#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# ///

from __future__ import annotations

import argparse
import hashlib
import json
import os
import re
import shutil
import tempfile
import urllib.request
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import urlparse


@dataclass(frozen=True)
class FormulaConfig:
    repo: str
    formula_path: Path
    class_name: str
    assets: dict[str, str]


FORMULAE = {
    "glue": FormulaConfig(
        repo="guywaldman/glue",
        formula_path=Path("Formula/glue.rb"),
        class_name="Glue",
        assets={
            "darwin_arm64": "glue_darwin_arm64.tar.gz",
            "darwin_amd64": "glue_darwin_amd64.tar.gz",
            "linux_arm64": "glue_linux_arm64.tar.gz",
            "linux_amd64": "glue_linux_amd64.tar.gz",
        },
    ),
    "wt": FormulaConfig(
        repo="guywaldman/wt",
        formula_path=Path("Formula/wt.rb"),
        class_name="Wt",
        assets={
            "darwin_arm64": "wt_darwin_arm64.tar.gz",
            "darwin_amd64": "wt_darwin_amd64.tar.gz",
            "linux_arm64": "wt_linux_arm64.tar.gz",
            "linux_amd64": "wt_linux_amd64.tar.gz",
        },
    ),
}


def github_token() -> str | None:
    return os.environ.get("GITHUB_TOKEN") or os.environ.get("GH_TOKEN") or os.environ.get("HOMEBREW_TAP_TOKEN")


def github_request(url: str, *, accept: str) -> urllib.request.Request:
    headers = {
        "Accept": accept,
        "User-Agent": "homebrew-tap-update-formula",
    }
    host = urlparse(url).hostname
    token = github_token()
    if token and host in {"api.github.com", "github.com"}:
        headers["Authorization"] = f"Bearer {token}"
    return urllib.request.Request(url, headers=headers)


def fetch_release(repo: str, tag: str | None) -> dict:
    if tag:
        url = f"https://api.github.com/repos/{repo}/releases/tags/{tag}"
    else:
        url = f"https://api.github.com/repos/{repo}/releases/latest"

    req = github_request(url, accept="application/vnd.github+json")
    with urllib.request.urlopen(req) as response:
        return json.loads(response.read().decode("utf-8"))


def download_file(url: str, destination: Path) -> None:
    req = github_request(url, accept="application/octet-stream")
    with urllib.request.urlopen(req) as response, destination.open("wb") as out:
        shutil.copyfileobj(response, out)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def replace_once(content: str, pattern: str, replacement: str) -> str:
    content, count = re.subn(pattern, replacement, content, count=1, flags=re.M)
    if count != 1:
        raise RuntimeError(f"Expected exactly one match for pattern: {pattern}")
    return content


def update_formula(config: FormulaConfig, tag: str, version: str, shas: dict[str, str]) -> None:
    content = config.formula_path.read_text()
    content = replace_once(content, r"^class\s+\w+\s+<\s+Formula", f"class {config.class_name} < Formula")
    content = replace_once(content, r'version "[^"]+"', f'version "{version}"')

    for platform, filename in config.assets.items():
        url = f"https://github.com/{config.repo}/releases/download/{tag}/{filename}"
        content = replace_once(
            content,
            rf'url "https://github\.com/{re.escape(config.repo)}/releases/download/[^\"]+/{re.escape(filename)}"\n\s+sha256 "[a-f0-9]+"',
            f'url "{url}"\n      sha256 "{shas[platform]}"',
        )

    config.formula_path.write_text(content)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("formula", choices=FORMULAE.keys())
    parser.add_argument("--tag", help="Git tag (for example: v0.1.2). Defaults to latest release.")
    args = parser.parse_args()

    config = FORMULAE[args.formula]
    release = fetch_release(config.repo, args.tag)
    tag = release["tag_name"]
    version = tag[1:] if tag.startswith("v") else tag
    assets = {asset["name"]: asset["url"] for asset in release.get("assets", [])}

    temp_dir = Path(tempfile.mkdtemp(prefix=f"{args.formula}-assets-"))
    shas: dict[str, str] = {}

    try:
        for platform, filename in config.assets.items():
            if filename not in assets:
                raise RuntimeError(f"Missing asset in release {tag}: {filename}")
            destination = temp_dir / filename
            download_file(assets[filename], destination)
            shas[platform] = sha256_file(destination)

        update_formula(config, tag, version, shas)
    finally:
        shutil.rmtree(temp_dir, ignore_errors=True)

    print(f"Updated {config.formula_path} to {version}")


if __name__ == "__main__":
    main()

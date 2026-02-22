#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# ///

import argparse
import hashlib
import json
import re
import shutil
import tempfile
import urllib.request
from pathlib import Path

REPO = "guywaldman/glue"
FORMULA_PATH = Path("Formula/glue.rb")
ASSETS = {
    "darwin_arm64": "glue_darwin_arm64.tar.gz",
    "darwin_amd64": "glue_darwin_amd64.tar.gz",
    "linux_arm64": "glue_linux_arm64.tar.gz",
    "linux_amd64": "glue_linux_amd64.tar.gz",
}


def fetch_release(tag: str | None) -> dict:
    if tag:
        url = f"https://api.github.com/repos/{REPO}/releases/tags/{tag}"
    else:
        url = f"https://api.github.com/repos/{REPO}/releases/latest"

    req = urllib.request.Request(url, headers={"Accept": "application/vnd.github+json"})
    with urllib.request.urlopen(req) as response:
        return json.loads(response.read().decode("utf-8"))


def download_file(url: str, destination: Path) -> None:
    req = urllib.request.Request(url)
    with urllib.request.urlopen(req) as response, destination.open("wb") as out:
        shutil.copyfileobj(response, out)


def sha256_file(path: Path) -> str:
    digest = hashlib.sha256()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(1024 * 1024), b""):
            digest.update(chunk)
    return digest.hexdigest()


def update_formula(version: str, shas: dict[str, str]) -> None:
    content = FORMULA_PATH.read_text()
    content = re.sub(r'version "[^"]+"', f'version "{version}"', content, count=1)

    for platform, filename in ASSETS.items():
        url = f"https://github.com/{REPO}/releases/download/v{version}/{filename}"
        sha = shas[platform]
        content = re.sub(
            rf'url "https://github\.com/{re.escape(REPO)}/releases/download/v[^\"]+/{re.escape(filename)}"\n\s+sha256 "[a-f0-9]+"',
            f'url "{url}"\n      sha256 "{sha}"',
            content,
            count=1,
        )

    FORMULA_PATH.write_text(content)


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--tag", help="Git tag (for example: v0.1.2). Defaults to latest release.")
    args = parser.parse_args()

    release = fetch_release(args.tag)
    tag = release["tag_name"]
    version = tag[1:] if tag.startswith("v") else tag

    assets = {asset["name"]: asset["browser_download_url"] for asset in release.get("assets", [])}

    temp_dir = Path(tempfile.mkdtemp(prefix="glue-assets-"))
    shas: dict[str, str] = {}

    try:
        for platform, filename in ASSETS.items():
            if filename not in assets:
                raise RuntimeError(f"Missing asset in release {tag}: {filename}")
            destination = temp_dir / filename
            download_file(assets[filename], destination)
            shas[platform] = sha256_file(destination)

        update_formula(version, shas)
    finally:
        shutil.rmtree(temp_dir, ignore_errors=True)

    print(f"Updated {FORMULA_PATH} to {version}")


if __name__ == "__main__":
    main()

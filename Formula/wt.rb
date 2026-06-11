class Wt < Formula
  desc "Ergonomic git worktree helper CLI"
  homepage "https://github.com/guywaldman/wt"
  version "0.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.3/wt_darwin_arm64.tar.gz"
      sha256 "500628b24645691ed5e90fc87d5f7bf843198311c65eae9adfb551eff00849b1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.3/wt_darwin_amd64.tar.gz"
      sha256 "fe655716039b3597200941f1fd7d4703336fcff189ff014f555a975e8b9ef15b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.3/wt_linux_arm64.tar.gz"
      sha256 "e9f3acccb52916a30215f82aba9e09d3015e0214ec8ebc6cb85491a1d6be78ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.3/wt_linux_amd64.tar.gz"
      sha256 "ae802684935bc4d1cc95ae47f86084a54f197f9d89e7b005c1b19f5e5f141668"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "wt"
  end

  test do
    assert_match "Lightweight git worktree helper CLI", shell_output("#{bin}/wt --help")
  end
end
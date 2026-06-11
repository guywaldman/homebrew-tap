class Wt < Formula
  desc "Ergonomic git worktree helper CLI"
  homepage "https://github.com/guywaldman/wt"
  version "0.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.4/wt_darwin_arm64.tar.gz"
      sha256 "2c50c0f5958bbb7f4656c9b6f239c74cd6d7759aa56c16cb12498155cc48aaaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.4/wt_darwin_amd64.tar.gz"
      sha256 "75e4ca21028a5277b885cdab8ad263b60a7ce26ecb72a1c18e53f8badffd1562"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.4/wt_linux_arm64.tar.gz"
      sha256 "2b58100b2b90c26f745f4e49f6e4d9e7cc0f46d5f5ee0110edb0b6f20695ff82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/wt/releases/download/v0.1.4/wt_linux_amd64.tar.gz"
      sha256 "0a5df1dafe72bc9c86d9234f53ec42229a0593589c25794a7829af408ff50db8"
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
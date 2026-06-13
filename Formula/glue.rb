class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.8.0/glue_darwin_arm64.tar.gz"
      sha256 "848236eab2768ceb205f53b4ffb790e57d415417262b034d4a9ab48ef0652854"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.8.0/glue_darwin_amd64.tar.gz"
      sha256 "5bd4464cdbd150020e8e5c4eb4679397dbe9fee6ee1d64880dba671a51e8d7b6"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.8.0/glue_linux_arm64.tar.gz"
      sha256 "682661a4fe32daa836cb8d275f04f6714033bc55d50d3ca21d678bd3c636697d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.8.0/glue_linux_amd64.tar.gz"
      sha256 "3a9cd41c6ba1638544c06056b7909207c7222cb00771146f9c63eba0b56dd3c4"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "glue"
  end

  test do
    assert_match "Glue CLI", shell_output("#{bin}/glue --help")
  end
end
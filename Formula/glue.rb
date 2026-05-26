class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.8"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.8/glue_darwin_arm64.tar.gz"
      sha256 "18751357c29dee45f7c19afbdfc60a0f88dcbbfaaa3b15c8b2d0495d8ea9b08a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.8/glue_darwin_amd64.tar.gz"
      sha256 "599da02fff542bc27c11759f8c4c25c0984dc3e6601e05cb6bfa734e6806fbcb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.8/glue_linux_arm64.tar.gz"
      sha256 "4e05ad650ecac7b08ad75336546eeacbdddb148967fe802c980ea7508f38a906"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.8/glue_linux_amd64.tar.gz"
      sha256 "b47f0521585973722f9de9785c4cfdd0d2b57dbe58059b5f029b7c8c87e9932b"
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
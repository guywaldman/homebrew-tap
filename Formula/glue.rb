class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.5.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.5.0/glue_darwin_arm64.tar.gz"
      sha256 "e3ef518cd28f674e74dd47a53be3fc4bd7fce14be39d164ad0cfe52ff39161e8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.5.0/glue_darwin_amd64.tar.gz"
      sha256 "727a011507eb0a81488be28bb53870825c0f9430fcdd27729dacb79b28ddb08e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.5.0/glue_linux_arm64.tar.gz"
      sha256 "231b663b2d0340cdb6a92d2d79ab493434c40c339a0292e98901572f1e6ade21"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.5.0/glue_linux_amd64.tar.gz"
      sha256 "60e680494f038e9d3abad0b103a8a59772d5d2d111aa4fea1241be724db01a25"
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
class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.7.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.7.0/glue_darwin_arm64.tar.gz"
      sha256 "786c7a6f72a5c0e2694e6f9d95526128714173c9eff62fae5aa38a955ade9ca3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.7.0/glue_darwin_amd64.tar.gz"
      sha256 "c01a5fea751a35a53e04f3bdc91b0bec2ee050bd28f661dec53aa5f72a8c2088"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.7.0/glue_linux_arm64.tar.gz"
      sha256 "9c0e874e88b58e050814675f652534a716f7138f7f86e632fb4d0f3a7b8b70b9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.7.0/glue_linux_amd64.tar.gz"
      sha256 "d21b89108bdf09214917a3d06d105c1f95ca3bf4eefd0f1fc781387ee450a2f4"
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
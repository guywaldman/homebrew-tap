class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.9.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.9.0/glue_darwin_arm64.tar.gz"
      sha256 "7279202ac5a47bb49d050481c0eb003169dc238e976b3fb822cc89e9e7e1bfd3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.9.0/glue_darwin_amd64.tar.gz"
      sha256 "0078fb98e9e15dc0b38a6cc96b625b4bf86c26465c7a9544b787f2c89d6f9b5b"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.9.0/glue_linux_arm64.tar.gz"
      sha256 "5016a7a7d49cf7ecac0e034335b260ea68d2096dd28411f58d0995ff7ced3a5c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.9.0/glue_linux_amd64.tar.gz"
      sha256 "cac8c075690d76994fdb74df6de616e9fa803de36f0fe753823ef850924c89df"
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
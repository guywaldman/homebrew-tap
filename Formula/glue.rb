class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "0.8.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.8.0/glue_darwin_arm64.tar.gz"
      sha256 "7b0753bb5ec0f8509102ca0a4b3c110e120760df7b0dcde2b95ac88313341eaa"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.8.0/glue_darwin_amd64.tar.gz"
      sha256 "1d67ba625f0e01e7983b6bf11008c63ca25cfdd4d066b14a99cebb6ea274ef3f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.8.0/glue_linux_arm64.tar.gz"
      sha256 "19b85cafe94f8637db516c0a0486389f568fc78626a3175a626c858b79935539"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.8.0/glue_linux_amd64.tar.gz"
      sha256 "759bdd9b2e8aee774cbc8b1abd0168ba01e396e88ed021b1d79665985429ddd3"
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
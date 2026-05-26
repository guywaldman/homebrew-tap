class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.4"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.4/glue_darwin_arm64.tar.gz"
      sha256 "08fd22747970fdaa5cb640eb1ba90e466cac6c985e228114faca758e9b2b29f1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.4/glue_darwin_amd64.tar.gz"
      sha256 "d159b2342b5bdd35b16061d0d761b1e6101763cac75406c05f829364eee54edc"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.4/glue_linux_arm64.tar.gz"
      sha256 "e9f61fcbdf35ab7ccd0c1d8a0312d3f0fd4e4decdfe3afda4786f3b0f9eff05e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.4/glue_linux_amd64.tar.gz"
      sha256 "31c61a95629766c49dd94814f61c26374c04ac5491d9f2a00aac678622a22d74"
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
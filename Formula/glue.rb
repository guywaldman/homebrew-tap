class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.2.0/glue_darwin_arm64.tar.gz"
      sha256 "0159c1b28b947d48816913c9192b6f1454e82d36ec58d2a91d26db1b712640ed"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.2.0/glue_darwin_amd64.tar.gz"
      sha256 "72ab40772b2b6a57bf9e276e66c09985e75e44a16a87fcbe53b0128f6c0079b3"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.2.0/glue_linux_arm64.tar.gz"
      sha256 "6c0d1d6bd73731b592108b4279b4e0e4ef226f14d561dcd2ec1e1e50a1b567a1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.2.0/glue_linux_amd64.tar.gz"
      sha256 "58728bd2cabef02587b33dcae3827d0526b7a427921150dd3eef2d5fffce11a3"
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
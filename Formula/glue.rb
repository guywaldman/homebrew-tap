class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "0.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.6.0/glue_darwin_arm64.tar.gz"
      sha256 "910622f6a0265690a78e44506e09a92ce362a4d4f2395fe7651e44df980fb175"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.6.0/glue_darwin_amd64.tar.gz"
      sha256 "de85054450f440113968aca04dbb03b9587b4ffbf0da1325bfdee39480afc7d5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.6.0/glue_linux_arm64.tar.gz"
      sha256 "084d3e03f659597327cf42cafee7e610652917df147d441437afc53971941bc2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.6.0/glue_linux_amd64.tar.gz"
      sha256 "78137d67f5111ae0ead958d754ef583f40ce93ccefb284d4e191227668639a10"
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
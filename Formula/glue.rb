class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "0.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.4.0/glue_darwin_arm64.tar.gz"
      sha256 "91b4e933f0a33728640ce802c27522dfdaec928527448129fbfcc9e67c030b8b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.4.0/glue_darwin_amd64.tar.gz"
      sha256 "d68dbb20f27287ccfa8eabf8e7e17a13f9c5a8f03c57973194b0f09b0ff2c80c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.4.0/glue_linux_arm64.tar.gz"
      sha256 "e96a4ef6c0678ab10aea88bfc62802420785b0c7d8967af11039a6434776ce93"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.4.0/glue_linux_amd64.tar.gz"
      sha256 "e6e7cb2b62c3502cee30fddcf11b3503b0a0454b06353f0d1e3263a11591b8f4"
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
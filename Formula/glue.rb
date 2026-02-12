class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "0.1.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.1.1/glue_darwin_arm64.tar.gz"
      sha256 "80c250e2dadbb0f6b29921c19fd1abb99b29044f56ffc335f1069c4a41da002b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.1.1/glue_darwin_amd64.tar.gz"
      sha256 "9ce685ac556c70c034de11cdb131863aec909b4b21091ee9f8623ca7c546a8b2"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v0.1.1/glue_linux_arm64.tar.gz"
      sha256 "e883faf39104e9e4f43e8cd07285636fa6a75076ba15a2aa0e9881f73204953e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v0.1.1/glue_linux_amd64.tar.gz"
      sha256 "573301e9ed4225d1d7e7678626c941e4451b30cfc50a46ffb67102587a0d457b"
    end
  end

  livecheck do
    url :stable
    strategy :github_latest
  end

  def install
    bin.install "glue"
    bin.install "lang" if File.exist?("lang")
    bin.install "lsp" if File.exist?("lsp")
  end

  test do
    assert_match "Glue Language CLI", shell_output("#{bin}/glue --help")
  end
end
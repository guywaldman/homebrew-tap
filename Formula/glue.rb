class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.6"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.6/glue_darwin_arm64.tar.gz"
      sha256 "b4112d3e9a5e0a5d73feed6fdd6a3f6ff03116bab6ed4b1f8bf5a8b944021256"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.6/glue_darwin_amd64.tar.gz"
      sha256 "b64ff1362bd37b3ced723abcd1c1e6511a9e8a8f840418600cf2f39f1bdbc9ea"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.6/glue_linux_arm64.tar.gz"
      sha256 "5480e2a0f50c53eb5ad0eb78cfe08ba9052e911530cf494b9189a68a1a6dd225"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.6/glue_linux_amd64.tar.gz"
      sha256 "17e8db3fc5b8e8597a2da3a82f1775232e4fd4daa7739f75c8a07a6c32867cda"
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
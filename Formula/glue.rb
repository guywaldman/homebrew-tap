class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.3.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.3.0/glue_darwin_arm64.tar.gz"
      sha256 "42acfd40573b14fe90da7ec348523d58e2c5dc4ef6b03da8a1b95dddc984b507"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.3.0/glue_darwin_amd64.tar.gz"
      sha256 "f94dd8c3f0fbb04ebfeee71741f48bfb6b46a0749bc95876fcf5a408be164047"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.3.0/glue_linux_arm64.tar.gz"
      sha256 "e004ec0509bcaa373625a9bc524f8422a8ad5e1364e611fbc58ece6a7210966d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.3.0/glue_linux_amd64.tar.gz"
      sha256 "abc64d5765d056d8c85ebf4dcdca4e8ab890bc975a8f92527362bd3ebed1e5b9"
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
class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.12.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.1/glue_darwin_arm64.tar.gz"
      sha256 "7f4c480c94fc8607798d1e32cb5542d37ccc772bd6c9bad15695efc9bb3a119a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.1/glue_darwin_amd64.tar.gz"
      sha256 "f0ef2ec7c700a70ada9139f907a3acd0944683f0516fa821b9c6e6360d9a0011"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.1/glue_linux_arm64.tar.gz"
      sha256 "ba8f2b9caeb21bf3c0227c94912608d8c2279d945fe93afe165f1a9a2a2bbc1b"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.1/glue_linux_amd64.tar.gz"
      sha256 "6e2181e71712cfb890ed6ea6b0b9dfc86adf778741d9a49e2f8e30bdc7110442"
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
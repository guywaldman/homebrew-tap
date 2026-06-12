class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.6.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.0/glue_darwin_arm64.tar.gz"
      sha256 "1a23b387a307b3c7c3598c9ce4b5562a09e129f321f0824f9ba43643a000a7f0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.0/glue_darwin_amd64.tar.gz"
      sha256 "393ce6e57c78b3922278727210624d6601acf267c5ad5585cc6860a25c78edfb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.0/glue_linux_arm64.tar.gz"
      sha256 "7545dcb45f1c0a269bf330f7c5ca8db66af19f85edd3d072f83a8b773065aa3c"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.0/glue_linux_amd64.tar.gz"
      sha256 "4fecbc4690d9bda6a7e0b6aefb051bb5d890b114249c676273342083bd2bb6b2"
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
class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.11.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.11.0/glue_darwin_arm64.tar.gz"
      sha256 "727d5cad895595e1572fd50f64ce0323cf752f5810139038c9f4e2884fdfeaba"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.11.0/glue_darwin_amd64.tar.gz"
      sha256 "e2a3fc6311cfeb68e6d446a62bfa3216ae984024f55e0941bb700f838ba52ade"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.11.0/glue_linux_arm64.tar.gz"
      sha256 "8b1efc47e63d8458fc90adb9e26cc7cf5db96b9d92ba973392c6c1d4ab6dedd2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.11.0/glue_linux_amd64.tar.gz"
      sha256 "e857c3de767fff3f1620a4250016fe677b35f7dde7011e27997dac8ad4e980c2"
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
class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.12.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.0/glue_darwin_arm64.tar.gz"
      sha256 "d67ef422360a6bccb1dc4d0865b62eba92d89adbebc876a2e38b851cfef35190"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.0/glue_darwin_amd64.tar.gz"
      sha256 "b9cd5bc5302d9774f1a4a28f865c68d2dbe3607e5d5a0288479150fb2f23a2a8"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.0/glue_linux_arm64.tar.gz"
      sha256 "d417495c54d85d6768092cba765f2ba9eba4661704e4984f9eb5213a6440b9ad"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.12.0/glue_linux_amd64.tar.gz"
      sha256 "e338bcd010f70303f7352d77e288f1011fe23b1cd61dc5273acaa07070c72553"
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
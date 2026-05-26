class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.7"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.7/glue_darwin_arm64.tar.gz"
      sha256 "a0fb060bc776b79a77e2a6de4c31762b8fc9000c793b3b69b6b09fef6ee4778f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.7/glue_darwin_amd64.tar.gz"
      sha256 "16bc9ff2027240cc7145996f9d7525710d27c9d1410d6d010728e92d4e9d0e34"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.7/glue_linux_arm64.tar.gz"
      sha256 "676f2a7091af0cb70c8c5f270e9b45be17046754c213c92a45bc3665cccbde34"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.7/glue_linux_amd64.tar.gz"
      sha256 "d5343e019c08a20934e254232ba2691f94df0198bda572ab9f9686810d1aa289"
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
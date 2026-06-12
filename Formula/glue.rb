class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.6.1"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.1/glue_darwin_arm64.tar.gz"
      sha256 "737df7ae1c150501a80b3b14c41ed86fed61d6c80d27fdb5847187634313904a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.1/glue_darwin_amd64.tar.gz"
      sha256 "49280936f2820d4d13d20222d668061d161a5de0a153a65fa5f7375344a2f1eb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.1/glue_linux_arm64.tar.gz"
      sha256 "7125d3bed089eb95f33dabccc9f5f4bed8ca5232abcbc93e9a883f0289da4ce0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.6.1/glue_linux_amd64.tar.gz"
      sha256 "7d10d8027f24945f94d4aefd82f5afd17a36ff82fe5c0e8470912066d69825bc"
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
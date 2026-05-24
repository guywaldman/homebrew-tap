class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.3"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.3/glue_darwin_arm64.tar.gz"
      sha256 "0a31fee41acbbc5c1d173ed1b2327dad0a4204a2d959c957580df668772b3feb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.3/glue_darwin_amd64.tar.gz"
      sha256 "8c5401223b5ef9a748385d741a70690327f4b68290fc3c3c97516d5ee6d8c07c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.3/glue_linux_arm64.tar.gz"
      sha256 "7f857c75b88a290f0afa2e7fae6553effa534fba0475a90da7a8b5ea7f345851"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.3/glue_linux_amd64.tar.gz"
      sha256 "1e02fce2c1ede3656e143ed194a45697a66f2dd8578b9f86ef7fb5a31cc9e772"
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
class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.5"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.5/glue_darwin_arm64.tar.gz"
      sha256 "f398c222e6df57f12eef39b5397832b0c245074789b78e47efacf6d2db18c9b6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.5/glue_darwin_amd64.tar.gz"
      sha256 "f129138ecb88992f61f699f971087115dc5ce93615d4735413a2a96004ac7361"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.5/glue_linux_arm64.tar.gz"
      sha256 "c8ac72534e83b87082826852d23d72650690d03c6c21562791f47fa1809bbbe0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.5/glue_linux_amd64.tar.gz"
      sha256 "b34a43973c3c63547cd82048c5ae8133fafc691f06a1c99dafeb781cde328fbd"
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
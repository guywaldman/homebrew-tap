class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.0/glue_darwin_arm64.tar.gz"
      sha256 "4c9c84260f103c0a603806a2ab2fe9181ab8efd18a7c285c9134bce132640ff5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.0/glue_darwin_amd64.tar.gz"
      sha256 "eef5e2a85d0951572f6fd28f5da347a2678d38bdd985f29f5126dc151f0322dd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.0/glue_linux_arm64.tar.gz"
      sha256 "4abbf553537550388cf4c227801c7a80077be972d271e3137dc8bbdd9bfe80e1"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.0/glue_linux_amd64.tar.gz"
      sha256 "770677a314215af209cca317e21728958db067d41b8e94206b417c4818b44e03"
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
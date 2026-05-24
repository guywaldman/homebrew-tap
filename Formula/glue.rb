class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.0.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.0.0/glue_darwin_arm64.tar.gz"
      sha256 "6ee4fdbcb755bcd5f588fb68680b8da0aa537f9235b6fe06465509e7c85cc947"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.0.0/glue_darwin_amd64.tar.gz"
      sha256 "2baa5fdd0b1951c4b386dc17f81bbe831b88101af68c5255080d5ee25f92ef45"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.0.0/glue_linux_arm64.tar.gz"
      sha256 "2ea784c639ed415bc1c996df3999362acb13b398801e428c6b049516e28709bc"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.0.0/glue_linux_amd64.tar.gz"
      sha256 "4ba47f2b64aafb58cba3ce94e2e696a51ad830e8abef312acffd7f38696d55e7"
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
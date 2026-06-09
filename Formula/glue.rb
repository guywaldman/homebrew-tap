class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.4.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.4.0/glue_darwin_arm64.tar.gz"
      sha256 "4cba97642c1ae73eaed502d3291d5983d38abd76e3948bddd8c02993ca11a1b4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.4.0/glue_darwin_amd64.tar.gz"
      sha256 "0adc0a85dc81e3fb141b6e4eae1c18ff1573ffedaece2eb46e1bc3bb6a7e35fd"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.4.0/glue_linux_arm64.tar.gz"
      sha256 "460b0ce53e2aa30b17d63f809c8897033119d60aeb79f3fd8a482a324a238395"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.4.0/glue_linux_amd64.tar.gz"
      sha256 "32fc41f19f6170119fb483348ef34f6f57e879b4b31f007ed86987cb6d26cfd4"
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
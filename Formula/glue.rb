class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.10.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.10.0/glue_darwin_arm64.tar.gz"
      sha256 "6efeca38ecbb74d2584ec5450e574da146a8a89b41cfda51c2b420b41e69dc3f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.10.0/glue_darwin_amd64.tar.gz"
      sha256 "4a13f385ca56aba4c59c728fd5c8dc5be216efc929dce68c3f0f3362cc9ca375"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.10.0/glue_linux_arm64.tar.gz"
      sha256 "da1234bb29cf37497cfbbc071584c62735675d9f11e03a1f5024e337d19e0325"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.10.0/glue_linux_amd64.tar.gz"
      sha256 "3df2df778b31cea9a9062e9681ae903fa3860f1e62961a9275901edd7888ba3b"
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
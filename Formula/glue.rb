class Glue < Formula
  desc "CLI for Glue (IDL and toolchain for modeling data and interfaces)"
  homepage "https://github.com/guywaldman/glue"
  version "1.1.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.2/glue_darwin_arm64.tar.gz"
      sha256 "6716aa2065c89d32a221efc1f006107c80865d0c6008fbfe484c27bb2f11789f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.2/glue_darwin_amd64.tar.gz"
      sha256 "bd5369f6035d9fd82426526f44b1c9b26b4a1ef8890da6396bc7aee3be07f51c"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.2/glue_linux_arm64.tar.gz"
      sha256 "0262e12949bd97e32199ada01679860909c6bfaae381ce0f4d676f5a2c36c660"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/glue/releases/download/v1.1.2/glue_linux_amd64.tar.gz"
      sha256 "a51d54ad54b199f37dad8bac0ad7c8fbd5f9a9a9886b9fb22c33686572d414b2"
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
class MagicCli < Formula
  desc "Command line utility to make you a magician in the terminal"
  homepage "https://github.com/guywaldman/magic-cli"
  version "0.0.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.6/magic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "8289addd743203448c0ee4fc987a22b69b14ca703077c51e63ad0f6c3e066556"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.6/magic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "f540594e01a79e82e6c9a74b4b2bdec865f1c5f9514122c2e9a95b7006c1c0cd"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.6/magic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b05ae77f2adc3d42722d61980584bd727175094725c25c86a31fec7dcd5856f0"
    end
  end

  BINARY_ALIASES = {"aarch64-apple-darwin": {}, "x86_64-apple-darwin": {}, "x86_64-pc-windows-gnu": {}, "x86_64-unknown-linux-gnu": {}}

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "magic-cli"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "magic-cli"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "magic-cli"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

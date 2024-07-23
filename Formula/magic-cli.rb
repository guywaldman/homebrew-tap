class MagicCli < Formula
  desc "Command line utility to make you a magician in the terminal"
  homepage "https://github.com/guywaldman/magic-cli"
  version "0.0.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.4/magic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "d77046356a79842fe61bde8de8086d5a73d0de74a9454e0ff0e121bfdadf3b33"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.4/magic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "34b1cacf3ab5c78f1efb5936756d5a62e730d10d8c30c17fb1cf4a604f49dd93"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.4/magic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "66af18af95238dbc0df205c5ac60176368c7f7cc386bc503917d3a6a4e0c0fef"
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

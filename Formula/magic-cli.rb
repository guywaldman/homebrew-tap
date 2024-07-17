class MagicCli < Formula
  desc "Command line utility to make you a magician in the terminal"
  homepage "https://github.com/guywaldman/magic-cli"
  version "0.0.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.2/magic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f4d264325cf3b6b2f791529c4056cc1e800b26cc2a4a55ed266e91d4d16cf67d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.2/magic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "fe5970ebb9804dec9bd6a0947824eb15f18b2ff3b8ce06745f3fd9e30cafc6ca"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.2/magic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "43407a71eced0ce6b602f753814acc3425187a7e3a14210516de3740ea1f22d0"
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

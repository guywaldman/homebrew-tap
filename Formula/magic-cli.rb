class MagicCli < Formula
  desc "Command line utility to make you a magician in the terminal"
  homepage "https://github.com/guywaldman/magic-cli"
  version "0.0.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.5/magic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "6416049dc8e7db4b83b221e8315e3db12d44e300f2d0cc2682bf150a8d6e6597"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.5/magic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "3cbd00768f8866e4e65719e735783e242d2091680e35d8e18cdda308584d5287"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.5/magic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b5b1c22ebb3968e31b81468883aa48233f5ecb01e4fbcbb3fccbc159726be91d"
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

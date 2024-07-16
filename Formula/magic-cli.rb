class MagicCli < Formula
  desc "Command line utility to make you a magician in the terminal"
  homepage "https://github.com/guywaldman/magic-cli"
  version "0.0.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.1/magic-cli-aarch64-apple-darwin.tar.xz"
      sha256 "357a1325a4d8ac35cbf2eea75e2cf6c782c37d83ce63d258855d97ae8cd7f704"
    end
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.1/magic-cli-x86_64-apple-darwin.tar.xz"
      sha256 "135b45d84ecac84354606ee8de2eedbd062498bc490144989346174f495772e6"
    end
  end
  if OS.linux?
    if Hardware::CPU.intel?
      url "https://github.com/guywaldman/magic-cli/releases/download/0.0.1/magic-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "cfbdb74c71ee0dbdf3e9a2ff4b456d06e729155ed459a8440e3b0fe6c9b1fe31"
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

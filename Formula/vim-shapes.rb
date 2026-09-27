class VimShapes < Formula
  desc "architecture diagrams, driven like vim — a terminal diagramming tool with an ontology under it"
  homepage "https://github.com/currently-unnamed/vim-shapes"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.5/vim-shapes-aarch64-apple-darwin.tar.xz"
      sha256 "72ec4293ceca911e65121b88fbb49e507b2f7cce5e80404e8f48ec4826e9ec15"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.5/vim-shapes-x86_64-apple-darwin.tar.xz"
      sha256 "31ff504a7c47f3c91119e165f8d57f53cc34e89cb9e7ed32c27b6b3719f19dc2"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.5/vim-shapes-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "d2c4a5810dc6ac0e78fd38b9aee47da813e6df39a1ea5c26072f688d25384147"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.5/vim-shapes-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "40cb6a31d2db3c9c02a216ad04cc8999c546ef0d28059854db3228ee851c51d6"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
  }.freeze

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
      bin.install "vim-shapes"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "vim-shapes"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "vim-shapes"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "vim-shapes"
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

class VimShapes < Formula
  desc "architecture diagrams, driven like vim — a terminal diagramming tool with an ontology under it"
  homepage "https://github.com/currently-unnamed/vim-shapes"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.6/vim-shapes-aarch64-apple-darwin.tar.xz"
      sha256 "b152dcaee7547b7cf0da855af14cb1de23985f89e98492d6447615e5390053a7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.6/vim-shapes-x86_64-apple-darwin.tar.xz"
      sha256 "6225b9f787aba4140dbe98e8e0c2cddec6f870d5f125a9b101cbcb27ae6925ac"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.6/vim-shapes-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "c2cf055ab875560685914c5acfc6244a23baa2f478d11f458c647990e2307343"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.6/vim-shapes-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "37a267dff2443cad8c99810feecc3a83e0baa0b48eac64f4f5e85202becb7314"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-pc-windows-gnu":     {},
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

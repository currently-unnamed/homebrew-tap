class VimShapes < Formula
  desc "architecture diagrams, driven like vim — a terminal diagramming tool with an ontology under it"
  homepage "https://github.com/currently-unnamed/vim-shapes"
  version "0.1.7"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.7/vim-shapes-aarch64-apple-darwin.tar.xz"
      sha256 "4471ed9c77becbef5cba5437f37e3b776d3c4baa619e5f6ace63ecee1d07b320"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.7/vim-shapes-x86_64-apple-darwin.tar.xz"
      sha256 "6ca16cf304ef11e8a2a9169d5a4193c7451a691d0a4fd87991ec6067a7e86f2e"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.7/vim-shapes-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b61c1a96e1471a62c853631ac8e08e636c3d4f471891fc7256bfb600563cdefd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.7/vim-shapes-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b2ab69090689158d515faa9d064fd4561ba15b1aa9262af9ab6b19c1b6190f25"
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

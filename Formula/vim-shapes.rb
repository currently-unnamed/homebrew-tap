class VimShapes < Formula
  desc "architecture diagrams, driven like vim — a terminal diagramming tool with an ontology under it"
  homepage "https://github.com/currently-unnamed/vim-shapes"
  version "0.1.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.4/vim-shapes-aarch64-apple-darwin.tar.xz"
      sha256 "0c3b7200b9eb321a077a84a1867c0e14d42e19222429dd90b27a7f23e4c68fd5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.4/vim-shapes-x86_64-apple-darwin.tar.xz"
      sha256 "48ec684e1ff200d3f5519197a1e181a0f82cec69742b8999c718d87e03139fed"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.4/vim-shapes-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "236487111003e85f57cec2567c069f9a46b650fa087d077b6b816337dc2bb37a"
    end
    if Hardware::CPU.intel?
      url "https://github.com/currently-unnamed/vim-shapes/releases/download/v0.1.4/vim-shapes-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "2661027f170f17d57addc45a489505cb8de8b00c65401f1698df54860873d981"
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

class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  version "0.2.4"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.4/yaait-aarch64-apple-darwin.tar.xz"
      sha256 "81f5c16c6077297cf73f4abf3ce7f6b36c3a4512955b44ca1f0fc3623b610a2f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.4/yaait-x86_64-apple-darwin.tar.xz"
      sha256 "46cf1c421fc2ca25e6928c1cc808b580030ec7d5f7da3bf28ef2a5a4e31b1aad"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.4/yaait-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "b2df7c3f5f7d70dc2e3afdc96c43d0284598301d28a2136b884563e1c16389de"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.4/yaait-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "0153a9064ce0e98fbdd7d9dfa811fb842dda924b4e64b0c72b2960d6e8a1594f"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-pc-windows-gnu":    {},
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
      bin.install "yaait"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "yaait"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "yaait"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "yaait"
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

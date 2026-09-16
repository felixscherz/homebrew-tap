class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  version "0.2.2"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.2/yaait-aarch64-apple-darwin.tar.xz"
      sha256 "9f8d41a0de9d8ef290d4c249165e1c1d9b68443ca326a6d04ea7c93bfd272046"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.2/yaait-x86_64-apple-darwin.tar.xz"
      sha256 "7a30ac9afb33ee73e9b3d730b476e5fb235706b2aac2a5693323b430690f5f37"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.2/yaait-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "35da35041483e7a0cdf59519077d85033bbee7e8c6d5381b321e6d09f70d7664"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.2/yaait-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d8c4c44a38277d1c6357f6c89c209d7d4f7fb19a7011be81472cea85b51d73d9"
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

class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  version "0.2.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.1/yaait-aarch64-apple-darwin.tar.xz"
      sha256 "397f99c64311cb850336d7625a072d029640ea1efea21338cf4365c697885bc6"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.1/yaait-x86_64-apple-darwin.tar.xz"
      sha256 "3f7de6cfea8b30d4fb63ee4d39de89ca2374518605ef3347cbe9971206678f8f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.1/yaait-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "710b0fe194ed6ebc8a0e4b497f852ff907482906babfff3ddb6d85c26d7189b3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.1/yaait-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "b9ed2ec05afd4ed9912e85022f8325a5356be6ce6b3fe9a650cd2d92156c549e"
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

class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  version "0.2.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.5/yaait-aarch64-apple-darwin.tar.xz"
      sha256 "f73d85236fba19d7e573b6b8b3e8f81fd11f4b4dc280e7955c8d64c5ed2cf13f"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.5/yaait-x86_64-apple-darwin.tar.xz"
      sha256 "d6cfdde15ef1f4860099fd6900d3ec4a6f6402997a1a1f90bda6d71a46bc0079"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.5/yaait-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "934edc994aa0d33fc7d4207dd8256c4e741d86deeb3c6408c03704af6012bb08"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.5/yaait-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "423152c0a1d8a164b602f6cd92a324dce31aaf5dc6354696302c68e9979a0de4"
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

class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.0/yaait-aarch64-apple-darwin.tar.xz"
      sha256 "ba4ea66b4061f4364f0ca6e5da77165f8a49026fee4cf8a0498834dc2dfdceeb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.0/yaait-x86_64-apple-darwin.tar.xz"
      sha256 "6465e1e2c54d7e4a4a944f97f0f8309419fdf94be088b9aedac7b4c85c71e6ee"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.0/yaait-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ea1b2f22af164d7babce035d32fc8036e6270da57686f0481a367c035d3edc02"
    end
    if Hardware::CPU.intel?
      url "https://github.com/felixscherz/yaait/releases/download/v0.2.0/yaait-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "8e65f9330b6e72253ad130982d640456e0ed398c762ed22c28d2464f994f5fa2"
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

class Yaait < Formula
  desc "Multi-instance AI usage tracker"
  homepage "https://github.com/felixscherz/yaait"
  url "https://github.com/felixscherz/yaait/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "eb21b6e0f0405b4b27a0d735c47f078b533366aa80dc3dcc286a47365b0d6900"
  license "MIT"

  depends_on "rust" => :build

  def install
    system "cargo", "install", *std_cargo_args
  end

  test do
    assert_match "github-copilot", shell_output("#{bin}/yaait providers list")
  end
end

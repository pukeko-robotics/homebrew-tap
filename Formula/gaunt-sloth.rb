class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.2.0.tgz"
  sha256 "45f97d58a912d2481cbf56b339dbe982d7bbec54c35c82c0fdc0323bd4646c5f"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.2.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "31f5e3c8bf5fd30bc29ad47ed1b0d4362034fc96fb4f20236c6f2fca1c3d049e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "b910dfe9de1ba09c44a5f418bd50524b9fc45731951f25fc7d53c49056fe5a01"
  end

  depends_on "node"

  def install
    system "npm", "install", *std_npm_args
    bin.install_symlink libexec.glob("bin/*")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/gth --version")
    assert_match version.to_s, shell_output("#{bin}/gsloth --version")
    assert_match version.to_s, shell_output("#{bin}/gaunt-sloth --version")
  end
end

class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.2.0.tgz"
  sha256 "45f97d58a912d2481cbf56b339dbe982d7bbec54c35c82c0fdc0323bd4646c5f"
  license "MIT"

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

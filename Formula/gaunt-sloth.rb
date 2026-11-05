class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.4.0.tgz"
  sha256 "ddb5dfd2933779e80a87ed80826724ea83721f66bcaaed7714313f53930ee7c7"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.4.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "403186a722838b39b2b19dae9abb9fef207c76712019b860b38452b365e03420"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ffb127de4b8cf834ebcf9efbe93560468ba6e3d60c3fac0395df8fd028a1b3e9"
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

class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.2.4.tgz"
  sha256 "428fe090a08909489c379af57346ee84dfa19578a6d2a9fb854a6fe46442c6dc"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.2.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "e94e1ba02011494dae57071af2a6381e7178c24ffe958e377afd7a0cced3c7ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "ec4f0cb8a60daa2e3790cf8a97c6cf47c312bd5ce2a38c458de1e9928a2c8647"
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

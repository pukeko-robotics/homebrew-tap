class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.0.1.tgz"
  sha256 "7b0e64817bdc3321f63707b2e752d39627cf7f3e30244d7dfcb38ecfc20fbf19"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.0.1"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "237afae75d21a5c4bdace308e692f1ea8e46a9782e2d4a74e84fbab06c463e8e"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d6d7265b28bcdb64bf385379c3a63ecc21e068c6e26ccbc13377a2c28f149aa6"
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

class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.2.2.tgz"
  sha256 "6f45e015a37d931f92be1dbba382234a16606a09b5f66d06c7a35e1242afd8a8"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.2.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "479214bcde8e30312912c8aec0baa9ee514147719f9dbe41ede7ba32291f6958"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a4fb846dff6c8563f2a855ac9c6c24fee82a45b0a20517a0e24a10a957985266"
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

class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.1.2.tgz"
  sha256 "4b76b6c33ad5fc0c277839673de79b66aaf0520a44ed60e939e3591467b16f98"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.1.2"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "c428768fd33cf9a460d9c83939883c9103d32967829047be31d5348432aea0c2"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "5ba660b5c4871816de018f96d0458284083792124faa2c63cb08441b7045bbfd"
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

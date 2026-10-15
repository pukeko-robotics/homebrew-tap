class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.2.3.tgz"
  sha256 "44007195ee9c72538f289ac1fd9b99ec71576c7a3cfbf776d1617a0ba9b8008f"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.2.3"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "986b53fb94d7b90c4cc8b363ad9b081273eacf01b6b87991f2b3668dcb31afc0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "bd6f9f4abed6b5dfd6a36f6c01f529329969133e74536e44296adbf8f88e38d0"
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

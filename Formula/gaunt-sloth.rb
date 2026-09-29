class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.1.0.tgz"
  sha256 "5ed43422ab0462287aeab3773f1262b2808af6747bd39eb3b80ae5d5f2993abe"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "454ee4ef0a934642c066f4a2d9800e9930b221ec82a8543c3b4bd381e9bc79ee"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e2cc641c7c06db86ffa09f3bf09210521b458d0ac5eac09ab1a6477bb47d2b29"
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

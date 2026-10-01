class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.1.3.tgz"
  sha256 "b3a7b612b08a56658bb33b4d279999c8058ba0bc3d610cd48e808d9ffc9121a8"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.1.3"
    rebuild 2
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "4ec9f7e1ae50cc030cc05270cbd6cf16fcb65b57606e9a6695cc5aba8f1810c0"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "6e2c64a0c2f61338ffd171a8a701adb51d40cbfaf5113b7103f79305e3e6d7ad"
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

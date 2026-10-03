class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.1.4.tgz"
  sha256 "10897d00d415b2914f69e02733c5b5e3a37929b6a4b9fa57b10f9faf340349e1"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.1.4"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0d0eb2d0dd27a2715e032a60be5868fce394446328c779488ddded5c95ca8f02"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d892da4d1401ad64f3110e3ada71e3b2a49b5b505ce420ce3f096090948f5d17"
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

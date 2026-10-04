class GauntSloth < Formula
  desc "Command-line AI assistant for code review, PR analysis and coding sessions"
  homepage "https://gauntsloth.app"
  url "https://registry.npmjs.org/gaunt-sloth/-/gaunt-sloth-2.1.5.tgz"
  sha256 "a0d75ce3f77c6b4c1d2eae49f34260f4fe84eefa9f076f08c9c3c0a579d30b1b"
  license "MIT"

  bottle do
    root_url "https://github.com/pukeko-robotics/homebrew-tap/releases/download/gaunt-sloth-2.1.5"
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_tahoe:  "0e3cf462120f60cc7e6182179aa58a1c52a04ca1523520fa9e562ea1a6dca3ad"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9fab38749727af602e0ad1eae40a74ff85032609e7dd5ad474ad6e97e72f30d6"
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

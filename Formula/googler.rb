class Googler < Formula
  include Language::Python::Shebang

  desc "Google Search and News from the command-line"
  homepage "https://github.com/oksiquatzel/googler"
  url "https://github.com/oksiquatzel/googler/archive/refs/tags/v4.3.13.tar.gz"
  sha256 "5d887f49ca2a83f8ecb87e505dfdb32d228a5b2e0d3bdd77b4722fc864085e57"
  license "GPL-3.0-or-later"
  head "https://github.com/oksiquatzel/googler.git", branch: "main"

  bottle do
    root_url "https://ghcr.io/v2/tuzi3040/bottles"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "d105b8a2c2d540d52ad2253bf02ab51c88e5a4cf56455d586fbf92765129dc68"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "9b8d1cb5770dab9b25bf938289fbfb85e900448455e23fb9eff64af87fd1e089"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "097790b17dc72bdd7444b8ee3db0bc417581e3f430de02f2b938d70368d263a4"
  end

  depends_on "python@3.12"

  def install
    rewrite_shebang detected_python_shebang, "googler"
    system "make", "disable-self-upgrade"
    system "make", "install", "PREFIX=#{prefix}"
    bash_completion.install "auto-completion/bash/googler-completion.bash"
    fish_completion.install "auto-completion/fish/googler.fish"
    zsh_completion.install "auto-completion/zsh/_googler"
  end

  test do
    ENV["PYTHONIOENCODING"] = "utf-8"
    assert_match "Homebrew", shell_output("#{bin}/googler --noprompt Homebrew")
  end
end

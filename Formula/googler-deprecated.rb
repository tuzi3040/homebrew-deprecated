class GooglerDeprecated < Formula
  include Language::Python::Shebang

  desc "Google Search and News from the command-line"
  homepage "https://github.com/jarun/googler"
  url "https://github.com/jarun/googler/archive/refs/tags/v4.3.2.tar.gz"
  sha256 "bd59af407e9a45c8a6fcbeb720790cb9eccff21dc7e184716a60e29f14c68d54"
  license "GPL-3.0-or-later"
  revision 3
  head "https://github.com/jarun/googler.git", branch: "main"

  depends_on "python@3.11"

  # Upstream PROTOCOL_TLS patch, review for removal on next release (if any)
  # https://github.com/jarun/googler/pull/426
  patch do
    url "https://github.com/jarun/googler/commit/52e2da672911cd9186bd3497fcdf81149071e72b.patch?full_index=1"
    sha256 "d8d8a813b6c0645990b8b1849718b0fc406f4201068ca483f27498599fd86cbf"
  end

  # Fix "No Result" at 20241001
  patch :DATA

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

__END__
diff --git a/googler b/googler
index 23b5abe..57ad401 100755
--- a/googler
+++ b/googler
@@ -2378,7 +2378,7 @@ class GoogleParser(object):
                     # As of January 15th 2021, the html class is not rc anymore, it's tF2Cxc.
                     # This approach is not very resilient to changes by Google, but it works for now.
                     # title_node, details_node, *_ = div_g.select_all('div.rc > div')
-                    title_node, details_node, *_ = div_g.select_all('div.tF2Cxc > div')
+                    title_node, details_node, *_ = div_g.select_all('div.tF2Cxc > div > div')
                     if 'yuRUbf' not in title_node.classes:
                         logger.debug('unexpected title node class(es): expected %r, got %r',
                                      'yuRUbf', ' '.join(title_node.classes))


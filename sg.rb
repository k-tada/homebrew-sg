require 'formula'

class Sg < Formula
  homepage ''
  url 'https://github.com/monochromegane/the_silver_searcher/archive/sg-0.18.1.1.tar.gz'
  sha256 '9f0b27997b86197fece89062ba84ddf206ae225b88482b5b3db4a75f7ed99bae'

  depends_on :automake
  depends_on :autoconf

  depends_on 'pkg-config' => :build
  depends_on 'pcre'
  depends_on 'xz'

  def install
    # Stable tarball does not include pre-generated configure script
    system "aclocal -I #{HOMEBREW_PREFIX}/share/aclocal"
    system "autoconf"
    system "autoheader"
    system "automake --add-missing"

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make"
    system "make install"

    bash_completion.install 'sg.bashcomp.sh'
  end

  def test
    system "#{bin}/sg", "--version"
  end
end

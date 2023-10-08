class Pan < Formula
  desc "Usenet newsreader that's good at both text and binaries"
  homepage "https://pan.rebelbase.com"
  url "https://gitlab.gnome.org/GNOME/pan/-/archive/v0.154/pan-v0.154.tar.bz2"
  sha256 "440317954df7217689100df3dfb68865770f5aed1b8ed2b45432d771bb80a8c9"
  license "GPL-2.0-only"

  depends_on "automake" => :build
  depends_on "autoconf" => :build
  depends_on "itstool" => :build
  depends_on "pkg-config" => :build
  depends_on "adwaita-icon-theme"
  depends_on "cairo"
  depends_on "enchant"
  depends_on "gdk-pixbuf"
  depends_on "gettext"
  depends_on "glib"
  depends_on "gmime"
  depends_on "gnutls"
  depends_on "gtk+3"
  depends_on "gtkspell3"
  depends_on "harfbuzz"
  depends_on "pango"

  def install

    # use brew name for gtk3 version of tool update-icon-cache
    inreplace  "pan/icons/Makefile.am", "gtk-update-icon-cache", "gtk3-update-icon-cache"

    ENV.append "LDFLAGS", "-liconv"
    ENV.append "CXXFLAGS", "-std=c++11"

    # there is a better way to do this rather than hardcode it, I'm certain
    ENV.append "CPPFLAGS", "-I/opt/homebrew/Cellar/gnutls/3.8.1/include -I/opt/homebrew/Cellar/enchant/2.6.1/include"

    system "./autogen.sh"
    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--with-gnutls"
    system "make"
    system "make", "install"
  end

  test do
    # this application does not appear to have a straightforward test that is more complex
    system "#{bin}/pan", "-v"
  end
end

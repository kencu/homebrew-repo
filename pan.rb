class Pan < Formula
  desc "Usenet newsreader that's good at both text and binaries"
  homepage "https://pan.rebelbase.com"
  url "https://pan.rebelbase.com/download/releases/0.149/source/pan-0.149.tar.bz2"
  sha256 "5d34d0d7dbb73ee53484ffe173f01d8b2c0732126ec21d8cf29d6baa5ecb85ea"
  license "GPL-2.0-only"

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
    # brew provides enchant-2, which is accepted for the pan build but needs include dir changed in source
    inreplace  "pan/gui/group-prefs-dialog.cc", "<enchant/enchant.h>", "<enchant-2/enchant.h>"

    # use brew name for gtk3 version of tool update-icon-cache
    inreplace  "pan/icons/Makefile.in", "gtk-update-icon-cache", "gtk3-update-icon-cache"

    ENV.append "LDFLAGS", "-liconv"

    system "./configure", *std_configure_args,
                          "--disable-silent-rules",
                          "--with-gmime30",
                          "--with-gtk3",
                          "--with-gnutls"
    system "make"
    system "make", "install"
  end

  test do
    # this application does not appear to have a straightforward test that is more complex
    system "#{bin}/pan", "-v"
  end
end

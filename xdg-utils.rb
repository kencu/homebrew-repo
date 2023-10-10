class XdgUtils < Formula
  desc "Scripts that provide basic desktop integration functions"
  homepage "https://gitlab.freedesktop.org/xdg/xdg-utils"
  url "https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v1.1.3/xdg-utils-v1.1.3.tar.gz"
  sha256 "7dfc542f9bff8ccd673a4f45c671f8f6bf4d1f191cff017f68e94a27182af01f"
  license :public_domain

  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "lynx" => :build
  depends_on "xmlto" => :build

  def install
    ENV.append "XML_CATALOG_FILES", "/opt/homebrew/etc/xml/catalog"

    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    assert_match "xdg-open" + " " + version.to_s, shell_output("#{bin}/xdg-open --version")
  end
end

class XdgUtils < Formula
  desc "A set of simple scripts that provide basic desktop integration functions for any Free Desktop, such as Linux."
  homepage "https://gitlab.freedesktop.org/xdg/xdg-utils"
  url "https://gitlab.freedesktop.org/xdg/xdg-utils/-/archive/v1.1.3/xdg-utils-v1.1.3.tar.gz"
  sha256 "7dfc542f9bff8ccd673a4f45c671f8f6bf4d1f191cff017f68e94a27182af01f"
  license :public_domain

  depends_on "xmlto" => :build
  depends_on "docbook" => :build
  depends_on "docbook-xsl" => :build
  depends_on "lynx" => :build

  def install

    ENV.append "XML_CATALOG_FILES", "/opt/homebrew/etc/xml/catalog"

    system "./configure", *std_configure_args
    system "make"
    system "make", "install"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test xdg-utils`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

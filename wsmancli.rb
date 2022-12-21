class Wsmancli < Formula
  homepage 'https://github.com/Openwsman/wsmancli'
  url 'https://github.com/Openwsman/wsmancli/archive/refs/tags/v2.6.0.tar.gz'
  sha256 '766fef60d4c627d8b6129b3c9ae97d8676442bc6110b3a723610c54894365e0d'

  depends_on "openwsman"
  depends_on "autoconf"   => :build
  depends_on "automake"   => :build
  depends_on "libtool"    => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "wsman --help"
  end
end

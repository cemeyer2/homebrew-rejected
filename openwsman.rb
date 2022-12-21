class Openwsman < Formula
  homepage 'http://openwsman.github.io'
  url "https://github.com/Openwsman/openwsman/archive/refs/tags/v2.7.1.tar.gz"
  sha256 'd260464c8af4c009c743778c667df02a2f558a216a5dfb79ebbef75fc947ba6f'

  depends_on "libxml2"
  depends_on "sblim-sfcc"
  depends_on "automake"   => :build
  depends_on "autoconf"   => :build
  depends_on "libtool"    => :build
  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    system "./autoconfiscate.sh --ignore-deprecation-warning"
    system "./configure", "--disable-more-warnings",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end



  test do
    (testpath/"openwsman.conf").write <<-EOS.undent
      # conf file based on https://raw.githubusercontent.com/Openwsman/openwsman/master/etc/openwsman.conf

      port = 5985

      ipv4 = yes
      ipv6 = yes
      ssl_disabled_protocols = SSLv2 SSLv3

      min_threads = 4
      max_threads = 0

      basic_authenticator = libwsman_pam_auth.so
      basic_authenticator_arg = openwsman


      [cim]
      default_cim_namespace = root/cimv2
      cim_client_frontend = XML
      vendor_namespaces = OpenWBEM=http://schema.openwbem.org/wbem/wscim/1/cim-schema/2,Linux=http://sblim.sf.net/wbem/wscim/1/cim-schema/2,OMC=http://schema.omc-project.org/wbem/wscim/1/cim-schema/2,PG=http://schema.openpegasus.org/wbem/wscim/1/cim-schema/2,RCP=http://schema.suse.com/wbem/wscim/1/cim-schema/2,DCIM=http://schemas.dell.com/wbem/wscim/1/cim-schema/2,SPAR=http://schema.unisys.com/wbem/wscim/1/cim-schema/2,SVS=http://schemas.ts.fujitsu.com/wbem/wscim/1/cim-schema/2
      port = 5989
      ssl = yes
      verify_cert = no
    EOS

    # should be able to open and parse the a config file
    system "openwsmand", "--config-file=openwsman.conf"
  end


end

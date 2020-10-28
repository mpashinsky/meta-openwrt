FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI += "file://lighttpd.init \
		file://etc \
		file://etc/certs \
	"
	
PARALLEL_MAKE = ""

EXTRA_OECONF += "--libdir=/usr/lib/lighttpd \
	--sysconfdir=/etc/lighttpd \
	--enable-shared \
	--enable-static \
	--without-attr \
	--without-bzip2 \
	--without-fam \
	--without-gdbm \
	--without-ldap \
	--without-lua \
	--without-mysql \
	--with-pcre \
	--without-valgrind \
	"

LDFLAGS_append = " -lpcre "
RDEPENDS_${PN} = ""

do_install () {
	oe_runmake install DESTDIR=${D}
	install -d ${D}/etc
	cp -r ${WORKDIR}/etc/* ${D}/etc/
	install -d ${D}/etc/init.d
	install -m 750 ${WORKDIR}/lighttpd.init ${D}/etc/init.d/lighttpd
	return 0;
}

FILES_${PN} += "/usr/lib/lighttpd/*"

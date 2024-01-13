PORTNAME=	seamonkey
DISTVERSION=    2.53.18
PORTREVISION=	1
CATEGORIES?=	www mail news editors irc
MASTER_SITES=	MOZILLA/${PORTNAME}/releases/${DISTVERSION}/source
DISTFILES=	${DISTNAME}.source${EXTRACT_SUFX}

MAINTAINER=	kostirya@gmail.com
COMMENT=	Web-browser, advanced e-mail, newsgroup and feed client, IRC chat, and HTML editing

USES=		tar:xz

USE_GL=		glu
USE_GNOME=	cairo gdkpixbuf2 gtk20 gtk30
USE_PERL5=	build
USE_XORG=	x11 xcb xcomposite xdamage xext xfixes xrender xt

USES+=		compiler:c++17-lang cpe gl gmake iconv localbase perl5 pkgconfig \
		python:2.7+,build desktop-file-utils gnome

BUILD_DEPENDS+=	nspr>=4.26:devel/nspr \
		nss>=3.58:security/nss \
		icu>=67.1,1:devel/icu \
		libevent>=2.1.8:devel/libevent \
		harfbuzz>=2.6.8:print/harfbuzz \
		graphite2>=1.3.14:graphics/graphite2 \
		png>=1.6.35:graphics/png \
		libvpx>=1.8.2:multimedia/libvpx \
		${PYTHON_PKGNAMEPREFIX}sqlite3>0:databases/py-sqlite3@${PY_FLAVOR} \
		v4l_compat>0:multimedia/v4l_compat \
		autoconf2.13:devel/autoconf2.13 \
		nasm:devel/nasm \
		yasm:devel/yasm \
		zip:archivers/zip \
		${RUST_DEFAULT}>=1.47:lang/${RUST_DEFAULT}


#MAKE_CMD=gmake
#MAKEFILE=client.mk
#ALL_TARGET=build
DO_MAKE_BUILD=./mach
ALL_TARGET=build

.if ${CC} == cc && ${CXX} == c++ && exists(/usr/lib/libc++.so)
LLVM=           13
BUILD_DEPENDS+= ${LOCALBASE}/bin/clang${LLVM}:devel/llvm${LLVM}
CPP=            ${LOCALBASE}/bin/clang-cpp${LLVM}
CC=             ${LOCALBASE}/bin/clang${LLVM}
CXX=            ${LOCALBASE}/bin/clang++${LLVM}
USES:=          ${USES:Ncompiler\:*} # XXX avoid warnings
.endif


BUILD_DEPENDS+= ${LOCALBASE}/include/alsa/asoundlib.h:audio/alsa-lib
LIB_DEPENDS+=	libasound.so:audio/alsa-lib
RUN_DEPENDS+=	alsa-plugins>=0:audio/alsa-plugins


MOZCONFIG?=             ${WRKSRC}/.mozconfig
MOZILLA_PLIST_DIRS?=    bin lib

PLISTF?= ${WRKDIR}/plist_files


MOZ_OPTIONS+= --enable-application=comm/suite
MOZ_OPTIONS+= --enable-official-branding
MOZ_OPTIONS+= --enable-release
MOZ_OPTIONS+= --enable-strip
MOZ_OPTIONS+= --enable-install-strip
MOZ_OPTIONS+= --enable-optimize
MOZ_OPTIONS+= --enable-alsa
MOZ_OPTIONS+= --disable-jack

# MOZ_OPTIONS+= --disable-pulseaudio
MOZ_OPTIONS+= --enable-pulseaudio
LIB_DEPENDS+= libpulse.so:audio/pulseaudio
RUN_DEPENDS+= pulseaudio:audio/pulseaudio

MOZ_OPTIONS+= --disable-gconf
MOZ_OPTIONS+= --disable-webrtc
MOZ_OPTIONS+= --disable-rust-simd 
MOZ_OPTIONS+= --disable-debug 
MOZ_OPTIONS+= --disable-debug-symbols 
MOZ_OPTIONS+= --disable-rust-debug 
MOZ_OPTIONS+= --disable-tests 
MOZ_OPTIONS+= --disable-updater
MOZ_OPTIONS+= --prefix=${PREFIX}

MOZ_OBJDIR=obj-freebsd
MOZ_MK_OPTIONS+=MOZ_OBJDIR=./${MOZ_OBJDIR}

CFLAGS+=	-O3
MOZ_EXPORT+=	MOZ_OPTIMIZE_FLAGS="${CFLAGS:M-O*}"


post-install-script: gecko-create-plist

gecko-create-plist:
# Create the plist
	${RM} ${PLISTF}
.for dir in ${MOZILLA_PLIST_DIRS}
	@cd ${STAGEDIR}${PREFIX}/${dir} && ${FIND} -H -s * ! -type d | \
		${SED} -e 's|^|${dir}/|' >> ${PLISTF}
.endfor
	${CAT} ${PLISTF} | ${SORT} >> ${TMPPLIST}


post-patch: gecko-post-patch
	@${REINPLACE_CMD} -e '/accessibility.typeaheadfind.enablesound/s/true/false/' \
		${WRKSRC}/modules/libpref/init/all.js

.include <bsd.port.pre.mk>

gecko-post-patch:
	@${RM} ${MOZCONFIG}
.for arg in ${MOZ_OPTIONS}
	@${ECHO_CMD} ac_add_options ${arg:Q} >> ${MOZCONFIG}
.endfor
.for arg in ${MOZ_MK_OPTIONS}
	@${ECHO_CMD} mk_add_options ${arg:Q} >> ${MOZCONFIG}
.endfor
.for var in ${MOZ_EXPORT}
	@${ECHO_CMD} export ${var:Q} >> ${MOZCONFIG}
.endfor


do-install:
	${CP} -rL ${WRKSRC}/${MOZ_OBJDIR}/dist/bin ${STAGEDIR}${PREFIX}/lib/${PORTNAME}
	${STRIP_CMD} ${STAGEDIR}${PREFIX}/lib/${PORTNAME}/nsinstall


post-install:
	${LN} -sf ${PREFIX}/lib/seamonkey/chrome/icons/default/default48.png \
		${STAGEDIR}${PREFIX}/share/pixmaps/seamonkey.png


.include <bsd.port.post.mk>

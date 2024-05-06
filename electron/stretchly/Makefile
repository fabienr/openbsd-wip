COMMENT=	break time reminder app

COMMIT=		ba95df8854b12f2518aa5bd3059c88679b8cda0b
DIST_TUPLE=	github hovancik stretchly ${COMMIT} .
DISTNAME=	stretchly-${COMMIT}
PKGNAME=	stretchly-1.15.1

CATEGORIES=	electron productivity

HOMEPAGE=	https://hovancik.net/stretchly/
MAINTAINER=	fabien@openbsd.org

# BSD 2-Clause
PERMIT_PACKAGE=	Yes

BUILD_DEPENDS+=	devel/app-builder

RUN_DEPENDS+=	devel/desktop-file-utils \
		x11/gtk+4,-guic

MODULES=	electron/electron

MODNPM_OMITOPTIONAL= Yes

DIST_TARGET=	${ELECTRON_DIST_APPS}/stretchly

BUILDDIR=	${WRKSRC}/dist/linux-unpacked/resources

pre-build:
	# generate icon files
	cd ${WRKSRC} && env -i ${MAKE_ENV} app-builder icon \
		--input=icon.icns --out=icons --format=set --root=build
.for size in 16 48
	mv ${WRKSRC}/icons/icon_${size}x${size}.png \
		${WRKSRC}/icons/icon_${size}.png
.endfor

do-build:
	# fake electron dist
	mkdir -p ${WRKDIR}/electron && \
		ln -fs ${LOCALBASE}/electron/electron \
			${WRKDIR}/electron/electron
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		./node_modules/electron-builder/cli.js \
		--linux --dir \
		--config.npmRebuild=false \
		--config.electronVersion=${ELECTRON_V} \
		--config.electronDist=${WRKDIR}/electron

do-install:
	# wraper
	${SUBST_PROGRAM} ${FILESDIR}/stretchly \
		${PREFIX}/bin/stretchly
	# menu
	${INSTALL_DATA_DIR} ${PREFIX}/share/applications
	${INSTALL_DATA} ${WRKSRC}/net.hovancik.Stretchly.desktop \
		${PREFIX}/share/applications/stretchly.desktop
	${INSTALL_DATA_DIR} ${PREFIX}/share/metainfo/
	${INSTALL_DATA} ${WRKSRC}/net.hovancik.Stretchly.metainfo.xml \
		${PREFIX}/share/metainfo/stretchly.metainfo.xml
.for size in 16 32 48 64 128 256 512 1024
	${INSTALL_DATA_DIR} ${PREFIX}/share/icons/hicolor/${size}x${size}/apps
	${INSTALL_DATA} ${WRKSRC}/icons/icon_${size}.png \
		${PREFIX}/share/icons/hicolor/${size}x${size}/apps/stretchly.png
.endfor
	# resources
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET}.asar.unpacked
# XXX permission ? no INSTALL* fn ? chown ? chmod o-w ?
	cp -Rp ${BUILDDIR}/app.asar.unpacked/* \
		${PREFIX}/${DIST_TARGET}.asar.unpacked
	${INSTALL_DATA} ${BUILDDIR}/app.asar \
		${PREFIX}/${DIST_TARGET}.asar
# XXX which app use this file ?
	${INSTALL_DATA} ${BUILDDIR}/app-update.yml \
		${PREFIX}/${DIST_TARGET}-update.yml

.include "modules.inc"

.include <bsd.port.mk>

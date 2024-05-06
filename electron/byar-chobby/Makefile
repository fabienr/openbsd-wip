# XXX games/recoil-rts is not compatible with byar, in discussion with thfr@
# move /usr/local/bin/spring to /usr/local/share/games/spring/spring
# use a wraper : exec "/usr/local/share/games/spring/spring" "${@}"

COMMENT =	launcher for Beyond All Reason

V =		1.2988.0
DIST_TUPLE =	github beyond-all-reason BYAR-Chobby v${V} .
DISTNAME =	BYAR-Chobby-${V}
# XXX bsd.port.mk doesn't cast in lower case itself ?
PKGNAME=	${DISTNAME:L}

COMMIT =	2c0a6e17b50ab04ea592c53963c571e5ccb071ba
DIST_TUPLE +=	github beyond-all-reason spring-launcher ${COMMIT} launcher

CATEGORIES =	electron games

HOMEPAGE =	https://www.beyondallreason.info/
MAINTAINER =	fabien@openbsd.org

# XXX licence ??? (spring-launcher = MIT)
PERMIT_PACKAGE=	Yes

BUILD_DEPENDS+=	devel/app-builder

RUN_DEPENDS+=	archivers/p7zip \
		electron/electron

MODULES =	electron/electron

MODNPM_OMITOPTIONAL= Yes
MODNPM_LOCKS=	${WRKSRC}/launcher/package-lock.json

DIST_TARGET =	${ELECTRON_DIST_APPS}/byar_chobby_launcher

BUILDDIR=	${WRKSRC}/launcher/dist/linux-unpacked/resources

pre-patch:
	# node_modules
	mv ${WRKSRC}/node_modules ${WRKSRC}/launcher/

pre-build:
	# dist_cfg->launcher/ : build, src/config.json, src/renderer
# XXX from github workflow, cook something less smart ?
	cp -r ${WRKSRC}/dist_cfg/* ${WRKSRC}/launcher/src/
	for dir in bin files build; do \
		mkdir -p ${WRKSRC}/launcher/$$dir ; \
		if [ -d ${WRKSRC}/launcher/src/$$dir/ ]; then \
			mv ${WRKSRC}/launcher/src/$$dir/* \
				${WRKSRC}/launcher/$$dir/ ; \
			rm -rf ${WRKSRC}/launcher/src/$$dir ; \
		fi ; \
	done
	# package.json
# XXX replace with a patch ?
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		node build/make_package_json.js \
			launcher/package.json \
			dist_cfg/config.json \
			beyond-all-reason/BYAR-Chobby ${V}

do-build:
	# fake electron dist
	mkdir -p ${WRKDIR}/electron && \
		ln -fs ${LOCALBASE}/electron/electron \
			${WRKDIR}/electron/electron
	cd ${WRKSRC}/launcher && env -i ${MAKE_ENV} \
		./node_modules/electron-builder/cli.js \
		--linux --dir \
		--config.npmRebuild=false \
		--config.electronVersion=${ELECTRON_V} \
		--config.electronDist=${WRKDIR}/electron

do-install:
	# wraper
	${SUBST_PROGRAM} ${FILESDIR}/byar_chobby_launcher \
		${PREFIX}/bin/byar_chobby_launcher
	# menu
	${INSTALL_DATA_DIR} ${PREFIX}/share/applications
	${INSTALL_DATA} ${FILESDIR}/byar_chobby_launcher.desktop \
		${PREFIX}/share/applications/byar_chobby_launcher.desktop
	${INSTALL_DATA_DIR} ${PREFIX}/share/pixmaps
	${INSTALL_DATA} ${WRKSRC}/dist_cfg/build/icon.png \
		${PREFIX}/share/pixmaps/byar_chobby_launcher.png
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
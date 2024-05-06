ELECTRON_V=		28.2.10
ELECTRON_DIST_APPS=	electron/resources

.include "modules/npm.port.mk"
.include "modules/yarn.port.mk"

.if ${NO_BUILD:L} == "no"
MODELECTRON_BUILDDEP ?=	Yes
.else
MODELECTRON_BUILDDEP ?=	No
.endif
MODELECTRON_RUNDEP ?=	Yes
.if ${NO_TEST:L} == "no"
MODELECTRON_TESTDEP ?=	Yes
.else
MODELECTRON_TESTDEP ?=	No
.endif

.if ${MODELECTRON_BUILDDEP:L} == "yes"
BUILD_DEPENDS +=	electron/electron
.endif
.if ${MODELECTRON_RUNDEP:L} == "yes"
RUN_DEPENDS +=		electron/electron
.endif
.if ${MODELECTRON_TESTDEP:L} == "yes"
TEST_DEPENDS +=		electron/electron
.endif

# XXX all electron ports need HOME ?
PORTHOME=		${WRKDIR}
MAKE_ENV+=		TMPDIR=${WRKDIR}/tmp
MAKE_ENV+=		USE_SYSTEM_APP_BUILDER=true
MAKE_ENV+=		ELECTRON_SKIP_BINARY_DOWNLOAD=1
TEST_ENV+=		HOME=${WRKDIR}

ELECTRON_ARCH=		${ARCH:S/aarch64/arm64/:S/amd64/x64/:S/i386/ia32/}
# XXX lang/node port.mk ?
NODE_ARCH=		${ARCH:S/aarch64/arm64/:S/amd64/x64/}

ELECTRON_URL=${SITES.github}electron/electron/releases/download/v${ELECTRON_V}
ELECTRON_URL_HASH=	$$(sha256 -q -s "${ELECTRON_URL}")
ELECTRON_RELEASES=	${LOCALBASE}/electron/releases
ELECTRON_NODE_DIR=	${LOCALBASE}/electron/node_headers
ELECTRON_REBUILD_ENV=	npm_config_runtime=electron \
			npm_config_target=${ELECTRON_V} \
			npm_config_nodedir=${ELECTRON_NODE_DIR}

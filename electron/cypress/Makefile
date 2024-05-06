# XXX fuse electron ?
# //       await flipFuses(
# //         exePathPerPlatform[os.platform()],
# //         {
# //           version: FuseVersion.V1,
# //           [FuseV1Options.LoadBrowserProcessSpecificV8Snapshot]: true,
# //           [FuseV1Options.EnableNodeCliInspectArguments]: false,
# //         },
# //       )

# node_modules/@opentelemetry/resources/build/esm/platform/node/machine-id/getMachineId.js
# node_modules/@packages/graphql/*

COMMENT=	reliable testing for anything that runs in a browser
V=		13.7.1
DIST_TUPLE=	github cypress-io cypress v${V} .

CATEGORIES=	electron devel

HOMEPAGE=	https://www.cypress.io/
MAINTAINER=	fabien@openbsd.org

# MIT
PERMIT_PACKAGE=	Yes

# XXX node-gyp = python+gmake
MODULES =	electron/electron

BUILD_DEPENDS=	devel/libinotify

CXXFLAGS+=	-I${LOCALBASE}/include/inotify
LDFLAGS+=	-L${LOCALBASE}/lib
MAKE_ENV+=	CXXFLAGS="${CXXFLAGS}" LDFLAGS="${LDFLAGS}"

# fix buildinfo for cli/scripts/build.js
CYPRESS_COMMIT=	f17fa4ca60338a1b86e092bc970e5d7decd4b2e3
CYPRESS_DATE=	2024-03-21T00:00:00.000Z
SUBST_VARS+=	WRKDIR CYPRESS_COMMIT CYPRESS_DATE

# XXX too much ?
# MODYARN_LOCKS =	$$(find ${WRKSRC}/system-tests -name yarn.lock -print)
# MODYARN_LOCKS+=	${WRKSRC}/yarn.lock

# XXX filtering yarn depends (WIP)
# MODYARN_OMITOPTIONAL=Yes
# MODYARN_INCLUDES+=

# XXX postinstall by hand ?
# XXX way more patches to handle
# pre-patch:
# 	# apply cypress patches
# 	for _p in ${WRKSRC}/patches/*.patch; do \
# 		${PATCH} -f -p1 -z .orig.cypress \
# 			-d ${WRKSRC} -i $${_p}; \
# 	done
pre-patch:
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		yarn patch-package

# XXX find ./ -name binding.gyp
# ./node_modules/@cypress/get-windows-proxy/node_modules/registry-js/binding.gyp
# ./node_modules/@parcel/watcher/binding.gyp
# ./node_modules/better-sqlite3/binding.gyp
# ./node_modules/cpu-features/binding.gyp
# ./node_modules/lzma-native/binding.gyp
# ./node_modules/registry-js/binding.gyp
# ./node_modules/ssh2/lib/protocol/crypto/binding.gyp
# ./node_modules/win-version-info/binding.gyp

# XXX only for NX daemon ? (disabled for this build)
# XXX use lerna
#	cd ${WRKSRC}/node_modules/@parcel/watcher && \
#		env -i ${MAKE_ENV} npm_config_nodedir=${LOCALBASE} \
#		node ${MODNPM_GYP_BIN} rebuild

# XXX Failed to start or connect to the Nx Daemon process.
# node:.../build/Release/watcher.node: undefined symbol 'inotify_init1'
# ld.so: node: lazy binding failed!
# 	cd ${WRKSRC} && env -i ${MAKE_ENV} \
# 		LD_PRELOAD=/usr/local/lib/inotify/libinotify.so.3.0 \
# 		yarn run nx daemon --start
# XXX better to never start ?
# 	cd ${WRKSRC} && env -i ${MAKE_ENV} \
# 		LD_PRELOAD=/usr/local/lib/inotify/libinotify.so.3.0 \
# 		yarn run nx daemon --stop

do-configure:
	${SUBST_CMD} ${WRKSRC}/cli/scripts/build.js
	find ${WRKSRC} -name '*.sh' \
		-exec sed -i.bak 's|\#!/bin/bash|\#!/bin/sh|' {} \;

# tooling/v8-snapshot require pre-built snapbuild binary (source?)
MAKE_ENV+=	DISABLE_SNAPSHOT_REQUIRE=1
# Failed to start or connect to the Nx Daemon process.
MAKE_ENV+=	NX_DAEMON=false

pre-build:
#	cd ${WRKSRC}/node_modules/@parcel/watcher && \
#		env -i ${MAKE_ENV} npm_config_nodedir=${LOCALBASE} \
#		node ${MODNPM_GYP_BIN} rebuild
# XXX 
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		${ELECTRON_REBUILD_ENV} \
		yarn lerna run rebuild-better-sqlite3 \
		--scope @packages/server
	mkdir -p ${PORTHOME}/.cache/electron
	if [ ! -e ${PORTHOME}/.cache/electron/${ELECTRON_URL_HASH} ]; then \
		ln -sf ${ELECTRON_RELEASES} \
			${PORTHOME}/.cache/electron/${ELECTRON_URL_HASH} ; \
	fi
	if [ ! -e ${PORTHOME}/.postinstall ]; then \
		cd ${WRKSRC} && env -i ${MAKE_ENV} \
			${ELECTRON_REBUILD_ENV} \
			yarn postinstall --frozen-lockfile --offline \
			--ignore-scripts --ignore-engines && \
		touch ${PORTHOME}/.postinstall ; \
	fi

do-build:
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		${ELECTRON_REBUILD_ENV} \
		yarn lerna run build-cli
	mkdir -p ${PORTHOME}/.config
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		${ELECTRON_REBUILD_ENV} \
		ELECTRON_OVERRIDE_DIST_PATH=${LOCALBASE}/electron \
		yarn binary-build --version=${V} --platform=linux

post-build:
	# fake electron dist
	mkdir -p ${WRKDIR}/electron && \
		ln -fs ${LOCALBASE}/electron/electron \
			${WRKDIR}/electron/electron
	${SUBST_CMD} ${WRKSRC}/scripts/binary/build.ts
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		${ELECTRON_REBUILD_ENV} \
		yarn binary-package --version=${V} --platform=linux

ELECTRON_TARGET=${WRKDIR}/tmp/cypress-build/linux/build/linux-unpacked

pre-test:
# XXX fix esbuild for old version not working anymore (syscall)
	cp ${LOCALBASE}/bin/esbuild \
		${WRKSRC}/node_modules/esbuild-openbsd-64/bin/esbuild
# XXX fix Cypress build for smoke test, setup a fake wrapper
	rm -f ${ELECTRON_TARGET}/Cypress
	echo '#!/bin/sh' > ${ELECTRON_TARGET}/Cypress
	echo 'exec ${TRUEPREFIX}/bin/electron_nosandbox \
		--app="${ELECTRON_TARGET}/resources/app" $$@' \
		>> ${ELECTRON_TARGET}/Cypress
	chmod +x ${ELECTRON_TARGET}/Cypress

# XXX x11 needed ?
TEST_IS_INTERACTIVE=	x11

# XXX error Command "..." not found.
# XXX lerna ERR! yarn test-debug exited 1 in '@cypress/grep' [...]
# XXX lerna ERR! yarn test-integration exited 1 in '@cypress/schematic' [...]
# XXX test-mocha: Could not find ...: scripts/spec.js
TEST_TARGETS =	test \
		test-scripts \
		verify:mocha:results \
		test-npm-package-release-script \
		test-system \
		test-unit \
		type-check

do-test:
	cd ${WRKSRC} && env -i ${TEST_ENV} ${MAKE_ENV} SKIP_DEPCHECK=1 \
		${ELECTRON_REBUILD_ENV} yarn binary-smoke-test --version=${V}
.for _test in ${TEST_TARGETS}
	cd ${WRKSRC} && env -i ${TEST_ENV} ${MAKE_ENV} SKIP_DEPCHECK=1 \
		${ELECTRON_REBUILD_ENV} yarn ${_test}
.endfor

yarn-start:
	# use CYPRESS_INTERNAL_DEV_DEBUG to unshift args at spawn
	cp ~/.Xauthority ${PORTHOME}/.Xauthority
	cd ${WRKSRC} && env HOME=${PORTHOME} DEBUG=* SKIP_DEPCHECK=1 yarn start

.include "modules.inc"

.include <bsd.port.mk>

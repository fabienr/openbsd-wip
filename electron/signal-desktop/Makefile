# XXX split in sub-ports electron/signal/* ?
# signal-desktop
# better-sqlite3
# libsignal
# ringrtc

# XXX fuse electron ?
# await flipFuses(electron, {
# version: FuseVersion.V1,
# // Disables ELECTRON_RUN_AS_NODE
# [FuseV1Options.RunAsNode]: false,
# // Enables cookie encryption
# [FuseV1Options.EnableCookieEncryption]: true,
# // Disables the NODE_OPTIONS environment variable
# [FuseV1Options.EnableNodeOptionsEnvironmentVariable]: false,
# // Disables the --inspect and --inspect-brk family of CLI options
# [FuseV1Options.EnableNodeCliInspectArguments]: enableInspectArguments,
# // Enables validation of the app.asar archive on macOS
# [FuseV1Options.EnableEmbeddedAsarIntegrityValidation]: true,
# // Enforces that Electron will only load your app from "app.asar" instead of
# // its normal search paths
# [FuseV1Options.OnlyLoadAppFromAsar]: true,
# });

# XXX feature = "fips" (& no "rpk")
# XXX security/boringssl/fips/patches ?
# XXX fips as a flavor ?

COMMENT=	Signal Desktop links with Signal

V=		7.1.1
DIST_TUPLE=	github signalapp Signal-Desktop v${V} .
DISTNAME=	Signal-Desktop-${V}
PKGNAME=	${DISTNAME:L}

CATEGORIES=	electron net

HOMEPAGE=	https://signal.org/
MAINTAINER=	fabien@openbsd.org

# BSD 2-Clause
PERMIT_PACKAGE=	Yes

WANTLIB += ${MODCARGO_WANTLIB} c++ crypto m

# better-sqlite3, MIT
# make sqlcipher
SQLCIPHER_HASH=ef53ea45ed92b928ecfd33c552d8d405263e86e63dec38e1ec63e1b0193b630b
SQLCIPHER_V=		4.5.5-fts5-fix--3.0.7--0.2.1-${SQLCIPHER_HASH}
SQLCIPHER_T=		${WRKSRC}/node_modules/@signalapp/better-sqlite3/deps
DISTFILES.sqlcipher=	sqlcipher-${SQLCIPHER_V}.tar.gz
SITES.sqlcipher=	https://build-artifacts.signal.org/desktop/
EXTRACT_CASES+=		${DISTFILES.sqlcipher});;

# Signal-FTS5-Extension, AGPLv3
# see @signalapp/better-sqlite3/deps/sqlite3.gyp, libsignal_tokenizer.a
FTS5_V=		0.2.1
FTS5_SRC=	${WRKDIR}/Signal-FTS5-Extension-${FTS5_V}
FTS5_TOML=	${FTS5_SRC}/Cargo.toml
DIST_TUPLE+=	github signalapp Signal-FTS5-Extension v${FTS5_V} .

# libsignal, AGPLv3
LIBSIGNAL_V=	0.41.2
LIBSIGNAL_SRC=	${WRKDIR}/libsignal-${LIBSIGNAL_V}
LIBSIGNAL_NODE=	${LIBSIGNAL_SRC}/node
LIBSIGNAL_TOML=	${LIBSIGNAL_SRC}/Cargo.toml
DIST_TUPLE+=	github signalapp libsignal v${LIBSIGNAL_V} .
# libsignal/Cargo.lock git+ depends
_BORING=	8245063ae6eb97d909982b89fad45bb7f0a2a1a0
_CURVE=		a12ab4e58455bb3dc7cd73a0f9f3443507b2854b
DIST_TUPLE+=	github signalapp boring ${_BORING} boring
DIST_TUPLE+=	github signalapp curve25519-dalek ${_CURVE} curve25519-dalek

# boringssl, OpenSSL/ISC
# see https://github.com/signalapp/boring/tree/libsignal/boring-sys/deps
BORINGSSL=	44b3df6f03d85c901767250329c571db405122d5
BORINGSSL_T=	${WRKDIR}/boring-${_BORING}/boring-sys/deps
DIST_TUPLE+=	github google boringssl ${BORINGSSL} .

# XXX only with feature = "fips" (& no "rpk")
#BORINGSSL_FIPS= 853ca1ea1168dff08011e5d42d94609cc0ca2e27
#DIST_TUPLE+=	github google boringssl ${BORINGSSL_FIPS} .
# XXX security/boringssl/fips/patches ?
#BORINGSSL_SRC=	${WRKSRC}/boring/boring-sys/deps
#ALL_PATCHFILES+=${PATCHDIR}/boringssl/patch-*
#PATCH_CASES+=	${PATCHDIR}/boringssl/patch-*) \
#		    ${PATCH} ${PATCH_DIST_ARGS} \
#		    -z .orig.boringssl \
#		    -d ${BORINGSSL_SRC}/boringssl-fips <$$patchfile ;;

# ringrtc, AGPLv3
RINGRTC_V=	2.39.1
RINGRTC_SRC=	${WRKDIR}/ringrtc-${RINGRTC_V}
RINGRTC_NODE=	${RINGRTC_SRC}/src/node
RINGRTC_TOML=	${RINGRTC_SRC}/Cargo.toml
DIST_TUPLE+=	github signalapp ringrtc v${RINGRTC_V} .

# libwebrtc, BSD-3-Clause
LIBWEBRTC_V=	6261c
DIST_TUPLE+=	github signalapp webrtc ${LIBWEBRTC_V} .

# make webrtc-deps
_DISTDIR=	signal-desktop
SITES.chrome=	https://chromium.googlesource.com/
SITES.boring=	https://boringssl.googlesource.com/
TEMPLATE_DISTFILES.webrtc= \
  ${_DISTDIR}/<account>-<project>-{<account>/<project>.git/+archive/}<id>.tar.gz
TEMPLATE_DISTFILES.chrome= ${TEMPLATE_DISTFILES.webrtc}
TEMPLATE_DISTFILES.boring= ${TEMPLATE_DISTFILES.webrtc}
EXTRACT_CASES+=${_DISTDIR}/*.tar.gz) \
	_filename=$${archive\#\#*/} && \
	mkdir -p $${_filename%.tar.gz} && \
	${GZIP_CMD} -d <${FULLDISTDIR}/$$archive | \
		${TAR} -C $${_filename%.tar.gz} -xf - -- ;;

WEBRTC_T=	${WRKDIR}/ringrtc-${RINGRTC_V}/src/webrtc
WEBRTC_SRC=	${RINGRTC_SRC}/src/webrtc/src
WEBRTC_DEPS= \
	src/base chromium/src-base \
	src/build chromium/src-build \
	src/buildtools chromium/src-buildtools \
	src/ringrtc/opus/src signalapp-opus \
	src/testing chromium/src-testing \
	src/third_party chromium/src-third_party \
	src/third_party/boringssl/src .-boringssl \
	src/third_party/catapult .-catapult \
	src/third_party/icu chromium/deps-icu \
	src/third_party/libjpeg_turbo chromium/deps-libjpeg_turbo \
	src/third_party/libsrtp chromium/deps-libsrtp \
	src/third_party/libvpx/source/libvpx webm-libvpx \
	src/third_party/libyuv libyuv-libyuv \
	src/third_party/nasm chromium/deps-nasm \
	src/tools chromium/src-tools

# XXX test-libwebrtc looks too hard to implement
# webrtc test
#WEBRTC_DEPS+= \
#	src/third_party/googletest/src external/github.com/google-googletest

ALL_PATCHFILES+=${PATCHDIR}/chromium/patch-*
PATCH_CASES+=	${PATCHDIR}/chromium/patch-*) \
		    ${PATCH} ${PATCH_DIST_ARGS} \
		    -z .orig.chromium \
		    -d ${WEBRTC_SRC}/ <$$patchfile ;;

MODULES=	devel/cargo \
		devel/cmake \
		electron/electron \
		lang/clang \
		lang/python

# see custom modcargo-gen-crates
MODCARGO_CARGOS_TOML=	${FTS5_TOML} ${LIBSIGNAL_TOML} ${RINGRTC_TOML}

MODPY_RUNDEP=	No

MODYARN_TARGETS=${LIBSIGNAL_NODE} \
		${RINGRTC_NODE} \
		${WRKSRC}/sticker-creator \
		${WRKSRC}

BUILD_DEPENDS+=	devel/app-builder \
		devel/gn \
		devel/ninja
# XXX only needed to generate ft5 include
# XXX only if we bundle sqlcipher from official source
#BUILD_DEPENDS+=	devel/cbindgen

RUN_DEPENDS+=	devel/desktop-file-utils

DEBUG_PACKAGES=	${BUILD_PACKAGES}

SUBST_VARS+=	WRKSRC MODCARGO_TARGET_DIR

# XXX always rebuild native node-sass module ??
#MAKE_ENV+=	SASS_FORCE_BUILD=true

RINGRTC_T=	node_modules/@signalapp/ringrtc/build
LIBSIGNAL_T=	node_modules/@signalapp/libsignal-client/prebuilds
DIST_TARGET=	${ELECTRON_DIST_APPS}/signal-desktop

BUILDDIR=	${WRKSRC}/dist/linux-unpacked/resources

# pre-define source date, no git show -s --format=%ct
SIGNAL_ENV+=	SOURCE_DATE_EPOCH=$$(date +'%s')

# libsignal/linkme is broken with https://github.com/dtolnay/linkme/commit/64e7c63c106848481bea8f66c4885b52c26ca9ec
# It's probably related to https://github.com/dtolnay/linkme/issues/49
MODCARGO_RUSTFLAGS+=	-Clink-dead-code

# XXX from freebsd port ?
#MAKE_ENV+=	RUSTC_BOOTSTRAP=aes,polyval

# libclang.so
MODCARGO_ENV +=		LIBCLANG_PATH=${LOCALBASE}/llvm${MODCLANG_VERSION}/lib \
			LD_LIBRARY_PATH=${LOCALBASE}/llvm${MODCLANG_VERSION}/lib

# XXX .include version
NODE_VER=		18.19.1

# see electron/Makefile
# - opus, RingRTC change to use a fork of opus
GN_SYSTEM_LIBS=	crc32c \
		dav1d \
		double-conversion \
		icu \
		jsoncpp \
		libaom \
		libevent \
		libpng \
		libvpx \
		libwebp \
		libxml \
		libxslt \
		openh264 \
		re2 \
		snappy \
		woff2
GN_ARGS=	use_system_libjpeg=true \
		use_system_harfbuzz=true \
# electron/Makefile link options
GN_ARGS+=	symbol_level=1 \
		is_component_build=false
GN_ARGS+=	use_thin_lto=false \
		thin_lto_enable_optimizations=true
.if ${MACHINE_ARCH} == "aarch64"
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib\"
PKG_ARGS+=	-Dswiftshader=0
.elif ${MACHINE_ARCH} == "amd64"
BUILD_DEPENDS+=	devel/nasm
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib\"
PKG_ARGS+=	-Dswiftshader=1
.elif ${MACHINE_ARCH} == "i386"
BUILD_DEPENDS+=	devel/nasm
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib -Wl,--no-keep-memory\"
PKG_ARGS+=	-Dswiftshader=1
.else
PKG_ARGS+=	-Dswiftshader=0
.endif
# electron/Makefile common options
GN_ARGS+=	enable_rust=false \
		use_sysroot=false \
		treat_warnings_as_errors=false \
		clang_use_chrome_plugins=false \
		extra_cppflags=\"-idirafter ${LOCALBASE}/include -idirafter ${X11BASE}/include\" \
		fatal_linker_warnings=false \
		use_custom_libcxx=false

# see ringrtc/bin/build-electron
GN_ARGS+=	rtc_build_examples=false \
		rtc_build_tools=false \
		rtc_include_tests=false \
		rtc_enable_protobuf=false \
		rtc_use_x11=false \
		rtc_enable_sctp=false \
		rtc_libvpx_build_vp9=true \
		rtc_include_ilbc=false

# webrtc
GN_ARGS+=	is_debug=false \
		is_clang=true \
		extra_cxxflags=\"${CXXFLAGS}\"

post-extract:
	# setup boring-sys
	rm -rf ${BORINGSSL_T}/*
	mv ${WRKDIR}/boringssl-${BORINGSSL} ${BORINGSSL_T}/boringssl
# XXX fips as a flavor ?
#	mv ${WRKDIR}/boringssl-${BORINGSSL_FIPS} ${BORINGSSL_T}/boringssl-fips
	# setup webrtc
	mkdir -p ${WEBRTC_T}
	mv ${WRKDIR}/webrtc-${LIBWEBRTC_V} ${WEBRTC_T}/src
	mv ${WRKDIR}/{,signalapp-}opus-*
.for _dst _name in ${WEBRTC_DEPS}
	mv ${WRKDIR}/${_name:T}-* ${WEBRTC_T}/${_dst}
.endfor

pre-patch:
# XXX DIST_TUPLE run after MODYARN
	# link depends into ${WRKSRC} to handle patches
	mv ${LIBSIGNAL_SRC} ${WRKSRC}/libsignal
	ln -s ${WRKSRC}/libsignal ${LIBSIGNAL_SRC}
	mv ${RINGRTC_SRC} ${WRKSRC}/ringrtc
	ln -s ${WRKSRC}/ringrtc ${RINGRTC_SRC}
	# apply signal-desktop patches
	for _p in ${WRKSRC}/patches/*.patch; do \
		${PATCH} -f -p1 -z .orig.signal \
			-d ${WRKSRC} -i $${_p}; \
	done
# XXX apply boring patches there instead from cargo build ?

pre-configure:
	@ln -sf ${MODPY_BIN} ${WRKDIR}/bin/python
	@ln -sf ${MODPY_BIN} ${WRKDIR}/bin/vpython3
	@ln -sf ${LOCALBASE}/bin/llvm-ar-${MODCLANG_VERSION} ${WRKDIR}/bin/ar
	# setup yarnrc for using electron node headers
	echo 'nodedir "${ELECTRON_NODE_DIR}"' >> ${WRKSRC}/.yarnrc

do-configure:
	${MODCARGO_configure}
	${SUBST_DATA} ${FILESDIR}/cargo.toml \
 		${WRKDIR}/cargo.toml
	cat ${WRKDIR}/cargo.toml >>${WRKDIR}/.cargo/config

pre-build: better-sqlite3 libsignal ringrtc sticker-creator

fts5:
	# build fts5-extension native depends for better-sqlite3
	cd ${FTS5_SRC} && env -i ${MAKE_ENV} ${CONFIGURE_ENV} \
		${MODCARGO_ENV} ${MODCARGO_CARGO_BIN} build \
		--release
# XXX try to fetch sqlcipher and make sqlite3.c with proper option ?
# XXX then we also need to generate the header to build better-sqlite
#	mkdir -p ${FTS5_SRC}/include
#	cd ${FTS5_SRC} && cbindgen >include/signal-tokenizer.h

better-sqlite3: fts5
	# build better-sqlite3 native depends
	cp ${DISTDIR}/${DISTFILES.sqlcipher} ${SQLCIPHER_T}/sqlcipher.tar.gz
	${SUBST_CMD} ${SQLCIPHER_T}/sqlite3.gyp
	cd ${SQLCIPHER_T}/.. && env -i ${MAKE_ENV} ${ELECTRON_REBUILD_ENV} \
		node ${MODNPM_GYP_BIN} rebuild

libsignal:
	# build libsignal native depends (fake node-gyp build)
	cd ${LIBSIGNAL_SRC} && env -i ${MAKE_ENV} ${CONFIGURE_ENV} \
		${MODCARGO_ENV} ${MODCARGO_CARGO_BIN} build \
		-p libsignal-node --features testing-fns --release
	# install libsignal prebuild
	mkdir -p ${WRKSRC}/${LIBSIGNAL_T}/openbsd-${NODE_ARCH}
	cp ${MODCARGO_TARGET_DIR}/release/libsignal_node.so \
		${WRKSRC}/${LIBSIGNAL_T}/openbsd-${NODE_ARCH}/node.napi.node

libwebrtc:
	# configure libwebrtc native depends for ringrtc
	echo "# fake gclient_args" > ${WEBRTC_SRC}/build/config/gclient_args.gni
	cd ${WEBRTC_SRC} && env -i ${MAKE_ENV} \
		build/linux/unbundle/replace_gn_files.py \
		--system-libraries ${GN_SYSTEM_LIBS}
	cd ${WEBRTC_SRC} && env -i ${CONFIGURE_ENV} ${MAKE_ENV} \
		gn gen out/release --args="${GN_ARGS}"
	# build libwebrtc native depends for ringrtc
# XXX 		CC=ccache CXX=ccache
	cd ${WEBRTC_SRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/release
# XXX		CC=ccache CXX=ccache
	cd ${WEBRTC_SRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/release \
		-t compdb > compile_commands.json

ringrtc: libwebrtc
	# build ringrtc native depends
	cd ${RINGRTC_SRC} && env -i ${MAKE_ENV} ${CONFIGURE_ENV} \
		OUTPUT_DIR=${WEBRTC_SRC}/out \
		${MODCARGO_ENV} ${MODCARGO_CARGO_BIN} build -p ringrtc \
		--features electron --release \
		${MODCARGO_BUILD_ARGS}
	# install ringrtc prebuild
	mkdir -p ${WRKSRC}/${RINGRTC_T}/openbsd
	cp ${MODCARGO_TARGET_DIR}/release/libringrtc.so \
		${WRKSRC}/${RINGRTC_T}/openbsd/libringrtc-${NODE_ARCH}.node

sticker-creator:
	# build sticker-creator
	cd ${WRKSRC}/sticker-creator && env -i ${MAKE_ENV} \
		yarn build

do-build:
	# build signal
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		yarn build:acknowledgments
	cd ${WRKSRC} && env -i ${MAKE_ENV} ${SIGNAL_ENV} \
		yarn generate
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		yarn build:esbuild:prod
	# fake electron dist
	mkdir -p ${WRKDIR}/electron && \
		ln -fs ${LOCALBASE}/electron/electron_nosandbox \
			${WRKDIR}/electron/electron
	cd ${WRKSRC} && env -i ${MAKE_ENV} SIGNAL_ENV=production \
		./node_modules/electron-builder/cli.js \
		--linux --dir \
		--config.npmRebuild=false \
		--config.electronVersion=${ELECTRON_V} \
		--config.electronDist=${WRKDIR}/electron

do-install:
	# wraper
	${SUBST_PROGRAM} ${FILESDIR}/signal-desktop \
		${PREFIX}/bin/signal-desktop
	# menu
	${INSTALL_DATA_DIR} ${PREFIX}/share/applications
	${INSTALL_DATA} ${FILESDIR}/signal.desktop \
		${PREFIX}/share/applications/signal.desktop
	${INSTALL_DATA_DIR} ${PREFIX}/share/pixmaps
	${INSTALL_DATA} ${WRKSRC}/images/signal-logo-desktop-linux.png \
		${PREFIX}/share/pixmaps/signal-desktop.png
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

# XXX test-fts5 ?
# XXX test-better-sqlite ?
# XXX test-libwebrtc ?
do-test:	test-libsignal \
		test-ringrtc \
		test-sticker-creator \
		test-signal-desktop

test-libsignal: libsignal
# # setup libsignal yarn depends
# echo 'yarn-offline-mirror "${WRKDIR}/${MODYARN_CACHE}"' >> \
# 	${LIBSIGNAL_NODE}/.yarnrc
# echo 'nodedir "${LOCALBASE}"' >> \
# 	${LIBSIGNAL_NODE}/.yarnrc
# cd ${LIBSIGNAL_NODE} && env -i ${MAKE_ENV} \
# 	yarn install --frozen-lockfile --offline \
# 	--ignore-scripts --ignore-engines
	# copy libsignal native lib
	mkdir -p ${LIBSIGNAL_NODE}/build/Release
	cp ${MODCARGO_TARGET_DIR}/release/libsignal_node.so \
		${LIBSIGNAL_NODE}/build/Release/node.napi.node
	# build libsignal test
	cd ${LIBSIGNAL_NODE} && env -i ${MAKE_ENV} yarn tsc
	# run libsignal test
	cd ${LIBSIGNAL_NODE} && env -i ${MAKE_ENV} yarn test

# XXX howto ?????
test-libwebrtc: libwebrtc
	# run libwebrtc test
	# cd ${WEBRTC_SRC} && env -i ${CONFIGURE_ENV} ${MAKE_ENV} \
	# 	gn gen out/release --args="${GN_ARGS}"
	#cd ${WEBRTC_SRC} && env -i ${MAKE_ENV} \
	#	CC=ccache CXX=ccache \
	#	ninja -j ${MAKE_JOBS} -C out/release test
	cd ${WEBRTC_SRC} && env -i ${MAKE_ENV} \
		CC=ccache CXX=ccache \
		ninja -j ${MAKE_JOBS} -C out/release run_test

# XXX .sndio/cookie ?
# audio_device_sndio.cc:26: Couldn't open audio device
test-ringrtc: ringrtc
	# XXX Xvfb :1 &
# # setup ringrtc yarn depends
# echo 'yarn-offline-mirror "${WRKDIR}/${MODYARN_CACHE}"' >> \
# 	${RINGRTC_NODE}/.yarnrc
# echo 'nodedir "${LOCALBASE}"' >> \
# 	${RINGRTC_NODE}/.yarnrc
# cd ${RINGRTC_NODE} && env -i ${MAKE_ENV} \
# 	yarn install --frozen-lockfile --offline \
# 	--ignore-scripts --ignore-engines
	# copy ringrtc native lib
	mkdir -p ${RINGRTC_NODE}/build/openbsd
	cp ${MODCARGO_TARGET_DIR}/release/libringrtc.so \
		${RINGRTC_NODE}/build/openbsd/libringrtc-${NODE_ARCH}.node
	# build ringrtc test
	cd ${RINGRTC_NODE} && env -i ${MAKE_ENV} yarn tsc
	# run ringrtc test
	mkdir -p ${WRKDIR}/.config/chromium
# XXX cp cookie from user env
	cp -R ~/.sndio ${WRKDIR}/
	cd ${RINGRTC_NODE} && env -i ${MAKE_ENV} DISPLAY=:1 \
		ELECTRON_PATH=${LOCALBASE}/bin/electron_nosandbox \
		yarn test

test-sticker-creator:
	# run sticker-creator test
	cd ${WRKSRC}/sticker-creator && env -i ${MAKE_ENV} \
		CI=ci yarn test

test-signal-desktop:
	# XXX Xvfb :1 &
	mkdir -p ${WRKDIR}/.config/chromium
	# setup electron wraper
	mkdir -p ${WRKSRC}/node_modules/.bin
	rm -rf ${WRKSRC}/node_modules/.bin/electron
	ln -fs ${LOCALBASE}/bin/electron_nosandbox \
		${WRKSRC}/node_modules/.bin/electron
	rm -rf ${WRKSRC}/dist/linux-unpacked/signal-desktop
	${SUBST_PROGRAM} ${FILESDIR}/signal-desktop \
		${WRKSRC}/dist/linux-unpacked/signal-desktop
	# copy libsignal native lib
	cd ${WRKSRC}/node_modules/@signalapp/mock-server/node_modules && \
		mkdir -p @signalapp/libsignal-client/build/Release && \
		cp ${MODCARGO_TARGET_DIR}/release/libsignal_node.so \
			@signalapp/libsignal-client/build/Release/node.napi.node
	# run signal-desktop test
	cd ${WRKSRC} && env -i ${TEST_ENV} DISPLAY=:1 \
		ELECTRON_PATH=${LOCALBASE}/bin/electron_nosandbox \
		yarn test
# XXX fake launch test from system or make one more wraper ?
	cd ${WRKSRC} && env -i ${TEST_ENV} DISPLAY=:1 \
		ELECTRON_PATH=${LOCALBASE}/bin/electron_nosandbox \
		yarn test-release
	cd ${WRKSRC} && env -i ${TEST_ENV} DISPLAY=:1 \
		ELECTRON_PATH=${LOCALBASE}/bin/electron_nosandbox \
		yarn test-mock
# XXX ts/util/asyncIterables.js
# SyntaxError: Unexpected token '['
	cd ${WRKSRC} && env -i ${TEST_ENV} DISPLAY=:1 \
		ELECTRON_PATH=${LOCALBASE}/bin/electron_nosandbox \
		ELECTRON_OVERRIDE_DIST_PATH=${WRKSRC}/node_modules/.bin \
		yarn test-node-coverage

### targets for port maintainer(s)

user-dev:
	cp ${WRKSRC}/config/{production,local-development}.json
	cd ${WRKSRC} && \
		NODE_ENV=development electron_nosandbox .

# XXX purpose ?
user-test:
	cd ${WRKSRC} && \
		NODE_ENV=test electron_nosandbox .

# XXX handle multiple cargo files
modcargo-gen-crates:
	@${_MAKE} extract >/dev/null 2>&1
	@echo '# run: make modcargo-gen-crates-licenses'
	@cat ${MODCARGO_CARGOS_TOML:toml=lock} | awk '\
		/^name = / { n=$$3; gsub("\"", "", n); } \
		/^version = / { v=$$3; gsub("\"", "", v); } \
		/^source = "registry\+https:\/\/github.com\/rust-lang\/crates\.io-index"/ \
			{ print "MODCARGO_CRATES +=	" n "	" v; }' | \
		sort | uniq

webrtc-deps:
	@${_MAKE} extract >/dev/null 2>&1
	# make webrtc-deps > webrtc.inc
	@echo "DIST_TUPLE+= \\"
.for _dst _name in ${WEBRTC_DEPS}
	@_id=$$(\
		grep -E '${_name:S|.-||:S|-|/|}(\.git)?@' \
			${WEBRTC_SRC}/DEPS | \
		awk -F '@' '{print $$2}' | \
		sed -e "s/',//" -e "s/'//") ; \
	if [ "${_name:S/.-//}" = "boringssl" ] ; then \
		printf 'boring %s %s . \\\n' "${_name:S/-/ /}" $$_id; \
	elif [ "${_name}" = "signalapp-opus" ] ; then \
		printf 'github %s %s . \\\n' "${_name:S/-/ /}" $$_id; \
	else \
		printf 'chrome %s %s . \\\n' "${_name:S/-/ /}" $$_id; \
	fi
.endfor
	@echo

chromium-patches:
	@${_MAKE} extract >/dev/null 2>&1
	# remember to update cvs co -D "..." if you change targeted version
	@if [ -d ${WRKDIR}/chromium ]; then \
		echo "${WRKDIR}/chromium exists, skip cvs co" ; \
	else \
		cd ${WRKDIR} && \
		cvs co -d chromium ports/www/chromium ; \
	fi
	# test chromium patches
	rm -rf ${WRKDIR}/patches
	mkdir -p ${WRKDIR}/patches/chromium{,.rej,.miss,.new}
	mkdir -p ${WRKDIR}/patches/webrtc
	@for p in ${WRKDIR}/chromium/patches/patch-*; do \
		if [[ $$p == *"third_party_webrtc"* ]]; then \
			cp $${p} ${WRKDIR}/patches/webrtc/$${p##*/} ; \
			p=${WRKDIR}/patches/webrtc/$${p##*/} ; \
			sed -i -e 's|third_party/webrtc/||g' $$p ; \
		fi ; \
		f=$$(grep 'Index' $$p | sed -e 's/.*: //' ) ; \
		if grep -q "@@ -0,0" $$p; then \
			cp $${p} ${WRKDIR}/patches/chromium/ ; \
			cp $${p} ${WRKDIR}/patches/chromium.new/ ; \
		elif [ -f "${WEBRTC_SRC}/$$f" ]; then \
			${PATCH} ${PATCH_DIST_ARGS} -sfC -z .orig.chromium \
				-d ${WEBRTC_SRC} < $${p} && \
				cp $${p} ${WRKDIR}/patches/chromium/ || \
				cp $${p} ${WRKDIR}/patches/chromium.rej/ ; \
		else \
			cp $${p} ${WRKDIR}/patches/chromium.miss/ ; \
		fi ; \
	done
	@echo "rejected:"
	@ls ${WRKDIR}/patches/chromium.rej
	# if ok, copy ${WRKDIR}/patches/chromium into port

# XXX import boringssl patches ?
# boringssl-fips-patches:
# 	@${_MAKE} extract >/dev/null 2>&1
# 	# remember to update cvs co -D "..." if you change targeted version
# 	@if [ -d ${WRKDIR}/boringssl ]; then \
# 		echo "${WRKDIR}/boringssl exists, skip cvs co" ; \
# 	else \
# 		cd ${WRKDIR} && \
# 		cvs co -d boringssl ports/security/boringssl/fips ; \
# 	fi
# 	# test chromium patches on top of electron patch (pre-patch)
# 	rm -rf ${WRKDIR}/patches
# 	mkdir -p ${WRKDIR}/patches/boringssl{,.rej,.miss,.new}
# 	@for p in ${WRKDIR}/boringssl/patches/patch-*; do \
# 		f=$$(grep 'Index' $$p | sed -e 's/.*: //' ) ; \
# 		if grep -q "@@ -0,0" $$p; then \
# 			cp $${p} ${WRKDIR}/patches/boringssl/ ; \
# 			cp $${p} ${WRKDIR}/patches/boringssl.new/ ; \
# 		elif [ -f "${BORINGSSL_SRC}/boringssl-fips/$$f" ]; then \
# 			${PATCH} ${PATCH_DIST_ARGS} -sfC -z .orig.boringssl \
# 				-d ${BORINGSSL_SRC}/boringssl-fips < $${p} && \
# 				cp $${p} ${WRKDIR}/patches/boringssl/ || \
# 				cp $${p} ${WRKDIR}/patches/boringssl.rej/ ; \
# 		else \
# 			cp $${p} ${WRKDIR}/patches/boringssl.miss/ ; \
# 		fi ; \
# 	done
# 	@echo "rejected:"
# 	@ls ${WRKDIR}/patches/boringssl.rej
# 	# if ok, copy ${WRKDIR}/patches/boringssl into port

sqlcipher:
	@${_MAKE} extract >/dev/null 2>&1
	# make sqlcipher
	@_src="node_modules/@signalapp/better-sqlite3/deps" ; \
	_uri=$$( \
		grep "const BASE_URI" ${WRKSRC}/$$_src/download.js | \
		awk -F '=' '{print $$2}' | \
		sed -e "s/ \`//" -e "s/\`;//") ; \
	_hash=$$( \
		grep "const HASH" ${WRKSRC}/$$_src/download.js | \
		awk -F '=' '{print $$2}' | \
		sed -e "s/ '//" -e "s/';//") ; \
	_sqlcipher_v=$$( \
		grep "const SQLCIPHER_VERSION" ${WRKSRC}/$$_src/download.js | \
		awk -F '=' '{print $$2}' | \
		sed -e "s/ '//" -e "s/';//") ; \
	_openssl_v=$$( \
		grep "const OPENSSL_VERSION" ${WRKSRC}/$$_src/download.js | \
		awk -F '=' '{print $$2}' | \
		sed -e "s/ '//" -e "s/';//") ; \
	_tokenizer_v=$$( \
		grep "const TOKENIZER_VERSION" ${WRKSRC}/$$_src/download.js | \
		awk -F '=' '{print $$2}' | \
		sed -e "s/ '//" -e "s/';//") ; \
	printf "SQLCIPHER_HASH=%s\n" $$_hash ; \
	printf "SQLCIPHER_V=\t\t%s--%s--%s-\$${SQLCIPHER_HASH}\n" \
		$$_sqlcipher_v $$_openssl_v $$_tokenizer_v ; \
	printf "SQLCIPHER_T=\t\t\$${WRKSRC}/%s\n" $$_src ; \
	printf "DISTFILES.sqlcipher=\tsqlcipher-\$${SQLCIPHER_V}.tar.gz\n" ; \
	printf "SITES.sqlcipher=\t%s/\n" $$_uri ; \
	printf "EXTRACT_CASES+=\t\t\$${DISTFILES.sqlcipher});;\n"

.include "modules.inc"

.include "crates.inc"

.include "webrtc.inc"

.include <bsd.port.mk>

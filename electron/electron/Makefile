# XXX no member named 'ToV8' in 'gin::Converter<unsigned long>' ?
# electron/shell/browser/api/electron_api_web_contents.cc

# XXX FilePath(NULL) segfault, strcmp 'electron' (was 'chrome')
# XXX handle error or crash early (which leed to this) ?
# base/process/process_handle_openbsd.cc

# XXX folder-hash looks broken on openbsd, skip SpecHash
# electron/script/spec-runner.js

# XXX openbsd use a wrapper, skip bin/electron check
# electron/spec/api-app-spec.ts

# XXX test crashReporter, check if its actually disabled from source ?
# not ok 709 -> 748
# electron/spec/disabled-tests.json

# XXX some other debug flags to play with (?)
# BUILDTYPE=Debug
# GN_FILE=testing.gn
# GN_ARGS+=is_debug=true
# GN_ARGS+=is_component_build=false
# GN_ARGS+=symbol_level=1
# GN_BOOTSTRAP_FLAGS+=--debug

# XXX annoying
# [13923:0221/203036.963735:ERROR:bus.cc(407)] Failed to connect to the bus: Could not parse server address: Unknown address type (examples of valid types are "tcp" and on UNIX "unix")

# XXX portcheck
#14 line(s) longer than 80 chars in Makefile
#extra directory: patches/chromium
#C++ libraries in WANTLIB with default COMPILER (most ports need 'COMPILER=base-clang ports-gcc' or 'COMPILER=base-clang ports-gcc base-gcc')

# XXX multi-versionning or one main version which all ports need to support ?
# need more app to learn from ecosystem

# XXX looks like we don't care about distfiles release to install apps
# wrong assumption : for ex, cypress needs it or a big hammer patch perhaps
# install all app into electron/resources/ (avoid duplicate electron bins)

# XXX start apps with --app= instead of a bundle electron copy
# runing command line without args bring a different config, diff ?

# XXX pledge & unveil integration
# pledge does not work on vscode (--no-sandbox)
# test does not pass without unveil "/ rwcx"
# need more app to learn from ecosystem

BROKEN-powerpc64=	Check failed: false. OS architecture not handled. (powerpc64)

USE_WXNEEDED=		Yes

DPB_PROPERTIES=		parallel parallel2
.if ${MACHINE_ARCH:Mi386}
DPB_PROPERTIES+=	lonesome
.endif

COMMENT=		cross-platform desktop applications
DIST_TUPLE=		github electron electron v${ELECTRON_V} .

CATEGORIES=		electron devel

HOMEPAGE=		https://www.electronjs.org/
MAINTAINER=		fabien@openbsd.org

# MIT
PERMIT_PACKAGE=		Yes

# uses pledge()
WANTLIB += ${COMPILER_LIBCXX} EGL FLAC GL X11 X11-xcb Xau Xcomposite
WANTLIB += Xcursor Xdamage Xdmcp Xext Xfixes Xft Xi Xinerama Xrandr
WANTLIB += Xrender Xtst Xxf86vm aom atk-1.0 atk-bridge-2.0 atspi
WANTLIB += brotlicommon brotlidec c cairo cairo-gobject cares
WANTLIB += cbor crc32c crypto cups dav1d dbus-1 double-conversion
WANTLIB += drm epoll-shim epoxy event execinfo expat ffi fido2
WANTLIB += fontconfig freetype fribidi gbm gdk-3 gdk_pixbuf-2.0
WANTLIB += gio-2.0 glib-2.0 gmodule-2.0 gobject-2.0 graphite2
WANTLIB += gthread-2.0 gtk-3 harfbuzz harfbuzz-gobject harfbuzz-subset
WANTLIB += icudata icui18n icuuc intl jpeg jsoncpp kvm lcms2 lzma
WANTLIB += m nghttp2 nspr4 nss3 nssutil3 ogg openh264 opus pango-1.0
WANTLIB += pangocairo-1.0 pangoft2-1.0 pcre2-8 pixman-1 plc4 plds4
WANTLIB += png re2 sharpyuv smime3 snappy sndio tiff usbhid util
WANTLIB += vpx wayland-client wayland-cursor wayland-egl webp
WANTLIB += webpdemux webpmux woff2common woff2dec xcb xcb-dri2
WANTLIB += xcb-glx xcb-render xcb-shm xkbcommon xml2 xshmfence
WANTLIB += xslt z zstd

# See electron/DEPS for versions, post-extract & pre-patch
CHROMIUM_V=			120.0.6099.291
NODE_V=				18.18.2
NAN_VER=			e14bdcd1f72d62bca1d541b66da43130384ec213
SQUIRREL_MAC_VER=		0e5d146ba13101a1302d59ea6e6e0b3cace4ae38
REACTIVEOBJC_VER=		74ab5baccc6f7202c8ac69a8d1e152c29dc1ea76
MANTLE_VER=			78d3966b3c331292ea29ec38661b25df0a245948
# See third_party/node/node_modules.tar.gz.sha1
CHROMIUM_NODE_MODULES_HASH=	bb991b26ccca36a9b3912b51dec5b70e5dea9aea
# See third_party/test_fonts/test_fonts.tar.gz.sha1
CHROMIUM_TEST_FONTS_HASH=	336e775eec536b2d785cc80eff6ac39051931286

# XXX fallback to freebsd distfiles
#DISTFILES.chromium=	chromium-${CHROMIUM_V}${EXTRACT_SUFX}
#SITES.chromium=		https://commondatastorage.googleapis.com/chromium-browser-official/
DISTFILES.chromium=	chromium-${CHROMIUM_V}.tar.xz
SITES.chromium=		https://github.com/tagattie/FreeBSD-Electron/releases/download/v28.2.4/
DISTFILES.nodemodule=	${CHROMIUM_NODE_MODULES_HASH}
SITES.nodemodule=	https://commondatastorage.googleapis.com/chromium-nodejs/
DISTFILES.fonts=	${CHROMIUM_TEST_FONTS_HASH}
SITES.fonts=		https://commondatastorage.googleapis.com/chromium-fonts/

DIST_TUPLE+=	github nodejs node v${NODE_V} third_party/electron_node
DIST_TUPLE+=	github nodejs nan ${NAN_VER} third_party/nan
DIST_TUPLE+=	github Squirrel Squirrel.Mac ${SQUIRREL_MAC_VER} third_party/squirrel.mac
DIST_TUPLE+=	github ReactiveCocoa ReactiveObjC ${REACTIVEOBJC_VER} third_party/squirrel.mac/vendor/ReactiveObjC
DIST_TUPLE+=	github Mantle Mantle ${MANTLE_VER} third_party/squirrel.mac/vendor/Mantle

# pre-patch electron > ALL_PATCHFILES > PATCH_LIST
.if empty(_MAKE_PATCHES)
ALL_PATCHFILES=	${PATCHDIR}/chromium/patch-* \
		${PATCHDIR}/node/patch-*
PATCH_CASES+=	${PATCHDIR}/chromium/patch-*) \
		    ${PATCH} ${PATCH_DIST_ARGS} \
		    -z .orig.chromium \
		    -d ${WRKSRC}/ <$$patchfile ;;
PATCH_CASES+=	${PATCHDIR}/node/patch-*) \
		    ${PATCH} ${PATCH_DIST_ARGS} \
		    -z .orig.node \
		    -d ${WRKSRC}/third_party/electron_node/ \
		    <$$patchfile ;;
PATCH_LIST=	patch-* chromium.local/patch-*
.else
# pre-patch only, see targets chromium-patches & node-patches
PATCH_LIST=
.endif

MODULES=	lang/python electron/electron

MODPY_RUNDEP=		No

MODELECTRON_BUILDDEP=	No
MODELECTRON_RUNDEP=	No
MODELECTRON_TESTDEP=	No

MODYARN_TARGETS=${WRKSRC}/electron ${WRKSRC}/electron/spec

# XXX LIB_DEPENDS devel/libnotify, BUILD|LIB ?
RUN_DEPENDS+=	devel/desktop-file-utils \
		devel/xdg-utils \
		fonts/noto/fonts \
		graphics/libexif \
		sysutils/libudev-openbsd \
		x11/gtk+3,-cups \
		x11/gtk+4,-guic
BUILD_DEPENDS+=	archivers/bzip2 \
		devel/bison \
		devel/gperf \
		devel/libnotify \
		devel/yarn \
		lang/node \
		shells/bash \
		sysutils/flock \
		sysutils/pciutils \
		devel/ninja \
		x11/py-xcbgen${MODPY_FLAVOR} \
		${MODGCC4_CPPDEP} \
		${RUN_DEPENDS}
LIB_DEPENDS+=	archivers/snappy \
		archivers/woff2 \
		audio/flac \
		audio/opus \
		devel/crc32c \
		devel/jsoncpp \
		devel/pango \
		graphics/jpeg \
		graphics/lcms2 \
		graphics/libwebp \
		graphics/png \
		graphics/tiff \
		math/double-conversion \
		multimedia/aom \
		multimedia/dav1d \
		multimedia/libvpx \
		multimedia/openh264 \
		net/libcares \
		security/nss \
		textproc/icu4c \
		textproc/libxml \
		textproc/libxslt \
		textproc/re2 \
		www/nghttp2 \
		x11/gnome/at-spi2-core \
		x11/gtk+3,-main \
		x11/xkbcommon \
		print/cups,-libs \
		${MODGCC4_CPPLIBDEP}
TEST_DEPENDS+=	devel/py-dbusmock \
		x11/dbus-python \
		devel/py-gobject3 \
		devel/glib2

USE_GMAKE=	Yes

DEBUG_PACKAGES=	${BUILD_PACKAGES}

.include <bsd.own.mk>

SUBST_VARS+=	WRKSRC WRKDIR

ALL_TARGET=		electron \
			electron:node_headers \
			chromedriver
# XXX also include *zip build targets ? required for building apps ?
# XXX missing chromedriver(.debug), manual STRIP in post-build ?
# XXX looks like we don't care about distfiles release to install apps, remove ?
POST_BUILD_TARGET=	licenses \
			version \
			electron_dist_zip \
			electron_mksnapshot_zip \
			electron_chromedriver_zip

DIST_TARGET_DIR=	electron

# Collect all DISTS under 'src'
WRKDIST=		${WRKDIR}/src
WRKSRC=			${WRKDIR}/src

# These libraries are used from the system and the build infrastructure
# removes them from the bundled third_party directory and replaces them
# with hooks to use them from the system.
GN_SYSTEM_LIBS=	crc32c \
		dav1d \
		double-conversion \
		flac \
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
		opus \
		re2 \
		snappy \
		woff2
GN_ARGS=	use_system_libjpeg=true \
		use_system_harfbuzz=true \
		use_system_cares=true \
		use_system_nghttp2=true
# pdfium
GN_ARGS+=	use_system_lcms2=true \
		use_system_libpng=true \
		use_system_libtiff=true \
		use_system_zlib=true

GN_ARGS+=	enable_nacl=false \
		enable_remoting=false \
		enable_hangout_services_extension=true \
		enable_rust=false \
		use_kerberos=false \
		icu_use_data_file=false \
		use_sysroot=false \
		treat_warnings_as_errors=false \
		clang_use_chrome_plugins=false \
		use_allocator_shim=false \
		enable_backup_ref_ptr_support=false \
		disable_fieldtrial_testing_config=true \
		extra_cppflags=\"-idirafter ${LOCALBASE}/include -idirafter ${X11BASE}/include\" \
		fatal_linker_warnings=false \
		use_custom_libcxx=false \
		use_bundled_fontconfig=false
# XXX notyet
GN_ARGS+=	use_vaapi=false

.if ${MACHINE_ARCH} == "aarch64"
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib\"
PKG_ARGS+=	-Dswiftshader=0
FFMPEG_TARGET=	arm64
.elif ${MACHINE_ARCH} == "amd64"
BUILD_DEPENDS+=	devel/nasm
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib\"
PKG_ARGS+=	-Dswiftshader=1
FFMPEG_TARGET=	x64
.elif ${MACHINE_ARCH} == "i386"
BUILD_DEPENDS+=	devel/nasm
GN_ARGS+=	extra_ldflags=\"-L${LOCALBASE}/lib -L${X11BASE}/lib -Wl,--no-keep-memory\"
PKG_ARGS+=	-Dswiftshader=1
FFMPEG_TARGET=	ia32
.else
PKG_ARGS+=	-Dswiftshader=0
.endif

FFMPEG_BRAND=	Chrome
FFMPEG_BDIR=	${WRKSRC}/build.${FFMPEG_TARGET}.openbsd/${FFMPEG_BRAND}
FFMPEG_CDIR=	${WRKSRC}/third_party/ffmpeg/chromium/config/${FFMPEG_BRAND}/openbsd/${FFMPEG_TARGET}

GN_ARGS+=	ffmpeg_branding=\"${FFMPEG_BRAND}\" \
		proprietary_codecs=true

# XXX dwz doesn't work with chromium yet
# dwz: .debug/electron.dbg: Too many DIEs, not optimizing
DWZ = :

# always build with symbol, bsd.port.mk will strip
GN_ARGS+=	symbol_level=1
# always link static into bin, no component
GN_ARGS+=	is_component_build=false \
		is_component_ffmpeg=false
# do not use lto, otherwise it needs -fno-ret-protector & -mno-retpoline
GN_ARGS+=	use_thin_lto=false \
		thin_lto_enable_optimizations=true

GN_ARGS+=	override_electron_version=\"${ELECTRON_V}\"

# XXX need chrome-linux-${CHROMIUM_V}-llvm<XX>.profdata${EXTRACT_SUFX}
GN_ARGS+=	chrome_pgo_phase=0

BUILDTYPE=		Release
BUILDDIR=		${WRKSRC}/out/${BUILDTYPE}
GN_FILE=		release.gn
GN_BOOTSTRAP_FLAGS=	--skip-generate-buildfiles
ELECTRON_PATCH=		${WRKSRC}/electron/patches/config.json

post-extract:
	# setup distfiles into src
	mv ${WRKDIR}/chromium-${CHROMIUM_V} ${WRKSRC}
	mv ${WRKDIR}/electron-${ELECTRON_V} ${WRKSRC}/electron
	mv ${WRKDIR}/node_modules ${WRKSRC}/third_party/node/node_modules
	mv ${WRKDIR}/test_fonts ${WRKSRC}/third_party/test_fonts
	# see DIST_TUPLE for other depends
	# early patch, for pre-patch
	for p in ${PATCHDIR}/post_extract/patch-*; do \
		${PATCH} ${PATCH_DIST_ARGS} \
		-z .orig.post_extract \
		-d ${WRKSRC} < $${p}; \
	done

pre-patch:
	# apply electron patches
	@for _pair in $$(grep ':' ${ELECTRON_PATCH} | cut -f 4,8 -d '"' ); do \
		_from=${WRKDIR}/$$(echo $${_pair} | cut -f 1 -d '"') ; \
		_to=${WRKDIR}/$$(echo $${_pair} | cut -f 2 -d '"') ; \
		for _p in $$(cat $${_from}/.patches); do \
			echo "Apply $${_from}/$${_p} into $${_to}"; \
			${PATCH} -f -p1 -z .orig.electron \
				-d $${_to} -i $${_from}/$${_p}; \
			grep -R '^rename' $${_from}/$${_p} | \
				cut -f 3 -d ' ' | xargs -r -L2 sh -c \
				"cd $${_to} && mv \$$@" mv ; \
		done ; \
	done

pre-configure:
	@ln -sf ${MODPY_BIN} ${WRKDIR}/bin/python
	@ln -sf ${LOCALBASE}/bin/llvm-ar-${MODCLANG_VERSION} ${WRKDIR}/bin/ar
	cd ${WRKSRC}/third_party/ffmpeg && \
		${MODPY_BIN} chromium/scripts/build_ffmpeg.py \
		openbsd ${FFMPEG_TARGET} --config-only \
		--branding=${FFMPEG_BRAND}
	cd ${FFMPEG_BDIR} && ${GMAKE} ffversion.h
	${INSTALL_DATA_DIR} ${FFMPEG_CDIR}
.for _e in config.h config.asm config_components.h libavcodec libavformat libavutil
	-cp -pR ${FFMPEG_BDIR}/${_e} ${FFMPEG_CDIR}
.endfor
	@mkdir -p ${WRKSRC}/third_party/node/openbsd/node-openbsd/bin
	@ln -sf ${LOCALBASE}/bin/node \
		${WRKSRC}/third_party/node/openbsd/node-openbsd/bin/node
	${SUBST_CMD} \
		${WRKSRC}/build/gn_run_binary.py \
		${WRKSRC}/v8/tools/run.py \
		${WRKSRC}/tools/protoc_wrapper/protoc_wrapper.py \
		${WRKSRC}/third_party/blink/renderer/build/scripts/run_with_pythonpath.py
	${SUBST_CMD} \
		${WRKSRC}/third_party/electron_node/src/env.cc

# Configuration consists of three steps:
# 1. replace the specified bundled libraries with hooks to use the system libs
# 2. bootstrap gn, the tool to generate ninja files
# 3. run gn with the appropriate configuration arguments
do-configure:
	cd ${WRKSRC} && env -i ${MAKE_ENV} \
		build/linux/unbundle/replace_gn_files.py \
		--system-libraries ${GN_SYSTEM_LIBS}
	cd ${WRKSRC}/tools/gn && env -i ${MAKE_ENV} \
		LDFLAGS=-L${LOCALBASE}/lib ${MODPY_BIN} \
		bootstrap/bootstrap.py --no-clean -s ${GN_BOOTSTRAP_FLAGS}
	cd ${WRKSRC} && env -i ${CONFIGURE_ENV} \
		${WRKSRC}/out/${BUILDTYPE}/gn gen out/${BUILDTYPE} \
		--args="import(\"//electron/build/args/${GN_FILE}\") ${GN_ARGS}"

do-build:
	@cd ${WRKSRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/${BUILDTYPE} ${ALL_TARGET}
	@cd ${WRKSRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/${BUILDTYPE} ${ALL_TARGET} \
		-t compdb > compile_commands.json

post-build:
# XXX need chromedriver.debug & chromedriver for electron_chromedriver_zip
	${STRIP} -o ${WRKSRC}/out/${BUILDTYPE}/chromedriver \
		${WRKSRC}/out/${BUILDTYPE}/chromedriver.unstripped
	${STRIP} --only-keep-debug \
		-o ${WRKSRC}/out/${BUILDTYPE}/chromedriver.debug \
		${WRKSRC}/out/${BUILDTYPE}/chromedriver.unstripped
	@cd ${WRKSRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/${BUILDTYPE} ${POST_BUILD_TARGET}
	@cd ${WRKSRC} && env -i ${MAKE_ENV} \
		ninja -j ${MAKE_JOBS} -C out/${BUILDTYPE} ${POST_BUILD_TARGET} \
		-t compdb >> compile_commands.json
# XXX looks like we don't care about distfiles release to install apps, remove ?
	@cd ${BUILDDIR} && cp chromedriver.zip \
		chromedriver-v${ELECTRON_V}-openbsd-${ELECTRON_ARCH}.zip
	@cd ${BUILDDIR} && cp dist.zip \
		electron-v${ELECTRON_V}-openbsd-${ELECTRON_ARCH}.zip
	@cd ${BUILDDIR} && cp mksnapshot.zip \
		mksnapshot-v${ELECTRON_V}-openbsd-${ELECTRON_ARCH}.zip
	@cd ${BUILDDIR} && sha256 -r *-v${ELECTRON_V}-openbsd-*.zip | \
		sed -e 's/ / */' > SHASUMS256.txt

do-install:
# XXX do we want all those files ?
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}
.for f in electron mksnapshot v8_context_snapshot_generator
	${INSTALL_PROGRAM} ${BUILDDIR}/${f} \
		${PREFIX}/${DIST_TARGET_DIR}
.endfor
	${SUBST_PROGRAM} ${FILESDIR}/electron \
		${PREFIX}/bin/electron
	${SUBST_PROGRAM} ${FILESDIR}/electron_nosandbox \
		${PREFIX}/bin/electron_nosandbox
	${INSTALL_PROGRAM} ${BUILDDIR}/chromedriver.unstripped \
		${PREFIX}/${DIST_TARGET_DIR}/chromedriver
	# copy .pak
	${INSTALL_DATA} ${BUILDDIR}/*.pak ${PREFIX}/${DIST_TARGET_DIR}
	# copy locales & ressources
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/locales
	${INSTALL_DATA} ${BUILDDIR}/locales/* \
		${PREFIX}/${DIST_TARGET_DIR}/locales
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/resources
# XXX permission ? no INSTALL* fn ? chown ? chmod o-w ?
	cp -Rp ${BUILDDIR}/resources/* ${PREFIX}/${DIST_TARGET_DIR}/resources
	@chown -R ${SHAREOWN}:${SHAREGRP} ${PREFIX}/${DIST_TARGET_DIR}/resources
	# ANGLE, EGL, Vk, ...
.for f in libEGL libGLESv2 libvk_swiftshader libVkICD_mock_icd
	${INSTALL_DATA} ${BUILDDIR}/${f}.so ${PREFIX}/${DIST_TARGET_DIR}
.endfor
	${INSTALL_DATA} ${BUILDDIR}/libvulkan.so.1 \
		${PREFIX}/${DIST_TARGET_DIR}/libvulkan.so
.if ${MACHINE_ARCH} != "aarch64"
	# SwiftShader
	${INSTALL_DATA} ${BUILDDIR}/libvk_swiftshader.so \
		${PREFIX}/${DIST_TARGET_DIR}
.endif
	# sandbox, unveil & pledge
	${INSTALL_DATA_DIR} ${PREFIX}/share/examples/electron
	${INSTALL_DATA} ${FILESDIR}/unveil.gpu ${PREFIX}/share/examples/electron
.for f in main utility_audio utility_network utility_video
	${INSTALL_DATA} ${FILESDIR}/{pledge,unveil}.${f} ${PREFIX}/share/examples/electron
.endfor
	# data
.for f in LICENSE LICENSES.chromium.html protoc snapshot_blob.bin \
    v8_context_snapshot.bin version vk_swiftshader_icd.json
	${INSTALL_DATA} ${BUILDDIR}/${f} ${PREFIX}/${DIST_TARGET_DIR}
.endfor
	# electron
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/node_headers
# XXX permission ? no INSTALL* fn ? chown ? chmod o-w ?
	cp -Rp ${BUILDDIR}/gen/node_headers/* \
		${PREFIX}/${DIST_TARGET_DIR}/node_headers
	@chown -R ${SHAREOWN}:${SHAREGRP} \
		${PREFIX}/${DIST_TARGET_DIR}/node_headers
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/gen/electron/buildflags
	${INSTALL_DATA} ${BUILDDIR}/gen/electron/buildflags/* \
		${PREFIX}/${DIST_TARGET_DIR}/gen/electron/buildflags
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/gen/v8
	${INSTALL_DATA} ${BUILDDIR}/gen/v8/embedded.S \
		${PREFIX}/${DIST_TARGET_DIR}/gen/v8/embedded.S
	# release
# XXX looks like we don't care about distfiles release to install apps, remove ?
	${INSTALL_DATA_DIR} ${PREFIX}/${DIST_TARGET_DIR}/releases
	${INSTALL_DATA} ${BUILDDIR}/SHASUMS256.txt \
		${PREFIX}/${DIST_TARGET_DIR}/releases
	${INSTALL_DATA} ${BUILDDIR}/*-v${ELECTRON_V}-openbsd-*.zip \
		${PREFIX}/${DIST_TARGET_DIR}/releases

do-test:
	# XXX --no-sandbox (hard to setup, not tested)
	# XXX unveil "/ rwcx" (/etc/electron/unveil.main)
	# XXX Xvfb :1 &
	rm -rf ${WRKDIR}/.config
	mkdir -p ${WRKDIR}/.config/Electron
	ulimit -Sn `ulimit -Hn`
	ulimit -Sd `ulimit -Hd`
	cd ${WRKSRC}/electron && env -i ${TEST_ENV} \
		ELECTRON_OUT_DIR=${BUILDTYPE} LOCAL_GIT_DIRECTORY=${LOCALBASE} \
		LD_LIBRARY_PATH="${LOCALBASE}/electron" \
		DISPLAY=:1 \
		npm run test -- --ci

### targets for port maintainer(s)

chromium-patches:
	@env _MAKE_PATCHES=yes ${_MAKE} patch >/dev/null 2>&1
	# remember to update cvs co -D "..." if you change targeted version
	@if [ -d ${WRKDIR}/chromium ]; then \
		echo "${WRKDIR}/chromium exists, skip cvs co" ; \
	else \
		cd ${WRKDIR} && \
		cvs co -D "2024-01-18" -d chromium ports/www/chromium ; \
	fi
	# test chromium patches on top of electron patch (pre-patch)
	rm -rf ${WRKDIR}/patches
	mkdir -p ${WRKDIR}/patches/chromium{,.rej,.miss,.new}
	@for p in ${WRKDIR}/chromium/patches/patch-*; do \
		f=$$(grep 'Index' $$p | sed -e 's/.*: //' ) ; \
		if grep -q "@@ -0,0" $$p; then \
			cp $${p} ${WRKDIR}/patches/chromium/ ; \
			cp $${p} ${WRKDIR}/patches/chromium.new/ ; \
		elif [ -f "${WRKSRC}/$$f" ]; then \
			${PATCH} ${PATCH_DIST_ARGS} -sfC -z .orig.chromium \
				-d ${WRKSRC} < $${p} && \
				cp $${p} ${WRKDIR}/patches/chromium/ || \
				cp $${p} ${WRKDIR}/patches/chromium.rej/ ; \
		else \
			cp $${p} ${WRKDIR}/patches/chromium.miss/ ; \
		fi ; \
	done
	@echo "rejected:"
	@ls ${WRKDIR}/patches/chromium.rej
	# if ok, copy ${WRKDIR}/patches/chromium into port && make clean

node-patches:
	@env _MAKE_PATCHES=yes ${_MAKE} patch >/dev/null 2>&1
	# remember to update cvs co -D "..." if you change targeted version
	@if [ -d ${WRKDIR}/node ]; then \
		echo "${WRKDIR}/node exists, skip cvs co" ; \
	else \
		cd ${WRKDIR} && \
		cvs co -d node ports/lang/node ; \
	fi
	# test node patches on top of electron patch (pre-patch)
	mkdir -p ${WRKDIR}/patches/node{,.rej}
	@for p in ${WRKDIR}/node/patches/patch-*; do \
		${PATCH} ${PATCH_DIST_ARGS} -sfC -z .orig.node \
			-d ${WRKSRC}/third_party/electron_node/ < $${p} && \
			cp $${p} ${WRKDIR}/patches/node/ || \
			cp $${p} ${WRKDIR}/patches/node.rej/ ; \
	done
	@echo "rejected:"
	@ls ${WRKDIR}/patches/node.rej
	# remember to copy ${WRKDIR}/patches/node/ into port && make clean

# XXX WIP, belt with suspenders : checks for defaults GN args
GN_ARGS_DEFAULTS=	use_system_libdrm true
gn_args-check:
	@${_MAKE} configure >/dev/null 2>&1
	# remember to check ${WRKDIR}/gn_args.list
	cd ${WRKSRC} && env -i ${CONFIGURE_ENV} \
		${WRKSRC}/out/${BUILDTYPE}/gn args out/${BUILDTYPE} \
		--list > ${WRKDIR}/gn_args.list
	# check some defaults are still the same
.for _arg _value in ${GN_ARGS_DEFAULTS}
	@grep -A1 ${_arg} ${WRKDIR}/gn_args.list | grep -q ${_value} || \
		echo "Wrong" $$(grep -A1 ${_arg} ${WRKDIR}/gn_args.list)
.endfor

.include "modules.inc"

.include <bsd.port.mk>

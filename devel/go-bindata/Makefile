COMMENT =	generates Go code from any file

DIST_TUPLE =	github go-bindata go-bindata v3.1.2 .

CATEGORIES =	devel

MAINTAINER =	fabien@openbsd.org

# CC0-1.0
PERMIT_PACKAGE=	Yes

MODULES =	lang/go

ALL_TARGET =	github.com/go-bindata/go-bindata

do-build:
	cd ${WRKSRC} && ${MODGO_CMD} build ${MODGO_FLAGS} \
	    -o ${MODGO_WORKSPACE}/bin/go-bindata ./go-bindata

.include <bsd.port.mk>

COMMENT =	generic helper tool to build app in a distributable format

MODGO_MODNAME =	github.com/develar/app-builder
MODGO_VERSION =	v0.0.0-20230912090615-0bc38fb5e76c

DISTNAME =	app-builder-v4.2.0

CATEGORIES =	devel

MAINTAINER=	fabien@openbsd.org

# MIT
PERMIT_PACKAGE=	Yes

WANTLIB += c pthread

# required to make assets
BUILD_DEPENDS+=	devel/go-bindata

TEST_DEPENDS+=	lang/node devel/pnpm devel/yarn

MODULES =	lang/go

USE_GMAKE=	Yes

WRKDIST =	${WRKSRC}

pre-build:
# XXX assets actually required ? (depends on go-bindata)
	cd ${WRKSRC} && env -i ${MAKE_ENV} ${GMAKE} assets

do-test:
	cd ${WRKSRC}/pkg/node-modules/npm-demo && \
		env -i ${MAKE_ENV} HOME=${WRKDIR} \
		npm ci
	cd ${WRKSRC}/pkg/node-modules/pnpm-demo && \
		env -i ${MAKE_ENV} HOME=${WRKDIR} \
		pnpm install --frozen-lockfile
	cd ${WRKSRC}/pkg/node-modules/yarn-demo && \
		env -i ${MAKE_ENV} HOME=${WRKDIR} \
		yarn install --frozen-lockfile
	cd ${WRKSRC} && ${MODGO_CMD} test ./pkg/...
	chmod -R u+w ${MODGO_WORKSPACE}/pkg/mod

.include "modules.inc"

.include <bsd.port.mk>

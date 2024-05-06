MODNPM_DIST=	npm_modules

MODNPM_OMITDEV?=	No # omit dev depends
MODNPM_OMITOPTIONAL?=	No # omit optional depends
MODNPM_INCLUDES?= 	# include package
# XXX MODNPM_LOCK(s), handle one file only
MODNPM_LOCKS ?=		${WRKSRC}/package-lock.json

MODNPM_NPM_MOD=${LOCALBASE}/lib/node_modules/npm
MODNPM_GYP_BIN=${MODNPM_NPM_MOD}/node_modules/node-gyp/bin/node-gyp.js

SITES.npm ?=	https://registry.npmjs.org/

TEMPLATE_DISTFILES.npm ?= \
	${MODNPM_DIST}/<account>-{<account>/<project>/-/}<project>-<id>.tgz

# XXX use FIX_EXTRACT_PERMISSIONS instead of chmod ? need to (re)find culprit
EXTRACT_CASES +=	${MODNPM_DIST}/*.tgz) \
	_filename=$${archive\#\#*/} && \
	${GZIP_CMD} -d <${FULLDISTDIR}/$$archive | ${TAR} -xf - -- && \
	mv "`${TAR} -ztf ${FULLDISTDIR}/$$archive | \
		awk -F/ '{print $$1}' | uniq`" $${_filename%.tgz} && \
	chmod -R a+x $${_filename%.tgz};;

MAKE_ENV += http_proxy=invalid://ports.should.not.fetch.at.buildtime/
MAKE_ENV += https_proxy=invalid://ports.should.not.fetch.at.buildtime/

.if !empty(MODNPM_MV)
.  for _src _dst in ${MODNPM_MV}
# XXX MODELECTRON until proper NPM integration into ports
MODELECTRON_post-extract += \
	t=`dirname ${WRKSRC}/${_dst}`; \
	[[ -d $$t ]] || mkdir -p $$t ; \
	mv ${WRKDIR}/${_src} ${WRKSRC}/${_dst} ;
.  endfor
.endif

.if !empty(MODNPM_CP)
.  for _dst _src in ${MODNPM_CP}
# XXX MODELECTRON until proper NPM integration into ports
MODELECTRON_post-extract += \
	t=`dirname ${WRKSRC}/node_modules/${_dst}`; \
	[[ -d $$t ]] || mkdir -p $$t ; \
	cp -Rp ${WRKSRC}/${_src} ${WRKSRC}/node_modules/${_dst} ;
.  endfor
.endif

# XXX MODELECTRON until proper NPM integration into ports
MODELECTRON_post-extract += rm -rf ${WRKSRC}/.npm ;

# XXX path to npm_dist
# XXX implement MODNPM_LOCKS (multiple files) ?
.if !target(modnpm-gen-modules)
modnpm-gen-modules:
	@if [ ! -d ${WRKSRC} ]; then ${_MAKE} extract >/dev/null 2>&1 ; fi
	# make modnpm-gen-modules > modules.inc
	# MODNPM_OMITDEV=${MODNPM_OMITDEV}
	# MODNPM_OMITOPTIONAL=${MODNPM_OMITOPTIONAL}
	# MODNPM_INCLUDES=${MODNPM_INCLUDES}
	@/usr/ports/mystuff/electron/electron/modules/npm_dist \
		${MODNPM_OMITDEV:S/Yes/-d/:S/No//} \
		${MODNPM_OMITOPTIONAL:S/Yes/-o/:S/No//} \
		${MODNPM_INCLUDES:='-i %'} \
		${MODNPM_LOCKS}
.endif

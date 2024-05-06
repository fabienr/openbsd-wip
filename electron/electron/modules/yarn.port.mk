MODYARN_DIST=		yarn_modules

MODYARN_CACHE?=		${WRKDIR}/.yarn
MODYARN_TARGETS?=	${WRKSRC}
MODYARN_LOCKS?=		${MODYARN_TARGETS:=%/yarn.lock}

SITES.yarn?=		https://registry.yarnpkg.com/
SITES.yarn_npm?=	https://registry.npmjs.org/
SITES.yarn_github?=	${SITES.github}
SITES.yarn_codeload?=	${SITES.github}

TEMPLATE_DISTFILES.yarn?= \
	${MODYARN_DIST}/<account>-{<account>/<project>/-/}<project>-<id>.tgz
TEMPLATE_DISTFILES.yarn_npm = ${TEMPLATE_DISTFILES.yarn}
TEMPLATE_DISTFILES.yarn_github?= \
	${MODYARN_DIST}/${TEMPLATE_DISTFILES.github:S/>-</>%</:S/-{/.git-{/}
TEMPLATE_DISTFILES.yarn_codeload?= \
	${MODYARN_DIST}/${TEMPLATE_DISTFILES.github:S/-{/%{/}

EXTRACT_CASES+=		${MODYARN_DIST}/*.git-*) \
	_filename=$$(echo $${archive\#\#*/} | \
		sed -e '/%/s/${EXTRACT_SUFX.github}//' \
		-e '/%/s/.*%//' -e 's/\.-//') && \
	_module=$$(${TAR} -ztf ${FULLDISTDIR}/$$archive | \
		awk -F/ '{print $$1}' | uniq) && \
	mkdir -p ${MODYARN_CACHE} && \
	${GZIP_CMD} -d <${FULLDISTDIR}/$$archive | ${TAR} -xf - -- && \
	${TAR} -cf ${MODYARN_CACHE}/$$_filename -C $$_module ./ && \
	rm -rf $$_module \
	;;

EXTRACT_CASES+=		${MODYARN_DIST}/*) \
	_filename=$$(echo $${archive\#\#*/} | \
		sed -e '/%/s/${EXTRACT_SUFX.github}//' \
		-e '/%/s/.*%//' -e 's/\.-//') && \
	mkdir -p ${MODYARN_CACHE} && \
	ln -fs ${FULLDISTDIR}/$$archive \
		${MODYARN_CACHE}/$$_filename \
	;;

MAKE_ENV+=	http_proxy=invalid://ports.should.not.fetch.at.buildtime/
MAKE_ENV+=	https_proxy=invalid://ports.should.not.fetch.at.buildtime/

# XXX MODELECTRON until proper YARN integration into ports
# XXX if ... needed until proper YARN integration into ports
# XXX would be easier for porters if DIST_TUPLE_post-extract ran before
MODELECTRON_post-extract+= \
	if [ -e ${MODYARN_CACHE} ]; then \
		echo 'yarn-offline-mirror "${MODYARN_CACHE}"' >> \
			${PORTHOME}/.yarnrc ; \
		for _target in ${MODYARN_TARGETS}; do \
			cd $$_target && env -i ${MAKE_ENV} \
			yarn install --frozen-lockfile --offline \
			--ignore-scripts --ignore-engines ; \
		done ; \
	fi ;

#--ignore-optional

# XXX path to yarn_dist
# XXX simple grep resolved | ... sh script ?
.if !target(modyarn-gen-modules)
modyarn-gen-modules:
	@if [ ! -d ${WRKSRC} ]; then ${_MAKE} extract >/dev/null 2>&1 ; fi
	# make modyarn-gen-modules > modules.inc
	@/usr/ports/mystuff/electron/electron/modules/yarn_dist \
		${MODYARN_LOCKS}
.endif

.if !target(modyarn-vendor-cache)
modyarn-vendor-cache:
	@if [ ! -d ${WRKSRC} ]; then ${_MAKE} extract >/dev/null 2>&1 ; fi
	@echo 'yarn-offline-mirror "${MODYARN_CACHE}"' >> \
		${PORTHOME}/.yarnrc
	@if [ -d ${MODYARN_CACHE} ]; then \
		rm -rf ${MODYARN_CACHE} ; \
	fi
	for _target in ${MODYARN_TARGETS}; do \
		cd $$_target && rm -rf node_modules && env -i HOME=${PORTHOME} \
			yarn install --frozen-lockfile \
			--ignore-scripts --ignore-engines ; \
	done
	@tar cvzf ${WRKDIR}/${DISTNAME}_vendor.tgz ${MODYARN_CACHE}
	@ls ${WRKDIR}/${DISTNAME}_vendor.tgz
.endif

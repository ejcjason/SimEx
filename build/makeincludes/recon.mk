RECON=recon
RECON_DIR = ${PACKAGES}/${RECON}
RECON_SRC_DIR=${SRC}/${RECON}

${RECON}: ${HDF5_SRC_DIR}/install.stamp \
	${RECON_SRC_DIR}/install.stamp

${PACKAGES}/${RECON}_package.stamp:
	@echo "\nFetching ${RECON}."
	cd ${PACKAGES} && \
	wget https://db.tt/8CTthFkw -O ${RECON}.tar.gz
	touch $@
	@echo "Fetched ${RECON}.\n"

${RECON_SRC_DIR}/unpack.stamp: ${PACKAGES}/${RECON}_package.stamp
	@echo "\nUnpacking ${RECON}."
	if [ ! -d ${RECON_SRC_DIR} ]; then \
		mkdir ${RECON_SRC_DIR}; \
	fi
	cd ${RECON_SRC_DIR} && \
	tar xzvf ${PACKAGES}/${RECON}.tar.gz && \
	touch $@
	@echo "Unpacked ${RECON}.\n"


${RECON_SRC_DIR}/build.stamp:${RECON_SRC_DIR}/unpack.stamp
	@echo "\nBuilding ${RECON}."
	cd ${RECON_SRC_DIR}/s2e_recon/EMC_Src && \
	./compile_EMC && \
	cd ${RECON_SRC_DIR}/s2e_recon/DM_Src && \
	./compile_DM && \
	touch $@
	@echo "Built ${RECON}.\n"


${RECON_SRC_DIR}/install.stamp:${RECON_SRC_DIR}/build.stamp
	@echo "\nInstalling ${RECON}."
	cd ${RECON_SRC_DIR}/s2e_recon/EMC_Src && \
	cp -av EMC ${PREFIX_DIR}/bin && \
	cp -av quaternions ${ROOT}/python/src/SimEx/Calculators/CalculatorUtilities && \
	cp -av runEMC.py ${PYPATH} && \
	mkdir -p ${PYPATH}/supp_py_modules && \
	cp -av supp_py_modules/*.py ${PYPATH}/supp_py_modules && \
	cp -av supp_py_modules/*.so ${PYPATH}/supp_py_modules && \
	cd ${RECON_SRC_DIR}/s2e_recon/DM_Src && \
	cp -av object_recon ${PREFIX_DIR}/bin && \
	cp -av runDM.py ${PYPATH}
	touch $@
	@echo "Installed ${RECON}.\n"

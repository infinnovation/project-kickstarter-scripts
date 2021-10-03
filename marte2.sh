#!/usr/bin/env bash

# Automate but also document, the dependencies for installing MARTe2 on various platforms.
#
# Primary assumption is that we have some kind of Linux
#
# TODO: see if there exists an existing project that maps generic requirements into 
#       distribution specific requirements.
#
# TODO: create some help utilities in python, or perhaps use Cmake ???
#
# Note that all the git setup machinery can be simply stepped around by performing a git fork on 
# a suitable template repository.

# WIBNI : vim indentation for filetype=sh just worked properly on this script as I expect ???
#
# TODO: clean up via shellcheck

submodule_register_marte2-dev_f4e () {
git submodule add https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2.git  MARTe2-dev
}
submodule_register_marte2-components_f4e () {
git submodule add https://vcis-gitlab.f4e.europa.eu/aneto/MARTe2-components.git 
}

submodule_register_marte2-dev_github () {
git submodule add https://github.com/aneto0/MARTe2.git  MARTe2-dev
}
submodule_register_marte2-components_github () {
git submodule add https://github.com/aneto0/MARTe2-components.git 
}

submodule_register_marte2-dev_inf () {
git submodule add https://github.com/infinnovation/MARTe2.git  MARTe2-dev
}
submodule_register_marte2-components_inf () {
git submodule add https://github.com/infinnovation/MARTe2-components.git 
}


marte2_clone() {
	if false; then
	mkdir MARTe2-F4E && cd $_
	git init .
	submodule_register_marte2-dev_f4e
	submodule_register_marte2-components_f4e
	cd ..
	fi

	if false; then
	mkdir MARTe2-GITHUB && cd $_
	git init .
	submodule_register_marte2-dev_github
	submodule_register_marte2-components_github
	cd ..
	fi

	if true; then
	TARGET=MARTe2-INF
	if [ -d ${TARGET} ]
	then
		echo "Assume existing ${TARGET} already configured"
	else
	mkdir MARTe2-INF && cd $_
	git init .
	submodule_register_marte2-dev_inf
	submodule_register_marte2-components_inf
	cd ..
	fi
	fi
}



marte2_build() {
	TOPLEVEL=$1
	ARCH=$2
	cd ${TOPLEVEL}
	echo "working in $(pwd)"
	cp ../../envsetup.sh .
	pushd MARTe2-dev
	git checkout develop-${ARCH}-linux
	echo "building in $(pwd)"
	make -f Makefile.${ARCH}-linux > make.${ARCH}-linux 2>&1
	popd
	pushd MARTe2-components
	git checkout develop-${ARCH}-linux
	. ../envsetup.sh
	echo "building in $(pwd)"
	make -f Makefile.${ARCH}-linux > make.${ARCH}-linux 2>&1
	popd
	cd ..
}

date

# Main actions
	if true; then 
TARGET=MARTe2-F4E
if [ -d ${TARGET} ]
then
	echo "${TARGET} exists."
	exit 0
	fi


		marte2_clone
	fi

#marte2_build MARTe2-F4E

#marte2_build MARTe2-GITHUB

marte2_build MARTe2-INF armv8




		if false; then
		git submodule init
		git submodule update
		./add_inside_marte2_components.sh
		pushd MARTe2-dev
		make -f Makefile.x86-linux
		popd
		pushd ./MARTe2-components
		. ../envsetup.sh
		make -f Makefile.linux
		cd IdunnRealTimeEngine
		git checkout develop
		make -f Makefile.x86-linux clean
		make -f Makefile.x86-linux
		cd ../Source/Components/DataSources/UDPDataSource
		make -f Makefile.linux

		popd
	fi

##
## Create the virtual environment for python
##

if false; then
	python3 -m venv idunn-test-platform-venv
	source idunn-test-platform-venv/bin/activate
	echo $(which python)
	echo $(which pip)
	pip install -r requirements.txt
	pip install --upgrade pip
	pip install -r rtcc2-configuration-manager/requirements.txt
fi


date

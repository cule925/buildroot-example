EXT_PYTHON_LXML_VERSION = 6.0.2
EXT_PYTHON_LXML_SOURCE = lxml-${EXT_PYTHON_LXML_VERSION}.tar.gz
EXT_PYTHON_LXML_SITE = https://files.pythonhosted.org/packages/aa/88/262177de60548e5a2bfc46ad28232c9e9cbde697bd94132aeb80364675cb
EXT_PYTHON_LXML_SETUP_TYPE = setuptools
EXT_PYTHON_LXML_LICENSE = BSD-3-Clause
EXT_PYTHON_LXML_LICENSE_FILES = LICENSE.txt

EXT_PYTHON_LXML_DEPENDENCIES = libxml2 libxslt zlib

# python-lxml needs these scripts in order to properly detect libxml2 and
# libxslt compiler and linker flags
EXT_PYTHON_LXML_BUILD_OPTS = \
	--skip-dependency-check \
	-C--build-option=--with-xslt-config=$(STAGING_DIR)/usr/bin/xslt-config \
	-C--build-option=--with-xml2-config=$(STAGING_DIR)/usr/bin/xml2-config

$(eval $(python-package))

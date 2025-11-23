LVGL_VERSION = 9.4.0
LVGL_SOURCE = v${LVGL_VERSION}.tar.gz
LVGL_SITE = https://github.com/lvgl/lvgl/archive/refs/tags
LVGL_LICENSE = MIT
LVGL_LICENSE_FILES = LICENSE.txt

# Pass custom configuration file
LVGL_CONF_OPTS = -DLV_BUILD_CONF_PATH="$(BR2_EXTERNAL)/package/lvgl/config/lv_conf.h"

# This will install the headers in the staging directory
LVGL_INSTALL_STAGING = YES

# This will install the libraries in the target directory
LVGL_INSTALL_TARGET = YES

$(eval $(cmake-package))

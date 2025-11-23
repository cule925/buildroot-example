LVGL_APP_VERSION = 1.0.0
LVGL_APP_SITE = ${BR2_EXTERNAL}/package/lvgl-app/app
LVGL_APP_SITE_METHOD = local
LVGL_APP_LICENSE = Unlicense

LVGL_APP_DEPENDENCIES = lvgl

define LVGL_APP_BUILD_CMDS
	$(TARGET_CC) $(TARGET_CFLAGS) \
	-I$(STAGING_DIR)/usr/include/lvgl \
	-I$(STAGING_DIR)/usr/include/lvgl/src \
	-c $(@D)/src/main.c -o $(@D)/main.o

	$(TARGET_CC) $(TARGET_LDFLAGS) \
	$(@D)/main.o \
	-L$(STAGING_DIR)/usr/lib -llvgl \
	-o $(@D)/lvgl_app
endef

define LVGL_APP_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/lvgl_app \
	$(TARGET_DIR)/home/user/lvgl_app
endef

$(eval $(generic-package))

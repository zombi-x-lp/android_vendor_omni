# Common settings and files
-include vendor/zombi/config/common.mk

# Add tablet overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/zombi/overlay/common_tablet

PRODUCT_CHARACTERISTICS := tablet


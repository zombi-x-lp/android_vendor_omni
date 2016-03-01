PRODUCT_BRAND ?= zombi

# bootanimation (Some devices cant go over 100fps for a bootani)
ifneq ($(USE_LOWFPS_BOOTANI),true)
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/bootanimation/bootanimation.zip:system/media/bootanimation.zip
else
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/bootanimation/lowfps-bootanimation.zip:system/media/bootanimation.zip
endif

# default wallpaper
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/default_wallpaper.jpg:system/media/default_wallpaper.jpg
PRODUCT_PROPERTY_OVERRIDES += \
    ro.config.wallpaper=/system/media/default_wallpaper.jpg

ifeq ($(PRODUCT_GMS_CLIENTID_BASE),)
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=android-google
else
PRODUCT_PROPERTY_OVERRIDES += \
    ro.com.google.clientidbase=$(PRODUCT_GMS_CLIENTID_BASE)
endif

# general properties
PRODUCT_PROPERTY_OVERRIDES += \
    ro.url.legal=http://www.google.com/intl/%s/mobile/android/basic/phone-legal.html \
    ro.com.android.wifi-watchlist=GoogleGuest \
    ro.setupwizard.enterprise_mode=1 \
    persist.sys.root_access=1

# enable ADB authentication if not on eng build
ifneq ($(TARGET_BUILD_VARIANT),eng userdebug)
ADDITIONAL_DEFAULT_PROPERTIES += ro.adb.secure=0
endif

# Backup Tool
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/bin/backuptool.sh:system/bin/backuptool.sh \
    vendor/zombi/prebuilt/bin/backuptool.functions:system/bin/backuptool.functions \
    vendor/zombi/prebuilt/bin/50-hosts.sh:system/addon.d/50-hosts.sh \
    vendor/zombi/prebuilt/bin/blacklist:system/addon.d/blacklist

# init.d support
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/etc/init.d/00banner:system/etc/init.d/00banner \
    vendor/zombi/prebuilt/bin/sysinit:system/bin/sysinit

# Init script file with zombi extras
PRODUCT_COPY_FILES += \
    vendor/zombi/prebuilt/etc/init.local.rc:root/init.zombi.rc

# Enable SIP and VoIP on all targets
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.sip.voip.xml:system/etc/permissions/android.software.sip.voip.xml

# Chromium Prebuilt
ifeq ($(PRODUCT_PREBUILT_WEBVIEWCHROMIUM),yes)
-include prebuilts/chromium/$(TARGET_DEVICE)/chromium_prebuilt.mk
endif

# Dashclock
#PRODUCT_COPY_FILES += \
#    vendor/zombi/prebuilt/app/DashClock.apk:system/app/DashClock.apk

# Additional packages
-include vendor/zombi/config/packages.mk

# Versioning
-include vendor/zombi/config/version.mk

# Add our overlays
PRODUCT_PACKAGE_OVERLAYS += vendor/zombi/overlay/common

# Enable dexpreopt for all KANG :)
ifeq ($(ROM_BUILDTYPE),KANG)
    WITH_DEXPREOPT := true
endif

ARCHS = arm64
TARGET = iphone:clang:latest:15.0
THEOS_PACKAGE_SCHEME = rootless
INSTALL_TARGET_PROCESSES = VideoStar

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = HSONModernMenu
HSONModernMenu_FILES = \
    Source/Tweak.m \
    Source/Features/HSONFeatureEngine.m
HSONModernMenu_CFLAGS = -fobjc-arc -fblocks -Wall
# Reserve Mach-O header space so downstream code-signing tools can add LC_CODE_SIGNATURE.
HSONModernMenu_LDFLAGS += -Wl,-headerpad,0x4000
HSONModernMenu_FRAMEWORKS = UIKit QuartzCore Foundation CoreImage CoreMedia AVFoundation UniformTypeIdentifiers

include $(THEOS_MAKE_PATH)/tweak.mk

TWEAK_NAME = MoreLinesNotificationCenter
MoreLinesNotificationCenter_FILES = Tweak.x
MoreLinesNotificationCenter_FRAMEWORKS = Foundation UIKit

ADDITIONAL_CFLAGS = -std=c99
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 4.3

include framework/makefiles/common.mk
include framework/makefiles/tweak.mk

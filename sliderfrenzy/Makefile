include theos/makefiles/common.mk

BUNDLE_NAME = SliderFrenzy
SliderFrenzy_FILES = SliderFrenzy.mm
SliderFrenzy_INSTALL_PATH = /Library/PreferenceBundles
SliderFrenzy_FRAMEWORKS = UIKit
SliderFrenzy_PRIVATE_FRAMEWORKS = Preferences

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SliderFrenzy.plist$(ECHO_END)

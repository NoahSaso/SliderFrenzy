include theos/makefiles/common.mk

TWEAK_NAME = SliderFrenzy
SliderFrenzy_FILES = Tweak.xm
SliderFrenzy_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/tweak.mk

SUBPROJECTS += sliderfrenzy
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "killall -9 SpringBoard"

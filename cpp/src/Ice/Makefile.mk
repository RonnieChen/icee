#
# IceUtil
#
include $(CLEAR_RULES)
LOCAL_MODULE                    = IceUtil
include $(SUBMODULE_RULES)
LIBRARY_OBJS                    := $(LIBRARY_OBJS) $(LOCAL_OBJS)

#
# IceDiscovery
#
include $(CLEAR_RULES)
LOCAL_MODULE                    = IceDiscovery
include $(SUBMODULE_RULES)
LIBRARY_OBJS                    := $(LIBRARY_OBJS) $(LOCAL_OBJS)

#
# IceLocatorDiscovery
#

include $(CLEAR_RULES)
LOCAL_MODULE                    = IceLocatorDiscovery
include $(SUBMODULE_RULES)
LIBRARY_OBJS                    := $(LIBRARY_OBJS) $(LOCAL_OBJS)

#
# IceSSL
#
include $(CLEAR_RULES)
LOCAL_MODULE                    = IceSSL
LOCAL_SLICE2CPPFLAGS            = --dll-export ICE_SSL_API
include $(SUBMODULE_RULES)
LIBRARY_OBJS                    := $(LIBRARY_OBJS) $(LOCAL_OBJS)

#
# Ice
#
include $(CLEAR_RULES)

LOCAL_MODULE                    = Ice
LOCAL_PATH                      = cpp/src/Ice

LOCAL_SLICEDIR                  = ice/slice/$(LOCAL_MODULE)
LOCAL_SLICES                    = $(wildcard $(LOCAL_SLICEDIR)/*.ice)
LOCAL_SLICE2CPPFLAGS            = --ice --include-dir Ice --dll-export ICE_API

LOCAL_SRCDIR                    = ice/cpp/src/$(LOCAL_MODULE)
LOCAL_SRCS                      = $(filter-out $(LOCAL_SRCDIR)/DLLMain.cpp $(LOCAL_SRCDIR)/RegisterPluginsInit.cpp, $(wildcard $(LOCAL_SRCDIR)/*.cpp)) \
                                  $(LOCAL_PATH)/RegisterPluginsInit.cpp

LOCAL_OBJS                      = $(LIBRARY_OBJS)
LOCAL_DEPENDENT_DYMODULES       = IceUtil

LOCAL_HEADERPATH                = cpp/include/$(LOCAL_MODULE)
include $(STATICLIBRARY_RULES)
LOCAL_OBJS                      =
include $(DYNAMICLIBRARY_RULES)
Ice: Ice_staticlib Ice_dynamiclib


Ice_slice_install: Ice
	$(Q)mkdir -p $(DESTDIR)$(ice_install_slice_dir)/Ice
	$(Q)cp ice/slice/Ice/*.ice $(DESTDIR)$(ice_install_slice_dir)/Ice

	$(Q)mkdir -p $(DESTDIR)$(ice_install_slice_dir)/IceSSL
	$(Q)cp ice/slice/IceSSL/*.ice $(DESTDIR)$(ice_install_slice_dir)/IceSSL

	$(Q)mkdir -p $(DESTDIR)$(ice_install_slice_dir)/IceDiscovery
	$(Q)cp ice/slice/IceDiscovery/*.ice $(DESTDIR)$(ice_install_slice_dir)/IceDiscovery

	$(Q)mkdir -p $(DESTDIR)$(ice_install_slice_dir)/IceLocatorDiscovery
	$(Q)cp ice/slice/IceLocatorDiscovery/*.ice $(DESTDIR)$(ice_install_slice_dir)/IceLocatorDiscovery

Ice_headers_install: Ice
	$(Q)mkdir -p $(DESTDIR)$(ice_install_include_dir)/IceUtil
	$(Q)cp cpp/include/IceUtil/*.h $(DESTDIR)$(ice_install_include_dir)/IceUtil

	$(Q)mkdir -p $(DESTDIR)$(ice_install_include_dir)/Ice
	$(Q)cp cpp/include/Ice/*.h $(DESTDIR)$(ice_install_include_dir)/Ice

	$(Q)mkdir -p $(DESTDIR)$(ice_install_include_dir)/IceSSL
	$(Q)cp cpp/include/IceSSL/*.h $(DESTDIR)$(ice_install_include_dir)/IceSSL

	$(Q)mkdir -p $(DESTDIR)$(ice_install_include_dir)/IceDiscovery
	$(Q)cp cpp/include/IceDiscovery/*.h $(DESTDIR)$(ice_install_include_dir)/IceDiscovery

	$(Q)mkdir -p $(DESTDIR)$(ice_install_include_dir)/IceLocatorDiscovery
	$(Q)cp cpp/include/IceLocatorDiscovery/*.h $(DESTDIR)$(ice_install_include_dir)/IceLocatorDiscovery

INSTALL_TARGETS := $(INSTALL_TARGETS) Ice_slice_install Ice_headers_install
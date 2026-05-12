QT       += core gui network widgets charts

TARGET   = radeon-profile
TEMPLATE = app

CONFIG  += c++11

CONFIG(release, debug|release) {
    DEFINES += QT_NO_DEBUG_OUTPUT
} else {
    CONFIG  += warn_on
    QMAKE_CXXFLAGS += -Wextra -Wpedantic
}

SOURCES += main.cpp\
    radeon_profile.cpp \
    uiElements.cpp \
    uiEvents.cpp \
    gpu.cpp \
    dxorg.cpp \
    settings.cpp \
    daemonComm.cpp \
    ioctlHandler.cpp \
    ioctl_radeon.cpp \
    ioctl_amdgpu.cpp \
    execbin.cpp \
    dialogs/dialog_defineplot.cpp \
    dialogs/dialog_rpevent.cpp \
    dialogs/dialog_topbarcfg.cpp \
    dialogs/dialog_deinetopbaritem.cpp \
    tab_events.cpp \
    tab_plots.cpp \
    tab_fanControl.cpp \
    tab_exec.cpp \
    tab_overclock.cpp \
    dialogs/dialog_sliders.cpp \
    dialogs/dialog_plotsconfiguration.cpp


HEADERS  += radeon_profile.h \
    gpu.h \
    dxorg.h \
    globalStuff.h \
    daemonComm.h \
    execbin.h \
    rpevent.h \
    ioctlHandler.h \
    components/rpplot.h \
    components/pieprogressbar.h \
    components/topbarcomponents.h \
    dialogs/dialog_defineplot.h \
    dialogs/dialog_rpevent.h \
    dialogs/dialog_topbarcfg.h \
    dialogs/dialog_deinetopbaritem.h \
    dialogs/dialog_sliders.h \
    dialogs/dialog_plotsconfiguration.h \
    components/slider.h

FORMS    += radeon_profile.ui \
    components/pieprogressbar.ui \
    dialogs/dialog_defineplot.ui \
    dialogs/dialog_plotsconfiguration.ui \
    dialogs/dialog_rpevent.ui \
    dialogs/dialog_topbarcfg.ui \
    dialogs/dialog_deinetopbaritem.ui \
    dialogs/dialog_sliders.ui \
    components/slider.ui

RESOURCES += \
    radeon-resource.qrc

# Requires: libxrandr-dev (Debian/Ubuntu), libXrandr-devel (Fedora/SUSE), libxrandr (Arch)
LIBS += -lXrandr -lX11

DESTDIR = target


bin.path = /usr/bin
bin.files = target/radeon-profile

desktop.path = /usr/share/applications
desktop.files = extra/radeon-profile.desktop

icon.path = /usr/share/icons/hicolor/512x512/apps
icon.files = extra/radeon-profile.png

INSTALLS += \
	bin \
	desktop \
	icon
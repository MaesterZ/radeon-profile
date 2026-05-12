#include "radeon_profile.h"
#include <QApplication>
#include <QTranslator>

int main(int argc, char *argv[])
{
    // Force XCB (X11) platform plugin unless the user has explicitly chosen another.
    // Wayland support in this Qt5 app is incomplete and causes QSocketNotifier warnings.
    if (qEnvironmentVariableIsEmpty("QT_QPA_PLATFORM"))
        qputenv("QT_QPA_PLATFORM", "xcb");

    qDebug() << "Creating application object";

    QApplication a(argc, argv);
    QTranslator translator;
    QLocale locale;

    if (locale.language() != QLocale::Language::English) {
        if (translator.load(locale, "strings", ".")
                || translator.load(locale, "strings", ".", QApplication::applicationDirPath())
                || translator.load(locale, "strings", ".", "/usr/share/radeon-profile"))

            a.installTranslator(&translator);
        else
            qWarning() << "Translation not found.";
    }

    qDebug() << "Creating radeon_profile";
    radeon_profile w;

    return a.exec();
}

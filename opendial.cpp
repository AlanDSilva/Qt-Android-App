#include "opendial.h"

OpenDial::OpenDial(QObject* parent) : QObject(parent) {}

void OpenDial::opendial(QString num)
{
#ifdef Q_OS_ANDROID
    QtAndroid::runOnAndroidThread([=]
    {
        qDebug() << "Hello world";
        QAndroidJniObject activity = QAndroidJniObject::callStaticObjectMethod("org/qtproject/qt5/android/QtNative", "activity", "()Landroid/app/Activity;");
        if ( activity.isValid() ) {
            qDebug() << "Activity is valid!";

            QAndroidJniObject callConstant = QAndroidJniObject::getStaticObjectField<jstring>("android/content/Intent", "ACTION_DIAL");
            QAndroidJniObject intent("android/content/Intent","(Ljava/lang/String;)V", callConstant.object());
                if ( intent.isValid() )
                {
                   qDebug() << "Intent is valid!!";

                   QAndroidJniObject jNumber = QAndroidJniObject::fromString(QString("tel:%1").arg(num));
                   QAndroidJniObject uri = QAndroidJniObject::callStaticObjectMethod("android/net/Uri","parse","(Ljava/lang/String;)Landroid/net/Uri;", jNumber.object());
                   intent.callObjectMethod("setData", "(Landroid/net/Uri;)Landroid/content/Intent;", uri.object<jobject>());

                   activity.callMethod<void>("startActivity","(Landroid/content/Intent;)V", intent.object<jobject>());
                }

        }
    });
#endif


}


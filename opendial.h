#ifndef OPENDIAL_H
#define OPENDIAL_H

#include <QObject>
#include <QDebug>
#ifdef Q_OS_ANDROID
  #include <QtAndroidExtras>
  #include <QAndroidJniObject>
#endif

class OpenDial : public QObject
{
    Q_OBJECT
public:
    explicit OpenDial(QObject* parent = nullptr);
    Q_INVOKABLE void opendial(QString num);

private:
    static OpenDial instance;
};

#endif // OPENDIAL_H

#ifndef SAILORGRAM_H
#define SAILORGRAM_H

#include <QObject>
#include <QGuiApplication>
#include <QDir>
#include <QStandardPaths>
#include <telegram.h>

class SailorGram : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QString telegramConfigPath READ telegramConfigPath CONSTANT FINAL)
    Q_PROPERTY(QString telegramPublicKey READ telegramPublicKey CONSTANT FINAL)

    public:
        explicit SailorGram(QObject *parent = 0);
        QString telegramConfigPath() const;
        QString telegramPublicKey() const;

    private:
        static const QString TELEGRAM_CONFIG;
        static const QString TELEGRAM_PUBLIC_KEY;
};

#endif // SAILORGRAM_H

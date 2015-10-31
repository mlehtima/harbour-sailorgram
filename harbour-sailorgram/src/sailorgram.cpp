#include "sailorgram.h"

const QString SailorGram::TELEGRAM_CONFIG = "libtelegram";
const QString SailorGram::TELEGRAM_PUBLIC_KEY = "server.pub";
const QString SailorGram::EMOJI_FOLDER = "emoji";

SailorGram::SailorGram(QObject *parent): QObject(parent)
{
    QDir cfgdir(QStandardPaths::writableLocation(QStandardPaths::GenericDataLocation));
    cfgdir.mkpath(qApp->applicationName() + QDir::separator() + qApp->applicationName() + QDir::separator() + SailorGram::TELEGRAM_CONFIG);
}

QString SailorGram::telegramConfigPath() const
{
    return QStandardPaths::writableLocation(QStandardPaths::DataLocation) + QDir::separator() + SailorGram::TELEGRAM_CONFIG;
}

QString SailorGram::telegramPublicKey() const
{
    return qApp->applicationDirPath() + QDir::separator() + "../share/" + qApp->applicationName() + QDir::separator() + SailorGram::TELEGRAM_PUBLIC_KEY;
}

QString SailorGram::emojiPath() const
{
    return qApp->applicationDirPath() + QDir::separator() + "../share/" + qApp->applicationName() + QDir::separator() + SailorGram::EMOJI_FOLDER + QDir::separator();
}

#ifndef SAILORGRAM_H
#define SAILORGRAM_H

#include <QGuiApplication>
#include <QStandardPaths>
#include <QFile>
#include <QMimeDatabase>
#include <telegramqml.h>
#include <userdata.h>
#include <objects/types.h>
#include "dbus/interface/sailorgraminterface.h"
#include "dbus/notification/notification.h"
#include "dbus/connectivitychecker.h"
#include "item/translationinfoitem.h"

class SailorGram : public QObject
{
    Q_OBJECT

    Q_PROPERTY(bool autostart READ autostart WRITE setAutostart NOTIFY autostartChanged)
    Q_PROPERTY(bool keepRunning READ keepRunning WRITE setKeepRunning NOTIFY keepRunningChanged)
    Q_PROPERTY(bool daemonized READ daemonized NOTIFY daemonizedChanged)
    Q_PROPERTY(bool connected READ connected NOTIFY connectedChanged)
    Q_PROPERTY(TelegramQml* telegram READ telegram WRITE setTelegram NOTIFY telegramChanged)
    Q_PROPERTY(QString emojiPath READ emojiPath CONSTANT FINAL)
    Q_PROPERTY(QString configPath READ configPath CONSTANT FINAL)
    Q_PROPERTY(QString publicKey READ publicKey CONSTANT FINAL)
    Q_PROPERTY(QString homeFolder READ homeFolder CONSTANT FINAL)
    Q_PROPERTY(QString sdcardFolder READ sdcardFolder CONSTANT FINAL)
    Q_PROPERTY(QString picturesFolder READ picturesFolder CONSTANT FINAL)
    Q_PROPERTY(QString androidStorage READ androidStorage CONSTANT FINAL)
    Q_PROPERTY(QString voiceRecordPath READ voiceRecordPath CONSTANT FINAL)
    Q_PROPERTY(QList<QObject *> translations READ translations CONSTANT FINAL)
    Q_PROPERTY(DialogObject* foregroundDialog READ foregroundDialog WRITE setForegroundDialog NOTIFY foregroundDialogChanged)

    public:
        explicit SailorGram(QObject *parent = 0);
        bool autostart();
        bool keepRunning() const;
        bool daemonized() const;
        bool connected() const;
        Q_INVOKABLE bool hasContact(const qint64 &id) const;
        int interval() const;
        QString emojiPath() const;
        QString configPath() const;
        QString publicKey() const;
        QString homeFolder() const;
        QString sdcardFolder() const;
        QString picturesFolder() const;
        QString androidStorage() const;
        QString voiceRecordPath() const;
        TelegramQml* telegram() const;
        DialogObject* foregroundDialog() const;
        QList<QObject *> translations();
        void setTelegram(TelegramQml* telegram);
        void setForegroundDialog(DialogObject* dialog);
        void setKeepRunning(bool keep);
        void setAutostart(bool autostart);

    public:
        static bool hasNoDaemonFile();

    public slots:
        void moveMediaToDownloads(const QString &mediafile);
        void moveMediaToGallery(const QString &mediafile, quint32 mediatype);
        void notify(MessageObject* message, const QString& name, const QString &elaboratedbody);
        void closeNotification(DialogObject* dialog);

    private:
        QString mediaLocation(quint32 mediatype);
        void updatePendingState(MessageObject* message, quint32 peerid);
        void moveMediaTo(const QString &mediafile, const QString& destination);
        void notify(const QString& summary, const QString& body, const QString &icon, qint32 peerid);
        void beep();

    private slots:
        void onApplicationStateChanged(Qt::ApplicationState state);
        void onNotificationClosed(uint);
        void onMessageUnreadedChanged();
        void onWakeUpRequested();
        void updateLogLevel();
        void updateOnlineState();
        void delayedCloseNotification();

    signals:
        void autostartChanged();
        void keepRunningChanged();
        void daemonizedChanged();
        void connectedChanged();
        void telegramChanged();
        void wakeUpRequested();
        void foregroundDialogChanged();
        void openDialogRequested(qint32 peerid);

    private:
        QHash<int, MessageObject*> _deletednotifications;
        QHash<qint32, Notification*> _notifications;
        QHash<qint32, MessageObject*> _topmessages;
        QMimeDatabase _mimedb;
        TelegramQml* _telegram;
        ConnectivityChecker* _connectivitychecker;
        QNetworkConfigurationManager* _netcfgmanager;
        SailorgramInterface* _interface;
        DialogObject* _foregrounddialog;
        int _connected;
        bool _daemonized;
        bool _autostart;

    private:
        static const QString NO_DAEMON_FILE;
        static const QString CONFIG_FOLDER;
        static const QString PUBLIC_KEY_FILE;
        static const QString EMOJI_FOLDER;
        static const QString APPLICATION_PRETTY_NAME;
};

#endif // SAILORGRAM_H

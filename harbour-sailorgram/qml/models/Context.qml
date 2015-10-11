import QtQuick 2.1
import harbour.sailorgram.DBus 1.0
import harbour.sailorgram.SailorGram 1.0
import harbour.sailorgram.Telegram 1.0
import "../js/Settings.js" as Settings
import "../js/TelegramHelper.js" as TelegramHelper

QtObject
{
    id: context

    readonly property string apiAddress: "149.154.167.50"
    readonly property int apiPort: 443
    readonly property int dcId: 2
    readonly property string version: "0.79"

    property bool sendwithreturn: false
    property bool backgrounddisabled: false
    property bool chatheaderhidden: false

    property ScreenBlank screenblank: ScreenBlank { }
    property Notifications notifications: Notifications { }
    property ErrorsModel errors: ErrorsModel { }
    property SailorGram sailorgram: SailorGram { }

    property Telegram telegram: Telegram {
        apiId: 27782
        apiHash: "5ce096f34c8afab871edce728e6d64c9"
        deviceModel: "Sailfish OS"
        osVersion: "Linux"
        applicationVersion: context.version
        storagePath: sailorgram.telegramConfigPath
        publicKey: sailorgram.telegramPublicKey

        onSignInRequested: {
            pageStack.completeAnimation();
            context.telegram.sendCode(); // NOTE: Change to sendSms()
            pageStack.replace(Qt.resolvedUrl("../pages/login/AuthorizationPage.qml"), { "context": context });
        }

        onLoggedInChanged: {
            if(!loggedIn)
                return;

            pageStack.completeAnimation();
            pageStack.replace(Qt.resolvedUrl("../pages/dialogs/DialogsPage.qml"), { "context": context });
        }
    }
}

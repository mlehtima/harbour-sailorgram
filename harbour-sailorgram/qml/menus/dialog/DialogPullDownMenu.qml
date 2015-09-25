import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "./../../components/telegram"
import "../../js/TelegramHelper.js" as TelegramHelper
import "../../js/TelegramConstants.js" as TelegramConstants

PullDownMenu
{
    property Context context

    id: dialogpulldownmenu

    MenuItem
    {
        text: qsTr("Profile")
        onClicked: pageStack.push(Qt.resolvedUrl("../../pages/profile/ProfilePage.qml"), { "context": dialogpulldownmenu.context })
    }

    TelegramMenuItem
    {
        text: qsTr("New Secret Chat")
        context: dialogpulldownmenu.context
        onClicked: pageStack.push(Qt.resolvedUrl("../../pages/secretconversations/CreateSecretConversationPage.qml"), { "context": dialogpulldownmenu.context })
    }

    TelegramMenuItem
    {
        text: qsTr("New Group")
        context: dialogpulldownmenu.context
        onClicked: pageStack.push(Qt.resolvedUrl("../../pages/chat/CreateChatPage.qml"), { "context": dialogpulldownmenu.context })
    }

    MenuItem
    {
        text: qsTr("Contacts")
        onClicked: pageStack.push(Qt.resolvedUrl("../../pages/contacts/ContactsPage.qml"), { "context": dialogpulldownmenu.context })
    }
}


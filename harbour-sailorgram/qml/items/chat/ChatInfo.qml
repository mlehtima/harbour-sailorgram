import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../user"
import "../../components"
import "../../models"
import "../../menus/chat"
import "../../js/TelegramHelper.js" as TelegramHelper

Item
{
    property Context context
    property Dialog dialog
    property Chat telegramChat

    property bool adminMenu: {
        if(chatfullprovider.chatFull && chatfullprovider.chatFull.participants.admin) {
            var admin = chatfullprovider.chatFull.participants.admin;
            return admin.id === context.telegram.myId;
        }

        return false;
    }

    ChatFullProvider
    {
        id: chatfullprovider
        telegram: context.telegram
        chat: chatinfo.telegramChat
    }

    id: chatinfo
    width: content.width
    height: column.height + lvpartecipants.contentHeight
    Component.onCompleted: chatfullprovider.requestObject()

    Column
    {
        id: column
        width: parent.width

        ClickableLabel
        {
            width: parent.width
            height: Theme.itemSizeSmall
            labelText: qsTr("Leave group")
            labelFont.pixelSize: Theme.fontSizeSmall
            remorseRequired: true
            remorseMessage: qsTr("Leaving group")

            onActionRequested: {
                /* FIXME:
                var peerid = TelegramHelper.peerId(dialog);
                context.telegram.messagesDeleteChatUser(peerid, context.telegram.me);
                context.telegram.messagesDeleteHistory(peerid);
                */
                pageStack.pop();
            }
        }

        ClickableLabel
        {
            width: parent.width
            height: Theme.itemSizeSmall
            labelText: qsTr("Change title")
            labelFont.pixelSize: Theme.fontSizeSmall
            onActionRequested: pageStack.push(Qt.resolvedUrl("../../pages/chat/ChangeChatTitle.qml"), { "context": chatinfo.context, "dialog": chatinfo.dialog })
        }

        ClickableLabel
        {
            width: parent.width
            height: Theme.itemSizeSmall
            labelText: qsTr("Add member")
            labelFont.pixelSize: Theme.fontSizeSmall
            onActionRequested: pageStack.push(Qt.resolvedUrl("../../pages/chat/AddContactsPage.qml"), { "context": chatinfo.context, "dialog": chatinfo.dialog })
        }
    }

    SilicaListView
    {
        id: lvpartecipants
        spacing: Theme.paddingMedium
        anchors { left: parent.left; top: column.bottom; right: parent.right; bottom: parent.bottom }
        model: chatfullprovider.chatFull ? chatfullprovider.chatFull.participants.participants : null
        header: SectionHeader { text: qsTr("Members") }

        delegate: ListItem {
            id: liparticipant
            contentWidth: parent.width
            contentHeight: Theme.itemSizeSmall
            showMenuOnPressAndHold: adminMenu && (modelData.user.id !== context.telegram.myId)

            /*
            menu: ChatInfoMenu {
                context: chatinfo.context
                dialog: chatinfo.dialog
                user: liparticipant.user
            }
            */

            UserItem {
                id: useritem
                anchors { fill: parent; leftMargin: Theme.paddingMedium; rightMargin: Theme.paddingMedium }
                telegramUser: modelData.user
            }
        }
    }
}

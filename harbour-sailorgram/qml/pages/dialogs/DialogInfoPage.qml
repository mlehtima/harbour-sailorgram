import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../components"
import "../../items/peer"
import "../../items/user"
import "../../items/chat"
import "../../js/TelegramHelper.js" as TelegramHelper

Page
{
    property Context context
    property Dialog telegramDialog
    property bool muted: !telegramDialog.peerNotifySettings.isEmpty && telegramDialog.peerNotifySettings.isMuted
    property bool actionVisible: true

    id: dialoginfopage
    allowedOrientations: defaultAllowedOrientations

    function conversationTypeMessage() {
        //FIXME: if(telegramDialog.encrypted)
            //return qsTr("Delete secret chat");

        if(telegramDialog.isChat)
            return qsTr("Delete group");

        return qsTr("Delete conversation");
    }

    function conversationTypeRemorseMessage() {
        //FIXME: if(telegramDialog.encrypted)
            //return qsTr("Deleting secret chat");

        if(telegramDialog.isChat)
            return qsTr("Deleting group");

        return qsTr("Deleting conversation");
    }

    Component {
        id: userinfocomponent

        UserInfo {
            actionVisible: true
            allowSendMessage: false
            telegramUser: telegramDialog.user
        }
    }

    Component {
        id: chatinfocomponent

        ChatInfo {
            context: dialoginfopage.context
            telegramChat: dialoginfopage.telegramDialog.chat
        }
    }

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        Column
        {
            id: content
            width: parent.width

            PageHeader { title: telegramDialog.title }

            PeerItem
            {
                x: Theme.paddingMedium
                width: parent.width - (x * 2)
                height: Theme.itemSizeSmall
                telegramDialog: dialoginfopage.telegramDialog
            }

            SectionHeader { text: qsTr("Actions") }

            ClickableLabel
            {
                labelText: dialoginfopage.muted ? qsTr("Enable notifications") : qsTr("Disable notifications")
                labelFont.pixelSize: Theme.fontSizeSmall
                width: parent.width
                height: Theme.itemSizeSmall

                onActionRequested: {
                    /*
                    if(dialoginfopage.telegramDialog.encrypted) { // Secret chats are P2P
                        if(context.telegram.userData.isMuted(dialoginfopage.telegramDialog.peer.userId)) {
                            context.telegram.userData.removeMute(dialoginfopage.telegramDialog.peer.userId);
                            dialoginfopage.muted = false;
                        }
                        else {
                            context.telegram.userData.addMute(dialoginfopage.telegramDialog.peer.userId);
                            dialoginfopage.muted = true;
                        }

                        return;
                    }

                    var peerid = TelegramHelper.peerId(dialoginfopage.telegramDialog);

                    if(context.telegram.userData.isMuted(peerid)) {
                        context.telegram.unmute(peerid);
                        dialoginfopage.muted = false;
                    }
                    else {
                        context.telegram.mute(peerid);
                        dialoginfopage.muted = true;
                    }
                    */
                }
            }

            ClickableLabel
            {
                labelText: conversationTypeMessage()
                labelFont.pixelSize: Theme.fontSizeSmall
                remorseMessage: conversationTypeRemorseMessage()
                remorseRequired: true
                width: parent.width
                height: Theme.itemSizeSmall

                onActionRequested: {
                    //telegramDialog.unreadCount = 0;

                    /* FIXME:
                    if(telegramDialog.encrypted)
                        context.telegram.messagesDiscardEncryptedChat(telegramDialog.peer.userId);
                    else
                        context.telegram.messagesDeleteHistory(TelegramHelper.peerId(telegramDialog));
                    */

                    pageStack.pop();
                }
            }

            ClickableLabel
            {
                labelText: qsTr("Add to contacts")
                visible: !telegramDialog.isChat && telegramDialog.user.isRequest
                width: parent.width
                height: Theme.itemSizeSmall
                //FIXME: onActionRequested: context.telegram.addContact(user.firstName, user.lastName, user.phone)
            }

            Loader
            {
                id: loader

                sourceComponent: {
                    if(telegramDialog.isChat)
                        return chatinfocomponent;

                    return userinfocomponent;
                }
            }
        }
    }
}

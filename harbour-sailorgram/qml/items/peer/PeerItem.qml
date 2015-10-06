import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../js/TelegramHelper.js" as TelegramHelper

Item
{
    property Dialog telegramDialog

    id: peeritem

    PeerImage
    {
        id: peerimage
        anchors { left: parent.left; top: parent.top }
        width: peeritem.height
        height: peeritem.height
        telegramDialog: peeritem.telegramDialog
        telegramUser: peeritem.telegramDialog.user
    }

    Column
    {
        anchors { left: peerimage.right; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall }

        Row
        {
            id: rowtitle
            width: parent.width
            height: lbltitle.contentHeight
            spacing: Theme.paddingSmall

            Image
            {
                id: imgsecure
                source: "image://theme/icon-s-secure"
                anchors.verticalCenter: lbltitle.verticalCenter
                fillMode: Image.PreserveAspectFit
                visible: false //FIXME: peeritem.telegramDialog.encrypted
            }

            Label
            {
                id: lbltitle
                width: parent.width
                elide: Text.ElideRight
                text: telegramDialog.title
            }
        }

        Row
        {
            height: peeritem.height - rowtitle.height

            Label
            {
                id: lblinfo
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.highlightColor

                text: {
                    if(telegramDialog.isChat) {
                        var chat = telegramDialog.chat;
                        return chat.participantsCount === 1 ? qsTr("%1 member").arg(chat.participantsCount) : qsTr("%1 members").arg(chat.participantsCount);
                    }

                    return TelegramHelper.userStatus(telegramDialog.user);
                }
            }
        }
    }
}

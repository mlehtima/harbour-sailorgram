import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../peer"
import "../../js/TelegramHelper.js" as TelegramHelper

Item
{
    property User telegramUser

    id: useritem

    PeerImage
    {
        id: useravatar
        anchors { left: parent.left; top: parent.top }
        width: useritem.height
        height: useritem.height
        fallbackText: TelegramHelper.fullName(useritem.telegramUser)
        telegramUser: useritem.telegramUser
    }

    Column
    {
        anchors { left: useravatar.right; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall }

        Label
        {
            id: lblfullname
            width: parent.width
            elide: Text.ElideRight
            text: TelegramHelper.fullName(useritem.telegramUser)
        }

        Row
        {
            height: useritem.height - lblfullname.contentHeight

            Label {
                id: lblstaticstatus
                text: TelegramHelper.userStatus(useritem.telegramUser)
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.highlightColor
            }

            Label {
                id: lblstatus
                width: useritem.width - lblstaticstatus.contentWidth
                font.pixelSize: Theme.fontSizeExtraSmall
                elide: Text.ElideRight
            }
        }
    }
}

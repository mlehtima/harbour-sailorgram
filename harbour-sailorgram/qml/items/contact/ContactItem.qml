import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../peer"
import "../../js/TelegramHelper.js" as TelegramHelper

Item
{
    property Contact telegramContact

    id: contactitem

    PeerImage
    {
        id: useravatar
        anchors { left: parent.left; top: parent.top }
        width: contactitem.height
        height: contactitem.height
        fallbackText: TelegramHelper.fullName(telegramContact.user)
        telegramUser: telegramContact.user
    }

    Column
    {
        anchors { left: useravatar.right; top: parent.top; right: parent.right; leftMargin: Theme.paddingSmall }

        Label
        {
            id: lblfullname
            width: parent.width
            elide: Text.ElideRight
            text: TelegramHelper.fullName(telegramContact.user)
        }

        Row
        {
            height: contactitem.height - lblfullname.contentHeight

            Label {
                id: lblstaticstatus
                text: TelegramHelper.userStatus(telegramContact.user)
                font.pixelSize: Theme.fontSizeExtraSmall
                color: Theme.highlightColor
            }

            Label {
                id: lblstatus
                width: contactitem.width - lblstaticstatus.contentWidth
                font.pixelSize: Theme.fontSizeExtraSmall
                elide: Text.ElideRight
            }
        }
    }
}

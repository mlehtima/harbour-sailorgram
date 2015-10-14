import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../js/TelegramHelper.js" as TelegramHelper

ContextMenu
{
    signal profileRequested()

    id: contactmenu

    MenuItem
    {
        text: qsTr("Profile")
        onClicked: profileRequested()
    }
}

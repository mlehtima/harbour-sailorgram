import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../js/TelegramHelper.js" as TelegramHelper

Image
{
    property Dialog telegramDialog
    property User telegramUser
    property string fallbackText

    id: imgpeer
    fillMode: Image.PreserveAspectFit
    asynchronous: true

    source: {
        if(telegramUser)
            return telegramUser.photo.photoSmall;

        if(telegramDialog)
        {
            if(telegramDialog.isChat)
                return telegramDialog.chat.photo.photoSmall;

            return telegramDialog.user.photo.photoSmall;
        }

        return "";
    }

    Rectangle {
        id: imgfallback
        anchors.fill: parent
        color: Theme.secondaryHighlightColor
        radius: imgpeer.width * 0.5

        visible: {
            if(telegramUser && telegramUser.photo.isEmpty)
                return true;

            if(telegramDialog && telegramDialog.isChat && telegramDialog.chat.photo.isEmpty)
                return true;

            if(telegramDialog && !telegramDialog.isChat && telegramDialog.user.photo.isEmpty)
                return true;

            return false;
        }

        Label {
            anchors.centerIn: parent
            font.bold: true
            text: TelegramHelper.fallbackLetters(fallbackText)
        }
    }

    Image
    {
        id: imgpeertype
        anchors { bottom: parent.bottom; right: parent.right }
        fillMode: Image.PreserveAspectFit
         visible: telegramDialog && telegramDialog.isChat

        source: {
            if(telegramDialog && telegramDialog.isChat)
                return "image://theme/icon-s-chat";

            return "";
        }
    }
}

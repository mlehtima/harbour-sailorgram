import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../../js/TelegramHelper.js" as TelegramHelper

Label
{
    property Message telegramMessage

    id: messagestatus
    visible: telegramMessage.isOut && !telegramMessage.isService
    verticalAlignment: Text.AlignVCenter
    font.bold: true

    color: {
        if(!telegramMessage.isSent)
            return "gray";

        return Theme.highlightDimmerColor;
    }

    text: {
        if(!telegramMessage.isUnread)
            return " ✓✓";

        return " ✓";
    }
}

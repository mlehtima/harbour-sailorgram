import QtQuick 2.1
import harbour.sailorgram.Telegram 1.0
import "../../js/TelegramHelper.js" as TelegramHelper

Image
{
    property Message telegramMessage

    id: messagestatus
    visible: telegramMessage.isOut && !telegramMessage.isService
    fillMode: Image.PreserveAspectFit

    source: {
        if(!telegramMessage.isUnread)
            return "qrc:///res/read.png";

        /* FIXME: if(telegramMessage.sent)
            return "qrc:///res/sent.png"; */

        return "qrc:///res/out.png";
    }
}

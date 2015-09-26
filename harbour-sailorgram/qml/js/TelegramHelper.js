.pragma library

.import "TelegramConstants.js" as TelegramConstants
.import harbour.sailorgram.Telegram 1.0 as Telegram

function fullName(user)
{
    return user.firstName+ " " + user.lastName;
}

function completeName(user) // NOTE: Deprecated
{
    return user.firstName + " " + user.lastName;
}

function phoneNumber(user)
{
    return completePhoneNumber(user.phone);
}

function fallbackLetters(text)
{
    var splittext = text.split(" ");

    if(splittext.length >= 2)
        return splittext[0].slice(0, 1).toUpperCase() + splittext[1].slice(0, 1).toUpperCase();

    return splittext[0][0].toUpperCase();
}

function userStatus(user)
{
    switch(user.status.classType)
    {
        case TelegramConstants.typeUserStatusRecently:
            return qsTr("Recently");

        case TelegramConstants.typeUserStatusLastMonth:
            return qsTr("Last Month");

        case TelegramConstants.typeUserStatusLastWeek:
            return qsTr("Last Week");

        case TelegramConstants.typeUserStatusOnline:
            return qsTr("Online");

        //case TelegramConstants.typeUserStatusOffline:
            //return qsTr("Last Seen %1").arg(TelegramCalendar.TelegramCalendar.timeToString(user.status.wasOnline));

        default:
            break;
    }

    return qsTr("Unknown");
}

function messageDate(message)
{
    var messagedate = message.date;
    var now = new Date(Date.now());

    console.log(messagedate);

    if(now === messagedate)
        return Qt.formatDateTime(messagedate, "HH:mm");

    var MS_PER_DAY = 1000 * 60 * 60 * 24;
    var daydiff = (now - messagedate) / MS_PER_DAY;

    if(daydiff < 7)
        return Qt.formatDateTime(messagedate, "ddd HH:mm");
    else if(messagedate.getYear() === now.getYear())
        return Qt.formatDateTime(messagedate, "dd MMM");

    return Qt.formatDateTime(messagedate, "dd MMM yy");
}

function isChat(dialog)
{
    if(!dialog)
        return false;

    if(dialog.encrypted)
        return false;

    return dialog.peer.classType === TelegramConstants.typePeerChat;
}

function isActionMessage(message)
{
    if(message.classType === TelegramConstants.typeMessageService)
        return true;

    if(message.action && (message.action.classType !== TelegramConstants.typeMessageActionEmpty))
        return true;

    return false;
}

function peerId(dialog)
{
    if(dialog.peer.classType === TelegramConstants.typePeerChat)
        return dialog.peer.chatId;

    return dialog.peer.userId;
}

function mediaType(messagemedia)
{
    if(messagemedia.isDocument)
        return qsTr("Document");

    if(messagemedia.isContact)
        return qsTr("Contact");

    if(messagemedia.isVideo)
        return qsTr("Video");

    if(messagemedia.isUnsupported)
        return qsTr("Unsupported");

    if(messagemedia.isAudio)
        return qsTr("Audio");

    if(messagemedia.isPhoto)
        return qsTr("Photo");

    if(messagemedia.isGeo)
        return qsTr("Geo");

    return qsTr("Unknown");
}

function messageContent(message) // NOTE: Deprecated
{
    if(message.media)
    {
        switch(message.media.classType)
        {
            case TelegramConstants.typeMessageMediaDocument:
                return qsTr("Document");

            case TelegramConstants.typeMessageMediaContact:
                return qsTr("Contact");

            case TelegramConstants.typeMessageMediaVideo:
                return qsTr("Video");

            case TelegramConstants.typeMessageMediaUnsupported:
                return qsTr("Unsupported");

            case TelegramConstants.typeMessageMediaAudio:
                return qsTr("Audio");

            case TelegramConstants.typeMessageMediaPhoto:
                return qsTr("Photo");

            case TelegramConstants.typeMessageMediaGeo:
                return qsTr("Geo");

            default:
                break;
        }
    }

    return message.message;
}

function formatBytes(bytes, decimals)
{
   if(bytes === 0)
       return "0 Byte";

   var k = 1024;
   var dm = decimals + 1 || 3;
   var sizes = ["Bytes", "KiB", "MiB", "GiB", "TiB", "PiB", "EiB", "ZiB", "YiB"];
   var i = Math.floor(Math.log(bytes) / Math.log(k));

   return (bytes / Math.pow(k, i)).toPrecision(dm) + " " + sizes[i];
}

function completePhoneNumber(phonenumber)
{
    if(phonenumber[0] !== '+')
        return "+" + phonenumber;

    return phonenumber;
}

function isTelegramUser(user) // https://core.telegram.org/constructor/updateServiceNotification
{
    return user.id === 777000;
}

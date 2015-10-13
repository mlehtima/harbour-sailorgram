.pragma library

.import "TelegramConstants.js" as TelegramConstants
.import harbour.sailorgram.Telegram 1.0 as Telegram

function fullName(user)
{
    if(!user)
        return "";

    if(user.lastName.length > 0)
        return user.firstName + " " + user.lastName;

    return user.firstName;
}

function completeName(user) // NOTE: Deprecated
{
    return user.firstName + " " + user.lastName;
}

function fallbackLetters(text)
{
    if(text.length <= 0)
        return "";

    var splittext = text.split(" ");

    if(splittext.length >= 2)
        return splittext[0].slice(0, 1).toUpperCase() + splittext[1].slice(0, 1).toUpperCase();

    return splittext[0][0].toUpperCase();
}

function userStatus(user)
{
    if(user)
    {
        if(user.status.isOnline)
            return qsTr("Online");

        if(user.status.isOffline)
            return qsTr("Last Seen %1").arg(printableDate(user.status.wasOnline));

        if(user.status.isRecently)
            return qsTr("Recently");

        if(user.status.isLastMonth)
            return qsTr("Last Month");

        if(user.status.isLastWeek)
            return qsTr("Last Week");
    }

    return qsTr("Unknown");
}

function printableDate(date)
{
    var now = new Date(Date.now());

    if(now === date)
        return Qt.formatDateTime(date, "HH:mm");

    var MS_PER_DAY = 1000 * 60 * 60 * 24;
    var daydiff = (now - date) / MS_PER_DAY;

    if(daydiff < 7)
        return Qt.formatDateTime(date, "ddd HH:mm");
    else if(date.getYear() === now.getYear())
        return Qt.formatDateTime(date, "dd MMM");

    return Qt.formatDateTime(date, "dd MMM yy");
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

    return qsTr("Unknown media");
}

function serviceType(messageaction, dialogmodel)
{
    var user = null;

    if(messageaction.isChatCreate)
    {
        user = dialogmodel.user(messageaction.users[0]); // NOTE: first_user = admin ?
        return qsTr("%1 created group «%2»").arg(fullName(user)).arg(messageaction.title);
    }

    if(messageaction.isEditTitle)
        return qsTr("Group title changed to '%1'").arg(messageaction.title);

    if(messageaction.isChatEditPhoto)
        return qsTr("Group photo has been changed");

    if(messageaction.isChatDeletePhoto)
        return qsTr("Group title has been removed");

    if(messageaction.isChatAddUser)
    {
        user = dialogmodel.user(messageaction.userId);
        return qsTr("%1 has joined the group").arg(completeName(user));
    }

    if(messageaction.isChatDeleteUser)
    {
        user = dialogmodel.user(messageaction.userId);
        return qsTr("%1 has left the group", fullName(user));
    }

    return qsTr("Unknown service message");
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

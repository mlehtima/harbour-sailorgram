import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../components"
import "../../components/telegram"
import "../../models"
import "../../items/user"
import "../../js/TelegramHelper.js" as TelegramHelper

Page
{
    property Context context

    id: profilepage
    allowedOrientations: defaultAllowedOrientations

    SelfUserProvider
    {
        id: selfuserprovider
        telegram: context.telegram
        Component.onCompleted: requestObject()
    }

    SilicaFlickable
    {
        anchors.fill: parent
        contentHeight: content.height

        TelegramPullDownMenu
        {
            context: profilepage.context

            MenuItem
            {
                text: qsTr("Change Username")
                //FIXME: onClicked: pageStack.push(Qt.resolvedUrl("ChangeUsernamePage.qml"), { "context": profilepage.context, "user": profilepage.user } )
            }

            MenuItem
            {
                text: qsTr("Change Picture")

                onClicked: {
                    /* FIXME:
                    var picker = pageStack.push(Qt.resolvedUrl("../picker/FilePickerPage.qml"), { "rootPage": profilepage, "mime": "image" })

                    picker.filePicked.connect(function(file) {
                        context.telegram.setProfilePhoto(file);
                    });
                    */
                }
            }
        }

        Column
        {
            id: content
            width: parent.width

            PageHeader { title: qsTr("Profile") }

            UserItem
            {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                height: Theme.itemSizeSmall
                telegramUser: selfuserprovider.user
            }

            SectionHeader { text: qsTr("User") }

            Label
            {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                text: selfuserprovider.user ? TelegramHelper.fullName(selfuserprovider.user) : ""
            }

            SectionHeader
            {
                text: qsTr("Username")
                visible: selfuserprovider.user && (selfuserprovider.user.userName.length > 0)
            }

            Label
            {
                visible: selfuserprovider.user && (selfuserprovider.user.userName.length > 0)
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                text: selfuserprovider.user ? selfuserprovider.user.userName : ""
            }

            SectionHeader { text: qsTr("Phone number") }

            Label
            {
                anchors { left: parent.left; right: parent.right; leftMargin: Theme.paddingSmall; rightMargin: Theme.paddingSmall }
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                wrapMode: Text.WordWrap
                font.pixelSize: Theme.fontSizeSmall
                text: selfuserprovider.user ? TelegramHelper.completePhoneNumber(selfuserprovider.user.phone) : ""
            }
        }
    }
}

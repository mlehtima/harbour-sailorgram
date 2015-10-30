import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../items/user"
import "../../menus/contact"

Page
{
    property Context context

    id: contactspage
    allowedOrientations: defaultAllowedOrientations

    SilicaListView
    {
        anchors.fill: parent
        spacing: Theme.paddingMedium
        header: PageHeader { title: qsTr("Contacts") }

        model: ContactsModel {
            telegram: context.telegram
        }

        delegate: ListItem {
            contentWidth: parent.width
            contentHeight: Theme.itemSizeSmall

            menu: ContactMenu {
                id: contactmenu
                onProfileRequested: pageStack.push(Qt.resolvedUrl("ContactPage.qml"), { "telegramUser": contact.user } );
            }

            onClicked: pageStack.replace(Qt.resolvedUrl("../dialogs/DialogPage.qml"), { "context": contactspage.context, "telegramDialog": context.dialogsmodel.createDialog(contact.user) })

            UserItem {
                id: useritem
                anchors.fill: parent
                telegramUser: contact.user
            }
        }
    }
}

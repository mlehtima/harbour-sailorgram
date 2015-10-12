import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0
import "../../models"
import "../../items/user"
import "../../menus"

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

            /* FIXME:
            menu: ContactMenu {
                id: contactmenu
                context: contactspage.context
                user: context.telegram.user(item.userId)
            }
            */

            onClicked: pageStack.replace(Qt.resolvedUrl("../dialogs/ConversationPage.qml"), { "context": contactspage.context, "dialog": context.telegram.fakeDialogObject(item.userId, false) } )

            UserItem {
                id: useritem
                anchors.fill: parent
                telegramUser: contact.user
            }
        }
    }
}

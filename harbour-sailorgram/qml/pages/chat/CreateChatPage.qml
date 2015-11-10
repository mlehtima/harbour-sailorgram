import QtQuick 2.1
import Sailfish.Silica 1.0
import harbour.sailorgram.Telegram 1.0 as Telegram
import "../../models"
import "../../items/user"
import "../../js/TelegramHelper.js" as TelegramHelper

Page
{
    property Context context
    property int count: 0
    property var users

    function createGroup() {
        busyindicator.running = true;

        var userlist = new Array;

        for(var prop in createchatpage.users)
            userlist.push(createchatpage.users[prop]);

        context.dialogsmodel.createChat(userlist, tfgroupname.text);
    }

    id: createchatpage
    allowedOrientations: defaultAllowedOrientations

    Component.onCompleted: {
        createchatpage.users = new Object;
    }

    Connections
    {
        target: context.dialogsmodel
        onDialogCreated: pageStack.replace(Qt.resolvedUrl("../dialogs/DialogPage.qml"), { "context": createchatpage.context, "telegramDialog": dialog })
    }

    SilicaFlickable
    {
        anchors.fill: parent

        PullDownMenu
        {
            MenuItem
            {
                text: qsTr("Create Group")
                enabled: (count > 0) && (tfgroupname.text.length > 0)
                onClicked: createGroup()
            }
        }

        BusyIndicator
        {
            id: busyindicator
            anchors.centerIn: parent
            size: BusyIndicatorSize.Large
            running: false
        }

        PageHeader
        {
            id: dlgheader
            title: qsTr("New Group")
        }

        TextField
        {
            id: tfgroupname
            enabled: !busyindicator.running
            anchors { left: parent.left; top: dlgheader.bottom; right: parent.right }
            placeholderText: qsTr("Group Name")
        }

        SilicaListView
        {
            id: lvcontacts
            anchors { left: parent.left; top: tfgroupname.bottom; right: parent.right; bottom: parent.bottom }
            spacing: Theme.paddingMedium
            enabled: !busyindicator.running
            clip: true

            model: Telegram.ContactsModel {
                telegram: context.telegram
            }

            delegate: ListItem {
                contentWidth: parent.width
                contentHeight: Theme.itemSizeSmall

                onClicked: {
                    swselectcontact.checked = !swselectcontact.checked;
                }

                UserItem {
                    id: useritem
                    anchors { left: parent.left; top: parent.top; right: swselectcontact.right; bottom: parent.bottom; leftMargin: Theme.paddingMedium; rightMargin: Theme.paddingMedium }
                    telegramUser: contact.user
                }

                Switch {
                    id: swselectcontact
                    anchors { right: parent.right; top: parent.top; bottom: parent.bottom }
                    width: parent.height

                    onCheckedChanged: {
                        checked ? count++ : count--

                        console.log(contact.user);

                        if(checked)
                            users[index] = contact.user;
                        else
                            delete users[index];
                    }
                }
            }
        }
    }
}

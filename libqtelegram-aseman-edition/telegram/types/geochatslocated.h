// This file generated by libqtelegram-code-generator.
// You can download it from: https://github.com/Aseman-Land/libqtelegram-code-generator
// DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

#ifndef LQTG_TYPE_GEOCHATSLOCATED
#define LQTG_TYPE_GEOCHATSLOCATED

#include "telegramtypeobject.h"
#include <QList>
#include "chat.h"
#include "geochatmessage.h"
#include "chatlocated.h"
#include "user.h"

class LIBQTELEGRAMSHARED_EXPORT GeochatsLocated : public TelegramTypeObject
{
public:
    enum GeochatsLocatedType {
        typeGeochatsLocated = 0x48feb267
    };

    GeochatsLocated(GeochatsLocatedType classType = typeGeochatsLocated, InboundPkt *in = 0);
    GeochatsLocated(InboundPkt *in);
    virtual ~GeochatsLocated();

    void setChats(const QList<Chat> &chats);
    QList<Chat> chats() const;

    void setMessages(const QList<GeoChatMessage> &messages);
    QList<GeoChatMessage> messages() const;

    void setResults(const QList<ChatLocated> &results);
    QList<ChatLocated> results() const;

    void setUsers(const QList<User> &users);
    QList<User> users() const;

    void setClassType(GeochatsLocatedType classType);
    GeochatsLocatedType classType() const;

    bool fetch(InboundPkt *in);
    bool push(OutboundPkt *out) const;

    bool operator ==(const GeochatsLocated &b);

private:
    QList<Chat> m_chats;
    QList<GeoChatMessage> m_messages;
    QList<ChatLocated> m_results;
    QList<User> m_users;
    GeochatsLocatedType m_classType;
};

#endif // LQTG_TYPE_GEOCHATSLOCATED

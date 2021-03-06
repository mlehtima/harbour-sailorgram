// This file generated by libqtelegram-code-generator.
// You can download it from: https://github.com/Aseman-Land/libqtelegram-code-generator
// DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

#include "user.h"
#include "core/inboundpkt.h"
#include "core/outboundpkt.h"
#include "../coretypes.h"

User::User(UserType classType, InboundPkt *in) :
    m_accessHash(0),
    m_id(0),
    m_classType(classType)
{
    if(in) fetch(in);
}

User::User(InboundPkt *in) :
    m_accessHash(0),
    m_id(0),
    m_classType(typeUserEmpty)
{
    fetch(in);
}

User::~User() {
}

void User::setAccessHash(qint64 accessHash) {
    m_accessHash = accessHash;
}

qint64 User::accessHash() const {
    return m_accessHash;
}

void User::setFirstName(const QString &firstName) {
    m_firstName = firstName;
}

QString User::firstName() const {
    return m_firstName;
}

void User::setId(qint32 id) {
    m_id = id;
}

qint32 User::id() const {
    return m_id;
}

void User::setLastName(const QString &lastName) {
    m_lastName = lastName;
}

QString User::lastName() const {
    return m_lastName;
}

void User::setPhone(const QString &phone) {
    m_phone = phone;
}

QString User::phone() const {
    return m_phone;
}

void User::setPhoto(const UserProfilePhoto &photo) {
    m_photo = photo;
}

UserProfilePhoto User::photo() const {
    return m_photo;
}

void User::setStatus(const UserStatus &status) {
    m_status = status;
}

UserStatus User::status() const {
    return m_status;
}

void User::setUsername(const QString &username) {
    m_username = username;
}

QString User::username() const {
    return m_username;
}

bool User::operator ==(const User &b) {
    return m_accessHash == b.m_accessHash &&
           m_firstName == b.m_firstName &&
           m_id == b.m_id &&
           m_lastName == b.m_lastName &&
           m_phone == b.m_phone &&
           m_photo == b.m_photo &&
           m_status == b.m_status &&
           m_username == b.m_username;
}

void User::setClassType(User::UserType classType) {
    m_classType = classType;
}

User::UserType User::classType() const {
    return m_classType;
}

bool User::fetch(InboundPkt *in) {
    LQTG_FETCH_LOG;
    int x = in->fetchInt();
    switch(x) {
    case typeUserEmpty: {
        m_id = in->fetchInt();
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    case typeUserSelf: {
        m_id = in->fetchInt();
        m_firstName = in->fetchQString();
        m_lastName = in->fetchQString();
        m_username = in->fetchQString();
        m_phone = in->fetchQString();
        m_photo.fetch(in);
        m_status.fetch(in);
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    case typeUserContact: {
        m_id = in->fetchInt();
        m_firstName = in->fetchQString();
        m_lastName = in->fetchQString();
        m_username = in->fetchQString();
        m_accessHash = in->fetchLong();
        m_phone = in->fetchQString();
        m_photo.fetch(in);
        m_status.fetch(in);
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    case typeUserRequest: {
        m_id = in->fetchInt();
        m_firstName = in->fetchQString();
        m_lastName = in->fetchQString();
        m_username = in->fetchQString();
        m_accessHash = in->fetchLong();
        m_phone = in->fetchQString();
        m_photo.fetch(in);
        m_status.fetch(in);
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    case typeUserForeign: {
        m_id = in->fetchInt();
        m_firstName = in->fetchQString();
        m_lastName = in->fetchQString();
        m_username = in->fetchQString();
        m_accessHash = in->fetchLong();
        m_photo.fetch(in);
        m_status.fetch(in);
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    case typeUserDeleted: {
        m_id = in->fetchInt();
        m_firstName = in->fetchQString();
        m_lastName = in->fetchQString();
        m_username = in->fetchQString();
        m_classType = static_cast<UserType>(x);
        return true;
    }
        break;
    
    default:
        LQTG_FETCH_ASSERT;
        return false;
    }
}

bool User::push(OutboundPkt *out) const {
    out->appendInt(m_classType);
    switch(m_classType) {
    case typeUserEmpty: {
        out->appendInt(m_id);
        return true;
    }
        break;
    
    case typeUserSelf: {
        out->appendInt(m_id);
        out->appendQString(m_firstName);
        out->appendQString(m_lastName);
        out->appendQString(m_username);
        out->appendQString(m_phone);
        m_photo.push(out);
        m_status.push(out);
        return true;
    }
        break;
    
    case typeUserContact: {
        out->appendInt(m_id);
        out->appendQString(m_firstName);
        out->appendQString(m_lastName);
        out->appendQString(m_username);
        out->appendLong(m_accessHash);
        out->appendQString(m_phone);
        m_photo.push(out);
        m_status.push(out);
        return true;
    }
        break;
    
    case typeUserRequest: {
        out->appendInt(m_id);
        out->appendQString(m_firstName);
        out->appendQString(m_lastName);
        out->appendQString(m_username);
        out->appendLong(m_accessHash);
        out->appendQString(m_phone);
        m_photo.push(out);
        m_status.push(out);
        return true;
    }
        break;
    
    case typeUserForeign: {
        out->appendInt(m_id);
        out->appendQString(m_firstName);
        out->appendQString(m_lastName);
        out->appendQString(m_username);
        out->appendLong(m_accessHash);
        m_photo.push(out);
        m_status.push(out);
        return true;
    }
        break;
    
    case typeUserDeleted: {
        out->appendInt(m_id);
        out->appendQString(m_firstName);
        out->appendQString(m_lastName);
        out->appendQString(m_username);
        return true;
    }
        break;
    
    default:
        return false;
    }
}


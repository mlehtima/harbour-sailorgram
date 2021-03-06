// This file generated by libqtelegram-code-generator.
// You can download it from: https://github.com/Aseman-Land/libqtelegram-code-generator
// DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

#include "peer.h"
#include "core/inboundpkt.h"
#include "core/outboundpkt.h"
#include "../coretypes.h"

Peer::Peer(PeerType classType, InboundPkt *in) :
    m_chatId(0),
    m_userId(0),
    m_classType(classType)
{
    if(in) fetch(in);
}

Peer::Peer(InboundPkt *in) :
    m_chatId(0),
    m_userId(0),
    m_classType(typePeerUser)
{
    fetch(in);
}

Peer::~Peer() {
}

void Peer::setChatId(qint32 chatId) {
    m_chatId = chatId;
}

qint32 Peer::chatId() const {
    return m_chatId;
}

void Peer::setUserId(qint32 userId) {
    m_userId = userId;
}

qint32 Peer::userId() const {
    return m_userId;
}

bool Peer::operator ==(const Peer &b) {
    return m_chatId == b.m_chatId &&
           m_userId == b.m_userId;
}

void Peer::setClassType(Peer::PeerType classType) {
    m_classType = classType;
}

Peer::PeerType Peer::classType() const {
    return m_classType;
}

bool Peer::fetch(InboundPkt *in) {
    LQTG_FETCH_LOG;
    int x = in->fetchInt();
    switch(x) {
    case typePeerUser: {
        m_userId = in->fetchInt();
        m_classType = static_cast<PeerType>(x);
        return true;
    }
        break;
    
    case typePeerChat: {
        m_chatId = in->fetchInt();
        m_classType = static_cast<PeerType>(x);
        return true;
    }
        break;
    
    default:
        LQTG_FETCH_ASSERT;
        return false;
    }
}

bool Peer::push(OutboundPkt *out) const {
    out->appendInt(m_classType);
    switch(m_classType) {
    case typePeerUser: {
        out->appendInt(m_userId);
        return true;
    }
        break;
    
    case typePeerChat: {
        out->appendInt(m_chatId);
        return true;
    }
        break;
    
    default:
        return false;
    }
}


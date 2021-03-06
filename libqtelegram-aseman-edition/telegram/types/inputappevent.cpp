// This file generated by libqtelegram-code-generator.
// You can download it from: https://github.com/Aseman-Land/libqtelegram-code-generator
// DO NOT EDIT THIS FILE BY HAND -- YOUR CHANGES WILL BE OVERWRITTEN

#include "inputappevent.h"
#include "core/inboundpkt.h"
#include "core/outboundpkt.h"
#include "../coretypes.h"

InputAppEvent::InputAppEvent(InputAppEventType classType, InboundPkt *in) :
    m_peer(0),
    m_time(0),
    m_classType(classType)
{
    if(in) fetch(in);
}

InputAppEvent::InputAppEvent(InboundPkt *in) :
    m_peer(0),
    m_time(0),
    m_classType(typeInputAppEvent)
{
    fetch(in);
}

InputAppEvent::~InputAppEvent() {
}

void InputAppEvent::setData(const QString &data) {
    m_data = data;
}

QString InputAppEvent::data() const {
    return m_data;
}

void InputAppEvent::setPeer(qint64 peer) {
    m_peer = peer;
}

qint64 InputAppEvent::peer() const {
    return m_peer;
}

void InputAppEvent::setTime(qreal time) {
    m_time = time;
}

qreal InputAppEvent::time() const {
    return m_time;
}

void InputAppEvent::setType(const QString &type) {
    m_type = type;
}

QString InputAppEvent::type() const {
    return m_type;
}

bool InputAppEvent::operator ==(const InputAppEvent &b) {
    return m_data == b.m_data &&
           m_peer == b.m_peer &&
           m_time == b.m_time &&
           m_type == b.m_type;
}

void InputAppEvent::setClassType(InputAppEvent::InputAppEventType classType) {
    m_classType = classType;
}

InputAppEvent::InputAppEventType InputAppEvent::classType() const {
    return m_classType;
}

bool InputAppEvent::fetch(InboundPkt *in) {
    LQTG_FETCH_LOG;
    int x = in->fetchInt();
    switch(x) {
    case typeInputAppEvent: {
        m_time = in->fetchDouble();
        m_type = in->fetchQString();
        m_peer = in->fetchLong();
        m_data = in->fetchQString();
        m_classType = static_cast<InputAppEventType>(x);
        return true;
    }
        break;
    
    default:
        LQTG_FETCH_ASSERT;
        return false;
    }
}

bool InputAppEvent::push(OutboundPkt *out) const {
    out->appendInt(m_classType);
    switch(m_classType) {
    case typeInputAppEvent: {
        out->appendDouble(m_time);
        out->appendQString(m_type);
        out->appendLong(m_peer);
        out->appendQString(m_data);
        return true;
    }
        break;
    
    default:
        return false;
    }
}


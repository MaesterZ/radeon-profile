#ifndef EVENT_H
#define EVENT_H

#include "globalStuff.h"

enum RPEventType {
    TEMPERATURE, BINARY
};

struct CheckInfoStruct {
    unsigned short checkTemperature;
};

class RPEvent {
public:

    RPEvent() { }

    bool enabled = false;
    QString name, activationBinary, fanProfileNameChange, powerProfileChange, powerLevelChange;
    unsigned short fixedFanSpeedChange = 0, activationTemperature = 0, fanComboIndex = 0;
    RPEventType type = RPEventType::TEMPERATURE;

    bool isActivationConditonFulfilled(const CheckInfoStruct &check) {
        switch (type) {
            case RPEventType::TEMPERATURE:
                return activationTemperature < check.checkTemperature;
            case RPEventType::BINARY:
                return !globalStuff::grabSystemInfo("pidof \""+activationBinary+"\"")[0].isEmpty();
        }

        return false;
    }
};

#endif // EVENT_H

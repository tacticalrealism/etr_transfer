#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"etr_transfer_main"};
        author = AUTHOR;
        authors[] = {""};
        VERSION_CONFIG;
    };
};

#include "ui\RscAttributes.hpp"
#include "CfgEventHandlers.hpp"

#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(initializedVehicleClasses) = [];
GVAR(massCache) = createHashMap;
GVAR(openedInventory) = objNull;

[
    QGVAR(timeFactor), "SLIDER",
    ["Time Factor", "Factor of how long transfer takes. Higher means longer."],
    "ETR Transfer Content",
    [0, 2, 0.6, 1],
    0
] call CBA_fnc_addSetting;

ADDON = true;

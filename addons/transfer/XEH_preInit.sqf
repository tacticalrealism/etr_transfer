#include "script_component.hpp"

ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

GVAR(initializedVehicleClasses) = [];
GVAR(massCache) = createHashMap;
GVAR(openedInventory) = objNull;

ADDON = true;

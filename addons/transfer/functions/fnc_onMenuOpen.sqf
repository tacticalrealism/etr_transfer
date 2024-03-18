#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display"];

// Lock inventories.
[GVAR(primaryInteraction), "lockInventory", QGVAR(transfering), true] call ace_common_fnc_statusEffect_set;
[GVAR(secondaryInteraction), "lockInventory", QGVAR(transfering), true] call ace_common_fnc_statusEffect_set;

// lock vehicle.
[GVAR(primaryInteraction), "blockEngine", QGVAR(transfering), true] call ace_common_fnc_statusEffect_set;
[GVAR(secondaryInteraction), "blockEngine", QGVAR(transfering), true] call ace_common_fnc_statusEffect_set;

// Get inventories contents.
GVAR(primaryCargo) = GVAR(primaryInteraction) call FUNC(getCargo);
GVAR(secondaryCargo) = GVAR(secondaryInteraction) call FUNC(getCargo);
GVAR(primaryVirtualCargo) =+ GVAR(primaryCargo);
GVAR(secondaryVirtualCargo) =+ GVAR(secondaryCargo);

// Get inventory load.
GVAR(primaryMaxLoad) = maxLoad GVAR(primaryInteraction);
GVAR(secondaryMaxLoad) = maxLoad GVAR(secondaryInteraction);
GVAR(primaryLoad) = loadAbs GVAR(primaryInteraction);
GVAR(secondaryLoad) = loadAbs GVAR(secondaryInteraction);

// Set primary (left) menu text.
(_display displayCtrl 250001) ctrlSetText ([GVAR(primaryInteraction), true] call ace_cargo_fnc_getNameItem);

// Set secondary (right) menu text.
(_display displayCtrl 250011) ctrlSetText ([GVAR(secondaryInteraction), true] call ace_cargo_fnc_getNameItem);

// Populate the primary (left) list.
["left"] call FUNC(populateList);

// Populate the secondary (right) list.
["right"] call FUNC(populateList);

// Set GVAR's
GVAR(shiftState) = false;
GVAR(ctrlState) = false;

nil
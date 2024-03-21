#include "script_component.hpp"

// Add for vehiclesClasses
private _vehicleClassesAddClassEH = call (uiNamespace getVariable ["ace_cargo_vehicleClasses_classEH", {[]}]);
{
    [_x, "initPost", DFUNC(initVehicle), nil, nil, true] call CBA_fnc_addClassEventHandler;
} forEach _vehicleClassesAddClassEH;

ACE_player addEventHandler ["InventoryOpened", {
    params ["_unit", "_container"];
    TRACE_2("Opened inventory",_unit,_container);
    GVAR(openedInventory) = _container;
}];

ACE_player addEventHandler ["InventoryClosed", {
    params ["_unit", "_container"];
    TRACE_2("Closed inventory",_unit,_container);
    GVAR(openedInventory) = objNull;
}];

["ace_common_lockInventory", {
    params ["_object", "_set"];
    private _locked = (_set > 0);
    if _locked then {
        if (GVAR(openedInventory) isEqualTo _object) then {
            TRACE_2("Kicked from inventory",_object,_set);
            (findDisplay 602) closeDisplay 0;
        };
    };
    _object setVariable ["ace_dragging_canDrag", !_locked];
    _object setVariable ["ace_dragging_canCarry", !_locked];
    _object setVariable ["ace_cargo_canLoad", !_locked];
}] call CBA_fnc_addEventHandler;

["ace_common_lockInventory", {
    params ["_object", "_set"];
    TRACE_2("lockInventory EH",_object,_set);
    _object lockInventory (_set > 0);
}] call CBA_fnc_addEventHandler;
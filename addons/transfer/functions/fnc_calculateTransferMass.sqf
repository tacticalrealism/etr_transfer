#include "script_component.hpp"
/*
 * Author: JasperRab
 * Calculates the transfer mass of the differences.
 *
 * Arguments:
 * 0: Differences <ARRAY of HASHMAPS>
 *
 * Return Value:
 * transfer mass <NUMBER>
 *
 * Example:
 * [] call etr_transfer_transfer_fnc_calculateTransferMass
 *
 * Public: No
 */


params [["_diffItems", []], ["_diffMagazines", []], ["_diffWeapons", []]];

TRACE_1("diff",_this);

private _mass = 0;

{
    _y params ["_item", "_amount"];
    _mass = _mass + (["item", _item] call FUNC(getMass)) * abs(_amount);
} forEach _diffItems;

{
    _y params ["_magazine", "_amount"];
    _mass = _mass + (["magazine", _magazine] call FUNC(getMass)) * abs(_amount);
} forEach _diffMagazines;

{
    _y params ["_weapon", "_amount"];
    _mass = _mass + (["weapon", _weapon] call FUNC(getMass)) * abs(_amount);
} forEach _diffWeapons;

// return
_mass
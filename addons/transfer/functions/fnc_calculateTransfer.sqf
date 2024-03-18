#include "script_component.hpp"
/*
 * Author: JasperRab
 * Calculates the transfer time of the differences. Also returns the total mass being moved.
 *
 * Arguments:
 * 0: Differences <ARRAY of HASHMAPS>
 *
 * Return Value:
 * transfer time and mass <ARRAY of NUMBERS>
 *
 * Public: No
 */

// item = 0.1 s.
// magazine = 0.3 s.
// weapon = 0.75 s.

params [["_diffItems", []], ["_diffMagazines", []], ["_diffWeapons", []]];

TRACE_1("diff",_this);

private _time = 0;
private _mass = 0;

{
	_y params ["_item", "_amount"];
	_time = _time + (0.1 * abs(_amount));
	_mass = _mass + (["item", _item] call FUNC(getMass)) * abs(_amount);
} forEach _diffItems;

{
	_y params ["_magazine", "_amount"];
	_time = _time + (0.3 * abs(_amount));
	_mass = _mass + (["magazine", _magazine] call FUNC(getMass)) * abs(_amount);
} forEach _diffMagazines;

{
	_y params ["_weapon", "_amount"];
	_time = _time + (0.75 * abs(_amount));
	_mass = _mass + (["weapon", _weapon] call FUNC(getMass)) * abs(_amount);
} forEach _diffWeapons;

// return
[_time, _mass]
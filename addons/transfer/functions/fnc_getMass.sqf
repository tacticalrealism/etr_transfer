#include "script_component.hpp"
/*
 * Author: JasperRab
 * Gets the mass of an item, magazine or weapon with attachments as a single entry.
 *
 * Arguments:
 * 0: Type <STRING>
 * 1: Data <ARRAY>
 *
 * Return Value:
 * None
 *
 * Example:
 * ["item", "ACE_Bandage"] call etr_transfer_transfer_fnc_getMass
 *
 * Public: No
 */

params ["_type", ["_data", ""]];

if (_data isEqualTo "") exitWith {0};
if (_data isEqualTo []) exitWith {0};

private _getMass = {
	private _mass = 0;
	switch (_type) do {
		case "item": {
			_data params ["_item"];
			_mass = getNumber (configFile >> "CfgWeapons" >> _item >> "ItemInfo" >> "mass");
		};
		case "magazine": {
			_data params ["_magazine"];
			_mass = getNumber (configFile >> "CfgMagazines" >> _magazine >> "mass");
		};
		case "weapon": {
			_data params ["_weapon", "_muzzle", "_flashlight", "_optics", "_primaryMagazine", "_secondaryMagazine", "_bipod"];
			_mass = getNumber (configFile >> "CfgWeapons" >> _weapon >> "WeaponSlotsInfo" >> "mass");
			_mass = _mass + (["item", _muzzle] call FUNC(getMass)); // getNumber (configFile >> "CfgWeapons" >> _muzzle >> "ItemInfo" >> "mass")
			_mass = _mass + (["item", _flashlight] call FUNC(getMass)); // getNumber (configFile >> "CfgWeapons" >> _flashlight >> "ItemInfo" >> "mass")
			_mass = _mass + (["item", _optics] call FUNC(getMass)); // getNumber (configFile >> "CfgWeapons" >> _optics >> "ItemInfo" >> "mass")
			_mass = _mass + (["magazine", _primaryMagazine#0] call FUNC(getMass)); // getNumber (configFile >> "CfgMagazines" >> _primaryMagazine#0 >> "mass")
			_mass = _mass + (["magazine", _secondaryMagazine#0] call FUNC(getMass)); // getNumber (configFile >> "CfgMagazines" >> _secondaryMagazine#0 >> "mass")
			_mass = _mass + (["item", _bipod] call FUNC(getMass)); // getNumber (configFile >> "CfgWeapons" >> _bipod >> "ItemInfo" >> "mass")
		};
	};
	// Return
	_mass
};

GVAR(massCache) getOrDefaultCall [_data, {[_type, _data] call _getMass}, true];
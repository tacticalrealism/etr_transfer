#include "script_component.hpp"
/*
 * Author: JasperRab
 * This function will add the given cargo into the inventory, most likely ignoring the load.
 *
 * Arguments:
 * 0: Inventory <OBJECT>
 * 1: Cargo <ARRAY of HASHMAPS> [items, magazines, weapons]
 *
 * Return Value:
 * true if successful.
 *
 * Example:
 * [myBox, thisCargo] call etr_transfer_transfer_fnc_addCargo
 *
 * Public: No
 */

params [["_inventory", objNull], ["_cargo", []]];

// Exit if object is null.
if (isNull _inventory) exitWith {false};

// Exit if no cargo is given.
if (_cargo isEqualTo []) exitWith {false};

_cargo params ["_items", "_magazines", "_weapons"];

// Add items.
{
	_y params ["_item", "_amount"];
	_inventory addItemCargoGlobal [_item, _amount];
} forEach _items;

// Add magazines.
{
	_y params ["_magazine", "_amount"];
	_magazine params ["_mag", "_rounds"];
	_inventory addMagazineAmmoCargo [_mag, _amount, _rounds];
} forEach _magazines;

// Add weapons.
private _weaponsCargo = weaponsItemsCargo _inventory;
// Go through all weapons and see if they are being added or removed.
{
	_y params ["_weapon", "_amount"];

	if (_amount < 0) then {
		// removing...
		for "_i" from 1 to abs(_amount) do {
			_weaponsCargo deleteAt (_weaponsCargo find _weapon);
		};
	} else {
		// adding...
		for "_i" from 1 to _amount do {
			_weaponsCargo pushBack _weapon;
		};
	}
} forEach _weapons;

// Clear all weapons.
clearWeaponCargoGlobal _inventory;

// Add back the ones that need to.
{
	_inventory addWeaponWithAttachmentsCargoGlobal [_x, 1];
} forEach _weaponsCargo;

true
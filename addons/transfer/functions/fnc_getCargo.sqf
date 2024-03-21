#include "script_component.hpp"
/*
 * Author: JasperRab
 * This function will return all cargo inside the inventory, excluding backpacks.
 *
 * Arguments:
 * 0: Inventory <OBJECT>
 *
 * Return Value:
 * Cargo <ARRAY of HASHMAPs> [items, magazines, weapons]
 *
 * Example:
 * [myBox] call etr_transfer_transfer_fnc_getCargo
 *
 * Public: No
 */

params [["_inventory", objNull]];

// Exit if object is null.
if (isNull _inventory) exitWith {[]};

// Create overall cargo array.
private _cargo = [];

// Create items hashmap.
private _items = createHashMap;

// Iterate over all items inside inventory.
{
    private _data = _items getOrDefault [_x, [_x, 0], true];
    _data params ["_item", "_amount"];
    // Add one for this item.
    _amount = _amount + 1;
    _items set [_x, [_item, _amount]];
} forEach itemCargo _inventory;

// Add items hashmap to cargo array.
_cargo pushBack _items;


// Create magazines hashmap.
private _magazines = createHashMap;

// Iterate over all magazines inside inventory.
{
    private _data = _magazines getOrDefault [str _x, [_x, 0], true];
    _data params ["_magazine", "_amount"];
    // Add one for this item.
    _amount = _amount + 1;
    _magazines set [str _x, [_magazine, _amount]];
} forEach magazinesAmmoCargo _inventory;

// Add magazines hashmap to cargo array.
_cargo pushBack _magazines;


// Create weapons hashmap.
private _weapons = createHashMap;

// Iterate over all weapons inside inventory.
{
    private _data = _weapons getOrDefault [str _x, [_x, 0], true];
    _data params ["_weapon", "_amount"];
    // Add one for this item.
    _amount = _amount + 1;
    _weapons set [str _x, [_weapon, _amount]];
} forEach weaponsItemsCargo _inventory;

// Add weapons hashmap to cargo array.
_cargo pushBack _weapons;

// Return cargo array.
_cargo
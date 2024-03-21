#include "script_component.hpp"
/*
 * Author: JasperRab
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: All <BOOL>
 *
 * Return Value:
 * None
 *
 * Example:
 * [[bob, ted], false] call etr_transfer_transfer_fnc_transferItems
 *
 * Public: No
 */

params ["_inventory", "_differences", "_transferMass", "_percentage"];

// If only up to a certain percentage has been transfered only do it until that precentage.
// else just do all of it.

//diag_log _this;

if (_percentage isEqualTo 1) exitWith {
    [_inventory, _differences] call FUNC(addCargo);
};

private _filtered = [createHashMap, createHashMap, createHashMap];

_differences params ["_diffItems", "_diffMagazines", "_diffWeapons"];
_filtered params ["_filtItems", "_filtMagazines", "_filtWeapons"];

private _maxMass = _transferMass * _percentage;
private _massTransferred = 0;


// transfer items
{
    _y params ["_item", "_amount"];
    _singleWeight = ["item", _item] call FUNC(getMass);

    private _dir = [-1, 1] select (_amount > 0);
    _amount = abs _amount;

    // Check if this amount can fit in the other inv. Remove one every cycle.
    while {(_massTransferred + abs(_singleWeight * _amount)) > _maxMass} do {
        _amount = _amount - 1;
    };

    if (_amount isEqualTo 0) then {continue};
    _filtItems set [_x, [_item, _amount*_dir]];
    _massTransferred = _massTransferred + abs(_singleWeight * _amount);
} forEach _diffItems;

// transfer magazines
{
    _y params ["_magazine", "_amount"];
    _singleWeight = ["magazine", _magazine] call FUNC(getMass);

    private _dir = [-1, 1] select (_amount > 0);
    _amount = abs _amount;

    // Check if this amount can fit in the other inv. Remove one every cycle.
    while {(_massTransferred + abs(_singleWeight * _amount)) > _maxMass} do {
        _amount = _amount - 1;
    };

    if (_amount isEqualTo 0) then {continue};
    _filtMagazines set [_x, [_magazine, _amount*_dir]];
    _massTransferred = _massTransferred + abs(_singleWeight * _amount);
} forEach _diffMagazines;

// transfer weapons
{
    _y params ["_weapon", "_amount"];
    _singleWeight = ["weapon", _weapon] call FUNC(getMass);

    private _dir = [-1, 1] select (_amount > 0);
    _amount = abs _amount;

    // Check if this amount can fit in the other inv. Remove one every cycle.
    while {(_massTransferred + abs(_singleWeight * _amount)) > _maxMass} do {
        _amount = _amount - 1;
    };

    if (_amount isEqualTo 0) then {continue};
    _filtWeapons set [_x, [_weapon, _amount*_dir]];
    _massTransferred = _massTransferred + abs(_singleWeight * _amount);
} forEach _diffWeapons;

TRACE_4("filtered",_filtered,_maxMass,_massTransferred,_percentage);

[_inventory, _filtered] call FUNC(addCargo);
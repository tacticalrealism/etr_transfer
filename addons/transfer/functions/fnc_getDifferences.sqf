#include "script_component.hpp"
/*
 * Author: JasperRab
 * Get's the differences between to the two arrays of hashmaps.
 *
 * Arguments:
 * 0: Original <ARRAY>
 * 1: Virtual <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_original", "_virtual"];

private _differences = [createHashMap, createHashMap, createHashMap];

_original params ["_originalItems", "_originalMagazines", "_originalWeapons"];
_virtual params ["_virtualItems", "_virtualMagazines", "_virtualWeapons"];
_differences params ["_diffItems", "_diffMagazines", "_diffVirtual"];

// Items
{
    private _og = _originalItems getOrDefault [_x, [_y#0, 0]];
    private _diff = (_y#1 - _og#1);
    if (_diff isEqualTo 0) then {continue};
    _diffItems set [_x, [_y#0, _diff]];
} forEach _virtualItems;

/*{
    private _og = _virtualItems getOrDefault [_x, [_y#0, 0]];
    private _diff = (_og#1 - _y#1);
    if (_diff isEqualTo 0) then {continue};
    _diffItems set [_x, [_y#0, _diff]];
} forEach _originalItems;*/

// Magazines
{
    private _og = _originalMagazines getOrDefault [_x, [_y#0, 0]];
    private _diff = (_y#1 - _og#1);
    if (_diff isEqualTo 0) then {continue};
    _diffMagazines set [_x, [_y#0, _diff]];
} forEach _virtualMagazines;

/*{
    private _og = _virtualMagazines getOrDefault [_x, [_y#0, 0]];
    private _diff = (_og#1 - _y#1);
    if (_diff isEqualTo 0) then {continue};
    _diffMagazines set [_x, [_y#0, _diff]];
} forEach _originalMagazines;*/

// Weapons
{
    private _og = _originalWeapons getOrDefault [_x, [_y#0, 0]];
    private _diff = (_y#1 - _og#1);
    if (_diff isEqualTo 0) then {continue};
    _diffVirtual set [_x, [_y#0, _diff]];
} forEach _virtualWeapons;

/*{
    private _og = _virtualWeapons getOrDefault [_x, [_y#0, 0]];
    private _diff = (_og#1 - _y#1);
    if (_diff isEqualTo 0) then {continue};
    _diffVirtual set [_x, [_y#0, _diff]];
} forEach _originalWeapons;*/

// return
_differences
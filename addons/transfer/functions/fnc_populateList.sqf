#include "script_component.hpp"
/*
 * Author: JasperRab
 * Function description
 *
 * Arguments:
 * 0: list <STRING>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_display, _cargo] call etr_transfer_transfer_fnc_populateList
 *
 * Public: No
 */

params ["_list"];

private ["_listControl", "_cargo", "_inventory", "_barControl", "_maxLoad"];

if (_list isEqualTo "left") then {
    _listControl = _display displayCtrl IDC_LEFT_LIST;
    _barControl = _display displayCtrl IDC_LEFT_BAR;
    _inventory = GVAR(primaryInteraction);
    _cargo = GVAR(primaryVirtualCargo);
    _maxLoad = GVAR(primaryMaxLoad);
} else {
    _listControl = _display displayCtrl IDC_RIGHT_LIST;
    _barControl = _display displayCtrl IDC_RIGHT_BAR;
    _inventory = GVAR(secondaryInteraction);
    _cargo = GVAR(secondaryVirtualCargo);
    _maxLoad = GVAR(secondaryMaxLoad);
};

_cargo params ["_items", "_magazines", "_weapons"];

private _mass = 0;
private _addMass = {
    params ["_type", "_data", "_amount"];
    if (_classname isEqualTo "") exitWith {nil};

    private _singleMass = [_type, _data] call FUNC(getMass);
    _mass = _mass + (_singleMass * _amount);
    nil
};

// Clear list.
lnbClear _listControl;

//diag_log [_listControl, diag_tickTime];

{
    _y params ["_item", "_amount"];
    if (_amount isEqualTo 0) then {continue};	// skip empty ones.
    ["item", _item, _amount] call _addMass;
    private _config = configFile >> "CfgWeapons" >> _item;

    private _row = _listControl lnbAddRow ["", getText (_config >> "displayName"), str _amount];
    _listControl lnbSetData [[_row, 0], _x];
    _listControl lnbSetPicture [[_row, 0], getText (_config >> "picture")];
} forEach _items;

{
    _y params ["_magazine", "_amount"];
    if (_amount isEqualTo 0) then {continue};	// skip empty ones.
    _magazine params ["_mag", "_rounds"];
    ["magazine", _mag, _amount] call _addMass;
    private _config = configFile >> "CfgMagazines" >> _mag;
    private _maxRounds = getNumber (_config >> "count");

    private _row = _listControl lnbAddRow ["", format ["%1 (%2/%3)", getText (_config >> "displayName"), _rounds, _maxRounds], str _amount];
    _listControl lnbSetData [[_row, 0], _x];
    _listControl lnbSetPicture [[_row, 0], getText (_config >> "picture")];
} forEach _magazines;

{
    // ["arifle_AK12_F","","","",["30Rnd_762x39_AK12_Mag_F",30],["",""],""]
    _y params ["_weaponArray", "_amount"];
    if (_amount isEqualTo 0) then {continue};	// skip empty ones.

    ["weapon", _weaponArray, _amount] call _addMass;
    _weaponArray params ["_weapon", "_muzzle", "_flashlight", "_optics", "_primaryMagazine", "_secondaryMagazine", "_bipod"];

    private _config = configFile >> "CfgWeapons" >> _weapon;
    private _text = getText (_config >> "displayName");

    if (_primaryMagazine isNotEqualTo []) then {
        _primaryMagazine params ["_mag", "_ammo"];
        private _config = configFile >> "CfgMagazines" >> _mag;
        _mag = getText (_config >> "displayName");
        private _maxAmmo = getNumber (_config >> "count");
        _text = _text + format [" | %1 (%2/%3)", _mag, _ammo, _maxAmmo];
    };

    if (_secondaryMagazine isNotEqualTo []) then {
        _secondaryMagazine params ["_mag", "_ammo"];
        private _config = configFile >> "CfgMagazines" >> _mag;
        _mag = getText (_config >> "displayName");
        private _maxAmmo = getNumber (_config >> "count");
        _text = _text + format [" | %1 (%2/%3)", _mag, _ammo, _maxAmmo];
    };
    
    private _row = _listControl lnbAddRow ["", _text, str _amount];
    _listControl lnbSetData [[_row, 0], _x];
    _listControl lnbSetPicture [[_row, 0], getText (_config >> "picture")];
} forEach _weapons;

_listControl lnbSort [1, false];

_barControl progressSetPosition (_mass/_maxLoad);
if (_mass*0.5 > ACE_maxWeightCarry) then {
    if (_mass*0.5 > ACE_maxWeightDrag) then {
        // Can't drag.
        if (getNumber ((configOf _inventory) >> "ace_dragging_canDrag") isEqualTo 1) then {
            _barControl ctrlSetTextColor [1, 0, 0, 1];
        };
    } else {
        // Can't carry.
        if (getNumber ((configOf _inventory) >> "ace_dragging_canCarry") isEqualTo 1) then {
            _barControl ctrlSetTextColor [1, 1, 0, 1];
        };
    };
} else {
    // Can do everything.
    _barControl ctrlSetTextColor [1, 1, 1, 1];
};

if (_list isEqualTo "left") then {
    GVAR(primaryLoad) = _mass;
} else {
    GVAR(secondaryLoad) = _mass;
};

//diag_log [_control, diag_tickTime];
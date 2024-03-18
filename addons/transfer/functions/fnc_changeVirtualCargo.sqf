#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: Objects <ARRAY>
 * 1: Control IDC <NUMBER>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_control", "_controlIDC"];

private _change = 1;
if GVAR(shiftState) then {
	_change = 5;
};

if GVAR(ctrlState) then {
	_change = _change * 10
};

private _display = ctrlParent _control;
private _listControl = _display displayCtrl _controlIDC;

private _selectedRow = lnbCurSelRow _listControl;
private _value = (_listControl lnbData [_selectedRow, 0]);

//diag_log [_controlIDC , _value, _change, _selectedRow];

// Exit if no value, eg. no row selected.
if (_value isEqualTo "") exitWith {nil};

switch _controlIDC do {
	case (250002): {
		// Left list.
		//diag_log "left";

		// Find data.
		private _data = GVAR(primaryVirtualCargo)#0 getOrDefault [_value, ""];
		private _index = 0;
		if (_data isEqualTo "") then {
			_data = GVAR(primaryVirtualCargo)#1 getOrDefault [_value, ""];
			_index = 1;
			if (_data isEqualTo "") then {
				_data = GVAR(primaryVirtualCargo)#2 getOrDefault [_value, ""];
				_index = 2;
			};
		};

		_data params ["_array", "_amountLeft"];
		private _singleWeight = [["item", "magazine", "weapon"] select _index, _array] call FUNC(getMass);

		// Limit the change to the amount that is left.
		if (_change > _amountLeft) then {
			_change = _amountLeft;
		};

		// Check if this amount can fit in the right. Remove one every cycle.
		while {(GVAR(secondaryLoad) + (_singleWeight * _change)) > GVAR(secondaryMaxLoad)} do {
			_change = _change - 1;
		};

		if (_change isEqualTo 0) exitWith {};

		//diag_log [_array, _amountLeft, _change, _singleWeight];
		
		// Remove from left list.
		private _newAmountLeft = _amountLeft - _change;
		if (_newAmountLeft > 0) then {
			GVAR(primaryVirtualCargo)#_index set [_value, [_array, _newAmountLeft]];
		} else {
			GVAR(primaryVirtualCargo)#_index set [_value, [_array, 0]];
		};

		//diag_log [_data, _newAmountLeft, _index];

		// Get amount from right list.
		private _data = GVAR(secondaryVirtualCargo)#_index getOrDefault [_value, [_array, 0]];

		_data params ["", "_amountRight"];

		// Add value to right list.
		GVAR(secondaryVirtualCargo)#_index set [_value, [_array, _amountRight + _change]];

		//diag_log [_data, _amountRight + _change];
	};
	case (250012): {
		// Right list.
		//diag_log "right";

		// Find data.
		private _data = GVAR(secondaryVirtualCargo)#0 getOrDefault [_value, ""];
		private _index = 0;
		if (_data isEqualTo "") then {
			_data = GVAR(secondaryVirtualCargo)#1 getOrDefault [_value, ""];
			_index = 1;
			if (_data isEqualTo "") then {
				_data = GVAR(secondaryVirtualCargo)#2 getOrDefault [_value, ""];
				_index = 2;
			};
		};

		_data params ["_array", "_amountRight"];
		private _singleWeight = [["item", "magazine", "weapon"] select _index, _array] call FUNC(getMass);

		// Limit the change to the amount that is left.
		if (_change > _amountRight) then {
			_change = _amountRight;
		};

		// Check if this amount can fit in the right. Remove one every cycle.
		while {(GVAR(primaryLoad) + (_singleWeight * _change)) > GVAR(primaryMaxLoad)} do {
			_change = _change - 1;
		};

		if (_change isEqualTo 0) exitWith {};

		//diag_log [_array, _amountRight, _change, _singleWeight];
		
		// Remove from right list.
		private _newAmountRight = _amountRight - _change;
		if (_newAmountRight > 0) then {
			GVAR(secondaryVirtualCargo)#_index set [_value, [_array, _newAmountRight]];
		} else {
			GVAR(secondaryVirtualCargo)#_index set [_value, [_array, 0]];
		};

		//diag_log [_data, _newAmountRight, _index];

		// Get amount from left list.
		private _data = GVAR(primaryVirtualCargo)#_index getOrDefault [_value, [_array, 0]];

		
		_data params ["", "_amountLeft"];

		// Add value to left list.
		GVAR(primaryVirtualCargo)#_index set [_value, [_array, _amountLeft + _change]];

		//diag_log [_data, _amountLeft + _change];
	};
};

// Re-populate lists.
["left"] call FUNC(populateList);
["right"] call FUNC(populateList);

nil
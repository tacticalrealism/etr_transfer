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
 * [[bob, ted], false] call etr_transfer_transfer_fnc_initVehicle
 *
 * Public: No
 */

params ["_vehicle"];
private _type = typeOf _vehicle;

// Servers and HCs do not require action menus (beyond this point)
if !(hasInterface) exitWith {};

// Unnecessary to add actions to an vehicle class that's already got them
if (_type in GVAR(initializedVehicleClasses)) exitWith {};

// If vehicle has no inventory don't add option, shouldn't be though but just incase
private _hasInventory = (getNumber (configFile >> "CfgVehicles" >> _type >> "maximumLoad") > 0);
if !(_hasInventory) exitWith {};

// create and add action
private _action = [QGVAR(Transfer),"Transfer Content","",
    {},
    {
		[_player, _target, []] call FUNC(canInteractWith)
    },
    {
		_this call FUNC(addChildActions);
	}, objNull
] call ace_interact_menu_fnc_createAction;

GVAR(initializedVehicleClasses) pushBack _type;
[_type, 0, ["ACE_MainActions"], _action] call ace_interact_menu_fnc_addActionToClass;

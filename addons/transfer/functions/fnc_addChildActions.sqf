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
 * [[bob, ted], false] call etr_transfer_transfer_fnc_addChildActions
 *
 * Public: No
 */

params ["_target", "_player", "_params"];

private _vehicleClassesAddClassEH = call (uiNamespace getVariable ["ace_cargo_vehicleClasses_classEH", {[]}]);
// Scan for all nearby inventories.
private _objects = nearestObjects [_target, _vehicleClassesAddClassEH, 10];

// Remove the primary inventory/object.
_objects = _objects - [_target];

// Add children to this action
private _actions = [];
{
	// Filter if object has an inventory
	if !([_player, _x] call FUNC(canInteractWith)) then {continue};

	private _distance = [_x distance _target, 0, 1] call CBA_fnc_formatNumber;   

	private _childStatement = {
		params ["_target", "", "_childTarget"];
		GVAR(primaryInteraction) = _target;
		GVAR(secondaryInteraction) = _childTarget;
		createDialog QGVAR(transferMenu);
	};
	private _objectName = ([_x, true] call ace_cargo_fnc_getNameItem);
	private _action = [_objectName, format ["%1 (%2m)", _objectName, _distance], "", _childStatement, {true}, {}, _x] call ace_interact_menu_fnc_createAction;
	_actions pushBack [_action, [], _target]; // New action, it's children, and the action's target
} forEach _objects;

_actions
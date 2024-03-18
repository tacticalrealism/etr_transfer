#include "script_component.hpp"
/*
 * Author: <author>
 * Function description
 *
 * Arguments:
 * 0: unit <OBJECT>
 * 1: target <OBJECT>
 *
 * Return Value:
 * None
 *
 * Example:
 * [bob, tank] call etr_transfer_transfer_fnc_canInteractWith
 *
 * Public: No
 */

params ["_unit", "_target", ["_exceptions", []]];

([_unit, _target, []] call ace_common_fnc_canInteractWith) &&
{getNumber (configFile >> "CfgVehicles" >> typeOf _target >> "maximumLoad") > 0 &&
{((speed  _target) < 1) &&
{!(lockedInventory _target) &&
{alive _target}}}}


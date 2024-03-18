#include "script_component.hpp"
/*
 * Author: JasperRab
 * Handles keyboard input in transfer menu.
 *
 * Arguments:
 * 0: Display <DISPLAY>
 * 1: Key being pressed <NUMBER>
 * 2: Shift state <BOOL>
 * 3: Ctrl state <BOOL>
 * 4: Alt state <BOOL>
 *
 * Return Value:
 * None
 *
 * Public: No
 */

params ["_display", "_keyPressed", "_shiftState", "_ctrlState", "_altState"];

GVAR(shiftState) = _shiftState;
GVAR(ctrlState) = _ctrlState;
#include "script_component.hpp"
/*
 * Author: JasperRab
 * Clears all GVARs after use of the transfer menu.
 *
 * Arguments:
 *
 * Return Value:
 * None
 *
 * Public: No
 */


GVAR(shiftState) = nil;
GVAR(ctrlState) = nil;
GVAR(primaryLoad) = nil;
GVAR(secondaryLoad) = nil;
GVAR(primaryMaxLoad) = nil;
GVAR(secondaryMaxLoad) = nil;
GVAR(primaryCargo) = nil;
GVAR(secondaryCargo) = nil;
GVAR(primaryVirtualCargo) = nil;
GVAR(secondaryVirtualCargo) = nil;
GVAR(primaryInteraction) = nil;
GVAR(secondaryInteraction) = nil;

nil
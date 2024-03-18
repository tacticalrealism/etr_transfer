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
 * Public: No
 */

params ["_display", ["_exitCode", 2]];

switch (_exitCode) do {
	case 1: {
		// Transfer

		[] spawn {
			uisleep .1;

			TRACE_2("ent",GVAR(primaryCargo),GVAR(primaryVirtualCargo));

			// Get differences.
			private _primaryDiff = [GVAR(primaryCargo), GVAR(primaryVirtualCargo)] call FUNC(getDifferences);
			private _secondaryDiff = [GVAR(secondaryCargo), GVAR(secondaryVirtualCargo)] call FUNC(getDifferences);

			// Calculations will be made from primary's perspective.
			private _transferData = _primaryDiff call FUNC(calculateTransfer);

			_transferData params ["_time", "_mass"];
			TRACE_3("Transfer data",_time,_mass,(_mass/25));

			// Only take 2/3 of mass calculation for time.
			[((_mass*(1/2.2046))/10)*(2/3), [_primaryDiff, _secondaryDiff, _mass], {
				params ["_args"];
				_args params ["_primaryDiff", "_secondaryDiff"];

				[GVAR(primaryInteraction), _primaryDiff] call FUNC(addCargo);
				[GVAR(secondaryInteraction), _secondaryDiff] call FUNC(addCargo);

				// Clear GVAR's
				call FUNC(clearVars);
			}, {
				params ["_args", "_elapsedTime", "_totalTime"];
				_args params ["_primaryDiff", "_secondaryDiff", "_mass"];

				[GVAR(primaryInteraction), _primaryDiff, _mass, _elapsedTime/_totalTime] call FUNC(transferItems);
				[GVAR(secondaryInteraction), _secondaryDiff, _mass, _elapsedTime/_totalTime] call FUNC(transferItems);

				// Clear GVAR's
				call FUNC(clearVars);
			}, "Transferring"] call ace_common_fnc_progressBar;
		};

		

	};
	case 2;
	default {
		// Cancel

		// Unlock inventories.
		[GVAR(primaryInteraction), "lockInventory", QGVAR(transfering), false] call ace_common_fnc_statusEffect_set;
		[GVAR(secondaryInteraction), "lockInventory", QGVAR(transfering), false] call ace_common_fnc_statusEffect_set;
		[GVAR(primaryInteraction), "blockEngine", QGVAR(transfering), false] call ace_common_fnc_statusEffect_set;
		[GVAR(secondaryInteraction), "blockEngine", QGVAR(transfering), false] call ace_common_fnc_statusEffect_set;

		// Clear GVAR's
		call FUNC(clearVars);
	};
};

nil
#include "RscCommon.hpp"

// MAIN MACROS
#define displayX safeZoneX+safeZoneW*(0.25/2)
#define displayY safeZoneY+safeZoneH*(0.25/2)
#define displayW safeZoneW*0.7
#define displayH safeZoneH*0.72

// LEFT MACROS
#define leftX displayX
#define leftY displayY
#define leftW displayW*0.495
#define leftH displayH

#define leftMenuX leftX
#define leftMenuY leftY
#define leftMenuW leftW
#define leftMenuH leftH*0.05

#define leftListX leftX
#define leftListY leftY+leftMenuH
#define leftListW leftW
#define leftListH leftH*0.925

#define leftBarW leftW
#define leftBarH leftH*0.025
#define leftBarX leftX
#define leftBarY leftY+leftMenuH+leftListH

// RIGHT MACROS
#define rightX displayX+leftW+displayW*0.01
#define rightY displayY
#define rightW displayW*0.495
#define rightH displayH

#define rightMenuX rightX
#define rightMenuY rightY
#define rightMenuW rightW
#define rightMenuH rightH*0.05

#define rightListX rightX
#define rightListY rightY+rightMenuH
#define rightListW rightW
#define rightListH rightH*0.925

#define rightBarW rightW
#define rightBarH rightH*0.025
#define rightBarX rightX
#define rightBarY rightY+rightMenuH+rightListH

// BOTTOM MACROS
#define bottomX displayX
#define bottomY displayY+displayH*0.8+displayH*0.01
#define bottomW displayW
#define bottomH displayH*0.2

#define bottomHeaderX bottomX
#define bottomHeaderY bottomY
#define bottomHeaderW bottomW
#define bottomHeaderH bottomH*0.15

#define bottomBtnLeftX bottomX+bottomW*0.25
#define bottomBtnLeftY bottomY+bottomH*0.275
#define bottomBtnLeftW bottomW*0.03
#define bottomBtnLeftH bottomH*0.35

#define bottomBtnRightX bottomX+bottomW*0.75
#define bottomBtnRightY bottomY+bottomH*0.275
#define bottomBtnRightW bottomW*0.03
#define bottomBtnRightH bottomH*0.35

#define bottomEditX bottomX+bottomHeaderW*0.375
#define bottomEditY bottomY+bottomH*0.25
#define bottomEditW bottomW*0.25
#define bottomEditH bottomH*0.4

#define bottomSliderX bottomX+bottomW*0.01
#define bottomSliderY bottomY+bottomH-bottomH*0.275
#define bottomSliderW bottomW*0.98
#define bottomSliderH bottomH*0.175

// BUTTON MACROS
#define buttonX displayX
#define buttonY displayY+displayH+displayH*0.005
#define buttonW displayW
#define buttonH displayH*0.045

#define buttonCancelX buttonX
#define buttonCancelY buttonY
#define buttonCancelW buttonW*0.495
#define buttonCancelH buttonH

#define buttonTransferX buttonX+buttonCancelW+buttonW*0.01
#define buttonTransferY buttonY
#define buttonTransferW buttonW*0.495
#define buttonTransferH buttonH

class ctrlDefault;
class ctrlDefaultText;
class ctrlDefaultButton;
class ctrlButton;
class ctrlListNBox;
class ACE_gui_backgroundBase;
class ACE_gui_buttonBase;

class GVAR(transferMenu) {
	idd = IDD_MAINDISPLAY;
	enableSimulation = 1;
    onLoad = QUOTE(_this call FUNC(onMenuOpen));
	onUnload = QUOTE(_this call FUNC(onMenuClose));
	onKeyDown = QUOTE(_this call FUNC(onKeyDown));
    onKeyUp = QUOTE(etr_transfer_transfer_shiftState = (_this select 2); etr_transfer_transfer_ctrlState = (_this select 3));

	class ControlsBackground {
        class Background: ACE_gui_backgroundBase {
            idc = -1;
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
            x = QUOTE(displayX);
            y = QUOTE(displayY);
            w = QUOTE(displayW);
            h = QUOTE(displayH);
            text = "#(argb,8,8,3)color(0,0,0,0.8)";
        };
	};

	class controls {
        class leftMenu {
			idc = IDC_LEFT_MENU;
            type = CT_STATIC;
			x = QUOTE(leftMenuX);
			y = QUOTE(leftMenuY);
			w = QUOTE(leftMenuW);
			h = QUOTE(leftMenuH);
            style = ST_SHADOW;
            font = "RobotoCondensed";
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1)";
            colorText[] = {0.95, 0.95, 0.95, 0.75};
            colorBackground[] = {"(profilenamespace getVariable ['GUI_BCG_RGB_R',0.69])","(profilenamespace getVariable ['GUI_BCG_RGB_G',0.75])","(profilenamespace getVariable ['GUI_BCG_RGB_B',0.5])", "(profilenamespace getVariable ['GUI_BCG_RGB_A',0.9])"};
            text = "";
        };
		
		class fakeButton: ctrlButton {
			idc=313103;
			text="";
			x=0;
			y=0;
			w=0;
			h=0;
			colorBackground[]={0,0,0,0};
			colorBackgroundDisabled[]={0,0,0,0};
			colorBackgroundActive[]={0,0,0,0};
			colorFocused[]={0,0,0,0};
		};

        class leftList: ctrlListNBox {
			//type = 102;
			//style="0x01 + 0x10";
            idc = IDC_LEFT_LIST;
            x = QUOTE(leftListX);
			y = QUOTE(leftListY);
			w = QUOTE(leftListW);
			h = QUOTE(leftListH);
			//drawSideArrows=1;
			idcLeft=313103;
			idcRight=313102;
			columns[]={0.050000001,0.15000001,0.85000002};
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
            rowHeight = 0.04;
            colorBackground[] = {0, 0, 0, 0.2};
            colorText[] = {1, 1, 1, 1.0};
            colorScrollbar[] = {0.95, 0.95, 0.95, 1};
            colorSelect[] = {1, 1, 1, 1.0};
            colorSelect2[] = {1, 1, 1, 1.0};
            colorSelectBackground[] = {0.3, 0.3, 0.3, 1.0};
            colorSelectBackground2[] = {0.3, 0.3, 0.3, 1.0};
        };
		
		class leftListRight: ctrlButton {
			idc=313102;
			text=">";
			font="RobotoCondensedBold";
			x=-1;
			y=-1;
			w="5 * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			onButtonClick = QUOTE((_this+[IDC_LEFT_LIST]) call FUNC(changeVirtualCargo));
		};

        class leftBar {
            idc = IDC_LEFT_BAR;
            x = QUOTE(leftBarX);
			y = QUOTE(leftBarY);
			w = QUOTE(leftBarW);
			h = QUOTE(leftBarH);
        	deletable = 0;
        	fade = 0;
        	access = 0;
        	type = CT_PROGRESS;
        	style = ST_HORIZONTAL;
        	colorFrame[] = {1,1,1,0.4};
        	colorBar[] = {1,1,1,1};
        	shadow = 2;
        	texture = "#(argb,8,8,3)color(1,1,1,1)";
        };

        class rightMenu: leftMenu {
			idc = IDC_RIGHT_MENU;
			x = QUOTE(rightMenuX);
			y = QUOTE(rightMenuY);
			w = QUOTE(rightMenuW);
			h = QUOTE(rightMenuH);
        };

        class rightList: leftList {
            idc = IDC_RIGHT_LIST;
            x = QUOTE(rightListX);
			y = QUOTE(rightListY);
			w = QUOTE(rightListW);
			h = QUOTE(rightListH);
			idcLeft=313104;
			idcRight=313103;
        };
		
		class rightListLeft: ctrlButton {
			idc=313104;
			text="<";
			font="RobotoCondensedBold";
			x=-1;
			y=-1;
			w="5 * (pixelW * pixelGrid * 	0.50)";
			h="5 * (pixelH * pixelGrid * 	0.50)";
			onButtonClick = QUOTE((_this+[IDC_RIGHT_LIST]) call FUNC(changeVirtualCargo));
		};

        class rightBar: leftBar {
            idc = IDC_RIGHT_BAR;
            x = QUOTE(rightBarX);
			y = QUOTE(rightBarY);
			w = QUOTE(rightBarW);
			h = QUOTE(rightBarH);
        };

        class btnCancel: ACE_gui_buttonBase {
            text = "$STR_DISP_CANCEL";
            idc = -1;
            x = QUOTE(buttonCancelX);
            y = QUOTE(buttonCancelY);
            w = QUOTE(buttonCancelW);
            h = QUOTE(buttonCancelH);
            size = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 1.1)";
            SizeEx = "(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) * 0.7)";
            animTextureNormal = "#(argb,8,8,3)color(0,0,0,0.9)";
            animTextureDisabled = "#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureOver = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
            animTexturePressed = "#(argb,8,8,3)color(1,1,1,1)";
            animTextureDefault = "#(argb,8,8,3)color(1,1,1,1)";
            color[] = {1,1,1,1};
            color2[] = {0,0,0,1};
            colorBackgroundFocused[] = {1,1,1,1};
            colorBackground[] = {1,1,1,1};
            colorbackground2[] = {1,1,1,1};
            colorDisabled[] = {1,1,1,1};
            colorFocused[] = {0,0,0,1};
            periodFocus = 1;
            periodOver = 1;
            action = QUOTE(closeDialog 2);
        };

        class btnTransfer: btnCancel {
            text = "Transfer";
            idc = -1;
            y = QUOTE(buttonTransferY);
            x = QUOTE(buttonTransferX);
            w = QUOTE(buttonTransferW);
            h = QUOTE(buttonTransferH);
            action = QUOTE(closeDialog 1);
        };
	};
};

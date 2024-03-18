#define COMPONENT transfer
#define COMPONENT_BEAUTIFIED Transfer
#include "\z\etr_transfer\addons\main\script_mod.hpp"

#ifdef CMD__DEV_TRANSFER
    #define DEBUG_MODE_FULL
    #define DISABLE_COMPILE_CACHE
    // #define ENABLE_PERFORMANCE_COUNTERS
#endif

#include "\z\etr_transfer\addons\main\script_macros.hpp"


// UI defines.
#define IDD_MAINDISPLAY 250000

#define IDC_LEFT_MENU 250001
#define IDC_LEFT_LIST 250002
#define IDC_LEFT_BAR 250003

#define IDC_RIGHT_MENU 250011
#define IDC_RIGHT_LIST 250012
#define IDC_RIGHT_BAR 250013

#define IDC_BOTTOM_EDIT 250021
#define IDC_BOTTOM_SLIDER 250022
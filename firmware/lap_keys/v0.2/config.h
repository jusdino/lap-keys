#ifndef CONFIG_H
#define CONFIG_H

#include "config_common.h"

/* USB Device descriptor parameter */
#define VENDOR_ID       0x6a75
#define PRODUCT_ID      0x0000
#define DEVICE_VER      0x0000
#define MANUFACTURER    Jusdino
#define PRODUCT         prototype
#define DESCRIPTION     Jusdinos working keyboard space

/* key matrix size */
#define MATRIX_ROWS 5
#define MATRIX_COLS 12

/* mine PCB default pin-out */
#define MATRIX_ROW_PINS { D7, E6, B4, B5, B7 }
#define MATRIX_COL_PINS { C6, D4, D0, D1, D2, D3, F1, F0, F6, F5, F4, B6 }
#define UNUSED_PINS

/* COL2ROW or ROW2COL */
#define DIODE_DIRECTION ROW2COL

/* PMW3360 */
#define PMW_SS 0
#define CPI 16

#endif

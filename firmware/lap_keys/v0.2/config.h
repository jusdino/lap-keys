#pragma once

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
#define MATRIX_ROW_PINS { F0, F7, F6, F5, F4 }
#define MATRIX_COL_PINS { D3, B5, D0, D2, B4, E6, D5, D1, C6, D7, D4, B7 }
#define UNUSED_PINS

/* COL2ROW or ROW2COL */
#define DIODE_DIRECTION ROW2COL

/* OPTIMIZATIONS */
#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

/* PMW3360 */
/*#define SPI_DEBUG*/
#define PMW_SS B6
#define CPI 1600
#define SPI_DIVISOR 2

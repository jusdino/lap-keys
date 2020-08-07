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
#define MATRIX_ROW_PINS { B12, A15, A8, A7, A6 }
#define MATRIX_COL_PINS { A2, A1, A0, B8, B10, B11, A9, A10, B7, B6, B5, B4 }
#define UNUSED_PINS

/* COL2ROW or ROW2COL */
#define DIODE_DIRECTION ROW2COL

/* OPTIMIZATIONS */
#define NO_ACTION_MACRO
#define NO_ACTION_FUNCTION

/* PMW3360 */
#define SPI_DEBUG
#define PMW_SS B9
#define CPI 1600


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
#define MATRIX_COLS 6

/* mine PCB default pin-out */
#define MATRIX_ROW_PINS { D4, D3, D2, D1, D0 }
#define MATRIX_COL_PINS { B0, B1, B2, B3, F4, F5 }
#define UNUSED_PINS

/* COL2ROW or ROW2COL */
#define DIODE_DIRECTION ROW2COL

#endif

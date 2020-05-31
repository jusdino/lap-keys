#ifndef CONFIG_H
#define CONFIG_H

#include "config_common.h"

/* USB Device descriptor parameter */
#define VENDOR_ID       0xFEED
#define PRODUCT_ID      0x0007
#define DEVICE_VER 		0x0001
#define MANUFACTURER    Jusdino
#define PRODUCT         prototype
#define DESCRIPTION     Jusdinos working keyboard space

/* key matrix size */
#define MATRIX_ROWS 3
#define MATRIX_COLS 3

/* mine PCB default pin-out */
#define MATRIX_ROW_PINS { D0, D1, D2 }
#define MATRIX_COL_PINS { B2, B1, B0 }
#define UNUSED_PINS

/* ws2812 RGB LED */
#define RGB_DI_PIN F7

#define RGBLED_NUM 1    // Number of LEDs

/* COL2ROW or ROW2COL */
#define DIODE_DIRECTION ROW2COL

#define TAPPING_TERM 200

#endif

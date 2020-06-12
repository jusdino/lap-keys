/*
 * Adapted from https://github.com/SunjunKim/PMW3360/blob/master/examples/HID_mouse/HID_mouse.ino
 *
# PIN CONNECTION
  * MI = MISO
  * MO = MOSI
  * SS = Slave Select / Chip Select
  * SC = SPI Clock
  * MT = Motion (active low interrupt line)
  * RS = Reset
  * GD = Ground
  * VI = Voltage in up to +5.5V 

  # PMW3360 Module
Module   Arduino
  RS --- (NONE)
  GD --- GND
  MT --- (NONE)
  SS --- Pin_10   (use this pin to initialize a PMW3360 instance)
  SC --- SCK 
  MO --- MOSI
  MI --- MISO
  VI --- 5V

  # Button switches
  Button 1: Common pin - GND / Normally Open pin - Arduino Pin_2
  Button 2: Common pin - GND / Normally Open pin - Arduino Pin_3

  # PMW3360_DATA struct format and description
  - PMW3360_DATA.isMotion      : bool, True if a motion is detected. 
  - PMW3360_DATA.isOnSurface   : bool, True when a chip is on a surface 
  - PMW3360_DATA.dx, data.dy   : integer, displacement on x/y directions.
  - PMW3360_DATA.SQUAL         : byte, Surface Quality register, max 0x80
                               * Number of features on the surface = SQUAL * 8
  - PMW3360_DATA.rawDataSum    : byte, It reports the upper byte of an 18‐bit counter 
                               which sums all 1296 raw data in the current frame;
                               * Avg value = Raw_Data_Sum * 1024 / 1296
  - PMW3360_DATA.maxRawData    : byte, Max/Min raw data value in current frame, max=127
    PMW3360_DATA.minRawData
  - PMW3360_DATA.shutter       : unsigned int, shutter is adjusted to keep the average
                               raw data values within normal operating ranges.
*/

// User define values
#include "matrix.h"
#include "pointing_device.h"
#include "PMW3360.h"

void matrix_init_custom(void) {
  //pmw_begin(10, 1600); // to set CPI (Count per Inch), pass it as the second parameter
  pmw_begin(PMW_SS);  // 10 is the pin connected to SS of the module.
}

bool matrix_scan_custom(matrix_row_t current_matrix[]) {
  bool matrix_has_changed = false;
    
  struct PMW3360_DATA data = read_burst();
  if(data.isOnSurface && data.isMotion)
  {
    int16_t mdx = constrain(data.dx, -127, 127);
    int16_t mdy = constrain(data.dy, -127, 127);
    report_mouse_t currentReport = pointing_device_get_report();
    currentReport.x = (int)mdx;
    currentReport.y = (int)mdy;
    pointing_device_set_report(currentReport);
  }
    
  return matrix_has_changed;
}


#include "v0.2.h"

void matrix_init_kb(void) {
  pmw_begin();
}

void matrix_scan_kb(void) {
  struct PMW3360_DATA data = read_burst();
  uprintf("", data);
  // uprintf("isMotion: %d isOnSurface: %d x: %d y: %d\n", data.isMotion, data.isOnSurface, data.dx, data.dy);
  // if(data.isOnSurface && data.isMotion)
  // {

  //   int16_t mdx = constrain(data.dx, -127, 127);
  //   int16_t mdy = constrain(data.dy, -127, 127);
  //   report_mouse_t currentReport = pointing_device_get_report();
  //   currentReport.x = (int)mdx;
  //   currentReport.y = (int)mdy;
  //   pointing_device_set_report(currentReport);
  // }
  matrix_scan_user();
}


#include "v0.2.h"

void pointing_device_init(void) {
  pmw_begin();
}

void pointing_device_task(void) {
  struct PMW3360_DATA data = read_burst();

  if(data.isOnSurface && data.isMotion)
  {

    int16_t mdy = constrain(data.dx, -127, 127);
    int16_t mdx = -constrain(data.dy, -127, 127);
    report_mouse_t currentReport = pointing_device_get_report();
    currentReport.x = (int)mdx;
    currentReport.y = (int)mdy;
    pointing_device_set_report(currentReport);
  }
  pointing_device_send();
}


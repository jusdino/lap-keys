# Keyboard Firmware

This firmware has been developed to use the [QMK Framework](https://docs.qmk.fm/#/) to program the MicroController Unit (MCU) that drives the keyboards in this repo. To use these firmware versions, copy (or softlink) the named keyboard directories into the QMK repository under `keyboards` and use them as described in the QMK documentation.

Keyboard firmwares:

## lap_keys
This firmware will drive the 60-key (5x12) keyboards in this project. The versions are:
- **v0.1**:
  Written for an [Elite-C MCU](https://keeb.io/products/elite-c-low-profile-version-usb-c-pro-micro-replacement-atmega32u4). Just keys. Very basic firmware with the keymap I worked out for the **split-sixty-percent** board.
- **v0.2**:
  Written for an [Elite-C MCU](https://keeb.io/products/elite-c-low-profile-version-usb-c-pro-micro-replacement-atmega32u4). Introduces the driver for the PMW3360 sensor used for a trackball.

## 3_by_3
Firmware to test out a quick numpad-like prototype for learning purposes

## right_sixty_percent
Firmware to test out half of a sixty-percent keyboard
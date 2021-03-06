#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* LAYER 0
 * ,-----------------------------------------------. ,-----------------------------------------------.
 * |   `   |   1   |   2   |   3   |   4   |   5   | |   6   |   7   |   8   |   9   |   0   |  BKSP |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * |  TAB  |   Q   |   W   |   E   |   R   |   T   | |   Y   |   U   |   I   |   O   |   P   |   \   |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * | CLCK  |   A   |   S   |   D   |   F   |   G   | |   H   |   J   |   K   |   L   |   :   |   '   |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * | SHIFT |   Z   |   X   |   C   |   V   |   B   | |   N   |   M   |   ,   |   .   |   /   | SHIFT |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * | CTRL  |  ALT  |  WIN  | LAYER |  ESC  |  SPC  | |  SPC  | ENTER |  HOME |  END  |  ALT  |  CTRL |
 * `-----------------------------------------------' `-----------------------------------------------'
 */
[0] = LAYOUT( \
  KC_GRV,   KC_1,    KC_2,      KC_3,  KC_4,   KC_5,     KC_6,    KC_7,    KC_8,     KC_9,    KC_0,    KC_BSPACE, \
  KC_TAB,   KC_Q,    KC_W,      KC_E,  KC_R,   KC_T,     KC_Y,    KC_U,    KC_I,     KC_O,    KC_P,    KC_BSLS, \
  KC_CLCK,  KC_A,    KC_S,      KC_D,  KC_F,   KC_G,     KC_H,    KC_J,    KC_K,     KC_L,    KC_SCLN, KC_QUOT, \
  KC_LSFT,  KC_Z,    KC_X,      KC_C,  KC_V,   KC_B,     KC_N,    KC_M,    KC_COMMA, KC_DOT,  KC_SLSH, KC_RSFT, \
  KC_LCTRL, KC_LALT, KC_LGUI,   MO(1), KC_ESC, KC_SPC,   KC_SPC,  KC_ENT,  KC_HOME,  KC_END,  KC_RALT, KC_RCTL \
),

/* LAYER 1
 * ,-----------------------------------------------. ,-----------------------------------------------.
 * |   F1  |   F2  |  F3   |  F4   |  F5   |  F6   | |  F7   |  F8   |  F9   |  F10  |  F11  |  F12  |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * |       |       |       |       |       |       | |       |       |       |       |       |  DEL  |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * |       |       |       |       |       |       | |  LEFT | DOWN  |  UP   | RIGHT |       |       |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * | ----- |       |       |       |       |       | |       |  -/_  |  =/+  |  [/{  |  ]/}  | ----- |
 * |-------+-------+-------+-------+-------+-------| |-------+-------+-------+-------+-------+-------|
 * | ----- | ----- | ----- | ----- |       |       | |       |       | ----- | ----- | ----- | ----- |
 * `-----------------------------------------------' `-----------------------------------------------'
 */
[1] = LAYOUT( \
  KC_F1,   KC_F2,   KC_F3,   KC_F4,   KC_F5,   KC_F6,      KC_F7,     KC_F8,     KC_F9,     KC_F10,    KC_F11,   KC_F12, \
  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,      KC_NO,     KC_NO,     KC_NO,     KC_NO,     KC_NO,    KC_DEL, \
  KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,      KC_LEFT,   KC_DOWN,   KC_UP,     KC_RGHT,   KC_NO,    KC_NO, \
  KC_TRNS, KC_NO,   KC_NO,   KC_NO,   KC_NO,   KC_NO,      KC_NO,    KC_MINS,   KC_EQL,    KC_LBRC,   KC_RBRC,   KC_TRNS, \
  KC_TRNS, KC_TRNS, KC_TRNS, KC_TRNS, KC_NO,   KC_NO,      KC_NO,     KC_NO,     KC_TRNS,   KC_TRNS,   KC_TRNS,  KC_TRNS \
)

};

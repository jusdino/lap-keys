#include QMK_KEYBOARD_H

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {

/* LAYER 0
 * ,-----------------------------------------------.
 * |   6   |   7   |   8   |   9   |   0   |  BKSP |
 * |-------+-------+-------+-------+-------+-------|
 * |   Y   |   U   |   I   |   O   |   P   |  BKSP |
 * |-------+-------+-------+-------+-------+-------|
 * |   H   |   J   |   K   |   L   |   :   |   '   |
 * |-------+-------+-------+-------+-------+-------|
 * |   N   |   M   |   ,   |   .   |   /   |  ENT  |
 * |-------+-------+-------+-------+-------+-------|
 * |       | SHIFT |  HOME |  END  |  ALT  |  CTRL |
 * `-----------------------------------------------'
 */
[0] = LAYOUT( \
  KC_6,   KC_7,    KC_8,     KC_9,   KC_0,    KC_BSPACE, \
  KC_Y,   KC_U,    KC_I,     KC_O,   KC_P,    KC_BSPACE, \
  KC_H,   KC_J,    KC_K,     KC_L,   KC_SCLN, KC_QUOT, \
  KC_N,   KC_M,    KC_COMMA, KC_DOT, KC_SLSH, KC_ENT, \
  KC_SPC, KC_RSFT, KC_HOME,  KC_END, KC_RALT, KC_RCTL \
)

};

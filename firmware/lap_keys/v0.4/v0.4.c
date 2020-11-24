#include "v0.4.h"

const rgblight_segment_t PROGMEM capslock_layer[] = RGBLIGHT_LAYER_SEGMENTS(
  {23, 10, HSV_RED}
);
 
const rgblight_segment_t PROGMEM layer_1_layer[] = RGBLIGHT_LAYER_SEGMENTS(
  {17, 6, HSV_PURPLE},
  {33, 6, HSV_PURPLE}
);
 
const rgblight_segment_t PROGMEM layer_2_layer[] = RGBLIGHT_LAYER_SEGMENTS(
  {17, 6, HSV_BLUE},
  {33, 6, HSV_BLUE}
);
 
const rgblight_segment_t* const PROGMEM rgb_layers[] = RGBLIGHT_LAYERS_LIST(
  capslock_layer,
  layer_1_layer,
  layer_2_layer
);

void keyboard_post_init_user(void) {
  rgblight_layers = rgb_layers;
};

layer_state_t layer_state_set_user(layer_state_t state) {
  rgblight_set_layer_state(1, layer_state_cmp(state, 1));
  rgblight_set_layer_state(2, layer_state_cmp(state, 2));
  return state;
}

bool led_update_user(led_t led_state) {
  rgblight_set_layer_state(0, led_state.caps_lock);
  return true;
}


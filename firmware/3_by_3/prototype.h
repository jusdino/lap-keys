#ifndef PROTOTYPE_H
#define PROTOTYPE_H

#include "quantum.h"

#define LAYOUT( \
      k00, k01, k02, \
      k10, k11, k12, \
      k20, k21, k22  \
) \
{ \
    { k00, k01, k02 }, \
    { k10, k11, k12 }, \
    { k20, k21, k22 } \
} 

#endif
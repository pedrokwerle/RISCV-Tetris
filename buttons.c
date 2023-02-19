#include "buttons.h"

inline int pollLeftFlag() { return *((volatile int *)0xffff0044); }
inline int pollRightFlag() { return *((volatile int *)0xffff0048); }
inline int pollRotFlag() { return *((volatile int *)0xffff004c); }
inline void lowerFlags() { *((volatile int *)0xffff0050) = 1; }

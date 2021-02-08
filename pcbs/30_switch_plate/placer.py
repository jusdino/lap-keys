#!/usr/bin/env python3

import pcbnew
print('Yep, actually importing')


class Placer():
    """
    Places the components in the 30 Switch Plate
    Notes::
    pcbnew positions are in nm
    pcbnew orientations are in tenths of a degree
    """
    def __init__(self, step=19E6, origin=pcbnew.wxPoint(100E6, 50E6)):
        self.step = step
        self.pcb = pcbnew.GetBoard()
        self.sw_origin = origin  # Positions in nm
        self.d_origin = origin + pcbnew.wxPoint(7500000, -6000000)
        self.d_orientation = -900  # Orientation in 1ths of a degree, it seems
        self.u_outset = 10E6
        self.u_orientation = 1800  # Start orientation plus rotation for each side
        self.xa_origin = origin + pcbnew.wxPoint(step/2, -1125E4)

    @staticmethod
    def x_step(i, step):
        return pcbnew.wxPoint(step*i, 0)

    @staticmethod
    def y_step(i, step):
        return pcbnew.wxPoint(0, step*i)
    
    @staticmethod
    def iter_coords():
        for i in range(30):
            col = i//5
            row = i%5
            yield (i, row, col)

    def place_switches(self):
        for i, row, col in self.iter_coords():
            sw_name = f'SW{i+1}'
            print(f'{sw_name} - {col} - {row}')
            sw = self.pcb.FindModuleByReference(sw_name)
            sw.SetPosition(self.sw_origin + self.x_step(col, self.step) + self.y_step(row, self.step))
            sw.SetOrientation(0)
            d = self.pcb.FindModuleByReference(f'D{i+1}')
            d.SetPosition(self.d_origin + self.x_step(col, self.step) + self.y_step(row, self.step))
            d.SetOrientation(self.d_orientation)
        pcbnew.Refresh()

    def place_leds(self):
        for i in range(6):
            # Top
            u = self.pcb.FindModuleByReference(f'U{i+1}')
            print(f'Placing {u.GetReference()}')
            u.SetPosition(
                    self.sw_origin \
                    + self.x_step(i, self.step) \
                    + pcbnew.wxPoint(0, -self.u_outset))
            u.SetOrientation(self.u_orientation + 0)
            # Bottom
            u = self.pcb.FindModuleByReference(f'U{i+12}')
            print(f'Placing {u.GetReference()}')
            u.SetPosition(
                    self.sw_origin \
                    + self.x_step(5-i, self.step) \
                    + self.y_step(4, self.step) \
                    + pcbnew.wxPoint(0, self.u_outset))
            u.SetOrientation(self.u_orientation + 1800)
        for i in range(5):
            # Right
            u = self.pcb.FindModuleByReference(f'U{i+7}')
            print(f'Placing {u.GetReference()}')
            u.SetPosition(
                    self.sw_origin \
                    + self.x_step(5, self.step) \
                    + self.y_step(i, self.step) \
                    + pcbnew.wxPoint(self.u_outset, 0))
            u.SetOrientation(self.u_orientation + -900)
            # Left
            u = self.pcb.FindModuleByReference(f'U{i+18}')
            print(f'Placing {u.GetReference()}')
            u.SetPosition(
                    self.sw_origin \
                    + self.y_step(4-i, self.step)
                    + pcbnew.wxPoint(-self.u_outset, 0))
            u.SetOrientation(self.u_orientation + 900)
        pcbnew.Refresh()

    def place_headers(self):
        xa = self.pcb.FindModuleByReference('XA1')
        print('Placing XA1')
        xa.SetPosition(self.xa_origin)
        xa.SetOrientation(0)
        xa = self.pcb.FindModuleByReference('XA2')
        print('Placing XA2')
        xa.SetPosition(self.xa_origin + self.x_step(4, self.step))
        xa.SetOrientation(0)
        pcbnew.Refresh()

    def place_components(self):
        self.place_switches()
        self.place_leds()
        self.place_headers()


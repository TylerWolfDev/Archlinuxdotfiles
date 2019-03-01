#!/bin/bash

#A fake DIS-FLICKERING mode

pkill compton
compton -b --config ~/.config/compton/compton.conf --benchmark 100000

simplescreenrecorder

pkill compton
compton -b --config ~/.config/compton/compton.conf

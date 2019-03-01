#!/bin/bash

		cd /home/chung/.themes/Arc-Dark-pixel-blue/gtk-2.0/assets
		ls
		files=()
		for i in *; do
			convert $i -fuzz 0% -fill 'rgb(37,129,223)' -opaque  'rgb(26,115,232))' /home/chung/temppics/$i
		done

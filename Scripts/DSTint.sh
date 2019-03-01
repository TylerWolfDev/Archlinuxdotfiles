
#!/bin/bash

STATUS=$(ps -ef |grep tint2|awk -F ' ' '{print $8}')

echo "first"
if [[ "${STATUS}" -ne "tint2"  ]]; then
   echo "TINT2"
   tint2 -c ~/.config/tint2/i3tary.tint2rc
else
   pkill tint2
fi

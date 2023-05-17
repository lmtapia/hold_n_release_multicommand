# hold_n_release_multicommand
Script for execution of one of various commands assigned to a mouse button

Requires 
- xbindkeys
- xdotool or xte 
- A mouse with extra buttons (optional)

Based on scripts from [https://www.nongnu.org/xbindkeys/xbindkeys.html#utilities]
Needs two calls like in [.xbindkeysrc](../blob/master/.xbindsrc) being the first for the pressed event:
``` 
hold_n_release <button>
```
and the second for the release event:
```
hold_n_release <button> release [<seconds>]
```

Executes the n command from the archive `hold_n_release.<button>.commands` with button being 
the associated button in `.xbindkeysrc` and n being the delay in seconds (except other step were indicated when calling `hold_n release.sh`) 
from the press event and the release event of that button. 



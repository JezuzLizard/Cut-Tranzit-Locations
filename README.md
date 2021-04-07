# Cut-Tranzit-Survival-Maps
Install each file to the same directory as the source is after compiling each file in t6r/data/maps.

Adds support for 4 cut Survival/Grief maps on Tranzit.

Each map has CIA/CDC, allows for hellhounds( survival-only ), has all 6 perks and pack-a-punch, and extra wallbuys.

They can all be loaded up with sv_maprotation or pasting the following dvars in the console for Redacted:

Grief
```
ui_zm_mapstartlocation "power/cornfield/tunnel/diner"
ui_gametype "zgrief"
ui_mapname "zm_transit"
mapname "zm_transit"
g_gametype "zgrief"
ui_zm_gamemodegroup "zencounter"
map "zm_transit"
```
Survival
```
ui_zm_mapstartlocation power/cornfield/tunnel/diner
ui_gametype "zstandard"
ui_mapname "zm_transit"
mapname "zm_transit"
g_gametype "zstandard"
ui_zm_gamemodegroup "zsurvival"
map "zm_transit"
```

Remove all other locations from ui_zm_mapstartlocation to load that map.

For Plutonium custom match separate each line with a comma and paste them all in at once.

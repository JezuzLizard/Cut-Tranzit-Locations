# Cut-Tranzit-Survival-Maps
All files go into %localappdata%\Plutonium\storage\t6\scripts\zm.
Create any folders that don't exist.

Adds support for 4 cut Survival/Grief maps on Tranzit.

Each map has CIA/CDC, allows for hellhounds( survival-only ), has all 6 perks and pack-a-punch, and extra wallbuys.

For Plutonium custom match separate each line with a semicolon and paste them all in at once.

Diner:
ui_zm_mapstartlocation "diner";ui_gametype "zstandard";ui_mapname "zm_transit";mapname "zm_transit";g_gametype "zstandard";ui_zm_gamemodegroup "zsurvival";map "zm_transit"

Power:
ui_zm_mapstartlocation "power";ui_gametype "zstandard";ui_mapname "zm_transit";mapname "zm_transit";g_gametype "zstandard";ui_zm_gamemodegroup "zsurvival";map "zm_transit"

Tunnel:
ui_zm_mapstartlocation "tunnel";ui_gametype "zstandard";ui_mapname "zm_transit";mapname "zm_transit";g_gametype "zstandard";ui_zm_gamemodegroup "zsurvival";map "zm_transit"

Cornfield:
ui_zm_mapstartlocation "cornfield";ui_gametype "zstandard";ui_mapname "zm_transit";mapname "zm_transit";g_gametype "zstandard";ui_zm_gamemodegroup "zsurvival";map "zm_transit"

If you want to do a coop on the new version of Plutonium T6 you can set the ui_zm_mapstartlocation dvar while in a Town lobby. Then start the match like normal.

Extra dvars:
set ctl_no_perks 0/1 //Toggles perk machine spawns
set ctl_no_magicbox 0/1 //Toggles mystery box
set ctl_no_boardrepair 0/1 //Toggles boardrepair
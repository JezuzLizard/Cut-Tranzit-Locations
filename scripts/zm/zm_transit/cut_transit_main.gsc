#include scripts/zm/zm_transit/gamemodes;
#include scripts/zm/zm_transit/locs/location_common;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;

main()
{
	replaceFunc( maps/mp/zm_transit_gamemodes::init, scripts/zm/zm_transit/gamemodes::init_override );
	location = getDvar( "ui_zm_mapstartlocation" );
	switch ( location )
	{
		case "power":
			door_ents = getEntArray( "zombie_door", "targetname" );
			foreach ( door in door_ents )
			{
				if ( door.script_noteworthy == "electric_door" )
				{
					door.script_noteworthy = "electric_buyable_door";
				}
			}
			break;
		case "diner":
			diner_hatch = getent( "diner_hatch", "targetname" );
			diner_hatch.script_gameobjectname = "zclassic zstandard zgrief";
			diner_hatch_mantle = getent( "diner_hatch_mantle", "targetname" );
			diner_hatch_mantle.script_gameobjectname = "zclassic zstandard zgrief";
			gameObjects = getEntArray( "script_model", "classname" );
			foreach ( object in gameObjects )
			{
				if ( object.script_gameobjectname == "zcleansed zturned" )
				{
					object.script_gameobjectname = "zstandard zgrief zcleansed zturned";
				}
			} 
			break;
		default:
			break;
	}
}
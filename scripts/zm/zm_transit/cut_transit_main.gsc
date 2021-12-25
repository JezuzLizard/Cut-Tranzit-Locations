#include scripts/zm/zm_transit/gamemodes;
#include scripts/zm/zm_transit/locs/location_common;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;
#include scripts/zm/zm_transit/locs/loc_cornfield;
#include scripts/zm/zm_transit/locs/loc_diner;
#include scripts/zm/zm_transit/locs/loc_farm;
#include scripts/zm/zm_transit/locs/loc_power;
#include scripts/zm/zm_transit/locs/loc_town;
#include scripts/zm/zm_transit/locs/loc_transit;
#include scripts/zm/zm_transit/locs/loc_tunnel;

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

init()
{
	location = getDvar( "ui_zm_mapstartlocation" );
	switch ( location )
	{
		case "tunnel":
			scripts/zm/zm_transit/locs/loc_tunnel::enable_zones();
			break;
		case "power":
			scripts/zm/zm_transit/locs/loc_power::enable_zones();
			break;
		default:
			break;
}
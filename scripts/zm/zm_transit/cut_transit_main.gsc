#include maps\mp\zm_transit;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\zm_transit_utility;
#include maps\mp\zombies\_zm_game_module;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zm_transit_grief_town;
#include maps\mp\zm_transit_grief_farm;
#include maps\mp\zm_transit_grief_station;
#include maps\mp\zm_transit_standard_town;
#include maps\mp\zm_transit_standard_farm;
#include maps\mp\zm_transit_standard_station;
#include maps\mp\zm_transit_classic;

#include scripts\zm\zm_transit\locs\loc_cornfield;
#include scripts\zm\zm_transit\locs\loc_diner;
#include scripts\zm\zm_transit\locs\loc_farm;
#include scripts\zm\zm_transit\locs\loc_power;
#include scripts\zm\zm_transit\locs\loc_town;
#include scripts\zm\zm_transit\locs\loc_transit;
#include scripts\zm\zm_transit\locs\loc_tunnel;

main()
{
	if ( !isDefined( level.ctsm_disable_custom_perk_locations ) )
	{
		level.ctsm_disable_custom_perk_locations = getDvarInt( "ctl_no_perks" ) == 1;
	}
	if ( !isDefined( level.ctl_disable_mystery_box ) )
	{
		level.ctl_disable_mystery_box = getDvarInt( "ctl_no_magicbox" ) == 1;
	}
	if ( !isDefined( level.no_board_repair ) )
	{
		level.no_board_repair = getDvarInt( "ctl_no_boardrepair" ) == 1;
	}
	replaceFunc( maps\mp\zm_transit_gamemodes::init, ::init_override );
	location = getDvar( "ui_zm_mapstartlocation" );
	switch ( location )
	{
		case "power":
			door_ents = getEntArray( "zombie_door", "targetname" );
			foreach ( door in door_ents )
			{
				if ( isDefined( door.script_noteworthy ) && door.script_noteworthy == "electric_door" )
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
				if ( isDefined( object.script_gameobjectname ) && object.script_gameobjectname == "zcleansed zturned" )
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
			scripts\zm\zm_transit\locs\loc_tunnel::enable_zones();
			break;
		case "power":
			scripts\zm\zm_transit\locs\loc_power::enable_zones();
			break;
		default:
			break;
	}
	flag_wait( "initial_blackscreen_passed" );
	if ( level.ctl_disable_mystery_box )
	{
		level thread kill_start_chest();
	}
}

init_override()
{
	add_map_gamemode( "zclassic", maps\mp\zm_transit::zclassic_preinit, undefined, undefined );
	add_map_gamemode( "zgrief", maps\mp\zm_transit::zgrief_preinit, undefined, undefined );
	add_map_gamemode( "zstandard", maps\mp\zm_transit::zstandard_preinit, undefined, undefined );
	add_map_location_gamemode( "zclassic", "transit", maps\mp\zm_transit_classic::precache, maps\mp\zm_transit_classic::main );
	add_map_location_gamemode( "zstandard", "transit", maps\mp\zm_transit_standard_station::precache, maps\mp\zm_transit_standard_station::main );
	add_map_location_gamemode( "zstandard", "farm", maps\mp\zm_transit_standard_farm::precache, maps\mp\zm_transit_standard_farm::main );
	add_map_location_gamemode( "zstandard", "town", maps\mp\zm_transit_standard_town::precache, maps\mp\zm_transit_standard_town::main );
	add_map_location_gamemode( "zstandard", "diner", scripts\zm\zm_transit\locs\loc_diner::precache, scripts\zm\zm_transit\locs\loc_diner::diner_main );
	add_map_location_gamemode( "zstandard", "tunnel", scripts\zm\zm_transit\locs\loc_tunnel::precache, scripts\zm\zm_transit\locs\loc_tunnel::tunnel_main );
	add_map_location_gamemode( "zstandard", "power", scripts\zm\zm_transit\locs\loc_power::precache, scripts\zm\zm_transit\locs\loc_power::power_main );
	add_map_location_gamemode( "zstandard", "cornfield", scripts\zm\zm_transit\locs\loc_cornfield::precache, scripts\zm\zm_transit\locs\loc_cornfield::cornfield_main );
	add_map_location_gamemode( "zgrief", "diner", scripts\zm\zm_transit\locs\loc_diner::precache, scripts\zm\zm_transit\locs\loc_diner::diner_main );
	add_map_location_gamemode( "zgrief", "tunnel", scripts\zm\zm_transit\locs\loc_tunnel::precache, scripts\zm\zm_transit\locs\loc_tunnel::tunnel_main );
	add_map_location_gamemode( "zgrief", "power", scripts\zm\zm_transit\locs\loc_power::precache, scripts\zm\zm_transit\locs\loc_power::power_main );
	add_map_location_gamemode( "zgrief", "cornfield", scripts\zm\zm_transit\locs\loc_cornfield::precache, scripts\zm\zm_transit\locs\loc_cornfield::cornfield_main );
	add_map_location_gamemode( "zgrief", "transit", maps\mp\zm_transit_grief_station::precache, maps\mp\zm_transit_grief_station::main );
	add_map_location_gamemode( "zgrief", "farm", maps\mp\zm_transit_grief_farm::precache, maps\mp\zm_transit_grief_farm::main );
	add_map_location_gamemode( "zgrief", "town", maps\mp\zm_transit_grief_town::precache, maps\mp\zm_transit_grief_town::main );

	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zgrief", "diner", scripts\zm\zm_transit\locs\loc_diner::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zgrief", "tunnel", scripts\zm\zm_transit\locs\loc_tunnel::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zgrief", "power", scripts\zm\zm_transit\locs\loc_power::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zgrief", "cornfield", scripts\zm\zm_transit\locs\loc_cornfield::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zstandard", "diner", scripts\zm\zm_transit\locs\loc_diner::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zstandard", "tunnel", scripts\zm\zm_transit\locs\loc_tunnel::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zstandard", "power", scripts\zm\zm_transit\locs\loc_power::struct_init );
	scripts\zm\_gametype_setup::add_struct_location_gamemode_func( "zstandard", "cornfield", scripts\zm\zm_transit\locs\loc_cornfield::struct_init );

	scripts\zm\_gametype_setup::add_zone_location_func( "power", scripts\zm\zm_transit\locs\loc_power::enable_zones );
	scripts\zm\_gametype_setup::add_zone_location_func( "tunnel", scripts\zm\zm_transit\locs\loc_tunnel::enable_zones );	
	scripts\zm\_gametype_setup::add_zone_location_func( "diner", scripts\zm\zm_transit\locs\loc_diner::enable_zones );	
}

kill_start_chest()
{
	flag_wait( "initial_blackscreen_passed" );
	wait 2;
	foreach ( chest in level.chests )
	{
		chest maps\mp\zombies\_zm_magicbox::hide_chest( 0 );
		chest notify( "kill_chest_think" );
		wait 0.05;
	}
}
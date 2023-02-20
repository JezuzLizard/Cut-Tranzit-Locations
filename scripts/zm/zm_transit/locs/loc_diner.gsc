#include maps\mp\zombies\_zm_game_module;
#include maps\mp\zombies\_zm_utility;
#include common_scripts\utility;
#include maps\mp\_utility;
#include maps\mp\zombies\_zm;
#include scripts\zm\_gametype_setup;

struct_init()
{
	if ( !is_true( level.ctsm_disable_custom_perk_locations ) )
	{
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_armorvest", "zombie_vending_jugg", ( 0, 176, 0 ), ( -3634, -7464, -58 ) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_rof", "zombie_vending_doubletap2", ( 0, 270, 0 ), (-4591.74 + 12.5, -7755.04, -40.5759) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_longersprint", "zombie_vending_marathon", ( 0, 4, 0 ), ( -4576, -6704, -61 ) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_scavenger", "zombie_vending_tombstone", ( 0, 90, 0 ), ( -6496, -7691, 0 ) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_weapupgrade", "p6_anim_zm_buildable_pap_on", ( 0, 175, 0 ), ( -6351, -7778, 227 ) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_quickrevive", "zombie_vending_quickrevive", ( 0, 270, 0 ), ( -4170 - 12.5, -7610, -61 ) );
		scripts\zm\_gametype_setup::register_perk_struct( "specialty_fastreload", "zombie_vending_sleight", ( 0, 270, 0 ), ( -5470, -7859.5, 0 ) );
	}
	/*
	//OLd spawnpoints
	coordinates = array( ( -3991, -7317, -63 ), ( -4231, -7395, -60 ), ( -4127, -6757, -54 ), ( -4465, -7346, -58 ),
						 ( -5770, -6600, -55 ), ( -6135, -6671, -56 ), ( -6182, -7120, -60 ), ( -5882, -7174, -61 ) );
	angles = array( ( 0, 161, 0 ), ( 0, 120, 0 ), ( 0, 217, 0 ), ( 0, 173, 0 ), ( 0, -106, 0 ), ( 0, -46, 0 ), ( 0, 51, 0 ), ( 0, 99, 0 ) );
	*/
	
	// Players spawn in the garage
	coordinates = array( (-4290.99, -7583.55, -62.699), (-4290.95, -7679.21, -60.8681), (-4292.12, -7782.84, -62.726), (-4292.43, -7872.34, -62.875),
					 	 (-4685.57, -7904.69, -62.875), (-4694.29, -7786.72, -55.6662), (-4707.08, -7671.75, -57.9624), (-4691.18, -7588.58, -57.875) );
	angles = array( (0, -177.244, 0), (0, 179.015, 0), (0, 176.477, 0), (0, 176.477, 0), (0, 1.68447, 0), (0, 1.68447, 0), (0, 1.68447, 0), (0, 1.68447, 0) );

	for ( i = 0; i < coordinates.size; i++ )
	{
		scripts\zm\_gametype_setup::register_map_initial_spawnpoint( coordinates[ i ], angles[ i ] );
	}
	gameObjects = getEntArray( "script_model", "classname" );
	foreach ( object in gameObjects )
	{
		if ( isDefined( object.script_gameobjectname ) && object.script_gameobjectname == "zcleansed zturned" )
		{
			object.script_gameobjectname = "zstandard zgrief zcleansed zturned";
		}
	}

	/*
	start_node = spawnpathnode( "node_negotiation_begin", (-6279.89, -7947.26, 146.691), (0, 177.35, 0), "animscript", "zm_jump_down_48", "target", "diner_roof_zm_jump_down" );
	end_node = spawnpathnode( "node_negotiation_end", (-6301.12, -7947.22, 40.125), (0, 176.801, 0), "targetname", "diner_roof_zm_jump_down" );

	a_nodes1 = getnodesinradiussorted( start_node.origin, 64, 16, 100, "pathnodes" );
	linkNodes( a_nodes1[ 0 ], start_node );
	a_nodes2 = getnodesinradiussorted( end_node.origin, 64, 16, 100, "pathnodes" );
	linkNodes( a_nodes2[ 0 ], end_node );
	linkNodes( start_node, end_node );
	*/
}

enable_zones()
{
	//level.location_zones_func = ::diner_adjacent_zones;
	zones = []; 
	zones[ 0 ] = "zone_gar";
	zones[ 1 ] = "zone_din";
	zones[ 2 ] = "zone_diner_roof";
	return zones;
}

diner_adjacent_zones()
{
	maps\mp\zombies\_zm_zonemgr::add_adjacent_zone( "zone_din", "zone_diner_roof", "always_on" );
}

precache()
{
	normalChests = getstructarray( "treasure_chest_use", "targetname" );
	start_chest_zbarrier = getEnt( "depot_chest_zbarrier", "script_noteworthy" );
	start_chest_zbarrier.origin = ( -5708, -7968, 232 );
	start_chest_zbarrier.angles = ( 0, 1, 0 );
	start_chest = spawnStruct();
	start_chest.origin = ( -5708, -7968, 232 );
	start_chest.angles = ( 0, 1, 0 );
	start_chest.script_noteworthy = "depot_chest";
	start_chest.zombie_cost = 950;
	collision = spawn( "script_model", start_chest_zbarrier.origin );
	collision.angles = start_chest_zbarrier.angles;
	collision setmodel( "collision_clip_32x32x128" );
	collision = spawn( "script_model", start_chest_zbarrier.origin - ( 32, 0, 0 ) );
	collision.angles = start_chest_zbarrier.angles;
	collision setmodel( "collision_clip_32x32x128" );
	collision = spawn( "script_model", start_chest_zbarrier.origin + ( 32, 0, 0 ) );
	collision.angles = start_chest_zbarrier.angles;
	collision setmodel( "collision_clip_32x32x128" );
	level.chests = [];
	level.chests[ 0 ] = normalChests[ 3 ];
	level.chests[ 1 ] = start_chest;
}

diner_main()
{
	diner_hatch_access();
	init_wallbuys();
	init_barriers();
	maps\mp\zombies\_zm_magicbox::treasure_chest_init( random( array( "start_chest", "depot_chest" ) ) );
	scripts\zm\zm_transit\locs\location_common::common_init();
}

diner_hatch_access()
{
	diner_hatch = getent( "diner_hatch", "targetname" );
	diner_hatch_col = getent( "diner_hatch_collision", "targetname" );
	diner_hatch_mantle = getent( "diner_hatch_mantle", "targetname" );
	if ( !isDefined( diner_hatch ) || !isDefined( diner_hatch_col ) )
	{
		return;
	}
	diner_hatch hide();
	diner_hatch_mantle.start_origin = diner_hatch_mantle.origin;
	diner_hatch_mantle.origin += vectorScale( ( 0, 0, 0 ), 500 );
	diner_hatch show();
	diner_hatch_col delete();
	diner_hatch_mantle.origin = diner_hatch_mantle.start_origin;
	//level maps\mp\zombies\_zm_buildables::track_placed_buildables( "dinerhatch" );
}

init_wallbuys()
{
	scripts\zm\_gametype_setup::wallbuy( "m14_zm", "m14", "weapon_upgrade", ( -4183.74 + 12.5, -7742.21, 0 ) , ( 0, 90, 0 ) );
	scripts\zm\_gametype_setup::wallbuy( "rottweil72_zm", "olympia", "weapon_upgrade", ( -4979.03, -7831.74 + 12.5, 0 ), ( 0, 180, 0 ) );
	scripts\zm\_gametype_setup::wallbuy( "claymore_zm", "claymore", "claymore_purchase", ( -4552.46 - 12.5, -7534.89, -15 ), ( 0, 270, 0 ) );
	scripts\zm\_gametype_setup::wallbuy( "m16_zm", "m16", "weapon_upgrade", ( -3578, -7181, 0 ), ( 0, 180, 0 ) );
	scripts\zm\_gametype_setup::wallbuy( "mp5k_zm", "mp5", "weapon_upgrade", ( -5489, -7982.7, 62 ), ( 0, 0, 0 ) );
	scripts\zm\_gametype_setup::wallbuy( "tazer_knuckles_zm", "tazer_knuckles", "tazer_upgrade", ( -6399.2, -7938.5, 207.25 ), ( 0, 270, 0 ) );
}

init_barriers()
{
	precacheModel( "zm_collision_transit_diner_survival" );
	collision = spawn( "script_model", ( -5000, -6700, 0 ), 1 );
	collision setmodel( "zm_collision_transit_diner_survival" );
}


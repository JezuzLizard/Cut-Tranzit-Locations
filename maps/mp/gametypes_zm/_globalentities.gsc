#include maps/mp/zombies/_zm_game_module;
#include maps/mp/zm_transit_utility;
#include maps/mp/gametypes_zm/_zm_gametype;
#include maps/mp/zombies/_zm_magicbox;
#include maps/mp/zombies/_zm_race_utility;
#include maps/mp/zombies/_zm_utility;
#include common_scripts/utility;
#include maps/mp/_utility;
#include maps/mp/zombies/_zm_weapons;
#include maps/mp/zombies/_zm_unitrigger;
#include maps/mp/zombies/_zm_weap_claymore;
#include maps/mp/zombies/_zm_melee_weapon;

treasure_chest_init()
{
	normalChests = getstructarray( "treasure_chest_use", "targetname" );
	level.chests = [];
	switch ( getDvar( "ui_zm_mapstartlocation" ) )
	{
		case "tunnel":
			start_chest = spawnstruct();
			start_chest.origin = ( -11090, -349, 193 );
			start_chest.angles = ( 0, -100, 0 );
			start_chest.script_noteworthy = "start_chest";
			start_chest.zombie_cost = 950;
			start_chest2 = spawnstruct();
			start_chest2.origin = ( -11772, -2501, 232 );
			start_chest2.angles = ( 0, 90, 0 );
			start_chest2.script_noteworthy = "farm_chest";
			start_chest2.zombie_cost = 950;
			level.chests[ 0 ] = start_chest;
			level.chests[ 1 ] = start_chest2;
			randy = RandomIntRange( 0, 3 );
			if ( randy == 1 )
            {
				treasure_chest_init( "start_chest" );
            }
			else
            {
				treasure_chest_init( "farm_chest" );
            }
			break;
		case "cornfield":
			start_chest = spawnstruct();
			start_chest.origin = ( 13566, -541, -188 );
			start_chest.angles = ( 0, -90, 0 );
			start_chest.script_noteworthy = "start_chest";
			start_chest.zombie_cost = 950;
			start_chest2 = spawnstruct();
			start_chest2.origin = ( 7458, -464, -196 );
			start_chest2.angles = ( 0, -90, 0 );
			start_chest2.script_noteworthy = "depot_chest";
			start_chest2.zombie_cost = 950;
			start_chest3 = spawnstruct();
			start_chest3.origin = ( 10158, 49, -220 );
			start_chest3.angles = ( 0, -185, 0 );
			start_chest3.script_noteworthy = "farm_chest";
			start_chest3.zombie_cost = 950;
			level.chests[ 0 ] = start_chest;
			level.chests[ 1 ] = start_chest2;
			level.chests[ 2 ] = start_chest3;
			randy = RandomIntRange( 0, 3 );
			if ( randy == 1 )
            {
				treasure_chest_init( "start_chest" );
            }
			else if ( randy == 2 )
            {
				treasure_chest_init( "farm_chest" );
            }
			else
            {
				treasure_chest_init( "depot_chest" );
            }
			break;
		case "power":
			start_chest = spawnstruct();
			start_chest.origin = ( 10806, 8518, -407 );
			start_chest.angles = ( 0, 180, 0 );
			start_chest.script_noteworthy = "depot_chest";
			start_chest.zombie_cost = 950;
			level.chests[ 0 ] = normalChests[ 2 ];
			level.chests[ 1 ] = start_chest;
			randy = RandomIntRange( 0, 2 );
			if ( randy == 1 )
            {
				treasure_chest_init( "pow_chest" );
            }
			else
            {
				treasure_chest_init( "depot_chest" );
            }
			break;
		case "diner":
			start_chest = spawnstruct();
			start_chest.origin = ( -5708, -7968, 232 );
			start_chest.angles = ( 0, 1, 0 );
			start_chest.script_noteworthy = "depot_chest";
			start_chest.zombie_cost = 950;
			level.chests[ 0 ] = normalChests[ 3 ];
			level.chests[ 1 ] = start_chest;
			randy = RandomIntRange( 0, 3 );
			if ( randy == 1 )
            {
				treasure_chest_init( "start_chest" );
            }
			else
            {
				treasure_chest_init( "depot_chest" );
            }
			break;
	}
}

main()
{
	level.create_spawner_list_func = ::create_spawner_list;
	//level.zone_spawn_locations_override = ::zone_spawn_locations_override;
	switch ( getDvar( "ui_zm_mapstartlocation" ) )
	{
		case "diner":
			level thread diner_hatch_access();
			_weapon_spawner( ( 0, 0, 0 ), ( -4280, -7486, -5 ), "m14_zm_fx", "m14_zm", "t6_wpn_ar_m14_world", "m14", "weapon_upgrade" );
			_weapon_spawner( ( 0, 0, 0 ), ( -5085, -7807, -5 ), "rottweil72_zm_fx", "rottweil72_zm", "t6_wpn_shotty_olympia_world", "olympia", "weapon_upgrade" );
			_weapon_spawner( ( 0, 180, 0 ), ( -3578, -7181, 0 ), "m16_zm_fx", "m16_zm", "t6_wpn_ar_m16a2_world", "m16", "weapon_upgrade" );
			_weapon_spawner( ( 0, 1.00179, 0 ), ( -5489, -7982.7, 62 ), "mp5k_zm_fx", "mp5k_zm", "t6_wpn_smg_mp5_world", "mp5", "weapon_upgrade" );
			_weapon_spawner( ( 0, 270, 0 ), ( -6399.2, -7938.5, 207.25 ), "tazer_knuckles_zm_fx", "tazer_knuckles_zm", "t6_wpn_taser_knuckles_world", "tazer_knuckles", "tazer_upgrade" );
			break;
		case "tunnel":
			_weapon_spawner( ( 0, -86, 0 ), ( -11166, -2844, 247 ), "m14_zm_fx", "m14_zm", "t6_wpn_ar_m14_world", "m14", "weapon_upgrade" );
			_weapon_spawner( ( 0, 83, 0 ), ( -10790, -1430, 247 ), "rottweil72_zm_fx", "rottweil72_zm", "t6_wpn_shotty_olympia_world", "olympia", "weapon_upgrade" );
			_weapon_spawner( ( 0, 270, 0 ), ( -7045.8, 4132, -6 ), "m16_zm_fx", "m16_zm", "t6_wpn_ar_m16a2_world", "m16", "weapon_upgrade" );
			_weapon_spawner( ( 0, 83, 0 ), ( -10625, -545, 247 ), "mp5k_zm_fx", "mp5k_zm", "t6_wpn_smg_mp5_world", "mp5", "weapon_upgrade" );
			_weapon_spawner( ( 0, -93, 0 ), ( -11839, -2406, 283 ), "tazer_knuckles_zm_fx", "tazer_knuckles_zm", "t6_wpn_taser_knuckles_world", "tazer_knuckles", "tazer_upgrade" );
			break;
		case "power":
			_weapon_spawner( ( 0, 90, 0), ( 10559, 8226, -504 ), "m14_zm_fx", "m14_zm", "t6_wpn_ar_m14_world", "m14", "weapon_upgrade" );
			_weapon_spawner( ( 0, 170, 0 ), ( 11769, 7662, -701 ), "rottweil72_zm_fx", "rottweil72_zm", "t6_wpn_shotty_olympia_world", "olympia", "weapon_upgrade" );
			_weapon_spawner( ( 0, 0, 0 ), ( 10859, 8146, -353 ), "m16_zm_fx", "m16_zm", "t6_wpn_ar_m16a2_world", "m16", "weapon_upgrade" );
			_weapon_spawner( ( 0, 90, 0 ), ( 11452, 8692, -521 ), "mp5k_zm_fx", "mp5k_zm", "t6_wpn_smg_mp5_world", "mp5", "weapon_upgrade" );
			_weapon_spawner( ( 0, 180, 0 ), ( -4280, -7486, -5 ), "bowie_knife_zm_fx", "bowie_knife_zm", "world_knife_bowie", "bowie_knife", "bowie_upgrade" );
			break;
		case "cornfield":
			_weapon_spawner( ( 0, -180, 0 ), ( 13603, -1282, -134 ), "claymore_zm_fx", "claymore_zm", "t6_wpn_claymore_world", "claymore", "claymore_purchase" );
			_weapon_spawner( ( 0, -90, 0 ), ( 13663, -1166, -134 ), "rottweil72_zm_fx", "rottweil72_zm", "t6_wpn_shotty_olympia_world", "olympia", "weapon_upgrade" );
			_weapon_spawner( ( 0, 90, 0 ), ( 14092, -351, -133 ), "m16_zm_fx", "m16_zm", "t6_wpn_ar_m16a2_world", "m16", "weapon_upgrade" );
			_weapon_spawner( ( 0, 90, 0 ), ( 13542, -764, -133 ), "mp5k_zm_fx", "mp5k_zm", "t6_wpn_smg_mp5_world", "mp5", "weapon_upgrade" );
			_weapon_spawner( ( 0, 90, 0 ), ( 13502, -12, -125 ), "tazer_knuckles_zm_fx", "tazer_knuckles_zm", "t6_wpn_taser_knuckles_world", "tazer_knuckles", "tazer_upgrade" );
			level thread increase_cornfield_zombie_speed();
			break;
	}
	//logline1 = "_globalentities.gsc main() initial setup done" + "\n";
	//logprint( logline1 );
	init_barriers_for_cut_locations();
	treasure_chest_init();
	level.enemy_location_override_func = ::enemy_location_override;
	level.player_out_of_playable_area_monitor = 0;
	flag_wait( "initial_blackscreen_passed" );
	maps/mp/zombies/_zm_game_module::turn_power_on_and_open_doors();
	flag_wait( "start_zombie_round_logic" );
	wait 1;
	level notify( "revive_on" );
	wait_network_frame();
	level notify( "doubletap_on" );
	wait_network_frame();
	level notify( "marathon_on" );
	wait_network_frame();
	level notify( "juggernog_on" );
	wait_network_frame();
	level notify( "sleight_on" );
	wait_network_frame();
	level notify( "tombstone_on" );
	wait_network_frame();
	level notify( "Pack_A_Punch_on" );
}

enemy_location_override( zombie, enemy )
{
	location = enemy.origin;
	if ( is_true( self.reroute ) )
	{
		if ( isDefined( self.reroute_origin ) )
		{
			location = self.reroute_origin;
		}
	}
	return location;
}

diner_hatch_access() //modified function
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
	player maps/mp/zombies/_zm_buildables::track_placed_buildables( "dinerhatch" );
}

_weapon_spawner( weapon_angles, weapon_coordinates, chalk_fx, weapon_name, weapon_model, target, targetname )
{
	tempmodel = spawn( "script_model", ( 0, 0, 0 ) );
	weapon_spawn = spawnstruct();
	weapon_spawn.angles = weapon_angles;
	weapon_spawn.origin = weapon_coordinates;
	if ( )
	weapon_spawn.targetname = targetname;
	weapon_spawn.zombie_weapon_upgrade = weapon_name;
	weapon_spawn.model = weapon_model;
	weapon_spawn.target = target;
	precachemodel( weapon_spawn.model );
	unitrigger_stub = spawnstruct();
	unitrigger_stub.origin = weapon_spawn.origin;
	unitrigger_stub.angles = weapon_spawn.angles;
	tempmodel.origin = weapon_spawn.origin;
	tempmodel.angles = weapon_spawn.angles;
	mins = undefined;
	maxs = undefined;
	absmins = undefined;
	absmaxs = undefined;
	tempmodel setmodel( weapon_spawn.model );
	tempmodel useweaponhidetags( weapon_spawn.zombie_weapon_upgrade );
	mins = tempmodel getmins();
	maxs = tempmodel getmaxs();
	absmins = tempmodel getabsmins();
	absmaxs = tempmodel getabsmaxs();
	bounds = absmaxs - absmins;
	unitrigger_stub.script_length = bounds[ 0 ] * 0.25;
	unitrigger_stub.script_width = bounds[ 1 ];
	unitrigger_stub.script_height = bounds[ 2 ];
	unitrigger_stub.origin -= anglesToRight( unitrigger_stub.angles ) * ( unitrigger_stub.script_length * 0.4 );
	unitrigger_stub.target = weapon_spawn.target;
	unitrigger_stub.targetname = weapon_spawn.targetname;
	unitrigger_stub.cursor_hint = "HINT_NOICON";
	if ( weapon_spawn.targetname == "weapon_upgrade" )
	{
		unitrigger_stub.cost = get_weapon_cost( spawn_list[ i ].zombie_weapon_upgrade );
		if ( !is_true( level.monolingustic_prompt_format ) )
		{
			unitrigger_stub.hint_string = get_weapon_hint( spawn_list[ i ].zombie_weapon_upgrade );
			unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
		}
		else
		{
			unitrigger_stub.hint_parm1 = get_weapon_display_name( spawn_list[ i ].zombie_weapon_upgrade );
			if ( !isDefined( unitrigger_stub.hint_parm1 ) || unitrigger_stub.hint_parm1 == "" || unitrigger_stub.hint_parm1 == "none" )
			{
				unitrigger_stub.hint_parm1 = "missing weapon name " + spawn_list[ i ].zombie_weapon_upgrade;
			}
			unitrigger_stub.hint_parm2 = unitrigger_stub.cost;
			unitrigger_stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY";
		}
	}
	unitrigger_stub.cost = get_weapon_cost( weapon_spawn.zombie_weapon_upgrade );
	unitrigger_stub.hint_string = get_weapon_hint( weapon_spawn.zombie_weapon_upgrade );
	unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
	unitrigger_stub.weapon_upgrade = weapon_spawn.zombie_weapon_upgrade;
	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.require_look_at = 1;
	unitrigger_stub.require_look_from = 0;
	unitrigger_stub.zombie_weapon_upgrade = weapon_spawn.zombie_weapon_upgrade;
	maps/mp/zombies/_zm_unitrigger::unitrigger_force_per_player_triggers( unitrigger_stub, 1 );
	if ( is_melee_weapon( unitrigger_stub.zombie_weapon_upgrade ) )
	{
		if ( unitrigger_stub.zombie_weapon_upgrade == "tazer_knuckles_zm" && isDefined( level.taser_trig_adjustment ) )
		{
			unitrigger_stub.origin += level.taser_trig_adjustment;
		}
		maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( unitrigger_stub, ::melee_weapon_think );
	}
	else if ( unitrigger_stub.zombie_weapon_upgrade == "claymore_zm" )
	{
		unitrigger_stub.prompt_and_visibility_func = ::claymore_unitrigger_update_prompt;
		maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( unitrigger_stub, ::buy_claymores );
	}
	else
	{
		unitrigger_stub.prompt_and_visibility_func = ::wall_weapon_update_prompt;
		maps/mp/zombies/_zm_unitrigger::register_static_unitrigger( unitrigger_stub, ::weapon_spawn_think );
	}
	weapon_spawn.trigger_stub = unitrigger_stub;
	tempmodel.origin += anglesToForward( ( 0, yaw, 0 ) ) * 8;
	tempmodel delete();
    thread playchalkfx( chalk_fx, weapon_coordinates, weapon_angles );
}

playchalkfx( effect, origin, angles ) //custom function
{
	fxSpawner = spawn( "script_model", origin );
	fxSpawner setmodel( "tag_origin" );
	fxSpawner.angles = angles;
	playfxontag( level._effect[ effect ], fxSpawner, "tag_origin" );
}

zombie_speed_up_distance_check()
{
	if ( distance( self.origin, self.closestPlayer.origin ) > 1000 )
	{
		return 1;
	}
	return 0;
}

increase_cornfield_zombie_speed()
{
	level endon( "end_game" );
	level waittill( "connected", player );
	level.zombie_vars[ "zombie_spawn_delay" ] = 0.08;
	level.speed_change_round = undefined;
	while ( 1 )
	{
		zombies = get_round_enemy_array();
		for ( i = 0; i < zombies.size; i++ )
		{
			zombies[ i ].closestPlayer = get_closest_valid_player( zombies[ i ].origin );
		}
		zombies = get_round_enemy_array();
		for ( i = 0; i < zombies.size; i++ )
		{
			if ( zombies[ i ] zombie_speed_up_distance_check() )
			{
				zombies[ i ] set_zombie_run_cycle( "chase_bus" );
			}
			else if ( zombies[ i ].zombie_move_speed != "sprint" )
			{
				zombies[ i ] set_zombie_run_cycle( "sprint" );
			}
		}
		wait 1;
	}
}

_spawn_tranzit_barrier( barrier_coordinates, barrier_model, barrier_angles, not_solid ) //custom function
{
	if ( !isDefined( level.survival_barriers ) )
	{
		level.survival_barriers = [];
	}
	level.survival_barriers [ level.survival_barriers.size ] = spawn( "script_model", barrier_coordinates );
	level.survival_barriers [ level.survival_barriers.size ] setModel( barrier_model );
	level.survival_barriers [ level.survival_barriers.size ] rotateTo( barrier_angles, 0.1 );
	level.survival_barriers [ level.survival_barriers.size ] disconnectPaths();  
	if ( is_true( not_solid ) )
	{
		barrier_ent notSolid();
	}
}

init_barriers_for_cut_locations() //custom function
{
	switch ( getDvar( "ui_zm_mapstartlocation" ) )
	{
		case "tunnel":
			_spawn_tranzit_barrier( ( -11250, -520, 255 ), "veh_t6_civ_movingtrk_cab_dead", ( 0, 172, 0 ) );
			_spawn_tranzit_barrier( ( 11250, -580, 255 ), "collision_player_wall_256x256x10", ( 0, 180, 0 ) );
			_spawn_tranzit_barrier( ( -11506, -580, 255 ), "collision_player_wall_256x256x10", ( 0, 180, 0 ) );
			_spawn_tranzit_barrier( ( -10770, -3240, 255 ), "veh_t6_civ_movingtrk_cab_dead", ( 0, 214, 0 ) );
			_spawn_tranzit_barrier( ( -10840, -3190, 255 ), "collision_player_wall_256x256x10", ( 0, 214, 0 ) );
			break;
		case "diner":
			_spawn_tranzit_barrier( ( -3952, -6957, -67 ), "collision_player_wall_256x256x10", ( 0, 82, 0 ) );
			_spawn_tranzit_barrier( ( -4173, -6679, -60 ), "collision_player_wall_512x512x10", ( 0, 0, 0 ) );
			_spawn_tranzit_barrier( ( -5073, -6732, -59 ), "collision_player_wall_512x512x10", ( 0, 328, 0 ) );
			_spawn_tranzit_barrier( ( -6104, -6490, -38 ), "collision_player_wall_512x512x10", ( 0, 2, 0 ) );
			_spawn_tranzit_barrier( ( -5850, -6486, -38 ), "collision_player_wall_256x256x10", ( 0, 0, 0 ) );
			_spawn_tranzit_barrier( ( -5624, -6406, -40 ), "collision_player_wall_256x256x10", ( 0, 226, 0 ) );
			_spawn_tranzit_barrier( ( -6348, -6886, -55 ), "collision_player_wall_512x512x10", ( 0, 98, 0 ) );
			break;
		case "power":
			_spawn_tranzit_barrier( ( 9965, 8133, -556 ), "veh_t6_civ_60s_coupe_dead", ( 15, 5, 0 ) );
			_spawn_tranzit_barrier( ( 9955, 8105, -575 ), "collision_player_wall_256x256x10", ( 0, 0, 0 ) );
			_spawn_tranzit_barrier( ( 10056, 8350, -584 ), "veh_t6_civ_bus_zombie", ( 0, 340, 0 ), 1 );
			_spawn_tranzit_barrier( ( 10267, 8194, -556 ), "collision_player_wall_256x256x10", ( 0, 340, 0 ) );
			_spawn_tranzit_barrier( ( 10409, 8220, -181 ), "collision_player_wall_512x512x10", ( 0, 250, 0 ) );
			_spawn_tranzit_barrier( ( 10409, 8220, -556 ), "collision_player_wall_128x128x10", ( 0, 250, 0 ) );
			_spawn_tranzit_barrier( ( 10281, 7257, -575 ), "veh_t6_civ_microbus_dead", ( 0, 13, 0 ) );
			_spawn_tranzit_barrier( ( 10268, 7294, -569 ), "collision_player_wall_256x256x10", ( 0, 13, 0 ) );
			_spawn_tranzit_barrier( ( 10100, 7238, -575 ), "veh_t6_civ_60s_coupe_dead", ( 0, 52, 0 ) );
			_spawn_tranzit_barrier( ( 10170, 7292, -505 ), "collision_player_wall_128x128x10", ( 0, 140, 0 ) );
			_spawn_tranzit_barrier( ( 10030, 7216, -569 ), "collision_player_wall_256x256x10", ( 0, 49, 0 ) );
			_spawn_tranzit_barrier( ( 10563, 8630, -344 ), "collision_player_wall_256x256x10", ( 0, 270, 0 ) );
			break;
		case "cornfield":
			_spawn_tranzit_barrier( ( 10190, 135, -159 ), "veh_t6_civ_movingtrk_cab_dead", ( 0, 172, 0 ) );
			_spawn_tranzit_barrier( ( 10100, 100, -159 ), "collision_player_wall_512x512x10", ( 0, 172, 0 ) );
			_spawn_tranzit_barrier( ( 10100, -1800, 217 ), "veh_t6_civ_bus_zombie", ( 0, 126, 0 ), 1 );
			_spawn_tranzit_barrier( ( 10045, -1607, -181 ), "collision_player_wall_512x512x10", ( 0, 126, 0 ) );
			break;
	}
}

zone_spawn_locations_override( spawn_locations, zone )
{
	switch ( zone )
	{
		case "zone_trans_diner":
			break;
		case "zone_roadside_west":
			break;
		case "zone_gas":
			break;
		case "zone_trans_diner2":
			break;
		case "zone_roadside_east":
			break;
		case "zone_din":
			break;
		case "zone_gar":
			break;
		case "zone_diner_roof":
			break;
	}
	return spawn_locations;
}

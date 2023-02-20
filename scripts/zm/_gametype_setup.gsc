#include maps\mp\zombies\_load;
#include maps\mp\_utility;
#include common_scripts\utility;
#include maps\mp\zombies\_zm_zonemgr;
#include maps\mp\gametypes_zm\_zm_gametype;
#include maps\mp\zombies\_zm_utility;
#include maps\mp\zombies\_zm_weapons;
#include maps\mp\zombies\_zm_melee_weapon;
#include maps\mp\zombies\_zm_weap_claymore;
#include maps\mp\zombies\_zm_weap_ballistic_knife;
#include maps\mp\zombies\_zm_equipment;
#include maps\mp\zombies\_zm_magicbox;

main()
{
	replaceFunc( common_scripts\utility::struct_class_init, ::struct_class_init_override );
	replaceFunc( maps\mp\zombies\_zm_zonemgr::manage_zones, ::manage_zones_override );
}

init()
{
	level thread on_player_connect();
}

on_player_connect()
{
	level endon( "end_game" );
	while ( true )
	{
		level waittill( "connected", player );
		//level.player_out_of_playable_area_monitor = false;
		player thread print_origin();
	}
}

print_origin()
{
	self endon( "disconnect" );
	while ( true )
	{
		wait 0.05;
		if ( getDvarInt( "ctl_debug" ) == 0 )
		{
			continue;
		}
		if ( self meleeButtonPressed() )
		{
			logprint( "origin: " + self.origin + "\n" );
			logprint( "angles: " + self.angles + "\n" );
			logprint( "anglestoforward: " + anglesToForward( self.angles ) + "\n" );
			while ( self meleeButtonPressed() )
				wait 0.05;
		}
	}
}

struct_class_init_override()
{
	level.struct_class_names = [];
	level.struct_class_names[ "target" ] = [];
	level.struct_class_names[ "targetname" ] = [];
	level.struct_class_names[ "script_noteworthy" ] = [];
	level.struct_class_names[ "script_linkname" ] = [];
	level.struct_class_names[ "script_unitrigger_type" ] = [];
	foreach ( s_struct in level.struct )
	{
		if ( isDefined( s_struct.targetname ) )
		{
			if ( !isDefined( level.struct_class_names[ "targetname" ][ s_struct.targetname ] ) )
			{
				level.struct_class_names[ "targetname" ][ s_struct.targetname ] = [];
			}
			size = level.struct_class_names[ "targetname" ][ s_struct.targetname ].size;
			level.struct_class_names[ "targetname" ][ s_struct.targetname ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.target ) )
		{
			if ( !isDefined( level.struct_class_names[ "target" ][ s_struct.target ] ) )
			{
				level.struct_class_names[ "target" ][ s_struct.target ] = [];
			}
			size = level.struct_class_names[ "target" ][ s_struct.target ].size;
			level.struct_class_names[ "target" ][ s_struct.target ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.script_noteworthy ) )
		{
			if ( !isDefined( level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] ) )
			{
				level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] = [];
			}
			size = level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ].size;
			level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ][ size ] = s_struct;
		}
		if ( isDefined( s_struct.script_linkname ) )
		{
			level.struct_class_names[ "script_linkname" ][ s_struct.script_linkname ][ 0 ] = s_struct;
		}
		if ( isDefined( s_struct.script_unitrigger_type ) )
		{
			if ( !isDefined( level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] ) )
			{
				level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] = [];
			}
			size = level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ].size;
			level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ][ size ] = s_struct;
		}
	}
	gametype = getDvar( "g_gametype" );
	location = getDvar( "ui_zm_mapstartlocation" );
	if ( array_validate( level.add_struct_gamemode_location_funcs ) )
	{
		if ( array_validate( level.add_struct_gamemode_location_funcs[ gametype ] ) )
		{
			if ( array_validate( level.add_struct_gamemode_location_funcs[ gametype ][ location ] ) )
			{
				for ( i = 0; i < level.add_struct_gamemode_location_funcs[ gametype ][ location ].size; i++ )
				{
					[[ level.add_struct_gamemode_location_funcs[ gametype ][ location ][ i ] ]]();
				}
			}
		}
	}
}

add_struct( s_struct )
{
	if ( isDefined( s_struct.targetname ) )
	{
		if ( !isDefined( level.struct_class_names[ "targetname" ][ s_struct.targetname ] ) )
		{
			level.struct_class_names[ "targetname" ][ s_struct.targetname ] = [];
		}
		size = level.struct_class_names[ "targetname" ][ s_struct.targetname ].size;
		level.struct_class_names[ "targetname" ][ s_struct.targetname ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.script_noteworthy ) )
	{
		if ( !isDefined( level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] ) )
		{
			level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ] = [];
		}
		size = level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ].size;
		level.struct_class_names[ "script_noteworthy" ][ s_struct.script_noteworthy ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.target ) )
	{
		if ( !isDefined( level.struct_class_names[ "target" ][ s_struct.target ] ) )
		{
			level.struct_class_names[ "target" ][ s_struct.target ] = [];
		}
		size = level.struct_class_names[ "target" ][ s_struct.target ].size;
		level.struct_class_names[ "target" ][ s_struct.target ][ size ] = s_struct;
	}
	if ( isDefined( s_struct.script_linkname ) )
	{
		level.struct_class_names[ "script_linkname" ][ s_struct.script_linkname ][ 0 ] = s_struct;
	}
	if ( isDefined( s_struct.script_unitrigger_type ) )
	{
		if ( !isDefined( level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] ) )
		{
			level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ] = [];
		}
		size = level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ].size;
		level.struct_class_names[ "script_unitrigger_type" ][ s_struct.script_unitrigger_type ][ size ] = s_struct;
	}
}

register_perk_struct( perk_name, perk_model, perk_angles, perk_coordinates )
{
	if ( getDvar( "g_gametype" ) == "zgrief" && perk_name == "specialty_scavenger" )
	{
		return;
	}
	perk_struct = spawnStruct();
	perk_struct.script_noteworthy = perk_name;
	perk_struct.model = perk_model;
	perk_struct.angles = perk_angles;
	perk_struct.origin = perk_coordinates;
	perk_struct.targetname = "zm_perk_machine";
	add_struct( perk_struct );
}

register_map_initial_spawnpoint( spawnpoint_coordinates, spawnpoint_angles )
{
	spawnpoint_struct = spawnStruct();
	spawnpoint_struct.origin = spawnpoint_coordinates;
	if ( isDefined( spawnpoint_angles ) )
	{
		spawnpoint_struct.angles = spawnpoint_angles;
	}
	else 
	{
		spawnpoint_struct.angles = ( 0, 0, 0 );
	}
	spawnpoint_struct.radius = 32;
	spawnpoint_struct.script_noteworthy = "initial_spawn";
	spawnpoint_struct.script_int = 2048;
	spawnpoint_struct.script_string = getDvar( "g_gametype" ) + "_" + getDvar( "ui_zm_mapstartlocation" );
	spawnpoint_struct.locked = 0;
	player_respawn_point_size = level.struct_class_names[ "targetname" ][ "player_respawn_point" ].size;
	player_initial_spawnpoint_size = level.struct_class_names[ "script_noteworthy" ][ "initial_spawn" ].size;
	level.struct_class_names[ "targetname" ][ "player_respawn_point" ][ player_respawn_point_size ] = spawnpoint_struct;
	level.struct_class_names[ "script_noteworthy" ][ "initial_spawn" ][ player_initial_spawnpoint_size ] = spawnpoint_struct;
}

wallbuy( weapon_name, target, targetname, origin, angles )
{
	unitrigger_stub = spawnstruct();
	unitrigger_stub.origin = origin;
	unitrigger_stub.angles = angles;

	model_name = undefined;
	if ( weapon_name == "sticky_grenade_zm" )
	{
		model_name = "semtex_bag";
	}
	else if ( weapon_name == "claymore_zm" )
	{
		model_name = "t6_wpn_claymore_world";
	}

	wallmodel = spawn_weapon_model( weapon_name, model_name, origin, angles );
	wallmodel.targetname = target;
	wallmodel useweaponhidetags( weapon_name );
	wallmodel hide();

	absmins = wallmodel getabsmins();
	absmaxs = wallmodel getabsmaxs();
	bounds = absmaxs - absmins;

	unitrigger_stub.script_length = 64;
	unitrigger_stub.script_width = bounds[ 1 ];
	unitrigger_stub.script_height = bounds[ 2 ];
	unitrigger_stub.target = target;
	unitrigger_stub.targetname = targetname;
	unitrigger_stub.cursor_hint = "HINT_NOICON";

	// move model forward so it always shows in front of chalk
	move_amount = anglesToRight( wallmodel.angles ) * -0.3;
	wallmodel.origin += move_amount;
	unitrigger_stub.origin += move_amount;

	if ( unitrigger_stub.targetname == "weapon_upgrade" )
	{
		unitrigger_stub.cost = get_weapon_cost( weapon_name );
		if ( !is_true( level.monolingustic_prompt_format ) )
		{
			unitrigger_stub.hint_string = get_weapon_hint( weapon_name );
			unitrigger_stub.hint_parm1 = unitrigger_stub.cost;
		}
		else
		{
			unitrigger_stub.hint_parm1 = get_weapon_display_name( weapon_name );
			if ( !isDefined( unitrigger_stub.hint_parm1 ) || unitrigger_stub.hint_parm1 == "" || unitrigger_stub.hint_parm1 == "none" )
			{
				unitrigger_stub.hint_parm1 = "missing weapon name " + weapon_name;
			}
			unitrigger_stub.hint_parm2 = unitrigger_stub.cost;
			unitrigger_stub.hint_string = &"ZOMBIE_WEAPONCOSTONLY";
		}
	}

	unitrigger_stub.weapon_upgrade = weapon_name;
	unitrigger_stub.script_unitrigger_type = "unitrigger_box_use";
	unitrigger_stub.require_look_at = 1;
	unitrigger_stub.require_look_from = 0;
	unitrigger_stub.zombie_weapon_upgrade = weapon_name;
	maps\mp\zombies\_zm_unitrigger::unitrigger_force_per_player_triggers( unitrigger_stub, 1 );

	if ( is_melee_weapon( weapon_name ) )
	{
		melee_weapon = undefined;
		foreach(melee_weapon in level._melee_weapons)
		{
			if(melee_weapon.weapon_name == weapon_name)
			{
				break;
			}
		}

		if(isDefined(melee_weapon))
		{
			unitrigger_stub.cost = melee_weapon.cost;
			unitrigger_stub.hint_string = melee_weapon.hint_string;
			unitrigger_stub.weapon_name = melee_weapon.weapon_name;
			unitrigger_stub.flourish_weapon_name = melee_weapon.flourish_weapon_name;
			unitrigger_stub.ballistic_weapon_name = melee_weapon.ballistic_weapon_name;
			unitrigger_stub.ballistic_upgraded_weapon_name = melee_weapon.ballistic_upgraded_weapon_name;
			unitrigger_stub.vo_dialog_id = melee_weapon.vo_dialog_id;
			unitrigger_stub.flourish_fn = melee_weapon.flourish_fn;

			if(is_true(level.disable_melee_wallbuy_icons))
			{
				unitrigger_stub.cursor_hint = "HINT_NOICON";
				unitrigger_stub.cursor_hint_weapon = undefined;
			}
			else
			{
				unitrigger_stub.cursor_hint = "HINT_WEAPON";
				unitrigger_stub.cursor_hint_weapon = melee_weapon.weapon_name;
			}
		}

		if(weapon_name == "tazer_knuckles_zm")
		{
			unitrigger_stub.origin += anglesToForward(angles) * -7;
			unitrigger_stub.origin += anglesToRight(angles) * -2;
		}

		wallmodel.origin += anglesToForward(angles) * -8; // _zm_melee_weapon::melee_weapon_show moves this back

		maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( unitrigger_stub, ::melee_weapon_think );
	}
	else if ( weapon_name == "claymore_zm" )
	{
		wallmodel.angles += (0, 90, 0);
		wallmodel.script_int = 90; // fix for model sliding right to left

		unitrigger_stub.prompt_and_visibility_func = maps\mp\zombies\_zm_weap_claymore::claymore_unitrigger_update_prompt;
		maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( unitrigger_stub, maps\mp\zombies\_zm_weap_claymore::buy_claymores );
	}
	else
	{
		unitrigger_stub.prompt_and_visibility_func = ::wall_weapon_update_prompt;
		maps\mp\zombies\_zm_unitrigger::register_static_unitrigger( unitrigger_stub, ::weapon_spawn_think );
	}

	chalk_fx = weapon_name + "_fx";
	level thread playchalkfx( chalk_fx, origin, angles );

	if(weaponType(weapon_name) == "grenade")
	{
		unitrigger_stub thread wallbuy_grenade_model_fix();
	}
}

// fixes grenade wallbuy model doing first trigger animation everytime
wallbuy_grenade_model_fix()
{
	model = getent(self.target, "targetname");
	if(!isDefined(model))
	{
		return;
	}

	model waittill("movedone");

	self.target = undefined;
}

playchalkfx( effect, origin, angles )
{
	while ( 1 )
	{
		fx = SpawnFX( level._effect[ effect ], origin, AnglesToForward( angles ), AnglesToUp( angles ) );
		TriggerFX( fx );
		level waittill( "connected", player );
		fx Delete();
	}
}

barrier( barrier_coordinates, barrier_model, barrier_angles, not_solid )
{
	if ( !isDefined( level.survival_barriers ) )
	{
		level.survival_barriers = [];
		level.survival_barriers_index = 0;
	}
	level.survival_barriers[ level.survival_barriers_index ] = spawn( "script_model", barrier_coordinates );
	level.survival_barriers[ level.survival_barriers_index ] setModel( barrier_model );
	level.survival_barriers[ level.survival_barriers_index ] rotateTo( barrier_angles, 0.1 );
	if ( is_true( not_solid ) )
	{
		level.survival_barriers[ level.survival_barriers_index ] notSolid();
	}
	level.survival_barriers_index++;
}

add_struct_location_gamemode_func( gametype, location, func )
{
	if ( !isDefined( level.add_struct_gamemode_location_funcs ) )
	{
		level.add_struct_gamemode_location_funcs = [];
	}
	if ( !isDefined( level.add_struct_gamemode_location_funcs[ gametype ] ) )
	{
		level.add_struct_gamemode_location_funcs[ gametype ] = [];
	}
	if ( !isDefined( level.add_struct_gamemode_location_funcs[ gametype ][ location ] ) )
	{
		level.add_struct_gamemode_location_funcs[ gametype ][ location ] = [];
	}
	level.add_struct_gamemode_location_funcs[ gametype ][ location ][ level.add_struct_gamemode_location_funcs[ gametype ][ location ].size ] = func;
}

add_zone_location_func( location, func )
{
	if ( !isDefined( level.location_zones ) )
	{
		level.location_zones = [];
	}
	if ( !isDefined( level.location_zones[ location ] ) )
	{
		level.location_zones[ location ] = [];
	}
	level.location_zones[ location ] = [[ func ]]();
}

manage_zones_override( initial_zone )
{
	assert( isdefined( initial_zone ), "You must specify an initial zone to manage" );
	deactivate_initial_barrier_goals();
	zone_choke = 0;
	spawn_points = maps\mp\gametypes_zm\_zm_gametype::get_player_spawns_for_gametype();

	for ( i = 0; i < spawn_points.size; i++ )
	{
		assert( isdefined( spawn_points[i].script_noteworthy ), "player_respawn_point: You must specify a script noteworthy with the zone name" );
		spawn_points[i].locked = 1;
	}

	if ( isdefined( level.zone_manager_init_func ) )
		[[ level.zone_manager_init_func ]]();

	location = getDvar( "ui_zm_mapstartlocation" );
	if ( isDefined( level.location_zones ) && isDefined( level.location_zones[ location ] ) )
	{
		location_zones = level.location_zones[ location ];
		for ( i = 0; i < location_zones.size; i++ )
		{
			zone_init( location_zones[ i ] );
			enable_zone( location_zones[ i ] );
		}
		initial_zone = level.location_zones[ location ];
	}
	else if ( isarray( initial_zone ) )
	{
		for ( i = 0; i < initial_zone.size; i++ )
		{
			zone_init( initial_zone[i] );
			enable_zone( initial_zone[i] );
		}
	}
	else
	{
/#
		println( "ZM >> zone_init (_zm_zonemgr.gsc) = " + initial_zone );
#/
		zone_init( initial_zone );
		enable_zone( initial_zone );
	}

	if ( isDefined( level.location_zones_func ) )
	{
		level [[ level.location_zones_func ]]();
	}

	setup_zone_flag_waits();
	zkeys = getarraykeys( level.zones );
	level.zone_keys = zkeys;
	level.newzones = [];

	for ( z = 0; z < zkeys.size; z++ )
		level.newzones[zkeys[z]] = spawnstruct();

	oldzone = undefined;
	flag_set( "zones_initialized" );
	flag_wait( "begin_spawning" );
/#
	level thread _debug_zones();
#/
	while ( getdvarint( "noclip" ) == 0 || getdvarint( "notarget" ) != 0 )
	{
		for ( z = 0; z < zkeys.size; z++ )
		{
			level.newzones[zkeys[z]].is_active = 0;
			level.newzones[zkeys[z]].is_occupied = 0;
		}

		a_zone_is_active = 0;
		a_zone_is_spawning_allowed = 0;
		level.zone_scanning_active = 1;

		for ( z = 0; z < zkeys.size; z++ )
		{
			zone = level.zones[zkeys[z]];
			newzone = level.newzones[zkeys[z]];

			if ( !zone.is_enabled )
				continue;

			if ( isdefined( level.zone_occupied_func ) )
				newzone.is_occupied = [[ level.zone_occupied_func ]]( zkeys[z] );
			else
				newzone.is_occupied = player_in_zone( zkeys[z] );

			if ( newzone.is_occupied )
			{
				newzone.is_active = 1;
				a_zone_is_active = 1;

				if ( zone.is_spawning_allowed )
					a_zone_is_spawning_allowed = 1;

				if ( !isdefined( oldzone ) || oldzone != newzone )
				{
					level notify( "newzoneActive", zkeys[z] );
					oldzone = newzone;
				}

				azkeys = getarraykeys( zone.adjacent_zones );

				for ( az = 0; az < zone.adjacent_zones.size; az++ )
				{
					if ( zone.adjacent_zones[azkeys[az]].is_connected && level.zones[azkeys[az]].is_enabled )
					{
						level.newzones[azkeys[az]].is_active = 1;

						if ( level.zones[azkeys[az]].is_spawning_allowed )
							a_zone_is_spawning_allowed = 1;
					}
				}
			}

			zone_choke++;

			if ( zone_choke >= 3 )
			{
				zone_choke = 0;
				wait 0.05;
			}
		}

		level.zone_scanning_active = 0;

		for ( z = 0; z < zkeys.size; z++ )
		{
			level.zones[zkeys[z]].is_active = level.newzones[zkeys[z]].is_active;
			level.zones[zkeys[z]].is_occupied = level.newzones[zkeys[z]].is_occupied;
		}

		if ( !a_zone_is_active || !a_zone_is_spawning_allowed )
		{
			if ( isarray( initial_zone ) )
			{
				level.zones[initial_zone[0]].is_active = 1;
				level.zones[initial_zone[0]].is_occupied = 1;
				level.zones[initial_zone[0]].is_spawning_allowed = 1;
			}
			else
			{
				level.zones[initial_zone].is_active = 1;
				level.zones[initial_zone].is_occupied = 1;
				level.zones[initial_zone].is_spawning_allowed = 1;
			}
		}

		[[ level.create_spawner_list_func ]]( zkeys );
/#
		debug_show_spawn_locations();
#/
		level.active_zone_names = maps\mp\zombies\_zm_zonemgr::get_active_zone_names();
		wait 1;
	}
}
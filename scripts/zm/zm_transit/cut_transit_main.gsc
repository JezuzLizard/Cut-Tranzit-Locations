#include scripts/zm/zm_transit/gamemodes;
#include scripts/zm/zm_transit/locs/location_common;
#include maps/mp/zombies/_zm_utility;
#include maps/mp/_utility;
#include common_scripts/utility;

main()
{
	replaceFunc( common_scripts/utility::struct_class_init, ::struct_class_init_override );
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
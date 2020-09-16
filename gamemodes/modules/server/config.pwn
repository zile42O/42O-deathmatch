#define hostname ".: 42O :. DeathMatch (SKINHIT)"
#define language "English"
#define gamemode "42O DM | v1.0"
#define mapname "Custom Arenas"
#define weburl "www.42Oclan.com"
#define nametags true
#define syncbugs false
#define markertype 2
#define player_ped_anims true
#define tag_name_distance 20.0
#define interiors_weapons 1
public OnGameModeInit()
{
	SendRconCommand("hostname "hostname"");
	SendRconCommand("language "language"");
	SetGameModeText(""gamemode"");
	SendRconCommand("mapname "mapname"");
	SendRconCommand("weburl "weburl"");
	ShowNameTags(nametags);
	SetDisableSyncBugs(syncbugs);
	ShowPlayerMarkers(markertype);	
	DisableInteriorEnterExits();
	#if player_ped_anims == true
	UsePlayerPedAnims();
	#endif
	SetNameTagDrawDistance(tag_name_distance);
	AllowInteriorWeapons(interiors_weapons);

	print("[INFO]: Server configuration applied:\n");
	printf("\
		Hostname: ("hostname")\n\
		Language: ("language")\n\
		Gamemode: ("gamemode")\n\
		Mapname: ("mapname")\n\
		Weburl: ("weburl")\n\
		Name tags: (%i)\n\
		Sync bugs: (%i)\n\
		Marker player style: (%i)\n\
		Ped anims: (%i)\n\
		Nametag distance: (%f)\n\
		Interior weapons: (%i)",
		nametags,
		syncbugs,
		markertype,
		player_ped_anims, 
		tag_name_distance,
		interiors_weapons
	);

	SetWeaponDamage(
		WEAPON_SNIPER,
		DAMAGE_TYPE_RANGE,
		45.0,
		4.0, 35.0,
		90.0, 30.0
	);
	SetWeaponDamage(
		WEAPON_RIFLE,
		DAMAGE_TYPE_RANGE,
		37.5,
		4.0, 30.0
	);
	SetWeaponDamage(
		WEAPON_DEAGLE,
		DAMAGE_TYPE_RANGE,
		35.0,
		25.0, 25.0
	);
	SetWeaponDamage(
		WEAPON_SILENCED,
		DAMAGE_TYPE_STATIC,
		15.0
	);
	SetWeaponDamage(
		WEAPON_PISTOLWHIP,
		DAMAGE_TYPE_STATIC,
		10.0
	);
	SetWeaponDamage(
		WEAPON_M4,
		DAMAGE_TYPE_STATIC,
		8.0
	);
	SetWeaponDamage(
		WEAPON_AK47,
		DAMAGE_TYPE_STATIC,
		11.5
	);
	SetDamageSounds(1190, 17802);		// Slice
	SetWeaponMaxRange(WEAPON_RIFLE, 	120.0);
	SetWeaponMaxRange(WEAPON_SNIPER, 	150.0);
	SetWeaponMaxRange(WEAPON_M4,		100.0);
	SetWeaponMaxRange(WEAPON_DEAGLE, 	40.0);
	SetWeaponMaxRange(WEAPON_SHOTGUN,	50.0);
	SetWeaponMaxRange(WEAPON_AK47,  	100.0);
#if defined CONFIG_OnGameModeInit
	return CONFIG_OnGameModeInit();
#else
	return true;
#endif
}	

#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit CONFIG_OnGameModeInit
#if defined CONFIG_OnGameModeInit
	forward CONFIG_OnGameModeInit();
#endif
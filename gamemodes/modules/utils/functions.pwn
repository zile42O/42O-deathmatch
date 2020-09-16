ReturnName(playerid)
{
	new name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

SpawnForPlayer(playerid)
{	
	SetSpawnInfo(playerid, NO_TEAM, GetPlayerSkin(playerid), 2814.3296, 994.2086, 17.5889, 182.4584, 24, 420, 0, 0, 0, 0);
	SetPlayerInterior(playerid, 0);
	if (GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) {
		TogglePlayerSpectating(playerid, false);	
	}
	else {
		SpawnPlayer(playerid);		
	}
	return true;
}
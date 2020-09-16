forward OnPlayerAutoLogin(playerid);
public OnPlayerAutoLogin(playerid)
{	
	CallLocalFunction("OnPlayerLogin", "i", playerid);
	return true;
}

forward OnPlayerLogin(playerid);
public OnPlayerLogin(playerid)
{
	new arg[100];
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	format(arg, sizeof(arg),"* Welcome back %s.",ReturnName(playerid));
	SendClientMessage(playerid, green_, arg);			
	SetPlayerScore(playerid, PlayerData[playerid][p_level]);
	SetPlayerSkin(playerid, PlayerData[playerid][p_skin]);		
	SetPlayerFightingStyle(playerid, FIGHT_STYLE_KUNGFU);
	SetCameraBehindPlayer(playerid);
	SetPlayerColor(playerid, white_);
	StopAudioStreamForPlayer(playerid);
	PlayerData[playerid][p_logged] = true;
	SpawnForPlayer(playerid);
	return true;
}
forward OnPlayerRegister(playerid);
public OnPlayerRegister(playerid)
{
	new arg[100];
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, -1, " ");
	SendClientMessage(playerid, white_, "___________________________________________________________________________");
	SendClientMessage(playerid, -1, " ");
	format(arg,sizeof(arg),"* Welcome to the server, you are registered with name %s.", ReturnName(playerid));
	SendClientMessage(playerid, green_, arg);
	PlayerData[playerid][p_logged] = true;
	SaveAccount(playerid);
	SpawnForPlayer(playerid);
	return true;
}
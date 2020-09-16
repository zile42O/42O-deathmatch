forward public SaveAccount(playerid);
public SaveAccount(playerid)
{
	if (!IsPlayerConnected(playerid)) return false;
	if (!PlayerData[playerid][p_logged]) return false;

	new query[512];
	format(query, sizeof query, "`password`='%s', `skin`='%i', `play time`='%i', `level`='%i', `lastIP`='%s', `lastOnline`= CURRENT_TIMESTAMP()",
	PlayerData[playerid][p_password],
	PlayerData[playerid][p_skin],
	PlayerData[playerid][p_playtime],
	PlayerData[playerid][p_level],
	PlayerData[playerid][p_lastIP]);
	mysql_format(SQL, query, sizeof query, "UPDATE `"USER_TABLE"` SET %s WHERE `username`='%s'", query, ReturnName(playerid));
	mysql_query(SQL, query);
	return true;
}

forward public sql_OnPlayerAccountExists(playerid);
public sql_OnPlayerAccountExists(playerid) 
{
	new rows;
	cache_get_row_count(rows);
	new info[164];
	if (rows) {
		PlayerData[playerid][p_skin] = DEFAULT_PLAYER_SKIN;
		PlayerData[playerid][p_level] =
		PlayerData[playerid][p_playtime] =
		PlayerData[playerid][p_lastIP] = -1;
		mysql_format(SQL, info, sizeof info, "SELECT * FROM `"USER_TABLE"` WHERE `username`='%s'", ReturnName(playerid));
		mysql_tquery(SQL, info, "sql_LoadPlayerData", "i", playerid);
	} else {
		format(info, sizeof(info), "\\c"white"Welcome to the server, "green"%s\n\
		\\c"white"Please, insert your password in box below.\n\
		\\c"green"www.42Oclan.com",	ReturnName(playerid));
		ShowPlayerDialog(playerid, dialog_register, DIALOG_STYLE_PASSWORD, "Register", info, "Input", "Disconnect");
	}
	return true;
}

forward sql_OnAccountCreate(playerid);
public sql_OnAccountCreate(playerid)
{
	if (!IsPlayerConnected(playerid))
		return false;

	PlayerData[playerid][p_sqlid] = cache_insert_id();
	PlayerData[playerid][p_skin] = DEFAULT_PLAYER_SKIN;
	PlayerData[playerid][p_level] =
	PlayerData[playerid][p_playtime] =
	PlayerData[playerid][p_lastIP] = -1;
	CallLocalFunction("OnPlayerRegister", "i", playerid);
	return true;
}

forward sql_LoadPlayerData(playerid);
public sql_LoadPlayerData(playerid) 
{
	new query[200];
	cache_get_value_name_int(0, "ID", PlayerData[playerid][p_sqlid]);
	cache_get_value_name(0, "password", PlayerData[playerid][p_password], 256);
	cache_get_value_name_int(0, "skin", PlayerData[playerid][p_skin]);
	cache_get_value_name_int(0, "level", PlayerData[playerid][p_level]);
	cache_get_value_name_int(0, "play time", PlayerData[playerid][p_playtime]);
	cache_get_value_name(0, "lastIP", PlayerData[playerid][p_lastIP], MAX_PLAYER_IP_ADDRESS);
	mysql_format(SQL, query, sizeof query, "SELECT * FROM `"USER_TABLE"` WHERE `username`='%s'", ReturnName(playerid));
	mysql_tquery(SQL, query, "sql_IsPlayerRegistered", "i", playerid);
}

forward sql_IsPlayerRegistered(playerid);
public sql_IsPlayerRegistered(playerid)
{
	new rows;
	cache_get_row_count(rows);
	if (rows) {
		new info[128];
		new nowIP[MAX_PLAYER_IP_ADDRESS];
		GetPlayerIp(playerid, nowIP, MAX_PLAYER_IP_ADDRESS);
		if (!strcmp(nowIP, PlayerData[playerid][p_lastIP], true)) {
			SendClientMessage(playerid, green_, "You are automatically logged in!");
			SetTimerEx("OnPlayerAutoLogin", 3500, false, "i", playerid);
		} else {
			format(info, sizeof(info), 
			"\\c"white"Welcome back, "green"%s\n\
			\\c"white"Please, insert your password in box below.",
			ReturnName(playerid));
			ShowPlayerDialog(playerid, dialog_login, DIALOG_STYLE_PASSWORD, "Login", info, "Input", "Disconnect");
		}
	} 
	else Kick(playerid);
	return true;
}
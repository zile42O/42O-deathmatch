public OnGameModeExit()
{
	new count = 0;
	for (new i = GetPlayerPoolSize(); i != -1; i--) {
		if (IsPlayerConnected(i) && !IsPlayerNPC(i)) {
			SaveAccount(i);
			Kick(i);
			count++;
		}
	}
	if (count > 0)
		printf("* [!] OnGameModeExit is called, %i connected players is saved.", count);
	else 
		print("* [!] OnGameModeExit is called, no connected players for saving.");
	return true;
}

public OnPlayerConnect(playerid)
{
	for (new i = 0; i < 80; i++) 
		SendClientMessage(playerid, -1," ");
	
	new version[24], arg[64];
	GetPlayerVersion(playerid, version, sizeof(version));
	format(arg, sizeof(arg), "Your version of SA-MP: %s", version);	
	if (strfind(version, "0.3.7-R4", true) == -1) {
		SendClientMessage(playerid, tomato_, arg);
		SendClientMessage(playerid, tomato_, "Version 0.3.7-R4 is recommended!");
		//Kick_(playerid, "Invalid version.");
		//return false;
	}
	SendClientMessage(playerid, green_, arg);
	SetSpawnInfo(playerid, NO_TEAM, 229, 2814.3296, 994.2086, 17.5889, 182.4584, 24, 420, 0, 0, 0, 0);
	TogglePlayerSpectating(playerid, true);

	new query[128];
	mysql_format(SQL, query, sizeof(query), "SELECT * FROM `"USER_TABLE"` WHERE `username`='%s'", ReturnName(playerid));
	mysql_tquery(SQL, query, "sql_OnPlayerAccountExists", "i", playerid);	
	return true;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveAccount(playerid);
	PlayerData[playerid][p_logged] = false;
	return true;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if (IsPlayerNPC(playerid)) return false;
	if (response)
		PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	else
		PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	
	switch (dialogid) {
		case dialog_register: {
			if (!response) return Kick(playerid);
			if (response) {
				new info[256];
				format(info, sizeof(info), 
				"\\c"white"Welcome to the server, "green"%s\n\
				\\c"white"Please, insert your password in box below.\n\
				\\c"tomato"* Min. 8 characters or max. 16.\n\
				\\c"green"www.42Oclan.com",	ReturnName(playerid));
				if (strlen(inputtext) < 8 || strlen(inputtext) > 16) return ShowPlayerDialog(playerid, dialog_register, DIALOG_STYLE_PASSWORD, "Register", info, "Input", "Disconnect");
				SHA256_PassHash(inputtext, SALT_KEY_HASH, PlayerData[playerid][p_password], 256);
				mysql_format(SQL, info, sizeof(info), "INSERT INTO `"USER_TABLE"` (`password`, `username`) VALUES ('%s', '%s')", PlayerData[playerid][p_password], ReturnName(playerid));
				mysql_tquery(SQL, info, "sql_OnAccountCreate", "i", playerid);
			}
		}
		case dialog_login: {
			if (!response) return Kick(playerid);
			if (response) {
				new info[256];
				SHA256_PassHash(inputtext, SALT_KEY_HASH, info, sizeof(info));
				if (!strcmp(info, PlayerData[playerid][p_password])) {
					CallLocalFunction("OnPlayerLogin", "i", playerid);
					new nowIP[MAX_PLAYER_IP_ADDRESS];
					GetPlayerIp(playerid, nowIP, MAX_PLAYER_IP_ADDRESS);
					format(PlayerData[playerid][p_lastIP], MAX_PLAYER_IP_ADDRESS, nowIP);
				} else {					
					format(info, sizeof(info), 
					"\\c"white"Welcome back, "green"%s\n\
					\\c"white"Please, insert your password in box below.\n\
					\\c"tomato"* Please enter a correct password.",
					ReturnName(playerid));
					ShowPlayerDialog(playerid, dialog_login, DIALOG_STYLE_PASSWORD, "Register", info, "Input", "Disconnect");
				}
			}
		}
	}
	return true;
}
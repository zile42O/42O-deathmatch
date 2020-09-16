enum E_PLAYER_DATA 
{
	p_sqlid,
	p_password[256],		
	p_playtime,	
	p_skin,
	p_level,
	p_lastIP[MAX_PLAYER_IP_ADDRESS],
	bool: p_logged
};
new PlayerData[MAX_PLAYERS][E_PLAYER_DATA];

new MySQL: SQL;

public OnGameModeInit()
{	
	SQL = mysql_connect_file();
	mysql_log(ALL);
	new err = mysql_errno(SQL);
	if (!err) {
		printf("[SUCCESS] Correct MySQL connection!");
	} else {
		print("[FAILED] Invalid MySQL connection!");
		SendRconCommand("exit");
		return true;
	}
	#if defined MYSQL_OnGameModeInit
		return MYSQL_OnGameModeInit();
	#else
		return true;
	#endif
}	
#if defined _ALS_OnGameModeInit
	#undef OnGameModeInit
#else
	#define _ALS_OnGameModeInit
#endif
#define OnGameModeInit MYSQL_OnGameModeInit
#if defined MYSQL_OnGameModeInit
	forward MYSQL_OnGameModeInit();
#endif
//     ___  _____  _____                           _               _    _                    
//    /   |/ __  \|  _  |                         | |             | |  (_)                   
//   / /| |`' / /'| | | |  _ __   _ __   ___    __| | _   _   ___ | |_  _   ___   _ __   ___ 
//  / /_| |  / /  | | | | | '_ \ | '__| / _ \  / _` || | | | / __|| __|| | / _ \ | '_ \ / __|
//  \___  |./ /___\ \_/ / | |_) || |   | (_) || (_| || |_| || (__ | |_ | || (_) || | | |\__ \
//      |_/\_____/ \___/  | .__/ |_|    \___/  \__,_| \__,_| \___| \__||_| \___/ |_| |_||___/
//                        | |                                                                
//                        |_|                                                                

//	Author: Aleksandar Živković (zile42O)
//	zile42o.github.io/portfolio
//	https://github.com/zile42O/42O-deathmatch

/*
	Includes 
*/

#include			< a_samp >
#define				FIXES_Single 1
#define				FIXES_Debug 0
#define				FIXES_ServerVarMsg 0
#undef				MAX_PLAYERS
#define				MAX_PLAYERS 100
#include			<fixes>
#include			<weapon-config>

#if defined _ALS_OnPlayerGiveDamage
	#undef OnPlayerGiveDamage
#else
	#define _ALS_OnPlayerGiveDamage
#endif
#define OnPlayerGiveDamage NULL_OnPlayerGiveDamage
#if defined NULL_OnPlayerGiveDamage
	forward NULL_OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid);
#endif
#if defined _ALS_OnPlayerTakeDamage
	#undef OnPlayerTakeDamage
#else
	#define _ALS_OnPlayerTakeDamage
#endif
#define OnPlayerTakeDamage NULL_OnPlayerTakeDamage
#if defined NULL_OnPlayerTakeDamage
	forward NULL_OnPlayerTakeDamage(playerid, issuerid, Float:amount, weaponid);
#endif	

#include			<streamer>
#include			<a_mysql>
#include			<sscanf2>
#include			<colandreas>
#include			<pawn.cmd>
#include			<scope-fix>
#include			<dcenter> //Ino
/* 
	Modules
*/
#include "modules/modules.pwn"
main()
{		
	print("_______________________________________________________________\n\n");
	print("\tName: 42O Deathmatch");
	print("\tVersion: 1.0");
	print("\tAuthor: zile42O\n\n");
	print("_______________________________________________________________");
}
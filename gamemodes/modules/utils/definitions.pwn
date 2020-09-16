/*   _       __ _                 
  __| | ___ / _(_)_ __   ___  ___ 
 / _` |/ _ \ |_| | '_ \ / _ \/ __|
| (_| |  __/  _| | | | |  __/\__ \
 \__,_|\___|_| |_|_| |_|\___||___/
                                  
*/
#define SALT_KEY_HASH "a$b#2c^d@fGjKlZmn2"
#define MAX_PLAYER_IP_ADDRESS 16
#define DEFAULT_PLAYER_SKIN 229
//Colors: 
#define white_ 		0xFFFFFFAA
#define white 		"{FFFFFF}"
#define tomato_		0xFF4040AA
#define tomato 		"{FF4040}"
#define green_ 		0xADFF2FAA 
#define green  		"{ADFF2F}"
#define orange_ 	0xFFA500AA
#define orange 		"{FFA500}"
#define ac 			"{C40000}"
#define ac_ 		0xC40000AA
/*
  ___ _ __  _   _ _ __ ___  ___ 
 / _ \ '_ \| | | | '_ ` _ \/ __|
|  __/ | | | |_| | | | | | \__ \
 \___|_| |_|\__,_|_| |_| |_|___/
                                
*/

enum _:E_DIALOGS 
{
	dialog_none = 0,
	dialog_register,
	dialog_login
}
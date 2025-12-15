
enum _LZ_Player
{
	pFlashOn
};
new LZ_PlayerData[MAX_PLAYERS][_LZ_Player];


#define FLASH_ON 		1
#define FLASH_OFF		0
/* Bicycle Jump Detector */

forward OnPlayerBicycleJump(playerid, vehicleid);

stock LZ_IsBicycle(vehicleid)
{
	switch (GetVehicleModel(vehicleid))
	{
		case 481, 509, 510: return 1;
	}
	return 0;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	new vehicleid = GetPlayerVehicleID(playerid);
	if(newkeys & KEY_ACTION && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
	    if(LZ_IsBicycle(vehicleid))
	    {
	        CallLocalFunction("OnPlayerBicycleJump", "ii", playerid, vehicleid);
		}
	}
	#if defined LZ_OnPlayerKeyStateChange
	    return LZ_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}


#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange  LZ_OnPlayerKeyStateChange

#if defined LZ_OnPlayerKeyStateChange
	forward LZ_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif
/* jumpbike.inc by LuminouZ 

 Callbacks :

public OnPlayerBicycleJump(playerid, vehicleid)*/

							

forward OnPlayerBicycleJump(playerid, vehicleid);

stock JB_IsBicycle(vehicleid)
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
	    if(JB_IsBicycle(vehicleid))
	    {
	        CallLocalFunction("OnPlayerBicycleJump", "ii", playerid, vehicleid);
		}
	}
	#if defined JB_OnPlayerKeyStateChange
	    return JB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
	#else
		return 1;
	#endif
}

#if defined _ALS_OnPlayerKeyStateChange
	#undef OnPlayerKeyStateChange
#else
	#define _ALS_OnPlayerKeyStateChange
#endif

#define OnPlayerKeyStateChange  JB_OnPlayerKeyStateChange

#if defined JB_OnPlayerKeyStateChange
	forward JB_OnPlayerKeyStateChange(playerid, newkeys, oldkeys);
#endif

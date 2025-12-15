new Float:ac_arm_armour[MAX_PLAYERS];

public ac_timer(playerid)
{
	new Float:armour;
	GetPlayerArmour(playerid, armour);
	if(_:ac_arm_armour[playerid] != _:armour && GetPVarInt(playerid, "ac-ignore") < gettime())
	{
		if((ac_arm_armour[playerid] > armour))
		{
			ac_arm_armour[playerid] = armour;
		}
		else if(ac_arm_armour[playerid] < armour)
		{
			SetPlayerArmour(playerid, ac_arm_armour[playerid]);
			OnCheatDetected(playerid, ANTICHEAT_CODE_ARMOUR);
		}
	}
    #if defined ac_arm_timer
        return ac_arm_timer(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_ac_timer
    #undef ac_timer
#else
    #define _ALS_ac_timer
#endif

#define ac_timer ac_arm_timer
#if defined ac_arm_timer
    forward ac_arm_timer(playerid);
#endif

stock ac_arm_SetPlayerArmour(playerid, Float:armour)
{
	SetPVarInt(playerid, "ac-ignore", gettime() + 1);
	ac_arm_armour[playerid] = armour;
	return SetPlayerArmour(playerid, armour);
}
#if	defined	_ALS_SetPlayerArmour
	#undef SetPlayerArmour
#else
	#define	_ALS_SetPlayerArmour
#endif
#define SetPlayerArmour ac_arm_SetPlayerArmour

stock ac_arm_GetPlayerArmour(playerid, &Float:armour)
{
	armour = ac_arm_armour[playerid];
	return 1;
}
#if	defined	_ALS_GetPlayerArmour
	#undef	GetPlayerArmour
#else
	#define	_ALS_GetPlayerArmour
#endif
#define GetPlayerArmour ac_arm_GetPlayerArmour
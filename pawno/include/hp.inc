new Float:ac_hp_health[MAX_PLAYERS];

public ac_timer(playerid)
{
	new Float:health;
	GetPlayerHealth(playerid, health);
	if(_:ac_hp_health[playerid] != _:health && GetPVarInt(playerid, "ac-ignore") < gettime())
	{
		if((ac_hp_health[playerid] > health))
		{
			ac_hp_health[playerid] = health;
		}
		else if(ac_hp_health[playerid] < health)
		{
			SetPlayerHealth(playerid, ac_hp_health[playerid]);
			OnCheatDetected(playerid, ANTICHEAT_CODE_HP);
		}
	}
    #if defined ac_hp_timer
        return ac_hp_timer(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_ac_timer
    #undef ac_timer
#else
    #define _ALS_ac_timer
#endif

#define ac_timer ac_hp_timer
#if defined ac_hp_timer
    forward ac_hp_timer(playerid);
#endif

stock ac_hp_SetPlayerHealth(playerid, Float:health)
{
	SetPVarInt(playerid, "ac-ignore", gettime() + 1);
	ac_hp_health[playerid] = health;
	return SetPlayerHealth(playerid, health);
}
#if	defined	_ALS_SetPlayerHealth
	#undef SetPlayerHealth
#else
	#define	_ALS_SetPlayerHealth
#endif
#define SetPlayerHealth ac_hp_SetPlayerHealth

stock ac_hp_GetPlayerHealth(playerid, &Float:health)
{
	health = ac_hp_health[playerid];
	return 1;
}
#if	defined	_ALS_GetPlayerHealth
	#undef	GetPlayerHealth
#else
	#define	_ALS_GetPlayerHealth
#endif
#define GetPlayerHealth ac_hp_GetPlayerHealth
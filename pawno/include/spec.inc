/**
*
*	Regasen Play
*	Airbreak/TP/Fly
*
**/
new ac_spec[MAX_PLAYERS];

stock ac_spec_TogglePlayerSpectating(playerid, toggle)
{
    ac_spec[playerid] = toggle;
	
    return TogglePlayerSpectating(playerid, toggle);
}
#if defined _ALS_TogglePlayerSpectating
    #undef TogglePlayerSpectating
#else
    #define _ALS_TogglePlayerSpectating
#endif

#define TogglePlayerSpectating ac_spec_TogglePlayerSpectating

public ac_timer(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING && !ac_spec[playerid])
	{
		OnCheatDetected(playerid, ANTICHEAT_CODE_SPECTATE);
	}
	
    #if defined ac_spec_timer
        return ac_spec_timer(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_ac_timer
    #undef ac_timer
#else
    #define _ALS_ac_timer
#endif

#define ac_timer ac_spec_timer
#if defined ac_spec_timer
    forward ac_spec_timer(playerid);
#endif
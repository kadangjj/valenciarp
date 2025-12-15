new ac_weapon_player[MAX_PLAYERS][13][2];

forward OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ);
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
	switch(weaponid)
    {
        case 0..15,40,44..46: return true;
    }
    ac_weapon_player[playerid][slot(weaponid)][1] -= 1;
    if(ac_weapon_player[playerid][slot(weaponid)][1] > GetPlayerAmmo(playerid)) ac_weapon_player[playerid][slot(weaponid)][1] = GetPlayerAmmo(playerid);
    else if(ac_weapon_player[playerid][slot(weaponid)][1]+9 < GetPlayerAmmo(playerid))
    {
    	OnCheatDetected(playerid, ANTICHEAT_CODE_WEAPON);
    }
#if	defined	ac_weapon_OnPlayerWeaponShot
	ac_weapon_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
#endif
	return 1;
}
#if	defined	_ALS_OnPlayerWeaponShot
	#undef	OnPlayerWeaponShot
#else
	#define	_ALS_OnPlayerWeaponShot
#endif
#define	OnPlayerWeaponShot	ac_weapon_OnPlayerWeaponShot
#if	defined	ac_weapon_OnPlayerWeaponShot
forward ac_weapon_OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, fX, fY, fZ);
#endif

public OnPlayerConnect(playerid)
{
	ResetWeapons(playerid);
#if	defined	ac_weapon_OnPlayerConnect
	ac_weapon_OnPlayerConnect(playerid);
#endif
	return 1;
}
#if	defined	_ALS_OnPlayerConnect
	#undef	OnPlayerConnect
#else
	#define	_ALS_OnPlayerConnect
#endif
#define	OnPlayerConnect	ac_weapon_OnPlayerConnect
#if	defined	ac_weapon_OnPlayerConnect
forward ac_weapon_OnPlayerConnect(playerid);
#endif
//

public ac_timer(playerid)
{
	if(GetPlayerAmmo(playerid) != ac_weapon_player[playerid][slot(GetPlayerWeapon(playerid))][1]) 
	{
		OnCheatDetected(playerid, ANTICHEAT_CODE_WEAPON);
	}
    #if defined ac_weapon_timer
        return ac_weapon_timer(playerid);
    #else
        return 1;
    #endif
}
#if defined _ALS_ac_timer
    #undef ac_timer
#else
    #define _ALS_ac_timer
#endif

#define ac_timer ac_weapon_timer
#if defined ac_weapon_timer
    forward ac_weapon_timer(playerid);
#endif


stock slot(weapon_id)
{
	switch(weapon_id)
    {
     	case 0,1: 		return 0;
        case 2..9: 		return 1;
        case 10..15: 	return 10;
        case 16..18,39: return 8;
        case 22..24: 	return 2;
        case 25..27: 	return 3;
        case 28,29,32: 	return 4;
        case 30,31: 	return 5;
        case 33,34: 	return 6;
        case 35..38: 	return 7;
        case 40: 		return 12;
        case 41..43: 	return 9;
     	case 44..46: 	return 11;
    }
    return -1;
}

stock ResetWeapons(playerid)
{
	for(new i = 0; i < 13; i++ ) ac_weapon_player[playerid][i][0] = 0, ac_weapon_player[playerid][i][0] = 0;
    ResetPlayerWeapons(playerid);
}
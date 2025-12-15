/* equip-weapon by LuminouZ */

#include <a_samp>

enum lz_playerenum
{
	pWep,
}
new
	P_Enum[MAX_PLAYERS][lz_playerenum];
	
	

public OnPlayerUpdate(playerid)
{
	new wepid = GetPlayerWeapon(playerid);
	#if defined OnPlayerEquipWeapon
	if (wepid != P_Enum[playerid][pWep])
	{
		OnPlayerWeaponChange(playerid, P_Enum[playerid][pWep], wepid);
	}
	#endif
	
	P_Enum[playerid][pWep] = wepid;
	#if defined LZ_OnPlayerUpdate
	    return LZ_OnPlayerUpdate(playerid);
	#else
		return 1;
	#endif
}

#if defined OnPlayerWeaponChange
forward OnPlayerWeaponChange(playerid, prev_weapon, cur_weapon);
#endif

#if defined _ALS_OnPlayerUpdate
	#undef OnPlayerUpdate
#else
	#define _ALS_OnPlayerUpdate
#endif

#define OnPlayerUpdate  LZ_OnPlayerUpdate

#if defined LZ_OnPlayerUpdate
	forward LZ_OnPlayerUpdate(playerid);
#endif


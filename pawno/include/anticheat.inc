/*  CROSS_Hunter's Anti Cheat Pack
 *
 *  © Copyright 2012, CROSS_HUNTER , sa-mp team and Wiki-SAMP
 *
 */

#if defined _AMH_included
    #endinput
#endif
#include <a_samp>
#define _AMH_included
#define CheckHacks 1 // checks the players hack in seconds its currently on '1'
#pragma tabsize 0

//--------------Forwards-----------
/*forward HealthHack(playerid);
forward MoneyHack(playerid);
forward ArmourHack(playerid);
forward VHH(playerid);
forward AntiCheat(playerid);
forward IlegalWeapons(playerid);
forward JetPack(playerid);*/
//---------------Anti Cheat-----------
new Float:vehhealth; //changed it to vehhealth duel to confilcts with other GMs
//---------------------------------
new vehicle;
new Reason =0; // never change this
new Action_Taken =1; //you have to change this in order for Anti Cheat to Work
// 1 = Ban
// 2 = Kick
//----------Functions---------------
/*
Usage: //Thanks to ikkentim for the Notice it had to be added to ur GM instead of repeating OnPlayerUpdate it may make a Conflict
MoneyHack(playerid);
JetPack(playerid);
IlegalWeapons(playerid);
*/
stock HealthHack(playerid)
{
	new health; 
	if(GetPlayerHealth(playerid,health) > 100)
	{
    Reason =1;
	return 1;
	}
	return 0;
}
stock ArmourHack(playerid)
{
	new armour;
	if(GetPlayerArmour(playerid, armour) > 100)
	{
	Reason =2;
	return 1;
	}
	return 0;
}
stock MoneyHack(playerid)
{
	if(GetPlayerMoney(playerid) >= 10000000) //change it as you want this is the amount that if the player exceeded he gets banned its currently on '5 million'
	{
	Reason =3;
	return 1;
	}
	return 0;
}
stock VHH(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
    vehicle = GetPlayerVehicleID(playerid);
    if(GetVehicleHealth(vehicle, vehhealth) > 1000)
    {
	Reason =4;
	return 1;
		}
	}
	return 0;
}
stock AntiCheat(playerid)
{
if(Action_Taken == 1 && Reason >= 1)
{
Ban(playerid);
return 1;
}
if(Action_Taken == 2 && Reason >= 1)
{
Kick(playerid);
return 1;
}
 return 0;
}
stock IlegalWeapons(playerid)
{

if(GetPlayerWeapon(playerid) == 16 || GetPlayerWeapon(playerid) == 17 || GetPlayerWeapon(playerid) == 35 ||
	GetPlayerWeapon(playerid) == 36 || GetPlayerWeapon(playerid) == 37 || GetPlayerWeapon(playerid) == 38 ||
	GetPlayerWeapon(playerid) == 39 || GetPlayerWeapon(playerid) == 40 || GetPlayerWeapon(playerid) == 18)
	{
	Reason =5;

	    return 1;
	}
	return 1;
	}
stock JetPack(playerid)
{
if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
{
              Reason =6;
               return 1;
}
	return 1;
}

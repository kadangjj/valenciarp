CMD:credits(playerid, params[])
{
	new credits[512];
	strcat(credits,"{00FFFF}RV:RP Server Credits\n");
	strcat(credits,"{FFFF00}> Kalcor\n");
	strcat(credits,"{FFD700}> LuminouZ\n");
	strcat(credits,"{FFFF00}> Y_Less\n");
	strcat(credits,"{FFD700}> Incognito\n");
	strcat(credits,"{FFFF00}> pBlueG\n");
	strcat(credits,"{FFD700}> Dandy Prasetyo\n");
	strcat(credits,"{FFFF00}> Southclaws\n");
	strcat(credits,"{FFD700}> SyS\n");
	strcat(credits,"{FFFF00}> Revelt\n");
	ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "{FFFFFF}Server Credits",credits,"Close","");
	return 1;
}
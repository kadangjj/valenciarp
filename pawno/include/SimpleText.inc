#if defined _LZText_included
	#endinput
#endif

#if !defined _samp_included
	#tryinclude <a_samp>
	#if !defined _samp_included
		#error could not locate a_samp.inc file, please check your server includes
	#endif
#endif

/*

/ Credits /

> LuminouZ

/ Function /

SimpleTextForPlayer(playerid, text[], time, type);

Ex: SimpleTextForPlayer(playerid, "Hello World!, 10, 1);

NOTE: Time in Second!

*/

/* Include */
#include a_samp

/* Variable */
new PlayerText:TYPE1[MAX_PLAYERS];
new PlayerText:TYPE2[MAX_PLAYERS];

stock CreatePlayerSimpleText1(playerid)
{
	TYPE1[playerid] = CreatePlayerTextDraw(playerid, 403.000000, 383.000000, "");
	PlayerTextDrawFont(playerid, TYPE1[playerid], 1);
	PlayerTextDrawLetterSize(playerid, TYPE1[playerid], 0.308333, 1.700000);
	PlayerTextDrawTextSize(playerid, TYPE1[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TYPE1[playerid], 1);
	PlayerTextDrawSetShadow(playerid, TYPE1[playerid], 0);
	PlayerTextDrawAlignment(playerid, TYPE1[playerid], 3);
	PlayerTextDrawColor(playerid, TYPE1[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, TYPE1[playerid], 255);
	PlayerTextDrawBoxColor(playerid, TYPE1[playerid], 50);
	PlayerTextDrawUseBox(playerid, TYPE1[playerid], 0);
	PlayerTextDrawSetProportional(playerid, TYPE1[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, TYPE1[playerid], 0);

	return 1;
}

stock CreatePlayerSimpleText2(playerid)
{
	TYPE2[playerid][0] = CreatePlayerTextDraw(playerid, 617.000000, 312.000000, "Teomri Osas Gemink");
	PlayerTextDrawFont(playerid, TYPE2[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, TYPE2[playerid][0], 0.333333, 1.899999);
	PlayerTextDrawTextSize(playerid, TYPE2[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, TYPE2[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, TYPE2[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TYPE2[playerid][0], 3);
	PlayerTextDrawColor(playerid, TYPE2[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TYPE2[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, TYPE2[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, TYPE2[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TYPE2[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, TYPE2[playerid][0], 0);
	return 1;
}
stock SimpleTextForPlayer(playerid, text[], time, type)
{
	new
		totaltime = time*1000;

	switch(type)
	{
		case 1:
		{
		    CreatePlayerSimpleText1(playerid);
		    PlayerTextDrawSetString(playerid, TYPE1[playerid], text);
		    PlayerTextDrawShow(playerid, TYPE1[playerid]);

			SetTimerEx("HideSimpleText", totaltime, false, "i", playerid);
		//	print("TextDraw Showed!");
		}
		case 2:
		{
		    CreatePlayerSimpleText2(playerid);
		    PlayerTextDrawSetString(playerid, TYPE2[playerid], text);
		    PlayerTextDrawShow(playerid, TYPE2[playerid]);

			SetTimerEx("HideSimpleText", totaltime, false, "i", playerid);
		//	print("TextDraw Showed!");
		}
	}
	return 1;
}

forward HideSimpleText(playerid);
public HideSimpleText(playerid)
{
	PlayerTextDrawDestroy(playerid, TYPE2[playerid]);
	PlayerTextDrawHide(playerid, TYPE2[playerid]);
	PlayerTextDrawDestroy(playerid, TYPE1[playerid]);
	PlayerTextDrawHide(playerid, TYPE1[playerid]);
//	print("TextDraw Hided!");
	return 1;
}
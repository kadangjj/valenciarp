//------------[ Textdraw ]------------


//Info textdraw
new PlayerText:InfoTD[MAX_PLAYERS];
new Text:TextTime, Text:TextDate;

//Server Name textdraw
new Text:ServerName;

//Animation
new Text:AnimationTD;

//SHOW SPEC PLAYERS
new PlayerText:SpecBG[MAX_PLAYERS];
new PlayerText:SpecName[MAX_PLAYERS];
new PlayerText:SpecCash[MAX_PLAYERS];
new PlayerText:SpecHP[MAX_PLAYERS];
new PlayerText:SpecAP[MAX_PLAYERS];
new PlayerText:SpecInt[MAX_PLAYERS];
new PlayerText:SpecWorld[MAX_PLAYERS];

//Navigator
new PlayerText:NAV[MAX_PLAYERS][7];

//Welcome Textdraws
new Text:WelcomeTD[5];
new Text:DollarCents;
new PlayerText:NameServer[MAX_PLAYERS][3];

/*new TD_Random_Messages_Intro[ ][ ] =
{
	"VALENCIA ~w~ROLEPLAY"
};*/
function TDUpdates()
{
	//TextDrawSetString(PlayerText:NameServer[3], TD_Random_Messages_Intro[random(sizeof(TD_Random_Messages_Intro))]);
}

//HBE textdraw Modern
new Text:TDEditor_TD[19];

new PlayerText:DPname[MAX_PLAYERS];
new PlayerText:DPmoney[MAX_PLAYERS];
new PlayerText:DPcoin[MAX_PLAYERS];

new PlayerText:DPvehname[MAX_PLAYERS];
new PlayerText:DPvehengine[MAX_PLAYERS];
new PlayerText:DPvehspeed[MAX_PLAYERS];
new Text:DPvehfare[MAX_PLAYERS];

//HBE textdraw Simple
new PlayerText:SPvehname[MAX_PLAYERS];
new PlayerText:SPvehengine[MAX_PLAYERS];
new PlayerText:SPvehspeed[MAX_PLAYERS];

new PlayerText:ActiveTD[MAX_PLAYERS];

//HBE textdraw Modern v2
new Text:LaparHaus[6];
new Text:AkuVeh[4];
new PlayerText:DGFood[MAX_PLAYERS];
new PlayerText:DGEnergy[MAX_PLAYERS];
new PlayerText:AkuDamage[MAX_PLAYERS];
new PlayerText:AkuFuel[MAX_PLAYERS];
new PlayerText:AkuSpeed[MAX_PLAYERS];

//Variables HBE Minimalist
new PlayerText:PlayerTD[MAX_PLAYERS][8];
new PlayerText:JGMVSPEED[MAX_PLAYERS];
new PlayerText:JGMVHP[MAX_PLAYERS];
new PlayerText:JGMVFUEL[MAX_PLAYERS];
new PlayerText:JGMHUNGER[MAX_PLAYERS];
new PlayerText:JGMTHIRST[MAX_PLAYERS];



CreatePlayerTextDraws(playerid)
{
	//Server Name Textdraw NEW
	NameServer[playerid][0] = CreatePlayerTextDraw(playerid, 294.000, 4.000, "alencia");
	PlayerTextDrawLetterSize(playerid, NameServer[playerid][0], 0.270, 1.299);
	PlayerTextDrawAlignment(playerid, NameServer[playerid][0], 1);
	PlayerTextDrawColor(playerid, NameServer[playerid][0], 0x176CECFF);
	PlayerTextDrawSetShadow(playerid, NameServer[playerid][0], 1);
	PlayerTextDrawSetOutline(playerid, NameServer[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, NameServer[playerid][0], 150);
	PlayerTextDrawFont(playerid, NameServer[playerid][0], 3);
	PlayerTextDrawSetProportional(playerid, NameServer[playerid][0], 1);

	NameServer[playerid][1] = CreatePlayerTextDraw(playerid, 294.000, 10.000, "Roleplay");
	PlayerTextDrawLetterSize(playerid, NameServer[playerid][1], 0.379, 1.299);
	PlayerTextDrawAlignment(playerid, NameServer[playerid][1], 1);
	PlayerTextDrawColor(playerid, NameServer[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, NameServer[playerid][1], 1);
	PlayerTextDrawSetOutline(playerid, NameServer[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, NameServer[playerid][1], 150);
	PlayerTextDrawFont(playerid, NameServer[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, NameServer[playerid][1], 1);

	NameServer[playerid][2] = CreatePlayerTextDraw(playerid, 286.000, 3.000, "V");
	PlayerTextDrawLetterSize(playerid, NameServer[playerid][2], 0.337, 1.899);
	PlayerTextDrawAlignment(playerid, NameServer[playerid][2], 1);
	PlayerTextDrawColor(playerid, NameServer[playerid][2], 0x176CECFF);
	PlayerTextDrawSetShadow(playerid, NameServer[playerid][2], 1);
	PlayerTextDrawSetOutline(playerid, NameServer[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, NameServer[playerid][2], 150);
	PlayerTextDrawFont(playerid, NameServer[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, NameServer[playerid][2], 1);

	//HU Minimalist
	PlayerTD[playerid][0] = CreatePlayerTextDraw(playerid, 579.000000, 352.000000, "ld_bum:blkdot");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][0], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][0], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][0], 61.000000, 50.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][0], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][0], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][0], 150);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][0], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][0], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][0], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][0], 0);

    PlayerTD[playerid][1] = CreatePlayerTextDraw(playerid, 579.000000, 287.000000, "ld_bum:blkdot");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][1], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][1], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][1], 61.000000, 63.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][1], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][1], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][1], 150);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][1], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][1], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][1], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][1], 0);

    PlayerTD[playerid][2] = CreatePlayerTextDraw(playerid, 583.000000, 355.000000, "HUD:radar_dateFood");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][2], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][2], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][2], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][2], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][2], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][2], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][2], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][2], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][2], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][2], 0);

    PlayerTD[playerid][3] = CreatePlayerTextDraw(playerid, 583.000000, 378.000000, "HUD:radar_diner");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][3], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][3], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][3], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][3], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][3], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][3], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][3], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][3], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][3], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][3], 0);

    PlayerTD[playerid][4] = CreatePlayerTextDraw(playerid, 583.000000, 286.000000, "HUD:radar_impound");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][4], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][4], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][4], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][4], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][4], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][4], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][4], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][4], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][4], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][4], 0);

    PlayerTD[playerid][5] = CreatePlayerTextDraw(playerid, 583.000000, 309.000000, "HUD:radar_modGarage");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][5], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][5], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][5], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][5], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][5], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][5], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][5], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][5], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][5], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][5], 0);

    PlayerTD[playerid][6] = CreatePlayerTextDraw(playerid, 583.000000, 330.000000, "HUD:radar_spray");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][6], 4);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][6], 0.550000, 5.250008);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][6], 17.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][6], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][6], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][6], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][6], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][6], 135);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][6], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][6], 0);

    JGMVSPEED[playerid] = CreatePlayerTextDraw(playerid, 612.000000, 291.000000, "100");
    PlayerTextDrawFont(playerid, JGMVSPEED[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVSPEED[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVSPEED[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVSPEED[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVSPEED[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVSPEED[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVSPEED[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVSPEED[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVSPEED[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVSPEED[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVSPEED[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVSPEED[playerid], 0);

    PlayerTD[playerid][7] = CreatePlayerTextDraw(playerid, 632.000000, 291.000000, "Mph");
    PlayerTextDrawFont(playerid, PlayerTD[playerid][7], 3);
    PlayerTextDrawLetterSize(playerid, PlayerTD[playerid][7], 0.245831, 1.149999);
    PlayerTextDrawTextSize(playerid, PlayerTD[playerid][7], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, PlayerTD[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, PlayerTD[playerid][7], 0);
    PlayerTextDrawAlignment(playerid, PlayerTD[playerid][7], 2);
    PlayerTextDrawColor(playerid, PlayerTD[playerid][7], -1);
    PlayerTextDrawBackgroundColor(playerid, PlayerTD[playerid][7], 255);
    PlayerTextDrawBoxColor(playerid, PlayerTD[playerid][7], 50);
    PlayerTextDrawUseBox(playerid, PlayerTD[playerid][7], 0);
    PlayerTextDrawSetProportional(playerid, PlayerTD[playerid][7], 1);
    PlayerTextDrawSetSelectable(playerid, PlayerTD[playerid][7], 0);

    JGMVHP[playerid] = CreatePlayerTextDraw(playerid, 621.000000, 310.000000, "100%");
    PlayerTextDrawFont(playerid, JGMVHP[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVHP[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVHP[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVHP[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVHP[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVHP[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVHP[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVHP[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVHP[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVHP[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVHP[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVHP[playerid], 0);

    JGMVFUEL[playerid] = CreatePlayerTextDraw(playerid, 621.000000, 333.000000, "100%");
    PlayerTextDrawFont(playerid, JGMVFUEL[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMVFUEL[playerid], 0.304165, 1.149999);
    PlayerTextDrawTextSize(playerid, JGMVFUEL[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMVFUEL[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMVFUEL[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMVFUEL[playerid], 2);
    PlayerTextDrawColor(playerid, JGMVFUEL[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMVFUEL[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMVFUEL[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMVFUEL[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMVFUEL[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMVFUEL[playerid], 0);

    JGMHUNGER[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 357.000000, "100%");
    PlayerTextDrawFont(playerid, JGMHUNGER[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMHUNGER[playerid], 0.299997, 1.399999);
    PlayerTextDrawTextSize(playerid, JGMHUNGER[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMHUNGER[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawColor(playerid, JGMHUNGER[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMHUNGER[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMHUNGER[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMHUNGER[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMHUNGER[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMHUNGER[playerid], 0);

    JGMTHIRST[playerid] = CreatePlayerTextDraw(playerid, 606.000000, 381.000000, "100%");
    PlayerTextDrawFont(playerid, JGMTHIRST[playerid], 3);
    PlayerTextDrawLetterSize(playerid, JGMTHIRST[playerid], 0.299997, 1.399999);
    PlayerTextDrawTextSize(playerid, JGMTHIRST[playerid], 400.000000, 17.000000);
    PlayerTextDrawSetOutline(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawSetShadow(playerid, JGMTHIRST[playerid], 0);
    PlayerTextDrawAlignment(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawColor(playerid, JGMTHIRST[playerid], 9109759);
    PlayerTextDrawBackgroundColor(playerid, JGMTHIRST[playerid], 255);
    PlayerTextDrawBoxColor(playerid, JGMTHIRST[playerid], 50);
    PlayerTextDrawUseBox(playerid, JGMTHIRST[playerid], 0);
    PlayerTextDrawSetProportional(playerid, JGMTHIRST[playerid], 1);
    PlayerTextDrawSetSelectable(playerid, JGMTHIRST[playerid], 0);

	//Info textdraw - POSISI LEBIH ATAS SEDIKIT
	InfoTD[playerid] = CreatePlayerTextDraw(playerid, 148.888, 330.000, "Selamat Datang!"); // ← Y diubah dari 361.385 menjadi 330.000
	PlayerTextDrawLetterSize(playerid, InfoTD[playerid], 0.326, 1.654);
	PlayerTextDrawAlignment(playerid, InfoTD[playerid], 1);
	PlayerTextDrawColor(playerid, InfoTD[playerid], -1);
	PlayerTextDrawSetOutline(playerid, InfoTD[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, InfoTD[playerid], 0x000000FF);
	PlayerTextDrawFont(playerid, InfoTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, InfoTD[playerid], 1);
	
	ActiveTD[playerid] = CreatePlayerTextDraw(playerid, 274.000000, 176.583435, "Mengisi Ulang...");
	PlayerTextDrawLetterSize(playerid, ActiveTD[playerid], 0.374000, 1.349166);
	PlayerTextDrawAlignment(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawColor(playerid, ActiveTD[playerid], -1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	PlayerTextDrawSetOutline(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, ActiveTD[playerid], 255);
	PlayerTextDrawFont(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetProportional(playerid, ActiveTD[playerid], 1);
	PlayerTextDrawSetShadow(playerid, ActiveTD[playerid], 0);
	
	//HBE Textdraw Modern
	DPname[playerid] = CreatePlayerTextDraw(playerid, 537.000000, 367.333251, "Pateeer");
	PlayerTextDrawLetterSize(playerid, DPname[playerid], 0.328999, 1.179998);
	PlayerTextDrawAlignment(playerid, DPname[playerid], 1);
	PlayerTextDrawColor(playerid, DPname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPname[playerid], 255);
	PlayerTextDrawFont(playerid, DPname[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DPname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPname[playerid], 0);

	DPmoney[playerid] = CreatePlayerTextDraw(playerid, 535.000000, 381.916473, "$50.000");
	PlayerTextDrawLetterSize(playerid, DPmoney[playerid], 0.231499, 1.034165);
	PlayerTextDrawAlignment(playerid, DPmoney[playerid], 1);
	PlayerTextDrawColor(playerid, DPmoney[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, DPmoney[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPmoney[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPmoney[playerid], 255);
	PlayerTextDrawFont(playerid, DPmoney[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPmoney[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPmoney[playerid], 0);

	DPcoin[playerid] = CreatePlayerTextDraw(playerid, 535.500000, 392.999877, "5000_Coin");
	PlayerTextDrawLetterSize(playerid, DPcoin[playerid], 0.246000, 0.952498);
	PlayerTextDrawAlignment(playerid, DPcoin[playerid], 1);
	PlayerTextDrawColor(playerid, DPcoin[playerid], -65281);
	PlayerTextDrawSetShadow(playerid, DPcoin[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPcoin[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPcoin[playerid], 255);
	PlayerTextDrawFont(playerid, DPcoin[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPcoin[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPcoin[playerid], 0);

	DPvehname[playerid] = CreatePlayerTextDraw(playerid, 431.000000, 367.333312, "Turismo");
	PlayerTextDrawLetterSize(playerid, DPvehname[playerid], 0.299499, 1.121665);
	PlayerTextDrawAlignment(playerid, DPvehname[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPvehname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehname[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehname[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehname[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehname[playerid], 0);

	DPvehengine[playerid] = CreatePlayerTextDraw(playerid, 462.000000, 381.916778, "ON");
	PlayerTextDrawLetterSize(playerid, DPvehengine[playerid], 0.229000, 0.940832);
	PlayerTextDrawAlignment(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehengine[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, DPvehengine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehengine[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehengine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehengine[playerid], 0);

	DPvehspeed[playerid] = CreatePlayerTextDraw(playerid, 460.000000, 391.833312, "120_Mph");
	PlayerTextDrawLetterSize(playerid, DPvehspeed[playerid], 0.266999, 0.946666);
	PlayerTextDrawAlignment(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawColor(playerid, DPvehspeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, DPvehspeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, DPvehspeed[playerid], 255);
	PlayerTextDrawFont(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawSetProportional(playerid, DPvehspeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DPvehspeed[playerid], 0);

	DPvehfare[playerid] = TextDrawCreate(462.000000, 401.166687, "$500.000");
	TextDrawLetterSize(DPvehfare[playerid], 0.216000, 0.952498);
	TextDrawAlignment(DPvehfare[playerid], 1);
	TextDrawColor(DPvehfare[playerid], 16711935);
	TextDrawSetShadow(DPvehfare[playerid], 0);
	TextDrawSetOutline(DPvehfare[playerid], 1);
	TextDrawBackgroundColor(DPvehfare[playerid], 255);
	TextDrawFont(DPvehfare[playerid], 1);
	TextDrawSetProportional(DPvehfare[playerid], 1);
	TextDrawSetShadow(DPvehfare[playerid], 0);
	
	//HBE textdraw Simple
	SPvehname[playerid] = CreatePlayerTextDraw(playerid, 540.000000, 366.749908, "Turismo");
	PlayerTextDrawLetterSize(playerid, SPvehname[playerid], 0.319000, 1.022498);
	PlayerTextDrawAlignment(playerid, SPvehname[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehname[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SPvehname[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehname[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehname[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehname[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehname[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehname[playerid], 0);

	SPvehspeed[playerid] = CreatePlayerTextDraw(playerid, 538.000000, 412.833160, "250_Mph");
	PlayerTextDrawLetterSize(playerid, SPvehspeed[playerid], 0.275498, 1.244166);
	PlayerTextDrawAlignment(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehspeed[playerid], -1);
	PlayerTextDrawSetShadow(playerid, SPvehspeed[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehspeed[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehspeed[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehspeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehspeed[playerid], 0);

	SPvehengine[playerid] = CreatePlayerTextDraw(playerid, 611.500000, 414.000152, "ON");
	PlayerTextDrawLetterSize(playerid, SPvehengine[playerid], 0.280999, 1.104166);
	PlayerTextDrawAlignment(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawColor(playerid, SPvehengine[playerid], 16711935);
	PlayerTextDrawSetShadow(playerid, SPvehengine[playerid], 0);
	PlayerTextDrawSetOutline(playerid, SPvehengine[playerid], 2);
	PlayerTextDrawBackgroundColor(playerid, SPvehengine[playerid], 255);
	PlayerTextDrawFont(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawSetProportional(playerid, SPvehengine[playerid], 1);
	PlayerTextDrawSetShadow(playerid, SPvehengine[playerid], 0);

	//HBE Modern v2
	//ALPRASH MODERN DAMAGE, FUEL, SPEED
	AkuDamage[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 370.000000, "100");
	PlayerTextDrawFont(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuDamage[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuDamage[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuDamage[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuDamage[playerid], 2);
	PlayerTextDrawColor(playerid, AkuDamage[playerid], -16776961);
	PlayerTextDrawBackgroundColor(playerid, AkuDamage[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuDamage[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuDamage[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuDamage[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuDamage[playerid], 0);

	AkuFuel[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 340.000000, "100");
	PlayerTextDrawFont(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuFuel[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuFuel[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuFuel[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuFuel[playerid], 2);
	PlayerTextDrawColor(playerid, AkuFuel[playerid], -16776961);
	PlayerTextDrawBackgroundColor(playerid, AkuFuel[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuFuel[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuFuel[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuFuel[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuFuel[playerid], 0);

	AkuSpeed[playerid] = CreatePlayerTextDraw(playerid, 600.000000, 310.000000, "100");
	PlayerTextDrawFont(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawLetterSize(playerid, AkuSpeed[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, AkuSpeed[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawSetShadow(playerid, AkuSpeed[playerid], 0);
	PlayerTextDrawAlignment(playerid, AkuSpeed[playerid], 2);
	PlayerTextDrawColor(playerid, AkuSpeed[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, AkuSpeed[playerid], 255);
	PlayerTextDrawBoxColor(playerid, AkuSpeed[playerid], 50);
	PlayerTextDrawUseBox(playerid, AkuSpeed[playerid], 0);
	PlayerTextDrawSetProportional(playerid, AkuSpeed[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, AkuSpeed[playerid], 0);

	//ALPRASH MODERN LAPAR HAUS
	DGFood[playerid] = CreatePlayerTextDraw(playerid, 595.000000, 417.000000, "100%");
	PlayerTextDrawFont(playerid, DGFood[playerid], 1);
	PlayerTextDrawLetterSize(playerid, DGFood[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, DGFood[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DGFood[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DGFood[playerid], 0);
	PlayerTextDrawAlignment(playerid, DGFood[playerid], 2);
	PlayerTextDrawColor(playerid, DGFood[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DGFood[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DGFood[playerid], 50);
	PlayerTextDrawUseBox(playerid, DGFood[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DGFood[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DGFood[playerid], 0);

	DGEnergy[playerid] = CreatePlayerTextDraw(playerid, 520.000000, 417.000000, "100%");
	PlayerTextDrawFont(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawLetterSize(playerid, DGEnergy[playerid], 0.300000, 1.799998);
	PlayerTextDrawTextSize(playerid, DGEnergy[playerid], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawSetShadow(playerid, DGEnergy[playerid], 0);
	PlayerTextDrawAlignment(playerid, DGEnergy[playerid], 2);
	PlayerTextDrawColor(playerid, DGEnergy[playerid], -1);
	PlayerTextDrawBackgroundColor(playerid, DGEnergy[playerid], 255);
	PlayerTextDrawBoxColor(playerid, DGEnergy[playerid], 50);
	PlayerTextDrawUseBox(playerid, DGEnergy[playerid], 0);
	PlayerTextDrawSetProportional(playerid, DGEnergy[playerid], 1);
	PlayerTextDrawSetSelectable(playerid, DGEnergy[playerid], 0);

	// NAVIGATION TEXTDRAW (SCALED UP ONLY)

	NAV[playerid][0] = CreatePlayerTextDraw(playerid, 118.000, 414.000, "South West");
	PlayerTextDrawLetterSize(playerid, NAV[playerid][0], 0.180, 1.050);
	PlayerTextDrawAlignment(playerid, NAV[playerid][0], 2);
	PlayerTextDrawColor(playerid, NAV[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][0], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][0], 150);
	PlayerTextDrawFont(playerid, NAV[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][0], 1);

	NAV[playerid][1] = CreatePlayerTextDraw(playerid, 118.000, 404.000, "SE");
	PlayerTextDrawLetterSize(playerid, NAV[playerid][1], 0.260, 1.450);
	PlayerTextDrawAlignment(playerid, NAV[playerid][1], 2);
	PlayerTextDrawColor(playerid, NAV[playerid][1], -7601921);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][1], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][1], 150);
	PlayerTextDrawFont(playerid, NAV[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][1], 1);

	NAV[playerid][2] = CreatePlayerTextDraw(playerid, 136.000, 398.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, NAV[playerid][2], -1.000, 36.000);
	PlayerTextDrawAlignment(playerid, NAV[playerid][2], 1);
	PlayerTextDrawColor(playerid, NAV[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][2], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][2], 255);
	PlayerTextDrawFont(playerid, NAV[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][2], 1);

	NAV[playerid][3] = CreatePlayerTextDraw(playerid, 138.000, 392.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, NAV[playerid][3], -1.000, 36.000);
	PlayerTextDrawAlignment(playerid, NAV[playerid][3], 1);
	PlayerTextDrawColor(playerid, NAV[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][3], 255);
	PlayerTextDrawFont(playerid, NAV[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][3], 1);

	NAV[playerid][4] = CreatePlayerTextDraw(playerid, 141.000, 406.000, "00:00:00");
	PlayerTextDrawLetterSize(playerid, NAV[playerid][4], 0.145, 0.850);
	PlayerTextDrawAlignment(playerid, NAV[playerid][4], 1);
	PlayerTextDrawColor(playerid, NAV[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][4], 150);
	PlayerTextDrawFont(playerid, NAV[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][4], 1);

	NAV[playerid][5] = CreatePlayerTextDraw(playerid, 141.000, 412.000, "Monday, 20 Aug 2024");
	PlayerTextDrawLetterSize(playerid, NAV[playerid][5], 0.145, 0.850);
	PlayerTextDrawAlignment(playerid, NAV[playerid][5], 1);
	PlayerTextDrawColor(playerid, NAV[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][5], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][5], 150);
	PlayerTextDrawFont(playerid, NAV[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][5], 1);

	NAV[playerid][6] = CreatePlayerTextDraw(playerid, 141.000, 418.000, "Los Santos");
	PlayerTextDrawLetterSize(playerid, NAV[playerid][6], 0.145, 0.850);
	PlayerTextDrawAlignment(playerid, NAV[playerid][6], 1);
	PlayerTextDrawColor(playerid, NAV[playerid][6], -7601921);
	PlayerTextDrawSetShadow(playerid, NAV[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, NAV[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, NAV[playerid][6], 150);
	PlayerTextDrawFont(playerid, NAV[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, NAV[playerid][6], 1);

	// ===== SPECTATE TEXTDRAWS (RATA KIRI + BOX) =====
	// BACKGROUND BOX
	SpecBG[playerid] = CreatePlayerTextDraw(playerid, 235.0, 346.0, "_");
	PlayerTextDrawFont(playerid, SpecBG[playerid], 1);
	PlayerTextDrawLetterSize(playerid, SpecBG[playerid], 0.0, 9.5);
	PlayerTextDrawUseBox(playerid, SpecBG[playerid], 1);
	PlayerTextDrawBoxColor(playerid, SpecBG[playerid], 0x00000088);
	PlayerTextDrawTextSize(playerid, SpecBG[playerid], 510.0, 0.0);
	PlayerTextDrawSetOutline(playerid, SpecBG[playerid], 0);

	// NAME
	SpecName[playerid] = CreatePlayerTextDraw(playerid, 245.0, 350.0, "~g~Juan_Coki (12)");
	PlayerTextDrawFont(playerid, SpecName[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecName[playerid], 0.28, 1.2);
	PlayerTextDrawAlignment(playerid, SpecName[playerid], 1);
	PlayerTextDrawColor(playerid, SpecName[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecName[playerid], 1);

	// CASH
	SpecCash[playerid] = CreatePlayerTextDraw(playerid, 245.0, 364.0, "~w~Cash: ~y~$9,100");
	PlayerTextDrawFont(playerid, SpecCash[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecCash[playerid], 0.26, 1.1);
	PlayerTextDrawAlignment(playerid, SpecCash[playerid], 1);
	PlayerTextDrawColor(playerid, SpecCash[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecCash[playerid], 1);

	// HP
	SpecHP[playerid] = CreatePlayerTextDraw(playerid, 245.0, 378.0, "~w~HP: ~y~100.0");
	PlayerTextDrawFont(playerid, SpecHP[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecHP[playerid], 0.26, 1.1);
	PlayerTextDrawAlignment(playerid, SpecHP[playerid], 1);
	PlayerTextDrawColor(playerid, SpecHP[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecHP[playerid], 1);

	// AP
	SpecAP[playerid] = CreatePlayerTextDraw(playerid, 245.0, 392.0, "~w~AP: ~y~100.0");
	PlayerTextDrawFont(playerid, SpecAP[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecAP[playerid], 0.26, 1.1);
	PlayerTextDrawAlignment(playerid, SpecAP[playerid], 1);
	PlayerTextDrawColor(playerid, SpecAP[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecAP[playerid], 1);

	// INTERIOR
	SpecInt[playerid] = CreatePlayerTextDraw(playerid, 245.0, 406.0, "~w~Int: ~y~1");
	PlayerTextDrawFont(playerid, SpecInt[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecInt[playerid], 0.26, 1.1);
	PlayerTextDrawAlignment(playerid, SpecInt[playerid], 1);
	PlayerTextDrawColor(playerid, SpecInt[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecInt[playerid], 1);

	// WORLD
	SpecWorld[playerid] = CreatePlayerTextDraw(playerid, 245.0, 420.0, "~w~World: ~y~1");
	PlayerTextDrawFont(playerid, SpecWorld[playerid], 2);
	PlayerTextDrawLetterSize(playerid, SpecWorld[playerid], 0.26, 1.1);
	PlayerTextDrawAlignment(playerid, SpecWorld[playerid], 1);
	PlayerTextDrawColor(playerid, SpecWorld[playerid], -1);
	PlayerTextDrawSetOutline(playerid, SpecWorld[playerid], 1);
}

CreateTextDraw()
{
	//dollar cent
	DollarCents = TextDrawCreate(544.000000, 82.000000, ",   .");
    TextDrawFont(DollarCents, 3);
    TextDrawLetterSize(DollarCents, 0.600000, 2.000000);
    TextDrawTextSize(DollarCents, 745.000000, 17.000000);
    TextDrawSetOutline(DollarCents, 1);
    TextDrawSetShadow(DollarCents, 0);
    TextDrawAlignment(DollarCents, 1);
    TextDrawColor(DollarCents, 0x3BBD44FF);
    TextDrawBackgroundColor(DollarCents, 255);
    TextDrawBoxColor(DollarCents, 50);
    TextDrawUseBox(DollarCents, 0);
    TextDrawSetProportional(DollarCents, 1);
    TextDrawSetSelectable(DollarCents, 0);

	//server name
	ServerName = TextDrawCreate(628.400024, 6.455494, "Valencia Roleplay");
	TextDrawLetterSize(ServerName, 0.303999, 1.204666);
	TextDrawAlignment(ServerName, 3);
	TextDrawColor(ServerName, 0x176CECFF);
	TextDrawSetShadow(ServerName, 0);
	TextDrawSetOutline(ServerName, -1);
	TextDrawBackgroundColor(ServerName, 255);
	TextDrawFont(ServerName, 1);
	TextDrawSetProportional(ServerName, 1);
	TextDrawSetShadow(ServerName, 0);

	//Date and Time
	TextDate = TextDrawCreate(71.000000, 430.000000, "24 - March - 2021");
	TextDrawFont(TextDate, 1);
	TextDrawLetterSize(TextDate, 0.308332, 1.349998);
	TextDrawTextSize(TextDate, 404.500000, 114.500000);
	TextDrawSetOutline(TextDate, 1);
	TextDrawSetShadow(TextDate, 0);
	TextDrawAlignment(TextDate, 2);
	TextDrawColor(TextDate, -1);
	TextDrawBackgroundColor(TextDate, 255);
	TextDrawBoxColor(TextDate, 50);
	TextDrawSetProportional(TextDate, 1);
	TextDrawSetSelectable(TextDate, 0);

	TextTime = TextDrawCreate(547.000000, 28.000000, "-:-:-");
    TextDrawFont(TextTime, 1);
    TextDrawLetterSize(TextTime, 0.400000, 2.000000);
    TextDrawTextSize(TextTime, 400.000000, 1.399999);
    TextDrawSetOutline(TextTime, 1);
    TextDrawSetShadow(TextTime, 0);
    TextDrawAlignment(TextTime, 1);
    TextDrawColor(TextTime, -1);
    TextDrawBackgroundColor(TextTime, 255);
    TextDrawBoxColor(TextTime, 50);
    TextDrawUseBox(TextTime, 0);
    TextDrawSetProportional(TextTime, 1);
    TextDrawSetSelectable(TextTime, 0);
	

	// Animation textdraw
	AnimationTD = TextDrawCreate(261.000000, 395.000000, "Gunakan ~b~H~w~ untuk stop anim");
	TextDrawFont(AnimationTD, 2);
	TextDrawLetterSize(AnimationTD, 0.199996, 1.649996);
	TextDrawTextSize(AnimationTD, 636.500000, -174.500000);
	TextDrawSetOutline(AnimationTD, 1);
	TextDrawSetShadow(AnimationTD, 0);
	TextDrawAlignment(AnimationTD, 1);
	TextDrawColor(AnimationTD, -1);
	TextDrawBackgroundColor(AnimationTD, 255);
	TextDrawBoxColor(AnimationTD, 50);
	TextDrawUseBox(AnimationTD, 0);
	TextDrawSetProportional(AnimationTD, 1);
	TextDrawSetSelectable(AnimationTD, 0);
	
	//HBE textdraw Modern
	TDEditor_TD[0] = TextDrawCreate(531.000000, 365.583435, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[0], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[0], 164.000000, 109.000000);
	TextDrawAlignment(TDEditor_TD[0], 1);
	TextDrawColor(TDEditor_TD[0], 120);
	TextDrawSetShadow(TDEditor_TD[0], 0);
	TextDrawSetOutline(TDEditor_TD[0], 0);
	TextDrawBackgroundColor(TDEditor_TD[0], 255);
	TextDrawFont(TDEditor_TD[0], 4);
	TextDrawSetProportional(TDEditor_TD[0], 0);
	TextDrawSetShadow(TDEditor_TD[0], 0);

	TDEditor_TD[1] = TextDrawCreate(533.000000, 367.916778, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[1], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[1], 105.000000, 13.000000);
	TextDrawAlignment(TDEditor_TD[1], 1);
	TextDrawColor(TDEditor_TD[1], 16777215);
	TextDrawSetShadow(TDEditor_TD[1], 0);
	TextDrawSetOutline(TDEditor_TD[1], 0);
	TextDrawBackgroundColor(TDEditor_TD[1], 255);
	TextDrawFont(TDEditor_TD[1], 4);
	TextDrawSetProportional(TDEditor_TD[1], 0);
	TextDrawSetShadow(TDEditor_TD[1], 0);

	TDEditor_TD[2] = TextDrawCreate(543.500000, 399.416625, "");
	TextDrawLetterSize(TDEditor_TD[2], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[2], 15.000000, 20.000000);
	TextDrawAlignment(TDEditor_TD[2], 1);
	TextDrawColor(TDEditor_TD[2], -1);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetOutline(TDEditor_TD[2], 0);
	TextDrawBackgroundColor(TDEditor_TD[2], 0);
	TextDrawFont(TDEditor_TD[2], 5);
	TextDrawSetProportional(TDEditor_TD[2], 0);
	TextDrawSetShadow(TDEditor_TD[2], 0);
	TextDrawSetPreviewModel(TDEditor_TD[2], 2703);
	TextDrawSetPreviewRot(TDEditor_TD[2], 0.000000, 90.000000, 80.000000, 1.000000);

	TDEditor_TD[3] = TextDrawCreate(536.500000, 414.000030, "");
	TextDrawLetterSize(TDEditor_TD[3], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[3], 26.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[3], 1);
	TextDrawColor(TDEditor_TD[3], -1);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetOutline(TDEditor_TD[3], 0);
	TextDrawBackgroundColor(TDEditor_TD[3], 0);
	TextDrawFont(TDEditor_TD[3], 5);
	TextDrawSetProportional(TDEditor_TD[3], 0);
	TextDrawSetShadow(TDEditor_TD[3], 0);
	TextDrawSetPreviewModel(TDEditor_TD[3], 1546);
	TextDrawSetPreviewRot(TDEditor_TD[3], 0.000000, 0.000000, 200.000000, 1.000000);

	TDEditor_TD[4] = TextDrawCreate(543.000000, 428.000030, "");
	TextDrawLetterSize(TDEditor_TD[4], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[4], 17.000000, 17.000000);
	TextDrawAlignment(TDEditor_TD[4], 1);
	TextDrawColor(TDEditor_TD[4], -1);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetOutline(TDEditor_TD[4], 0);
	TextDrawBackgroundColor(TDEditor_TD[4], 0);
	TextDrawFont(TDEditor_TD[4], 5);
	TextDrawSetProportional(TDEditor_TD[4], 0);
	TextDrawSetShadow(TDEditor_TD[4], 0);
	TextDrawSetPreviewModel(TDEditor_TD[4], 2738);
	TextDrawSetPreviewRot(TDEditor_TD[4], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[5] = TextDrawCreate(425.000000, 365.583557, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[5], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[5], 102.000000, 92.000000);
	TextDrawAlignment(TDEditor_TD[5], 1);
	TextDrawColor(TDEditor_TD[5], 120);
	TextDrawSetShadow(TDEditor_TD[5], 0);
	TextDrawSetOutline(TDEditor_TD[5], 0);
	TextDrawBackgroundColor(TDEditor_TD[5], 255);
	TextDrawFont(TDEditor_TD[5], 4);
	TextDrawSetProportional(TDEditor_TD[5], 0);
	TextDrawSetShadow(TDEditor_TD[5], 0);

	TDEditor_TD[6] = TextDrawCreate(428.000000, 367.916717, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[6], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[6], 97.000000, 11.000000);
	TextDrawAlignment(TDEditor_TD[6], 1);
	TextDrawColor(TDEditor_TD[6], 16777215);
	TextDrawSetShadow(TDEditor_TD[6], 0);
	TextDrawSetOutline(TDEditor_TD[6], 0);
	TextDrawBackgroundColor(TDEditor_TD[6], 255);
	TextDrawFont(TDEditor_TD[6], 4);
	TextDrawSetProportional(TDEditor_TD[6], 0);
	TextDrawSetShadow(TDEditor_TD[6], 0);

	TDEditor_TD[7] = TextDrawCreate(428.000000, 380.750030, "Engine:");
	TextDrawLetterSize(TDEditor_TD[7], 0.248998, 1.063333);
	TextDrawAlignment(TDEditor_TD[7], 1);
	TextDrawColor(TDEditor_TD[7], -1);
	TextDrawSetShadow(TDEditor_TD[7], 0);
	TextDrawSetOutline(TDEditor_TD[7], 1);
	TextDrawBackgroundColor(TDEditor_TD[7], 255);
	TextDrawFont(TDEditor_TD[7], 1);
	TextDrawSetProportional(TDEditor_TD[7], 1);
	TextDrawSetShadow(TDEditor_TD[7], 0);

	TDEditor_TD[8] = TextDrawCreate(428.000000, 389.499969, "Speed:");
	TextDrawLetterSize(TDEditor_TD[8], 0.266499, 1.191666);
	TextDrawAlignment(TDEditor_TD[8], 1);
	TextDrawColor(TDEditor_TD[8], -1);
	TextDrawSetShadow(TDEditor_TD[8], 0);
	TextDrawSetOutline(TDEditor_TD[8], 1);
	TextDrawBackgroundColor(TDEditor_TD[8], 255);
	TextDrawFont(TDEditor_TD[8], 1);
	TextDrawSetProportional(TDEditor_TD[8], 1);
	TextDrawSetShadow(TDEditor_TD[8], 0);

	TDEditor_TD[9] = TextDrawCreate(437.000000, 411.083343, "");
	TextDrawLetterSize(TDEditor_TD[9], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[9], 13.000000, 18.000000);
	TextDrawAlignment(TDEditor_TD[9], 1);
	TextDrawColor(TDEditor_TD[9], -1);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetOutline(TDEditor_TD[9], 0);
	TextDrawBackgroundColor(TDEditor_TD[9], 0);
	TextDrawFont(TDEditor_TD[9], 5);
	TextDrawSetProportional(TDEditor_TD[9], 0);
	TextDrawSetShadow(TDEditor_TD[9], 0);
	TextDrawSetPreviewModel(TDEditor_TD[9], 1240);
	TextDrawSetPreviewRot(TDEditor_TD[9], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[10] = TextDrawCreate(434.500000, 425.666595, "");
	TextDrawLetterSize(TDEditor_TD[10], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[10], 20.000000, 21.000000);
	TextDrawAlignment(TDEditor_TD[10], 1);
	TextDrawColor(TDEditor_TD[10], -1);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetOutline(TDEditor_TD[10], 0);
	TextDrawBackgroundColor(TDEditor_TD[10], 0);
	TextDrawFont(TDEditor_TD[10], 5);
	TextDrawSetProportional(TDEditor_TD[10], 0);
	TextDrawSetShadow(TDEditor_TD[10], 0);
	TextDrawSetPreviewModel(TDEditor_TD[10], 1650);
	TextDrawSetPreviewRot(TDEditor_TD[10], 0.000000, 0.000000, 0.000000, 1.000000);
	
	TDEditor_TD[11] = TextDrawCreate(427.000000, 400.583374, "Fare:");
	TextDrawLetterSize(TDEditor_TD[11], 0.360498, 1.022500);
	TextDrawAlignment(TDEditor_TD[11], 1);
	TextDrawColor(TDEditor_TD[11], -1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	TextDrawSetOutline(TDEditor_TD[11], 1);
	TextDrawBackgroundColor(TDEditor_TD[11], 255);
	TextDrawFont(TDEditor_TD[11], 1);
	TextDrawSetProportional(TDEditor_TD[11], 1);
	TextDrawSetShadow(TDEditor_TD[11], 0);
	
	//HBE textdraw Simple
	TDEditor_TD[12] = TextDrawCreate(450.500000, 428.000091, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[12], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[12], 191.000000, 27.000000);
	TextDrawAlignment(TDEditor_TD[12], 1);
	TextDrawColor(TDEditor_TD[12], 175);
	TextDrawSetShadow(TDEditor_TD[12], 0);
	TextDrawSetOutline(TDEditor_TD[12], 0);
	TextDrawBackgroundColor(TDEditor_TD[12], 255);
	TextDrawFont(TDEditor_TD[12], 4);
	TextDrawSetProportional(TDEditor_TD[12], 0);
	TextDrawSetShadow(TDEditor_TD[12], 0);

	TDEditor_TD[13] = TextDrawCreate(450.000000, 422.166778, "");
	TextDrawLetterSize(TDEditor_TD[13], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[13], 17.000000, 34.000000);
	TextDrawAlignment(TDEditor_TD[13], 1);
	TextDrawColor(TDEditor_TD[13], -1);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetOutline(TDEditor_TD[13], 0);
	TextDrawBackgroundColor(TDEditor_TD[13], 0);
	TextDrawFont(TDEditor_TD[13], 5);
	TextDrawSetProportional(TDEditor_TD[13], 0);
	TextDrawSetShadow(TDEditor_TD[13], 0);
	TextDrawSetPreviewModel(TDEditor_TD[13], 2703);
	TextDrawSetPreviewRot(TDEditor_TD[13], 100.000000, 0.000000, -10.000000, 1.000000);

	TDEditor_TD[14] = TextDrawCreate(507.500000, 429.166748, "");
	TextDrawLetterSize(TDEditor_TD[14], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[14], 25.000000, 20.000000);
	TextDrawAlignment(TDEditor_TD[14], 1);
	TextDrawColor(TDEditor_TD[14], -1);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetOutline(TDEditor_TD[14], 0);
	TextDrawBackgroundColor(TDEditor_TD[14], 0);
	TextDrawFont(TDEditor_TD[14], 5);
	TextDrawSetProportional(TDEditor_TD[14], 0);
	TextDrawSetShadow(TDEditor_TD[14], 0);
	TextDrawSetPreviewModel(TDEditor_TD[14], 1546);
	TextDrawSetPreviewRot(TDEditor_TD[14], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[15] = TextDrawCreate(574.500000, 427.999969, "");
	TextDrawLetterSize(TDEditor_TD[15], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[15], 20.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[15], 1);
	TextDrawColor(TDEditor_TD[15], -1);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetOutline(TDEditor_TD[15], 0);
	TextDrawBackgroundColor(TDEditor_TD[15], 0);
	TextDrawFont(TDEditor_TD[15], 5);
	TextDrawSetProportional(TDEditor_TD[15], 0);
	TextDrawSetShadow(TDEditor_TD[15], 0);
	TextDrawSetPreviewModel(TDEditor_TD[15], 2738);
	TextDrawSetPreviewRot(TDEditor_TD[15], 0.000000, 0.000000, 100.000000, 1.000000);

	TDEditor_TD[16] = TextDrawCreate(533.000000, 365.000061, "LD_SPAC:white");
	TextDrawLetterSize(TDEditor_TD[16], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[16], 105.000000, 62.000000);
	TextDrawAlignment(TDEditor_TD[16], 1);
	TextDrawColor(TDEditor_TD[16], 175);
	TextDrawSetShadow(TDEditor_TD[16], 0);
	TextDrawSetOutline(TDEditor_TD[16], 0);
	TextDrawBackgroundColor(TDEditor_TD[16], 255);
	TextDrawFont(TDEditor_TD[16], 4);
	TextDrawSetProportional(TDEditor_TD[16], 0);
	TextDrawSetShadow(TDEditor_TD[16], 0);

	TDEditor_TD[17] = TextDrawCreate(550.000000, 378.999938, "");
	TextDrawLetterSize(TDEditor_TD[17], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[17], 11.000000, 14.000000);
	TextDrawAlignment(TDEditor_TD[17], 1);
	TextDrawColor(TDEditor_TD[17], -1);
	TextDrawSetShadow(TDEditor_TD[17], 0);
	TextDrawSetOutline(TDEditor_TD[17], 0);
	TextDrawBackgroundColor(TDEditor_TD[17], 0);
	TextDrawFont(TDEditor_TD[17], 5);
	TextDrawSetProportional(TDEditor_TD[17], 0);
	TextDrawSetShadow(TDEditor_TD[17], 0);
	TextDrawSetPreviewModel(TDEditor_TD[17], 1240);
	TextDrawSetPreviewRot(TDEditor_TD[17], 0.000000, 0.000000, 0.000000, 1.000000);

	TDEditor_TD[18] = TextDrawCreate(546.500000, 391.249938, "");
	TextDrawLetterSize(TDEditor_TD[18], 0.000000, 0.000000);
	TextDrawTextSize(TDEditor_TD[18], 18.000000, 19.000000);
	TextDrawAlignment(TDEditor_TD[18], 1);
	TextDrawColor(TDEditor_TD[18], -1);
	TextDrawSetShadow(TDEditor_TD[18], 0);
	TextDrawSetOutline(TDEditor_TD[18], 0);
	TextDrawBackgroundColor(TDEditor_TD[18], 0);
	TextDrawFont(TDEditor_TD[18], 5);
	TextDrawSetProportional(TDEditor_TD[18], 0);
	TextDrawSetShadow(TDEditor_TD[18], 0);
	TextDrawSetPreviewModel(TDEditor_TD[18], 1650);
	TextDrawSetPreviewRot(TDEditor_TD[18], 0.000000, 0.000000, 0.000000, 1.000000);

//hbe modern v2
//ALPRASH VEH PACK
	AkuVeh[0] = TextDrawCreate(565.000000, 370.000000, "hud:radar_spray");
	TextDrawFont(AkuVeh[0], 4);
	TextDrawLetterSize(AkuVeh[0], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[0], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[0], 1);
	TextDrawSetShadow(AkuVeh[0], 0);
	TextDrawAlignment(AkuVeh[0], 1);
	TextDrawColor(AkuVeh[0], -1);
	TextDrawBackgroundColor(AkuVeh[0], 255);
	TextDrawBoxColor(AkuVeh[0], 50);
	TextDrawUseBox(AkuVeh[0], 1);
	TextDrawSetProportional(AkuVeh[0], 1);
	TextDrawSetSelectable(AkuVeh[0], 0);

	AkuVeh[1] = TextDrawCreate(565.000000, 340.000000, "hud:radar_modGarage");
	TextDrawFont(AkuVeh[1], 4);
	TextDrawLetterSize(AkuVeh[1], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[1], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[1], 1);
	TextDrawSetShadow(AkuVeh[1], 0);
	TextDrawAlignment(AkuVeh[1], 1);
	TextDrawColor(AkuVeh[1], -1);
	TextDrawBackgroundColor(AkuVeh[1], 255);
	TextDrawBoxColor(AkuVeh[1], 50);
	TextDrawUseBox(AkuVeh[1], 1);
	TextDrawSetProportional(AkuVeh[1], 1);
	TextDrawSetSelectable(AkuVeh[1], 0);

	AkuVeh[2] = TextDrawCreate(565.000000, 310.000000, "hud:radar_impound");
	TextDrawFont(AkuVeh[2], 4);
	TextDrawLetterSize(AkuVeh[2], 0.600000, 2.000000);
	TextDrawTextSize(AkuVeh[2], 17.000000, 19.000000);
	TextDrawSetOutline(AkuVeh[2], 1);
	TextDrawSetShadow(AkuVeh[2], 0);
	TextDrawAlignment(AkuVeh[2], 1);
	TextDrawColor(AkuVeh[2], -1);
	TextDrawBackgroundColor(AkuVeh[2], 255);
	TextDrawBoxColor(AkuVeh[2], 50);
	TextDrawUseBox(AkuVeh[2], 1);
	TextDrawSetProportional(AkuVeh[2], 1);
	TextDrawSetSelectable(AkuVeh[2], 0);

	AkuVeh[3] = TextDrawCreate(623.000000, 310.000000, "mph");
	TextDrawFont(AkuVeh[3], 1);
	TextDrawLetterSize(AkuVeh[3], 0.300000, 1.799998);
	TextDrawTextSize(AkuVeh[3], 400.000000, 17.000000);
	TextDrawSetOutline(AkuVeh[3], 1);
	TextDrawSetShadow(AkuVeh[3], 0);
	TextDrawAlignment(AkuVeh[3], 2);
	TextDrawColor(AkuVeh[3], -16776961);
	TextDrawBackgroundColor(AkuVeh[3], 255);
	TextDrawBoxColor(AkuVeh[3], 50);
	TextDrawUseBox(AkuVeh[3], 0);
	TextDrawSetProportional(AkuVeh[3], 1);
	TextDrawSetSelectable(AkuVeh[3], 0);

	//ALPRASH LAPAR HAUS
	LaparHaus[0] = TextDrawCreate(550.000000, 403.000000, "id_dual:white");
	TextDrawFont(LaparHaus[0], 4);
	TextDrawLetterSize(LaparHaus[0], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[0], 70.000000, 45.000000);
	TextDrawSetOutline(LaparHaus[0], 1);
	TextDrawSetShadow(LaparHaus[0], 0);
	TextDrawAlignment(LaparHaus[0], 1);
	TextDrawColor(LaparHaus[0], -1);
	TextDrawBackgroundColor(LaparHaus[0], 255);
	TextDrawBoxColor(LaparHaus[0], 50);
	TextDrawUseBox(LaparHaus[0], 1);
	TextDrawSetProportional(LaparHaus[0], 1);
	TextDrawSetSelectable(LaparHaus[0], 0);

	LaparHaus[1] = TextDrawCreate(475.000000, 403.000000, "id_dual:white");
	TextDrawFont(LaparHaus[1], 4);
	TextDrawLetterSize(LaparHaus[1], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[1], 70.000000, 45.000000);
	TextDrawSetOutline(LaparHaus[1], 1);
	TextDrawSetShadow(LaparHaus[1], 0);
	TextDrawAlignment(LaparHaus[1], 1);
	TextDrawColor(LaparHaus[1], -1);
	TextDrawBackgroundColor(LaparHaus[1], 255);
	TextDrawBoxColor(LaparHaus[1], 50);
	TextDrawUseBox(LaparHaus[1], 1);
	TextDrawSetProportional(LaparHaus[1], 1);
	TextDrawSetSelectable(LaparHaus[1], 0);

	LaparHaus[2] = TextDrawCreate(480.000000, 408.000000, "id_dual:white");
	TextDrawFont(LaparHaus[2], 4);
	TextDrawLetterSize(LaparHaus[2], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[2], 60.000000, 35.000000);
	TextDrawSetOutline(LaparHaus[2], 1);
	TextDrawSetShadow(LaparHaus[2], 0);
	TextDrawAlignment(LaparHaus[2], 1);
	TextDrawColor(LaparHaus[2], 16711935);
	TextDrawBackgroundColor(LaparHaus[2], 255);
	TextDrawBoxColor(LaparHaus[2], 50);
	TextDrawUseBox(LaparHaus[2], 1);
	TextDrawSetProportional(LaparHaus[2], 1);
	TextDrawSetSelectable(LaparHaus[2], 0);

	LaparHaus[3] = TextDrawCreate(555.000000, 408.000000, "id_dual:white");
	TextDrawFont(LaparHaus[3], 4);
	TextDrawLetterSize(LaparHaus[3], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[3], 60.000000, 35.000000);
	TextDrawSetOutline(LaparHaus[3], 1);
	TextDrawSetShadow(LaparHaus[3], 0);
	TextDrawAlignment(LaparHaus[3], 1);
	TextDrawColor(LaparHaus[3], 35839);
	TextDrawBackgroundColor(LaparHaus[3], 255);
	TextDrawBoxColor(LaparHaus[3], 50);
	TextDrawUseBox(LaparHaus[3], 1);
	TextDrawSetProportional(LaparHaus[3], 1);
	TextDrawSetSelectable(LaparHaus[3], 0);

	LaparHaus[4] = TextDrawCreate(485.000000, 415.000000, "hud:radar_dateFood");
	TextDrawFont(LaparHaus[4], 4);
	TextDrawLetterSize(LaparHaus[4], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[4], 18.000000, 19.000000);
	TextDrawSetOutline(LaparHaus[4], 1);
	TextDrawSetShadow(LaparHaus[4], 0);
	TextDrawAlignment(LaparHaus[4], 1);
	TextDrawColor(LaparHaus[4], -1);
	TextDrawBackgroundColor(LaparHaus[4], 255);
	TextDrawBoxColor(LaparHaus[4], 50);
	TextDrawUseBox(LaparHaus[4], 1);
	TextDrawSetProportional(LaparHaus[4], 1);
	TextDrawSetSelectable(LaparHaus[4], 0);

	LaparHaus[5] = TextDrawCreate(560.000000, 415.000000, "hud:radar_diner");
	TextDrawFont(LaparHaus[5], 4);
	TextDrawLetterSize(LaparHaus[5], 0.600000, 2.000000);
	TextDrawTextSize(LaparHaus[5], 17.000000, 19.000000);
	TextDrawSetOutline(LaparHaus[5], 1);
	TextDrawSetShadow(LaparHaus[5], 0);
	TextDrawAlignment(LaparHaus[5], 1);
	TextDrawColor(LaparHaus[5], -1);
	TextDrawBackgroundColor(LaparHaus[5], 255);
	TextDrawBoxColor(LaparHaus[5], 50);
	TextDrawUseBox(LaparHaus[5], 1);
	TextDrawSetProportional(LaparHaus[5], 1);
	TextDrawSetSelectable(LaparHaus[5], 0);

	//Welcome Textdraw
	WelcomeTD[0] = TextDrawCreate(320.000000, 379.000000, "_");
	TextDrawFont(WelcomeTD[0], 1);
	TextDrawLetterSize(WelcomeTD[0], 1.016666, 5.199995);
	TextDrawTextSize(WelcomeTD[0], 353.500000, 785.000000);
	TextDrawSetOutline(WelcomeTD[0], 1);
	TextDrawSetShadow(WelcomeTD[0], 0);
	TextDrawAlignment(WelcomeTD[0], 2);
	TextDrawColor(WelcomeTD[0], -1);
	TextDrawBackgroundColor(WelcomeTD[0], 255);
	TextDrawBoxColor(WelcomeTD[0], -206);
	TextDrawUseBox(WelcomeTD[0], 1);
	TextDrawSetProportional(WelcomeTD[0], 1);
	TextDrawSetSelectable(WelcomeTD[0], 0);

	WelcomeTD[1] = TextDrawCreate(320.000000, 378.000000, "_");
	TextDrawFont(WelcomeTD[1], 1);
	TextDrawLetterSize(WelcomeTD[1], 0.600000, -0.350005);
	TextDrawTextSize(WelcomeTD[1], 298.500000, 210.000000);
	TextDrawSetOutline(WelcomeTD[1], 1);
	TextDrawSetShadow(WelcomeTD[1], 0);
	TextDrawAlignment(WelcomeTD[1], 2);
	TextDrawColor(WelcomeTD[1], -1);
	TextDrawBackgroundColor(WelcomeTD[1], 255);
	TextDrawBoxColor(WelcomeTD[1], -65281);
	TextDrawUseBox(WelcomeTD[1], 1);
	TextDrawSetProportional(WelcomeTD[1], 1);
	TextDrawSetSelectable(WelcomeTD[1], 0);

	WelcomeTD[2] = TextDrawCreate(320.000000, 429.000000, "_");
	TextDrawFont(WelcomeTD[2], 1);
	TextDrawLetterSize(WelcomeTD[2], 0.600000, -0.350005);
	TextDrawTextSize(WelcomeTD[2], 298.500000, 312.500000);
	TextDrawSetOutline(WelcomeTD[2], 1);
	TextDrawSetShadow(WelcomeTD[2], 0);
	TextDrawAlignment(WelcomeTD[2], 2);
	TextDrawColor(WelcomeTD[2], -1);
	TextDrawBackgroundColor(WelcomeTD[2], 255);
	TextDrawBoxColor(WelcomeTD[2], -65281);
	TextDrawUseBox(WelcomeTD[2], 1);
	TextDrawSetProportional(WelcomeTD[2], 1);
	TextDrawSetSelectable(WelcomeTD[2], 0);

	WelcomeTD[3] = TextDrawCreate(265.000000, 381.000000, "Welcome back to");
	TextDrawFont(WelcomeTD[3], 0);
	TextDrawLetterSize(WelcomeTD[3], 0.562500, 2.000000);
	TextDrawTextSize(WelcomeTD[3], 671.500000, 67.000000);
	TextDrawSetOutline(WelcomeTD[3], 0);
	TextDrawSetShadow(WelcomeTD[3], 2);
	TextDrawAlignment(WelcomeTD[3], 1);
	TextDrawColor(WelcomeTD[3], -1);
	TextDrawBackgroundColor(WelcomeTD[3], 255);
	TextDrawBoxColor(WelcomeTD[3], 50);
	TextDrawUseBox(WelcomeTD[3], 0);
	TextDrawSetProportional(WelcomeTD[3], 1);
	TextDrawSetSelectable(WelcomeTD[3], 0);

	WelcomeTD[4] = TextDrawCreate(255.000000, 400.000000, "Valencia Roleplay");
	TextDrawFont(WelcomeTD[4], 0);
	TextDrawLetterSize(WelcomeTD[4], 0.562500, 2.000000);
	TextDrawTextSize(WelcomeTD[4], 671.500000, 67.000000);
	TextDrawSetOutline(WelcomeTD[4], 0);
	TextDrawSetShadow(WelcomeTD[4], 2);
	TextDrawAlignment(WelcomeTD[4], 1);
	TextDrawColor(WelcomeTD[4], -1);
	TextDrawBackgroundColor(WelcomeTD[4], 255);
	TextDrawBoxColor(WelcomeTD[4], 50);
	TextDrawUseBox(WelcomeTD[4], 0);
	TextDrawSetProportional(WelcomeTD[4], 1);
	TextDrawSetSelectable(WelcomeTD[4], 0);
}

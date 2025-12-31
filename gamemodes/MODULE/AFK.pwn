// Timer untuk check AFK (di ptask)
ptask AFKChecker[5000](playerid) // Check setiap 5 detik
{
	if(pData[playerid][IsLoggedIn] == false) return 1;
	if(pData[playerid][pAFK] == 1)
	{
		new msg[128];
		format(msg, sizeof(msg), "~r~AFK MODE~w~ Type: /afk %d", pData[playerid][pAFKCode]);
		InfoTD_MSG(playerid, 5200, msg); // Tampil terus setiap 5 detik
		return 1;
	} // Skip jika sudah AFK
	
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	// Cek apakah posisi sama dengan posisi terakhir
	if(floatabs(x - pData[playerid][pAFKPosX]) < 0.5 && 
	   floatabs(y - pData[playerid][pAFKPosY]) < 0.5 && 
	   floatabs(z - pData[playerid][pAFKPosZ]) < 0.5)
	{
		// Posisi tidak berubah, tambah waktu AFK
		pData[playerid][pAFKTime] += 5;
		
		// Jika AFK lebih dari 3 menit (180 detik), set status AFK
		if(pData[playerid][pAFKTime] >= 120)
		{
			SetPlayerAFK(playerid);
		}
	}
	else
	{
		// Posisi berubah, reset waktu AFK
		pData[playerid][pAFKTime] = 0;
		pData[playerid][pAFKPosX] = x;
		pData[playerid][pAFKPosY] = y;
		pData[playerid][pAFKPosZ] = z;
	}
	
	return 1;
}

// Function untuk set player AFK
stock SetPlayerAFK(playerid)
{
	if(pData[playerid][pAFK] == 1) return 0;
	
	// Generate random code (4 digit)
	pData[playerid][pAFKCode] = 1000 + random(9000);
	pData[playerid][pAFK] = 1;
	
	// Freeze player
	TogglePlayerControllable(playerid, false);
	
	// ✅ Update 3D Label dengan tag [AFK] + Code
	new labeltext[128];
	format(labeltext, sizeof(labeltext), "%s (%d) {FF0000}[AFK]", GetRPName(playerid), playerid);
	UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
	
	// ✅ Notifikasi simple
	Custom(playerid, "AFK: "WHITE_E"You have been marked as AFK. Use '/afk %d' to resume.", pData[playerid][pAFKCode]);
	
	printf("[AFK] %s marked as AFK. Code: %d", pData[playerid][pName], pData[playerid][pAFKCode]);
	
	return 1;
}

// Function untuk remove AFK status
stock RemovePlayerAFK(playerid)
{
	if(pData[playerid][pAFK] == 0) return 0;
	
	pData[playerid][pAFK] = 0;
	pData[playerid][pAFKTime] = 0;
	pData[playerid][pAFKCode] = 0;
	
	// Unfreeze player
	TogglePlayerControllable(playerid, true);
	
    // ✅ Reset 3D Label berdasarkan kondisi
	new labeltext[128];
	new labelcolor = COLOR_WHITE;
	
	// Cek apakah admin duty
	if(pData[playerid][pAdminDuty] == 1)
	{
		format(labeltext, sizeof(labeltext), ""SBLUE_E"On Duty\n"WHITE_E"%s (%d)\n"YELLOW_E"%s", 
			pData[playerid][pAdminname], 
			playerid, 
			GetStaffRank(playerid));
		UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_YELLOW, labeltext);
	}
	// ✅ Cek apakah faction duty
	else if(pData[playerid][pOnDuty] == 1)
	{
		// Set warna berdasarkan faction
		switch(pData[playerid][pFaction])
		{
			case 1: labelcolor = COLOR_BLUE;    // Police
			case 2: labelcolor = COLOR_LBLUE;   // Medic
			case 3: labelcolor = COLOR_PINK2;   // Faction 3
			case 4: labelcolor = COLOR_ORANGE2; // Faction 4
			case 5: labelcolor = COLOR_GREEN;   // Faction 5
			default: labelcolor = COLOR_WHITE;
		}
		
		// Format label on duty
		format(labeltext, sizeof(labeltext), "%s (%d)", GetRPName(playerid), playerid);
		UpdateDynamic3DTextLabelText(PlayerLabel[playerid], labelcolor, labeltext);
	}
	else if (pData[playerid][pMaskOn] == 1)
    {
        format(labeltext, sizeof(labeltext), "Mask_#%d {ffffff}(%d)", pData[playerid][pMaskID], playerid);
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
    }
	else
	{
		// Label normal (off duty)
		format(labeltext, sizeof(labeltext), "%s (%d)", GetRPName(playerid), playerid);
		UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
	}
	
	// Clear animation
	ClearAnimations(playerid);
	
	printf("[AFK] %s removed from AFK", pData[playerid][pName]);
	
	return 1;
}

// Command untuk kembali dari AFK
CMD:afk(playerid, params[])
{
	// Cek apakah player sedang AFK
	if(pData[playerid][pAFK] == 0)
		return Error(playerid, "You are not AFK!");
	
	new code;
	if(sscanf(params, "d", code))
		return Usage(playerid, "/afk [code]");
	
	// Validasi code
	if(code != pData[playerid][pAFKCode])
	{
		Error(playerid, "Invalid code! The correct code is '/afk %d'.", pData[playerid][pAFKCode]);
		PlayerPlaySound(playerid, 1085, 0.0, 0.0, 0.0);
		return 1;
	}
	
	// Remove AFK status
	RemovePlayerAFK(playerid);
	Custom(playerid, "AFK: "WHITE_E"You are no longer AFK Mode.");
	PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
	
	return 1;
}

// Command untuk admin force remove AFK
CMD:unafk(playerid, params[])
{
	if(pData[playerid][pAdmin] < 2) return PermissionError(playerid);
	
	new otherid;
	if(sscanf(params, "u", otherid)) return Usage(playerid, "/unafk [playerid]");
	if(!IsPlayerConnected(otherid)) return Error(playerid, "Player tidak online!");
	
	if(pData[otherid][pAFK] == 0)
		return Error(playerid, "Player tersebut tidak sedang AFK!");
	
	RemovePlayerAFK(otherid);
	Info(playerid, "Kamu telah menghapus status AFK dari %s.", pData[otherid][pName]);
	Info(otherid, "Admin %s telah menghapus status AFK kamu.", pData[playerid][pAdminname]);
	
	return 1;
}

// Command untuk check AFK list
CMD:afklist(playerid, params[])
{
	new count = 0, string[2048], temp[128];
	format(string, sizeof(string), "{FFFFFF}Player Name\t{FFFF00}AFK Time\n");
	
	foreach(new i : Player)
	{
		if(pData[i][pAFK] == 1)
		{
			count++;
			new afk_minutes = pData[i][pAFKTime] / 60;
			format(temp, sizeof(temp), "{33CCFF}%s\t{FFFFFF}%d minutes\n", pData[i][pName], afk_minutes);
			strcat(string, temp);
		}
	}
	
	if(count == 0)
	{
		return Info(playerid, "Tidak ada player yang sedang AFK.");
	}
	
	new title[64];
    format(title, sizeof(title), "AFK Players (%d)", count);
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, 
	title, string, "Close", "");
	
	return 1;
}
// ===== SETTINGS =====
#define DAMAGE_LABEL_DURATION 1000 // Durasi tampil (ms) - 3 detik
#define DAMAGE_LABEL_DISTANCE 50.0 // Jarak maksimal lihat label

LoadTagName(playerid)
{
    if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
        DestroyDynamic3DTextLabel(PlayerLabel[playerid]);

    new labeltext[128];
    format(labeltext, sizeof(labeltext), "%s (%d)", GetRPName(playerid), playerid);
    PlayerLabel[playerid] = CreateDynamic3DTextLabel(labeltext, COLOR_WHITE, 0.0, 0.0, 0.1, 10.0, playerid, INVALID_VEHICLE_ID, 1);
}

ResetTagLabel(playerid)
{
    if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
        DestroyDynamic3DTextLabel(PlayerLabel[playerid]);

    PlayerLabel[playerid] = STREAMER_TAG_3D_TEXT_LABEL:INVALID_STREAMER_ID;
}

// Timer untuk update label admin
timer LabelAdmin[1000](playerid)
{
    if(!IsPlayerConnected(playerid)) return;
    if(!IsValidDynamic3DTextLabel(PlayerLabel[playerid])) return;

    new nametag[128];
    format(nametag, sizeof(nametag), ""SBLUE_E"On Duty\n"WHITE_E"%s (%d)\n"YELLOW_E"%s", 
        pData[playerid][pAdminname], 
        playerid, 
        GetStaffRank(playerid)
    );
    UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_YELLOW, nametag);
}

// Timer untuk update label normal
timer LabelNormal[1000](playerid)
{
    if(!IsPlayerConnected(playerid)) return;
    if(!IsValidDynamic3DTextLabel(PlayerLabel[playerid])) return;

    new labeltext[128], labelcolor = COLOR_WHITE;

    // Admin Duty - Priority tertinggi
    if(pData[playerid][pAdminDuty])
    {
        defer LabelAdmin(playerid);
        return;
    }
    
    // Mask On - Priority kedua
    if(pData[playerid][pMaskOn])
    {
        format(labeltext, sizeof(labeltext), "Mask_#%d {ffffff}(%d)", pData[playerid][pMaskID], playerid);
        UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
        defer LabelNormal(playerid); // PENTING: Loop timer
        return;
    }

    // Faction Duty - Warna berdasarkan faction
    if(pData[playerid][pOnDuty])
    {
        switch(pData[playerid][pFaction])
        {
            case 1: labelcolor = COLOR_BLUE;    // Police
            case 2: labelcolor = COLOR_LBLUE;   // Medic
            case 3: labelcolor = COLOR_PINK2;   // Faction 3
            case 4: labelcolor = COLOR_ORANGE2; // Faction 4
            case 5: labelcolor = COLOR_GREEN;   // Faction 5
            default: labelcolor = COLOR_WHITE;
        }
    }

    // Default Label
    format(labeltext, sizeof(labeltext), "%s (%d)", GetRPName(playerid), playerid);
    UpdateDynamic3DTextLabelText(PlayerLabel[playerid], labelcolor, labeltext);
    
    defer LabelNormal(playerid); // PENTING: Loop timer agar terus update
}
// ===== ALTERNATIVE 3: Text-based percentage =====
stock CreateProgressBarText(Float:value, Float:max, output[], size, const color[])
{
	new percent = floatround((value / max) * 100.0);
	if(percent < 0) percent = 0;
	if(percent > 100) percent = 100;
	
	format(output, size, "%s%d%%", color, percent);
	
	return 1;
}
stock CreateProgressBar(Float:value, Float:max, output[], size, const filledcolor[], const emptycolor[])
{
	new percent = floatround((value / max) * 100.0);
	if(percent < 0) percent = 0;
	if(percent > 100) percent = 100;
	
	new filled = percent / 10;
	new empty = 10 - filled;
	
	output[0] = 0;
	
	strcat(output, filledcolor, size);
	for(new i = 0; i < filled; i++)
		strcat(output, "|", size);
	
	strcat(output, emptycolor, size);
	for(new i = 0; i < empty; i++)
		strcat(output, "|", size);
	
	return 1;
}
// ===== TIMER: HIDE DAMAGE LABEL =====
forward HideDamageLabel(attackerid, targetid);
public HideDamageLabel(attackerid, targetid)
{
	if(!IsPlayerConnected(attackerid))
		return 0;
	
	if(pData[attackerid][pDamageLabel][targetid] != PlayerText3D:INVALID_3DTEXT_ID)
	{
		DeletePlayer3DTextLabel(attackerid, pData[attackerid][pDamageLabel][targetid]);
		pData[attackerid][pDamageLabel][targetid] = PlayerText3D:INVALID_3DTEXT_ID;
	}
	
	pData[attackerid][pShowingDamage][targetid] = false;
	pData[attackerid][pDamageTimer][targetid] = 0;
	
	return 1;
}
// ===== FUNCTION: SHOW DAMAGE LABEL =====
stock ShowDamageLabel(attackerid, targetid)
{
	if(!IsPlayerConnected(attackerid) || !IsPlayerConnected(targetid))
		return 0;
	
	if(attackerid == targetid) // Jangan tampilkan untuk diri sendiri
		return 0;
	
	// Get target HP and Armor
	new Float:health, Float:armor;
	GetPlayerHealth(targetid, health);
	GetPlayerArmour(targetid, armor);
	
	// Buat HP bar - PILIH SALAH SATU STYLE DI BAWAH INI:
	
	// STYLE 1: Pipe bars (||||||||)
	/*new hpbar[32], armorbar[32];
	CreateProgressBar(health, 100.0, hpbar, sizeof(hpbar), "{FF0000}", "{666666}"); 
	CreateProgressBar(armor, 100.0, armorbar, sizeof(armorbar), "{00FF00}", "{666666}");
	
	 ATAU STYLE 2: Bracket style [========--]
	new hpbar[32], armorbar[32];
	CreateProgressBarBracket(health, 100.0, hpbar, sizeof(hpbar), "{FF0000}", "{666666}");
	CreateProgressBarBracket(armor, 100.0, armorbar, sizeof(armorbar), "{00FF00}", "{666666}");
	*/
	
	/* ATAU STYLE 3: Dots (oooooo....)
	new hpbar[32], armorbar[32];
	CreateProgressBarDots(health, 100.0, hpbar, sizeof(hpbar), "{FF0000}", "{666666}");
	CreateProgressBarDots(armor, 100.0, armorbar, sizeof(armorbar), "{00FF00}", "{666666}");
	*/
	
	//ATAU STYLE 4: Simple percentage (65%)
	new hpbar[32], armorbar[32];
	CreateProgressBarText(health, 100.0, hpbar, sizeof(hpbar), "{FF0000}");
	CreateProgressBarText(armor, 100.0, armorbar, sizeof(armorbar), "{00FF00}");
	
	
	// Format text
	new labeltext[256];
	if(armor > 0)
	{
		format(labeltext, sizeof(labeltext), 
			"{FFFFFF}HP: %s {FFFFFF}%.0f\n{FFFFFF}AR: %s {FFFFFF}%.0f",
			hpbar, health, armorbar, armor);
	}
	else
	{
		format(labeltext, sizeof(labeltext), 
			"{FFFFFF}HP: %s {FFFFFF}%.0f",
			hpbar, health);
	}
	
	// Hapus label lama jika ada
	if(pData[attackerid][pDamageLabel][targetid] != PlayerText3D:INVALID_3DTEXT_ID)
	{
		DeletePlayer3DTextLabel(attackerid, pData[attackerid][pDamageLabel][targetid]);
	}
	
	// Kill timer lama jika ada
	if(pData[attackerid][pDamageTimer][targetid] != 0)
	{
		KillTimer(pData[attackerid][pDamageTimer][targetid]);
	}
	
	// Buat label baru
	pData[attackerid][pDamageLabel][targetid] = CreatePlayer3DTextLabel(
		attackerid, 
		labeltext, 
		-1, 
		0.0, 0.0, 0.5, // Offset diatas kepala
		DAMAGE_LABEL_DISTANCE, 
		targetid, 
		INVALID_VEHICLE_ID, 
		1
	);
	
	pData[attackerid][pShowingDamage][targetid] = true;
	
	// Set timer untuk hide label
	pData[attackerid][pDamageTimer][targetid] = SetTimerEx(
		"HideDamageLabel", 
		DAMAGE_LABEL_DURATION, 
		false, 
		"ii", 
		attackerid, 
		targetid
	);
	
	return 1;
}

// ===== OPTIONAL: UPDATE LABEL SETIAP DETIK (Jika ingin real-time) =====
forward UpdateDamageLabels();
public UpdateDamageLabels()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(!IsPlayerConnected(i)) continue;
		
		for(new t = 0; t < MAX_PLAYERS; t++)
		{
			if(!IsPlayerConnected(t)) continue;
			if(i == t) continue;
			
			// Jika sedang menampilkan damage label
			if(pData[i][pShowingDamage][t])
			{
				// Update label dengan HP/Armor terbaru
				new Float:health, Float:armor;
				GetPlayerHealth(t, health);
				GetPlayerArmour(t, armor);
				
				// GUNAKAN STYLE YANG SAMA SEPERTI DI ShowDamageLabel
				new hpbar[32], armorbar[32];
				CreateProgressBar(health, 100.0, hpbar, sizeof(hpbar), "{FF0000}", "{666666}");
				CreateProgressBar(armor, 100.0, armorbar, sizeof(armorbar), "{00FF00}", "{666666}");
				
				new labeltext[256];
				if(armor > 0)
				{
					format(labeltext, sizeof(labeltext), 
						"{FFFFFF}HP: %s {FFFFFF}%.0f\n{FFFFFF}AR: %s {FFFFFF}%.0f",
						hpbar, health, armorbar, armor);
				}
				else
				{
					format(labeltext, sizeof(labeltext), 
						"{FFFFFF}HP: %s {FFFFFF}%.0f",
						hpbar, health);
				}
				
				// Update text
				if(pData[i][pDamageLabel][t] != PlayerText3D:INVALID_3DTEXT_ID)
				{
					UpdatePlayer3DTextLabelText(i, pData[i][pDamageLabel][t], -1, labeltext);
				}
			}
		}
	}
	return 1;
}
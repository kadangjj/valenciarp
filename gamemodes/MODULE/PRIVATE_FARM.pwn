#define MAX_LADANG 20

//-------[ ENUM LADANG ]--------
enum ladang
{
	laName[50],
	laOwner[MAX_PLAYER_NAME],
	laPrice,
	Float:laExtposX,
	Float:laExtposY,
	Float:laExtposZ,
	Float:laExtTanemX,
	Float:laExtTanemY,
	Float:laExtTanemZ,
	Float:laExtTanemA,
	laProduct,
	laWheat,
	laOrange,
	laPegawai1[32],
	laPegawai2[32],
	laPegawai3[32],
	wPicksafe,
	wInt,
	wPickup,
	Text3D:wLabelPoint
};

new laData[MAX_LADANG][ladang],
	Iterator:FARMS<MAX_LADANG>;

//-------[ FUNCTIONS ]--------

Ladang_Save(id)
{
	if(id == -1 || !Iter_Contains(FARMS, id)) return 0;
	
	new dquery[2048];
	
	// Query dengan mysql_format (lebih aman)
	mysql_format(g_SQL, dquery, sizeof(dquery), 
		"UPDATE ladang SET "\
		"name='%e', "\
		"owner='%e', "\
		"price='%d', "\
		"extposx='%f', "\
		"extposy='%f', "\
		"extposz='%f', "\
		"safex='%f', "\
		"safey='%f', "\
		"safez='%f', "\
		"safea='%f', "\
		"product='%d', "\
		"white='%d', "\
		"orange='%d', "\
		"pegawai1='%e', "\
		"pegawai2='%e', "\
		"pegawai3='%e' "\
		"WHERE ID='%d'",
		laData[id][laName],
		laData[id][laOwner],
		laData[id][laPrice],
		laData[id][laExtposX],
		laData[id][laExtposY],
		laData[id][laExtposZ],
		laData[id][laExtTanemX],
		laData[id][laExtTanemY],
		laData[id][laExtTanemZ],
		laData[id][laExtTanemA],
		laData[id][laProduct],
		laData[id][laWheat],
		laData[id][laOrange],
		laData[id][laPegawai1],
		laData[id][laPegawai2],
		laData[id][laPegawai3],
		id
	);
	
	// DEBUG
	printf("[LADANG_SAVE] ID:%d Area:%.2f,%.2f,%.2f", 
		id, laData[id][laExtTanemX], laData[id][laExtTanemY], laData[id][laExtTanemZ]);
	
	return mysql_tquery(g_SQL, dquery);
}

Ladang_Refresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamicPickup(laData[id][wPickup]))
			DestroyDynamicPickup(laData[id][wPickup]);

		if(IsValidDynamic3DTextLabel(laData[id][wLabelPoint]))
			DestroyDynamic3DTextLabel(laData[id][wLabelPoint]);

		new string[900];
		if(strcmp(laData[id][laOwner], "-"))
		{
			// Hitung member
			new members = 1; // Owner
			if(strcmp(laData[id][laPegawai1], "-")) members++;
			if(strcmp(laData[id][laPegawai2], "-")) members++;
			if(strcmp(laData[id][laPegawai3], "-")) members++;
			
			format(string, sizeof(string), 
				"{00FFFF}[ID:%d]\n"\
				"{FFFFFF}Farm: "BLUE_E"%s\n"\
				"{FFFFFF}Owner: "GREEN_E"%s\n"\
				"{FFFFFF}Members: "YELLOW_E"%d/4\n"\
				"{FFFFFF}Stocks:\n"\
				"  Potato: "YELLOW_E"%d\n"\
				"  Wheat: "YELLOW_E"%d\n"\
				"  Orange: "YELLOW_E"%d", 
				id, laData[id][laName], laData[id][laOwner], members,
				laData[id][laProduct], laData[id][laWheat], laData[id][laOrange]);
				
			laData[id][wPickup] = CreateDynamicPickup(19135, 23, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.2, 0, 0, _, 8.0);
			laData[id][wLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		}		
		else
		{
			format(string, sizeof(string), 
				"{00FFFF}[ID:%d]\n"\
				"{00D900}Farm For Sale\n"\
				"{FFFF00}Price: {00FF00}%s\n"\
				"{FFFFFF}Type '/buy' to purchase", 
				id, FormatMoney(laData[id][laPrice]));
				
			laData[id][wPickup] = CreateDynamicPickup(19135, 23, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.2, 0, 0, _, 8.0);
			laData[id][wLabelPoint] = CreateDynamic3DTextLabel(string, COLOR_ARWIN, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ]+0.5, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, 0, 0);
		}
	}
}

function FarmCreate(id)
{
	Ladang_Save(id);
	Ladang_Refresh(id);
	return 1;
}

function LoadFarm()
{
	new rows = cache_num_rows();
	if(rows)
	{
		new wid, name[50], owner[MAX_PLAYER_NAME];
		new pegawai1[32], pegawai2[32], pegawai3[32];
		
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "ID", wid);
			cache_get_value_name(i, "name", name);
			format(laData[wid][laName], 50, "%s", name);
			cache_get_value_name(i, "owner", owner);
			format(laData[wid][laOwner], MAX_PLAYER_NAME, "%s", owner);
			cache_get_value_name_int(i, "price", laData[wid][laPrice]);
			
			// Load entrance
			cache_get_value_name_float(i, "extposx", laData[wid][laExtposX]);
			cache_get_value_name_float(i, "extposy", laData[wid][laExtposY]);
			cache_get_value_name_float(i, "extposz", laData[wid][laExtposZ]);
			
			// Load planting area
			cache_get_value_name_float(i, "safex", laData[wid][laExtTanemX]);
			cache_get_value_name_float(i, "safey", laData[wid][laExtTanemY]);
			cache_get_value_name_float(i, "safez", laData[wid][laExtTanemZ]);
			cache_get_value_name_float(i, "safea", laData[wid][laExtTanemA]);
			
			// Load stocks
			cache_get_value_name_int(i, "product", laData[wid][laProduct]);
			cache_get_value_name_int(i, "white", laData[wid][laWheat]);
			cache_get_value_name_int(i, "orange", laData[wid][laOrange]);
			
			// Load pegawai
			cache_get_value_name(i, "pegawai1", pegawai1);
			format(laData[wid][laPegawai1], 32, "%s", pegawai1);
			cache_get_value_name(i, "pegawai2", pegawai2);
			format(laData[wid][laPegawai2], 32, "%s", pegawai2);
			cache_get_value_name(i, "pegawai3", pegawai3);
			format(laData[wid][laPegawai3], 32, "%s", pegawai3);

			Iter_Add(FARMS, wid);
			Ladang_Refresh(wid);
			
			// DEBUG
			printf("[LOADFARM] ID:%d Area:%.2f,%.2f,%.2f", 
				wid, laData[wid][laExtTanemX], laData[wid][laExtTanemY], laData[wid][laExtTanemZ]);
		}
		printf("*** [Database: Loaded] farmer data (%d count).", rows);
	}
	return 1;
}

//-------[ ADMIN COMMANDS ]--------

CMD:lacreate(playerid, params[])
{
	if(pData[playerid][pAdmin] < 5)
		return PermissionError(playerid);

	new wid = Iter_Free(FARMS);
	if(wid == -1) return Error(playerid, "You cant create more farm!");
	
	new price, query[512];
	if(sscanf(params, "d", price)) return Usage(playerid, "/lacreate [price]");
	price *= 100;

	// Set default values
	format(laData[wid][laName], 50, "No Name");
	format(laData[wid][laOwner], MAX_PLAYER_NAME, "-");
	format(laData[wid][laPegawai1], 32, "-");
	format(laData[wid][laPegawai2], 32, "-");
	format(laData[wid][laPegawai3], 32, "-");
	laData[wid][laPrice] = price;
	
	// Get entrance position
	GetPlayerPos(playerid, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]);

	// Initialize area tanam
	laData[wid][laExtTanemX] = 0.0;
	laData[wid][laExtTanemY] = 0.0;
	laData[wid][laExtTanemZ] = 0.0;
	laData[wid][laExtTanemA] = 0.0;
	
	// Initialize stocks
	laData[wid][laProduct] = 0;
	laData[wid][laWheat] = 0;
	laData[wid][laOrange] = 0;

	Iter_Add(FARMS, wid);
	
	SendAdminMessage(COLOR_RED, "AdmCmd: %s created Farm ID %d Price %s", 
		pData[playerid][pAdminname], wid, FormatMoney(price));
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "IMPORTANT: Use /laedit %d area to set planting area!", wid);
	
	// INSERT
	mysql_format(g_SQL, query, sizeof(query), 
		"INSERT INTO ladang (ID, name, owner, price, extposx, extposy, extposz, safex, safey, safez, safea, product, white, orange, pegawai1, pegawai2, pegawai3) "\
		"VALUES (%d, 'No Name', '-', %d, %f, %f, %f, 0, 0, 0, 0, 0, 0, 0, '-', '-', '-')",
		wid, price, 
		laData[wid][laExtposX], 
		laData[wid][laExtposY], 
		laData[wid][laExtposZ]
	);
	mysql_tquery(g_SQL, query, "FarmCreate", "i", wid);
	
	return 1;
}

CMD:ladelete(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	new wid, query[256];
	if(sscanf(params, "i", wid)) return Usage(playerid, "/ladelete [farmid]");
	if(!Iter_Contains(FARMS, wid)) return Error(playerid, "Farm ID doesn't exist.");

	// Hapus semua plants di ladang
	for(new i = 0; i < MAX_PLANT; i++)
	{
		if(PlantData[i][PlantFarmID] == wid)
		{
			KillTimer(PlantData[i][PlantTimer]);
			if(IsValidDynamicObject(PlantData[i][PlantObjID]))
				DestroyDynamicObject(PlantData[i][PlantObjID]);
			if(IsValidDynamicCP(PlantData[i][PlantCP]))
				DestroyDynamicCP(PlantData[i][PlantCP]);
			
			PlantData[i][PlantType] = 0;
			PlantData[i][PlantFarmID] = -1;
			Iter_Remove(Plants, i);
		}
	}
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM plants WHERE farmid=%d", wid);
	mysql_tquery(g_SQL, query);

	// Hapus pickup & label
	if(IsValidDynamicPickup(laData[wid][wPickup]))
		DestroyDynamicPickup(laData[wid][wPickup]);
	if(IsValidDynamic3DTextLabel(laData[wid][wLabelPoint]))
		DestroyDynamic3DTextLabel(laData[wid][wLabelPoint]);

	// Reset data
	format(laData[wid][laName], 50, "None");
	format(laData[wid][laOwner], MAX_PLAYER_NAME, "None");
	format(laData[wid][laPegawai1], 32, "-");
	format(laData[wid][laPegawai2], 32, "-");
	format(laData[wid][laPegawai3], 32, "-");
	laData[wid][laExtposX] = 0;
	laData[wid][laExtposY] = 0;
	laData[wid][laExtposZ] = 0;
	laData[wid][laProduct] = 0;
	laData[wid][laWheat] = 0;
	laData[wid][laOrange] = 0;
	laData[wid][laExtTanemX] = 0;
	laData[wid][laExtTanemY] = 0;
	laData[wid][laExtTanemZ] = 0;

	Iter_Remove(FARMS, wid);

	// Update players
	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET ladang=-1, ladangrank=0 WHERE ladang=%d", wid);
	mysql_tquery(g_SQL, query);

	foreach(new ii : Player)
	{
		if(pData[ii][pLadang] == wid)
		{
			pData[ii][pLadang] = -1;
			pData[ii][pLadangRank] = 0;
			Servers(ii, "Your farm has been deleted by admin!");
		}
	}
	
	mysql_format(g_SQL, query, sizeof(query), "DELETE FROM ladang WHERE ID=%d", wid);
	mysql_tquery(g_SQL, query);
	
	SendStaffMessage(COLOR_ADMCMD, "AdmCmd: %s deleted Farm ID %d", pData[playerid][pAdminname], wid);
	return 1;
}

CMD:gotofarm(playerid, params[])
{
	new id;
	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
	
	if(sscanf(params, "d", id))
		return Usage(playerid, "/gotofarm [id]");
		
	if(!Iter_Contains(FARMS, id)) return Error(playerid, "Farm ID tidak ada.");
	
	SetPlayerPosition(playerid, laData[id][laExtposX], laData[id][laExtposY], laData[id][laExtposZ], 2.0);
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInFamily] = -1;
	
	Servers(playerid, "Teleport ke ID Farm %d", id);
	return 1;
}

CMD:laedit(playerid, params[])
{
	static wid, type[24], string[128];

	if(pData[playerid][pAdmin] < 4)
		return PermissionError(playerid);

	if(sscanf(params, "ds[24]S()[128]", wid, type, string))
	{
		Usage(playerid, "/laedit [id] [type]");
		SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} location, name, area, owner");
		return 1;
	}
	
	if((wid < 0 || wid >= MAX_LADANG))
		return Error(playerid, "Invalid farm ID.");
		
	if(!Iter_Contains(FARMS, wid)) 
		return Error(playerid, "Farm ID doesn't exist.");

	if(!strcmp(type, "location", true))
	{
		GetPlayerPos(playerid, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]);
		Ladang_Save(wid);
		Ladang_Refresh(wid);
		SendStaffMessage(COLOR_ADMCMD, "AdmCmd: %s set entrance of Farm ID %d", pData[playerid][pAdminname], wid);
	}
	else if(!strcmp(type, "name", true))
	{
		new name[50];
		if(sscanf(string, "s[50]", name))
			return Usage(playerid, "/laedit [id] name [Farm Name]");

		format(laData[wid][laName], 50, "%s", name);
		Ladang_Save(wid);
		Ladang_Refresh(wid);
		SendStaffMessage(COLOR_ADMCMD, "AdmCmd: %s changed Farm ID %d name to: %s", pData[playerid][pAdminname], wid, name);
	}
	else if(!strcmp(type, "area", true))
	{
		// Get position
		GetPlayerPos(playerid, laData[wid][laExtTanemX], laData[wid][laExtTanemY], laData[wid][laExtTanemZ]);
		GetPlayerFacingAngle(playerid, laData[wid][laExtTanemA]);
		
		// Save immediately
		Ladang_Save(wid);
		Ladang_Refresh(wid);
		
		SendStaffMessage(COLOR_ADMCMD, "AdmCmd: %s set planting area of Farm ID %d at (%.2f, %.2f, %.2f)", 
			pData[playerid][pAdminname], wid,
			laData[wid][laExtTanemX], laData[wid][laExtTanemY], laData[wid][laExtTanemZ]);
		
		Info(playerid, "Planting area set! Players can now plant within 60m radius.");
	}
	else if(!strcmp(type, "owner", true))
	{
		new otherid;
		if(sscanf(string, "d", otherid))
			return Usage(playerid, "/laedit [farmid] owner [playerid] (use '-1' to reset)");

		if(otherid == -1)
		{
			format(laData[wid][laOwner], MAX_PLAYER_NAME, "-");
		}
		else
		{
			if(!IsPlayerConnected(otherid))
				return Error(playerid, "Player not connected.");
				
			format(laData[wid][laOwner], MAX_PLAYER_NAME, "%s", pData[otherid][pName]);
			pData[otherid][pLadang] = wid;
			pData[otherid][pLadangRank] = 6;
			
			Info(otherid, "Admin set you as owner of Farm ID %d!", wid);
		}
		
		Ladang_Save(wid);
		Ladang_Refresh(wid);
		SendAdminMessage(COLOR_RED, "AdmCmd: %s set owner of Farm ID %d", pData[playerid][pAdminname], wid);
	}
	else
	{
		SendClientMessage(playerid, COLOR_YELLOW, "[TYPES]:{FFFFFF} location, name, area, owner");
	}
	
	return 1;
}

//-------[ PLAYER COMMANDS ]--------

CMD:lainvite(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You don't have a farm!");

	if(pData[playerid][pLadangRank] < 5)
		return Error(playerid, "You must be farm owner!");

	new otherid;
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/lainvite [playerid]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Player not connected.");

	if(otherid == playerid)
		return Error(playerid, "You can't invite yourself.");

	if(!NearPlayer(playerid, otherid, 5.0))
		return Error(playerid, "Player must be nearby.");

	if(pData[otherid][pLadang] != -1)
		return Error(playerid, "Player already in another farm!");

	// Count members
	new count = 0, limit = 4;
	foreach(new ii : Player)
	{
		if(pData[ii][pLadang] == pData[playerid][pLadang])
			count++;
	}
	
	if(count >= limit)
		return Error(playerid, "Farm is full (max 4 members)!");
	
	pData[otherid][pLadangInvite] = pData[playerid][pLadang];
	pData[otherid][pLadangOffer] = playerid;
	
	SendClientMessageEx(playerid, COLOR_GREEN, "You invited %s to join your farm.", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_YELLOW, "%s invited you to join their farm. Type: /accept farm", pData[playerid][pName]);
	
	return 1;
}

CMD:launinvite(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You don't have a farm!");

	if(pData[playerid][pLadangRank] < 5)
		return Error(playerid, "You must be farm owner!");

	new otherid;
	if(sscanf(params, "u", otherid))
		return Usage(playerid, "/launinvite [playerid]");

	if(!IsPlayerConnected(otherid))
		return Error(playerid, "Player not connected.");

	if(otherid == playerid)
		return Error(playerid, "You can't kick yourself.");

	if(pData[otherid][pLadangRank] > pData[playerid][pLadangRank])
		return Error(playerid, "You can't kick this player.");

	if(pData[otherid][pLadang] != pData[playerid][pLadang])
		return Error(playerid, "Player not in your farm.");

	// Remove from pegawai list
	new wid = pData[playerid][pLadang];
	new pname[MAX_PLAYER_NAME];
	GetPlayerName(otherid, pname, sizeof(pname));
	
	if(!strcmp(laData[wid][laPegawai1], pname, true))
		format(laData[wid][laPegawai1], 32, "-");
	else if(!strcmp(laData[wid][laPegawai2], pname, true))
		format(laData[wid][laPegawai2], 32, "-");
	else if(!strcmp(laData[wid][laPegawai3], pname, true))
		format(laData[wid][laPegawai3], 32, "-");
	
	Ladang_Save(wid);
	
	pData[otherid][pLadangRank] = 0;
	pData[otherid][pLadang] = -1;
	
	SendClientMessageEx(playerid, COLOR_GREEN, "You kicked %s from the farm.", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_RED, "%s kicked you from the farm.", pData[playerid][pName]);
	
	return 1;
}

CMD:lasafe(playerid)
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You're not a farm member.");

	new wid = pData[playerid][pLadang];
	
	if(IsPlayerInRangeOfPoint(playerid, 5.0, laData[wid][laExtposX], laData[wid][laExtposY], laData[wid][laExtposZ]))
	{
		ShowPlayerDialog(playerid, DIALOG_FARMSAFE, DIALOG_STYLE_LIST, "Farm Safe", "Potato\nWheat\nOrange\nChange Name Farm", "Select", "Cancel");
	}
	else
	{
		Error(playerid, "You must be at farm entrance.");
	}
	return 1;
}

CMD:lainfo(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You're not a farm member.");

	new ladangid = pData[playerid][pLadang];
	new string[512];

	format(string, sizeof(string), 
		"Farm ID\t\t: %d\n"\
		"Farm Name\t: %s\n"\
		"Farm Owner\t: %s\n"\
		"Potato\t\t: %d\n"\
		"Wheat\t\t: %d\n"\
		"Orange\t\t: %d",
		ladangid, 
		laData[ladangid][laName], 
		laData[ladangid][laOwner], 
		laData[ladangid][laProduct], 
		laData[ladangid][laWheat], 
		laData[ladangid][laOrange]
	);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Farm Information", string, "Close", "");
	return 1;
}

CMD:sellfarm(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You don't have a farm!");
		
	if(pData[playerid][pLadangRank] < 6)
		return Error(playerid, "You must be farm owner!");
		
	new wid = pData[playerid][pLadang];
	new string[256];
	new pay = laData[wid][laPrice] / 2; // 50% sell price
	
	format(string, sizeof(string), 
		""WHITE_E"Farm Name: "YELLOW_E"%s\n"\
		""WHITE_E"Sell Price: "GREEN_E"%s\n"\
		""WHITE_E"Are you sure you want to sell this farm?", 
		laData[wid][laName], FormatMoney(pay));
		
	ShowPlayerDialog(playerid, DIALOG_FARMSELL, DIALOG_STYLE_MSGBOX, "Farm Sell", string, "Yes", "No");
	return 1;	
}

CMD:givefarm(playerid, params[])
{
	if(pData[playerid][pLadang] == -1)
		return Error(playerid, "You don't have a farm!");
		
	if(pData[playerid][pLadangRank] < 6)
		return Error(playerid, "You must be farm owner!");
		
	new otherid;
	if(sscanf(params, "u", otherid)) 
		return Usage(playerid, "/givefarm [playerid]");
	
	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
		return Error(playerid, "Player must be nearby.");
		
	if(pData[otherid][pLadang] != -1) 
		return Error(playerid, "Player already has a farm!"); 
	
	new wid = pData[playerid][pLadang];
	
	// Transfer ownership
	GetPlayerName(otherid, laData[wid][laOwner], MAX_PLAYER_NAME);
	Ladang_Save(wid);
	Ladang_Refresh(wid);
	
	pData[otherid][pLadang] = wid;
	pData[otherid][pLadangRank] = 6;
	pData[playerid][pLadang] = -1;
	pData[playerid][pLadangRank] = 0;
	
	SendClientMessageEx(playerid, COLOR_GREEN, "You transferred farm ownership to %s", pData[otherid][pName]);
	SendClientMessageEx(otherid, COLOR_GREEN, "%s transferred farm ownership to you!", pData[playerid][pName]);
	
	return 1;	
}
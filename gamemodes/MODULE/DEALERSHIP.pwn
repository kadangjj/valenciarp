#define MAX_DEALER 100

enum e_Dealer
{
	dID,
	dName[128],
	dOwner[MAX_PLAYER_NAME],
	dProduct,
	dMoney,
	dVisit,
	dRestock,
	Text3D:dText,
	Text3D:dPText,
	dPPickup,
    dPickup,
    Float:dX,
    Float:dY,
    Float:dZ,
    Float:dPX,
    Float:dPY,
    Float:dPZ,
    dPrice,
    dVehicle[11],
    dType,
    dMapIcon,	
};

enum E_TEMP_BUY
{
    tempDealerID,
    tempModel,
    tempPrice,
    tempColor1,
    tempColor2
}
new BuyData[MAX_PLAYERS][E_TEMP_BUY];

// Deklarasi array
new DealerVehicleNames[7][11][32];
new DealerVehicleModels[7][11];
new DealerVehicleCount[7] = {0, 8, 10, 10, 7, 10, 9};

// Function untuk initialize data
stock InitializeDealerVehicles()
{
	// Type 1: WAA (8 vehicles)
	format(DealerVehicleNames[1][0], 32, "Alpha");
	format(DealerVehicleNames[1][1], 32, "Elegy");
	format(DealerVehicleNames[1][2], 32, "Stratum");
	format(DealerVehicleNames[1][3], 32, "Sultan");
	format(DealerVehicleNames[1][4], 32, "Jester");
	format(DealerVehicleNames[1][5], 32, "Flash");
	format(DealerVehicleNames[1][6], 32, "Uranus");
	format(DealerVehicleNames[1][7], 32, "Comet");
	
	DealerVehicleModels[1][0] = 602;
	DealerVehicleModels[1][1] = 562;
	DealerVehicleModels[1][2] = 561;
	DealerVehicleModels[1][3] = 560;
	DealerVehicleModels[1][4] = 559;
	DealerVehicleModels[1][5] = 565;
	DealerVehicleModels[1][6] = 558;
	DealerVehicleModels[1][7] = 480;
	
	// Type 2: Transfender (10 vehicles)
	format(DealerVehicleNames[2][0], 32, "Elegant");
	format(DealerVehicleNames[2][1], 32, "Admiral");
	format(DealerVehicleNames[2][2], 32, "Primo");
	format(DealerVehicleNames[2][3], 32, "Regina");
	format(DealerVehicleNames[2][4], 32, "Premier");
	format(DealerVehicleNames[2][5], 32, "Sentinel");
	format(DealerVehicleNames[2][6], 32, "Willard");
	format(DealerVehicleNames[2][7], 32, "Solair");
	format(DealerVehicleNames[2][8], 32, "Vincent");
	format(DealerVehicleNames[2][9], 32, "Sunrise");
	
	DealerVehicleModels[2][0] = 507;
	DealerVehicleModels[2][1] = 445;
	DealerVehicleModels[2][2] = 479;
	DealerVehicleModels[2][3] = 507;
	DealerVehicleModels[2][4] = 426;
	DealerVehicleModels[2][5] = 405;
	DealerVehicleModels[2][6] = 529;
	DealerVehicleModels[2][7] = 458;
	DealerVehicleModels[2][8] = 540;
	DealerVehicleModels[2][9] = 550;
	
	// Type 3: Locolow (10 vehicles)
	format(DealerVehicleNames[3][0], 32, "Blade");
	format(DealerVehicleNames[3][1], 32, "Broadway");
	format(DealerVehicleNames[3][2], 32, "Remington");
	format(DealerVehicleNames[3][3], 32, "Savanna");
	format(DealerVehicleNames[3][4], 32, "Slamvan");
	format(DealerVehicleNames[3][5], 32, "Tahoma");
	format(DealerVehicleNames[3][6], 32, "Tornado");
	format(DealerVehicleNames[3][7], 32, "Voodoo");
	format(DealerVehicleNames[3][8], 32, "Burrito");
	format(DealerVehicleNames[3][9], 32, "Pony");
	
	DealerVehicleModels[3][0] = 536;
	DealerVehicleModels[3][1] = 575;
	DealerVehicleModels[3][2] = 534;
	DealerVehicleModels[3][3] = 567;
	DealerVehicleModels[3][4] = 535;
	DealerVehicleModels[3][5] = 566;
	DealerVehicleModels[3][6] = 576;
	DealerVehicleModels[3][7] = 412;
	DealerVehicleModels[3][8] = 482;
	DealerVehicleModels[3][9] = 413;
	
	// Type 4: Motorcycle (7 vehicles)
	format(DealerVehicleNames[4][0], 32, "BF-400");
	format(DealerVehicleNames[4][1], 32, "Faggio");
	format(DealerVehicleNames[4][2], 32, "FCR-900");
	format(DealerVehicleNames[4][3], 32, "Freeway");
	format(DealerVehicleNames[4][4], 32, "PCJ-600");
	format(DealerVehicleNames[4][5], 32, "Sanchez");
	format(DealerVehicleNames[4][6], 32, "Wayfarer");
	
	DealerVehicleModels[4][0] = 581;
	DealerVehicleModels[4][1] = 462;
	DealerVehicleModels[4][2] = 521;
	DealerVehicleModels[4][3] = 463;
	DealerVehicleModels[4][4] = 461;
	DealerVehicleModels[4][5] = 468;
	DealerVehicleModels[4][6] = 586;
	
	// Type 5: Industrial (10 vehicles)
	format(DealerVehicleNames[5][0], 32, "Linerunner");
	format(DealerVehicleNames[5][1], 32, "Mule");
	format(DealerVehicleNames[5][2], 32, "Flatbed");
	format(DealerVehicleNames[5][3], 32, "Yankee");
	format(DealerVehicleNames[5][4], 32, "Boxville");
	format(DealerVehicleNames[5][5], 32, "Benson");
	format(DealerVehicleNames[5][6], 32, "Roadtrain");
	format(DealerVehicleNames[5][7], 32, "Tanker");
	format(DealerVehicleNames[5][8], 32, "Mr Whoopee");
	format(DealerVehicleNames[5][9], 32, "Hotdog");

	DealerVehicleModels[5][0] = 403;
	DealerVehicleModels[5][1] = 414;
	DealerVehicleModels[5][2] = 455;
	DealerVehicleModels[5][3] = 456;
	DealerVehicleModels[5][4] = 498;
	DealerVehicleModels[5][5] = 499;
	DealerVehicleModels[5][6] = 515;
	DealerVehicleModels[5][7] = 514;
	DealerVehicleModels[5][8] = 588;
	DealerVehicleModels[5][9] = 588;
	
	// Type 6: Company (10 vehicles)
	format(DealerVehicleNames[6][0], 32, "Cabbie");
	format(DealerVehicleNames[6][1], 32, "Taxi");
	format(DealerVehicleNames[6][2], 32, "Tow Truck");
	format(DealerVehicleNames[6][3], 32, "Walton");
	format(DealerVehicleNames[6][4], 32, "Sadler");
	//format(DealerVehicleNames[6][5], 32, "Pony");
	format(DealerVehicleNames[6][5], 32, "Bobcat");
	format(DealerVehicleNames[6][6], 32, "Yosemite");
	format(DealerVehicleNames[6][7], 32, "Burrito");
	format(DealerVehicleNames[6][8], 32, "Rumpo");
	
	DealerVehicleModels[6][0] = 438;
	DealerVehicleModels[6][1] = 420;
	DealerVehicleModels[6][2] = 525;
	DealerVehicleModels[6][3] = 478;
	DealerVehicleModels[6][4] = 543;
	//DealerVehicleModels[6][5] = 413;
	DealerVehicleModels[6][5] = 422;
	DealerVehicleModels[6][6] = 554;
	DealerVehicleModels[6][7] = 482;
	DealerVehicleModels[6][8] = 440;
}

new dsData[MAX_DEALER][e_Dealer],
	Iterator:Dealer<MAX_DEALER>;

Dealer_Refresh(id)
{
	if(id != -1)
	{
		if(IsValidDynamic3DTextLabel(dsData[id][dText]))
			DestroyDynamic3DTextLabel(dsData[id][dText]), dsData[id][dText] = Text3D: INVALID_3DTEXT_ID;

		if(IsValidDynamicPickup(dsData[id][dPickup]))
			DestroyDynamicPickup(dsData[id][dPickup]);

		if(IsValidDynamic3DTextLabel(dsData[id][dPText]))
			DestroyDynamic3DTextLabel(dsData[id][dPText]), dsData[id][dPText] = Text3D: INVALID_3DTEXT_ID;

		if(IsValidDynamicPickup(dsData[id][dPPickup]))
			DestroyDynamicPickup(dsData[id][dPPickup]);

		new str[316], type[128], lstr[1280];
		
		switch(dsData[id][dType])
		{
			case 1: type = "WAA";
			case 2: type = "Transfender";
			case 3: type = "Locolow";
			case 4: type = "Motorcycle";
			case 5: type = "Industrial";
			case 6: type = "Company";
			default: type = "Unknown";
		}

		if(strcmp(dsData[id][dOwner], "-"))
		{
			format(str, sizeof(str), "[Dealer ID : %d]\n"WBLUE_E"Dealer Name : "WHITE_E"%s\n"WBLUE_E"Dealer Owner: "WHITE_E"%s"WBLUE_E"\nDealer Product: "GREEN_E"%d\n"WBLUE_E"Dealer Type : "YELLOW_E"%s"LB_E"\n/buypv - to buy a vehicle here.", id, dsData[id][dName], dsData[id][dOwner], dsData[id][dProduct], type);
		}
		else
		{
			format(str, sizeof(str), "[Dealer ID : %d]\n"WBLUE_E"Dealer Price: "GREEN_E"%s\n"WBLUE_E"Dealer Product: "GREEN_E"%d\n"WBLUE_E"Dealer Type : "YELLOW_E"%s"LB_E"\n/buy - if you want to buy this dealership.", id, FormatMoney(dsData[id][dPrice]), dsData[id][dProduct], type);			
		}
		
		dsData[id][dPickup] = CreateDynamicPickup(1239, 23, dsData[id][dX], dsData[id][dY], dsData[id][dZ]+0.2, -1, -1, -1, 50);

		format(lstr, sizeof(lstr), "[Dealer Point ID : %d]\n"WBLUE_E"DEALERSHIP: "WHITE_E"Spawn kendaraan dealer {ffff00}%s\n{ffffff}Jika kalian sudah membeli kendaraan silahkan di pindahkan", id, dsData[id][dName]);
		dsData[id][dText] = CreateDynamic3DTextLabel(str, ARWIN, dsData[id][dX], dsData[id][dY], dsData[id][dZ]+0.0, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 8.0);
		dsData[id][dPPickup] = CreateDynamicPickup(1239, 23, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]+0.0, -1, -1, -1, 50);

		dsData[id][dPText] = CreateDynamic3DTextLabel(lstr, ARWIN, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]+0.0, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 8.0);
		dsData[id][dMapIcon] = CreateDynamicMapIcon(dsData[id][dX], dsData[id][dY], dsData[id][dZ], 55, -1, -1, -1, -1, 70.0);
	}
}

Dealer_Save(id)
{
	new query[2048];
	mysql_format(g_SQL, query, sizeof(query), 
		"UPDATE dealership SET owner='%e', name='%e', price=%d, type=%d, product=%d, money=%d, visit=%d, restock=%d, posx=%f, posy=%f, posz=%f, pospx=%f, pospy=%f, pospz=%f, veh1=%d, veh2=%d, veh3=%d, veh4=%d, veh5=%d, veh6=%d, veh7=%d, veh8=%d, veh9=%d, veh10=%d, veh11=%d WHERE id=%d",
		dsData[id][dOwner],
		dsData[id][dName],
		dsData[id][dPrice],
		dsData[id][dType],
		dsData[id][dProduct],
		dsData[id][dMoney],
		dsData[id][dVisit],
		dsData[id][dRestock],
		dsData[id][dX],
		dsData[id][dY],
		dsData[id][dZ],
		dsData[id][dPX],
		dsData[id][dPY],
		dsData[id][dPZ],
		dsData[id][dVehicle][0],
		dsData[id][dVehicle][1],
		dsData[id][dVehicle][2],
		dsData[id][dVehicle][3],
		dsData[id][dVehicle][4],
		dsData[id][dVehicle][5],
		dsData[id][dVehicle][6],
		dsData[id][dVehicle][7],
		dsData[id][dVehicle][8],
		dsData[id][dVehicle][9],
		dsData[id][dVehicle][10],
		id
	);

	return mysql_tquery(g_SQL, query);
}

GetNearbyDealer(playerid)
{
	for(new i = 0; i < MAX_DEALER; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.0, dsData[i][dX], dsData[i][dY], dsData[i][dZ]))
		{
			return i;
		}
	}
	return -1;
}

IsdOwner(playerid, id)
{
	if(!strcmp(dsData[id][dOwner], pData[playerid][pName], true))
		return 1;
	return 0;
}

Player_OwnsDealer(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(dsData[id][dOwner], pData[playerid][pName], true)) return 1;
	return 0;
}

Player_DealerCount(playerid)
{
	#if LIMIT_PER_PLAYER != 0
    new count;
	foreach(new i : Dealer)
	{
		if(IsdOwner(playerid, i)) count++;
	}
	return count;
	#else
	return 0;
	#endif
}

function LoadDealer()
{
	new rows = cache_num_rows();
	if(rows)
	{
		new did, owner[128], name[128];
		for(new i = 0; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", did);
			
			if(did < 0 || did >= MAX_DEALER)
			{
				printf("[DEALER ERROR] Invalid ID %d skipped during load", did);
				continue;
			}
			
			cache_get_value_name(i, "owner", owner);
			format(dsData[did][dOwner], 128, owner);
			cache_get_value_name(i, "name", name);
			format(dsData[did][dName], 128, name);
			cache_get_value_name_int(i, "price", dsData[did][dPrice]);
			cache_get_value_name_int(i, "visit", dsData[did][dVisit]);
			cache_get_value_name_int(i, "restock", dsData[did][dRestock]);
			cache_get_value_name_int(i, "product", dsData[did][dProduct]);
			cache_get_value_name_int(i, "money", dsData[did][dMoney]);
			cache_get_value_name_float(i, "posx", dsData[did][dX]);
			cache_get_value_name_float(i, "posy", dsData[did][dY]);
			cache_get_value_name_float(i, "posz", dsData[did][dZ]);
			cache_get_value_name_float(i, "pospx", dsData[did][dPX]);
			cache_get_value_name_float(i, "pospy", dsData[did][dPY]);
			cache_get_value_name_float(i, "pospz", dsData[did][dPZ]);
			cache_get_value_name_int(i, "type", dsData[did][dType]);
			cache_get_value_name_int(i, "veh1", dsData[did][dVehicle][0]);
			cache_get_value_name_int(i, "veh2", dsData[did][dVehicle][1]);
			cache_get_value_name_int(i, "veh3", dsData[did][dVehicle][2]);
			cache_get_value_name_int(i, "veh4", dsData[did][dVehicle][3]);
			cache_get_value_name_int(i, "veh5", dsData[did][dVehicle][4]);
			cache_get_value_name_int(i, "veh6", dsData[did][dVehicle][5]);
			cache_get_value_name_int(i, "veh7", dsData[did][dVehicle][6]);
			cache_get_value_name_int(i, "veh8", dsData[did][dVehicle][7]);
			cache_get_value_name_int(i, "veh9", dsData[did][dVehicle][8]);
			cache_get_value_name_int(i, "veh10", dsData[did][dVehicle][9]);
			cache_get_value_name_int(i, "veh11", dsData[did][dVehicle][10]);

			dsData[did][dID] = did;
			Iter_Add(Dealer, did);
			Dealer_Refresh(did);
			
			printf("[DEALER] Loaded ID %d: %s", did, dsData[did][dName]);
		}
		printf("[DEALER] Total loaded: %d", rows);
	}
}

GetOwnedDealer(playerid)
{
	new tmpcount;
	foreach(new did : Dealer)
	{
		if(!strcmp(dsData[did][dOwner], pData[playerid][pName], true))
		{
			tmpcount++;
		}
	}
	return tmpcount;
}

ReturnPlayerDealerID(playerid, dslot)
{
	new tmpcount;
	if(dslot < 1 && dslot > LIMIT_PER_PLAYER) return -1;
	foreach(new did : Dealer)
	{
		if(!strcmp(pData[playerid][pName], dsData[did][dOwner], true))
		{
			tmpcount++;
			if(tmpcount == dslot)
			{
				return did;
			}
		}
	}
	return -1;
}

GetAnyDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
		tmpcount++;
	}
	return tmpcount;
}

Dealer_BuyMenu(playerid, did)
{
	if(did <= -1) return 0;
	
	new dtype = dsData[did][dType];
	if(dtype < 1 || dtype > 6) return 0;
	
	new string[1024];
	format(string, sizeof(string), "Vehicle Name\tPrice\n");
	
	for(new i = 0; i < DealerVehicleCount[dtype]; i++)
	{
		format(string, sizeof(string), "%s{ffffff}%s{7fff00}\t%s\n", 
			string, 
			DealerVehicleNames[dtype][i], 
			FormatMoney(dsData[did][dVehicle][i])
		);
	}
	
	ShowPlayerDialog(playerid, DEALER_BUYPROD, DIALOG_STYLE_TABLIST_HEADERS, dsData[did][dName], string, "Buy", "Cancel");
	return 1;
}

Dealer_ProductMenu(playerid, did)
{
	if(did <= -1) return 0;
	
	new dtype = dsData[did][dType];
	if(dtype < 1 || dtype > 6) return 0;
	
	new string[1024];
	format(string, sizeof(string), "Vehicle Name\tPrice\n");
	
	for(new i = 0; i < DealerVehicleCount[dtype]; i++)
	{
		format(string, sizeof(string), "%s{ffffff}%s{7fff00}\t%s\n", 
			string, 
			DealerVehicleNames[dtype][i], 
			FormatMoney(dsData[did][dVehicle][i])
		);
	}
	
	ShowPlayerDialog(playerid, DEALER_EDITPROD, DIALOG_STYLE_TABLIST_HEADERS, "Dealer: Modify Vehicle Price", string, "Edit", "Cancel");
	return 1;
}

ReturnDealerID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALER) return -1;
	foreach(new id : Dealer)
	{
		tmpcount++;
		if(tmpcount == slot)
		{
			return id;
		}
	}
	return -1;
}

function OnDealerCreated(did)
{
	new query[256];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE dealership SET id=%d WHERE id=(SELECT MAX(id) FROM (SELECT * FROM dealership) AS temp)", did);
	mysql_tquery(g_SQL, query);
	
	Dealer_Save(did);
	Dealer_Refresh(did);
	return 1;
}

CMD:createdealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	static query[512];
	new did = -1;
	
	for(new i = 0; i < MAX_DEALER; i++)
	{
		if(!Iter_Contains(Dealer, i))
		{
			did = i;
			break;
		}
	}
	
	if(did == -1)
		return Error(playerid, "Kamu tidak bisa membuat Dealer lagi sudah terkena Limit");

	new price, type;
	if(sscanf(params, "dd", price, type))
		return Usage(playerid, "/createdealer [price] [type, 1.WAA | 2.Transfender | 3.Locolow | 4.Motorcycle | 5.Industrial | 6.Company]");
	
	if(type < 1 || type > 6)
		return Error(playerid, "Tipe dealer tidak valid! Gunakan 1-6");
	
	if(price < 0)
		return Error(playerid, "Harga tidak boleh negatif!");

	price *= 100;

	format(dsData[did][dOwner], 128, "-");
	GetPlayerPos(playerid, dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
	dsData[did][dPrice] = price;
	dsData[did][dType] = type;
	new address[128];
	address = GetLocation(dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
	format(dsData[did][dName], 128, address);
	
	dsData[did][dPX] = 0.0;
	dsData[did][dPY] = 0.0;
	dsData[did][dPZ] = 0.0;
	
	for(new i = 0; i < 11; i++)
	{
		dsData[did][dVehicle][i] = 0;
	}
	
	dsData[did][dProduct] = 0;
	dsData[did][dMoney] = 0;
	dsData[did][dVisit] = 0;
	dsData[did][dRestock] = 0;

	Dealer_Refresh(did);
	Iter_Add(Dealer, did);
	
	SendAdminMessage(COLOR_RED, "%s has add of Dealer ID: %d.", pData[playerid][pAdminname], did);

	// Query INSERT - pastikan semua tipe data benar
	mysql_format(g_SQL, query, sizeof(query), 
		"INSERT INTO dealership (id, owner, name, price, type, product, money, visit, restock, posx, posy, posz, pospx, pospy, pospz, veh1, veh2, veh3, veh4, veh5, veh6, veh7, veh8, veh9, veh10, veh11) VALUES (%d, '%e', '%e', %d, %d, %d, %d, %d, %d, %f, %f, %f, %f, %f, %f, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d, %d)", 
		did, 
		dsData[did][dOwner], 
		dsData[did][dName], 
		dsData[did][dPrice], 
		dsData[did][dType], 
		dsData[did][dProduct], 
		dsData[did][dMoney], 
		dsData[did][dVisit], 
		dsData[did][dRestock], 
		dsData[did][dX], 
		dsData[did][dY], 
		dsData[did][dZ],
		dsData[did][dPX],
		dsData[did][dPY],
		dsData[did][dPZ],
		dsData[did][dVehicle][0],
		dsData[did][dVehicle][1],
		dsData[did][dVehicle][2],
		dsData[did][dVehicle][3],
		dsData[did][dVehicle][4],
		dsData[did][dVehicle][5],
		dsData[did][dVehicle][6],
		dsData[did][dVehicle][7],
		dsData[did][dVehicle][8],
		dsData[did][dVehicle][9],
		dsData[did][dVehicle][10]
	);
	mysql_tquery(g_SQL, query, "OnDealerCreated", "i", did);
	return 1;
}

CMD:editdealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	new did, type[24], string[128];
	if(sscanf(params, "ds[24]S()[128]", did, type, string))
	{
		Usage(playerid, "/editdealer [dealerid] [name]");
		SendClientMessageEx(playerid, ARWIN, "[NAME]"WHITE_E" location, owner, point, product, price, type, remove");
		return 1;
	}

	if(did < 0 || did >= MAX_DEALER)
		return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, did)) 
		return Error(playerid, "The Dealer you specified ID of doesn't exist.");

	if(!strcmp(type, "location", true))
	{
		GetPlayerPos(playerid, dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
		
		new address[128];
		address = GetLocation(dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
		format(dsData[did][dName], 128, address);
		
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the location of Dealer ID: %d", pData[playerid][pAdminname], did);
	}
	else if(!strcmp(type, "owner", true))
	{
		new otherid;
		if(sscanf(string, "d", otherid))
			return Usage(playerid, "/editdealer [dealerid] owner [playerid] (use '-1' to reset owner)");

		if(!IsPlayerConnected(otherid) && otherid != -1)
			return Error(playerid, "Player is not connected!");

		if(otherid == -1)
		{
			format(dsData[did][dOwner], MAX_PLAYER_NAME, "-");
			dsData[did][dVisit] = 0;
			SendAdminMessage(COLOR_RED, "%s has reset the owner of dealership ID: %d", pData[playerid][pAdminname], did);
		}
		else
		{
			format(dsData[did][dOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
			dsData[did][dVisit] = gettime() + (86400 * 30);
			SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealership ID: %d to %s", pData[playerid][pAdminname], did, pData[otherid][pName]);
		}
		
		Dealer_Save(did);
		Dealer_Refresh(did);
	}
	else if(!strcmp(type, "point", true))
	{
		GetPlayerPos(playerid, dsData[did][dPX], dsData[did][dPY], dsData[did][dPZ]);
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Point of Dealer ID: %d", pData[playerid][pAdminname], did);
	}
	else if(!strcmp(type, "product", true))
	{
		new product;
		if(sscanf(string, "d", product))
			return Usage(playerid, "/editdealer [dealerid] product [jumlah]");

		if(product < 0)
			return Error(playerid, "Product tidak boleh negatif!");

		dsData[did][dProduct] = product;
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Product of Dealer ID: %d to %d", pData[playerid][pAdminname], did, product);
		Servers(playerid, "Product Dealer ID %d telah diubah menjadi %d", did, product);
	}
	else if(!strcmp(type, "price", true))
	{
		new newprice;
		if(sscanf(string, "d", newprice))
			return Usage(playerid, "/editdealer [dealerid] price [harga dalam ribuan]");

		if(newprice < 0)
			return Error(playerid, "Harga tidak boleh negatif!");

		newprice *= 100;
		dsData[did][dPrice] = newprice;
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Price of Dealer ID %d to %s", pData[playerid][pAdminname], did, FormatMoney(newprice));
		Servers(playerid, "Dealer price telah diubah menjadi %s", FormatMoney(newprice));
	}
	else if(!strcmp(type, "type", true))
	{
		new dtype;
		if(sscanf(string, "d", dtype))
			return Usage(playerid, "/editdealer [dealerid] type [1.WAA | 2.Transfender | 3.Locolow | 4.Motorcycle | 5.Industrial | 6.Company]");

		if(dtype < 1 || dtype > 6)
			return Error(playerid, "Tipe dealer tidak valid! Gunakan 1-6");
    
		dsData[did][dType] = dtype;
		
		for(new i = 0; i < 11; i++)
		{
			dsData[did][dVehicle][i] = 0;
		}
		
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Type of Dealer ID: %d to type %d", pData[playerid][pAdminname], did, dtype);
	}
	else if(!strcmp(type, "remove", true))
	{
		DestroyDynamic3DTextLabel(dsData[did][dText]);
		DestroyDynamic3DTextLabel(dsData[did][dPText]);
		DestroyDynamicPickup(dsData[did][dPickup]);
		DestroyDynamicPickup(dsData[did][dPPickup]);
		DestroyDynamicMapIcon(dsData[did][dMapIcon]);

		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dealership WHERE id=%d", did);
		mysql_tquery(g_SQL, query);
		
		Iter_Remove(Dealer, did);
		
		dsData[did][dID] = -1;
		format(dsData[did][dOwner], MAX_PLAYER_NAME, "");
		format(dsData[did][dName], 128, "");
		dsData[did][dX] = 0.0;
		dsData[did][dY] = 0.0;
		dsData[did][dZ] = 0.0;
		dsData[did][dPX] = 0.0;
		dsData[did][dPY] = 0.0;
		dsData[did][dPZ] = 0.0;
		dsData[did][dPrice] = 0;
		dsData[did][dProduct] = 0;
		dsData[did][dMoney] = 0;
		dsData[did][dVisit] = 0;
		dsData[did][dRestock] = 0;
		dsData[did][dType] = 0;
		dsData[did][dText] = Text3D:INVALID_3DTEXT_ID;
		dsData[did][dPText] = Text3D:INVALID_3DTEXT_ID;
		dsData[did][dPickup] = -1;
		dsData[did][dPPickup] = -1;
		dsData[did][dMapIcon] = -1;
		
		for(new i = 0; i < 11; i++)
		{
			dsData[did][dVehicle][i] = 0;
		}

		SendAdminMessage(COLOR_RED, "%s has deleted Dealer ID: %d", pData[playerid][pAdminname], did);
	}
	return 1;
}

CMD:dm(playerid, params[])
{
	if(GetNearbyDealer(playerid) == -1) return Error(playerid, "Anda tidak berada di dealer manapun!");
	if(!IsdOwner(playerid, GetNearbyDealer(playerid))) return Error(playerid, "Anda tidak memiliki bisnis ini!");
	ShowPlayerDialog(playerid, DEALER_MENU, DIALOG_STYLE_LIST, "Dealer Menu", "Dealer Info\nChange Name\nBisnis Vault\nProduct Menu\nRequest Stock", "Select", "Cancel");
	return 1;
}

CMD:buypv(playerid, params[])
{
	new id = GetNearbyDealer(playerid);
	if(id > -1)
	{
		Dealer_BuyMenu(playerid, id);	
	}
	else return Error(playerid, "Kamu tidak di dekat Point apapun");
	return 1;
}

CMD:mydealer(playerid, params[])
{
	if(!GetOwnedDealer(playerid)) return Error(playerid, "You don't have any Dealer.");
	new did, tmpstring[128], count = GetOwnedDealer(playerid), CMDSString[512];
	CMDSString = "";
	strcat(CMDSString, "No\tName\tLocation\n", sizeof(CMDSString));
	Loop(itt, (count + 1), 1)
	{
		did = ReturnPlayerDealerID(playerid, itt);
		if(itt == count)
		{
			format(tmpstring, sizeof(tmpstring), "%d\t%s{ffffff}\t%s\n", itt, dsData[did][dName], GetLocation(dsData[did][dX], dsData[did][dY], dsData[did][dZ]));
		}
		else format(tmpstring, sizeof(tmpstring), "%d\t%s{ffffff}\t%s\n", itt, dsData[did][dName], GetLocation(dsData[did][dX], dsData[did][dY], dsData[did][dZ]));
		strcat(CMDSString, tmpstring);
	}
	ShowPlayerDialog(playerid, DIALOG_MY_DEALER, DIALOG_STYLE_TABLIST_HEADERS, "My Dealer", CMDSString, "Track", "Cancel");
	return 1;
}

CMD:gotodealer(playerid, params[])
{
	new did;
	if(pData[playerid][pAdmin] < 2)
		return PermissionError(playerid);
		
	if(sscanf(params, "d", did))
		return Usage(playerid, "/gotodealer [id]");
		
	if(!Iter_Contains(Dealer, did)) return Error(playerid, "The Dealership you specified ID of doesn't exist.");
	SetPlayerPos(playerid, dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
	SetPlayerInterior(playerid, 0);
	SetPlayerVirtualWorld(playerid, 0);
	Info(playerid, "You has teleport to Dealership id %d", did);
	return 1;
}
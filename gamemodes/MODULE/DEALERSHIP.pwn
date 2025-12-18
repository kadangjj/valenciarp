#define MAX_DEALER 100

enum e_Dealer
{
	dID,
	dName[128],
	dOwner[MAX_PLAYER_NAME],
	dProduct,
	dMoney,
	dVisit,
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
// Deklarasi array
new DealerVehicleNames[7][11][32];
new DealerVehicleModels[7][11];
new DealerVehicleCount[7] = {0, 8, 10, 10, 7, 10, 10};

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

	DealerVehicleModels[5][0] = 403; // Linerunner
	DealerVehicleModels[5][1] = 414; // Mule
	DealerVehicleModels[5][2] = 455; // Flatbed
	DealerVehicleModels[5][3] = 456; // Yankee
	DealerVehicleModels[5][4] = 498; // Boxville
	DealerVehicleModels[5][5] = 499; // Benson
	DealerVehicleModels[5][6] = 515; // Roadtrain ✅
	DealerVehicleModels[5][7] = 514; // Tanker ✅
	DealerVehicleModels[5][8] = 588; // Mr Whoopee
	DealerVehicleModels[5][9] = 588; // Hotdog (isi benar, jangan 0)

	
	// Type 6: Company (10 vehicles)
	format(DealerVehicleNames[6][0], 32, "Cabbie");
	format(DealerVehicleNames[6][1], 32, "Taxi");
	format(DealerVehicleNames[6][2], 32, "Tow Truck");
	format(DealerVehicleNames[6][3], 32, "Walton");
	format(DealerVehicleNames[6][4], 32, "Sadler");
	format(DealerVehicleNames[6][5], 32, "Pony");
	format(DealerVehicleNames[6][6], 32, "Bobcat");
	format(DealerVehicleNames[6][7], 32, "Yosemite");
	format(DealerVehicleNames[6][8], 32, "Burrito");
	format(DealerVehicleNames[6][9], 32, "Rumpo");
	
	DealerVehicleModels[6][0] = 438;
	DealerVehicleModels[6][1] = 420;
	DealerVehicleModels[6][2] = 525;
	DealerVehicleModels[6][3] = 478;
	DealerVehicleModels[6][4] = 543;
	DealerVehicleModels[6][5] = 413;
	DealerVehicleModels[6][6] = 422;
	DealerVehicleModels[6][7] = 554;
	DealerVehicleModels[6][8] = 482;
	DealerVehicleModels[6][9] = 440;
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
			DestroyDynamicPickup(dsData[id][dPickup]);//, dsData[id][dPickup] = -1;

		if(IsValidDynamic3DTextLabel(dsData[id][dPText]))
			DestroyDynamic3DTextLabel(dsData[id][dPText]), dsData[id][dPText] = Text3D: INVALID_3DTEXT_ID;

		if(IsValidDynamicPickup(dsData[id][dPPickup]))
			DestroyDynamicPickup(dsData[id][dPPickup]);//, dsData[id][dPPickup] = -1;

		new str[316], type[128], lstr[1280];
		if(dsData[id][dType] == 1)
		{
			type = "WAA";
		}
		else if(dsData[id][dType] == 2)
		{
			type = "Transfender";
		}
		else if(dsData[id][dType] == 3)
		{
			type = "Locolow";
		}
		else if(dsData[id][dType] == 4)
		{
			type = "Motorcycle";
		}
		else if(dsData[id][dType] == 5)
		{
			type = "Industrial";
		}
		else if(dsData[id][dType] == 6)
		{
			type = "Company";
		}
		else
		{
			type = "Unkown";
		}

		// PERBAIKAN:
		if(strcmp(dsData[id][dOwner], "-") != 0) // atau if(strcmp(dsData[id][dOwner], "-"))
		{
			// Dealer SUDAH punya owner
			format(str, sizeof(str), "[Dealer ID : %d]\n"WBLUE_E"Dealer Name : "WHITE_E"%s\n"WBLUE_E"Dealer Owner: "WHITE_E"%s"WBLUE_E"\nDealer Product: "GREEN_E"%d\n"WBLUE_E"Dealer Type : "YELLOW_E"%s"WBLUE_E"\n/buypv to buy a vehicle here.", id, dsData[id][dName], dsData[id][dOwner], dsData[id][dProduct], type);
		}
		else
		{
			// Dealer BELUM punya owner
			format(str, sizeof(str), "[Dealer ID : %d]\n"WBLUE_E"Dealer Price: "GREEN_E"$%s\n"WBLUE_E"Dealer Product: "GREEN_E"%d\n"WBLUE_E"Dealer Type : "YELLOW_E"%s"WBLUE_E"\n/buy if you want to buy this dealership.", id, FormatMoney(dsData[id][dPrice]), dsData[id][dProduct], type);			
		}
		dsData[id][dPickup] = CreateDynamicPickup(1239, 23, dsData[id][dX], dsData[id][dY], dsData[id][dZ]+0.2, -1, -1, -1, 50);

		format(lstr, sizeof(lstr), "[Dealer Point ID : %d]\n"WBLUE_E"INFO: "WHITE_E"Spawn kendaraan dealer {ffff00}%s{ffffff} Jika kalian sudah membeli kendaraan silahkan di pindahkan", id, dsData[id][dName]);
		dsData[id][dText] = CreateDynamic3DTextLabel(str, ARWIN, dsData[id][dX], dsData[id][dY], dsData[id][dZ]+0.5, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 8.0);
		dsData[id][dPPickup] = CreateDynamicPickup(1239, 23, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]+0.2, -1, -1, -1, 50);

		dsData[id][dPText] = CreateDynamic3DTextLabel(lstr, ARWIN, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]+0.5, 8.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 8.0);
		dsData[id][dMapIcon] = CreateDynamicMapIcon(dsData[id][dX], dsData[id][dY], dsData[id][dZ], 55, -1, -1, -1, -1, 70.0);
	}
}

Dealer_Save(id)
{
	new query[5120];
	format(query, sizeof(query), "UPDATE dealership SET owner='%s', name='%s', product='%d', money='%d', visit='%d', posx='%f', posy='%f', posz='%f', pospx='%f', pospy='%f', pospz='%f', price='%d', type='%d'",
		dsData[id][dOwner],
		dsData[id][dName],
		dsData[id][dProduct],
		dsData[id][dMoney],
		dsData[id][dVisit],
		dsData[id][dX],
		dsData[id][dY],
		dsData[id][dZ],
		dsData[id][dPX],
		dsData[id][dPY],
		dsData[id][dPZ],
		dsData[id][dPrice],
		dsData[id][dType]
		);

	for (new i = 0; i < 10; i ++) 
	{
    	format(query, sizeof(query), "%s, veh%d='%d'", query, i + 1, dsData[id][dVehicle][i]);
    }
	format(query, sizeof(query), "%s, veh11='%d' WHERE ID='%d'", query, dsData[id][dVehicle][10], id);

	return mysql_tquery(g_SQL, query);
}

Dealer_Reset(id)
{
	format(dsData[id][dOwner], MAX_PLAYER_NAME, "-");
	dsData[id][dProduct] = 0;
	dsData[id][dMoney] = 0;
	dsData[id][dVisit] = 0;
	Dealer_Refresh(id);
}


GetNearbyDealer(playerid)
{
	for(new i=0; i< MAX_DEALER; i++){
		if(IsPlayerInRangeOfPoint(playerid, 2.0, dsData[i][dX], dsData[i][dY], dsData[i][dZ])) {//&& dsData[i][dId] == i){}
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
	static did;

	new rows = cache_num_rows(), owner[128], name[128];
	if(rows)
	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", did);
			cache_get_value_name(i, "owner", owner);
			format(dsData[did][dOwner], 128, owner);
			cache_get_value_name(i, "name", name);
			format(dsData[did][dName], 128, name);
			cache_get_value_name_int(i, "price", dsData[did][dPrice]);
			cache_get_value_name_int(i, "visit", dsData[did][dVisit]);
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

			Dealer_Refresh(did);
			dsData[did][dID] = did;
			Iter_Add(Dealer, did);
		}
		printf("[DEALER] Number of loaded : %d", rows);
	}
}

/*IsPlayerOwnerOfCDEx(playerid, id)
{
	if(!IsPlayerConnected(playerid)) return 0;
	if(id == -1) return 0;
	if(!strcmp(dsData[id][dOwner], pData[playerid][pName], true)) return 1;
	return 0;
}
*/
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
/*
GetDealerPaytax(playerid)//dealer
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

ReturnDealerPaytaxID(playerid, hslot) //dealer
{
	new tmpcount;
	if(hslot < 1 && hslot > MAX_DEALER) return -1;
	foreach(new did : Dealer)
	{
	    if(!strcmp(pData[playerid][pName], dsData[did][dOwner], true))
	    {
     		tmpcount++;
       		if(tmpcount == hslot)
       		{
        		return did;
  			}
	    }
	}
	return -1;
}*/

GetAnyDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
		tmpcount++;
	}
	return tmpcount;
}

// Function untuk build dialog
Dealer_BuyMenu(playerid, did)
{
	if(did <= -1) return 0;
	
	new dtype = dsData[did][dType];
	if(dtype < 1 || dtype > 6) return 0;
	
	new string[1024];
	format(string, sizeof(string), "Vehicle Name\tPrice\n");
	
	for(new i = 0; i < DealerVehicleCount[dtype]; i++)
	{
		format(string, sizeof(string), "%s{ffffff}%s{7fff00}\t$%s\n", 
			string, 
			DealerVehicleNames[dtype][i], 
			FormatMoney(dsData[did][dVehicle][i])
		);
	}
	
	ShowPlayerDialog(playerid, DEALER_BUYPROD, DIALOG_STYLE_TABLIST_HEADERS, dsData[did][dName], string, "Buy", "Cancel");
	return 1;
}

// Function untuk admin edit harga
Dealer_ProductMenu(playerid, did)
{
	if(did <= -1) return 0;
	
	new dtype = dsData[did][dType];
	if(dtype < 1 || dtype > 6) return 0;
	
	new string[1024];
	format(string, sizeof(string), "Vehicle Name\tPrice\n");
	
	for(new i = 0; i < DealerVehicleCount[dtype]; i++)
	{
		format(string, sizeof(string), "%s{ffffff}%s{7fff00}\t$%s\n", 
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
	
	// Cari ID yang kosong di database dengan looping
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
	price *= 100;

	format(dsData[did][dOwner], 128, "-");
	GetPlayerPos(playerid, dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
	dsData[did][dPrice] = price;
	dsData[did][dType] = type;
	new address[128];
	address = GetLocation(dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
	format(dsData[did][dName], 128, address);
	dsData[did][dVehicle][0] = 0;
	dsData[did][dVehicle][1] = 0;
	dsData[did][dVehicle][2] = 0;
	dsData[did][dVehicle][3] = 0;
	dsData[did][dVehicle][4] = 0;
	dsData[did][dVehicle][5] = 0;
	dsData[did][dVehicle][6] = 0;
	dsData[did][dVehicle][7] = 0;
	dsData[did][dVehicle][8] = 0;
	dsData[did][dVehicle][9] = 0;	
	dsData[did][dVehicle][10] = 0;	
	dsData[did][dProduct] = 0;
	dsData[did][dMoney] = 0;
	dsData[did][dVisit] = 0;

	Dealer_Refresh(did);
	Iter_Add(Dealer, did);
	
	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO dealership SET id=%d, owner='%s', price=%d, posx='%f', posy='%f', posz='%f', product=%d, money=%d, type=%d, name='%s'", did, dsData[did][dOwner], dsData[did][dPrice], dsData[did][dX], dsData[did][dY], dsData[did][dZ], dsData[did][dProduct], dsData[did][dMoney], dsData[did][dType], dsData[did][dName]);
	mysql_tquery(g_SQL, query, "OnDealerCreated", "i", did);
	return 1;
}

CMD:editdealer(playerid, params[])
{
	if(pData[playerid][pAdmin] < 6)
		return PermissionError(playerid);

	static did, type[24], string[128];
	if(sscanf(params, "ds[24]S()[128]", did, type, string))
	{
		Usage(playerid, "/editdealer [dealerid] [name]");
		SendClientMessageEx(playerid, ARWIN, "[NAME]"WHITE_E"posisi, owner, point, product, price, type");
		return 1;
	}

	if((did < 0 || did >= MAX_DEALER))
		return Error(playerid, "You have specified an invalid ID.");

	if(!Iter_Contains(Dealer, did)) 
		return Error(playerid, "The Dealer you specified ID of doesn't exist.");

	if(!strcmp(type, "posisi", true))
	{
		GetPlayerPos(playerid, dsData[did][dX], dsData[did][dY], dsData[did][dZ]);
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the location of Dealer ID: %d.", pData[playerid][pAdminname], did);
	}
	else if(!strcmp(type, "owner", true))
	{
		new otherid;
        if(sscanf(string, "d", otherid))
            return Usage(playerid, "/editdealer [dealerid] [owner] [playerid] (use '-1' to no owner/ reset)");

		if(otherid == -1)
			return format(dsData[did][dOwner], MAX_PLAYER_NAME, "-");

        format(dsData[did][dOwner], MAX_PLAYER_NAME, pData[otherid][pName]);
		
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "UPDATE dealership SET owner='%s' WHERE ID='%d'", dsData[did][dOwner], did);
		mysql_tquery(g_SQL, query);

		dsData[did][dVisit] = gettime() + (86400 * 30);
		Dealer_Save(did);
		Dealer_Refresh(did);
        SendAdminMessage(COLOR_RED, "%s has adjusted the owner of dealership ID: %d to %s", pData[playerid][pAdminname], did, pData[otherid][pName]);
	}
	else if(!strcmp(type, "point", true))
	{
		new
			Float:x,
			Float:y,
			Float:z;

		GetPlayerPos(playerid, x, y, z);

		dsData[did][dPX] = x;
		dsData[did][dPY] = y;
		dsData[did][dPZ] = z;

		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Point of Dealer ID: %d", pData[playerid][pAdminname], did);
	}
	else if(!strcmp(type, "product", true))
	{
		new product;
		if(sscanf(string, "d", product))
			return Usage(playerid, "/editdealer [product]");

		dsData[did][dProduct] = product;
		Dealer_Save(did);
		Dealer_Refresh(did);

		Servers(playerid, "Kamu telah menambahkan Product Dealer ID : %d", did);
	}
	else if(!strcmp(type, "price", true))
	{
		new cash[32], totalcash[25];
		
		// Mengambil harga yang diinputkan
		if(sscanf(string, "s[32]", cash))
			return Usage(playerid, "/editdealer [price]");

		// Konversi harga ke format yang benar (misalnya x100)
		format(totalcash, sizeof(totalcash), "%d00", strval(cash));

        dsData[did][dPrice] = strval(totalcash);
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%s has adjusted the Price of Dealer ID : %d", pData[playerid][pAdminname], did, FormatMoney(strval(totalcash)));
	}
	else if(!strcmp(type, "type", true))
	{
		new dtype;
		if(sscanf(string, "d", dtype))
			return Usage(playerid, "/editdealer [type, 1.WAA | 2.Transfender | 3.Locolow | 4.Motorcycle | 5.Industrial | 6.Company]");

		dsData[did][dType] = dtype;
		Dealer_Save(did);
		Dealer_Refresh(did);

		SendAdminMessage(COLOR_RED, "%S has adjusted the Price of Dealer ID : %d", pData[playerid][pAdminname], did);
	}
	else if(!strcmp(type, "remove", true))
	{
		Dealer_Reset(did);

		DestroyDynamic3DTextLabel(dsData[did][dText]);
		DestroyDynamic3DTextLabel(dsData[did][dPText]);
		DestroyDynamicPickup(dsData[did][dPickup]);
		DestroyDynamicPickup(dsData[did][dPPickup]);

		dsData[did][dX] = 0;
		dsData[did][dY] = 0;
		dsData[did][dZ] = 0;
		dsData[did][dPX] = 0;
		dsData[did][dPY] = 0;
		dsData[did][dPZ] = 0;	
		dsData[did][dPrice] = 0;
		dsData[did][dText] = Text3D: INVALID_3DTEXT_ID;
		dsData[did][dPText] = Text3D: INVALID_3DTEXT_ID;
		dsData[did][dPickup] = -1;
		dsData[did][dPPickup] = -1;

		Iter_Remove(Dealer, did);
		new query[128];
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dealership WHERE ID=%d", did);
		mysql_tquery(g_SQL, query);
		SendAdminMessage(COLOR_RED, "%s Has been deleted Dealer ID : %d", pData[playerid][pAdminname], did);
	}
	return 1;
}

CMD:dm(playerid, params[])
{
	if(GetNearbyDealer(playerid) == -1) return Error(playerid, "Anda tidak berada di dealer manapun!");
	if(!IsdOwner(playerid, GetNearbyDealer(playerid))) return Error(playerid, "Anda tidak memiliki bisnis ini!");
	ShowPlayerDialog(playerid, DEALER_MENU, DIALOG_STYLE_LIST, "Dealer Menu", "Dealer Info\nChange Name\nBisnis Vault\nProduct Menu", "Select", "Cancel");
	return 1;
}

CMD:buypv(playerid, params[])
{
	new id = GetNearbyDealer(playerid);
	if(id > -1)
	{
		Dealer_BuyMenu(playerid, id);	
	}else return Error(playerid, "Kamu tidak di dekat Point apapun");
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

CMD:restockdealer(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2731.5867, -2417.5535, 13.6280)) return Error(playerid, "Kamu tidak di point jual mana pun.");
	if(!GetOwnedDealer(playerid)) return Error(playerid, "You don't have any dealer");

	new jumlah, id;
	if(sscanf(params, "dd", id, jumlah))
		return Usage(playerid, "/restockdealer [dealerid] [jumlah] | /mydealer untuk mengecek ID Dealer kamu");

    if(jumlah < 0 || jumlah > 100)
        return Error(playerid, "Invalid Restock. Dealer range from 0 to 100.");

    GivePlayerMoneyEx(playerid, ProductPrice);
	dsData[id][dProduct] += jumlah;
	Info(playerid, "Sebuah truck telah mengirimkan Kendaraan ke Dealership anda");
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

#define MAX_GSTATION 50

enum gsinfo
{
	gsStock,
	Float:gsPosX,
	Float:gsPosY,
	Float:gsPosZ,
	Text3D:gsLabel,
	gsPickup
};

new gsData[MAX_GSTATION][gsinfo],
	Iterator: GStation<MAX_GSTATION>;
	
GStation_Refresh(gsid)
{
	if(gsid != -1)
    {
        if(IsValidDynamic3DTextLabel(gsData[gsid][gsLabel]))
            DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);

        if(IsValidDynamicPickup(gsData[gsid][gsPickup]))
            DestroyDynamicPickup(gsData[gsid][gsPickup]);

        static
        string[255];

		format(string, sizeof(string), "[GAS STATION ID: %d]\n"WHITE_E"Gas Stock: "YELLOW_E"%d liters\n"WHITE_E"Price: "LG_E"$%s /liters\n\n"WHITE_E"Type '"RED_E"/fill"WHITE_E"' to refill", gsid, gsData[gsid][gsStock], FormatMoney(GStationPrice));
		gsData[gsid][gsPickup] = CreateDynamicPickup(1650, 23, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.2, -1, -1, -1, 50.0);
		gsData[gsid][gsLabel] = CreateDynamic3DTextLabel(string, COLOR_GREEN, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]+0.5, 5.5);
	}
    return 1;
}

function LoadGStations()
{
    static gsid;
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", gsid);
			cache_get_value_name_int(i, "stock", gsData[gsid][gsStock]);
			cache_get_value_name_float(i, "posx", gsData[gsid][gsPosX]);
			cache_get_value_name_float(i, "posy", gsData[gsid][gsPosY]);
			cache_get_value_name_float(i, "posz", gsData[gsid][gsPosZ]);
			GStation_Refresh(gsid);
			Iter_Add(GStation, gsid);
		}
		printf("[Gas Station]: %d Loaded.", rows);
	}
}

GStation_Save(gsid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE gstations SET stock='%d', posx='%f', posy='%f', posz='%f' WHERE id='%d'",
	gsData[gsid][gsStock],
	gsData[gsid][gsPosX],
	gsData[gsid][gsPosY],
	gsData[gsid][gsPosZ],
	gsid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:creategs(playerid, params[])
{
	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
	
	new gsid = Iter_Free(GStation), query[128];
	if(gsid == -1) return Error(playerid, "You cant create more gs!");
	new stok;
	if(sscanf(params, "d", stok)) return Usage(playerid, "/creategs [stock - max: 10000/liters]");
	
	if(stok < 1 || stok > 10000) return Error(playerid, "Invagsid stok.");
	
	GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
	gsData[gsid][gsStock] = stok;
    GStation_Refresh(gsid);
	Iter_Add(GStation, gsid);

	mysql_format(g_SQL, query, sizeof(query), "INSERT INTO gstations SET id='%d', stock='%d', posx='%f', posy='%f', posz='%f'", gsid, gsData[gsid][gsStock], gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
	mysql_tquery(g_SQL, query, "OnGstationCreated", "ii", playerid, gsid);
	return 1;
}

function OnGstationCreated(playerid, gsid)
{
	GStation_Save(gsid);
	new str[150];
	format(str,sizeof(str),"[Gas]: %s membuat gas station id %d!", GetRPName(playerid), gsid);
	LogServer("Admin", str);	
	return 1;
}

// Helper function untuk cek vehicle terdekat
stock GetNearestVehicle(playerid, Float:range = 5.0)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	for(new i = 1; i < MAX_VEHICLES; i++)
	{
		if(GetVehicleModel(i) == 0) continue; // Skip jika vehicle tidak valid
		if(GetVehicleDistanceFromPoint(i, x, y, z) <= range)
		{
			return i;
		}
	}
	return INVALID_VEHICLE_ID;
}

// Helper function untuk cek jarak player ke vehicle
stock IsPlayerNearVehicle(playerid, vehicleid, Float:range = 5.0)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	
	if(GetVehicleDistanceFromPoint(vehicleid, x, y, z) <= range)
		return 1;
	
	return 0;
}

CMD:gotogs(playerid, params[])
{
	new gsid;
	if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);
		
	if(sscanf(params, "d", gsid))
		return Usage(playerid, "/gotogs [id]");
		
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The gs you specified ID of doesn't exist.");
	SetPlayerPosition(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ], 2.0);
    SetPlayerVirtualWorld(playerid, 0);
	SetPlayerInterior(playerid, 0);
	pData[playerid][pInBiz] = -1;
	pData[playerid][pInDoor] = -1;
	pData[playerid][pInHouse] = -1;
	pData[playerid][pInFamily] = -1;
	Servers(playerid, "You has teleport to gs id %d", gsid);
	return 1;
}

CMD:editgs(playerid, params[])
{
    static
        gsid,
        type[24],
        string[128];

    if(pData[playerid][pAdmin] < 4)
		if(pData[playerid][pServerModerator] < 1)
			return PermissionError(playerid);

    if(sscanf(params, "ds[24]S()[128]", gsid, type, string))
    {
        Usage(playerid, "/editgs [id] [name]");
        SendClientMessage(playerid, COLOR_YELLOW, "[NAMES]:{FFFFFF} location, stock, delete");
        return 1;
    }
    if((gsid < 0 || gsid >= MAX_GSTATION))
        return Error(playerid, "You have specified an invagsid ID.");
	if(!Iter_Contains(GStation, gsid)) return Error(playerid, "The doors you specified ID of doesn't exist.");

    if(!strcmp(type, "location", true))
    {
		GetPlayerPos(playerid, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]);
        GStation_Save(gsid);
		GStation_Refresh(gsid);

        SendAdminMessage(COLOR_RED, "%s has adjusted the location of gs ID: %d.", pData[playerid][pAdminname], gsid);
    }
    else if(!strcmp(type, "stock", true))
    {
        new stok;

        if(sscanf(string, "d", stok))
            return Usage(playerid, "/editgs [id] [type] [stock - 10000]");

        if(stok < 1 || stok > 10000)
            return Error(playerid, "You must specify at least 1 - 5.");

        gsData[gsid][gsStock] = stok;
        GStation_Save(gsid);
		GStation_Refresh(gsid);

        SendAdminMessage(COLOR_RED, "%s has set gs ID: %d stock to %d.", pData[playerid][pAdminname], gsid, stok);
    }
    else if(!strcmp(type, "delete", true))
    {
		new query[128];
		DestroyDynamic3DTextLabel(gsData[gsid][gsLabel]);
		DestroyDynamicPickup(gsData[gsid][gsPickup]);
		gsData[gsid][gsPosX] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsPosY] = 0;
		gsData[gsid][gsStock] = 0;
		gsData[gsid][gsLabel] = Text3D: INVALID_3DTEXT_ID;
		gsData[gsid][gsPickup] = -1;
		Iter_Remove(GStation, gsid);
		mysql_format(g_SQL, query, sizeof(query), "DELETE FROM gstations WHERE id=%d", gsid);
		mysql_tquery(g_SQL, query);
        SendAdminMessage(COLOR_RED, "%s has delete gs ID: %d.", pData[playerid][pAdminname], gsid);
		new str[150];
		format(str,sizeof(str),"[Gas]: %s menghapus gas station id %d!", GetRPName(playerid), gsid);
		LogServer("Admin", str);		
    }
    return 1;
}

CMD:fill(playerid, params[])
{
	// Harus tidak di dalam kendaraan
	if(IsPlayerInAnyVehicle(playerid))
		return Error(playerid, "You must exit the vehicle first to refuel.");

	// Cek apakah ada kendaraan di dekat player
	new vehid = GetNearestVehicle(playerid, 5.0);
	if(vehid == INVALID_VEHICLE_ID)
		return Error(playerid, "There is no vehicle nearby.");

	if(!IsEngineVehicle(vehid))
		return Error(playerid, "This vehicle doesn't have an engine.");

	if(GetEngineStatus(vehid))
		return Error(playerid, "Turn off the vehicle engine first.");

	if(GetVehicleFuel(vehid) >= 1000)
		return Error(playerid, "This vehicle tank is full.");

	if(pData[playerid][pFill] != -1)
		return Error(playerid, "You are already filling a vehicle. Please wait!");

	// Cek apakah di gas station
	foreach(new gsid : GStation)
	{
		if(IsPlayerInRangeOfPoint(playerid, 15.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
		{
			if(gsData[gsid][gsStock] < 1)
				return Error(playerid, "This gas station is out of stock!");

			// Set data filling
			pData[playerid][pFill] = gsid;
			pData[playerid][pFillVeh] = vehid;
			pData[playerid][pFillPrice] = 0;
			pData[playerid][pActivityTime] = 0;
			
			// Animasi pegang nozzle
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
			SetPlayerAttachedObject(playerid, 9, 19819, 6, 0.095, 0.03, -0.01, 0.0, 90.0, 90.0, 1.0, 1.0, 1.0); // Nozzle
			
			// Mulai timer filling dengan progress bar
			pData[playerid][pFillTime] = SetTimerEx("Filling", 1000, true, "i", playerid);
			PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Filling...");
			PlayerTextDrawShow(playerid, ActiveTD[playerid]);
			ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
			
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s takes the fuel nozzle and starts refueling the vehicle.", ReturnName(playerid));
			Info(playerid, "Filling vehicle... Stay near the vehicle!");
			return 1;
		}
	}
	return Error(playerid, "You must be at a gas station!");
}

function Filling(playerid)
{
	if(pData[playerid][pFill] == -1) return 0;
	
	new vehid = pData[playerid][pFillVeh];
	new gsid = pData[playerid][pFill];
	
	// Validasi: Jarak dari gas station
	if(!IsPlayerInRangeOfPoint(playerid, 15.0, gsData[gsid][gsPosX], gsData[gsid][gsPosY], gsData[gsid][gsPosZ]))
	{
		Error(playerid, "You moved too far from the gas station!");
		StopFilling(playerid);
		return 1;
	}
	
	// Validasi: Jarak dari kendaraan
	if(!IsPlayerNearVehicle(playerid, vehid, 5.0))
	{
		Error(playerid, "You moved too far from the vehicle!");
		StopFilling(playerid);
		return 1;
	}
	
	// Validasi: Uang cukup
	if(GetPlayerMoney(playerid) < GStationPrice)
	{
		Error(playerid, "Not enough money to continue filling!");
		StopFilling(playerid);
		return 1;
	}
	
	// Validasi: Engine masih mati
	if(GetEngineStatus(vehid))
	{
		Error(playerid, "Vehicle engine is on! Filling stopped for safety.");
		StopFilling(playerid);
		return 1;
	}
	
	// Validasi: Stock gas station
	if(gsData[gsid][gsStock] < 10)
	{
		Error(playerid, "Gas station is out of stock!");
		StopFilling(playerid);
		return 1;
	}
	
	// Get current fuel
	new Float:currentFuel = GetVehicleFuel(vehid);
	
	// Hitung progress berdasarkan fuel (0-1000 = 0-100%)
	new Float:progress = (currentFuel / 1000.0) * 100.0;
	
	// Update progress bar
	if(progress < 100.0)
	{
		pData[playerid][pActivityTime] = floatround(progress);
		SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], pData[playerid][pActivityTime]);
		
		// Proses isi bensin
		new Float:newfuel = currentFuel + 50.0; // +50 liter per detik
		
		// Cek jika sudah penuh atau akan penuh
		if(newfuel >= 1000.0)
		{
			newfuel = 1000.0;
			SetVehicleFuel(vehid, floatround(newfuel));
			pData[playerid][pFillPrice] += GStationPrice;
			gsData[gsid][gsStock] -= 10;
			
			// Set progress ke 100
			pData[playerid][pActivityTime] = 100;
			SetPlayerProgressBarValue(playerid, pData[playerid][activitybar], 100);
			
			// Auto stop karena penuh
			InfoTD_MSG(playerid, 8000, "Tank is full!");
			StopFilling(playerid);
			return 1;
		}
		
		// Update fuel, price, dan stock
		SetVehicleFuel(vehid, floatround(newfuel));
		pData[playerid][pFillPrice] += GStationPrice;
		gsData[gsid][gsStock] -= 10;
	}
	else
	{
		// Progress sudah 100%, stop filling
		InfoTD_MSG(playerid, 8000, "Tank is full!");
		StopFilling(playerid);
	}
	
	return 1;
}

StopFilling(playerid)
{
	if(pData[playerid][pFill] == -1) return 0;
	
	new gsid = pData[playerid][pFill];
	
	// Bayar
	if(pData[playerid][pFillPrice] > 0)
	{
		GivePlayerMoneyEx(playerid, -pData[playerid][pFillPrice]);
		//gsData[gsid][gsMoney] += pData[playerid][pFillPrice];
		Info(playerid, "Vehicle tank is full! You paid "GREEN_E"$%s "WHITE_E"for fuel.", FormatMoney(pData[playerid][pFillPrice]));
	}
	else
	{
		Info(playerid, "Refueling cancelled.");
	}
	
	// Stop animasi dan hapus object
	ClearAnimations(playerid);
	RemovePlayerAttachedObject(playerid, 9);
	
	// Refresh gas station
	GStation_Refresh(gsid);
	
	// Reset data
	KillTimer(pData[playerid][pFillTime]);
	pData[playerid][pFillPrice] = 0;
	pData[playerid][pFill] = -1;
	pData[playerid][pFillVeh] = INVALID_VEHICLE_ID;
	pData[playerid][pActivityTime] = 0;
	
	// Hide progress bar dan textdraw
	HidePlayerProgressBar(playerid, pData[playerid][activitybar]);
	PlayerTextDrawHide(playerid, ActiveTD[playerid]);
	
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s puts back the fuel nozzle and finishes refueling.", ReturnName(playerid));
	return 1;
}
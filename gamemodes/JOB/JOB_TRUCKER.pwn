CreateJoinTruckPoint()
{
	//JOBS
	new strings[128];
	CreateDynamicPickup(1239, 23, -77.38, -1136.52, 1.07, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[TRUCKER JOBS]\n{ffffff}Jadilah Pekerja Trucker disini\n{7fffd4}/takejob /accept job");
	CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -77.38, -1136.52, 1.07, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // truck
}

//Sistem Trucker level
/*CheckTruckerLevelUp(playerid) {
    // Level maksimal
    if(pData[playerid][pTruckerLevel] >= 10) return 0;

    // Definisikan exp yang dibutuhkan untuk setiap level
    new levelUpExp[6] = {
        0,      // Level 0 (tidak digunakan)
        10,    // Level 1 -> Level 2
        20,    // Level 2 -> Level 3
        35,    // Level 3 -> Level 4
        50,   // Level 4 -> Level 5
        100   // Level 5 max
    };

    // Pastikan level minimal 1
    if(pData[playerid][pTruckerLevel] < 1) {
        pData[playerid][pTruckerLevel] = 1;
    }

    // Cek apakah bisa naik level
    while(pData[playerid][pTruckerLevelup] >= levelUpExp[pData[playerid][pTruckerLevel] + 1] 
          && pData[playerid][pTruckerLevel] < 5) {
        
        // Kurangi exp yang digunakan untuk level up
        pData[playerid][pTruckerLevelup] -= levelUpExp[pData[playerid][pTruckerLevel] + 1];
        
        // Naikkan level
        pData[playerid][pTruckerLevel]++;

    }

    return 1;
}
*/
//Mission
GetRestockDealer()
{
	new tmpcount;
	foreach(new id : Dealer)
	{
	    if(dsData[id][dRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockDealerID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_DEALER) return -1;
	foreach(new id : Dealer)
	{
	    if(dsData[id][dRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

GetRestockBisnis()
{
	new tmpcount;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockBisnisID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_BISNIS) return -1;
	foreach(new id : Bisnis)
	{
	    if(bData[id][bRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Hauling
GetRestockGStation()
{
	new tmpcount;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockGStationID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_GSTATION) return -1;
	foreach(new id : GStation)
	{
	    if(gsData[id][gsStock] < 7000)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

//Vending Restock
GetRestockVending()
{
	new tmpcount;
	foreach(new id : Vendings)
	{
	    if(VendingData[id][vendingRestock] == 1)
	    {
     		tmpcount++;
		}
	}
	return tmpcount;
}

ReturnRestockVendingID(slot)
{
	new tmpcount;
	if(slot < 1 && slot > MAX_VENDING) return -1;
	foreach(new id : Bisnis)
	{
	    if(VendingData[id][vendingRestock] == 1)
	    {
     		tmpcount++;
       		if(tmpcount == slot)
       		{
        		return id;
  			}
	    }
	}
	return -1;
}

CMD:lvltrucker(playerid, params[]) 
{
    new str[128];
    format(str, sizeof(str), 
        "Level Trucker: %d | Exp: %d", 
        pData[playerid][pTruckerLevel], 
        pData[playerid][pTruckerLevelup]
    );
    
    SendClientMessage(playerid, COLOR_ARWIN, str);
    return 1;
}

CMD:mission(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new string[512];
	    string =  "List Cargo\tVehicle Used\n";
	    format(string, sizeof(string), "%sRestock Business\tMule, Yankee, Benson, Boxville\n", string);
	    format(string, sizeof(string), "%sRestock Gas Station\tRoadtrain, Linerunner, Petrol\n", string);
		format(string, sizeof(string), "%sRestock Vending Machine\tMule, Yankee, Benson, Boxville\n", string);
		format(string, sizeof(string), "%sRestock Dealership\tRoadtrain, Linerunner, Petrol\n", string);
		format(string, sizeof(string), "%sCargo Industry\tMule, Yankee, Benson, Boxville\n", string);
		ShowPlayerDialog(playerid, DIALOG_MENU_TRUCKER, DIALOG_STYLE_TABLIST_HEADERS, "Menu Trucker", string, "Select","Cancel");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:mymission(playerid, params[])
{
	//new vehicleid = GetPlayerVehicleID(playerid);
	
	// Check for Business Mission
	if(pData[playerid][pMission] > -1)
	{
		new id = pData[playerid][pMission];
		
		//if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || !IsATruck(vehicleid))
			//return Error(playerid, "You must be driving a truck to view mission info.");
		
		new line[900];
		new type[128];
		new Float:distance;
		
		if(bData[id][bType] == 1)
		{
			type = "Fast Food";
		}
		else if(bData[id][bType] == 2)
		{
			type = "Market";
		}
		else if(bData[id][bType] == 3)
		{
			type = "Clothes";
		}
		else if(bData[id][bType] == 4)
		{
			type = "Equipment";
		}
		else if(bData[id][bType] == 5)
		{
			type = "Electronics";
		}
		else
		{
			type = "Unknown";
		}
		
		// Calculate distance to business location
		distance = GetPlayerDistanceFromPoint(playerid, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ]);
		
		format(line, sizeof(line), "{FFFFFF}Active Business Restock Mission:\n\nBusiness ID: {00FF00}%d\n{FFFFFF}Business Owner: {FFFF00}%s\n{FFFFFF}Business Name: {00FFFF}%s\n{FFFFFF}Business Type: {FF6347}%s\n{FFFFFF}Distance to Checkpoint: {00FF00}%.2f meters\n\n{FFFFFF}Follow the red checkpoint to complete your mission!\n{FFD700}Tip: {FFFFFF}Make sure you have purchased products from the warehouse first.", id, bData[id][bOwner], bData[id][bName], type, distance);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "My Mission Info", line, "Close", "");
		
		// Re-set checkpoint to make sure it's visible
		SetPlayerRaceCheckpoint(playerid, 1, bData[id][bExtposX], bData[id][bExtposY], bData[id][bExtposZ], 0.0, 0.0, 0.0, 3.5);
		
		return 1;
	}
	// Check for Gas Station Hauling
	else if(pData[playerid][pHauling] > -1)
	{
		new id = pData[playerid][pHauling];
		
		//if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER || !IsAHaulTruck(vehicleid))
			//return Error(playerid, "You must be driving a hauling truck to view hauling info.");
		
		new line[900];
		new Float:distance;
		
		// Calculate distance to gas station location
		distance = GetPlayerDistanceFromPoint(playerid, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]);
		
		format(line, sizeof(line), "{FFFFFF}Active Gas Station Hauling Mission:\n\nGas Station ID: {00FF00}%d\n{FFFFFF}Location: {FFFF00}%s\n{FFFFFF}Distance to Checkpoint: {00FF00}%.2f meters\n\n{FFFFFF}Follow the red checkpoint and deliver the gas oil trailer!\n{FFD700}Tip: {FFFFFF}Make sure your trailer is attached to your truck.", id, GetLocation(gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]), distance);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "My Hauling Info", line, "Close", "");
		
		// Re-set checkpoint to gas station location
		SetPlayerRaceCheckpoint(playerid, 1, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ], 0.0, 0.0, 0.0, 3.5);
		
		return 1;
	}
	// Check for Dealer Hauling
	else if(pData[playerid][pDealerHauling] > -1)
	{
		new id = pData[playerid][pDealerHauling];
		
		new line[900];
		new Float:distance;
		
		// Calculate distance to dealer location
		distance = GetPlayerDistanceFromPoint(playerid, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]);

		format(line, sizeof(line), "{FFFFFF}Active Dealer Hauling Mission:\n\nDealer ID: {00FF00}%d\n{FFFFFF}Dealer Owner: {FFFF00}%s\n{FFFFFF}Dealer Name: {00FFFF}%s\n{FFFFFF}Location: {FFFF00}%s\n{FFFFFF}Distance to Checkpoint: {00FF00}%.2f meters\n\n{FFFFFF}Follow the red checkpoint and deliver the vehicle trailer!\n{FFD700}Tip: {FFFFFF}Make sure your trailer is attached to your truck.", id, dsData[id][dOwner], dsData[id][dName], GetLocation(dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]), distance);
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "My Hauling Info", line, "Close", "");
		
		// Re-set checkpoint to dealer location
		SetPlayerRaceCheckpoint(playerid, 1, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ], 0.0, 0.0, 0.0, 3.5);
		
		return 1;
	}
	else
	{
		return Error(playerid, "You don't have an active mission or hauling job.");
	}
}

CMD:storeproduct(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new bid = pData[playerid][pMission], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(bid == -1) return Error(playerid, "You dont have mission.");
		if(IsPlayerInRangeOfPoint(playerid, 4.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsATruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(VehProduct[vehicleid] < 1) return Error(playerid, "Product is empty in this vehicle.");
			total = VehProduct[vehicleid] * ProductPrice;
			percent = (total / 100) * 50;
			convert = floatround(percent, floatround_floor);
			pay = total + convert;
			bData[bid][bProd] += VehProduct[vehicleid];
			bData[bid][bMoney] -= pay;
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Trucker (Product)", pay);
			if((carid = Vehicle_Nearest(playerid)) != -1)
			{
				pvData[carid][cProduct] = 0;
				Info(playerid, "Anda mendapatkan uang 50 percent dari hasil stock product anda.");
			}
			VehProduct[vehicleid] = 0;
			pData[playerid][pMission] = -1;
			pData[playerid][pJobTime] = 500;
		}
		else return Error(playerid, "Anda harus berada didekat dengan bisnis mission anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storedealer(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new id = pData[playerid][pDealerHauling], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(id == -1) return Error(playerid, "You dont have hauling.");
		if(IsPlayerInRangeOfPoint(playerid, 5.5, dsData[id][dPX], dsData[id][dPY], dsData[id][dPZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAHaulTruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return Error(playerid, "Your Vehicle Trailer is not even attached");
			DetachTrailerFromVehicle(vehicleid);

			if(VehProduct[vehicleid] < 1) return Error(playerid, "Product is empty in this vehicle.");
			DestroyVehicle(GetVehicleTrailer(vehicleid));
			pData[playerid][pTrailer] = INVALID_VEHICLE_ID;

			total = VehProduct[vehicleid] * ProductPrice;
			percent = (total / 100) * 50;
			convert = floatround(percent, floatround_floor);
			pay = total + convert;
			dsData[id][dProduct] += VehProduct[vehicleid];
			dsData[id][dMoney] -= pay;

			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"item product dengan seharga "GREEN_E"%s", VehProduct[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Trucker (Hauling)", pay);
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				pvData[carid][cProduct] = 0;
				Info(playerid, "Anda mendapatkan uang 50 percent dari hasil stock product anda.");
			}
			VehProduct[vehicleid] = 0;
			pData[playerid][pDealerHauling] = -1;
			pData[playerid][pJobTime] = 2000;
			Dealer_Refresh(id);
			Dealer_Save(id);
		}
		else return Error(playerid, "Anda harus berada didekat dengan Dealer hauling anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storegas(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new id = pData[playerid][pHauling], vehicleid = GetPlayerVehicleID(playerid), carid = -1, total, Float:percent, pay, convert;
		if(id == -1) return Error(playerid, "You dont have hauling.");
		if(IsPlayerInRangeOfPoint(playerid, 5.5, gsData[id][gsPosX], gsData[id][gsPosY], gsData[id][gsPosZ]))
		{
			if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER && !IsAHaulTruck(vehicleid)) return Error(playerid, "Anda harus mengendarai truck.");
			if(!IsTrailerAttachedToVehicle(vehicleid)) return Error(playerid, "Your Vehicle Trailer is not even attached");
			DetachTrailerFromVehicle(vehicleid);

			if(VehGasOil[vehicleid] < 1) return Error(playerid, "GasOil is empty in this vehicle.");
			DestroyVehicle(GetVehicleTrailer(vehicleid));
			pData[playerid][pTrailer] = INVALID_VEHICLE_ID;

			total = VehGasOil[vehicleid] * GasOilPrice;
			percent = (total / 100) * 55;
			convert = floatround(percent, floatround_ceil);
			pay = total + convert;
			gsData[id][gsStock] += VehGasOil[vehicleid];
			Server_MinMoney(pay);
			Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"liters gas oil dengan seharga "GREEN_E"%s", VehGasOil[vehicleid], FormatMoney(pay));
			AddPlayerSalary(playerid, "Trucker (Hauling)", pay);
			if((carid = Vehicle_Nearest2(playerid)) != -1)
			{
				pvData[carid][cGasOil] = 0;
				Info(playerid, "Anda mendapatkan uang 55 percent dari hasil stock liters gas oil anda.");
			}
			DisableVehicleSpeedCap(vehicleid);
			VehGasOil[vehicleid] = 0;
			pData[playerid][pHauling] = -1;
			pData[playerid][pJobTime] = 2000;
			GStation_Refresh(id);
			GStation_Save(id);
		}
		else return Error(playerid, "Anda harus berada didekat dengan gas oil hauling anda.");
	}
	else return Error(playerid, "You are not trucker job.");
	return 1;
}

CMD:storecrate(playerid, params[])
{
    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
        return Error(playerid, "You are not trucker job.");

    // Cek lokasi store fish (tanpa bool: karena IsPlayerInRangeOfPoint udah return bool)
    if(IsPlayerInRangeOfPoint(playerid, 3.0, -377.0572, -1445.5399, 25.7266))
    {
        // Store Fish
        if(pData[playerid][pCrateFish] > 0)
        {
            new total = pData[playerid][pCrateFish]; // Total raw fish (20)
            new totalPrice = total * FishPrice; // Harga total ke server
            new salary = floatround(totalPrice * 0.4); // Player dapat 60% aja

            // Tambahkan ke food stock
            Food += total;

            // Tambahkan uang ke server (40% sisanya masuk server)
            Server_MinMoney(salary);

            new crateAmount = total / 20; // Hitung berapa crate
            Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"crate fish (%d kg) dan mendapat gaji "GREEN_E"%s", crateAmount, total, FormatMoney(salary));

            AddPlayerSalary(playerid, "Trucker", salary);

            // Reset crate
            pData[playerid][pCrateFish] = 0;

            // Hapus objek crate
            RemovePlayerAttachedObject(playerid, 9);
            ClearAnimations(playerid);

            // Set cooldown
            pData[playerid][pJobTime] = 900;

            return 1;
        }
        else if(pData[playerid][pCrateComponent] > 0)
        {
            return Error(playerid, "You cannot store component crate here. Go to component store.");
        }
        else
        {
            return Error(playerid, "You don't have any fish crate to store.");
        }
    }

    // Cek lokasi store component
    if(IsPlayerInRangeOfPoint(playerid, 3.0, 797.5262, -617.7863, 16.3359))
    {
        // Store Component
        if(pData[playerid][pCrateComponent] > 0)
        {
            new total = pData[playerid][pCrateComponent]; // Total raw component (20)
            new totalPrice = total * ComponentPrice; // Harga total ke server
            new salary = floatround(totalPrice * 0.4); // Player dapat 60% aja

            // Tambahkan ke component stock
            Component += total;

            // Tambahkan uang ke server (40% sisanya masuk server)
            Server_MinMoney(salary);

            new crateAmount = total / 20; // Hitung berapa crate
            Info(playerid, "Anda menjual "RED_E"%d "WHITE_E"crate component (%d pcs) dan mendapat gaji "GREEN_E"%s", crateAmount, total, FormatMoney(salary));

            AddPlayerSalary(playerid, "Trucker", salary);

            // Reset crate
            pData[playerid][pCrateComponent] = 0;

            // Hapus objek crate
            RemovePlayerAttachedObject(playerid, 9);
            ClearAnimations(playerid);

            // Set cooldown
            pData[playerid][pJobTime] = 900;

            return 1;
        }
        else if(pData[playerid][pCrateFish] > 0)
        {
            return Error(playerid, "You cannot store fish crate here. Go to fish store.");
        }
        else
        {
            return Error(playerid, "You don't have any component crate to store.");
        }
    }

    return Error(playerid, "You must be at fish store or component store location.");
}

CMD:takecrate(playerid, params[])
{
    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
        return Error(playerid, "Anda bukan pekerja trucker.");

    if(pData[playerid][pJobTime] > 0)
        return Error(playerid, "You must wait %d seconds to perform this action.", pData[playerid][pJobTime]);

    if(pData[playerid][pCrateFish] > 0 || pData[playerid][pCrateComponent] > 0)
        return Error(playerid, "Anda masih membawa crate.");

    // Lokasi Fish Crate
    if(IsPlayerInRangeOfPoint(playerid, 3.5, 2836.5061, -1540.5342, 11.0991))
    {
        new totalfish = 20;

        if(RawFish < totalfish)
            return Error(playerid, "Stok fish tidak mencukupi.");


        // Ambil crate fish
        pData[playerid][pCrateFish] = totalfish;
        RawFish -= totalfish;

        // Pastikan slot object kosong
        if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
            RemovePlayerAttachedObject(playerid, 9);

        SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.0, 0.45, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0);
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);

        //Info(playerid, "Anda mengambil 1 Crate Fish (20 kg). Antar ke Fish Store untuk mendapat gaji.");
        return 1;
    }

    // Lokasi Component Crate (ganti koordinat sesuai kebutuhan)
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 323.5624, 904.4940, 21.5862))
    {
        new totalcomp = 20;

        if(RawComponent < totalcomp)
            return Error(playerid, "Stok component tidak mencukupi.");

        // Ambil crate component
        pData[playerid][pCrateComponent] = totalcomp;
        RawComponent -= totalcomp;

        // Pastikan slot object kosong
        if(IsPlayerAttachedObjectSlotUsed(playerid, 9))
            RemovePlayerAttachedObject(playerid, 9);

        SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.0, 0.45, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0);
        ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);

        //Info(playerid, "Anda mengambil 1 Crate Component (20 pcs). Antar ke Component Store untuk mendapat gaji.");
        return 1;
    }

    return Error(playerid, "Anda tidak berada di lokasi pengambilan crate.");
}

CMD:loadcrate(playerid, params[])
{
    new vehicleid = GetNearestVehicleToPlayer(playerid, 5.5, false);

    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
        return Error(playerid, "You are not trucker job.");

    if(vehicleid == INVALID_VEHICLE_ID) 
        return Error(playerid, "You are not near any vehicles.");

    // FIXED: Tambah definisi modelid
    new modelid = GetVehicleModel(vehicleid);
    if(modelid != 414 && modelid != 456 && modelid != 499 && modelid != 498)
        return Error(playerid, "You're not near a trucker car.");

    new carid = Vehicle_Nearest(playerid);
    if(carid == -1 || !IsValidVehicle(pvData[carid][cVeh]))
        return Error(playerid, "You're not near a valid player-owned vehicle.");

    new fishToLoad = pData[playerid][pCrateFish];
    new compToLoad = pData[playerid][pCrateComponent];

    if(fishToLoad <= 0 && compToLoad <= 0)
        return Error(playerid, "You don't have any crates to load.");

    new maxCrates = 10 * 20;
    new totalInVehicle = pvData[carid][cFish] + pvData[carid][cComponent];
    
    if(totalInVehicle >= maxCrates)
        return Error(playerid, "The vehicle is already full (Max: 10 crates).");

    if(fishToLoad > 0 && pvData[carid][cComponent] > 0)
        return Error(playerid, "You can't load fish crate. The vehicle already contains component crates.");
    if(compToLoad > 0 && pvData[carid][cFish] > 0)
        return Error(playerid, "You can't load component crate. The vehicle already contains fish crates.");

    new spacesLeft = maxCrates - totalInVehicle;
    
    if(fishToLoad > 0)
    {
        new amountToLoad = (fishToLoad > spacesLeft) ? spacesLeft : fishToLoad;
        pvData[carid][cFish] += amountToLoad;
        pData[playerid][pCrateFish] -= amountToLoad;
        
        UpdateVehicleCrateLabel(carid);
        
        new cratesLoaded = amountToLoad / 20;
        SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've loaded %d fish crate(s) into the vehicle.", cratesLoaded);
    }

    if(compToLoad > 0)
    {
        new amountToLoad = (compToLoad > spacesLeft) ? spacesLeft : compToLoad;
        pvData[carid][cComponent] += amountToLoad;
        pData[playerid][pCrateComponent] -= amountToLoad;
        
        UpdateVehicleCrateLabel(carid);
        
        new cratesLoaded = amountToLoad / 20;
        SendClientMessageEx(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've loaded %d component crate(s) into the vehicle.", cratesLoaded);
    }

    if(pData[playerid][pCrateFish] == 0 && pData[playerid][pCrateComponent] == 0)
    {
        RemovePlayerAttachedObject(playerid, 9);
        ClearAnimations(playerid);
    }

    return 1;
}

CMD:unloadcrate(playerid, params[])
{
    new vehicleid = GetNearestVehicleToPlayer(playerid, 5.5, false);

    if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
        return Error(playerid, "You are not trucker job.");

    if(vehicleid == INVALID_VEHICLE_ID) 
        return Error(playerid, "You are not near any vehicles.");

    new carid = Vehicle_Nearest(playerid);
    if(carid == -1 || !IsValidVehicle(pvData[carid][cVeh]))
        return Error(playerid, "You're not near a valid player-owned vehicle.");

    if(pData[playerid][pCrateFish] > 0 || pData[playerid][pCrateComponent] > 0)
        return Error(playerid, "You are already carrying a crate. Load it into the vehicle first.");

    new fishToUnload = pvData[carid][cFish];
    new compToUnload = pvData[carid][cComponent];

    if(fishToUnload <= 0 && compToUnload <= 0)
        return Error(playerid, "There are no crates to unload from this vehicle.");

    if(fishToUnload > 0)
    {
        pvData[carid][cFish] = 0;
        pData[playerid][pCrateFish] = fishToUnload;
        SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've unloaded fish crate from the vehicle.");
    }

    if(compToUnload > 0)
    {
        pvData[carid][cComponent] = 0;
        pData[playerid][pCrateComponent] = compToUnload;
        SendClientMessage(playerid, COLOR_ARWIN, "JOB: "WHITE_E"You've unloaded component crate from the vehicle.");
    }
	if(pvData[carid][cFish] == 0 && pvData[carid][cComponent] == 0)
	{
		if(IsValidDynamic3DTextLabel(pvData[carid][cTextLabel]))
		{
			DestroyDynamic3DTextLabel(pvData[carid][cTextLabel]);
			pvData[carid][cTextLabel] = Text3D:INVALID_3DTEXT_ID;
		}
	}
	else
	{
		UpdateVehicleCrateLabel(carid);
	}
    SetPlayerAttachedObject(playerid, 9, 2912, 1, 0.0, 0.45, 0.0, 0.0, 90.0, 0.0, 1.0, 1.0, 1.0);
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.1, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:cargo(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
		if(isnull(params)) return Usage(playerid, "/cargo [buy/sell/list/load/unload/pickup]");
		
		if(!strcmp(params, "buy", true))
		{
			new rego = ProductPrice*15;
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, -50.61, -233.28, 6.76))
				return Error(playerid, "Kamu tidak berada di pembelian box");
			if(pData[playerid][CarryingBox] == true)
				return Error(playerid, "Kamu masih membawa box product!");
			if(GetPlayerMoney(playerid) < rego)
				return Error(playerid, "Uangmu tidak cukup untuk membeli box seharga %s", FormatMoney(rego));

			Player_GiveBox(playerid);
			Product -= 15;
			Server_AddMoney(rego);
            Servers(playerid,"Kamu berhasil membeli box {ffff00}vending product {ffffff}seharga %s", FormatMoney(rego));
        	
		}
		else if(!strcmp(params, "sell", true))
		{
			new vid = pData[playerid][pInVending], total, Float:percent, pay, convert;
			if(IsPlayerInRangeOfPoint(playerid, 5.0, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]))
			{
				if(!strcmp(VendingData[vid][vendingOwner], "-") || VendingData[vid][vendingOwnerID] == 0) 
					return Error(playerid, "Vending ini masih belum mempunyai pemilik");
				if(VendingData[vid][vendingStock] > 75) 
					return Error(playerid, "Vending ini masih punya cukup stock");
				if(pData[playerid][CarryingBox] == false)
					return Error(playerid, "Kamu tidak membawa box product!");

				total = 15 * ProductPrice;
				percent = (total / 100) * 50;
				convert = floatround(percent, floatround_floor);
				pay = total + convert;
				VendingData[vid][vendingStock] += 15;
				VendingData[vid][vendingMoney] -= pay;
				
				Vending_Save(vid);
				Vending_RefreshText(vid);

				ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0 ,0,0,0,0,1);
				Player_RemoveBox(playerid);
				GivePlayerMoneyEx(playerid, pay);
				pData[playerid][pVendingRestock] = -1;
				Info(playerid, "Anda mendapatkan uang 50 percent dari hasil vending restock anda senilai "GREEN_E"%s.", FormatMoney(pay));
			}	
			else return Error(playerid, "Anda harus berada didekat dengan vending mission anda.");
		}
		else if(!strcmp(params, "list", true))
		{
			new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);
			if(!IsValidVehicle(vehicleid)) return Error(playerid, "You're not near any vehicle.");
			if(!IsATruck(vehicleid)) return Error(playerid, "Vehicle isn't a mining vehicle.");
			new string[196], title[32], type[64];//, harga;
			format(string, sizeof(string), "Type\tAmount\n");
			for(new i; i < 2; i++)
			{
				if(BoxData[i][boxType] == 0)
				{
					type = "Product Vending";
				}
				if(BoxData[i][boxType] == 1)
				{
					type = "Product Business";
				}
				else
				{
					type = "Unknown";
				}
				format(string, sizeof(string), "%s%s\t{2ECC71}%d Box\n", string, type, Vehicle_BoxCount(vehicleid));
			}
			format(title, sizeof(title), "Cargo List {E74C3C}(%d/%d)", Vehicle_BoxCount(vehicleid), BOX_LIMIT);
			ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, title, string, "Close", "");
		}
		else if(!strcmp(params, "load", true))
		{
			new carid = -1;
			if(!pData[playerid][CarryingBox]) return Error(playerid, "You're not carrying a Box.");
			if(IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus keluar dari kendaraan.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 4.5, false);
			if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
			if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
			if(GetTrunkStatus(vehicleid))
			{
				if(Vehicle_BoxCount(vehicleid) >= BOX_LIMIT) return Error(playerid, "You can't load any more logs to this vehicle.");
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					if(IsValidVehicle(pvData[carid][cVeh]))
					{
						pvData[carid][cBox]++;
					}
					BoxStorage[vehicleid][ pData[playerid][CarryingBox] ]++;
				}
				Player_RemoveBox(playerid);
				Info(playerid, "Loaded a box.");
			} 
			else Error(playerid, "Kamu belum membuka trunk kendaraan");	
		}
		else if(!strcmp(params, "unload", true))
		{
			new carid = -1;
			if(pData[playerid][CarryingBox]) return Error(playerid, "You're already carrying a box.");
			new vehicleid = GetNearestVehicleToPlayer(playerid, 4.5, false);		
			if(vehicleid == INVALID_VEHICLE_ID) return Error(playerid, "You not in near any vehicles.");
			if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
			if(GetTrunkStatus(vehicleid))
			{
				if(Vehicle_BoxCount(vehicleid) < 1) return Error(playerid, "This vehicle doesn't have any Boxs.");
				if((carid = Vehicle_Nearest(playerid)) != -1)
				{
					if(IsValidVehicle(pvData[carid][cVeh]))
					{
						pvData[carid][cBox]--;
					}
					BoxStorage[vehicleid][ pData[playerid][CarryingBox] ]--;
				}
				Player_GiveBox(playerid);
				Info(playerid, "You've taken a box from the car.");
			}	
			else Error(playerid, "Kamu belum membuka trunk kendaraan");
		}
		else if(!strcmp(params, "pickup", true))
		{
			if(pData[playerid][CarryingBox]) return Error(playerid, "You're already carrying a Box.");
			new tid = GetClosestBox(playerid);
			if(tid == -1) return Error(playerid, "You're not near a Box.");
			BoxData[tid][boxSeconds] = 1;
			RemoveBox(tid);
			
			Player_GiveBox(playerid);
			Info(playerid, "You've taken a Box from ground.");
		}
	}	
	else return Error(playerid, "Kamu bukan Trucker!");
	return 1;
}

Player_GiveBox(playerid)
{
    if(!IsPlayerConnected(playerid)) return 0;
	pData[playerid][CarryingBox] = true;
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	SetPlayerAttachedObject(playerid, 9, 1271, 1, 0.002953, 0.469660, -0.009797, 269.851104, 34.443557, 0.000000, 0.804894, 1.000000, 0.822361 );
	Info(playerid, "You can press "GREEN_E"N "WHITE_E"to drop your box.");
	return 1;
}

Player_RemoveBox(playerid)
{
	if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingBox]) return 0;
	ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
	RemovePlayerAttachedObject(playerid, 9);
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	pData[playerid][CarryingBox] = false;
	return 1;
}

Player_DropBox(playerid, death_drop = 0)
{
    if(!IsPlayerConnected(playerid) || !pData[playerid][CarryingBox]) return 0;
    new id = Iter_Free(Boxs);
    if(id != -1)
    {
        new Float: x, Float: y, Float: z, Float: a, label[128];
        GetPlayerPos(playerid, x, y, z);
        GetPlayerFacingAngle(playerid, a);
        GetPlayerName(playerid, BoxData[id][boxDroppedBy], MAX_PLAYER_NAME);

		if(!death_drop)
		{
		    x += (1.0 * floatsin(-a, degrees));
			y += (1.0 * floatcos(-a, degrees));
			
			ApplyAnimation(playerid, "CARRY", "putdwn05", 4.1, 0, 1, 1, 0, 0, 1);
		}

		BoxData[id][boxSeconds] = BOX_LIFETIME;
		BoxData[id][boxObjID] = CreateDynamicObject(1271, x, y, z - 0.4, 0.0, 0.0, a);
		
		format(label, sizeof(label), "Box (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /cargo pickup.", id, BoxData[id][boxDroppedBy], ConvertToMinutes(BOX_LIFETIME));
		BoxData[id][boxLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, x, y, z - 0.2, 5.0, .testlos = 1);
		
		BoxData[id][boxTimer] = SetTimerEx("RemoveBox", 1000, true, "i", id);
		Iter_Add(Boxs, id);
    }
    
    Player_RemoveBox(playerid);
	return 1;
}

Vehicle_BoxCount(vehicleid)
{
	//if(!IsValidVehicle(vehicleid)) return -1;
	new count = 0;
	for(new i; i < 2; i++) count += BoxStorage[vehicleid][i];
	return count;
}

GetClosestBox(playerid, Float: range = 3.0)
{
	new id = -1, Float: dist = range, Float: tempdist, Float: pos[3];
	foreach(new i : Boxs)
	{
	    GetDynamicObjectPos(BoxData[i][boxObjID], pos[0], pos[1], pos[2]);
	    tempdist = GetPlayerDistanceFromPoint(playerid, pos[0], pos[1], pos[2]);

	    if(tempdist > range) continue;
		if(tempdist <= dist)
		{
			dist = tempdist;
			id = i;
		}
	}

	return id;
}

function RemoveBox(tid)
{
	if(!Iter_Count(Boxs, tid)) return 1;
	
	if(BoxData[tid][boxSeconds] > 1) 
	{
	    BoxData[tid][boxSeconds]--;

        new label[128];
	    format(label, sizeof(label), "Box (%d)\n"WHITE_E"Dropped By "GREEN_E"%s\n"WHITE_E"%s\nUse /cargo pickup.", tid, BoxData[tid][boxDroppedBy], ConvertToMinutes(BoxData[tid][boxSeconds]));
		UpdateDynamic3DTextLabelText(BoxData[tid][boxLabel], COLOR_GREEN, label);
	}
	else if(BoxData[tid][boxSeconds] == 1) 
	{
	    KillTimer(BoxData[tid][boxTimer]);
	    DestroyDynamicObject(BoxData[tid][boxObjID]);
		DestroyDynamic3DTextLabel(BoxData[tid][boxLabel]);
		
	    BoxData[tid][boxTimer] = -1;
        BoxData[tid][boxObjID] = -1;
        BoxData[tid][boxLabel] = Text3D: -1;

		Iter_Remove(Boxs, tid);
	}
	
	return 1;
}

CMD:shipments(playerid, params[])
{
	if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
	{
		new vehicleid = GetNearestVehicleToPlayer(playerid, 5.0, false);
		if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda harus didalam kendaraan.");
		if(!IsATruck(vehicleid)) return Error(playerid, "You're not near a trucker car.");
		ShowPlayerDialog(playerid, DIALOG_SHIPMENTS, DIALOG_STYLE_LIST, "Shipments Menu", "Shipments Business\nShipments Vending", "Select", "Close");
		return 1;
	}
	else return Error(playerid, "Kamu bukan Trucker!");
}	
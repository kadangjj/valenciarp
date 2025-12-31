//-------------[ Player Commands ]-------------//
CMD:help(playerid, params[])
{
	new str[512], info[512];
	format(str, sizeof(str), "Account Commands\nGeneral Commands\nVehicle Commands\nJob Commands\nFaction Commands\nBusiness Commands\nHouse Commands\nWorkshop Commands\nVending Commands\nAuto RP\nDonate\nServer Credits\n");
	strcat(info, str);
	if(pData[playerid][pRobLeader] > 1 || pData[playerid][pMemberRob] > 1)
	{
		format(str, sizeof(str), "Robbery Help");
		strcat(info, str);	
	}
	ShowPlayerDialog(playerid, DIALOG_HELP, DIALOG_STYLE_LIST, "Valencia Help Menu", info, "Select", "Close");
	return 1;
}

CMD:fixcp(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pSideJob] > 1 || pData[playerid][pCP] > 1)
		return Error(playerid, "Harap selesaikan Pekerjaan mu terlebih dahulu");

	DisablePlayerCheckpoint(playerid);
	DisablePlayerRaceCheckpoint(playerid);
	Servers(playerid, "Menghapus Checkpoint Sukses");
	return 1;
}

CMD:credits(playerid)
{
    static const creditsText[] = \
    ""LB_E"Founder: "WHITE_E"Rama, nd0yy, kayzen767\n\
	"LB_E"Lead Developer: "WHITE_E"Redvelvet\n\
	"LB_E"Mapping Support: "WHITE_E"Kayzen767 & Tim Valencia\n\
	"LB_E"Web Support: "WHITE_E"Redvelvet\n\
	"LB_E"Server Administration: "WHITE_E"Tim Valencia\n\n\
	"LB_E"Special Thanks: "WHITE_E"%s & komunitas SAMP\n\n\
	"WHITE_E"2025 Valencia Roleplay - All Rights Reserved.";

    
    new finalText[sizeof(creditsText) + MAX_PLAYER_NAME];
    format(finalText, sizeof(finalText), creditsText, pData[playerid][pName]);
    
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Valencia Roleplay "WHITE_E"Server Credits", finalText, "OK", "");
    return 1;
}

CMD:vip(playerid)
{
	new longstr2[3500];
	format(longstr2, sizeof(longstr2),
    ""YELLOW_E"Looking for bonus features and commands? Get premium status today!\n\n"RED_E"Premium features:\n\
	"dot""GREEN_E"Bronze(1) "PINK_E"Rp.30.000/month"RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"20 "WHITE_E"VIP Gold.\n\
	"YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n\
	"YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.\n\
	"YELLOW_E"4) "WHITE_E"Mempunyai "LB_E"4 "WHITE_E"slot untuk kendaraan pribadi.\n\
	"YELLOW_E"5) "WHITE_E"Mempunyai "LB_E"2 "WHITE_E"Slot untuk rumah.\n\
	"YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"2 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".\n\
	"YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"5% "WHITE_E"lebih cepat.\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"10% "WHITE_E"bunga bank setiap kali paycheck.\n\n\
	"dot""YELLOW_E"Silver(2) "PINK_E"Rp.50,000/month "RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"30"WHITE_E" VIP Gold.\n\
	"YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n\
	"YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.\n\
	"YELLOW_E"4) "WHITE_E"Mempunyai "LB_E"5 "WHITE_E"slot untuk kendaraan pribadi.\n\
	"YELLOW_E"5) "WHITE_E"Mempunyai "LB_E"3 "WHITE_E"Slot untuk rumah.\n\
	"YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"3 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".\n\
	"YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"10% "WHITE_E"lebih cepat.\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"15% "WHITE_E"bunga bank setiap kali paycheck.\n\n\
	"dot""PURPLE_E"Diamond(3) "PINK_E"Rp.80,000/month "RED_E"|| "PINK_E"Features:\n\
	"YELLOW_E"1) "WHITE_E"Gratis "LB_E"40 "WHITE_E"VIP Gold.\n\
	"YELLOW_E"2) "WHITE_E"Mendapat "GREEN_E"2 "WHITE_E"slot job.\n\
	"YELLOW_E"3) "WHITE_E"Akses custom VIP room dan VIP locker.\n\
	"YELLOW_E"4) "WHITE_E"Mempunyai "LB_E"6 "WHITE_E"slot untuk kendaraan pribadi.\n\
	"YELLOW_E"5) "WHITE_E"Mempunyai "LB_E"4 "WHITE_E"Slot untuk rumah.\n\
	"YELLOW_E"6) "WHITE_E"Mempunyai "LB_E"4 "WHITE_E"slot untuk bisnis.\n\
	"YELLOW_E"7) "WHITE_E"Akses VIP chat dan VIP status "LB_E"/vips"WHITE_E".\n\
	"YELLOW_E"8) "WHITE_E"Waktu Paycheck/Payday "LB_E"15% "WHITE_E"lebih cepat.\n\
	"YELLOW_E"9) "WHITE_E"Mendapatkan "LB_E"20% "WHITE_E"bunga bank setiap kali paycheck.\n\n\
	"LB_E"Pembayaran Via Qris/Dana/BCA/BRI/Gopay. "LB2_E"Harga VIP Gold "LB_E"Rp.1,000/gold.\n\
	"YELLOW_E"Untuk informasi selengkapnya hubungi Redvelvet (Server Management & Founder)!"
	);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Valencia Roleplay "PINK_E"VIP SYSTEM", longstr2, "Close", "");

	return 1;
}

/*CMD:donate(playerid)
{
    new line3[3500];
    strcat(line3, ""RED_E"...:::... "DOOM_"Donate List Valencia Roleplay "RED_E"...:::...\n");
    strcat(line3, ""RED_E"..:.. "DOOM_"GOLD(OOC) "RED_E"..:..\n\n");

    strcat(line3, ""DOOM_"1. 250 Gold >> "RED_E"Rp 15.000\n");
    strcat(line3, ""DOOM_"2. 525 Gold >> "RED_E"Rp 25.000\n");
	strcat(line3, ""DOOM_"3. 1125 Gold >> "RED_E"Rp 50.000\n");
    strcat(line3, ""DOOM_"4. 2150 Gold >> "RED_E"Rp 100.000\n");
	strcat(line3, ""DOOM_"5. 3125 Gold >> "RED_E"Rp 150.000\n");
    strcat(line3, ""DOOM_"6. 4200 Gold >> "RED_E"Rp 200.000\n\n");

	strcat(line3, ""RED_E"..::.. "DOOM_"VIP PLAYER "RED_E"..::..\n\n");
	
    strcat(line3, ""DOOM_"1. VIP Regular(1 Month) >> "RED_E"500 Gold\n");
    strcat(line3, ""DOOM_"2. VIP Premium(1 Month) >> "RED_E"900 Gold\n");
    strcat(line3, ""DOOM_"3. VIP Platinum(1 Month) >> "RED_E"1200 Gold\n\n");

	strcat(line3, ""RED_E"..:::.. "DOOM_"SERVER FEATURE "RED_E"..:::..\n\n");
    strcat(line3, ""DOOM_"1. Mapping(per object) >> "RED_E"60 Gold\n");
	strcat(line3, ""DOOM_"2. Private Door >> "RED_E"100 Gold\n");
	strcat(line3, ""DOOM_"3. Private Gate >> "RED_E"200 Gold\n");
	strcat(line3, ""DOOM_"4. Bisnis >> "RED_E"(Tergantung Lokasi)\n");
	strcat(line3, ""DOOM_"5. House >> "RED_E"(Tergantung Lokasi dan Type)\n");
	strcat(line3, ""DOOM_"6. Custom House Interior >> "RED_E"(Tergantung Interior)\n\n");
	
	strcat(line3, ""RED_E"..::::.. "DOOM_"SERVER VEHICLE "RED_E"..:::::..\n\n");
    strcat(line3, ""DOOM_"1. VEHICLE IN DEALER >> "RED_E"1200 Gold\n");
	strcat(line3, ""DOOM_"2. VEHICLE NON DEALER >> "RED_E"1800 Gold\n");
	strcat(line3, ""DOOM_"3. BOAT / HELI >> "RED_E"2300 Gold\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"CONTACT INFO "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"1. NAMA : "RED_E"Adit (SugengGod)\n");
    strcat(line3, ""WHITE_E"-  WHATSAPP: "RED_E"+6281231845985\n\n");

    strcat(line3, ""RED_E"..::.. "WHITE_E"NOTE "RED_E"..::..\n");
    strcat(line3, ""WHITE_E"Note: "RED_E"Pembayaran Via PayPal, Gopay, Dana, OVO, Saweria, Pulsa Telkomsel!\n\n");

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, ""ORANGE_E"Valencia: "WHITE_E"DONATE LIST", line3, "Okay", "");
	return 1;
}*/

CMD:email(playerid)
{
    // Periksa status login
    if(!pData[playerid][IsLoggedIn])
        return Error(playerid, "Kamu harus login!");

    // Siapkan string dialog
    new longstr[512];
    format(longstr, sizeof(longstr), ""WHITE_E"Masukkan Email.\n"WHITE_E"Ini akan digunakan jika kamu lupa ganti kata sandi.\n\n"RED_E"* "WHITE_E"Email mu tidak akan termunculkan untuk Publik\n"RED_E"* "WHITE_E"Email hanya berguna untuk verifikasi Password yang terlupakan dan berita lainnya\n"RED_E"* "WHITE_E"Pastikan memasukkan alamat email yang valid!");

    // Tampilkan dialog
    ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, 
        "Change E-mail", 
        longstr, 
        "Enter", "Exit");

    return 1;
}

CMD:changepass(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "Kamu harus login sebelum menggantinya!");

	ShowPlayerDialog(playerid, DIALOG_PASSWORD, DIALOG_STYLE_INPUT, ""WHITE_E"Change your password", "Masukkan Password untuk menggantinya!", "Change", "Exit");
	InfoTD_MSG(playerid, 3000, "~g~~h~Masukkan password yang sebelum nya anda pakai!");
	return 1;
}

CMD:savestats(playerid, params[])
{
    // Cek apakah pemain yang memanggil perintah sedang mengikuti event
    if(IsAtEvent[playerid] == 1)
    {
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    }

    // Cek apakah pemain yang memanggil perintah sudah login
    if(pData[playerid][IsLoggedIn] == false)
    {
        return Error(playerid, "You are not logged in!");
    }

    // Simpan data untuk semua pemain
    for(new pid = 0; pid < MAX_PLAYERS; pid++)
    {
        // Pastikan pemain terhubung dan tidak dalam status event serta sudah login
        if(IsPlayerConnected(pid) && IsAtEvent[pid] == 0 && pData[pid][IsLoggedIn] == true)
        {
            UpdatePlayerData(pid); // Simpan data untuk pemain yang valid
        }
    }

    // Kirim pesan konfirmasi kepada pemain yang memanggil perintah
    SendClientMessage(playerid, COLOR_GREEN, "Statistik kamu telah berhasil disimpan ke dalam database!");

    return 1;
}


CMD:gshop(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new Dstring[512];
	format(Dstring, sizeof(Dstring), "Gold Shop\tPrice\n\
	Instant Change Name\t500 Gold\n");
	format(Dstring, sizeof(Dstring), "%sClear Warning\t1000 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 1(7 Days)\t150 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 2(7 Days)\t250 Gold\n", Dstring);
	format(Dstring, sizeof(Dstring), "%sVIP Level 3(7 Days)\t500 Gold\n", Dstring);
	ShowPlayerDialog(playerid, DIALOG_GOLDSHOP, DIALOG_STYLE_TABLIST_HEADERS, "Gold Shop", Dstring, "Buy", "Cancel");
	return 1;
}
CMD:mypos(playerid, params[])
{
	new int, Float:px,Float:py,Float:pz, Float:a;
	GetPlayerPos(playerid, px, py, pz);
	GetPlayerFacingAngle(playerid, a);
	int = GetPlayerInterior(playerid);
	new zone[MAX_ZONE_NAME];
	GetPlayer3DZone(playerid, zone, sizeof(zone));
	SendClientMessageEx(playerid, COLOR_WHITE, "Lokasi Anda Saat Ini: %s (%0.2f, %0.2f, %0.2f, %0.2f) Int = %d", zone, px, py, pz, a, int);
	return 1;
}

CMD:gps(playerid, params[])
{
	if(pData[playerid][pGPS] < 1) return Error(playerid, "Anda tidak memiliki GPS.");
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "GPS Menu", ""RED_E"Disable GPS\n"WHITE_E"Public Location\nPublic Property\nJobs\nMy Properties", "Select", "Close");
	return 1;
}

CMD:death(playerid, params[])
{
    if(pData[playerid][pInjured] == 0)
        return Error(playerid, "You're not injured.");
		
	if(pData[playerid][pJail] > 0)
		return Error(playerid, "This action is not available while you are in jail.");
		
	if(pData[playerid][pArrest] > 0)
		return Error(playerid, "This action is not available while you are under arrest.");

    if((gettime()-GetPVarInt(playerid, "GiveUptime")) < 100)
        return Error(playerid, "You must wait 3 minutes before returning to the hospital.");
        
	/*if(pMatiPukul[playerid] == 1)
	{
	    SetPlayerHealthEx(playerid, 50.0);
	    ClearAnimations(playerid);
	    pData[playerid][pInjured] = 0;
	    pMatiPukul[playerid] = 0;
    	Servers(playerid, "You have wake up and accepted death in your position.");
    	return 1;
	}*/
    Servers(playerid, "You have woken up from unconsciousness.");
	pData[playerid][pHospitalTime] = 0;
	pData[playerid][pHospital] = 1;
    return 1;
}

/*CMD:piss(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    if(pData[playerid][pInjured] == 1)
        return Error(playerid, "Kamu tidak bisa melakukan ini disaat yang tidak tepat!");
        
	new time = (100 - pData[playerid][pBladder]) * (300);
    SetTimerEx("UnfreezePee", time, 0, "i", playerid);
    SetPlayerSpecialAction(playerid, 68);
    return 1;
}*/

CMD:health(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new hstring[512], info[512];
	new hh = pData[playerid][pHead];
	new hp = pData[playerid][pPerut];
	new htk = pData[playerid][pRHand];
	new htka = pData[playerid][pLHand];
	new hkk = pData[playerid][pRFoot];
	new hkka = pData[playerid][pLFoot];
	format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
	strcat(info, hstring);
    format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
    strcat(info, hstring);
    ShowPlayerDialog(playerid, DIALOG_HEALTH, DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(pData[playerid][pInjured] == 1)
        return Error(playerid, "You cannot do this at an inappropriate time!");
	
	if(pData[playerid][pInHouse] == -1)
		return Error(playerid, "You are not inside a house.");
	
	InfoTD_MSG(playerid, 10000, "Sleeping... Please Wait");
	TogglePlayerControllable(playerid, 0);
	new time = (100 - pData[playerid][pEnergy]) * (400);
    SetTimerEx("UnfreezeSleep", time, 0, "i", playerid);
	switch(random(6))
	{
		case 0: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_L",4.1,0,0,0,1,1);
		case 1: ApplyAnimation(playerid, "INT_HOUSE", "BED_In_R",4.1,0,0,0,1,1);
		case 2: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_L",4.1,1,0,0,1,1);
		case 3: ApplyAnimation(playerid, "INT_HOUSE", "BED_Loop_R",4.1,1,0,0,1,1);
		case 4: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_L",4.1,0,1,1,0,0);
		case 5: ApplyAnimation(playerid, "INT_HOUSE", "BED_Out_R",4.1,0,1,1,0,0);
	}
	return 1;
}

/*CMD:salary(playerid, params[])
{
	new query[256], count;
	format(query, sizeof(query), "SELECT * FROM salary WHERE owner='%d'", pData[playerid][pID]);
	new Cache:result = mysql_query(g_SQL, query);
	new rows = cache_num_rows();
	if(rows) 
	{
		new str[2048];
		for(new i; i < rows; i++)
		{
			new info[64];
			cache_get_value_int(i, "id", pSalary[playerid][i][salaryId]);
			cache_get_value_int(i, "money", pSalary[playerid][i][salaryMoney]);
			cache_get_value(i, "info", info);
			format(pSalary[playerid][i][salaryInfo], 64, "%s", info);
			cache_get_value_int(i, "date", pSalary[playerid][i][salaryDate]);
			
			format(str, sizeof(str), "%s%s\t%s\t%s\n", str, ReturnDate(pSalary[playerid][i][salaryDate]), pSalary[playerid][i][salaryInfo], FormatMoney(pSalary[playerid][i][salaryMoney]));
			count++;
			if(count >= 10) break;
		}
		format(str, sizeof(str), "Date\tInfo\tCash\n", str);
		if(count >= 10)
		{
			format(str, sizeof(str), "%s\nNext >>>", str);
		}
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Salary Details", str, "Close", "");
	}
	else 
	{
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Notice", "Kamu tidak memiliki salary saat ini!", "Ok", "");
	}
	cache_delete(result);
	return 1;
}*/

CMD:dice(playerid, params[])
{
    new to_player, money;
    
    if(sscanf(params, "ud", to_player, money))
    {
        Usage(playerid, "Gunakan: /dice [id] [jumlah]");
        return 1;
    }

	money *= 100;
    
    if(to_player == INVALID_PLAYER_ID || !IsPlayerConnected(to_player) || to_player == playerid)
    {
        Error(playerid, "Invalid player.");
        return 1;
    }
    
    if(!NearPlayer(playerid, to_player, 5.0))
    {
        Error(playerid, "You must be near the player.");
        return 1;
    }
    
    if(money < 100 || money > 1000000) return Error(playerid, "You cannot dice more than $10,000.00 at once!");
    
    if(GetPlayerMoney(playerid) < money)
    {
        Error(playerid, "You do not have enough money.");
        return 1;
    }
    
    if(GetPlayerMoney(to_player) < money)
    {
        Error(playerid, "The other player does not have enough money.");
        return 1;
    }
    
    pData[to_player][pDiceOffer] = playerid;
    pData[to_player][pDiceMoney] = money;
    
    SendConfirmation(to_player, playerid, "drag", 0); // ✅ data = 0
    
    Info(playerid, "You have invited %s to play dice with a bet of %s", ReturnName(to_player), FormatMoney(money));
    return 1;
}

CMD:time(playerid)
{
    if(pData[playerid][IsLoggedIn] == false)
        return Error(playerid, "You must be logged in!");
    
    new line2[1500];
    
    // Hitung sisa waktu paycheck (dalam detik)
    new paycheck_remaining = 1800 - pData[playerid][pPaycheck];
    if(paycheck_remaining < 0) paycheck_remaining = 0;
    
    // Convert detik ke menit dan detik
    new pc_min = paycheck_remaining / 60;
    new pc_sec = paycheck_remaining % 60;
    
    // Hitung waktu untuk setiap delay
    new job_min = pData[playerid][pJobTime] / 60;
    new job_sec = pData[playerid][pJobTime] % 60;
    
    new sidejob_min = pData[playerid][pSideJobTime] / 60;
    new sidejob_sec = pData[playerid][pSideJobTime] % 60;
    
    new sweeper_min = pData[playerid][pSweeperTime] / 60;
    new sweeper_sec = pData[playerid][pSweeperTime] % 60;
    
    new forklift_min = pData[playerid][pForklifterTime] / 60;
    new forklift_sec = pData[playerid][pForklifterTime] % 60;
    
    new bus_min = pData[playerid][pBusTime] / 60;
    new bus_sec = pData[playerid][pBusTime] % 60;
    
    new mower_min = pData[playerid][pMowerTime] / 60;
    new mower_sec = pData[playerid][pMowerTime] % 60;
    
    new plant_min = pData[playerid][pPlantTime] / 60;
    new plant_sec = pData[playerid][pPlantTime] % 60;
    
    new arrest_min = pData[playerid][pArrestTime] / 60;
    new arrest_sec = pData[playerid][pArrestTime] % 60;
    
    new jail_min = pData[playerid][pJailTime] / 60;
    new jail_sec = pData[playerid][pJailTime] % 60;
    
    // FIXED: Langsung pakai countdown, bukan kurangi gettime()
    new claim_remaining = 0;
    new total_claiming = 0;
    foreach(new i : PVehicles)
    {
        if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 1)
        {
            if(pvData[i][cClaimTime] > 0) // Langsung cek countdown
            {
                if(claim_remaining == 0 || pvData[i][cClaimTime] < claim_remaining)
                    claim_remaining = pvData[i][cClaimTime]; // Ambil waktu tercepat
                total_claiming++;
            }
        }
    }
    
    new claim_min = claim_remaining / 60;
    new claim_sec = claim_remaining % 60;
    
    // Format string dengan waktu yang lebih akurat
    format(line2, sizeof(line2), "Informasi\tWaktu Tersisa\n\
        Paycheck\t"YELLOW_E"%02d:%02d\n\
        Delay Job\t{%s}%02d:%02d\n\
        Delay Side Job\t{%s}%02d:%02d\n\
        Delay Sweeper\t{%s}%02d:%02d\n\
        Delay Forklift\t{%s}%02d:%02d\n\
        Delay Bus\t{%s}%02d:%02d\n\
        Delay Mower\t{%s}%02d:%02d\n\
        Plant Time (Farmer)\t{%s}%02d:%02d\n\
        Arrest Time\t{%s}%02d:%02d\n\
        Jail Time\t{%s}%02d:%02d\n\
        Vehicle Claim (%d)\t{%s}%02d:%02d",
        pc_min, pc_sec,
        (pData[playerid][pJobTime] == 0 ? "00FF00" : "FF0000"), job_min, job_sec,
        (pData[playerid][pSideJobTime] == 0 ? "00FF00" : "FF0000"), sidejob_min, sidejob_sec,
        (pData[playerid][pSweeperTime] == 0 ? "00FF00" : "FF0000"), sweeper_min, sweeper_sec,
        (pData[playerid][pForklifterTime] == 0 ? "00FF00" : "FF0000"), forklift_min, forklift_sec,
        (pData[playerid][pBusTime] == 0 ? "00FF00" : "FF0000"), bus_min, bus_sec,
        (pData[playerid][pMowerTime] == 0 ? "00FF00" : "FF0000"), mower_min, mower_sec,
        (pData[playerid][pPlantTime] == 0 ? "00FF00" : "FF0000"), plant_min, plant_sec,
        (pData[playerid][pArrestTime] == 0 ? "00FF00" : "FF0000"), arrest_min, arrest_sec,
        (pData[playerid][pJailTime] == 0 ? "00FF00" : "FF0000"), jail_min, jail_sec,
        total_claiming,
        (claim_remaining == 0 ? "00FF00" : "FF0000"), claim_min, claim_sec
    );
    
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, ""ORANGE_E"Valencia Roleplay: "WHITE_E"Time", line2, "Oke", "");
    return 1;
}

CMD:idcard(playerid, params[])
{
	if(pData[playerid][pIDCard] == 0) return Error(playerid, "Anda tidak memiliki id card!");
	
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	
	new string[512];
	format(string, sizeof(string), 
		"{FFFFFF}Name:\t{FFFF00}%s\n{FFFFFF}Gender:\t{FFFF00}%s\n{FFFFFF}Birthdate:\t{FFFF00}%s\n{FFFFFF}Valid Until:\t{FFFF00}%s",
		pData[playerid][pName],
		sext,
		pData[playerid][pAge],
		ReturnTimelapse(gettime(), pData[playerid][pIDCardTime])
	);
	
	// Dialog untuk diri sendiri
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "{FFFFFF}ID Card", string, "Close", "");
	
	// Kirim dialog ke nearby players
	new title[128];
	format(title, sizeof(title), " {FFFFFF}ID Card - %s", pData[playerid][pName]);
	
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && i != playerid)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(GetPlayerDistanceFromPoint(i, x, y, z) <= 20.0)
			{
				ShowPlayerDialog(i, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, title, string, "Tutup", "");
			}
		}
	}
	
	// Kirim pesan roleplay
	SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s menunjukkan ID Card miliknya.", ReturnName(playerid));
	return 1;
}

CMD:drivelic(playerid, params[])
{
	if(pData[playerid][pDriveLic] == 0) return Error(playerid, "You do not have a Driving License/SIM!");
	new sext[40];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	SendNearbyMessage(playerid, 20.0, COLOR_GREEN, "[Drive-Lic] "GREY3_E"Name: %s | Gender: %s | Brithday: %s | Expire: %s.", pData[playerid][pName], sext, pData[playerid][pAge], ReturnTimelapse(gettime(), pData[playerid][pDriveLicTime]));
	return 1;
}

CMD:newidcard(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2082.9756, 2675.5081, 1500.9647)) return Error(playerid, "You must be at City Hall!");
	if(pData[playerid][pIDCard] != 0) return Error(playerid, "You already have an ID Card!");
	if(GetPlayerMoney(playerid) < 5000) return Error(playerid, "You need $50.00 to create an ID Card");
	new sext[40], mstr[128];
	if(pData[playerid][pGender] == 1) { sext = "Male"; } else { sext = "Female"; }
	format(mstr, sizeof(mstr), "{FFFFFF}Name: %s\nCountry: San Andreas\nBirthdate: %s\nGender: %s\nValid for 14 days!", pData[playerid][pName], pData[playerid][pAge], sext);
	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "ID-Card", mstr, "Close", "");
	pData[playerid][pIDCard] = 1;
	pData[playerid][pIDCardTime] = gettime() + (30 * 86400);
	GivePlayerMoneyEx(playerid, -5000);
	Server_AddMoney(25);
	return 1;
}

CMD:newage(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2082.9756, 2675.5081, 1500.9647)) return Error(playerid, "You must be at City Hall!");
	//if(pData[playerid][pIDCard] != 0) return Error(playerid, "Anda sudah memiliki ID Card!");
	if(GetPlayerMoney(playerid) < 30000) return Error(playerid, "You need $300.00 to change your birthdate!");
	if(pData[playerid][IsLoggedIn] == false) return Error(playerid, "You must be logged in first!");
	ShowPlayerDialog(playerid, DIALOG_CHANGEAGE, DIALOG_STYLE_INPUT, "Birthdate", "Enter your birthdate (DD/MM/YYYY): 15/04/1998", "Change", "Cancel");
	return 1;
}

CMD:newdrivelic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2578.5625, -1383.2179, 1500.7570)) return Error(playerid, "You must be at the DMV!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "You already have a Driving License!");
	if(GetPlayerMoney(playerid) < 20000) return Error(playerid, "You need $200.00 to obtain a Driving License.");
	
	new string[512];
	format(string, sizeof(string), "{ffffff}Biaya Pendaftaran:\t{00ff00}$200.00\n{ffffff}Durasi Test:\t{ffff00}5 Menit\n\n{ffffff}Peraturan Test:\n{ff6347}- Jangan menabrak kendaraan/objek lain\n{ff6347}- Jangan keluar dari kendaraan test\n{ff6347}- Ikuti checkpoint yang tersedia\n{ff6347}- Jika melanggar, test akan gagal\n\n{ffffff}Apakah kamu yakin ingin mengikuti test SIM?");
	ShowPlayerDialog(playerid, DIALOG_DRIVELIC_APPLY, DIALOG_STYLE_MSGBOX, "{7348EB}DMV - Driving License Test", string, "Yes", "No");
	return 1;
}

/*CMD:buyplate(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 101.9294, 1064.6431, -48.9141)) return Error(playerid, "Anda harus berada di SAPD!");
	
	new bool:found = false, msg2[512], Float:fx, Float:fy, Float:fz;
	format(msg2, sizeof(msg2), "ID\tModel\tPlate\tPlate Time\n");
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID])
		{
			if(strcmp(pvData[i][cPlate], "NoHave"))
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\t%s\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));
				found = true;
			}
			else
			{
				GetVehiclePos(pvData[i][cVeh], fx, fy, fz);
				format(msg2, sizeof(msg2), "%s%d\t%s\t%s\tNone\n", msg2, pvData[i][cVeh], GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate]);
				found = true;
			}
		}
	}
	if(found)
		ShowPlayerDialog(playerid, DIALOG_BUYPLATE, DIALOG_STYLE_TABLIST_HEADERS, "Vehicles Plate", msg2, "Buy", "Close");
	else
		ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Vehicles Plate", "Anda tidak memeliki kendaraan", "Close", "");
			
	return 1;
}*/

CMD:payticket(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 85.0160, 1070.5106, -48.9141) && !IsPlayerInRangeOfPoint(playerid, 3.0, -1469.6188, 2600.2039, 19.6310)) return Error(playerid, "Anda harus berada di kantor SAPD!");
	
	new vehid;
	if(sscanf(params, "d", vehid))
		return Usage(playerid, "/payticket [vehid] | /mypv - for find vehid");
		
	if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
		return Error(playerid, "Invalid id");
		
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID])
			{
				new ticket = pvData[i][cTicket];
				
				if(ticket > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money! check your ticket in /v insu.");
					
				if(ticket > 0)
				{
					GivePlayerMoneyEx(playerid, -ticket);
					pvData[i][cTicket] = 0;
					Info(playerid, "You have successfully paid the traffic ticket for the vehicle %s (ID: %d) in the amount of "RED_E"%s.", GetVehicleName(vehid), vehid, FormatMoney(ticket));
					return 1;
				}
			}
			else return Error(playerid, "This vehicle ID does not belong to you! use /mypv to find the ID.");
		}
	}
	return 1;
}

CMD:buyplate(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 101.9294, 1064.6431, -48.9141) &&
        !IsPlayerInRangeOfPoint(playerid, 3.0, -1466.4567, 2600.2031, 19.6310))
        return Error(playerid, "Anda harus berada di SAPD!");

    new vehid;
    if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyplate [vehid] | /mypv - for find vehid");

    if(vehid == INVALID_VEHICLE_ID || !IsValidVehicle(vehid))
        return Error(playerid, "Invalid id");

    foreach(new i : PVehicles)
    {
        if(vehid == pvData[i][cVeh])
        {
            if(pvData[i][cOwner] != pData[playerid][pID])
                return Error(playerid, "This vehicle ID does not belong to you! use /mypv to find the ID.");

            if(GetPlayerMoney(playerid) < 50000)
                return Error(playerid, "You need $500.00 to buy a new Plate.");

            GivePlayerMoneyEx(playerid, -50000);

            // Generate 3 huruf acak A-Z
            new l1 = 65 + random(26);
            new l2 = 65 + random(26);
            new l3 = 65 + random(26);

            // Generate angka 4 digit (1000-9999)
            new num = 1000 + random(9000);

            // Format US plate: ABC-1234
            format(pvData[i][cPlate], 16, "%c%c%c-%d", l1, l2, l3, num);

            // Apply
            SetVehicleNumberPlate(pvData[i][cVeh], pvData[i][cPlate]);
            pvData[i][cPlateTime] = gettime() + (15 * 86400);

            Info(playerid, "Model: %s || New plate: %s || Plate Time: %s || Price: $500.00", GetVehicleModelName(pvData[i][cModel]), pvData[i][cPlate], ReturnTimelapse(gettime(), pvData[i][cPlateTime]));

            return 1;
        }
    }
    return 1;
}


CMD:buyinsu(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1296.0533, -1264.1348, 13.5939)) return Error(playerid, "You must be at the Insurance Office!");
		
	new vehid;
	if(sscanf(params, "d", vehid)) return Usage(playerid, "/buyinsu [vehid] | /mypv - for find vehid");
	if(vehid == INVALID_VEHICLE_ID) return Error(playerid, "Invalid id");
			
	foreach(new i : PVehicles)
	{
		if(vehid == pvData[i][cVeh])
		{
			if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 0)
			{
				if(GetPlayerMoney(playerid) < 50000) return Error(playerid, "You need $500.00 to buy Insurance.");
				GivePlayerMoneyEx(playerid, -50000);
				pvData[i][cInsu]++;
				Info(playerid, "Model: %s || Total Insurance: %d || Insurance Price: $500.00", GetVehicleModelName(pvData[i][cModel]), pvData[i][cInsu]);
			}
			else return Error(playerid, "This vehicle ID does not belong to you! use /mypv to find the ID.");
		}
	}
	return 1;
}

CMD:claimpv(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, 1296.0533, -1264.1348, 13.5939)) 
		return Error(playerid, "You must be at the Insurance Office!");
	
	new found = 0, waiting = 0;
	
	foreach(new i : PVehicles)
	{
		if(pvData[i][cOwner] == pData[playerid][pID] && pvData[i][cClaim] == 1)
		{
			if(pvData[i][cClaimTime] <= 0) // Cek countdown sudah habis
			{
				// Claim ready
				pvData[i][cClaim] = 0;
				pvData[i][cClaimTime] = 0;
				
				OnPlayerVehicleRespawn(i);
				pvData[i][cPosX] = 1290.7111;
				pvData[i][cPosY] = -1243.8767;
				pvData[i][cPosZ] = 13.3901;
				pvData[i][cPosA] = 2.5077;
				SetValidVehicleHealth(pvData[i][cVeh], 1000.0);
				SetVehiclePos(pvData[i][cVeh], 1290.7111, -1243.8767, 13.3901);
				SetVehicleZAngle(pvData[i][cVeh], 2.5077);
				SetVehicleFuel(pvData[i][cVeh], 1000);
				ValidRepairVehicle(pvData[i][cVeh]);
				
				// Update database
				new query[128];
				mysql_format(g_SQL, query, sizeof(query), 
					"UPDATE vehicle SET claim='0', claim_time='0' WHERE id='%d'", 
					pvData[i][cID]);
				mysql_tquery(g_SQL, query);
				
				found++;
			}
			else
			{
				waiting++;
			}
		}
	}
	
	if(found == 0 && waiting == 0)
		return Error(playerid, "You don't have any vehicles in claim!");
	
	if(found == 0 && waiting > 0)
		return Error(playerid, "You have %d vehicle%s waiting, come back later!", waiting, (waiting > 1) ? "s" : "");
	
	Info(playerid, "Successfully claimed %d vehicle%s!", found, (found > 1) ? "s" : "");
	
	if(waiting > 0)
		Info(playerid, "%d vehicle%s still waiting.", waiting, (waiting > 1) ? "s" : "");
	
	return 1;
}

CMD:checkclaim(playerid, params[])
{
    new count = 0, string[2048], tempstr[128];
    
    strcat(string, "Vehicle\tStatus\tTime Remaining\n", sizeof(string));
    
    foreach(new i : PVehicles)
    {
        if(pvData[i][cOwner] == pData[playerid][pID])
        {
            count++;
            
            if(pvData[i][cClaim] == 1)
            {
                // FIXED: Langsung pakai countdown, bukan kurangi gettime()
                if(pvData[i][cClaimTime] > 0)
                {
                    format(tempstr, sizeof(tempstr), "%s\t{FFFF00}Waiting\t{FFFF00}%s\n",
                        GetVehicleModelName(pvData[i][cModel]),
                        ConvertToMinutes(pvData[i][cClaimTime])); // Langsung pakai countdown
                }
                else
                {
                    format(tempstr, sizeof(tempstr), "%s\t{00FF00}Ready to Claim\t{00FF00}-\n",
                        GetVehicleModelName(pvData[i][cModel]));
                }
            }
            else
            {
                format(tempstr, sizeof(tempstr), "%s\t{FFFFFF}Active\t{FFFFFF}-\n",
                    GetVehicleModelName(pvData[i][cModel]));
            }
            
            strcat(string, tempstr, sizeof(string));
        }
    }
    
    if(count == 0)
        return Error(playerid, "You don't have any vehicles!");
    
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, 
        "Vehicle Claim Status", string, "Close", "");
    return 1;
}

CMD:scrapveh(playerid, params[])
{
    // Check apakah di tempat scrap/insurance office
    if(!IsPlayerInRangeOfPoint(playerid, 15.0, 2415.4207, -2467.8943, 13.6250)) 
        return Error(playerid, "You must be at the scrap vehicle area!");
    
    // Check apakah player sedang naik kendaraan
    if(!IsPlayerInAnyVehicle(playerid))
        return Error(playerid, "You must be inside a vehicle to scrap it!");
    
    // Check apakah player adalah driver
    if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
        return Error(playerid, "You must be the driver to scrap this vehicle!");
    
    new vehicleid = GetPlayerVehicleID(playerid);
    
    // Cari vehicle di PVehicles
    new carid = -1;
    foreach(new i : PVehicles)
    {
        if(pvData[i][cVeh] == vehicleid)
        {
            carid = i;
            break;
        }
    }
    
    // Check apakah ini private vehicle
    if(carid == -1)
        return Error(playerid, "This is not a private vehicle!");
    
    // Check ownership
    if(pvData[carid][cOwner] != pData[playerid][pID])
        return Error(playerid, "This vehicle doesn't belong to you!");
    
    // Check rental
    if(pvData[carid][cRent] != 0)
        return Error(playerid, "You can't scrap a rental vehicle!");
    
    // Check if vehicle is being claimed
    if(pvData[carid][cClaim] == 1)
        return Error(playerid, "You can't scrap a vehicle that is being claimed!");
    
    // Hitung harga jual (50% dari harga beli)
    new pay = pvData[carid][cPrice] / 2;
    
    // Konfirmasi dialog
    new str[512];
    format(str, sizeof(str),
        "{FFFFFF}Are you sure you want to scrap this vehicle?\n\n\
        Vehicle: {FFFF00}%s\n\
        {FFFFFF}Original Price: {00FF00}%s\n\
        {FFFFFF}Scrap Value: {FFFF00}%s {FFFFFF}(50%%)\n\n\
        {FF0000}Warning: This action cannot be undone!",
        GetVehicleModelName(GetVehicleModel(vehicleid)),
        FormatMoney(pvData[carid][cPrice]),
        FormatMoney(pay)
    );
    
    SetPVarInt(playerid, "ScrapVehicleID", carid);
    ShowPlayerDialog(playerid, DIALOG_SCRAP_CONFIRM, DIALOG_STYLE_MSGBOX, 
        "Scrap Vehicle Confirmation", str, "Scrap", "Cancel");
    
    return 1;
}

CMD:newrek(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2667.4021, 802.2328, 1500.9688)) return Error(playerid, "You must be at the Bank!");
	if(GetPlayerMoney(playerid) < 5000) return Error(playerid, "Not enough money!");
	new query[128], rand = RandomEx(111111, 999999);
	new rek = rand+pData[playerid][pID];
	mysql_format(g_SQL, query, sizeof(query), "SELECT brek FROM players WHERE brek='%d'", rek);
	mysql_tquery(g_SQL, query, "BankRek", "id", playerid, rek);
	Info(playerid, "New rekening bank!");
	GivePlayerMoneyEx(playerid, -5000);
	Server_AddMoney(50);
	return 1;
}

CMD:bank(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2679.9041, 806.8085, 1500.9688)) return Error(playerid, "You must be at the bank point!");
	new tstr[128];
	format(tstr, sizeof(tstr), ""ORANGE_E"No Rek: "LB_E"%d", pData[playerid][pBankRek]);
	ShowPlayerDialog(playerid, DIALOG_BANK, DIALOG_STYLE_LIST, tstr, "Deposit Money\nWithdraw Money\nCheck Balance\nTransfer Money\nSign Paycheck", "Select", "Cancel");
	return 1;
}

CMD:pay(playerid, params[])
{
	if (IsAtEvent[playerid] == 1)
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

    new otherid, cash[32], mstr[128];
    new totalcash[25];
    if(sscanf(params, "us[32]", otherid, cash)) return SendClientMessage(playerid, COLOR_GREY, "/pay [playerid] [ammount]");

	if(!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The specified player is disconnected or not near you.");

	format(totalcash, sizeof(totalcash), "%d00", strval(cash));
	if(IsPlayerConnected(otherid) && otherid != playerid)
	{
		if(strval(totalcash) > 1000000) return Error(playerid, "You cannot send more than $10,000.00 at once!");
		if(GetPlayerMoney(playerid) >= strval(totalcash))
		{
			if(IsPlayerConnected(otherid))
			{
				if(strval(totalcash) < 0) return SendClientMessageEx(playerid, COLOR_GREY, "You cannot send less than $1.00!");
				GivePlayerMoneyEx(playerid, -strval(totalcash));
				GivePlayerMoneyEx(otherid, strval(totalcash));
				format(mstr, sizeof(mstr), "PAYINFO: "WHITE_E"You've paid "GREEN_E"%s "WHITE_E"to "YELLOW_E"%s", FormatMoney(strval(totalcash)), ReturnName(otherid));
				SendClientMessage(playerid, COLOR_ARWIN, mstr);
				format(mstr, sizeof(mstr), "PAYINFO: "YELLOW_E"%s "WHITE_E"has paid "GREEN_E"%s "WHITE_E"to you", ReturnName(playerid), FormatMoney(strval(totalcash)));
				SendClientMessage(otherid, COLOR_ARWIN, mstr);
				ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
				//SendAdminMessage(COLOR_ARWIN, "PAYLOGS: "WBLUE_E"%s "YELLOW_E"has paid "GREEN_E"%s "YELLOW_E"to "WBLUE_E"%s", ReturnName2(playerid), FormatMoney(strval(totalcash)), ReturnName2(otherid));
				
				new dc[500];
				format(dc, sizeof(dc),  "```[PAY LOG]%s telah memberikan uang kepada %s sebesar %s```", ReturnName(playerid), ReturnName(otherid), FormatMoney(strval(totalcash)));
				SendDiscordMessage(1, dc);
				new query[512];
				mysql_format(g_SQL, query, sizeof(query), "INSERT INTO logpay (player,playerid,toplayer,toplayerid,ammount,time) VALUES('%s','%d','%s','%d','%d',UNIX_TIMESTAMP())", pData[playerid][pName], pData[playerid][pID], pData[otherid][pName], pData[otherid][pID], totalcash);
				mysql_tquery(g_SQL, query);		
			}
			else SendClientMessage(playerid, COLOR_GREY, "The player is disconnected or not near you.");
		}
		else SendClientMessage(playerid, COLOR_GREY, "You don't have enough money to send!");
	}
    return 1;
}
/*
CMD:pay(playerid, params[])
{
    if (IsAtEvent[playerid] == 1)
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    
    new money, otherid;
    new mstr[128];

    if (sscanf(params, "ud", otherid, money))
    {
        Usage(playerid, "/pay <playerid> <amount>");
        return true;
    }

    if (!IsPlayerConnected(otherid) || !NearPlayer(playerid, otherid, 4.0))
        return Error(playerid, "The player is disconnected or not near you.");

    if (otherid == playerid)
        return Error(playerid, "You cannot send money to yourself!");

    if (pData[playerid][pMoney] < money)
        return Error(playerid, "You don't have enough money to send!");

    if (money > 100000 && pData[playerid][pAdmin] == 0)
        return Error(playerid, "You cannot send more than $100,000 at once!");

    if (money < 1)
        return Error(playerid, "You cannot send less than $1!");

    // Tampilkan konfirmasi kepada player
    format(mstr, sizeof(mstr), ""WHITEP_E"Apakah Anda yakin ingin mengirim %s(%d) "GREEN_E"%s?", ReturnName(otherid), otherid, FormatMoney(money));
    ShowPlayerDialog(playerid, DIALOG_PAY, DIALOG_STYLE_MSGBOX, ""GREEN_E"Pay", mstr, "Kirim", "Batal");

    // Simpan jumlah uang dan ID player yang akan menerima uang
    SetPVarInt(playerid, "gcAmount", money);
    SetPVarInt(playerid, "gcPlayer", otherid);

    return 1;
}
*/
CMD:stats(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check statistics!");
	    return 1;
	}
	
	DisplayStats(playerid, playerid);
	return 1;
}

CMD:settings(playerid)
{
	if(pData[playerid][IsLoggedIn] == false)
		return Error(playerid, "You must be logged in to check statistics!");
	
	static str[512]; // ← Pakai static, ga perlu 2048!
	new hbemode[32], togpm[16], toglog[16], togads[16], togwt[16]; // ← Ukuran lebih kecil
	
	// HBE Mode Settings
	switch(pData[playerid][pHBEMode]) 
	{
		case 1: hbemode = ""LG_E"Simple";
		case 2: hbemode = ""LB_E"Modern"; 
		case 3: hbemode = ""YELLOW_E" Minimalist";
		default: hbemode = ""RED_E"Disabled";
	}
	
	// Toggle Settings (lebih simpel)
	togpm = (pData[playerid][pTogPM] == 0) ? ""LG_E"ON" : ""RED_E"OFF";
	toglog = (pData[playerid][pTogLog] == 0) ? ""LG_E"ON" : ""RED_E"OFF";
	togads = (pData[playerid][pTogAds] == 0) ? ""LG_E"ON" : ""RED_E"OFF";
	togwt = (pData[playerid][pTogWT] == 0) ? ""LG_E"ON" : ""RED_E"OFF";
	
	format(str, sizeof(str),
    ""WHITEP_E"Email:\t\t\t"GREEN_E"%s\n"WHITEP_E"Change Password\n"WHITEP_E"HBE Mode:\t"GREEN_E"%s\n"WHITEP_E"Private Messages:\t"GREEN_E"%s\n"WHITEP_E"Server Logs:\t\t"GREEN_E"%s\n"WHITEP_E"Advertisements:\t"GREEN_E"%s\n"WHITEP_E"Walkie-Talkie:\t"GREEN_E"%s",
    pData[playerid][pEmail],
    hbemode,
    togpm,
    toglog, 
    togads,
    togwt
	);
	
	ShowPlayerDialog(playerid, DIALOG_SETTINGS, DIALOG_STYLE_LIST,
		""BLUE_E"SETTINGS - "WHITEP_E"Player Configuration",
		str,
		"Select",
		"Back"
	);
	return 1;
}
CMD:items(playerid, params[])
{
	if(pData[playerid][IsLoggedIn] == false)
	{
	    Error(playerid, "You must be logged in to check items!");
	    return true;
	}
	DisplayItems(playerid, playerid);
	return 1;
}

CMD:takejob(playerid, params[])
{
    if(pData[playerid][pIDCard] <= 0)
        return Error(playerid, "You do not have an ID-Card.");
        
    if(pData[playerid][pVip] > 0) // If the player is VIP
    {
        if(pData[playerid][pJob] == 0 || pData[playerid][pJob2] == 0) // If there is an empty job slot
        {
            if(pData[playerid][pJob] == 0) // If the first job slot is empty
            {
                if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -2159.04, 640.36, 1052.38))
                {
                    pData[playerid][pGetJob] = 1;
                    Info(playerid, "You have successfully registered for the Taxi job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1767.3154, -1719.1577, 13.6183))
                {
                    pData[playerid][pGetJob] = 2;
                    Info(playerid, "You have successfully registered for the Mechanic job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
                {
                    pData[playerid][pGetJob] = 3;
                    Info(playerid, "You have successfully registered for the Lumberjack job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
                {
                    pData[playerid][pGetJob] = 4;
                    Info(playerid, "You have successfully registered for the Trucker job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
                {
                    pData[playerid][pGetJob] = 5;
                    Info(playerid, "You have successfully registered for the Miner job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1218.3816, 186.7438, 20.2838))
                {
                    pData[playerid][pGetJob] = 6;
                    Info(playerid, "You have successfully registered for the Production job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
                {
                    pData[playerid][pGetJob] = 7;
                    Info(playerid, "You have successfully registered for the Farmer job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
                {
                    pData[playerid][pGetJob] = 8;
                    Info(playerid, "You have successfully registered for the Courier job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
                {
                    if(pData[playerid][pLevel] < 5) return Error(playerid, "You must be level 5 to enter this job.");
                    pData[playerid][pGetJob] = 9;
                    Info(playerid, "You have successfully registered for the Smuggler job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
                {
                    pData[playerid][pGetJob] = 10;
                    Info(playerid, "You have successfully registered for the Baggage job. Use /accept job to confirm.");
                }
                else return Error(playerid, "You already have a job or are not near a job registration.");
            }
            else if(pData[playerid][pJob2] == 0) // If the second job slot is empty
            {
                // Check the same locations for the second job
                if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -2159.04, 640.36, 1052.38))
                {
                    pData[playerid][pGetJob2] = 1;
                    Info(playerid, "You have successfully registered for the Taxi job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1767.3154, -1719.1577, 13.6183))
                {
                    pData[playerid][pGetJob2] = 2;
                    Info(playerid, "You have successfully registered for the Mechanic job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
                {
                    pData[playerid][pGetJob2] = 3;
                    Info(playerid, "You have successfully registered for the Lumberjack job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
                {
                    pData[playerid][pGetJob2] = 4;
                    Info(playerid, "You have successfully registered for the Trucker job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
                {
                    pData[playerid][pGetJob2] = 5;
                    Info(playerid, "You have successfully registered for the Miner job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1218.3816, 186.7438, 20.2838))
                {
                    pData[playerid][pGetJob2] = 6;
                    Info(playerid, "You have successfully registered for the Production job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
                {
                    pData[playerid][pGetJob2] = 7;
                    Info(playerid, "You have successfully registered for the Farmer job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
                {
                    pData[playerid][pGetJob2] = 8;
                    Info(playerid, "You have successfully registered for the Courier job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
                {
                    if(pData[playerid][pLevel] < 5) return Error(playerid, "You must be level 5 to enter this job.");
                    pData[playerid][pGetJob2] = 9;
                    Info(playerid, "You have successfully registered for the Smuggler job. Use /accept job to confirm.");
                }
                else if(GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
                {
                    pData[playerid][pGetJob2] = 10;
                    Info(playerid, "You have successfully registered for the Baggage job. Use /accept job to confirm.");
                }
                else return Error(playerid, "You already have a job or are not near a job registration.");
            }
            else return Error(playerid, "You already have 2 jobs!");
        }
        else return Error(playerid, "You already have 2 jobs!");
    }
    else // If the player is not VIP
    {
        if(pData[playerid][pJob] > 0)
            return Error(playerid, "You can only have 1 job!");
            
        if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -2159.04, 640.36, 1052.38))
        {
            pData[playerid][pGetJob] = 1;
            Info(playerid, "You have successfully registered for the Taxi job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1767.3154, -1719.1577, 13.6183))
        {
            pData[playerid][pGetJob] = 2;
            Info(playerid, "You have successfully registered for the Mechanic job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -265.87, -2213.63, 29.04))
        {
            pData[playerid][pGetJob] = 3;
            Info(playerid, "You have successfully registered for the Lumberjack job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -77.38, -1136.52, 1.07))
        {
            pData[playerid][pGetJob] = 4;
            Info(playerid, "You have successfully registered for the Trucker job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 319.94, 874.77, 20.39))
        {
            pData[playerid][pGetJob] = 5;
            Info(playerid, "You have successfully registered for the Miner job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 1218.3816, 186.7438, 20.2838))
        {
            pData[playerid][pGetJob] = 6;
            Info(playerid, "You have successfully registered for the Production job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, -383.67, -1438.90, 26.32))
        {
            pData[playerid][pGetJob] = 7;
            Info(playerid, "You have successfully registered for the Farmer job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 988.890563, -1349.136962, 13.545228))
        {
            pData[playerid][pGetJob2] = 8;
            Info(playerid, "You have successfully registered for the Courier job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 5.0, 977.34, -771.49, 112.20))
        {
            if(pData[playerid][pLevel] < 5) return Error(playerid, "You must be level 5 to enter this job.");
            pData[playerid][pGetJob] = 9;
            Info(playerid, "You have successfully registered for the Smuggler job. Use /accept job to confirm.");
        }
        else if(pData[playerid][pJob] == 0 && GetPlayerState(playerid) == 1 && IsPlayerInRangeOfPoint(playerid, 3.0, 2060.2942, -2220.8250, 13.5469))
        {
            pData[playerid][pGetJob] = 10;
            Info(playerid, "You have successfully registered for the Baggage job. Use /accept job to confirm.");
        }
        else return Error(playerid, "You already have a job or are not near a job registration.");
    }
    
    return 1; // Ensure the command returns a value
}


CMD:frisk(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/frisk [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pFriskOffer] = playerid;

    // ✅ PERBAIKAN: Ganti 'factionid' dengan 0 (tidak perlu data tambahan)
    SendConfirmation(otherid, playerid, "frisk", 0);
	Info(playerid, "You have offered to frisk %s.", ReturnName(otherid));

	return 1;
}

CMD:inspect(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/inspect [playerid/PartOfName]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player tidak berada didekat mu.");

    if(otherid == playerid)
        return Error(playerid, "Kamu tidak bisa memeriksa dirimu sendiri.");

    pData[otherid][pInsOffer] = playerid;

    SendConfirmation(otherid, playerid, "inspect", 0); // ✅ data = 0

    Info(playerid, "You have offered to inspect %s.", ReturnName(otherid));
	return 1;
}

CMD:reqloc(playerid, params[])
{
    new phone;
    if(sscanf(params, "d", phone)) // ← Ubah jadi "d" (nomor telepon)
        return Usage(playerid, "/reqloc [phone number]");

    if(pData[playerid][pPhone] < 1)
        return Error(playerid, "You do not have a cellphone.");

    if(pData[playerid][pPhoneStatus] == 0)
        return Error(playerid, "Your phone is still offline.");

    if(pData[playerid][pDelayReqloc] > 0) 
        return Error(playerid, "Wait %d seconds to use reqloc again.", pData[playerid][pDelayReqloc]);

    // Cari player berdasarkan nomor telepon
    new otherid = INVALID_PLAYER_ID;
    foreach(new i : Player)
    {
        if(pData[i][pPhone] == phone)
        {
            otherid = i;
            break;
        }
    }

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "Phone number not found or player is offline.");

    if(pData[otherid][pPhoneStatus] == 0)
        return Error(playerid, "The phone you are trying to reach is still offline.");

    if(otherid == playerid)
        return Error(playerid, "You cannot request your own location.");

    pData[playerid][pDelayReqloc] = 60;
    pData[otherid][pLocOffer] = playerid;

    SendConfirmation(otherid, playerid, "drag", 0); // ✅ data = 0

    Info(playerid, "You have sent a location request to phone number %d.", phone);
    
    return 1;
}

CMD:accept(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /accept [name]");
            Info(playerid, "Names: faction, family, drag, frisk, inspect, job, reqloc, rob, dice");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFacOffer])) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
                    pData[playerid][pFaction] = pData[playerid][pFacInvite];
					pData[playerid][pFactionRank] = 1;
					Info(playerid, "You have accepted a faction invite from %s", pData[pData[playerid][pFacOffer]][pName]);
					Info(pData[playerid][pFacOffer], "%s has accepted the faction invite you offered", pData[playerid][pName]);
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "There is no player offering you!");
                return 1;
            }
        }
		if(strcmp(params,"family",true) == 0) 
		{
            if(IsPlayerConnected(pData[playerid][pFamOffer])) 
			{
                if(pData[playerid][pFamInvite] > -1) 
				{
                    pData[playerid][pFamily] = pData[playerid][pFamInvite];
					pData[playerid][pFamilyRank] = 1;
					Info(playerid, "You have accepted a family invite from %s", pData[pData[playerid][pFamOffer]][pName]);
					Info(pData[playerid][pFamOffer], "%s has accepted the family invite you offered", pData[playerid][pName]);
					pData[playerid][pFamInvite] = 0;
					pData[playerid][pFamOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid family id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "There is no player offering you!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "The player is not logged in.");
        
			if(!NearPlayer(playerid, dragby, 5.0))
				return Error(playerid, "You must be near the player.");
        
			pData[playerid][pDragged] = 1;
			pData[playerid][pDraggedBy] = dragby;

			pData[playerid][pDragTimer] = SetTimerEx("DragUpdate", 1000, true, "ii", dragby, playerid);
			SendNearbyMessage(dragby, 30.0, COLOR_PURPLE, "* %s grabs %s and starts dragging them, (/undrag).", ReturnName(dragby), ReturnName(playerid));
			return true;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "The player is not logged in!");
			
			if(!NearPlayer(playerid, pData[playerid][pInsOffer], 5.0))
				return Error(playerid, "You must be near the player.");
				
			new hstring[512], info[512];
			new hh = pData[playerid][pHead];
			new hp = pData[playerid][pPerut];
			new htk = pData[playerid][pRHand];
			new htka = pData[playerid][pLHand];
			new hkk = pData[playerid][pRFoot];
			new hkka = pData[playerid][pLFoot];
			format(hstring, sizeof(hstring),"Bagian Tubuh\tKondisi\n{ffffff}Kepala\t{7fffd4}%d.0%\n{ffffff}Perut\t{7fffd4}%d.0%\n{ffffff}Tangan Kanan\t{7fffd4}%d.0%\n{ffffff}Tangan Kiri\t{7fffd4}%d.0%\n",hh,hp,htk,htka);
			strcat(info, hstring);
			format(hstring, sizeof(hstring),"{ffffff}Kaki Kanan\t{7fffd4}%d.0%\n{ffffff}Kaki Kiri\t{7fffd4}%d.0%\n",hkk,hkka);
			strcat(info, hstring);
			ShowPlayerDialog(pData[playerid][pInsOffer],DIALOG_HEALTH,DIALOG_STYLE_TABLIST_HEADERS,"Health Condition",info,"Oke","");
			Servers(playerid, "You have successfully accepted the Inspect offer from %s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
		}
		else if(strcmp(params,"job",true) == 0) 
		{
			if(pData[playerid][pGetJob] > 0)
			{
				pData[playerid][pJob] = pData[playerid][pGetJob];
				Info(playerid, "You have successfully obtained a new job. Use /help for information.");
				pData[playerid][pGetJob] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 21600);
			}
			else if(pData[playerid][pGetJob2] > 0)
			{
				pData[playerid][pJob2] = pData[playerid][pGetJob2];
				Info(playerid, "You have successfully obtained a new job. Use /help for information.");
				pData[playerid][pGetJob2] = 0;
				pData[playerid][pExitJob] = gettime() + (1 * 21600);
			}
		}
		else if(strcmp(params,"reqloc",true) == 0)
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "The player is not logged in!");
				
			new Float:sX, Float:sY, Float:sZ;
			GetPlayerPos(playerid, sX, sY, sZ);
			SetPlayerCheckpoint(pData[playerid][pLocOffer], sX, sY, sZ, 5.0);
			Servers(playerid, "Location sharing from %s has been accepted.", ReturnName(pData[playerid][pLocOffer]));
			Servers(pData[playerid][pLocOffer], "Location of %s has been marked.", ReturnName(playerid));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		
		if(strcmp(params, "dice", true) == 0)
    	{
			new otherid = pData[playerid][pDiceOffer];
			new money = pData[playerid][pDiceMoney];

			if(otherid == INVALID_PLAYER_ID || !IsPlayerConnected(otherid))
				return Error(playerid, "There is no active dice game offer.");
			
			if(GetPlayerMoney(playerid) < money || GetPlayerMoney(otherid) < money)
			{
				Error(playerid, "One of the players does not have enough money.");
				Error(otherid, "One of the players does not have enough money.");
				pData[playerid][pDiceOffer] = INVALID_PLAYER_ID;
				pData[playerid][pDiceMoney] = 0;
				return 1;
			}
			
			// Mulai permainan dadu
			new dice1 = random(6) + 1, dice2 = random(6) + 1;
			new dice3 = random(6) + 1, dice4 = random(6) + 1;
			new playerTotal = dice1 + dice2, otherTotal = dice3 + dice4;
			
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s rolls the dice: %d and %d (Total: %d)", ReturnName(playerid), dice1, dice2, playerTotal);
			SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s rolls the dice: %d and %d (Total: %d)", ReturnName(otherid), dice3, dice4, otherTotal);
			
			// Tentukan pemenang
			if(playerTotal > otherTotal)
			{
				GivePlayerMoneyEx(otherid, -money);
				GivePlayerMoneyEx(playerid, money);
				SendClientMessageEx(playerid, COLOR_WHITE, "Anda menang! Menerima "GREEN_E"%s"WHITE_E" dari %s.", FormatMoney(money), ReturnName(otherid));
				SendClientMessageEx(otherid, COLOR_WHITE, "Anda kalah. Kehilangan "RED_E"%s"WHITE_E" untuk %s.", FormatMoney(money), ReturnName(playerid));
			}
			else if(otherTotal > playerTotal)
			{
				GivePlayerMoneyEx(playerid, -money);
				GivePlayerMoneyEx(otherid, money);
				SendClientMessageEx(otherid, COLOR_WHITE, "Anda menang! Menerima "GREEN_E"%s"WHITE_E" dari %s.", FormatMoney(money), ReturnName(playerid));
				SendClientMessageEx(playerid, COLOR_WHITE, "Anda kalah. Kehilangan "RED_E"%s"WHITE_E" untuk %s.", FormatMoney(money), ReturnName(otherid));
			}
			else
			{
				SendClientMessage(playerid, COLOR_YELLOW, "Permainan seri.");
				SendClientMessage(otherid, COLOR_YELLOW, "Permainan seri.");
			}
			
			pData[playerid][pDiceOffer] = INVALID_PLAYER_ID;
			pData[playerid][pDiceMoney] = 0;
    	}
		else if(strcmp(params,"rob",true) == 0)
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "The player is not logged in!");
			
			Servers(playerid, "You accepted %s's robbery team invitation.", ReturnName(pData[playerid][pRobOffer]));
			Servers(pData[playerid][pRobOffer], "%s has accepted your robbery team invitation.", ReturnName(playerid));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
			pData[playerid][pMemberRob] = 1;
			pData[pData[playerid][pRobOffer]][pRobMember] += 1;
			RobMember += 1;
		}
	}
	return 1;
}

CMD:deny(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /deny [name]");
            Info(playerid, "Names: faction, drag, frisk, inspect, reqloc, rob, dice");
            return 1;
        }
		if(strcmp(params,"faction",true) == 0) 
		{
            if(pData[playerid][pFacOffer] > -1) 
			{
                if(pData[playerid][pFacInvite] > 0) 
				{
					Info(playerid, "You have denied a faction invite from %s", ReturnName(pData[playerid][pFacOffer]));
					Info(pData[playerid][pFacOffer], "%s has denied the faction invite you offered", ReturnName(playerid));
					pData[playerid][pFacInvite] = 0;
					pData[playerid][pFacOffer] = -1;
				}
				else
				{
					Error(playerid, "Invalid faction id!");
					return 1;
				}
            }
            else 
			{
                Error(playerid, "There is no player who has offered you!");
                return 1;
            }
        }
		else if(strcmp(params,"drag",true) == 0)
		{
			new dragby = GetPVarInt(playerid, "DragBy");
			if(dragby == INVALID_PLAYER_ID || dragby == playerid)
				return Error(playerid, "The player is not logged in.");

			Info(playerid, "You have denied the drag.");
			Info(dragby, "The player has denied the drag you offered.");
			
			DeletePVar(playerid, "DragBy");
			pData[playerid][pDragged] = 0;
			pData[playerid][pDraggedBy] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"frisk",true) == 0)
		{
			if(pData[playerid][pFriskOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pFriskOffer]))
				return Error(playerid, "The player is not logged in!");
			
			Info(playerid, "You have denied the frisk offer from %s.", ReturnName(pData[playerid][pFriskOffer]));
			pData[playerid][pFriskOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"inspect",true) == 0)
		{
			if(pData[playerid][pInsOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pInsOffer]))
				return Error(playerid, "The player is not logged in!");
			
			Info(playerid, "You have denied the inspect offer from %s.", ReturnName(pData[playerid][pInsOffer]));
			pData[playerid][pInsOffer] = INVALID_PLAYER_ID;
			return 1;
		}
		else if(strcmp(params,"reqloc",true) == 0) 
		{
			if(pData[playerid][pLocOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pLocOffer]))
				return Error(playerid, "The player is not logged in!");
			
			Info(playerid, "You have denied the location share offer from %s.", ReturnName(pData[playerid][pLocOffer]));
			pData[playerid][pLocOffer] = INVALID_PLAYER_ID;
		}
		if(strcmp(params, "dice", true) == 0)
    {
        if(pData[playerid][pDiceOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pDiceOffer]))
        {
            return Error(playerid, "There is no active dice game offer.");
        }
        
        new offerer = pData[playerid][pDiceOffer];
        
        Info(playerid, "You have denied the dice game offer from %s.", ReturnName(offerer));
        Info(offerer, "%s has denied the dice game offer you made.", ReturnName(playerid));
        
        pData[playerid][pDiceOffer] = INVALID_PLAYER_ID;
        pData[playerid][pDiceMoney] = 0;
    }
		else if(strcmp(params,"rob",true) == 0) 
		{
			if(pData[playerid][pRobOffer] == INVALID_PLAYER_ID || !IsPlayerConnected(pData[playerid][pRobOffer]))
				return Error(playerid, "The player is not logged in!");
			
			Info(playerid, "You have denied the rob offer from %s.", ReturnName(pData[playerid][pRobOffer]));
			pData[playerid][pRobOffer] = INVALID_PLAYER_ID;
		}
	}
	return 1;
}

CMD:quitjob(playerid, params[])
{
    if(isnull(params))
    {
        SendClientMessage(playerid, -1, 
            "USAGE: /quitjob [job1/job2]");
        return 1;
    }

    // ===== JOB 1 =====
    if(strcmp(params, "job1", true) == 0)
    {
        if(pData[playerid][pJob] == 0)
            return Error(playerid, "You do not have a primary job.");

        pData[playerid][pJob] = 0;
        Info(playerid, "You have successfully left your primary job.");
        return 1;
    }

    // ===== JOB 2 =====
    if(strcmp(params, "job2", true) == 0)
    {
        if(pData[playerid][pJob2] == 0)
            return Error(playerid, "You do not have a secondary job.");

        pData[playerid][pJob2] = 0;
        Info(playerid, "You have successfully left your secondary job.");
        return 1;
    }

    return Error(playerid, "Invalid option. Use /quitjob job1 or job2.");
}

CMD:give(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
		new name[24], ammount, otherid;
        if(sscanf(params, "us[24]d", otherid, name, ammount))
		{
			Usage(playerid, "/give [playerid] [name] [ammount]");
			Info(playerid, "Names: bandage, redmoney, medicine, snack, sprunk, material, component, marijuana, obat, weapon");
			return 1;
		}
		if(otherid == INVALID_PLAYER_ID || otherid == playerid || !NearPlayer(playerid, otherid, 3.0))
			return Error(playerid, "Invalid playerid!");
	
		if(ammount < 1 || ammount > 500)
        {
            return Error(playerid, "The number of items must be between 1 and 500!");
        }
		if(strcmp(name,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pBandage] -= ammount;
			pData[otherid][pBandage] += ammount;
			Info(playerid, "You have successfully given bandages to %s in the amount of %d.", ReturnName(otherid), ammount);
			Info(otherid, "%s has successfully given you bandages in the amount of %d.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pMedicine] -= ammount;
			pData[otherid][pMedicine] += ammount;
			Info(playerid, "You have successfully given %d medicine to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d medicine.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pSnack] -= ammount;
			pData[otherid][pSnack] += ammount;
			Info(playerid, "You have successfully given %d snacks to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d snacks.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"redmoney",true) == 0) 
		{
			if(pData[playerid][pRedMoney] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pRedMoney] -= ammount;
			pData[otherid][pRedMoney] += ammount;
			Info(playerid, "You have successfully given redmoney to %s in the amount of %s.", ReturnName(otherid), FormatMoney(ammount));
			Info(otherid, "%s has successfully given you redmoney in the amount of %s.", ReturnName(playerid), FormatMoney(ammount));
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pSprunk] -= ammount;
			pData[otherid][pSprunk] += ammount;
			Info(playerid, "You have successfully given %d Sprunk to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d Sprunk.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"material",true) == 0) 
		{
			if(pData[playerid][pMaterial] < ammount)
				return Error(playerid, "You do not have enough items.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxmat = pData[otherid][pMaterial] + ammount;
			
			if(maxmat > 500)
				return Error(playerid, "That player already have maximum material!");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pMaterial] -= ammount;
			pData[otherid][pMaterial] += ammount;
			Info(playerid, "You have successfully given %d Material to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d Material.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"component",true) == 0) 
		{
			if(pData[playerid][pComponent] < ammount)
				return Error(playerid, "You do not have enough items.");
			
			if(ammount > 500)
				return Error(playerid, "Invalid ammount 1 - 500");
			
			new maxcomp = pData[otherid][pComponent] + ammount;
			
			if(maxcomp > 500)
				return Error(playerid, "That player already have maximum component!");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pComponent] -= ammount;
			pData[otherid][pComponent] += ammount;
			Info(playerid, "You have successfully given %d Component to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d Component.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pMarijuana] -= ammount;
			pData[otherid][pMarijuana] += ammount;
			Info(playerid, "You have successfully given %d Marijuana to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d Marijuana.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
		else if(strcmp(name,"weapon",true) == 0) 
		{
			return callcmd::weapon(playerid, "give");
		}
		else if(strcmp(name,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < ammount)
				return Error(playerid, "You do not have enough items.");

			if(ammount < 1) return Error(playerid, "You can't give less than 1.");
			
			pData[playerid][pObat] -= ammount;
			pData[otherid][pObat] += ammount;
			Info(playerid, "You have successfully given %d Obat to %s.", ammount, ReturnName(otherid));
			Info(otherid, "%s has successfully given you %d Obat.", ReturnName(playerid), ammount);
			ApplyAnimation(playerid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
			ApplyAnimation(otherid, "DEALER", "shop_pay", 4.0, 0, 0, 0, 0, 0);
		}
	}
	return 1;
}

CMD:use(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
		return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");

	if(IsPlayerConnected(playerid)) 
	{
        if(isnull(params)) 
		{
            Usage(playerid, "USAGE: /use [name]");
            Info(playerid, "Names: bandage, snack, sprunk, gas, medicine, marijuana, obat");
            return 1;
        }
		if(strcmp(params,"bandage",true) == 0) 
		{
			if(pData[playerid][pBandage] < 1)
				return Error(playerid, "You do not have any bandages.");
			
			new Float:darah;
			GetPlayerHealth(playerid, darah);
			pData[playerid][pBandage]--;
			SetPlayerHealthEx(playerid, darah+15);
			Info(playerid, "You have successfully used a bandage.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Health");
		}
		else if(strcmp(params,"snack",true) == 0) 
		{
			if(pData[playerid][pSnack] < 1)
				return Error(playerid, "You do not have any snacks.");
			
			pData[playerid][pSnack]--;
			pData[playerid][pHunger] += 15;
			Info(playerid, "You have successfully used a snack.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"sprunk",true) == 0) 
		{
			if(pData[playerid][pSprunk] < 1)
				return Error(playerid, "You do not have any sprunk.");
			
			pData[playerid][pSprunk]--;
			pData[playerid][pEnergy] += 15;
			Info(playerid, "You have successfully drunk a sprunk.");
			InfoTD_MSG(playerid, 3000, "Restore +15 Energy");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"cigar",true) == 0) 
		{
			return callcmd::cigar(playerid, "");
		}
		else if(strcmp(params,"gas",true) == 0) 
		{
			if(pData[playerid][pGas] < 1)
				return Error(playerid, "You do not have any gas.");
				
			if(IsPlayerInAnyVehicle(playerid))
				return Error(playerid, "You must be outside of a vehicle!");
			
			if(pData[playerid][pActivityTime] > 5) return Error(playerid, "You still have an activity progress!");
			
			new vehicleid = GetNearestVehicleToPlayer(playerid, 3.5, false);
			if(IsValidVehicle(vehicleid))
			{
				new fuel = GetVehicleFuel(vehicleid);
			
				if(GetEngineStatus(vehicleid))
					return Error(playerid, "Turn off vehicle engine.");
			
				if(fuel >= 999.0)
					return Error(playerid, "This vehicle gas is full.");
			
				if(!IsEngineVehicle(vehicleid))
					return Error(playerid, "This vehicle can't be refull.");

				if(!GetHoodStatus(vehicleid))
					return Error(playerid, "The hood must be opened before refull the vehicle.");

				pData[playerid][pGas]--;
				Info(playerid, "Don't move from your position or you will failed to refulling this vehicle.");
				ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 0, 0, 0, 0, 0, 1);
				pData[playerid][pActivityStatus] = 1;
				pData[playerid][pActivity] = SetTimerEx("RefullCar", 1000, true, "id", playerid, vehicleid);
				PlayerTextDrawSetString(playerid, ActiveTD[playerid], "Refulling...");
				PlayerTextDrawShow(playerid, ActiveTD[playerid]);
				ShowPlayerProgressBar(playerid, pData[playerid][activitybar]);
				/*InfoTD_MSG(playerid, 10000, "Refulling...");
				//SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s starts to refulling the vehicle.", ReturnName(playerid));*/
				return 1;
			}
		}
		else if(strcmp(params,"medicine",true) == 0) 
		{
			if(pData[playerid][pMedicine] < 1)
				return Error(playerid, "You do not have any medicine.");
			
			pData[playerid][pMedicine]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "You have successfully used medicine.");
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"obat",true) == 0) 
		{
			if(pData[playerid][pObat] < 1)
				return Error(playerid, "You do not have any Myricous medicine.");
			
			pData[playerid][pObat]--;
			pData[playerid][pSick] = 0;
			pData[playerid][pSickTime] = 0;
			pData[playerid][pHead] = 100;
			pData[playerid][pPerut] = 100;
			pData[playerid][pRHand] = 100;
			pData[playerid][pLHand] = 100;
			pData[playerid][pRFoot] = 100;
			pData[playerid][pLFoot] = 100;
			SetPlayerDrunkLevel(playerid, 0);
			Info(playerid, "You have successfully used Myricous medicine.");
			
			//InfoTD_MSG(playerid, 3000, "Restore +15 Hunger");
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"marijuana",true) == 0) 
		{
			if(pData[playerid][pMarijuana] < 1)
				return Error(playerid, "You dont have marijuana.");
			
			new Float:armor;
			GetPlayerArmour(playerid, armor);
			if(armor+10 > 90) return Error(playerid, "Over dosis!");
			
			pData[playerid][pMarijuana]--;
			SetPlayerArmourEx(playerid, armor+10);
			SetPlayerDrunkLevel(playerid, 4000);
			ApplyAnimation(playerid,"SMOKING","M_smkstnd_loop",2.1,0,0,0,0,0);
		}
		else if(strcmp(params,"boombox",true) == 0)
		{
			if(pData[playerid][pVip] < 1 || pData[playerid][pVip] > 3)
				return Error(playerid, "You need to be VIP to use boombox.");

			if(pData[playerid][pBoombox] < 1)
				return Error(playerid, "You dont have boombox");
			// Cek apakah pemain sedang dalam posisi jongkok

			new string[128], Float:BBCoord[4], pNames[MAX_PLAYER_NAME];
		    GetPlayerPos(playerid, BBCoord[0], BBCoord[1], BBCoord[2]);
		    GetPlayerFacingAngle(playerid, BBCoord[3]);
		    SetPVarFloat(playerid, "BBX", BBCoord[0]);
		    SetPVarFloat(playerid, "BBY", BBCoord[1]);
		    SetPVarFloat(playerid, "BBZ", BBCoord[2]);
		    GetPlayerName(playerid, pNames, sizeof(pNames));
		    BBCoord[0] += (2 * floatsin(-BBCoord[3], degrees));
		   	BBCoord[1] += (2 * floatcos(-BBCoord[3], degrees));
		   	BBCoord[2] -= 1.0;
			if(GetPVarInt(playerid, "PlacedBB")) return SCM(playerid, -1, "You have already placed a boombox");
			foreach(new i : Player)
			{
		 		if(GetPVarType(i, "PlacedBB"))
		   		{
		  			if(IsPlayerInRangeOfPoint(playerid, 30.0, GetPVarFloat(i, "BBX"), GetPVarFloat(i, "BBY"), GetPVarFloat(i, "BBZ")))
					{
		   				SendClientMessage(playerid, COLOR_WHITE, "You cannot place a boombox here because someone else has already placed one.");
					    return 1;
					}
				}
			}
			new string2[128];
			format(string2, sizeof(string2), "* %s placed a boombox below", ReturnName(playerid));
			SendNearbyMessage(playerid, 15, COLOR_PURPLE, string2);
			SetPVarInt(playerid, "PlacedBB", CreateDynamicObject(2226, BBCoord[0], BBCoord[1], BBCoord[2], 0.0, 0.0, 0.0, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			format(string, sizeof(string), ""WHITE_E"Creator %s\n[/bbhelp for info]", pNames);
			SetPVarInt(playerid, "BBLabel", _:CreateDynamic3DTextLabel(string, COLOR_YELLOW, BBCoord[0], BBCoord[1], BBCoord[2]+0.6, 5, .worldid = GetPlayerVirtualWorld(playerid), .interiorid = GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBArea", CreateDynamicSphere(BBCoord[0], BBCoord[1], BBCoord[2], 30.0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid)));
			SetPVarInt(playerid, "BBInt", GetPlayerInterior(playerid));
			SetPVarInt(playerid, "BBVW", GetPlayerVirtualWorld(playerid));
			ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
		    ApplyAnimation(playerid,"BOMBER","BOM_Plant",4.0,0,0,0,0,0);
			
		}
	}
	return 1;
}

CMD:enter(playerid, params[])
{
	if(pData[playerid][pInjured] == 0)
    {

		foreach(new did : Doors)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "The interior entrance is still empty, or does not have an interior.");

					if(dData[did][dLocked])
						return Error(playerid, "This building is temporarily locked.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door is for factions only.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "This door is for Family only.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level is not enough.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level is not enough.");
						
					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
				else
				{
					if(dData[did][dIntposX] == 0.0 && dData[did][dIntposY] == 0.0 && dData[did][dIntposZ] == 0.0)
						return Error(playerid, "The interior entrance is still empty, or does not have an interior.");

					if(dData[did][dLocked])
						return Error(playerid, "This door is temporarily locked.");
						
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door is for factions only.");
					}
					if(dData[did][dFamily] > 0)
					{
						if(dData[did][dFamily] != pData[playerid][pFamily])
							return Error(playerid, "This door is for family only.");
					}
					
					if(dData[did][dVip] > pData[playerid][pVip])
						return Error(playerid, "Your VIP level is not enough to enter this door.");
					
					if(dData[did][dAdmin] > pData[playerid][pAdmin])
						return Error(playerid, "Your admin level not enough to enter this door.");

					if(strlen(dData[did][dPass]))
					{
						if(sscanf(params, "s[256]", params)) return Usage(playerid, "/enter [password]");
						if(strcmp(params, dData[did][dPass])) return Error(playerid, "Invalid door password.");
						
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
					else
					{
						if(dData[did][dCustom])
						{
							SetPlayerPositionEx(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						else
						{
							SetPlayerPosition(playerid, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ], dData[did][dIntposA]);
						}
						TogglePlayerControllable(playerid, false); // Disable player control
						SetTimerEx("UnfreezePlayer", 3000, false, "i", playerid); // 2000ms = 2 seconds
						pData[playerid][pInDoor] = did;
						SetPlayerInterior(playerid, dData[did][dIntint]);
						SetPlayerVirtualWorld(playerid, dData[did][dIntvw]);
						SetCameraBehindPlayer(playerid);
						SetPlayerWeather(playerid, 0);
					}
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.8, dData[did][dIntposX], dData[did][dIntposY], dData[did][dIntposZ]))
			{
				if(dData[did][dGarage] == 1 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER && IsPlayerInAnyVehicle(playerid))
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door is for factions only.");
					}
				
					if(dData[did][dCustom])
					{
						SetVehiclePositionEx(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					else
					{
						SetVehiclePosition(playerid, GetPlayerVehicleID(playerid), dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					}
					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
				else
				{
					if(dData[did][dFaction] > 0)
					{
						if(dData[did][dFaction] != pData[playerid][pFaction])
							return Error(playerid, "This door is for factions only.");
					}
					
					if(dData[did][dCustom])
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);

					else
						SetPlayerPositionEx(playerid, dData[did][dExtposX], dData[did][dExtposY], dData[did][dExtposZ], dData[did][dExtposA]);
					
					TogglePlayerControllable(playerid, false); // Disable player control
					SetTimerEx("UnfreezePlayer", 3000, false, "i", playerid); // 2000ms = 2 seconds

					pData[playerid][pInDoor] = -1;
					SetPlayerInterior(playerid, dData[did][dExtint]);
					SetPlayerVirtualWorld(playerid, dData[did][dExtvw]);
					SetCameraBehindPlayer(playerid);
					SetPlayerWeather(playerid, WorldWeather);
				}
			}
        }
		//Houses
		foreach(new hid : Houses)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
			{
				if(hData[hid][hIntposX] == 0.0 && hData[hid][hIntposY] == 0.0 && hData[hid][hIntposZ] == 0.0)
					return Error(playerid, "The interior house is still empty, or does not have an interior.");

				if(hData[hid][hLocked])
					return Error(playerid, "This house is locked!");
				
				pData[playerid][pInHouse] = hid;
				SetPlayerPositionEx(playerid, hData[hid][hIntposX], hData[hid][hIntposY], hData[hid][hIntposZ], hData[hid][hIntposA]);

				TogglePlayerControllable(playerid, false); // Disable player control
				SetTimerEx("UnfreezePlayer", 3000, false, "i", playerid); // 2000ms = 2 seconds

				SetPlayerInterior(playerid, hData[hid][hInt]);
				SetPlayerVirtualWorld(playerid, hid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inhouseid = pData[playerid][pInHouse];
		if(pData[playerid][pInHouse] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, hData[inhouseid][hIntposX], hData[inhouseid][hIntposY], hData[inhouseid][hIntposZ]))
		{
			SetPlayerPositionEx(playerid, hData[inhouseid][hExtposX], hData[inhouseid][hExtposY], hData[inhouseid][hExtposZ], hData[inhouseid][hExtposA]);

			pData[playerid][pInHouse] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Bisnis
		foreach(new bid : Bisnis)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
			{
				if(bData[bid][bIntposX] == 0.0 && bData[bid][bIntposY] == 0.0 && bData[bid][bIntposZ] == 0.0)
					return Error(playerid, "The business interior is still empty, or does not have an interior.");

				if(bData[bid][bLocked])
					return Error(playerid, "This business is locked!");

				if(bData[bid][bLocked] == 2)
    				return Error(playerid, "This business has been confiscated by the government and cannot be entered.");
					
				pData[playerid][pInBiz] = bid;
				SetPlayerPositionEx(playerid, bData[bid][bIntposX], bData[bid][bIntposY], bData[bid][bIntposZ], bData[bid][bIntposA]);

				TogglePlayerControllable(playerid, false); // Disable player control
				SetTimerEx("UnfreezePlayer", 3000, false, "i", playerid); // 2000ms = 2 seconds
				
				SetPlayerInterior(playerid, bData[bid][bInt]);
				SetPlayerVirtualWorld(playerid, bid);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, 0);
			}
        }
		new inbisnisid = pData[playerid][pInBiz];
		if(pData[playerid][pInBiz] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, bData[inbisnisid][bIntposX], bData[inbisnisid][bIntposY], bData[inbisnisid][bIntposZ]))
		{
			SetPlayerPositionEx(playerid, bData[inbisnisid][bExtposX], bData[inbisnisid][bExtposY], bData[inbisnisid][bExtposZ], bData[inbisnisid][bExtposA]);
			
			pData[playerid][pInBiz] = -1;
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			SetCameraBehindPlayer(playerid);
			SetPlayerWeather(playerid, WorldWeather);
		}
		//Family
		foreach(new fid : FAMILYS)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.8, fData[fid][fExtposX], fData[fid][fExtposY], fData[fid][fExtposZ]))
			{
				if(fData[fid][fIntposX] == 0.0 && fData[fid][fIntposY] == 0.0 && fData[fid][fIntposZ] == 0.0)
					return Error(playerid, "The interior is still empty, or does not have an interior.");

				if(pData[playerid][pFaction] == 0)
					if(pData[playerid][pFamily] == -1)
						return Error(playerid, "You dont have registered for this door!");
					
				pData[playerid][pInFamily] = fid;		
				SetPlayerPositionEx(playerid, fData[fid][fIntposX], fData[fid][fIntposY], fData[fid][fIntposZ], fData[fid][fIntposA]);

				SetPlayerInterior(playerid, fData[fid][fInt]);
				SetPlayerVirtualWorld(playerid, fid);
				SetCameraBehindPlayer(playerid);
				//pData[playerid][pInBiz] = fid;
				SetPlayerWeather(playerid, 0);
			}
			new difamily = pData[playerid][pInFamily];
			if(pData[playerid][pInFamily] != -1 && IsPlayerInRangeOfPoint(playerid, 2.8, fData[difamily][fIntposX], fData[difamily][fIntposY], fData[difamily][fIntposZ]))
			{
				pData[playerid][pInFamily] = -1;	
				SetPlayerPositionEx(playerid, fData[difamily][fExtposX], fData[difamily][fExtposY], fData[difamily][fExtposZ], fData[difamily][fExtposA]);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetCameraBehindPlayer(playerid);
				SetPlayerWeather(playerid, WorldWeather);
			}
        }
	}
	return 1;
}

CMD:drag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid))
        return Usage(playerid, "/drag [playerid/PartOfName] || /undrag [playerid]");

    if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "That player is disconnected.");

    if(otherid == playerid)
        return Error(playerid, "You cannot drag yourself.");

    if(!NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "You must be near the player.");

    if(!pData[otherid][pInjured])
        return Error(playerid, "You cannot drag a player who is not injured.");

    SetPVarInt(otherid, "DragBy", playerid);
	SendConfirmation(otherid, playerid, "drag", 0); // ✅ data = 0

	Info(playerid, "You have successfully offered to drag player %s", ReturnName(otherid));
    return 1;
}

CMD:undrag(playerid, params[])
{
	new otherid;
    if(sscanf(params, "u", otherid)) return Usage(playerid, "/undrag [playerid]");
	if(pData[otherid][pDragged])
    {
        DeletePVar(playerid, "DragBy");
        DeletePVar(otherid, "DragBy");
        pData[otherid][pDragged] = 0;
        pData[otherid][pDraggedBy] = INVALID_PLAYER_ID;

        KillTimer(pData[otherid][pDragTimer]);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "** %s releases %s from their grip.", ReturnName(playerid), ReturnName(otherid));
    }
    return 1;
}

CMD:myproperty(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_GPS_PROPERTIES, DIALOG_STYLE_LIST, "My Properties", "House\nBusiness\nDealership\nVending Machine\nVehicle", "Select", "Close");
    return 1;
}

CMD:mask(playerid, params[])
{
    if(pData[playerid][pMask] <= 0)
        return Error(playerid, "Anda tidak memiliki topeng!");
    
    new labeltext[128];
    
    switch(pData[playerid][pMaskOn])
    {
        case 0: // Pasang Mask
        {
            pData[playerid][pMaskOn] = 1;
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a mask and puts it on.", ReturnName(playerid));
            
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            {
                format(labeltext, sizeof(labeltext), "Mask_#%d {ffffff}(%d)", pData[playerid][pMaskID], playerid);
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
            }
        }
        case 1: // Lepas Mask
        {
            pData[playerid][pMaskOn] = 0;
            SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes their mask off and puts it away.", ReturnName(playerid));
            
            if(IsValidDynamic3DTextLabel(PlayerLabel[playerid]))
            {
                format(labeltext, sizeof(labeltext), "%s (%d)", GetRPName(playerid), playerid);
                UpdateDynamic3DTextLabelText(PlayerLabel[playerid], COLOR_WHITE, labeltext);
            }
        }
    }
    return 1;
}

CMD:stuck(playerid)
{
	if(pData[playerid][pFreeze] == 1)
		return Error(playerid, "You are currently frozen by staff, you cannot use this");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	ShowPlayerDialog(playerid, DIALOG_STUCK, DIALOG_STYLE_LIST,"Stuck Options","Tersangkut Di Gedung\nTersangkut setelah masuk/keluar Interior\nTersangkut di Kendaraan","Pilih","Batal");
	return 1;
}
//Text and Chat Commands
CMD:try(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/try [action]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s, %s", params[64], (random(2) == 0) ? ("and success") : ("but fail"));
    }
    else {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s, %s", ReturnName(playerid), params, (random(2) == 0) ? ("and success") : ("but fail"));
    }
	printf("[TRY] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ado(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ado [text]");
		Info(playerid, "Use /ado off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pAdoActive])
            return Error(playerid, "You're not actived your 'ado' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pAdoTag]);

        Servers(playerid, "You're removed your ado text.");
        pData[playerid][pAdoActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [ADO]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pAdoActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pAdoTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pAdoTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pAdoActive] = true;
        pData[playerid][pAdoTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[ADO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ab(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164], Float:x, Float:y, Float:z;

    if(isnull(params))
	{
        Usage(playerid, "/ab [text]");
		Info(playerid, "Use /ab off to disable or delete the ado tag.");
		return 1;
	}
    if(strlen(params) > 128)
        return Error(playerid, "Max text can only maximmum 128 characters.");

    if (!strcmp(params, "off", true))
    {
        if (!pData[playerid][pBActive])
            return Error(playerid, "You're not actived your 'ab' text.");

        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            DestroyDynamic3DTextLabel(pData[playerid][pBTag]);

        Servers(playerid, "You're removed your ab text.");
        pData[playerid][pBActive] = false;
        return 1;
    }

    FixText(params);
    format(flyingtext, sizeof(flyingtext), "* %s *\n(( OOC : %s ))", ReturnName(playerid), params);

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* [AB]: %s", params);
    }

    GetPlayerPos(playerid, x, y, z);
    if(pData[playerid][pBActive])
    {
        if (IsValidDynamic3DTextLabel(pData[playerid][pBTag]))
            UpdateDynamic3DTextLabelText(pData[playerid][pBTag], COLOR_PURPLE, flyingtext);
        else
            pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
    else
    {
        pData[playerid][pBActive] = true;
        pData[playerid][pBTag] = CreateDynamic3DTextLabel(flyingtext, COLOR_PURPLE, x, y, z, 15, _, _, 1, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
    }
	printf("[AB] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:ame(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    new flyingtext[164];

    if(isnull(params))
        return Usage(playerid, "/ame [action]");

    if(strlen(params) > 128)
        return Error(playerid, "Max action can only maximmum 128 characters.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    format(flyingtext, sizeof(flyingtext), "* %s %s*", ReturnName(playerid), params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_PURPLE, 10.0, 10000);
	printf("[AME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:me(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/me [action]");
	
	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s %s", ReturnName(playerid), params);
    }
	printf("[ME] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:do(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/do [description]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %.64s ..", params);
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, ".. %s (( %s ))", params[64], ReturnName(playerid));
    }
    else 
	{
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s (( %s ))", params, ReturnName(playerid));
    }
	printf("[DO] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:toglog(playerid)
{
	if(!pData[playerid][pTogLog])
	{
		pData[playerid][pTogLog] = 1;
		Info(playerid, "You have disabled server logging");
	}
	else
	{
		pData[playerid][pTogLog] = 0;
		Info(playerid, "You have enabled server logging");
	}
	return 1;
}

CMD:togphone(playerid)
{
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You do not have a phone!");
	if(!pData[playerid][pPhoneStatus])
	{
		pData[playerid][pPhoneStatus] = 1;
		Servers(playerid, "You have turned on your phone");
	}
	else
	{
		pData[playerid][pPhoneStatus] = 0;
		Servers(playerid, "You have turned off your phone");
	}
	return 1;

}
CMD:togpm(playerid)
{
	if(!pData[playerid][pTogPM])
	{
		pData[playerid][pTogPM] = 1;
		Info(playerid, "You have disabled PM");
	}
	else
	{
		pData[playerid][pTogPM] = 0;
		Info(playerid, "You have enabled PM");
	}
	return 1;
}

CMD:togads(playerid)
{
	if(!pData[playerid][pTogAds])
	{
		pData[playerid][pTogAds] = 1;
		Info(playerid, "You have disabled Ads.");
	}
	else
	{
		pData[playerid][pTogAds] = 0;
		Info(playerid, "You have enabled Ads.");
	}
	return 1;
}

CMD:togwt(playerid)
{
	if(!pData[playerid][pTogWT])
	{
		pData[playerid][pTogWT] = 1;
		Info(playerid, "You have disabled Walkie Talkie.");
	}
	else
	{
		pData[playerid][pTogWT] = 0;
		Info(playerid, "You have enabled Walkie Talkie.");
	}
	return 1;
}

CMD:pm(playerid, params[])
{
    static text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/pm [playerid/PartOfName] [message]");

    /*if(pData[playerid][pTogPM])
        return Error(playerid, "You must enable private messaging first.");*/

    /*if(pData[otherid][pAdminDuty])
        return Error(playerid, "You can't pm'ing admin duty now!");*/
		
	if(otherid == INVALID_PLAYER_ID)
        return Error(playerid, "The player you are trying to reach is not valid.");

    if(otherid == playerid)
        return Error(playerid, "You cannot PM yourself.");

    if(pData[otherid][pTogPM] && pData[playerid][pAdmin] < 1)
        return Error(playerid, "The player has disabled PM.");

    if(IsPlayerInRangeOfPoint(otherid, 50, 2184.32, -1023.32, 1018.68))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

    //GameTextForPlayer(otherid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~n~~y~New message!", 3000, 3);
    PlayerPlaySound(otherid, 1085, 0.0, 0.0, 0.0);

    SendClientMessageEx(otherid, COLOR_YELLOW, "(( PM from %s (%d): %s ))", pData[playerid][pName], playerid, text);
    SendClientMessageEx(playerid, COLOR_YELLOW, "(( PM to %s (%d): %s ))", pData[otherid][pName], otherid, text);
	//Info(otherid, "/togpm for tog enable/disable PM");

    foreach(new i : Player) if((pData[i][pAdmin]) && pData[playerid][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_LIGHTGREEN, "[SPY PM] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:whisper(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new text[128], otherid;
    if(sscanf(params, "us[128]", otherid, text))
        return Usage(playerid, "/(w)hisper [playerid/PartOfName] [text]");

    if(otherid == INVALID_PLAYER_ID || !NearPlayer(playerid, otherid, 5.0))
        return Error(playerid, "Player itu Disconnect or not near you.");

    if(otherid == playerid)
        return Error(playerid, "You can't whisper yourself.");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(text) > 64) 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %.64s", ReturnName(playerid), playerid, text);
        SendClientMessageEx(otherid, COLOR_YELLOW, "...%s **", text[64]);

        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %.64s", ReturnName(otherid), otherid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "...%s **", text[64]);
    }
    else 
	{
        SendClientMessageEx(otherid, COLOR_YELLOW, "** Whisper from %s (%d): %s **", ReturnName(playerid), playerid, text);
        SendClientMessageEx(playerid, COLOR_YELLOW, "** Whisper to %s (%d): %s **", ReturnName(otherid), otherid, text);
    }
    SendNearbyMessage(playerid, 10.0, COLOR_PURPLE, "* %s mutters something in %s's ear.", ReturnName(playerid), ReturnName(otherid));
	
	foreach(new i : Player) if((pData[i][pAdmin]) && pData[i][pSPY] > 0)
    {
        SendClientMessageEx(i, COLOR_YELLOW2, "[SPY Whisper] %s (%d) to %s (%d): %s", pData[playerid][pName], playerid, pData[otherid][pName], otherid, text);
    }
    return 1;
}

CMD:l(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(l)ow [low text]");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
	if(IsPlayerInAnyVehicle(playerid))
	{
		foreach(new i : Player)
		{
			if(IsPlayerInAnyVehicle(i) && GetPlayerVehicleID(i) == GetPlayerVehicleID(playerid))
			{
				if(strlen(params) > 64) 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %.64s ..", ReturnName(playerid), params);
					SendClientMessageEx(i, COLOR_WHITE, "...%s", params[64]);
				}
				else 
				{
					SendClientMessageEx(i, COLOR_WHITE, "[car] %s says: %s", ReturnName(playerid), params);
				}
				printf("[CAR] %s(%d) : %s", pData[playerid][pName], playerid, params);
			}
		}
	}
	else
	{
		if(strlen(params) > 64) 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %.64s ..", ReturnName(playerid), params);
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "...%s", params[64]);
		}
		else 
		{
			SendNearbyMessage(playerid, 5.0, COLOR_WHITE, "[low] %s says: %s", ReturnName(playerid), params);
		}
		printf("[LOW] %s(%d) : %s", pData[playerid][pName], playerid, params);
	}
    return 1;
}

CMD:s(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(isnull(params))
        return Usage(playerid, "/(s)hout [shout text] /ds for in the door");

	if(GetPVarType(playerid, "Caps")) UpperToLower(params);
    if(strlen(params) > 64) 
	{
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "%s shouts: %.64s ..", ReturnName(playerid), params);
        SendNearbyMessage(playerid, 40.0, COLOR_WHITE, "...%s!", params[64]);
    }
    else 
	{
        SendNearbyMessage(playerid, 30.0, COLOR_WHITE, "%s shouts: %s!", ReturnName(playerid), params);
    }
	new flyingtext[128];
	format(flyingtext, sizeof(flyingtext), "%s!", params);
    SetPlayerChatBubble(playerid, flyingtext, COLOR_WHITE, 10.0, 10000);
	printf("[SHOUTS] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:b(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "OOC Zone, Ketik biasa saja");

    if(isnull(params))
        return Usage(playerid, "/b [local OOC]");
		
	if(pData[playerid][pAdminDuty] == 1)
    {
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_RED, "%s:"WHITE_E" (( %s ))", GetRPName(playerid), params);
            return 1;
        }
	}
	else
	{
		if(strlen(params) > 64)
		{
			SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %.64s ..", GetRPName(playerid), params);
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, ".. %s ))", params[64]);
		}
		else
        {
            SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s: (( %s ))", GetRPName(playerid), params);
            return 1;
        }
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
	new str[150];
	format(str,sizeof(str),"[OOC] %s: %s", GetRPName(playerid), params);
	LogServer("Chat", str);
	new dc[200];
	format(str, sizeof(str), "```[LOG CHAT OOC] %s: (( %s ))```", GetRPName(playerid), params);
	SendDiscordMessage(2, dc);
    return 1;
}

CMD:t(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(isnull(params))
		return Usage(playerid, "/t [typo text]");

	if(strlen(params) < 10)
	{
		SendNearbyMessage(playerid, 20.0, COLOR_WHITE, "%s : %.10s*", ReturnName(playerid), params);
	}
	//printf("[OOC] %s(%d) : %s", pData[playerid][pName], playerid, params);
    return 1;
}

CMD:phone(playerid, params[])
{
	if (pData[playerid][pPhone] == 0) 
    	return Error(playerid, "You do not have a phone!");
	//if (pData[playerid][pPhoneStatus] == 0) 
    	//return Error(playerid, "Your phone is turned off.");


	ShowPlayerDialog(playerid, DIALOG_PHONE, DIALOG_STYLE_LIST,"Phone","Call\nContact\nGPS\nM-Banking\nSms\nAdsvertisement\nRequest Location\nSettings", "Select", "Cancel");
	return 1;
}

CMD:call(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph;
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You do not have a phone!");
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Your phone is turned off.");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "You do not have a phone credits!");
	
	Usage(playerid, "/call [phone number] 933 - Taxi or Mechanic Call | 911 - Emergency Call");
	
	// 911 Emergency Call - Set status menunggu konfirmasi
	if(ph == 911)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		// Set player sedang dalam proses 911 call
		SetPVarInt(playerid, "Calling911", 1);
		Custom(playerid, "SERVICE: "WHITE_E"911 Emergency Call 'police' or 'paramedic'");
		return 1;
	}
	
	// 933 Taxi Call
	if(ph == 911)
	{
		if(pData[playerid][pCallTime] >= gettime())
			return Error(playerid, "You must wait %d seconds before sending another call.", pData[playerid][pCallTime] - gettime());
		
		// Set player sedang dalam proses 933 call
		SetPVarInt(playerid, "Calling933", 1);
		Custom(playerid, "SERVICE: "WHITE_E"933 Service Call 'taxi' or 'mechanic'");
		return 1;
	}
	
	// Regular phone call
	if(ph == pData[playerid][pPhone]) return Error(playerid, "Nomor sedang sibuk!");
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][IsLoggedIn] == false || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			if(pData[ii][pPhoneStatus] == 0) return Error(playerid, "Cannot make the call, the targeted phone is inactive.");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(pData[ii][pCall] == INVALID_PLAYER_ID)
			{
				pData[playerid][pCall] = ii;
				
				SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE to %d] "WHITE_E"phone begins to ring, please wait for answer!", ph);
				SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE from %d] "WHITE_E"Your phonecell is ringing, type '/p' to answer it!", pData[playerid][pPhone]);
				PlayerPlaySound(playerid, 3600, 0,0,0);
				PlayerPlaySound(ii, 6003, 0,0,0);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
				SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s takes out a cellphone and calling someone.", ReturnName(playerid));
				return 1;
			}
			else
			{
				Error(playerid, "Nomor ini sedang sibuk.");
				return 1;
			}
		}
	}
	return 1;
}

CMD:p(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pCall] != INVALID_PLAYER_ID)
		return Error(playerid, "You are already on a call!");
		
	if(pData[playerid][pInjured] != 0)
		return Error(playerid, "You cant do that in this time.");
		
	foreach(new ii : Player)
	{
		if(playerid == pData[ii][pCall])
		{
			pData[ii][pPhoneCredit]--;
			
			pData[playerid][pCall] = ii;
			SendClientMessageEx(ii, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] "WHITE_E"phone is connected, type '/hu' to stop!");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USECELLPHONE);
			SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s answers their cellphone.", ReturnName(playerid));
			return 1;
		}
	}
	return 1;
}

CMD:hu(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new caller = pData[playerid][pCall];
	if(IsPlayerConnected(caller) && caller != INVALID_PLAYER_ID)
	{
		pData[caller][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(caller, SPECIAL_ACTION_STOPUSECELLPHONE);
		SendNearbyMessage(caller, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(caller));
		
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s puts away their cellphone.", ReturnName(playerid));
		pData[playerid][pCall] = INVALID_PLAYER_ID;
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_STOPUSECELLPHONE);
	}
	return 1;
}

CMD:sms(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	new ph, text[50];
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You do not have a phone!");
	if(pData[playerid][pPhoneCredit] <= 0) return Error(playerid, "You do not have a phone credits!");
	if(pData[playerid][pInjured] != 0) return Error(playerid, "You cant do at this time.");
	
	if(sscanf(params, "ds[50]", ph, text))
        return Usage(playerid, "/sms [phone number] [message max 50 text]");
	
	foreach(new ii : Player)
	{
		if(pData[ii][pPhone] == ph)
		{
			if(pData[ii][pPhoneStatus] == 0) return Error(playerid, "Cannot send SMS, the phone you are trying to reach is offline.");
			if(IsPlayerInRangeOfPoint(ii, 20, 2179.9531,-1009.7586,1021.6880))
				return Error(playerid, "Anda tidak dapat melakukan ini, orang yang dituju sedang berada di OOC Zone");

			if(ii == INVALID_PLAYER_ID || !IsPlayerConnected(ii)) return Error(playerid, "This number is not actived!");
			SendClientMessageEx(playerid, COLOR_YELLOW, "[SMS to %d]"WHITE_E" %s", ph, text);
			SendClientMessageEx(ii, COLOR_YELLOW, "[SMS from %d]"WHITE_E" %s", pData[playerid][pPhone], text);
			Info(ii, "Gunakan "LB_E"'@<text>' "WHITE_E"untuk membalas SMS!");
			PlayerPlaySound(ii, 6003, 0,0,0);
			pData[ii][pSMS] = pData[playerid][pPhone];
			
			pData[playerid][pPhoneCredit] -= 1;
			return 1;
		}
	}
	return 1;
}

CMD:number(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pPhoneBook] == 0)
		return Error(playerid, "You dont have a phone book.");
	
	new otherid;
	if(sscanf(params, "u", otherid))
        return Usage(playerid, "/number [playerid]");
	
	if(!IsPlayerConnected(otherid))
		return Error(playerid, "That player is not listed in phone book.");
		
	if(pData[otherid][pPhone] == 0)
		return Error(playerid, "That player is not listed in phone book.");
	
	SendClientMessageEx(playerid, COLOR_YELLOW, "[CELLPHONE] Name: %s | Ph: %d.", ReturnName(otherid), pData[otherid][pPhone]);
	return 1;
}


CMD:setfreq(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
	
	new channel;
	if(sscanf(params, "d", channel))
		return Usage(playerid, "/setfreq [channel 1 - 1000]");
	
	if(pData[playerid][pTogWT] == 1) return Error(playerid, "Your walkie talkie is turned off.");
	if(channel == pData[playerid][pWT]) return Error(playerid, "You are already in this channel.");
	
	if(channel > 0 && channel <= 1000)
	{
		foreach(new i : Player)
		{
		    if(pData[i][pWT] == channel)
		    {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s has joined in to this channel!", ReturnName(playerid));
		    }
		}
		Info(playerid, "You have set your walkie talkie channel to "LIME_E"%d", channel);
		pData[playerid][pWT] = channel;
	}
	else
	{
		Error(playerid, "Invalid channel id! 1 - 1000");
	}
	return 1;
}

CMD:wt(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

	if(pData[playerid][pWT] == 0)
		return Error(playerid, "You dont have walkie talkie!");
		
	if(pData[playerid][pTogWT] == 1)
		return Error(playerid, "Your walkie talkie is turned off!");
	
	new msg[128];
	if(sscanf(params, "s[128]", msg)) return Usage(playerid, "/wt [message]");
	foreach(new i : Player)
	{
	    if(pData[i][pTogWT] == 0)
	    {
	        if(pData[i][pWT] == pData[playerid][pWT])
	        {
				SendClientMessageEx(i, COLOR_LIME, "[WT] "WHITE_E"%s: %s", ReturnName(playerid), msg);
	        }
	    }
	}
	return 1;
}

CMD:saved(playerid, params[])
{
	if(IsAtEvent[playerid] == 1)
    {
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    }

    // Cek apakah pemain yang memanggil perintah sudah login
    if(pData[playerid][IsLoggedIn] == false)
    {
        return Error(playerid, "You are not logged in!");
    }
	//UpdateWeapons(playerid);
	UpdatePlayerData(playerid);
	Info(playerid, "Your data have been saved!");
	return 1;
}

CMD:tutorial(playerid, params[])
{
    // Teks pesan tutorial
    new mstr[1000];
    format(mstr, sizeof(mstr), ""WHITE_E"Selamat datang di tutorial server kami!\n\n\
        Di sini Anda akan mempelajari cara bermain dan fitur-fitur server ini.\n\n\
        Sebagai warga baru:\n\
        1. Gunakan "BLUE_E"'/claimsp'"WHITE_E" untuk mendapatkan starterpack awal.\n\
        2. Anda bisa membuat ID card di City Hall.\n\
        3. Buat SIM di DMV untuk mengemudikan kendaraan.\n\
        4. Mulailah bekerja di sidejob untuk mendapatkan uang.\n\
        5. Beli HP di toko elektronik untuk komunikasi lebih mudah.\n\n\
        Jika Anda kebingungan, gunakan perintah "YELLOW_E"'/help'"WHITE_E" untuk bantuan lebih lanjut.\n\
        Untuk mencari lokasi, gunakan perintah "YELLOW_E"'/gps'"WHITE_E" GPS bisa dibeli di toko elektronik.");

    // Menampilkan dialog kepada pemain
    ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Valencia Roleplay Tutorial", mstr, "Close", "");

	return 1;
}

/*CMD:ads(playerid, params[])
{
	if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Tidak dapat iklan, Ponsel anda sedang Offline");

	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -192.3483, 1338.7361, 1500.9823)) 
        return Error(playerid, "You must in SANA Station!");

	if(pData[playerid][pDelayIklan] > 0) return Error(playerid, "Kamu masih cooldown %d detik", pData[playerid][pDelayIklan]);
	if(pData[playerid][pPhone] == 0) return Error(playerid, "You do not have a phone!");
	
	if(isnull(params))
	{
		Usage(playerid, "/ads [text] | 1 character pay $2");
		return 1;
	}
	if(strlen(params) >= 100 ) return Error(playerid, "Maximum character is 100 text." );
	new payout = strlen(params) * 2;
	if(GetPlayerMoney(playerid) < payout) return Error(playerid, "Not enough money.");
	
	GivePlayerMoneyEx(playerid, -payout);
	Server_AddMoney(payout);
	pData[playerid][pDelayIklan] = 500;
	foreach(new ii : Player)
	{
		if(pData[ii][pTogAds] == 0)
		{
			SendClientMessageEx(ii, COLOR_RED, "Ad: "GREEN_E"%s.", params);
			SendClientMessageEx(ii, COLOR_RED, "Contact Info: ["GREEN_E"%s"RED_E"] Phone Number: ["GREEN_E"%d"RED_E"]", pData[playerid][pName], pData[playerid][pPhone]);
		}
	}
	//SendClientMessageToAllEx(COLOR_ORANGE2, "[ADS] "GREEN_E"%s.", params);
	//SendClientMessageToAllEx(COLOR_ORANGE2, "Contact Info: ["GREEN_E"%s"ORANGE_E2"] Ph: ["GREEN_E"%d"ORANGE_E2"] Bank Rek: ["GREEN_E"%d"ORANGE_E2"]", pData[playerid][pName], pData[playerid][pPhone], pData[playerid][pBankRek]);
	return 1;
}
CMD:ad(playerid, params[])
{
    if(pData[playerid][pPhoneStatus] == 0) return Error(playerid, "Cannot advertise, your phone is offline.");

    if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
        return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");

    if(!IsPlayerInRangeOfPoint(playerid, 3.0, -192.3483, 1338.7361, 1500.9823)) return Error(playerid, "You must in SANA Station!");
    if(pData[playerid][pDelayIklan] > 0) return Error(playerid, "You have to wait %d minutes.", pData[playerid][pDelayIklan] / 60);
    if(pData[playerid][pPhone] == 0) return Error(playerid, "You do not have a phone!");

    ShowPlayerDialog(playerid, DIALOG_ADS, DIALOG_STYLE_LIST, "San News Advertise Service Category", "Events\nProperties\nAutomotive\nItem\nService\nOther", "Choose", "Close");
    return 1;
}
*/
CMD:ads(playerid, params[])
{
	ShowAdvertisements(playerid);
	return 1;
}

CMD:ad(playerid, params[])
{
	// Cek delay iklan
	if(pData[playerid][pDelayIklan] > 0) 
		return Error(playerid, "Please wait %d second(s) before post another ad.", pData[playerid][pDelayIklan]);
	
	// Validasi phone
	if(pData[playerid][pPhone] < 1) 
		return Error(playerid, "You dont have phone!");
	
	// VIP 2+ - Bisa iklan dari mana saja
	if(pData[playerid][pVip] > 1)
	{
		// Langsung tampilkan dialog input text
		ShowPlayerDialog(playerid, DIALOG_ADS1, DIALOG_STYLE_INPUT, "San News Advertise Service", 
		""WHITE_E"Please write your "YELLOW_E"advertisement "WHITE_E"in the dialog box:\n\n"GREEN_E"** Maximal words can be writed is 128 characters.", 
		"Next", "Cancel");
	}
	// Non-VIP - Harus ke SANA Station
	else
	{
		// Cek apakah player berada di OOC Zone
		if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
			return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
		
		// Cek apakah player berada di SANA Station
		if(!IsPlayerInRangeOfPoint(playerid, 3.0, -192.3483, 1338.7361, 1500.9823)) 
			return Error(playerid, "You must in SANA Station!");
		
		// Langsung tampilkan dialog input text
		ShowPlayerDialog(playerid, DIALOG_ADS1, DIALOG_STYLE_INPUT, "San News Advertise Service", 
		""WHITE_E"Please write your "YELLOW_E"advertisement "WHITE_E"in the dialog box:\n\n"GREEN_E"** Maximum characters: 200\n"RED_E"** Price: $2 per character", 
		"Next", "Cancel");
	}
	return 1;
}

//------------------[ Bisnis and Buy Commands ]-------
CMD:buy(playerid, params[])
{
	//UpdatePlayerData(playerid);
	if(IsPlayerInRangeOfPoint(playerid, 50, 2184.32, -1023.32, 1018.68))
		return Error(playerid, "Anda tidak dapat melakukan ini jika sedang berada di OOC Zone");
	//trucker product
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 1208.0065, 185.8374, 20.5067))
	{
		if(pData[playerid][pJob] == 4 || pData[playerid][pJob2] == 4)
		{
			if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				new modelid = GetVehicleModel(vehicleid);
				
				// Check if vehicle is one of the allowed trucker vehicles
				if(modelid == 414 || modelid == 456 || modelid == 499 || modelid == 498)
				{
					new mstr[256];
					format(mstr, sizeof(mstr), ""WHITE_E"Input the product quantity.\nProduct Stock: "GREEN_E"%d\n"WHITE_E"Product Price"GREEN_E" %s / item", Product, FormatMoney(ProductPrice));
					ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
				}
				else return Error(playerid, "You must use a trucker vehicle (Mule, Yankee, Benson, or Boxville).");
			}
			else return Error(playerid, "You are not in vehicle trucker.");
		}
		else return Error(playerid, "You are not trucker job.");
	}
	//Gasoil
	if(IsPlayerInRangeOfPoint(playerid, 3.5, 336.70, 895.54, 20.40))
	{
		if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
			return Error(playerid, "You are not trucker job.");
		
		if(pData[playerid][pJobTime] > 0)
			return Error(playerid, "You must wait %d seconds to perform this action.", pData[playerid][pJobTime]);
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return Error(playerid, "You must be driving a vehicle.");
		
		// ✅ CEK APAKAH ADA TRAILER ATTACHED
		new trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));
		if(!trailerid) // Atau cek: if(trailerid == 0 || trailerid == INVALID_VEHICLE_ID)
			return Error(playerid, "Your vehicle trailer is not attached!");
		
		// ✅ CEK APAKAH TRAILER ADALAH TRUCKER TRAILER
		new vehicleid = GetPlayerVehicleID(playerid);
		new modelid = GetVehicleModel(vehicleid);
		
		// Model trucker dengan trailer: 403 (Linerunner), 514 (Tanker), 515 (Roadtrain), dll
		if(modelid != 403 && modelid != 514 && modelid != 515)
			return Error(playerid, "You are not in a trucker vehicle.");
		
		// ✅ TAMPILKAN DIALOG
		new mstr[256];
		format(mstr, sizeof(mstr),"{FFFFFF}Input the gasoil quantity:\nGasOil Stock: {00FF00}%d\n{FFFFFF}GasOil Price: {00FF00}%s {FFFFFF}/ liter", GasOil, FormatMoney(GasOilPrice));
		ShowPlayerDialog(playerid, DIALOG_GASOIL, DIALOG_STYLE_INPUT, "Buy GasOil", mstr, "Buy", "Cancel");
	}
	//restok dealer
	if(IsPlayerInRangeOfPoint(playerid, 3.5, -198.4669, -203.1409, 1.4219))
	{
		if(pData[playerid][pJob] != 4 && pData[playerid][pJob2] != 4)
			return Error(playerid, "You are not trucker job.");
		
		if(pData[playerid][pJobTime] > 0)
			return Error(playerid, "You must wait %d seconds to perform this action.", pData[playerid][pJobTime]);
		
		if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
			return Error(playerid, "You must be driving a vehicle.");
		
		// ✅ CEK APAKAH ADA TRAILER ATTACHED
		new trailerid = GetVehicleTrailer(GetPlayerVehicleID(playerid));
		if(!trailerid) // Atau cek: if(trailerid == 0 || trailerid == INVALID_VEHICLE_ID)
			return Error(playerid, "Your vehicle trailer is not attached!");
		
		// ✅ CEK APAKAH TRAILER ADALAH TRUCKER TRAILER
		new vehicleid = GetPlayerVehicleID(playerid);
		new modelid = GetVehicleModel(vehicleid);
		
		// Model trucker dengan trailer: 403 (Linerunner), 514 (Tanker), 515 (Roadtrain), dll
		if(modelid != 403 && modelid != 514 && modelid != 515)
			return Error(playerid, "You are not in a trucker vehicle.");
		
		// ✅ TAMPILKAN DIALOG
		new mstr[256];
		format(mstr, sizeof(mstr),"{FFFFFF}Input the product quantity:\nProduct Stock: {00FF00}%d\n{FFFFFF}Product Price: {00FF00}%s {FFFFFF}/ item", Product, FormatMoney(ProductPrice));
		ShowPlayerDialog(playerid, DIALOG_PRODUCT, DIALOG_STYLE_INPUT, "Buy Product", mstr, "Buy", "Cancel");
	}
	//Material
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -258.54, -2189.92, 28.97))
	{
		if(pData[playerid][pMaterial] >= 500) return Error(playerid, "Anda sudah membawa 500 Material!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Input the material quantity:\nMaterial Stock: "GREEN_E"%d\n"WHITE_E"Material Price"GREEN_E" %s / item", Material, FormatMoney(MaterialPrice));
		ShowPlayerDialog(playerid, DIALOG_MATERIAL, DIALOG_STYLE_INPUT, "Buy Material", mstr, "Buy", "Cancel");
	}
	//Component
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 854.5555, -605.2056, 18.4219))
	{
		if(pData[playerid][pComponent] >= 500) return Error(playerid, "Anda sudah membawa 500 Component!");
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Input the Component quantity:\nComponent Stock: "GREEN_E"%d\n"WHITE_E"Component Price"GREEN_E" %s / item", Component, FormatMoney(ComponentPrice));
		ShowPlayerDialog(playerid, DIALOG_COMPONENT, DIALOG_STYLE_INPUT, "Buy Component", mstr, "Buy", "Cancel");
	}
	//Apotek
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -1774.0746, -2005.6477, 1500.7853))
	{
		if(pData[playerid][pFaction] != 3)
			return Error(playerid, "Medical only!");
			
		new mstr[128];
		format(mstr, sizeof(mstr), "Product\tPrice\n\
		Medicine\t"GREEN_E"%s\n\
		Medkit\t"GREEN_E"%s\n\
		Bandage\t"GREEN_E"$100.00\n\
		", FormatMoney(MedicinePrice), FormatMoney(MedkitPrice));
		ShowPlayerDialog(playerid, DIALOG_APOTEK, DIALOG_STYLE_TABLIST_HEADERS, "Apotek", mstr, "Buy", "Cancel");
	}
	//Food and Seed
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -381.44, -1426.13, 25.93))
	{
		new mstr[512];
		format(mstr, sizeof(mstr), 
			"Product\tPrice\nFood\t"GREEN_E"%s\nSeed\t"GREEN_E"%s\n", 
			FormatMoney(FoodPrice), 
			FormatMoney(SeedPrice)
		);
		ShowPlayerDialog(playerid, DIALOG_FOOD, DIALOG_STYLE_TABLIST_HEADERS, "Food", mstr, "Buy", "Cancel");
	}
	//Drugs
	if(IsPlayerInRangeOfPoint(playerid, 2.5, 874.52, -15.98, 63.19))
	{
		if(pData[playerid][pMarijuana] >= 100) return Error(playerid, "Anda sudah membawa 100gr Marijuana!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Input the marijuana quantity:\nMarijuana Stock: "GREEN_E"%d\n"WHITE_E"Marijuana Price"GREEN_E" %s / item", Marijuana, FormatMoney(MarijuanaPrice));
		ShowPlayerDialog(playerid, DIALOG_DRUGS, DIALOG_STYLE_INPUT, "Buy Drugs", mstr, "Buy", "Cancel");
	}
	// Obat Myr
	if(IsPlayerInRangeOfPoint(playerid, 2.5, -1772.3304, -2013.1531, 1500.7853))
	{
		if(pData[playerid][pObat] >= 5) return Error(playerid, "Anda sudah membawa 5 Obat Myr!");
		
		new mstr[128];
		format(mstr, sizeof(mstr), ""WHITE_E"Input the obat quantity:\nObat Stock: "GREEN_E"%d\n"WHITE_E"Obat Price"GREEN_E" %s / item", ObatMyr, FormatMoney(ObatPrice));
		ShowPlayerDialog(playerid, DIALOG_OBAT, DIALOG_STYLE_INPUT, "Buy Obat", mstr, "Buy", "Cancel");
	}
	//Buy House
	foreach(new hid : Houses)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, hData[hid][hExtposX], hData[hid][hExtposY], hData[hid][hExtposZ]))
		{
			if(hData[hid][hPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this houses.");
			if(strcmp(hData[hid][hOwner], "-")) return Error(playerid, "Someone already owns this house.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 2) return Error(playerid, "You cannot buy more houses.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 3) return Error(playerid, "You cannot buy more houses.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 4) return Error(playerid, "You cannot buy more houses.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_HouseCount(playerid) + 1 > 1) return Error(playerid, "You cannot buy more houses.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -hData[hid][hPrice]);
			Server_AddMoney(hData[hid][hPrice]);
			GetPlayerName(playerid, hData[hid][hOwner], MAX_PLAYER_NAME);
			hData[hid][hOwnerID] = pData[playerid][pID];
			hData[hid][hVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[HOUSE]: %s membeli rumah id %d seharga %s!", GetRPName(playerid), hid, FormatMoney(hData[hid][hPrice]));
			LogServer("Property", str);

			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE houses SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", hData[hid][hOwner], hData[hid][hOwnerID], hData[hid][hVisit], hid);
			mysql_tquery(g_SQL, query);
			
			House_Refresh(hid);
		}
	}
	//Buy Bisnis
	foreach(new bid : Bisnis)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, bData[bid][bExtposX], bData[bid][bExtposY], bData[bid][bExtposZ]))
		{
			if(bData[bid][bPrice] > GetPlayerMoney(playerid)) return Error(playerid, "Not enough money, you can't afford this bisnis.");
			if(strcmp(bData[bid][bOwner], "-") || bData[bid][bOwnerID] != 0) return Error(playerid, "Someone already owns this bisnis.");
			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 2) return Error(playerid, "You cannot buy any more businesses.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 3) return Error(playerid, "You cannot buy any more businesses.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 4) return Error(playerid, "You cannot buy any more businesses.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_BisnisCount(playerid) + 1 > 1) return Error(playerid, "You cannot buy any more businesses.");
				#endif
			}
			GivePlayerMoneyEx(playerid, -bData[bid][bPrice]);
			Server_AddMoney(-bData[bid][bPrice]);
			GetPlayerName(playerid, bData[bid][bOwner], MAX_PLAYER_NAME);
			bData[bid][bOwnerID] = pData[playerid][pID];
			bData[bid][bVisit] = gettime();
			new str[150];
			format(str,sizeof(str),"[BIZ]: %s membeli bisnis id %d seharga %s!", GetRPName(playerid), bid, FormatMoney(bData[bid][bPrice]));
			LogServer("Property", str);
			
			new query[128];
			mysql_format(g_SQL, query, sizeof(query), "UPDATE bisnis SET owner='%s', ownerid='%d', visit='%d' WHERE ID='%d'", bData[bid][bOwner], bData[bid][bOwnerID], bData[bid][bVisit], bid);
			mysql_tquery(g_SQL, query);

			Bisnis_Refresh(bid);
		}
	}
	//Buy Bisnis menu
	if(pData[playerid][pInBiz] >= 0 && IsPlayerInRangeOfPoint(playerid, 2.5, bData[pData[playerid][pInBiz]][bPointX], bData[pData[playerid][pInBiz]][bPointY], bData[pData[playerid][pInBiz]][bPointZ]))
	{
		Bisnis_BuyMenu(playerid, pData[playerid][pInBiz]);
	}
	//Buy Vending Machine
	foreach(new vid : Vendings)
	{
		if(IsPlayerInRangeOfPoint(playerid, 2.5, VendingData[vid][vendingX], VendingData[vid][vendingY], VendingData[vid][vendingZ]))
		{
			if(VendingData[vid][vendingPrice] > GetPlayerMoney(playerid)) 
				return Error(playerid, "Not enough money, you can't afford this Vending.");

			if(strcmp(VendingData[vid][vendingOwner], "-") || VendingData[vid][vendingOwnerID] != 0) 
				return Error(playerid, "Someone already owns this Vending.");

			if(pData[playerid][pVip] == 1)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 2)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else if(pData[playerid][pVip] == 3)
			{
			    #if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}
			else
			{
				#if LIMIT_PER_PLAYER > 0
				if(Player_VendingCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more Vending.");
				#endif
			}

			SendClientMessageEx(playerid, COLOR_WHITE, "You has teleport to vending id %d", vid);
			GivePlayerMoneyEx(playerid, -VendingData[vid][vendingPrice]);
			Server_AddMoney(VendingData[vid][vendingPrice]);
			GetPlayerName(playerid, VendingData[vid][vendingOwner], MAX_PLAYER_NAME);
			VendingData[vid][vendingOwnerID] = pData[playerid][pID];
			new str[150];
			format(str,sizeof(str),"[VEND]: %s membeli vending id %d seharga %s!", GetRPName(playerid), vid, FormatMoney(VendingData[vid][vendingPrice]));
			LogServer("Property", str);
			
			Vending_RefreshText(vid);
			Vending_Save(vid);
		}
		
		//Buy Workshop
		foreach(new wid : Workshop)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, wsData[wid][wX], wsData[wid][wY], wsData[wid][wZ]))
			{
				if(wsData[wid][wPrice] > GetPlayerMoney(playerid))
					return Error(playerid, "Not enough money, you can't afford this workshop.");
				if(wsData[wid][wOwnerID] != 0 || strcmp(wsData[wid][wOwner], "-")) 
					return Error(playerid, "Someone already owns this workshop.");

				#if LIMIT_PER_PLAYER > 0
				if(Player_WorkshopCount(playerid) + 1 > 1) return Error(playerid, "You can't buy any more workshop.");
				#endif

				GivePlayerMoneyEx(playerid, -wsData[wid][wPrice]);
				Server_AddMoney(wsData[wid][wPrice]);
				GetPlayerName(playerid, wsData[wid][wOwner], MAX_PLAYER_NAME);
				wsData[wid][wOwnerID] = pData[playerid][pID];
				new str[150];
				format(str,sizeof(str),"[WS]: %s membeli workshop id %d seharga %s!", GetRPName(playerid), wid, FormatMoney(wsData[wid][wPrice]));
				LogServer("Property", str);

				Workshop_Refresh(wid);
				Workshop_Save(wid);
			}
			
		}
		//Buy dealership
		foreach(new did : Dealer)
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.5, dsData[did][dX], dsData[did][dY], dsData[did][dZ]))
			{
				// Cek uang
				if(GetPlayerMoney(playerid) < dsData[did][dPrice])
					return Error(playerid, "Not enough money, you can't afford this dealership.");
				
				// Cek ownership - UNTUK STRING
				if(strcmp(dsData[did][dOwner], "None", true) != 0 && strcmp(dsData[did][dOwner], "-", true) != 0)
					return Error(playerid, "Someone already owns this dealership.");

				#if LIMIT_PER_PLAYER > 0
				if(Player_DealerCount(playerid) + 1 > 1) 
					return Error(playerid, "You can't buy any more dealership.");
				#endif

				// Proses pembelian
				GivePlayerMoneyEx(playerid, -dsData[did][dPrice]);
				Server_AddMoney(dsData[did][dPrice]);
				GetPlayerName(playerid, dsData[did][dOwner], MAX_PLAYER_NAME); // Set owner name
				
				new str[150];
				format(str, sizeof(str), "[DS]: %s membeli dealership id %d seharga %s!", 
					GetRPName(playerid), did, FormatMoney(dsData[did][dPrice]));
				LogServer("Property", str);

				Dealer_Refresh(did);
				Dealer_Save(did);
				
				Servers(playerid, "You have successfully purchased this dealership for %s!", FormatMoney(dsData[did][dPrice]));
			}
			
		}
	}
	return 1;
}

forward Revive(playerid);
public Revive(playerid)
{
	new otherid = GetPVarInt(playerid, "gcPlayer");
	TogglePlayerControllable(playerid,1);
	Servers(playerid, "Sukses revive");
	pData[playerid][pObat] -= 1;
    pData[otherid][pInjured] = 0;
    pData[otherid][pHospital] = 0;
    pData[otherid][pSick] = 0;
    pData[otherid][pHead] = 100;
    pData[otherid][pPerut] = 100;
    pData[otherid][pRHand] = 100;
    pData[otherid][pLHand] = 100;
    pData[otherid][pRFoot] = 100;
    pData[otherid][pLFoot] = 100;
}


CMD:selfie(playerid,params[])
{
	if(takingselfie[playerid] == 0)
	{
	    GetPlayerPos(playerid,lX[playerid],lY[playerid],lZ[playerid]);
		static Float: n1X, Float: n1Y;
		if(Degree[playerid] >= 360) Degree[playerid] = 0;
		Degree[playerid] += Speed;
		n1X = lX[playerid] + Radius * floatcos(Degree[playerid], degrees);
		n1Y = lY[playerid] + Radius * floatsin(Degree[playerid], degrees);
		SetPlayerCameraPos(playerid, n1X, n1Y, lZ[playerid] + Height);
		SetPlayerCameraLookAt(playerid, lX[playerid], lY[playerid], lZ[playerid]+1);
		SetPlayerFacingAngle(playerid, Degree[playerid] - 90.0);
		takingselfie[playerid] = 1;
		ApplyAnimation(playerid, "PED", "gang_gunstand", 4.1, 1, 1, 1, 1, 1, 1);
		return 1;
	}
    if(takingselfie[playerid] == 1)
	{
	    TogglePlayerControllable(playerid,1);
		SetCameraBehindPlayer(playerid);
	    takingselfie[playerid] = 0;
	    ApplyAnimation(playerid, "PED", "ATM", 4.1, 0, 1, 1, 0, 1, 1);
	    return 1;
	}
    return 1;
}

CMD:claimsp(playerid, params)
{
	if(pData[playerid][pStarterpack] != 0)
	{
		return Error(playerid, "Starter pack has already been claimed.");
	}
	else
	{
		GivePlayerMoneyEx(playerid, 50000);
		pData[playerid][pGold] += 150;
		pData[playerid][pSnack] += 5;
		pData[playerid][pSprunk] += 5;
		pData[playerid][pGPS] = 1;
		//pData[playerid][pLevel] += 2;
		pData[playerid][pIDCard] = 1;
		pData[playerid][pIDCardTime] = gettime() + (30 * 86400);
		pData[playerid][pStarterpack] = 1;
		//pData[playerid][pLevelUp] += 24;
		
		new cQuery[1024];
		new Float:x,Float:y,Float:z, Float:a;
		GetPlayerPos(playerid, x ,y , z);
		GetPlayerFacingAngle(playerid, a);
		new model = 468, color1 = 1, color2 = 1;
		mysql_format(g_SQL, cQuery, sizeof(cQuery), "INSERT INTO `vehicle` (`owner`, `model`, `color1`, `color2`, `x`, `y`, `z`, `a`) VALUES (%d, %d, %d, %d, '%f', '%f', '%f', '%f')", pData[playerid][pID], model, color1, color2, x, y, z, a);
		mysql_tquery(g_SQL, cQuery, "OnVehStarterpack", "dddddffff", playerid, pData[playerid][pID], model, color1, color2, x, y, z, a);
	}
	return 1;	

}

DelaysPlayer(playerid, p2)
{
	new str[(1024 * 2)], headers[500];
	strcat(headers, "Name\tTime\n");

	if(pData[p2][pExitJob] > 0)
    {
        format(str, sizeof(str), "%s{ff0000}Exit Jobs{ffffff}\t%i Second\n", str, ReturnTimelapse(gettime(), pData[p2][pExitJob]));
	}
	if(pData[p2][pJobTime] > 0)
    {
        format(str, sizeof(str), "%sJobs\t%i Second\n", str, pData[p2][pJobTime]);
	}
    if(pData[p2][pSweeperTime] > 0)
    {
        format(str, sizeof(str), "%sSweeper (Sidejob)\t%i Second\n", str, pData[p2][pSweeperTime]);
	}
	if(pData[p2][pForklifterTime] > 0)
    {
        format(str, sizeof(str), "%sForklifter (Sidejob)\t%i Second\n", str, pData[p2][pForklifterTime]);
	}
	if(pData[p2][pBusTime] > 0)
    {
        format(str, sizeof(str), "%sBus (Sidejob)\t%i Second\n", str, pData[p2][pBusTime]);
	}
	if(pData[p2][pMowerTime] > 0)
    {
        format(str, sizeof(str), "%sMower (Sidejob)\t%i Second\n", str, pData[p2][pMowerTime]);
	}
	
	strcat(headers, str);

	ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_TABLIST_HEADERS, "Delays", headers, "Okay", "");
	return 1;
}

CMD:delays(playerid, params)
{
	DelaysPlayer(playerid, playerid);
}

CMD:washmoney(playerid, params[])
{
	new merah = pData[playerid][pRedMoney];
	new rumus = (merah/200)*10; // 5 discount percent
 	new total = merah-rumus;
	if(pData[playerid][pRedMoney] < 0)
	{
		return Error(playerid, "You do not have red money.");
	}
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, -427.3773, -392.3799, 16.5802))
	{
		return Error(playerid, "You must be at the money laundering location.");
	}
	Info(playerid, "You have laundered money and earned %s.", FormatMoney(total));
	pData[playerid][pRedMoney] -= total;
	GivePlayerMoneyEx(playerid, total);
	return 1;
}

CMD:clearchat(playerid, params[])
{
	ClearChat(playerid);
	return 1;
}

CMD:taclight(playerid, params[])
{
	if(!pData[playerid][pFlashlight]) 
		return Error(playerid, "You do not have a flashlight.");
	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 6, 0.25, -0.0175, 0.16, 86.5, -185, 86.5, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 6, 0.2, 0.01, 0.16, 90, -95, 90, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s attach the flashlight to the gun.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] = 1;
	}
	else
	{
		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take the flashlight off the gun.", ReturnName(playerid));
	}
	return 1;
}
CMD:flashlight(playerid, params[])
{
	if(!pData[playerid][pFlashlight])
		return Error(playerid, "You do not have a flashlight.");

	if(pData[playerid][pUsedFlashlight] == 0)
	{
		if(IsPlayerAttachedObjectSlotUsed(playerid,8)) RemovePlayerAttachedObject(playerid,8);
		if(IsPlayerAttachedObjectSlotUsed(playerid,9)) RemovePlayerAttachedObject(playerid,9);
		SetPlayerAttachedObject(playerid, 8, 18656, 5, 0.1, 0.038, -0.01, -90, 180, 0, 0.03, 0.1, 0.03);
		SetPlayerAttachedObject(playerid, 9, 18641, 5, 0.1, 0.02, -0.05, 0, 0, 0, 1, 1, 1);
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s take out the flashlight and turn on the flashlight.", ReturnName(playerid));

		pData[playerid][pUsedFlashlight] =1;
	}
	else
	{
 		RemovePlayerAttachedObject(playerid,8);
		RemovePlayerAttachedObject(playerid,9);
		pData[playerid][pUsedFlashlight] =0;
		SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "* %s turn off the flashlight and put it in.", ReturnName(playerid));
	}
	return 1;
}

CMD:newweaponlic(playerid, params[])
{
	if(!IsPlayerInRangeOfPoint(playerid, 3.0, -2578.5625, -1383.2179, 1500.7570)) return Error(playerid, "You must be at the SAPD Office!");
	if(pData[playerid][pDriveLic] != 0) return Error(playerid, "You already have a Weapon License!");
	if(GetPlayerMoney(playerid) < 400000) return Error(playerid, "You need $4,000.00 to create a Weapon License.");
	pData[playerid][pWeaponLic] = 1;
	pData[playerid][pWeaponLicTime] = gettime() + (30 * 86400);
	GivePlayerMoneyEx(playerid, -400000);
	Server_AddMoney(4000);
	return 1;
}
CMD:bbhelp(playerid, params[])
{
    Usage(playerid, "/use boombox /setbb /pickupbb");
    return 1;
}

CMD:setbb(playerid, params[])
{
    if (pData[playerid][pBoombox] == 0)
        return Error(playerid, "You do not have a boombox.");

    if (GetPVarType(playerid, "PlacedBB"))
    {
        if (IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
        {
            ShowPlayerDialog(playerid, DIALOG_BOOMBOX, DIALOG_STYLE_LIST, "Boombox", "Custom URL\nTurn off\nList Song", "Pilih", "Batal");
        }
        else
        {
            return Error(playerid, "You are not close to your boombox.");
        }
    }
    else
    {
        Error(playerid, "You have not placed the boombox");
    }
    return 1;
}

CMD:pickupbb(playerid, params[])
{
    if (pData[playerid][pBoombox] == 0)
        return Error(playerid, "You do not have a boombox.");

    if (!GetPVarInt(playerid, "PlacedBB"))
    {
        Info(playerid, "You do not have a placed boombox to pick up");
    }
    else if (IsPlayerInRangeOfPoint(playerid, 3.0, GetPVarFloat(playerid, "BBX"), GetPVarFloat(playerid, "BBY"), GetPVarFloat(playerid, "BBZ")))
    {
        PickUpBoombox(playerid);
        Custom(playerid, "BOOMBOX: "WHITE_E"You picked up the boombox.");
    }
    return 1;
}

CMD:cigar(playerid, params[])
{
	if(pData[playerid][pCigarette] < 1)
		return Error(playerid, "You do not have a cigarette!");

	if(pData[playerid][pIsSmoking])
		return Error(playerid, "You are already smoking!");

	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER || GetPlayerState(playerid) == PLAYER_STATE_PASSENGER)
		return Error(playerid, "You cannot smoke inside a vehicle!");

	// Kurangi rokok
	pData[playerid][pCigarette]--;

	SetPlayerArmedWeapon(playerid, 0);

    // Attach rokok ke tangan
	SetPlayerAttachedObject(playerid, 9, 19625, 6, 0.10, 0.03, 0.01, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0);
	SetPlayerAttachedObject(playerid, 8, 18673, 6, 0.14, 0.03, 0.10, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5);

	// Reset puff count
	pData[playerid][pCigPuffs] = 0;
	pData[playerid][pIsSmoking] = true;


	// Chat bubble
	SetPlayerChatBubble(playerid, "menyalakan rokok", COLOR_PURPLE, 10.0, 3000);
	return 1;
}
/*CMD:blindfold(playerid,params[])
{
    new targetid;
	if(sscanf(params, "u", targetid))
	{
	    return Usage(playerid, "/blindfold [playerid]");
	}
	if(pData[playerid][pBlindfold] <= 0)
	{
	    return Error(playerid, "Kamu tidak memiliki blindfold");
	}
	if(!IsPlayerInVehicle(targetid, GetPlayerVehicleID(playerid)))
	{
	    return Error(playerid, "Orang yang ditentukan terputus.");
	}
	if(GetPlayerState(targetid) == PLAYER_STATE_DRIVER)
	{
	    return Error(playerid, "Kamu tidak bisa menutup mata pengemudi.");
	}
	if(targetid == playerid)
	{
	    return Error(playerid, "Kamu tidak bisa menutup matamu sendiri.");
	}
	if(pBlind[targetid])
	{
	    return Error(playerid, "Orang itu sudah ditutup matanya. '/unblindfold' untuk melepas.");
	}
	if(pData[targetid][pAdminDuty])
	{
	    return Error(playerid, "Kamu tidak dapat menutup mata Administrator");
	}

	pData[playerid][pBlindfold]--;

	GameTextForPlayer(targetid, "~r~Penutup Mata", 3000, 3);
	SendProximityMessage(playerid, 20.0, SERVER_COLOR, "{C2A2DA} %s menutup mata %s dengan bandana.", GetRPName(playerid), GetRPName(targetid));

	TogglePlayerControllable(targetid, 0);
	TextDrawShowForPlayer(targetid, Blind);
	pBlind[targetid] = 1;
    return 1;
}

CMD:unblindfold(playerid, params[])
{
	new targetid;

	if(sscanf(params, "u", targetid))
	{
	    return SCM(playerid, COLOR_SYNTAX, "Gunakan: /unblindfold [playerid]");
	}
	if(!IsPlayerConnected(targetid) || !IsPlayerInRangeOfPlayer(playerid, targetid, 5.0))
	{
	    return Error(playerid, "Orang yang ditentukan terputus atau jauh darimu.");
	}
	if(targetid == playerid)
	{
	    return Error(playerid, "Kamu tidak dapat membuka penutup mata dirimu sendiri.");
	}
	if(!pBlind[targetid])
	{
	    return Error(playerid, "Orang itu bukan penutup mata.");
	}
	if(IsPlayerInAnyVehicle(targetid) && !IsPlayerInVehicle(playerid, GetPlayerVehicleID(targetid)))
	{
	    return Error(playerid, "Kamu harus berada di dalam kendaraan pemain itu untuk membuka penutup matanya.");
	}

	GameTextForPlayer(targetid, "~g~Buka penutup mata", 3000, 3);
	SendProximityMessage(playerid, 20.0, SERVER_COLOR, "**{C2A2DA} %s membuka penutup mata bandana dari %s.", GetRPName(playerid), GetRPName(targetid));

    TextDrawHideForPlayer(targetid, Blind);
	pBlind[targetid] = 0;
	return 1;
}*/
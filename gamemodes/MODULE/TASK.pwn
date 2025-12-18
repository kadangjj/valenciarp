/*


         TASK OPTIMIZED LUNARPRIDE

*/
#define COMPASS_SECTORS 22.5
// Tambahkan variable global di bagian atas script
new LastUptimeSecond = 0;

stock NavUpdate(playerid)
{
	static second, minute, hour, day, month, year;
	static Float:posPlayer[4];
	static timestr[32], datestr[64];
	
	gettime(hour, minute, second);
	getdate(year, month, day);
	
	// Get position and angle efficiently
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		GetVehiclePos(vehicleid, posPlayer[0], posPlayer[1], posPlayer[2]);
		GetVehicleZAngle(vehicleid, posPlayer[3]);
	}
	else
	{
		GetPlayerPos(playerid, posPlayer[0], posPlayer[1], posPlayer[2]);
		GetPlayerFacingAngle(playerid, posPlayer[3]);
	}

	// Untuk 8 arah mata angin
	new direction = floatround((posPlayer[3] + 22.5) / 45.0) % 8;

	static const directionNames[][] = {
		"North", "Northeast", "East", "Southeast",
		"South", "Southwest", "West", "Northwest"
	};

	static const directionShort[][] = {
		"N", "NE", "E", "SE",
		"S", "SW", "W", "NW"
	};

	// Update direction textdraws
	PlayerTextDrawSetString(playerid, NAV[playerid][0], directionNames[direction]);
	PlayerTextDrawSetString(playerid, NAV[playerid][1], directionShort[direction]);
	
	// Update time textdraw
	format(timestr, sizeof(timestr), "%02d:%02d:%02d", hour, minute, second);
	PlayerTextDrawSetString(playerid, NAV[playerid][4], timestr);
	
	// Update date textdraw
	format(datestr, sizeof(datestr), "%02d %s %04d", day, GetMonth(month), year);
	PlayerTextDrawSetString(playerid, NAV[playerid][5], datestr);
	
	// Update location textdraw
	PlayerTextDrawSetString(playerid, NAV[playerid][6], GetLocation(posPlayer[0], posPlayer[1], posPlayer[2]));
}

task onlineTimer[1000]()
{	
	//Date and Time Textdraw
	new datestring[64];
	new hours, minutes, seconds, days, months, years;
	new MonthName[12][] = {"January", "February", "March", "April", "May", "June", "July",	"August", "September", "October", "November", "December"};
	getdate(years, months, days);
 	gettime(hours, minutes, seconds);
	format(datestring, sizeof datestring, "%s%d %s %s%d", ((days < 10) ? ("0") : ("")), days, MonthName[months-1], (years < 10) ? ("0") : (""), years);
	TextDrawSetString(TextDate, datestring);
	format(datestring, sizeof datestring, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
	TextDrawSetString(TextTime, datestring);

	// Fix: Hanya update uptime sekali per detik (cek berdasarkan real second)
	if(seconds != LastUptimeSecond)
	{
		LastUptimeSecond = seconds;
		
		up_seconds++;
		if(up_seconds == 60)
		{
			up_seconds = 0, up_minutes++;
			if(up_minutes == 60)
			{
				up_minutes = 0, up_hours++;
				
				// Broadcast uptime setiap 1 jam
				new tstr[128];
				format(tstr, sizeof(tstr), ""BLUE_E"UPTIME: "WHITE_E"The server has been online for %s.", Uptime());
				SendClientMessageToAll(COLOR_WHITE, tstr);
				
				// Update world time & weather setiap 1 jam
				if(hours > 18)
				{
					SetWorldTime(0);
					WorldTime = 0;
				}
				else
				{
					SetWorldTime(hours);
					WorldTime = hours;
				}
				
				new rand = RandomEx(0, 20);
				SetWeather(rand);
				WorldWeather = rand;
				
				// Auto save semua player setiap 1 jam
				for(new pid = 0; pid < MAX_PLAYERS; pid++)
				{
					if(IsPlayerConnected(pid) && IsAtEvent[pid] == 0 && pData[pid][IsLoggedIn] == true)
					{
						UpdatePlayerData(pid);
					}
				}
				
				// Optimize database setiap 1 jam
				mysql_tquery(g_SQL, "OPTIMIZE TABLE `bisnis`,`houses`,`toys`,`vehicle`");
				
				if(up_hours == 24) up_hours = 0, up_days++;
			}
		}
	}
	
	return 1;
}

ptask PlayerDelay[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == false) return 0;
	NgecekCiter(playerid);
	NavUpdate(playerid);

		//VIP Expired Checking
	if(pData[playerid][pVip] > 0)
	{
		if(pData[playerid][pVipTime] != 0 && pData[playerid][pVipTime] <= gettime())
		{
			Info(playerid, "Maaf, Level VIP player anda sudah habis! sekarang anda adalah player biasa!");
			pData[playerid][pVip] = 0;
			pData[playerid][pVipTime] = 0;
		}
	}
		//ID Card Expired Checking
	if(pData[playerid][pIDCard] > 0)
	{
		if(pData[playerid][pIDCardTime] != 0 && pData[playerid][pIDCardTime] <= gettime())
		{
			Info(playerid, "Masa berlaku ID Card anda telah habis, silahkan perpanjang kembali!");
			pData[playerid][pIDCard] = 0;
			pData[playerid][pIDCardTime] = 0;
		}
	}

	if(pData[playerid][pExitJob] != 0 && pData[playerid][pExitJob] <= gettime())
	{
		Info(playerid, "Now you can exit from your current job!");
		pData[playerid][pExitJob] = 0;
	}
	if(pData[playerid][pDriveLic] > 0)
	{
		if(pData[playerid][pDriveLicTime] != 0 && pData[playerid][pDriveLicTime] <= gettime())
		{
			Info(playerid, "Masa berlaku Driving anda telah habis, silahkan perpanjang kembali!");
			pData[playerid][pDriveLic] = 0;
			pData[playerid][pDriveLicTime] = 0;
		}
	}
	if(pData[playerid][pWeaponLic] > 0)
	{
		if(pData[playerid][pWeaponLicTime] != 0 && pData[playerid][pWeaponLicTime] <= gettime())
		{
			Info(playerid, "Masa berlaku License Weapon anda telah habis, silahkan perpanjang kembali!");
			pData[playerid][pWeaponLic] = 0;
			pData[playerid][pWeaponLicTime] = 0;
		}
	}
		//Player JobTime Delay
	if(pData[playerid][pJobTime] > 0)
	{
		pData[playerid][pJobTime]--;
	}
	if(pData[playerid][pSideJobTime] > 0)
	{
		pData[playerid][pSideJobTime]--;
	}
	if(pData[playerid][pSweeperTime] > 0)
	{
		pData[playerid][pSweeperTime]--;
	}
	if(pData[playerid][pForklifterTime] > 0)
	{
		pData[playerid][pForklifterTime]--;
	}
	if(pData[playerid][pBusTime] > 0)
	{
		pData[playerid][pBusTime]--;
	}
	if(pData[playerid][pMowerTime] > 0)
	{
		pData[playerid][pMowerTime]--;
	}
	//Twitter Post
	if(pData[playerid][pTwitterPostCooldown] > 0)
	{
		pData[playerid][pTwitterPostCooldown]--;
	}
	//Twitter Changename
	if(pData[playerid][pTwitterNameCooldown] > 0)
	{
		pData[playerid][pTwitterNameCooldown]--;
	}

		// Duty Delay
	if(pData[playerid][pDutyHour] > 0)
	{
		pData[playerid][pDutyHour]--;
	}
		// Rob Delay
	if(pData[playerid][pRobTime] > 0)
	{
		pData[playerid][pRobTime]--;
	}
		// Get Loc timer
	if(pData[playerid][pSuspectTimer] > 0)
	{
		pData[playerid][pSuspectTimer]--;
	}
	if(pData[playerid][pDelayIklan] > 0)
	{
		pData[playerid][pDelayIklan]--;
	}
	if(pData[playerid][pDelayReqloc] > 0)
	{
		pData[playerid][pDelayReqloc]--;
	}
		//Warn Player Check
	if(pData[playerid][pWarn] >= 20)
	{
		new ban_time = gettime() + (5 * 86400), query[512], PlayerIP[16], giveplayer[24];
		GetPlayerIp(playerid, PlayerIP, sizeof(PlayerIP));
		GetPlayerName(playerid, giveplayer, sizeof(giveplayer));
		pData[playerid][pWarn] = 0;
			//SetPlayerPosition(playerid, 227.46, 110.0, 999.02, 360.0000, 10);
		BanPlayerMSG(playerid, playerid, "20 Total Warning", true);
		SendClientMessageToAllEx(COLOR_RED, "Server: "GREY2_E"Player %s(%d) telah otomatis dibanned permanent dari server. [Reason: 20 Total Warning]", giveplayer, playerid);

		mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', 'Server Ban', '20 Total Warning', %i, %d)", giveplayer, PlayerIP, gettime(), ban_time);
		mysql_tquery(g_SQL, query);
		KickEx(playerid);
	}
	return 1;
}

task Tags_Update[60000]()
{
	static
		counter;

	if(++counter >= 20)
	{
		foreach(new i : Tags) if(TagsData[i][tagExpired] < gettime())
		{
			new output[212];
			mysql_format(g_SQL, output, sizeof(output), "DELETE FROM `tags` WHERE `tagId`='%d';", TagsData[i][tagID]);
			mysql_tquery(g_SQL, output);
			if (IsValidDynamicObject(TagsData[i][tagObjectID]))
				DestroyDynamicObject(TagsData[i][tagObjectID]);

			new tmp_TagsData[E_TAGS_DATA];
			TagsData[i] = tmp_TagsData;

			TagsData[i][tagObjectID] = INVALID_STREAMER_ID;

			new next;
			Iter_SafeRemove(Tags, i, next);
			i = next;
		}
		counter = 0;
	}
	return 1;
}

ptask Player_SprayTagging[1000](playerid)
{
	if(GetPVarInt(playerid, "TagsReady") == 1)
	{
		if(GetPVarInt(playerid, "TagsTimer"))
		{
			SetPVarInt(playerid, "TagsTimer", GetPVarInt(playerid, "TagsTimer") - 1);

			if(!GetPVarInt(playerid, "TagsTimer"))
			{
				ClearAnimations(playerid);
				DeletePVar(playerid, "TagsReady");

				if(Tags_Create(playerid) != -1) Servers(playerid, "Sukses membuat "YELLOW_E"spray tag"WHITE_E", akan hilang setelah "PINK_E"3 hari!");
				else Error(playerid, "Tags sudah mencapai batas maksimal!");

				Tags_Reset(playerid);
			}
			else
			{
				ApplyAnimation(playerid, "GRAFFITI", "spraycan_fire", 4.1, 1, 0, 0, 1, 0, 1);
			}
		}
	}
	return 1;
}

ptask FarmDetect[1000](playerid)
{
	if(pData[playerid][IsLoggedIn] == true)
	{
		if(pData[playerid][pPlant] >= 20)
		{
			pData[playerid][pPlant] = 0;
			pData[playerid][pPlantTime] = 600;
		}
		if(pData[playerid][pPlantTime] > 0)
		{
			pData[playerid][pPlantTime]--;
			if(pData[playerid][pPlantTime] < 1)
			{
				pData[playerid][pPlantTime] = 0;
				pData[playerid][pPlant] = 0;
			}
		}
		new pid = GetClosestPlant(playerid);
		if(pid != -1)
		{
			if(IsPlayerInDynamicCP(playerid, PlantData[pid][PlantCP]) && pid != -1)
			{
				new type[24], mstr[128];
				if(PlantData[pid][PlantType] == 1)
				{
					type = "Potato";
				}
				else if(PlantData[pid][PlantType] == 2)
				{
					type = "Wheat";
				}
				else if(PlantData[pid][PlantType] == 3)
				{
					type = "Orange";
				}
				else if(PlantData[pid][PlantType] == 4)
				{
					type = "Marijuana";
				}
				if(PlantData[pid][PlantTime] > 1)
				{
					format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~r~%s", type, ConvertToMinutes(PlantData[pid][PlantTime]));
					InfoTD_MSG(playerid, 1000, mstr);
				}
				else
				{
					format(mstr, sizeof(mstr), "~w~Plant Type: ~g~%s ~n~~w~Plant Time: ~g~Now", type);
					InfoTD_MSG(playerid, 1000, mstr);
				}
			}
		}
	}
	return 1;
}

ptask playerTimer[1000](playerid)
{
    if(pData[playerid][IsLoggedIn] == true)
    {
        // JANGAN increment lagi jika sudah >= 1800 (sudah ready)
        if(pData[playerid][pPaycheck] < 1800)
        {
            // VIP Paycheck Boost System
            if(pData[playerid][pVip] == 1) // Bronze VIP
            {
                pData[playerid][pPaycheck] += 2; // 2x lebih cepat
            }
            else if(pData[playerid][pVip] == 2) // Silver VIP
            {
                pData[playerid][pPaycheck] += 3; // 3x lebih cepat
            }
            else if(pData[playerid][pVip] == 3) // Diamond VIP
            {
                pData[playerid][pPaycheck] += 4; // 4x lebih cepat
            }
            else // Non-VIP
            {
                pData[playerid][pPaycheck]++; // Normal speed
            }
            
            // Notifikasi saat PERTAMA KALI mencapai 1800 detik (30 menit)
            if(pData[playerid][pPaycheck] >= 1800)
            {
                pData[playerid][pPaycheck] = 1800; // Cap at 1800
                Info(playerid, "Waktunya mengambil paycheck!");
                Servers(playerid, "{ffff00}Silahkan pergi ke bank atau ATM terdekat untuk mengambil paycheck.");
                PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
            }
        }
        
        pData[playerid][pSeconds]++, pData[playerid][pCurrSeconds]++;
        
        if(pData[playerid][pOnDuty] >= 1)
        {
            pData[playerid][pOnDutyTime]++;
        }
        if(pData[playerid][pTaxiDuty] >= 1)
        {
            pData[playerid][pTaxiTime]++;
        }
        if(theftInfo[tTime] > 0)
        {
            theftInfo[tTime]--;
        }
        if(pData[playerid][pSeconds] == 60)
        {
            pData[playerid][pMinutes]++, pData[playerid][pCurrMinutes]++;
            pData[playerid][pSeconds] = 0, pData[playerid][pCurrSeconds] = 0;
            
            switch(pData[playerid][pMinutes])
            {               
                case 60: // Setiap 1 jam
                {
                    pData[playerid][pHours]++;
                    pData[playerid][pMinutes] = 0;
                    
                    // Sistem EXP baru dengan VIP Boost
                    new exp_gain;
                    
                    // Base EXP berdasarkan level
                    if(pData[playerid][pLevel] >= 6)
                    {
                        exp_gain = 2; // Level 6+ dapat 2 EXP per jam
                    }
                    else
                    {
                        exp_gain = 1; // Level 1-5 dapat 1 EXP per jam
                    }
                    
                    // VIP Boost Multiplier
                    if(pData[playerid][pVip] == 1) // Bronze VIP
                    {
                        exp_gain *= 2; // 2x EXP
                    }
                    else if(pData[playerid][pVip] == 2) // Silver VIP
                    {
                        exp_gain *= 3; // 3x EXP
                    }
                    else if(pData[playerid][pVip] == 3) // Diamond VIP
                    {
                        exp_gain *= 4; // 4x EXP
                    }
                    
                    // Tambah EXP (pLevelUp)
                    pData[playerid][pLevelUp] += exp_gain;
                    
                    // Hitung EXP yang dibutuhkan untuk naik level (scoremath)
                    new scoremath = (pData[playerid][pLevel] * 8);
                    
                    // Cek apakah cukup EXP untuk naik level
                    if(pData[playerid][pLevelUp] >= scoremath)
                    {
                        // Naik level!
                        pData[playerid][pLevel]++;
                        pData[playerid][pLevelUp] = 0; // Reset EXP
                        SetPlayerScore(playerid, pData[playerid][pLevel]);
                        
                        // Notifikasi level up
                        new mstr[128];
                        format(mstr, sizeof(mstr), "~g~Level Up!~n~~w~Sekarang anda level ~r~%d", pData[playerid][pLevel]);
                        GameTextForPlayer(playerid, mstr, 6000, 1);
                        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
                        
                        Servers(playerid, "Selamat! Kamu naik ke level %d!", pData[playerid][pLevel]);
					}
                    else
                    {
                        // Belum cukup EXP, kasih tau progress
                        Servers(playerid, "EXP +%d | Progress: %d/%d EXP menuju level %d", exp_gain, pData[playerid][pLevelUp], scoremath, pData[playerid][pLevel] + 1);
                       
                    }
                    
                    // Update database
                    UpdatePlayerData(playerid);
                }
            }
            
            if(pData[playerid][pCurrMinutes] == 60)
            {
                pData[playerid][pCurrMinutes] = 0;
                pData[playerid][pCurrHours]++;
            }
        }
    }
    return 1;
}
//Fishing System by Flow-RP Team

#define MAX_SPECIAL_FISHING_SPOTS 9
#define FISH_PULL_REQUIRED 5 // Jumlah tap H yang dibutuhkan

new FishBiteTimer[MAX_PLAYERS]; // Timer untuk ikan menyambar
new FishBite[MAX_PLAYERS]; // Status apakah ikan menyambar
new FishPullCount[MAX_PLAYERS]; // Counter berapa kali player tekan H
new FishPullTimer[MAX_PLAYERS]; // Timer untuk batas waktu tap
new bool:PlayerInSpecialFishingArea[MAX_PLAYERS];


enum FishingSpot {
    Float:SPOT_X,
    Float:SPOT_Y,
    Float:SPOT_Z,
    Float:SPOT_RADIUS
}

new Float:SpecialFishingSpots[MAX_SPECIAL_FISHING_SPOTS][FishingSpot] = {
    {37.4008,   -1774.0511, -0.0756, 100.0},
    {542.1485,  -2288.1877, -0.0446, 100.0},
    {292.5652,  -2318.2786, -0.2819, 100.0},
    {138.7230,  -2193.8169, -0.1165, 100.0},
    {1734.2797, -3059.4399, -0.3702, 100.0},
    {2338.7151, -2964.8977,  0.3207, 100.0},
    {2655.9961, -2722.0564, -0.3954, 100.0},   
    {2890.5527, -2611.0249, -0.4983, 100.0},  
    {2994.1577, -2360.2026,  0.2739, 100.0}
};

// Fungsi untuk menentukan area memancing
stock bool:IsPlayerInSpecialFishingSpot(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);

    for(new i = 0; i < MAX_SPECIAL_FISHING_SPOTS; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, SpecialFishingSpots[i][SPOT_RADIUS], 
           SpecialFishingSpots[i][SPOT_X], SpecialFishingSpots[i][SPOT_Y], SpecialFishingSpots[i][SPOT_Z]))
        {
            return true;
        }
    }
    return false;
}

stock IsPlayerInWater(playerid)
{
    new Float:x, Float:y, Float:pz;
    GetPlayerPos(playerid, x, y, pz);
    if(
        (IsPlayerInArea(playerid, 2032.1371, 1841.2656, 1703.1653, 1467.1099) && pz <= 9.0484) ||
        (IsPlayerInArea(playerid, 2109.0725, 2065.8232, 1962.5355, 10.8547) && pz <= 10.0792) ||
        (IsPlayerInArea(playerid, -492.5810, -1424.7122, 2836.8284, 2001.8235) && pz <= 41.06) ||
        (IsPlayerInArea(playerid, -2675.1492, -2762.1792, -413.3973, -514.3894) && pz <= 4.24) ||
        (IsPlayerInArea(playerid, -453.9256, -825.7167, -1869.9600, -2072.8215) && pz <= 5.72) ||
        (IsPlayerInArea(playerid, 1281.0251, 1202.2368, -2346.7451, -2414.4492) && pz <= 9.3145) ||
        (IsPlayerInArea(playerid, 2012.6154, 1928.9028, -1178.6207, -1221.4043) && pz <= 18.45) ||
        (IsPlayerInArea(playerid, 2326.4858, 2295.7471, -1400.2797, -1431.1266) && pz <= 22.615) ||
        (IsPlayerInArea(playerid, 2550.0454, 2513.7588, 1583.3751, 1553.0753) && pz <= 9.4171) ||
        (IsPlayerInArea(playerid, 1102.3634, 1087.3705, -663.1653, -682.5446) && pz <= 112.45) ||
        (IsPlayerInArea(playerid, 1287.7906, 1270.4369, -801.3882, -810.0527) && pz <= 87.123) ||
        (pz < 1.5)
    )
    {
        return 1;
    }
    return 0;
}

stock IsPlayerInArea(playerid, Float:minx, Float:maxx, Float:miny, Float:maxy)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    if(x > minx && x < maxx && y > miny && y < maxy) return 1;
    return 0;
}

stock IsAtFishPlace(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, 403.8266, -2088.7598, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 398.7553, -2088.7490, 7.8359))
        {
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 396.2197, -2088.6692, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 391.1094, -2088.7976, 7.8359))
        {
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 383.4157, -2088.7849, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 374.9598, -2088.7979, 7.8359))
        {
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 369.8107, -2088.7927, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 367.3637, -2088.7925, 7.8359))
        {
            return 1;
        }
        else if(IsPlayerInRangeOfPoint(playerid, 1.0, 362.2244, -2088.7981, 7.8359) || IsPlayerInRangeOfPoint(playerid, 1.0, 354.5382, -2088.7979, 7.8359))
        {
            return 1;
        }
        else if(IsPlayerInWater(playerid))
        {
            return 1;
        }
    }
    return 0;
}

forward CheckFishingArea();
public CheckFishingArea()
{
    foreach(new i : Player)
    {
        if(!IsPlayerConnected(i)) continue;
        
        new bool:inArea = IsPlayerInSpecialFishingSpot(i);
        
        // Hanya tampilkan pas MASUK area aja
        if(inArea && !PlayerInSpecialFishingArea[i])
        {
            PlayerInSpecialFishingArea[i] = true;
            
            GameTextForPlayer(i, "~b~SPECIAL FISHING SPOT~n~~w~Big Fish Area!", 10000, 3);
            PlayerPlaySound(i, 1056, 0.0, 0.0, 0.0);
            //SendClientMessage(i, 0x00BFFFAA, "FISHING: {FFFFFF}You entered a special fishing spot! Use /fish for bigger catch!");
        }
        // Reset flag pas keluar (tanpa notif)
        else if(!inArea && PlayerInSpecialFishingArea[i])
        {
            PlayerInSpecialFishingArea[i] = false;
        }
    }
}

function FishBiteTime(playerid)
{
    if(IsPlayerConnected(playerid) && pData[playerid][pInFish] == 1)
    {
        FishBite[playerid] = 1; // Ikan menyambar
        FishPullCount[playerid] = 0; // Reset counter
        
        // Beri efek dan suara
        PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
        
        new string[128];
        format(string, sizeof(string), "~r~FISH BITE!~n~~w~Press ~y~H ~r~%d/%d~w~ times!", FishPullCount[playerid], FISH_PULL_REQUIRED);
        InfoTD_MSG(playerid, 8000, string);
        
        // Set timer untuk batas waktu menarik ikan (8 detik untuk tap-tap)
        FishPullTimer[playerid] = SetTimerEx("FishEscape", 8000, false, "i", playerid);
        
        SendClientMessage(playerid, COLOR_WHITE, "FISHING: Fish bite! Quickly tap "RED_E"H "WHITE_E"to pull the fish!");
    }
}

function FishEscape(playerid)
{
    if(IsPlayerConnected(playerid) && pData[playerid][pInFish] == 1 && FishBite[playerid] == 1)
    {
        // Ikan kabur karena tidak ditarik
        KillTimer(FishBiteTimer[playerid]);
        FishBite[playerid] = 0;
        pData[playerid][pInFish] = 0;
        
        RemovePlayerAttachedObject(playerid, 9);
        ClearAnimations(playerid);
        TogglePlayerControllable(playerid, 1);
        
        //SendClientMessage(playerid, COLOR_RED, "FISHING: "WHITE_E"The fish escaped! You were too slow.");
        Info(playerid, "The fish escaped! You were too slow to pull.");
    }
}

ProcessFishCatch(playerid)
{
    new bool:isSpecialSpot = IsPlayerInSpecialFishingSpot(playerid);
    new rand = RandomEx(1, 5); // Simplified: 5 kemungkinan saja
    new Float:weight;
    new fishName[32];
    
    // Generate weight dengan desimal
    if(isSpecialSpot)
    {
        weight = float(RandomEx(60, 200)) / 10.0; // 6.0 - 15.0 lbs
    }
    else
    {
        weight = float(RandomEx(10, 50)) / 10.0; // 1.0 - 5.0 lbs
    }

    switch(rand)
    {
        case 1: // Trash
        {
            format(fishName, sizeof(fishName), "trash");
            Info(playerid, "You caught trash and threw it away.");
        }
        case 2, 3, 4: // Ikan biasa (60% chance)
        {
            // Random nama ikan
            new fishTypes[][] = {
                "Tuna", "Mackerel", "Snapper", "Grouper", 
                "Stingray", "Spanish Mackerel", "Blue Marlin"
            };
            new randomFish = random(sizeof(fishTypes));
            format(fishName, sizeof(fishName), "%s", fishTypes[randomFish]);
            
            Info(playerid, "You caught a %s weighing %.1flbs", fishName, weight);
            pData[playerid][pFish] += floatround(weight, floatround_floor); // Simpan sebagai integer
            PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        }
        case 5: // Line broke atau nothing
        {
            new chance = random(2);
            if(chance == 0)
            {
                format(fishName, sizeof(fishName), "nothing");
                Info(playerid, "You didn't catch anything.");
            }
            else
            {
                format(fishName, sizeof(fishName), "big fish");
                Info(playerid, "A huge fish broke your line!");
                pData[playerid][pFishTool]--;
            }
        }
    }
    
    // Kurangi umpan (kecuali dapat trash)
    if(rand != 1) pData[playerid][pWorm] -= 1;
    
    // Reset fishing state
    FishBite[playerid] = 0;
    FishPullCount[playerid] = 0;
    pData[playerid][pInFish] = 0;
    KillTimer(FishBiteTimer[playerid]);
    KillTimer(FishPullTimer[playerid]);
    RemovePlayerAttachedObject(playerid, 9);
    ClearAnimations(playerid);
    TogglePlayerControllable(playerid, 1);
}
CMD:fish(playerid, params[])
{
    if(pData[playerid][pFishTool] < 1)
        return Error(playerid, "You don't have fishing tool.");
        
    if(pData[playerid][pWorm] < 1)
        return Error(playerid, "You don't have bait.");
        
    if(!IsAtFishPlace(playerid))
        return Error(playerid, "You must be in the sea to fish.");
        
    if(pData[playerid][pInFish] == 1)
        return Error(playerid, "You are already fishing.");
        
    if(pData[playerid][pFish] >= 50)
        return Error(playerid, "Inventory ikan anda sudah penuh, anda dapat menjualnya terlebih dahulu.");
    
    new random2 = RandomEx(15000, 25000); // Waktu menunggu ikan
    pData[playerid][pInFish] = 1;
    FishBite[playerid] = 0;
    
    // Set timer untuk ikan menyambar
    FishBiteTimer[playerid] = SetTimerEx("FishBiteTime", random2, false, "i", playerid);
    
    new bool:isSpecialSpot = IsPlayerInSpecialFishingSpot(playerid);
    if(isSpecialSpot)
    {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s swings fishing rod in a special fishing spot and starts to wait for big fish", ReturnName(playerid));
    }
    else
    {
        SendNearbyMessage(playerid, 20.0, COLOR_PURPLE, "** %s swings fishing rod and starts to wait for fish", ReturnName(playerid));
    }
    
    TogglePlayerControllable(playerid, false);
    ApplyAnimation(playerid, "SWORD", "sword_block", 50.0, 0, 1, 0, 1, 1);
    SetPlayerAttachedObject(playerid, 9, 18632, 6, 0.079376, 0.037070, 0.007706, 181.482910, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
    InfoTD_MSG(playerid, 10000, "Waiting for fish bite...");
    
    SendClientMessage(playerid, COLOR_WHITE, "FISHING: Wait for the fish to bite, then press "RED_E"H "WHITE_E"to pull!");
    return 1;
}

CMD:sellfish(playerid, params[])
{
    if(!IsPlayerInRangeOfPoint(playerid, 3.0, 2843.9133, -1516.6660, 11.3011)) 
        return Error(playerid, "You're not near a fish factory");
        
    if(pData[playerid][pFish] < 1)
        return Error(playerid, "You dont have fish.");
        
    new fish = pData[playerid][pFish];
    new pay = fish * FishPrice;
    GivePlayerMoneyEx(playerid, pay);
    Info(playerid, "Anda menjual semua ikan dengan total uang "GREEN_E"%s", FormatMoney(pay));
    RawFish += fish;
    Server_MinMoney(pay);
    pData[playerid][pFish] = 0;
    return 1;
}
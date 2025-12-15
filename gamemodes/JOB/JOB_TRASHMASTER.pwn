//job trashmaster by yellowcrush
new TimerTrashmaster[MAX_PLAYERS], TrashmasterDynCP[MAX_PLAYERS][11];
new Float: TrashmasterPlayerX[MAX_PLAYERS][11];
new Float: TrashmasterPlayerY[MAX_PLAYERS][11];
new Float: TrashmasterPlayerZ[MAX_PLAYERS][11];
new bool:TrashStatus[MAX_PLAYERS][11], TrashmasterCrate[MAX_PLAYERS];

new Float: TrashmasterCP[][3] = {
    {1809.0026, -1804.9397, 13.54650},
    {1789.8159, -1883.3229, 13.56840},
    {1871.1851, -1627.0081, 13.36930},
    {2001.1465, -1550.3231, 13.64730},
    {1985.2653, -1781.0939, 13.55120},
    {2173.0061, -1787.7135, 13.5215},    
    {2277.2932, -1672.1891, 15.1442},    
    {2307.1309, -1630.4855, 14.45960},
    {2417.6409, -1696.1266, 13.80610},
    {2440.1418, -1900.7098, 13.54690},
    {2365.7229, -1939.5677, 13.5469},    
    {2341.8357, -1891.6252, 13.6241},
    {2441.5244, -1973.6356, 13.5469},    
    {2538.5154, -2010.2054, 13.54690},
    {2659.9102, -2056.8606, 13.55000},
    {2592.5217, -2205.9204, 13.5469},    
    {2613.1609, -2425.0059, 13.6338},    
    {2411.1960, -2620.4434, 13.66410},
    {2205.8130, -2632.1299, 13.54690},
    {2241.8938, -2158.8701, 13.55380},
    {2340.8311, -2070.9648, 13.54690},
    {2284.5413, -2028.2296, 13.54690},
    {1920.1262, -2123.1318, 13.58490},
    {1919.7515, -2088.2029, 13.58040},
    {1660.5251, -2113.0540, 13.5469}
};

new VehicleTrashmaster[4];

AddTrashmasterVehicle()
{
    VehicleTrashmaster[0] = AddStaticVehicleEx(408,2118.483, -2078.253, 13.546, 141.301, 1, 1, VEHICLE_RESPAWN);
    VehicleTrashmaster[1] = AddStaticVehicleEx(408,2126.990, -2084.031, 13.546, 136.226, 1, 1, VEHICLE_RESPAWN);
    VehicleTrashmaster[2] = AddStaticVehicleEx(408,2134.713, -2090.880, 13.546, 134.353, 1, 1, VEHICLE_RESPAWN);
}

IsVehicleTrashmaster(vehicleid)
{
    for (new i = 0; i != 4; i ++) if(VehicleTrashmaster[i] == vehicleid) {
        return 1;
    }
    return 0;
}

ptask TrashmasterTimer[1000](playerid) 
{
    if(!IsPlayerInAnyVehicle(playerid) && TimerTrashmaster[playerid] > 0)
    {
        TimerTrashmaster[playerid]--;
        new str[256];
        format(str, sizeof(str), "~w~Return To Trashmaster Vehicle ~n~in ~y~%d seconds", TimerTrashmaster[playerid]);
        GameTextForPlayer(playerid, str, 1000, 6);
        PlayerPlaySound(playerid, 1056, 0.0, 0.0, 0.0);
        if(TimerTrashmaster[playerid] == 0)
        {
            new list[128], rada = 50;
            new trash_collected = GetPVarInt(playerid, "TrashCollected");
            new cash = trash_collected * 1500;
            for(new i; i < 11; i++) {
                RemovePlayerMapIcon(playerid, rada+i);
            }
            format(list, sizeof(list), "Cleared %d trash dumps", trash_collected);
            
            if(GetPVarType(playerid, "TrashmasterVehicle")) {
                new vehicleid = GetPVarInt(playerid, "TrashmasterVehicle");
                SetVehicleToRespawn(vehicleid);
            }
            
            //  AddPlayerSalary(playerid, "Public Service (Trashmaster)", list, cash);	
            SendClientMessageEx(playerid, COLOR_ARWIN, "SIDEJOB: {ffffff}Trashmaster sidejob failed, {3BBD44}$%s {ffffff}has been issued for your next paycheck", FormatMoney(cash));
            SendClientMessageEx(playerid, COLOR_ARWIN, "SALARY: {ffffff}Your salary statement has been updated, please check {ffff00}'/mysalary'");
            
            DeletePVar(playerid, "TrashCollected");
            pData[playerid][pTrashmasterJob] = 0;
            //  DelayPlayer[playerid][DelayTrashmaster] = 1800;
            // TextDrawHideForPlayer(playerid, PlayerCrateTD);
            // PlayerTextDrawHide(playerid, PlayerCrate[playerid][0]);
            //PlayerTextDrawHide(playerid, PlayerCrate[playerid][1]);
        }
    }
    return 1;
}

CMD:loadtrash(playerid, params[])
{
    new vehicleid = GetPlayerVehicleID(playerid);
    if(!IsPlayerInAnyVehicle(playerid)) return Error(playerid, "Anda tidak berada di dalam kendaraan.");
    if(!IsVehicleTrashmaster(vehicleid)) return Error(playerid, "Ini bukan mobil khusus untuk pekerjaan trashman.");
    
    for(new id = 0; id < 11; id++) {
        if(IsPlayerInDynamicArea(playerid, TrashmasterDynCP[playerid][id])) {
            if(TrashStatus[playerid][id] == false && pData[playerid][pTrashmasterJob] == 1) {
                // Gunakan PVar untuk menyimpan jumlah trash
                new current_trash = GetPVarInt(playerid, "TrashCollected");
                current_trash++;
                SetPVarInt(playerid, "TrashCollected", current_trash);
                
                TrashStatus[playerid][id] = true;
                RemovePlayerMapIcon(playerid, 50+id);
                SendCustomMessage(playerid, "TRASH", "You have loaded trash into your trashmaster from the gerbage dump, trash loaded "YELLOW_E"%d/10", current_trash);
                
                if(current_trash == 10)
                {
                    SendCustomMessage(playerid, "TRASH", "You have loaded trash into your trashmaster from the gerbage dump, "GREEN_E"your trashmaster is now full");
                    SendCustomMessage(playerid, "TRASH", "Your trashmaster is "GREEN_E"already full"WHITE_E", return to the trash dump to finish sidejob!");
                    SetPlayerRaceCheckpoint(playerid, 1, 2101.2063,-2032.8599,14.0905, 0.0, 0.0, 0.0, 5.0);
                    for(new i; i < 11; i++) RemovePlayerMapIcon(playerid, 50+i);
                    new String2[212];
                    format(String2,sizeof(String2),"Trash~n~%d/10", current_trash); 
                    PlayerTextDrawSetString(playerid, PlayerCrate[playerid][1], String2);
                    return 1;
                }
                
                // Update textdraw setelah load trash
                new String2[212];
                format(String2,sizeof(String2),"Trash~n~%d/10", current_trash); 
                PlayerTextDrawSetString(playerid, PlayerCrate[playerid][1], String2);
                return 1; // Keluar setelah berhasil load satu trash
            }
        }
    }
    
    // Update textdraw jika tidak ada trash yang diload
    new current_trash = GetPVarInt(playerid, "TrashCollected");
    new String2[212];
    format(String2,sizeof(String2),"Trash~n~%d/10", current_trash); 
    PlayerTextDrawSetString(playerid, PlayerCrate[playerid][1], String2);
    
    Error(playerid, "Anda tidak berada di dekat lokasi sampah atau sampah sudah diambil.");
    return 1;
}
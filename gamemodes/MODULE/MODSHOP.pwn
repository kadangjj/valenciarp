/*
===========================================================
    Vehicle Accesories Script, Author : Revelt
===========================================================*/
new ObjectVehicle[MAX_VEHICLES][5];

enum E_VEH_OBJECT {
    vehObjectID, // Untuk Menampung ID SQL Vehicle Acc
    vehObjectVehicleIndex, // Untuk mengampung ID SQL Vehicle
    vehObjectType, // Untuk menampung tipe object 
    vehObjectModel, // Untuk menampung model Object 
    vehObjectColor, // Untuk menampung warna object 

    vehObjectText[128], // Untuk menampung Text object
    vehObjectFont[24], // Untuk menampung font object
    vehObjectFontSize, // Untuk menampung size font dari si text 
    vehObjectFontColor, // Untuk menampung warna dari text 

    vehObject, // sebagai STREAMER ID object 
    
    bool:vehObjectExists, // Flagger untuk status object slot, true jika ada, false jika kosong

    Float:vehObjectPosX, // Coordinate dari object ketika attach ke kendaraan 
    Float:vehObjectPosY, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosZ, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRX, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRY, // Coordinate dari object ketika attach ke kendaraan
    Float:vehObjectPosRZ // Coordinate dari object ketika attach ke kendaraan
};

enum E_OBJECT {
    Model,
    Name[37]
};

new 
    VehicleObjects[MAX_PRIVATE_VEHICLE][MAX_VEHICLE_OBJECT][E_VEH_OBJECT], // Sebagai variable dari enumurator veh object
    ListedVehObject[MAX_PLAYERS][MAX_VEHICLE_OBJECT], // Untuk menyimpan index id array vehicle object ke playerid
    Player_EditingObject[MAX_PLAYERS], // Sebagai flagger untuk menandakan player sedang edit object atau tidak 
    Player_EditVehicleObject[MAX_PLAYERS], // Variable Holder
    Player_EditVehicleObjectSlot[MAX_PLAYERS] // Variable Holder
; 
new color_string[3256], object_font[200];


new VehObject[][E_OBJECT] = 
{
    {19314,"BullHorns"},
    {1100,"Tengkorak"},
    {1013,"Lamp Round"},
    {1024,"Lamp Square"},
    {1028,"Exhaust Alien-1"},
    {1032,"Vent Alien-1"},
    {1033,"Vent X-Flow-1"},
    {1034,"Exhaust Alien-2"},
    {1035,"Vent Alien-2"},
    {1038,"Vent X-Flow-2"},
    {1099,"BullBars-1 Left"},
    {1042,"BullBars-1 Right"},
    {1046,"Exhaust Alien-2"},
    {1053,"Vent Alien-3"},
    {1054,"Vent X-Flow-3"},
    {1055,"Vent Alien-4"},
    {1061,"Vent X-Flow-4"},
    {1067,"Vent Alien-5"},
    {1068,"Vent X-Flow-5"},
    {1088,"Vent Alien-6"},
    {1091,"Vent X-Flow-6"},
    {1101,"BullBars Fire 1 Left"},
    {1106,"BullBars Stripes 1 Left"},
    {1109,"BullBars Lamp"},
    {1110,"BullBars Lamp Small"},
    {1111,"Accessories Metal 1"},
    {1112,"Accessories Metal 2"},
    {1121,"Accessories 3"},
    {1122,"BullBars Fire 2 Left"},
    {1123,"Accessories 4"},
    {1124,"BullBars Stripes 2 Left"},
    {1125,"BullBars Lamp 2"},
    {1128,"Hard Top"},
    {1130,"Medium Top"},
    {1131,"Soft Top"},
    {18659,"Vehicle Text"},
    {1025,"Wheels Offroad"},
    {1066,"Exhaust X-Flow"},
    {1065,"Exhaust Alien"},
    {1142,"Vets Left Oval"},
    {1143,"Vents Right Oval"},
    {1144,"Vents Left Square"},
    {1145,"Vents Right Square"},
    {1171,"Alien Front Bumper-1"},
    {1149,"Alien Rear Bumper-1"},
    {1023,"Spoiler Fury"},
    {1172,"X-Flow Front Bumper-1"},
    {1148,"X-Flow Rear Bumper-1"},
    {1000,"Pro Spoiler"},
    {1001,"Win Spoiler"},
    {1002,"Drag Spoiler"},
    {1003,"Alpha Spoiler"},
    {1004,"Champ Scoop Hood"},
    {1005,"Fury Scoop Hood"},
    {1006,"Roof Scoop"},
    {1007,"R-Sideskirt-TF"},
    {1011,"Race Scoop Hood"},
    {1012,"Worx Scoop Hood"},
    {1014,"Champ Spoiler"},
    {1015,"Race Spoiler"},
    {1016,"Worx Spoiler"},
    {1017,"L-Sideskirt-TF"},
    {1030,"L-Sideskirt-WAA-1"},
    {1031,"R-Sideskirt-WAA-1"},
    {1036,"R-Sideskirt-WAA-2"},
    {1039,"L-Sideskirt-WAA-3"},
    {1040,"L-Sideskirt-WAA-2"},
    {1041,"R-Sideskirt-WAA-3"},
    {1047,"R-Sideskirt-WAA-4"},
    {1048,"R-Sideskirt-WAA-5"},
    {1049,"Alien Spoiler-1"},
    {1050,"X-Flow Spoiler-1"},
    {1051,"L-Sideskirt-WAA-4"},
    {1052,"L-Sideskirt-WAA-5"},
    {1056,"R-Sideskirt-WAA-6"},
    {1057,"R-Sideskirt-WAA-7"},
    {1058,"Alien Spoiler-2"},
    {1060,"X-Flow Spoiler-2"},
    {1062,"L-Sideskirt-WAA-6"},
    {1063,"L-Sideskirt-WAA-7"},
    {1116,"F-Bullbars Slamin-1"},
    {1115,"F-Bullbars Chrome-1"},
    {1138,"Alien Spoiler-3"},
    {1139,"X-Flow Spoiler-3"},
    {1140,"X-Flow Rear Bumper-2"},
    {1141,"Alien Rear Bumper-2"},
    {1146,"X-Flow Spoiler-4"},
    {1147,"Alien Spoiler-4"},
    {1148,"X-Flow Rear Bumper-3"},
    {1149,"Alien Rear Bumper-3"},
    {1150,"Alien Rear Bumper-4"},
    {1151,"X-Flow Rear Bumper-4"},
    {1152,"X-Flow Front Bumper-4"},
    {1153,"Alien Front Bumper-4"},
    {1154,"Alien Rear Bumper-5"},
    {1155,"Alien Front Bumper-5"},
    {1156,"X-Flow Rear Bumper-5"},
    {1157,"X-Flow Front Bumper-5"},
    {1158,"X-Flow Spoiler-5"},
    {1159,"Alien Rear Bumper-6"},
    {1160,"Alien Front Bumper-6"},
    {1161,"X-Flow Rear Bumper-6"},
    {1162,"Alien Spoiler-5"},
    {1163,"X-Flow Spoiler-6"},
    {1164,"Alien Spoiler-6"},
    {1165,"X-Flow Front Bumper-7"},
    {1166,"Alien Front Bumper-7"},
    {1167,"X-Flow Rear Bumper-7"},
    {1168,"Alien Rear Bumper-7"},
    {1169,"Alien Front Bumper-2"},
    {1170,"X-Flow Front Bumper-2"},
    {1171,"Alien Front Bumper-3"},
    {1172,"X-Flow Front Bumper-3"},
    {1173,"X-Flow Front Bumper-6"},
    {1174,"Chrome Front Bumper-1"},
    {1175,"Slamin Front Bumper-1"},
    {1176,"Chrome Rear Bumper-1"},
    {1177,"Slamin Rear Bumper-1"},
    {1178,"Slamin Rear Bumper-2"},
    {1179,"Chrome Front Bumper-2"},
    {1185,"Slamin Front Bumper-3"},
    {1188,"Slamin Front Bumper-4"},
    {19308, "Taxi Sign"}
};

/*new const FontNames[][] = {
    "Arial",
    "Calibri",
    "Comic Sans MS",
    "Georgia",
    "Times New Roman",
    "Consolas",
    "Constantia",
    "Corbel",
    "Courier New",
    "Impact",
    "Lucida Console",
    "Palatino Linotype",
    "Tahoma",
    "Trebuchet MS",
    "Verdana",
    "Custom Font"
}; */

new vehName[][] =       // array for vehicle names to be displayed
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "SABI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratium", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Trailer", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

new const familyvehicle[] = {
    412, 413, 418, 426, 445, 482, 482, 507, 567, 579
};

new const dmvehicle1[] = {
    536, 402, 483, 466, 579, 400, 467, 461, 426, 506, 412
};

new const dmvehicle2[] = {
    568, 496, 401, 462, 500, 470, 440, 535, 558, 491, 554
};

new const dmvehicle3[] = {
    602, 581, 482, 415, 507, 533, 492, 551, 543, 567, 560
};

new const dmvehicle4[] = {
    474, 559, 410, 516, 600, 459, 475, 468, 550, 576, 540
};

new const dmvehicle5[] = {
    445, 480, 562, 419, 603, 471, 489, 405, 458, 439, 529, 555
};

new const dmvehicle6[] = {
    495, 575, 518, 587, 521, 526, 404, 505, 561, 549, 477
};

new const dmvehicle7[] = {
    422, 609, 527, 565, 545, 508, 517, 534, 580, 478, 586
};

new const dmvehicle8[] = {
    424, 542, 585, 463, 546, 418, 413, 436, 547, 479, 566, 421
};

new const transfender[] = {
    1000, 1001, 1002, 1003, 1004, 1005, 1006, 1007, 1011, 1012, 1013, 
    1014, 1015, 1016, 1017, 1023, 1024, 1025, 1142, 1143, 1144, 1145
};

new const loco[] = {
    1103, 1104, 1105, 1107, 1108, 1128, 1182, 1183, 1184, 1042, 1043, 
    1044, 1099, 1174, 1175, 1176, 1177, 1100, 1101, 1106, 1122, 1123, 
    1124, 1125, 1126, 1127, 1178, 1179, 1180, 1185, 1102, 1129, 1130, 
    1131, 1132, 1133, 1186, 1187, 1188, 1189, 1109, 1110, 1111, 1112, 
    1113, 1114, 1115, 1116, 1117, 1118, 1119, 1120, 1121
};

new const waa[] = {
    1026, 1027, 1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, 1036, 
    1037, 1038, 1039, 1040, 1141, 1045, 1046, 1047, 1048, 1049, 1050, 
    1051, 1052, 1053, 1054, 1055, 1056, 1057, 1058, 1059, 1060, 1061, 
    1062, 1063, 1064, 1065, 1066, 1067, 1068, 1069, 1070, 1071, 1072, 
    1088, 1089, 1090, 1091, 1092, 1093, 1094, 1095, 1138, 1139, 1140, 
    1141, 1146, 1147, 1148, 1149, 1150, 1151, 1152, 1153, 1154, 1155, 
    1156, 1157, 1158, 1159, 1160, 1161, 1162, 1163, 1164, 1165, 1166, 
    1167, 1168, 1169, 1170, 1171, 1172, 1173
};

// Function ini untuk save object kendaraan ke database dan menyimpan SQL id ke dalam vehObjectID!
forward Vehicle_ObjectDB(vehicleid, slot);
public Vehicle_ObjectDB(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
		return 0;

	VehicleObjects[vehicleid][slot][vehObjectID] = cache_insert_id();
	Vehicle_ObjectSave(vehicleid, slot);
	return 1;
}

// Function untuk ngeload object kendaraan ketika kendraan diload ke dalam server!
forward Vehicle_ObjectLoaded(vehicleid);
public Vehicle_ObjectLoaded(vehicleid)
{
	if(cache_num_rows())
	{
		for(new slot = 0; slot != cache_num_rows(); slot++)
        { 
            if(!VehicleObjects[vehicleid][slot][vehObjectExists])
            {
                // Load semua data yang ada di Mysql dan di simpan ke dalam variabel, untuk di tampung
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                cache_get_value_name(slot, "text", VehicleObjects[vehicleid][slot][vehObjectText], 128);
                cache_get_value_name(slot, "font", VehicleObjects[vehicleid][slot][vehObjectFont], 32);			

                cache_get_value_name_int(slot, "id", VehicleObjects[vehicleid][slot][vehObjectID]);
                cache_get_value_name_int(slot, "vehicle", VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]);
                cache_get_value_name_int(slot, "type", VehicleObjects[vehicleid][slot][vehObjectType]);
                cache_get_value_name_int(slot, "model", VehicleObjects[vehicleid][slot][vehObjectModel]);
				cache_get_value_name_int(slot, "color", VehicleObjects[vehicleid][slot][vehObjectColor]);

                cache_get_value_name_int(slot, "fontcolor", VehicleObjects[vehicleid][slot][vehObjectFontColor]);
                cache_get_value_name_int(slot, "fontsize", VehicleObjects[vehicleid][slot][vehObjectFontSize]);

                cache_get_value_name_float(slot, "x", VehicleObjects[vehicleid][slot][vehObjectPosX]);
                cache_get_value_name_float(slot, "y", VehicleObjects[vehicleid][slot][vehObjectPosY]);
                cache_get_value_name_float(slot, "z", VehicleObjects[vehicleid][slot][vehObjectPosZ]);

                cache_get_value_name_float(slot, "rx", VehicleObjects[vehicleid][slot][vehObjectPosRX]);
                cache_get_value_name_float(slot, "ry", VehicleObjects[vehicleid][slot][vehObjectPosRY]);
                cache_get_value_name_float(slot, "rz", VehicleObjects[vehicleid][slot][vehObjectPosRZ]);

                // Ketika sudah terload, maka object yang sudah di tampung ke dalam variabel akan di attach berdasarkan slotnya!
                Vehicle_AttachObject(vehicleid, slot);
            }
        }
	}
	return 1;
}

// Function untuk ngesave object ke dalam database dari variabel penampung!
Vehicle_ObjectSave(vehicleid, slot)
{
	if(VehicleObjects[vehicleid][slot][vehObjectExists])
    {
        new query[1024];

        format(query, sizeof(query), "UPDATE `vehicle_object` SET `model`='%d', `color`='%d',`type`='%d', `x`='%f',`y`='%f',`z`='%f', `rx`='%f',`ry`='%f',`rz`='%f'",
            VehicleObjects[vehicleid][slot][vehObjectModel],
            VehicleObjects[vehicleid][slot][vehObjectColor],
            VehicleObjects[vehicleid][slot][vehObjectType],
            VehicleObjects[vehicleid][slot][vehObjectPosX], 
            VehicleObjects[vehicleid][slot][vehObjectPosY], 
            VehicleObjects[vehicleid][slot][vehObjectPosZ], 
            VehicleObjects[vehicleid][slot][vehObjectPosRX],
            VehicleObjects[vehicleid][slot][vehObjectPosRY], 
            VehicleObjects[vehicleid][slot][vehObjectPosRZ]
        );

        format(query, sizeof(query), "%s, `text`='%s',`font`='%s', `fontsize`='%d',`fontcolor`='%d' WHERE `id`='%d' AND `vehicle` = '%d'",
            query, 
            VehicleObjects[vehicleid][slot][vehObjectText], 
            VehicleObjects[vehicleid][slot][vehObjectFont], 
            VehicleObjects[vehicleid][slot][vehObjectFontSize], 
            VehicleObjects[vehicleid][slot][vehObjectFontColor], 
            VehicleObjects[vehicleid][slot][vehObjectID],
			VehicleObjects[vehicleid][slot][vehObjectVehicleIndex]
        );
        mysql_tquery(g_SQL, query);
    }
	return 1;
}

// Function untuk menambahkan object untuk vehicle id tersebut
// Model = Object modelnya || Type = 1 / 2, 1 Itu Object, 2 Itu Text
Vehicle_ObjectAddObjects(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT) //
                {
                    format(VehicleObjects[vehicleid][slot][vehObjectText], 128, "TEXT");
                    format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                    VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                    VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                }

                Dialog_Show(playerid, DIALOG_MODSHOPMOVE, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)", "Select", "Close");
                GivePlayerMoneyEx(playerid, -5000);
                Streamer_Update(playerid);
                SendClientMessageEx(playerid, COLOR_ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}%s {ffffff}for {00ff00}$50.00", GetVehObjectNameByModel(VehicleObjects[vehicleid][slot][vehObjectModel]));
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_TextAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT) //
                {
                    format(VehicleObjects[vehicleid][slot][vehObjectText], 128, "TEXT");
                    format(VehicleObjects[vehicleid][slot][vehObjectFont], 24, "Arial");
                    VehicleObjects[vehicleid][slot][vehObjectFontColor] = 1;
                    VehicleObjects[vehicleid][slot][vehObjectFontSize] = 24; 
                }

                Dialog_Show(playerid, VACCSE1, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nText Name\nText Size\nText Font\nText Color\nRemove Modification", "Select", "Back");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, COLOR_ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}Sticker {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_SpotLightAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                if(GetPlayerMoney(playerid) < 5000)
	  			    return Error(playerid, "Untuk membeli vehicle toys kamu harus mempunyai uang $50.00");
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                Dialog_Show(playerid, DIALOG_SPOTLIGHT, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)\nLight Color", "Select", "Close");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, COLOR_ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}SpotLight {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_PlateAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                if(GetPlayerMoney(playerid) < 5000)
	  			    return Error(playerid, "Untuk membeli vehicle toys kamu harus mempunyai uang $50.00");
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                Dialog_Show(playerid, VACCSE3, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nRemove Modification\nSave", "Select", "Back");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, COLOR_ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}Plate {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

Vehicle_NeonAdd(playerid, vehicleid, model, type)
{
    if(Iter_Contains(PVehicles, vehicleid)) // Jika vehicle id nya tidak sama dengan yang ada di iterator PVehicles, dia akan return 0
	{
        new query_string[255];
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        { 
            if(VehicleObjects[vehicleid][slot][vehObjectExists] == false)
            {
                if(GetPlayerMoney(playerid) < 5000)
	  			    return Error(playerid, "Untuk membeli vehicle toys kamu harus mempunyai uang $50.00");
                VehicleObjects[vehicleid][slot][vehObjectExists] = true;

                VehicleObjects[vehicleid][slot][vehObjectType] = type;
                VehicleObjects[vehicleid][slot][vehObjectVehicleIndex] = pvData[vehicleid][cID];
                VehicleObjects[vehicleid][slot][vehObjectModel] = model;		

                VehicleObjects[vehicleid][slot][vehObjectColor] = 0;

                VehicleObjects[vehicleid][slot][vehObjectPosX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;

                VehicleObjects[vehicleid][slot][vehObjectPosRX] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRY] = 0.0;
                VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;

                Dialog_Show(playerid, NeonTube, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nNeon Color", "Select", "Back");
                GivePlayerMoneyEx(playerid, -5000);
                SendClientMessageEx(playerid, COLOR_ARWIN, "MODSHOP: {ffffff}You've purchased {ffff00}Plate {ffffff}for {00ff00}$50.00");
                format(query_string, sizeof(query_string), "INSERT INTO `vehicle_object` (`vehicle`) VALUES ('%d')", pvData[vehicleid][cID]);
                mysql_tquery(g_SQL, query_string, "Vehicle_ObjectDB", "dd", vehicleid, slot);
                return 1;
            }
        }
	}
	return 0;
}

// Function untuk attach vehicle object ke kendaraan yang sudah ada di server!
Vehicle_AttachObject(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            model       = VehicleObjects[vehicleid][slot][vehObjectModel],
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;

        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

        GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_BODY)
        {
            Vehicle_ObjectColorSync(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_TEXT)
        {
            Vehicle_ObjectTextSync(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
        {
            Vehicle_SpotLightDelete(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_PLATE)
        {
            Vehicle_PlateAttach(vehicleid, slot);
        }
        else if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_NEON)
        {
            Vehicle_NeonTubeDelete(vehicleid, slot);
        }
        AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
        Vehicle_ObjectUpdate(vehicleid, slot);
        return 1;
    }
    return 0;
}

Vehicle_PlateAttach(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_PLATE)
        {
            new
                model       = VehicleObjects[vehicleid][slot][vehObjectModel],
                Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
                Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
                Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
                Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
                Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
                Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
                Float:vposx,
                Float:vposy,
                Float:vposz
            ;
            if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

            VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

            GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

            VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);
            SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, sprintf(""PURPLE_E2"%s", pvData[vehicleid][cPlate]), 80, "Arial", 40, 1, -65536, -1, 1);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
            Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

            AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
            Vehicle_ObjectUpdate(vehicleid, slot);
        }
    }
    return 1;
}

Vehicle_SpotLightDelete(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_LIGHT)
        {
            switch(GetLightStatus(vehicleid))
            {
                case false:
                {
                    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                        DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);
                }
                case true:
                {
                    new
                        model       = VehicleObjects[vehicleid][slot][vehObjectModel],
                        Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
                        Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
                        Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
                        Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
                        Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
                        Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
                        Float:vposx,
                        Float:vposy,
                        Float:vposz
                    ;
                    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                    DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

                    VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

                    GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

                    VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

                    AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
                    Vehicle_ObjectUpdate(vehicleid, slot);
                }
            }
        }
    }
    return 1;
}

Vehicle_NeonTubeDelete(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_NEON)
        {
            switch(GetLightStatus(vehicleid))
            {
                case false:
                {
                    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                        DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);
                }
                case true:
                {
                    new
                        model       = VehicleObjects[vehicleid][slot][vehObjectModel],
                        Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
                        Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
                        Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
                        Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
                        Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
                        Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
                        Float:vposx,
                        Float:vposy,
                        Float:vposz
                    ;
                    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                    DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

                    VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

                    GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);

                    VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(model, vposx, vposy, vposz, rx, ry, rz);

                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
                    Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

                    AttachDynamicObjectToVehicle(VehicleObjects[vehicleid][slot][vehObject], pvData[vehicleid][cVeh], x, y, z, rx, ry, rz);
                    Vehicle_ObjectUpdate(vehicleid, slot);
                }
            }
        }
    }
    return 1;
}

// Function Untuk sync object color yang ada di kendaraan, ketika mengubah warna object!
Vehicle_ObjectColorSync(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        SetDynamicObjectMaterial(VehicleObjects[vehicleid][slot][vehObject], 0, VehicleObjects[vehicleid][slot][vehObjectModel], "none", "none", RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectColor]]));
        return 1;
    }
    return 0;
}

// Function Untuk sync object color yang ada di kendaraan, ketika mengubah warna object!
Vehicle_LightColorSync(vehicleid, slot, id, playerid)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new
            Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
            Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
            Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
            Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
            Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
            Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
            Float:vposx,
            Float:vposy,
            Float:vposz
        ;
        VehicleObjects[vehicleid][slot][vehObjectModel] = id;
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
            DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);


        GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);
        VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;
        VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(VehicleObjects[vehicleid][slot][vehObjectModel], vposx+x, vposy+y, vposz+z, rx, ry, rz);   
        
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 15);
        Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[vehicleid][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 15);
        //Vehicle_ObjectSave(vehicleid, slot); // Setelah warna di ubah pastikan selalu di save!
        Dialog_Show(playerid, DIALOG_SPOTLIGHT, DIALOG_STYLE_LIST, "Modshop", "Position\nPosition (Manual)\nLight Color\nSave", "Select", "Close");
	    return 1;
    }
    return 0;
}

Vehicle_NeonColorSync(vehicleid, slot, id, playerid)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        VehicleObjects[vehicleid][slot][vehObjectModel] = id;
        Vehicle_ObjectUpdate(vehicleid, slot);
        Dialog_Show(playerid, NeonTube, DIALOG_STYLE_LIST, "Edit Component", "Position\nPosition (Manual)\nNeon Color", "Select", "Back");
	    return 1;
    }
    return 0;
}

// Function untuk sync text yang ada di kendaraan ketika mengubah text!
Vehicle_ObjectTextSync(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, ReplaceString(VehicleObjects[vehicleid][slot][vehObjectText]), 130, VehicleObjects[vehicleid][slot][vehObjectFont], VehicleObjects[vehicleid][slot][vehObjectFontSize], 1, RGBAToARGB(ColorList[VehicleObjects[vehicleid][slot][vehObjectFontColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
        return 1;
    }
    return 0;
}

Vehicle_PlateSync(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        SetDynamicObjectMaterialText(VehicleObjects[vehicleid][slot][vehObject], 0, sprintf(""PURPLE_E2"%s", pvData[vehicleid][cPlate]), 80, "Arial", 40, 1, -65536, -1, 1);
        return 1;
    }
    return 0;
}

// Function ini berguna untuk update posisi object ke dalam variabel setelah di edit menggunakan
// ..- Callback OnPlayerEditDynamicObject!
Vehicle_ObjectUpdate(id, slot, sync = 1)
{    
	if(!IsValidVehicle(pvData[id][cVeh])) return 0;
    new
        model       = VehicleObjects[id][slot][vehObjectModel],
        Float:x     = VehicleObjects[id][slot][vehObjectPosX],
        Float:y     = VehicleObjects[id][slot][vehObjectPosY],
        Float:z     = VehicleObjects[id][slot][vehObjectPosZ],
        Float:rx    = VehicleObjects[id][slot][vehObjectPosRX],
        Float:ry    = VehicleObjects[id][slot][vehObjectPosRY],
        Float:rz    = VehicleObjects[id][slot][vehObjectPosRZ];
	if (sync) {
		if (IsValidDynamicObject(VehicleObjects[id][slot][vehObject])) DestroyDynamicObject(VehicleObjects[id][slot][vehObject]);
		VehicleObjects[id][slot][vehObject] = CreateDynamicObject(model, x, y, z, rx, ry, rz);
	}
    if(VehicleObjects[id][slot][vehObjectType] == OBJECT_TYPE_BODY) Vehicle_ObjectColorSync(id, slot);
    else if(VehicleObjects[id][slot][vehObjectType] == OBJECT_TYPE_TEXT) Vehicle_ObjectTextSync(id, slot);
    else if(VehicleObjects[id][slot][vehObjectType] == OBJECT_TYPE_LIGHT) Vehicle_SpotLightDelete(id, slot);
    else if(VehicleObjects[id][slot][vehObjectType] == OBJECT_TYPE_PLATE) Vehicle_PlateSync(id, slot);
    else if(VehicleObjects[id][slot][vehObjectType] == OBJECT_TYPE_NEON) Vehicle_NeonTubeDelete(id, slot);

	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[id][slot][vehObject], E_STREAMER_DRAW_DISTANCE, 25);
	Streamer_SetFloatData(STREAMER_TYPE_OBJECT, VehicleObjects[id][slot][vehObject], E_STREAMER_STREAM_DISTANCE, 25);

	if (sync) AttachDynamicObjectToVehicle(VehicleObjects[id][slot][vehObject], pvData[id][cVeh], x, y, z, rx, ry, rz);
	return 1;
}

// Function ini berguna untuk menghapus object pada kendaraan, berdasarkan slot!
Vehicle_ObjectDelete(vehicleid, slot)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        new query_string[255];
        if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject])) DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);
        VehicleObjects[vehicleid][slot ][vehObject] = INVALID_OBJECT_ID;
        VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
        VehicleObjects[vehicleid][slot][vehObjectExists] = false;
        VehicleObjects[vehicleid][slot][vehObjectColor] = 0;
        VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
        VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        format(query_string, sizeof(query_string), "DELETE FROM `vehicle_object` WHERE `id` = '%d'", VehicleObjects[vehicleid][slot][vehObjectID]);
        mysql_tquery(g_SQL, query_string);
        return 1;
    }
    return 0;
}

// Function ini berguna untuk menghapus object pada kendaraan secara keseluruhan!
Vehicle_ObjectDestroy(vehicleid)
{
    if(Iter_Contains(PVehicles, vehicleid))
	{
        for(new slot = 0; slot < MAX_VEHICLE_OBJECT; slot++)
        {
            //Jika objectnya valid, maka object akan di hapus!
            if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
                DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

            VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;

            VehicleObjects[vehicleid][slot][vehObjectModel] = 0;
            VehicleObjects[vehicleid][slot][vehObjectExists] = false;

            VehicleObjects[vehicleid][slot][vehObjectColor] = 1;

            VehicleObjects[vehicleid][slot][vehObjectPosX] = VehicleObjects[vehicleid][slot][vehObjectPosY] = VehicleObjects[vehicleid][slot][vehObjectPosZ] = 0.0;
            VehicleObjects[vehicleid][slot][vehObjectPosRX] = VehicleObjects[vehicleid][slot][vehObjectPosRY] = VehicleObjects[vehicleid][slot][vehObjectPosRZ] = 0.0;
        }
        return 1;
    }
    return 0;
}

// Function ini berguna dan akan terpanggil ketika kita "ingin" meng-edit kordinat dari object kita ke kendaraan.
Vehicle_ObjectEdit(playerid, vehicleid, slot, bool:text = false)
{
    new
        Float:x     = VehicleObjects[vehicleid][slot][vehObjectPosX],
        Float:y     = VehicleObjects[vehicleid][slot][vehObjectPosY],
        Float:z     = VehicleObjects[vehicleid][slot][vehObjectPosZ],
        Float:rx    = VehicleObjects[vehicleid][slot][vehObjectPosRX],
        Float:ry    = VehicleObjects[vehicleid][slot][vehObjectPosRY],
        Float:rz    = VehicleObjects[vehicleid][slot][vehObjectPosRZ],
        Float:vposx,
        Float:vposy,
        Float:vposz
    ;
    if(IsValidDynamicObject(VehicleObjects[vehicleid][slot][vehObject]))
        DestroyDynamicObject(VehicleObjects[vehicleid][slot][vehObject]);

    GetVehiclePos(pvData[vehicleid][cVeh], vposx, vposy, vposz);
    VehicleObjects[vehicleid][slot][vehObject] = INVALID_OBJECT_ID;
    VehicleObjects[vehicleid][slot][vehObject] = CreateDynamicObject(VehicleObjects[vehicleid][slot][vehObjectModel], vposx+x, vposy+y, vposz+z, rx, ry, rz);   

    Player_EditVehicleObject[playerid] = vehicleid;
    Player_EditVehicleObjectSlot[playerid] = slot;
    Player_EditingObject[playerid] = 1;
    if(text)  Vehicle_ObjectTextSync(vehicleid, slot);
    if(VehicleObjects[vehicleid][slot][vehObjectType] == OBJECT_TYPE_PLATE) Vehicle_PlateSync(vehicleid, slot);
    Streamer_Update(playerid);
    EditDynamicObject(playerid, VehicleObjects[vehicleid][slot][vehObject]);
    return 1;
}

// Function ini akan terpanggil ketika cancel editing object
ResetEditing(playerid)
{
    if(Player_EditingObject[playerid])
    {
        if(Player_EditVehicleObject[playerid] != -1 && Player_EditVehicleObjectSlot[playerid] != -1){
            Vehicle_AttachObject(Player_EditVehicleObject[playerid], Player_EditVehicleObjectSlot[playerid]);
            Vehicle_ObjectUpdate(Player_EditVehicleObject[playerid], Player_EditVehicleObjectSlot[playerid]);
            
            Player_EditVehicleObject[playerid] = -1;
            Player_EditVehicleObjectSlot[playerid] = -1;
        }
    }
    Player_EditingObject[playerid] = 0;
    return 1;
}

GetVehObjectNameByModel(model)
{
    new
        name[32];

    for (new i = 0; i < sizeof(VehObject); i ++) 
    if(VehObject[i][Model] == model) 
    {
        strcat(name, VehObject[i][Name]);
        break;
    }
    return name;
}

CMD:myov(playerid, params[])
{
    new 
		vid = GetPlayerVehicleID(playerid),
        string[1024],
        count
	;
	if(!IsPlayerInAnyVehicle(playerid))
        return Error(playerid, "You need to be driver to use this command.");

    if(IsPlayerInRangeOfPoint(playerid, 4.0, 2240.0049,-1992.2527,13.4790) || IsPlayerInRangeOfPoint(playerid, 4.0, 2249.2793,-1992.1729,13.4792) || IsPlayerInRangeOfPoint(playerid, 4.0, 2259.4019,-1991.5497,13.4791) || IsPlayerInRangeOfPoint(playerid, 4.0, 2269.0203,-1992.3207,13.4792)) //
    {
        foreach(new vehid : PVehicles)
        {
            if(vid == pvData[vehid][cVeh]) 
            { 
                if(pvData[vehid][cOwner] == pData[playerid][pID])
                {
                    if(GetEngineStatus(GetPlayerVehicleID(playerid)))
                        return Error(playerid, "Turn off vehicle engine first.");
                    format(string,sizeof(string),"Slot\tMod Type\tModel\n");
                    if(pData[playerid][pVip] > 1)
                    {
                        for (new i = 0; i < MAX_VEHICLE_OBJECT; i++)
                        {
                            if(VehicleObjects[vehid][i][vehObjectExists])
                            {
                                if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_BODY)
                                {
                                    format(string,sizeof(string),"%s%d\t"GREEN_E"Mod\t"WHITE_E"%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehid][i][vehObjectModel]));
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_TEXT)
                                {
                                    format(string,sizeof(string),"%s%d\t"GREEN_E"Sticker\t"WHITE_E"%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_LIGHT)
                                {
                                    format(string,sizeof(string),"%s%d\t"YELLOW_E"Light\t"WHITE_E"Spot Light\n", string, i);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_PLATE)
                                {
                                    format(string,sizeof(string),"%s%d\t"AQUA_E"Plate\t"WHITE_E"(number plate)\n", string, i);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_NEON)
                                {
                                    format(string,sizeof(string),"%s%d\t"YELLOW_E"Light\t"WHITE_E"Neon Tube\n", string, i);
                                }
                            }
                            else
                            {
                                format(string, sizeof(string), "%sNew\tMod\n", string);
                            }
                            if (count < 10)
                            {
                                ListedVehObject[playerid][count] = i;
                                count = count + 1;
                            }
                        }
                    }
                    else
                    {
                        for (new i = 0; i < 3; i ++)
                        {
                            if(VehicleObjects[vehid][i][vehObjectExists])
                            {
                                if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_BODY)
                                {
                                    format(string,sizeof(string),"%s%d\t"GREEN_E"Mod\t"WHITE_E"%s\n", string, i, GetVehObjectNameByModel(VehicleObjects[vehid][i][vehObjectModel]));
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_TEXT)
                                {
                                    format(string,sizeof(string),"%s%d\t"GREEN_E"Sticker\t"WHITE_E"%s\n", string, i, VehicleObjects[vehid][i][vehObjectText]);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_LIGHT)
                                {
                                    format(string,sizeof(string),"%s%d\t"YELLOW_E"Light\t"WHITE_E"Spot Light\n", string, i);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_PLATE)
                                {
                                    format(string,sizeof(string),"%s%d\t"AQUA_E"Plate\t"WHITE_E"(number plate)\n", string, i);
                                }
                                else if(VehicleObjects[vehid][i][vehObjectType] == OBJECT_TYPE_NEON)
                                {
                                    format(string,sizeof(string),"%s%d\t"YELLOW_E"Light\t"WHITE_E"Neon Tube\n", string, i);
                                }
                            }
                            else
                            {
                                format(string, sizeof(string), "%sNew\tMod\n", string);
                            }
                            if (count < 10)
                            {
                                ListedVehObject[playerid][count] = i;
                                count = count + 1;
                            }
                        }
                    }

                    if(!count) 
                    {
                        Error(playerid, "You don't have vehicle toys installed!");
                    }
                    else 
                    {
                        Player_EditVehicleObject[playerid] = vehid;
                        Dialog_Show(playerid, EditingVehObject, DIALOG_STYLE_TABLIST_HEADERS, "Modshop: List", string, "Select","Exit");
                    }
                }
                else return Error(playerid, "This isn't owned by you");
            }
        }
    }    
    else return Error(playerid, "You're not in a modshop.");
    return 1;
}


forward LoadMainData();
public LoadMainData()
{
	mysql_tquery(g_SQL, "SELECT * FROM `doors`", "LoadDoors");
	mysql_tquery(g_SQL, "SELECT * FROM `familys`", "LoadFamilys");
	mysql_tquery(g_SQL, "SELECT * FROM `houses`", "LoadHouses");
	mysql_tquery(g_SQL, "SELECT * FROM `bisnis`", "LoadBisnis");
}

forward LoadAdditionalData();
public LoadAdditionalData()
{
	mysql_tquery(g_SQL, "SELECT * FROM `lockers`", "LoadLockers");
	mysql_tquery(g_SQL, "SELECT * FROM `gstations`", "LoadGStations");
	mysql_tquery(g_SQL, "SELECT * FROM `atms`", "LoadATM");
	mysql_tquery(g_SQL, "SELECT * FROM `gates`", "LoadGates");
	mysql_tquery(g_SQL, "SELECT * FROM `vouchers`", "LoadVouchers");
	mysql_tquery(g_SQL, "SELECT * FROM `trees`", "LoadTrees");
	mysql_tquery(g_SQL, "SELECT * FROM `ores`", "LoadOres");
	mysql_tquery(g_SQL, "SELECT * FROM `plants`", "LoadPlants");
	mysql_tquery(g_SQL, "SELECT * FROM `workshop`", "LoadWorkshop");
	mysql_tquery(g_SQL, "SELECT * FROM `parks`", "LoadPark");
	mysql_tquery(g_SQL, "SELECT * FROM `speedcameras`", "LoadSpeedCam");
	mysql_tquery(g_SQL, "SELECT * FROM `actor`", "LoadActor");
	mysql_tquery(g_SQL, "SELECT * FROM `vending`", "LoadVending");
}

forward CreateServerPoints();
public CreateServerPoints()
{
	CreateServerPoint();
	CreateJoinLumberPoint();
	CreateJoinTaxiPoint();
	CreateJoinMechPoint();
	CreateJoinMinerPoint();
	CreateJoinProductionPoint();
	CreateJoinTruckPoint();
	CreateArmsPoint();
	//CreateJoinKurirPoint();
	//CreateFishingZones();
	CreateJoinFarmerPoint();
	LoadTazerSAPD();
	CreateJoinSmugglerPoint();
	CreateJoinBaggagePoint();
	CreateCarStealingPoint();
	LoadMap();
	ResetCarStealing();
}

forward CreateRentalPoints();
public CreateRentalPoints()
{
	new strings[150];
	
	for(new i = 0; i < sizeof(rentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Bike Rental]\n{FFFFFF}/rentbike /unrentpv");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentVehicle[i][0], rentVehicle[i][1], rentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(rentBoat); i ++)
	{
	    CreateDynamicPickup(1239, 23, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Boat Rental]\n{FFFFFF}/rentboat");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, rentBoat[i][0], rentBoat[i][1], rentBoat[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}

	for(new i = 0; i < sizeof(unrentVehicle); i ++)
	{
	    CreateDynamicPickup(1239, 23, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], -1, -1, -1, 50);
		format(strings, sizeof(strings), "[Unrent Vehicle]\n{FFFFFF}/unrentpv\n to unrent your vehicle");
		CreateDynamic3DTextLabel(strings, COLOR_LBLUE, unrentVehicle[i][0], unrentVehicle[i][1], unrentVehicle[i][2], 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // rent bike
	}
}

forward CreateBusinessPoints();
public CreateBusinessPoints()
{
	new strings[150];
	
	//-----[ Toll System ]-----	
	for(new i;i < sizeof(BarrierInfo);i ++)
	{
		new
		Float:X = BarrierInfo[i][brPos_X],
		Float:Y = BarrierInfo[i][brPos_Y];

		ShiftCords(0, X, Y, BarrierInfo[i][brPos_A]+90.0, 3.5);
		CreateDynamicObject(966,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z],0.00000000,0.00000000,BarrierInfo[i][brPos_A]);
		if(!BarrierInfo[i][brOpen])
		{
			gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,90.00000000,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.7,BARRIER_SPEED,0.0,0.0,BarrierInfo[i][brPos_A]+180);
			MoveObject(gBarrier[i],BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[i][brPos_A]+180);
		}
		else gBarrier[i] = CreateDynamicObject(968,BarrierInfo[i][brPos_X],BarrierInfo[i][brPos_Y],BarrierInfo[i][brPos_Z]+0.8,0.00000000,20.00000000,BarrierInfo[i][brPos_A]+180);
	}

	CreateDynamicPickup(1239, 23, -2082.9756, 2675.5081, 1500.9647, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[City Hall]\n{FFFFFF}/newidcard - create new ID Card\n/newage - Change Birthday\n/sellhouse - sell your house\n/sellbusiness - sell your bisnis");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2082.9756, 2675.5081, 1500.9647, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // ID Card
	
	CreateDynamicPickup(1239, 23, 1296.0533, -1264.1348, 13.5939, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Veh Insurance]\n{FFFFFF}/buyinsu - buy insurance\n/claimpv - claim insurance\n/sellpv - sell vehicle");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1296.0533, -1264.1348, 13.5939, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance

	CreateDynamicPickup(1239, 23, 1294.1837, -1267.9083, 20.6199, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Sparepart Shop]\n{FFFFFF}/buysparepart\n");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, 1294.1837, -1267.9083, 20.6199, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Veh insurance
	
	CreateDynamicPickup(1239, 23, -2578.5625, -1383.2179, 1500.7570, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[License]\n{FFFFFF}/newdrivelic - create new license");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -2578.5625, -1383.2179, 1500.7570, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Driving Lic
	
	CreateDynamicPickup(1239, 23, 101.9294, 1064.6431, -48.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 101.9294, 1064.6431, -48.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota LS
	
	CreateDynamicPickup(1239, 23, 85.0160, 1070.5106, -48.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 85.0160, 1070.5106, -48.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Dilimore

	CreateDynamicPickup(1239, 23, -1466.4567, 2600.2031, 19.6310, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Plate]\n{FFFFFF}/buyplate - create new plate");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -1466.4567, 2600.2031, 19.6310, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Plate Kota Dilimore
	
	CreateDynamicPickup(1239, 23, -1469.6188, 2600.2039, 19.6310, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Ticket]\n{FFFFFF}/payticket - to pay ticket");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, -1469.6188, 2600.2039, 19.6310, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Ticket Kota Ls
	
	CreateDynamicPickup(1239, 23, 59.6879, 1067.4708, -50.9141, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Arrest Point]\n{FFFFFF}/arrest - arrest wanted player");
	CreateDynamic3DTextLabel(strings, COLOR_BLUE, 59.6879, 1067.4708, -50.9141, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // arrest
	
	CreateDynamicPickup(1239, 23, 1142.38, -1330.74, 13.62, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Hospital]\n{FFFFFF}/dropinjured");
	CreateDynamic3DTextLabel(strings, COLOR_PINK, 1142.38, -1330.74, 13.62, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // hospital
	
	CreateDynamicPickup(1239, 23, -2667.4021, 802.2328, 1500.9688, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/newrek - create new rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2667.4021, 802.2328, 1500.9688, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, -2679.9041, 806.8085, 1500.9688, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[BANK]\n{FFFFFF}/bank - access rekening");
	CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2679.9041, 806.8085, 1500.9688, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // bank
	
	CreateDynamicPickup(1239, 23, -192.3483, 1338.7361, 1500.9823, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[IKLAN]\n{FFFFFF}/ad - public ads");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -192.3483, 1338.7361, 1500.9823, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // iklan

	CreateDynamicPickup(1241, 23, -1775.2911, -1994.0675, 1500.7853, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[MYRICOUS PRODUCTION]\n{FFFFFF}/mix");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -1775.2911, -1994.0675, 1500.7853, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // racik obat

	CreateDynamicPickup(1239, 23, -427.3773, -392.3799, 16.5802, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Exchange Money]\n{FFFFFF}/washmoney");
	CreateDynamic3DTextLabel(strings, COLOR_ORANGE2, -427.3773, -392.3799, 16.5802, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // pencucian uang haram
	
	//-----[ Dynamic Checkpoint ]-----	
	ShowRoomCP = CreateDynamicCP(538.8544, -1292.9434, 17.2422, 1.0, -1, -1, -1, 5.0);
	CreateDynamicPickup(1239, 23, 538.85, -1292.94, 17.24, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fffd4}Vehicle Showroom\n{ffffff}Stand Here!", COLOR_GREEN, 538.8544, -1292.9434, 17.2422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
	
	ShowRoomCPRent = CreateDynamicCP(545.7528, -1293.4164, 17.2422, 1.0, -1, -1, -1, 5.0);
	CreateDynamicPickup(1239, 23, 545.75, -1293.41, 17.24, -1, -1, -1, 50);
	CreateDynamic3DTextLabel("{7fff00}Rental Vehicle\n{ffffff}Stand Here!"YELLOW_E"\n/unrentpv", COLOR_LBLUE, 545.7528, -1293.4164, 17.2422, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, -1);
}

forward CreateFactionPoints();
public CreateFactionPoints()
{
	new strings[150];
	
	//----STATIC VEHICLE FACTION-----
	CreateDynamicPickup(1239, 23, 1162.5398, -1313.6564, 31.4925, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SAMD Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 1162.5398, -1313.6564, 31.4925, 20.0);

    CreateDynamicPickup(1239, 23, 1124.6143, -1318.0011, 13.7310, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SAMD Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 1124.6143, -1318.0011, 13.7310, 20.0);

    CreateDynamicPickup(1239, 23, 1564.9774, -1656.3179, 28.3979, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SAPD Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 1564.9774, -1656.3179, 28.3979, 20.0);

    CreateDynamicPickup(1239, 23, 1569.8613, -1708.7760, 5.8906, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SAPD Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 1569.8613, -1708.7760, 5.8906, 20.0);

    CreateDynamicPickup(1239, 23, 1480.2343, -1839.9185, 13.5469, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SAGS Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 1480.2343, -1839.9185, 13.5469, 20.0);

    CreateDynamicPickup(1239, 23, 756.5260, -1345.0209, 13.8414, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SANA Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 756.5260, -1345.0209, 13.8414, 20.0);

    CreateDynamicPickup(1239, 23, 741.8675, -1370.4966, 25.6922, -1, -1, -1, 50);
    CreateDynamic3DTextLabel("SANA Vehicle Menu\n{7fff00}/staticveh", 0xFFFFFFFF, 741.8675, -1370.4966, 25.6922, 20.0);

	// SAGS Doors
	SAGSLobbyBtn[0] = CreateButton(-2688.83, 808.989, 1501.67, 180.0000);//bank
	SAGSLobbyBtn[1] = CreateButton(-2691.719238, 807.353333, 1501.422241, 0.000000); //bank
	SAGSLobbyBtn[2] = CreateButton(-2067.57, 2692.6, 1501.75, 90.0000);
	SAGSLobbyBtn[3] = CreateButton(-2067.81, 2692.64, 1501.64, -90.0000);
	SAGSLobbyBtn[4] = CreateButton(-2062.34, 2695.24, 1501.72, -90.0000);
	SAGSLobbyBtn[5] = CreateButton(-2062.09, 2695.21, 1501.7, 90.0000);
	SAGSLobbyBtn[6] = CreateButton(-2062.33, 2706.59, 1501.71, -90.0000);
	SAGSLobbyBtn[7] = CreateButton(-2062.08, 2706.69, 1501.73, 90.0000);
	SAGSLobbyDoor[0] = CreateDynamicObject(1569, -2689.33, 807.425, 1499.95, 0.000000, 0.000000, -179.877, -1, -1, -1, 300.00, 300.00);//Bank
	SAGSLobbyDoor[1] = CreateDynamicObject(1569, -2067.72, 2694.67, 1499.96, 0.000000, 0.000000, -89.6241, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[2] = CreateDynamicObject(1569, -2062.2, 2693.16, 1499.98, 0.000000, 0.000000, 89.9741, -1, -1, -1, 300.00, 300.00);
	SAGSLobbyDoor[3] = CreateDynamicObject(1569, -2062.22, 2704.74, 1499.96, 0.000000, 0.000000, 90.2693, -1, -1, -1, 300.00, 300.00);

	// SAMC Doors
	SAMCLobbyBtn[0] = CreateButton(-1786.67, -1999.45, 1501.55, 90.0000);
	SAMCLobbyBtn[1] = CreateButton(-1786.89, -1999.48, 1501.56, -90.0000);
	SAMCLobbyBtn[2] = CreateButton(-1773.67, -1994.98, 1501.57, 180.0000);
	SAMCLobbyBtn[3] = CreateButton(-1773.71, -1995.25, 1501.56, 0.0000);
	SAMCLobbyBtn[4] = CreateButton(-1758.02, -1999.46, 1501.56, -90.0000);
	SAMCLobbyBtn[5] = CreateButton(-1757.81, -1999.46, 1501.57, 90.0000);
	SAMCLobbyDoor[0] = CreateDynamicObject(1569, -1786.8, -1997.48, 1499.77, 0.000000, 0.000000, -90.4041, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[1] = CreateDynamicObject(1569, -1771.77, -1995.14, 1499.77, 0.000000, 0.000000, -179.415, -1, -1, -1, 300.00, 300.00);
	SAMCLobbyDoor[2] = CreateDynamicObject(1569, -1757.91, -1997.48, 1499.76, 0.000000, 0.000000, -91.6195, -1, -1, -1, 300.00, 300.00);
}

forward LoadVehiclesAndFinish();
public LoadVehiclesAndFinish()
{
	//-----[ Sidejob Vehicle ]-----	
	AddSweeperVehicle();
	AddBusVehicle();
	//AddKurirVehicle();
	AddForVehicle();
	AddMowerVehicle();

	//-----[ Job Vehicle ]-----	
	AddBaggageVehicle();

	//-----[ DMV ]-----	
	AddDmvVehicle();
	
	//-----[ SAPD Vehicle ]-----	
	/* Semua kode SAPD vehicles tetap ada di sini */
	
	//-----[ SAGS Vehicle ]-----	
	/* Semua kode SAGS vehicles tetap ada di sini */
	
	//-----[ SAMD Vehicle ]-----	
	/* Semua kode SAMD vehicles tetap ada di sini */
	
	//-----[ SANA Vehicle ]-----	
	/* Semua kode SANA vehicles tetap ada di sini */
	
	for (new i; i < sizeof(ColorList); i++) {
    format(color_string, sizeof(color_string), "%s{%06x}%03d %s", color_string, ColorList[i] >>> 8, i, ((i+1) % 16 == 0) ? ("\n") : (""));
    }

    for (new i; i < sizeof(FontNames); i++) {
        format(object_font, sizeof(object_font), "%s%s\n", object_font, FontNames[i]);
    }

	printf("[Objects]: %d Loaded.", CountDynamicObjects());
	return 1;
}
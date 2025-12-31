//======== Bus ===========
#define buspoint1 		1671.5015, -1477.9338, 13.4804
#define buspoint2 		1655.4309, -1578.8663, 13.4876
#define buspoint3 		1675.6584, -1594.5546, 13.4830
#define buspoint4 		1808.3151, -1614.4534, 13.4606
#define buspoint5 		1822.1866, -1602.4225, 13.4650
#define buspoint6 		1852.0515, -1477.0760, 13.4892
#define buspoint7 		1976.1843, -1468.7709, 13.4898
#define buspoint8 		1988.9058, -1453.9619, 13.4881
#define buspoint9 		1989.5841, -1354.7592, 23.8970
#define buspoint10 		2055.3843, -1343.6346, 23.9209
#define buspoint11 		2073.3601, -1237.0232, 23.9111 //
#define buspoint12 		2074.4985, -1106.5936, 24.7291
#define buspoint13 		1995.6899, -1054.9963, 24.5139
#define buspoint14 		1867.9518, -1058.5884, 23.7857
#define buspoint15 		1863.6049, -1169.5271, 23.7625
#define buspoint16 		1657.9583, -1157.8536, 23.8513
#define buspoint17 		1592.6194, -1159.1958, 24.0051
#define buspoint18 		1549.6796, -1055.4402, 23.7095
#define buspoint19 		1458.6635, -1030.3673, 23.7568 //
#define buspoint20 		1383.3145, -1032.3024, 26.1900
#define buspoint21 		1355.6470, -1045.0482, 26.4642
#define buspoint22 		1340.4150, -1127.6436, 23.7744
#define buspoint23 		1340.1676, -1379.0829, 13.5948
#define buspoint24 		1363.4252, -1405.9730, 13.4503
#define buspoint25 		1393.6683, -1430.9860, 13.5163
#define buspoint26 		1640.2510, -1443.0830, 13.4826
#define buspoint27 		1654.4456, -1539.0234, 13.4815

#define cpbus1 1656.0156, -1477.8744, 13.0388
#define cpbus2 1655.0776, -1589.9154, 13.0446
#define cpbus3 1532.6605, -1589.6821, 13.0414
#define cpbus4 1432.9233, -1589.9476, 13.0498
#define cpbus5 1316.0553, -1569.7157, 13.0421
#define cpbus6 1359.4305, -1395.8110, 13.0687
#define cpbus7 1263.4889, -1392.8324, 12.7956
#define cpbus8 1156.7874, -1393.5610, 13.1723
#define cpbus9 1004.0629, -1393.9250, 12.6311
#define cpbus10 801.7507, -1392.7928, 13.1757
#define cpbus11 635.0526, -1392.2098, 13.0239
#define cpbus12 636.7373, -1294.9091, 14.5204
#define cpbus13 631.7147, -1217.6456, 17.7691
#define cpbus14 747.5268, -1072.1058, 22.9451
#define cpbus15 923.6449, -981.4242, 37.8171
#define cpbus16 1088.3160, -960.0802, 41.9558
#define cpbus17 1206.8578, -947.9197, 42.3778
#define cpbus18 1314.9423, -935.9100, 37.7017
#define cpbus19 1360.8773, -944.7673, 33.8446
#define cpbus20 1351.3561, -1044.5947, 26.0343
#define cpbus21 1342.0881, -1143.1753, 23.3232
#define cpbus22 1451.5962, -1163.0127, 23.3181
#define cpbus23 1452.1281, -1314.9419, 13.0429
#define cpbus24 1452.7000, -1444.1198, 13.0506
#define cpbus25 1654.6570, -1442.6141, 13.0399
#define cpbus26 1654.7021, -1482.4590, 13.0399


new BusRouteAUsed,
	BusRouteBUsed;
	//BusRouteCUsed;
	
new PlayerUsingBusRoute[MAX_PLAYERS]; // 0 = tidak pakai, 1 = Route A, 2 = Route B, 3 = Route C
new BusVeh[4];

AddBusVehicle()
{
	BusVeh[0] = AddStaticVehicleEx(431, 1704.6984, -1524.3541, 13.3736, 0.0000, -1, -1, VEHICLE_RESPAWN);
	BusVeh[1] = AddStaticVehicleEx(431, 1705.1564, -1488.2904, 13.3736, 0.0000, -1, -1, VEHICLE_RESPAWN);
	BusVeh[2] = AddStaticVehicleEx(431, 1705.3203, -1505.8333, 13.3736, 0.0000, -1, -1, VEHICLE_RESPAWN);
	//BusVeh[3] = AddStaticVehicleEx(431, 1705.1434, -1543.4546, 13.3736, 0.0000, -1, -1, VEHICLE_RESPAWN);
}

IsABusVeh(carid)
{
	for(new v = 0; v < sizeof(BusVeh); v++) {
	    if(carid == BusVeh[v]) return 1;
	}
	return 0;
}
//-----[ Bus Countdown - Harus Diam di CP ]-----
// Variable
new BusCountdown[MAX_PLAYERS];
new BusStopPBus[MAX_PLAYERS]; // Simpan pBus saat ini

// Fungsi helper untuk cek apakah player di bus stop
stock IsPlayerInBusStop(playerid, pbusvalue)
{
	switch(pbusvalue)
	{
		case 11: return IsPlayerInRangeOfPoint(playerid, 5.0, buspoint11);
		case 19: return IsPlayerInRangeOfPoint(playerid, 5.0, buspoint19);
		// Tambahkan bus stop lain...
	}
	return 0;
}

// Timer countdown
forward BusCountdownTimer(playerid);
public BusCountdownTimer(playerid)
{
	if(!IsPlayerConnected(playerid)) return 1;
	
	// Cek apakah player masih di bus stop
	if(!IsPlayerInBusStop(playerid, BusStopPBus[playerid]))
	{
		// Keluar dari CP, reset countdown
		BusCountdown[playerid] = 0;
		BusStopPBus[playerid] = 0;
	//	GameTextForPlayer(playerid, "~r~Bus Stop Cancelled", 2000, 3);
		return 1;
	}
	
	if(BusCountdown[playerid] > 0)
	{
		// Tampilkan countdown
		new string[64];
		format(string, sizeof(string), "~w~PLEASE WAIT~n~~y~%d ~w~seconds", BusCountdown[playerid]);
		GameTextForPlayer(playerid, string, 1100, 3);
		BusCountdown[playerid]--;
		
		// Lanjut ke detik berikutnya
		SetTimerEx("BusCountdownTimer", 1000, false, "i", playerid);
	}
	else
	{
		// Countdown selesai, set checkpoint berikutnya
		BusStopPBus[playerid] = 0;
		
		if(pData[playerid][pBus] == 11)
		{
			pData[playerid][pBus] = 12;
			SetPlayerRaceCheckpoint(playerid, 0, buspoint12, buspoint13, 5.0);
			PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		}
		else if(pData[playerid][pBus] == 19)
		{
			pData[playerid][pBus] = 20;
			SetPlayerRaceCheckpoint(playerid, 0, buspoint20, buspoint21, 5.0);
			PlayerPlaySound(playerid, 1139, 0.0, 0.0, 0.0);
		}
		// Tambahkan bus stop lain...
	}
	return 1;
}
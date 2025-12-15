//======== Sweper ===========
#define sweperpoint1 	1302.8302, -1849.4556, 13.0875
#define sweperpoint2 	1232.3949, -1850.0408, 13.0875
#define sweperpoint3	1183.8446, -1849.3145, 13.1076
#define sweperpoint4 	1183.2184, -1774.2012, 13.1039
#define sweperpoint5 	1178.6483, -1709.2806, 13.2418
#define sweperpoint6 	1041.8136, -1710.3401, 13.0902
#define sweperpoint7 	1065.2297, -1409.2794, 13.1431
#define sweperpoint8 	1200.0457, -1406.7920, 12.9661
#define sweperpoint9 	1340.2993, -1409.1520, 13.0545
#define sweperpoint10 	1294.2234, -1599.6781, 13.0875
#define sweperpoint11 	1295.2847, -1802.9811, 13.0883
#define sweperpoint12 	1296.9086, -1866.5306, 13.2504

#define cpswep1 		1298.5780, -1856.1818, 13.0785
#define cpswep2 		1390.7565, -1874.4198, 13.1079
#define cpswep3 		1392.2083, -1825.2299, 13.1079
#define cpswep4 		1394.0238, -1734.9700, 13.1118
#define cpswep5 		1532.8352, -1734.7449, 13.1117
#define cpswep6 		1532.9265, -1677.1617, 13.1079
#define cpswep7 		1530.4902, -1590.3329, 13.1080
#define cpswep8 		1433.3167, -1590.0101, 13.1157
#define cpswep9 		1457.8777, -1445.3361, 13.1134
#define cpswep10 		1530.3947, -1444.2867, 13.1079
#define cpswep11 		1655.5946, -1443.7605, 13.1077
#define cpswep12 		1654.1218, -1594.1459, 13.1194
#define cpswep13 		1686.2814, -1595.7411, 13.1145
#define cpswep14 		1686.9634, -1728.5503, 13.1154
#define cpswep15 		1686.2375, -1853.6815, 13.1156
#define cpswep16 		1553.0499, -1869.1846, 13.1079
#define cpswep17 		1413.4078, -1868.6414, 13.1079
#define cpswep18 		1327.8479, -1849.5575, 13.1079
#define cpswep19		1299.9303, -1863.6350, 13.5469

#define swepercp1 		1298.5313, -1852.0948, 13.1080
#define swepercp2 		1183.9670, -1849.9176, 13.1275
#define swepercp3 		1182.5780, -1710.5563, 13.2095
#define swepercp4 		1154.0594, -1709.2855, 13.5064
#define swepercp5 		1152.5205, -1653.7526, 13.5064
#define swepercp6 		1150.1276, -1570.6666, 12.9986
#define swepercp7 		1041.0161, -1570.3312, 13.1134
#define swepercp8 		921.9171,  -1569.5109, 13.1080
#define swepercp9 		920.4626,  -1414.0493, 12.9412
#define swepercp10 		920.6669,  -1375.9684, 12.9452
#define swepercp11 		921.4231,  -1330.9607, 13.2122
#define swepercp12 		1062.6602, -1326.0370, 13.1080
#define swepercp13 		1062.7950, -1285.0055, 13.3850
#define swepercp14 		1192.0583, -1282.9587, 13.0493
#define swepercp15 		1194.3517, -1335.3618, 13.1233
#define swepercp16 		1194.3982, -1399.5499, 12.9620
#define swepercp17 		1193.5675, -1567.4077, 13.1080
#define swepercp18 		1149.2621, -1569.2085, 12.9986
#define swepercp19 		1147.1945, -1713.9965, 13.5064
#define swepercp20 		1292.2675, -1714.3502, 13.1080
#define swepercp21 		1294.7943, -1823.4174, 13.1079
#define swepercp22 		1294.4216, -1865.8944, 13.2717



new SweeperRouteAUsed,
	SweeperRouteBUsed, 
	SweeperRouteCUsed;
	
new PlayerUsingSweeperRoute[MAX_PLAYERS]; // 0 = tidak pakai, 1 = Route A, 2 = Route B, 3 = Route C

new SweepVeh[5];

AddSweeperVehicle()
{
	SweepVeh[0] = AddStaticVehicleEx(574, 1303.5151, -1878.5725, 14.0000, 0.0000, 1, 1, VEHICLE_RESPAWN);
	SweepVeh[1] = AddStaticVehicleEx(574, 1301.2148, -1878.5293, 14.0000, 0.0000, 1, 1, VEHICLE_RESPAWN);
	SweepVeh[2] = AddStaticVehicleEx(574, 1298.8950, -1878.4896, 14.0000, 0.0000, 1, 1, VEHICLE_RESPAWN);
	//SweepVeh[3] = AddStaticVehicleEx(574, 1295.0103, -1878.3979, 14.0000, 0.0000, 1, 1, VEHICLE_RESPAWN);
	//SweepVeh[4] = AddStaticVehicleEx(574, 1291.9260, -1878.4087, 14.0000, 0.0000, 1, 1, VEHICLE_RESPAWN);
}

IsASweeperVeh(carid)
{
	for(new v = 0; v < sizeof(SweepVeh); v++) {
	    if(carid == SweepVeh[v]) return 1;
	}
	return 0;
}
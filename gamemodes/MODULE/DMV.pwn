//========[ DMV - Updated Coordinates ]===========
#define dmvpoint1   2039.3669, -1929.9969, 13.0736
#define dmvpoint2   1961.4358, -1929.5638, 13.0874
#define dmvpoint3   1827.2887, -1928.4904, 13.0877
#define dmvpoint4   1823.2869, -1837.9298, 13.1198
#define dmvpoint5   1693.1897, -1805.4681, 13.0873
#define dmvpoint6   1692.4103, -1737.9344, 13.0876
#define dmvpoint7   1694.5463, -1597.2538, 13.0861
#define dmvpoint8   1820.3014, -1613.1027, 13.0859
#define dmvpoint9   1848.9766, -1551.8643, 12.9296
#define dmvpoint10  1925.4437, -1520.5193, 2.9942
#define dmvpoint11  2020.6552, -1538.4968, 3.6107
#define dmvpoint12  2039.5223, -1610.6908, 13.0870
#define dmvpoint13  2076.6672, -1614.6458, 13.0809
#define dmvpoint14  2079.3772, -1737.8307, 13.0903
#define dmvpoint15  2086.5969, -1761.6428, 13.1064
#define dmvpoint16  2079.0024, -1819.0388, 13.0875
#define dmvpoint17  2078.4399, -1909.6899, 13.0599
#define dmvpoint18  2060.4077, -1912.5676, 13.2524


new DmvVeh[4];

AddDmvVehicle()
{
	DmvVeh[0] = AddStaticVehicleEx(602, 2052.7083, -1904.0043, 13.3536, 179.3548, 1, 1, VEHICLE_RESPAWN);
	DmvVeh[1] = AddStaticVehicleEx(602, 2056.0083, -1903.9602, 13.3530, 178.6753, 1, 1, VEHICLE_RESPAWN);
	DmvVeh[2] = AddStaticVehicleEx(602, 2059.1909, -1904.1512, 13.3532, 179.2641, 1, 1, VEHICLE_RESPAWN);
	DmvVeh[3] = AddStaticVehicleEx(602, 2062.4348, -1903.9548, 13.3536, 179.3495, 1, 1, VEHICLE_RESPAWN);
}

IsADmvVeh(carid)
{
	for(new v = 0; v < sizeof(DmvVeh); v++) {
	    if(carid == DmvVeh[v]) return 1;
	}
	return 0;
}

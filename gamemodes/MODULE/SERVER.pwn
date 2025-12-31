new ServerMoney, //2255.92, -1747.33, 1014.77
	Material,
	MaterialPrice,
	LumberPrice,
	Component,
	ComponentPrice,
	MetalPrice,
	GasOil,
	GasOilPrice,
	CoalPrice,
	Product,
	ProductPrice,
	RawComponent,
	RawFish,
	Apotek,
	MedicinePrice,
	MedkitPrice,
	Food,
	FoodPrice,
	SeedPrice,
	PotatoPrice,
	WheatPrice,
	OrangePrice,
	Marijuana,
	MarijuanaPrice,
	FishPrice,
	GStationPrice,
	ObatMyr,
	ObatPrice;
	
new MoneyPickup,
	Text3D:MoneyText,
	MatPickup,
	Text3D:MatText,
	CompPickup,
	Text3D:CompText,
	GasOilPickup,
	Text3D:GasOilText,
	RawComponentPickup,
	Text3D:RawComponentText,
	OrePickup,
	Text3D:OreText,
	ProductPickup,
	Text3D:ProductText,
	ProductPickup2,
	Text3D:ProductText2,
	ApotekPickup,
	Text3D:ApotekText,
	FoodPickup,
	Text3D:FoodText,
	DrugPickup,
	Text3D:DrugText,
	ObatPickup,
	Text3D:ObatText,
	CargoPickup,
	Text3D:CargoText,
	TruckerBuyCompoPickup,
	Text3D:TruckerBuyCompoText,
	FishPickup,
	Text3D:FishText,
	RawFishPickup,
	Text3D:RawFishText,
	TruckerBuyFishPickup,
	Text3D:TruckerBuyFishText;
	
CreateServerPoint()
{
	if(IsValidDynamic3DTextLabel(MoneyText))
            DestroyDynamic3DTextLabel(MoneyText);

	if(IsValidDynamicPickup(MoneyPickup))
		DestroyDynamicPickup(MoneyPickup);
			
	//Server Money
	new strings[1024];
	MoneyPickup = CreateDynamicPickup(1239, 23, -2694.4294, 810.9385, 1500.9688, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Server Money]\n"WHITE_E"Government Money: "LG_E"%s", FormatMoney(ServerMoney));
	MoneyText = CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -2694.4294, 810.9385, 1500.9688, 5.0);
	
	if(IsValidDynamic3DTextLabel(MatText))
            DestroyDynamic3DTextLabel(MatText);

	if(IsValidDynamicPickup(MatPickup))
		DestroyDynamicPickup(MatPickup);
	
	if(IsValidDynamic3DTextLabel(CompText))
            DestroyDynamic3DTextLabel(CompText);

	if(IsValidDynamicPickup(CompPickup))
		DestroyDynamicPickup(CompPickup);
	
	if(IsValidDynamic3DTextLabel(GasOilText))
            DestroyDynamic3DTextLabel(GasOilText);

	if(IsValidDynamicPickup(GasOilPickup))
		DestroyDynamicPickup(GasOilPickup);
		
	if(IsValidDynamic3DTextLabel(RawComponentText))
            DestroyDynamic3DTextLabel(RawComponentText);

	if(IsValidDynamicPickup(RawComponentPickup))
		DestroyDynamicPickup(RawComponentPickup);

	if(IsValidDynamic3DTextLabel(OreText))
            DestroyDynamic3DTextLabel(OreText);

	if(IsValidDynamicPickup(OrePickup))
		DestroyDynamicPickup(OrePickup);
		
	if(IsValidDynamic3DTextLabel(ProductText))
            DestroyDynamic3DTextLabel(ProductText);
		
	if(IsValidDynamicPickup(ProductPickup))
		DestroyDynamicPickup(ProductPickup);

	if(IsValidDynamic3DTextLabel(ProductText2))
            DestroyDynamic3DTextLabel(ProductText2);
		
	if(IsValidDynamicPickup(ProductPickup2))
		DestroyDynamicPickup(ProductPickup2);

	if(IsValidDynamic3DTextLabel(ApotekText))
            DestroyDynamic3DTextLabel(ApotekText);
		
	if(IsValidDynamicPickup(ApotekPickup))
		DestroyDynamicPickup(ApotekPickup);
	
	if(IsValidDynamic3DTextLabel(FoodText))
            DestroyDynamic3DTextLabel(FoodText);
		
	if(IsValidDynamicPickup(FoodPickup))
		DestroyDynamicPickup(FoodPickup);
		
	if(IsValidDynamic3DTextLabel(DrugText))
            DestroyDynamic3DTextLabel(DrugText);
		
	if(IsValidDynamicPickup(DrugPickup))
		DestroyDynamicPickup(DrugPickup);

	if(IsValidDynamic3DTextLabel(ObatText))
            DestroyDynamic3DTextLabel(ObatText);
		
	if(IsValidDynamicPickup(ObatPickup))
		DestroyDynamicPickup(ObatPickup);

	if(IsValidDynamicPickup(DrugPickup))
		DestroyDynamicPickup(DrugPickup);

	if(IsValidDynamic3DTextLabel(CargoText))
            DestroyDynamic3DTextLabel(CargoText);
		
	if(IsValidDynamicPickup(CargoPickup))
		DestroyDynamicPickup(CargoPickup);

	if(IsValidDynamic3DTextLabel(TruckerBuyCompoText))
            DestroyDynamic3DTextLabel(TruckerBuyCompoText);
		
	if(IsValidDynamicPickup(TruckerBuyCompoPickup))
		DestroyDynamicPickup(TruckerBuyCompoPickup);

	if(IsValidDynamic3DTextLabel(FishText))
            DestroyDynamic3DTextLabel(FishText);
		
	if(IsValidDynamicPickup(FishPickup))
		DestroyDynamicPickup(FishPickup);

	if(IsValidDynamic3DTextLabel(TruckerBuyFishText))
            DestroyDynamic3DTextLabel(TruckerBuyFishText);
		
	if(IsValidDynamicPickup(TruckerBuyFishPickup))
		DestroyDynamicPickup(TruckerBuyFishPickup);

	if(IsValidDynamic3DTextLabel(RawFishText))
            DestroyDynamic3DTextLabel(RawFishText);
		
	if(IsValidDynamicPickup(RawFishPickup))
		DestroyDynamicPickup(RawFishPickup);
	
		
	//JOBS
	MatPickup = CreateDynamicPickup(1239, 23, -258.54, -2189.92, 28.97, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Material]\n"WHITE_E"Material Stock: "LG_E"%d\n\n"WHITE_E"Material Price: "LG_E"%s /item\n\n"WHITE_E"Lumber Price: "LG_E"%s /item\n"LB_E"/buy", Material, FormatMoney(MaterialPrice), FormatMoney(LumberPrice));
	MatText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -258.54, -2189.92, 28.97, 5.0); // lumber
	
	CompPickup = CreateDynamicPickup(1239, 23, 854.5555, -605.2056, 18.4219, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Component]\n"WHITE_E"Component Stock: "LG_E"%d\n\n"WHITE_E"Component Price: "LG_E"%s /item\n"LB_E"/buy", Component, FormatMoney(ComponentPrice));
	CompText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 854.5555, -605.2056, 18.4219, 5.0); // comp
	
	GasOilPickup = CreateDynamicPickup(1239, 23, 336.70, 895.54, 20.40, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Miner]\n"WHITE_E"GasOil Stock: "LG_E"%d liters\n\n"WHITE_E"GasOil Price: "LG_E"%s /liters\n"LB_E"/buy", GasOil, FormatMoney(GasOilPrice));
	GasOilText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 336.70, 895.54, 20.40, 5.0); // gasoil

	TruckerBuyCompoPickup = CreateDynamicPickup(2912, 23, 323.5624, 904.4940, 21.5862, -1, -1, -1, 50.0);
	new crateComponentStock = RawComponent / 20; // Hitung berapa crate tersedia
	format(strings, sizeof(strings), "[Component Crate]\n"WHITE_E"Stock: "LG_E"%d Crates "GREY_E"(%d kg)\n"YELLOW_E"Take crate and deliver to store\n"LB_E"/takecrate", crateComponentStock, RawComponent);
	TruckerBuyCompoText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 323.5624, 904.4940, 21.5862, 5.0); // rawcomponent

	RawComponentPickup = CreateDynamicPickup(1239, 23, 797.5262, -617.7863, 16.3359, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Trucker Store Component]\n"WHITE_E"Component Stock: "LG_E"%d\n\n"LB_E"/storecrate", Component);
	RawComponentText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 797.5262, -617.7863, 16.3359, 5.0); // rawcomponent
	

	TruckerBuyFishPickup = CreateDynamicPickup(2912, 23, 2836.5061,-1540.5342,11.0991, -1, -1, -1, 50.0);
	new crateFishStock = RawFish / 20; // Hitung berapa crate tersedia
	format(strings, sizeof(strings), "[Fish Crate]\n"WHITE_E"Stock: "LG_E"%d Crates "GREY_E"(%d kg)\n"YELLOW_E"Take crate and deliver to store\n"LB_E"/takecrate", crateFishStock, RawFish);
	TruckerBuyFishText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2836.5061,-1540.5342,11.0991, 5.0);


	RawFishPickup = CreateDynamicPickup(1239, 23, -377.0572, -1445.5399, 25.7266, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Trucker Store Fish]\n"WHITE_E"Fish Stock: "LG_E"%d\n\n"LB_E"/storecrate", Food);
	RawFishText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -377.0572, -1445.5399, 25.7266, 5.0); // rawfish

	OrePickup = CreateDynamicPickup(1239, 23, 298.0443, 907.1157, 20.4363, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Miner]\n"WHITE_E"Ore Metal Price: "LG_E"%s / item\n\n"WHITE_E"Ore Coal Price: "LG_E"%s /item\n"LB_E"/ore sell", FormatMoney(MetalPrice), FormatMoney(CoalPrice));
	OreText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 298.0443, 907.1157, 20.4363, 5.0); // sell ore
	
	ProductPickup = CreateDynamicPickup(1239, 23, -198.4669, -203.1409, 1.4219, -1, -1, -1, 50.0);
	ProductPickup2 = CreateDynamicPickup(1239, 23, 1208.0065, 185.8374, 20.5067, -1, -1, -1, 50.0);

	format(strings, sizeof(strings), "[PRODUCT]\n"WHITE_E"Product Stock: "LG_E"%d\n\n"WHITE_E"Product Price: "LG_E"%s /item\n"LB_E"/buy", Product, FormatMoney(ProductPrice));
	ProductText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -198.4669, -203.1409, 1.4219, 5.0);
	ProductText2 = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 1208.0065, 185.8374, 20.5067, 5.0); // product

	ApotekPickup = CreateDynamicPickup(1241, 23, -1774.0746, -2005.6477, 1500.7853, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Hospital]\n"WHITE_E"Apotek Stock: "LG_E"%d\n"LB_E"/buy", Apotek);
	ApotekText = CreateDynamic3DTextLabel(strings, COLOR_PINK, -1774.0746, -2005.6477, 1500.7853, 5.0); // Apotek hospital
	
	FoodPickup = CreateDynamicPickup(1239, 23, -381.44, -1426.13, 25.93, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Food]\n"WHITE_E"Food Stock: "LG_E"%d\n"WHITE_E"Food Price: "LG_E"%s /item\n\n"WHITE_E"Seed Price: "LG_E"%s /item\n"WHITE_E"Potato Price: "LG_E"%s /kg\n"WHITE_E"Wheat Price: "LG_E"%s /kg\n"WHITE_E"Orange Price: "LG_E"%s /kg\n\n"LB_E"/buy", 
	Food, FormatMoney(FoodPrice), FormatMoney(SeedPrice), FormatMoney(PotatoPrice), FormatMoney(WheatPrice), FormatMoney(OrangePrice), FormatMoney(FishPrice));
	FoodText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, -381.44, -1426.13 , 25.93+1, 5.0); // food 
	
	FishPickup = CreateDynamicPickup(1239, 23, 2843.9133, -1516.6660, 11.3011, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Fish Factory]\n"WHITE_E"Fish Price: "LG_E"%s\n\n"LB_E"/sellfish", FormatMoney(FishPrice));
	FishText = CreateDynamic3DTextLabel(strings, COLOR_YELLOW, 2843.9133, -1516.6660, 11.3011, 5.0); // fish factory

	DrugPickup = CreateDynamicPickup(1239, 23, 874.52, -15.98, 63.19, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Black Market]\n"WHITE_E"Marijuana Stock: "LG_E"%d\n\n"WHITE_E"Marijuana Price: "LG_E"%s /item\n"LB_E"/buy /sellmarijuana", Marijuana, FormatMoney(MarijuanaPrice));
	DrugText = CreateDynamic3DTextLabel(strings, COLOR_GREY, 874.52, -15.98, 63.19, 5.0); // product

	ObatPickup = CreateDynamicPickup(1241, 23, -1772.3304, -2013.1531, 1500.7853, -1, -1, -1, 50.0);
	format(strings, sizeof(strings), "[Obat Myricous]\n"WHITE_E"Myricous Stock: "LG_E"%d\n\n"WHITE_E"Myricous Price: "LG_E"%s /item\n"LB_E"/buy", ObatMyr, FormatMoney(ObatPrice));
	ObatText = CreateDynamic3DTextLabel(strings, COLOR_GREY, -1772.3304, -2013.1531, 1500.7853, 5.0); // product

	//Vending Restock
	new box = ProductPrice*15;
	CargoPickup = CreateDynamicPickup(1271, 23, -50.61, -233.28, 6.76, -1, -1, -1, 50);
	format(strings, sizeof(strings), "[Cargo Warehouse]\n"WHITE_E"Box Stock: "LG_E"%d\n\n"WHITE_E"Product Price: "LG_E"%s /item\n"LB_E"/cargo buy", Product, FormatMoney(box));
	CargoText = CreateDynamic3DTextLabel(strings, COLOR_LBLUE, -50.61, -233.28, 6.76, 5.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1); // Vending Product
}

Server_Percent(price)
{
    return floatround((float(price) / 100) * 85);
}

Server_AddPercent(price)
{
    new money = (price - Server_Percent(price));
    ServerMoney = ServerMoney + money;
    Server_Save();
}

Server_AddMoney(amount)
{
    ServerMoney = ServerMoney + amount;
    Server_Save();
}

Server_MinMoney(amount)
{
    ServerMoney -= amount;
    Server_Save();
}

Server_Save()
{
    new str[2024];

	CreateServerPoint();
    format(str, sizeof(str), "UPDATE server SET servermoney='%d', material='%d', materialprice='%d', lumberprice='%d', component='%d', componentprice='%d', metalprice='%d', gasoil='%d', gasoilprice='%d', coalprice='%d', product='%d', productprice='%d', medicineprice='%d', medkitprice='%d', food='%d', foodprice='%d', seedprice='%d', potatoprice='%d', wheatprice='%d', orangeprice='%d', marijuana='%d', marijuanaprice='%d', fishprice='%d', gstationprice='%d', obatmyr='%d', obatprice='%d', rawcomponent='%d' WHERE id=0",
	ServerMoney, Material, MaterialPrice, LumberPrice, Component, ComponentPrice, MetalPrice, GasOil, GasOilPrice, CoalPrice, Product, ProductPrice, MedicinePrice, MedkitPrice, 
	Food, FoodPrice, SeedPrice, PotatoPrice, WheatPrice, OrangePrice, Marijuana, MarijuanaPrice, FishPrice, GStationPrice, ObatMyr, ObatPrice, RawComponent, RawFish);
    return mysql_tquery(g_SQL, str);
}

function LoadServer()
{
	cache_get_value_name_int(0, "servermoney", ServerMoney);
	cache_get_value_name_int(0, "material", Material);
	cache_get_value_name_int(0, "materialprice", MaterialPrice);
	cache_get_value_name_int(0, "lumberprice", LumberPrice);
	cache_get_value_name_int(0, "component", Component);
	cache_get_value_name_int(0, "componentprice", ComponentPrice);
	cache_get_value_name_int(0, "metalprice", MetalPrice);
	cache_get_value_name_int(0, "gasoil", GasOil);
	cache_get_value_name_int(0, "gasoilprice", GasOilPrice);
	cache_get_value_name_int(0, "coalprice", CoalPrice);
	cache_get_value_name_int(0, "product", Product);
	cache_get_value_name_int(0, "productprice", ProductPrice);
	cache_get_value_name_int(0, "apotek", Apotek);
	cache_get_value_name_int(0, "medicineprice", MedicinePrice);
	cache_get_value_name_int(0, "medkitprice", MedkitPrice);
	cache_get_value_name_int(0, "food", Food);
	cache_get_value_name_int(0, "foodprice", FoodPrice);
	cache_get_value_name_int(0, "seedprice", SeedPrice);
	cache_get_value_name_int(0, "potatoprice", PotatoPrice);
	cache_get_value_name_int(0, "wheatprice", WheatPrice);
	cache_get_value_name_int(0, "orangeprice", OrangePrice);
	cache_get_value_name_int(0, "marijuana", Marijuana);
	cache_get_value_name_int(0, "marijuanaprice", MarijuanaPrice);
	cache_get_value_name_int(0, "fishprice", FishPrice);
	cache_get_value_name_int(0, "gstationprice", GStationPrice);
	cache_get_value_name_int(0, "obatmyr", ObatMyr);
	cache_get_value_name_int(0, "obatprice", ObatPrice);
	cache_get_value_name_int(0, "rawcomponent", RawComponent);
	cache_get_value_name_int(0, "rawfish", RawFish);
	//cache_get_value_name_int(0, "rawcomponentprice", RawComponentPrice);
	printf("[Server] Loaded Data Server...");
	printf("[Server] %d Server Money", ServerMoney);
	//printf("[Server] Material: %d", Material);
	//printf("[Server] MaterialPrice: %d", MaterialPrice);
	//printf("[Server] LumberPrice: %d", LumberPrice);
	
	CreateServerPoint();
}
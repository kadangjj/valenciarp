#define MAX_DROPPED_ITEMS 500

enum droppedItemData
{
    dItemDBID,
    dItemType[32],
    dItemAmount,
    dItemWeaponID,      // Tambahan untuk weapon
    Float:dItemX,
    Float:dItemY,
    Float:dItemZ,
    dItemInt,
    dItemVW,
    dItemObject,
    Text3D:dItemLabel,
    bool:dItemExists
}

new DropItemData[MAX_DROPPED_ITEMS][droppedItemData];
new Iterator:DroppedItems<MAX_DROPPED_ITEMS>;

stock GetItemObjectModel(const itemtype[])
{
    if(strcmp(itemtype, "bandage", true) == 0) return 11738;
    if(strcmp(itemtype, "medicine", true) == 0) return 1575;
    if(strcmp(itemtype, "snack", true) == 0) return 2880;
    if(strcmp(itemtype, "sprunk", true) == 0) return 1546;
    if(strcmp(itemtype, "redmoney", true) == 0) return 1212;
    if(strcmp(itemtype, "material", true) == 0) return 1463;
    if(strcmp(itemtype, "component", true) == 0) return 1279;
    if(strcmp(itemtype, "marijuana", true) == 0) return 3409;
    if(strcmp(itemtype, "obat", true) == 0) return 1580;
    if(strcmp(itemtype, "gas", true) == 0) return 1650;
    if(strcmp(itemtype, "weapon", true) == 0) return 0; // Will be set by CreateDroppedWeapon
    return 1550;
}

stock GetItemDisplayName(const itemtype[])
{
    new name[32];
    if(strcmp(itemtype, "bandage", true) == 0) format(name, sizeof(name), "Bandage");
    else if(strcmp(itemtype, "medicine", true) == 0) format(name, sizeof(name), "Medicine");
    else if(strcmp(itemtype, "snack", true) == 0) format(name, sizeof(name), "Snack");
    else if(strcmp(itemtype, "sprunk", true) == 0) format(name, sizeof(name), "Sprunk");
    else if(strcmp(itemtype, "redmoney", true) == 0) format(name, sizeof(name), "Red Money");
    else if(strcmp(itemtype, "material", true) == 0) format(name, sizeof(name), "Material");
    else if(strcmp(itemtype, "component", true) == 0) format(name, sizeof(name), "Component");
    else if(strcmp(itemtype, "marijuana", true) == 0) format(name, sizeof(name), "Marijuana");
    else if(strcmp(itemtype, "obat", true) == 0) format(name, sizeof(name), "Obat");
    else if(strcmp(itemtype, "gas", true) == 0) format(name, sizeof(name), "Gas");
    else if(strcmp(itemtype, "weapon", true) == 0) format(name, sizeof(name), "Weapon");
    else format(name, sizeof(name), "Unknown");
    return name;
}

stock GetNearestDroppedItem(playerid, Float:range = 2.0)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    
    foreach(new i : DroppedItems)
    {
        if(DropItemData[i][dItemExists])
        {
            if(GetPlayerVirtualWorld(playerid) == DropItemData[i][dItemVW] && 
               GetPlayerInterior(playerid) == DropItemData[i][dItemInt])
            {
                if(IsPlayerInRangeOfPoint(playerid, range, DropItemData[i][dItemX], DropItemData[i][dItemY], DropItemData[i][dItemZ]))
                {
                    return i;
                }
            }
        }
    }
    return -1;
}

stock CreateDroppedItem(const itemtype[], amount, Float:x, Float:y, Float:z, interior, virtualworld/*, bool:savetodb = true*/)
{
    new id = Iter_Free(DroppedItems);
    if(id == INVALID_ITERATOR_SLOT) return -1;
    
    format(DropItemData[id][dItemType], 32, itemtype);
    DropItemData[id][dItemAmount] = amount;
    DropItemData[id][dItemWeaponID] = 0;
    DropItemData[id][dItemX] = x;
    DropItemData[id][dItemY] = y;
    DropItemData[id][dItemZ] = z - 0.9;
    DropItemData[id][dItemInt] = interior;
    DropItemData[id][dItemVW] = virtualworld;
    DropItemData[id][dItemExists] = true;
    DropItemData[id][dItemDBID] = 0;
    
    new modelid = GetItemObjectModel(itemtype);
    DropItemData[id][dItemObject] = CreateDynamicObject(modelid, x, y, z - 0.9, 0.0, 0.0, 0.0, virtualworld, interior);
    
    new labeltext[128];
    format(labeltext, sizeof(labeltext), "{FFFF00}%s\n{FFFFFF}Amount: {00FF00}%d\n{FFFFFF}Press {FFFF00}'N' {FFFFFF}to pickup", 
           GetItemDisplayName(itemtype), amount);
    DropItemData[id][dItemLabel] = CreateDynamic3DTextLabel(labeltext, 0xFFFFFFFF, x, y, z - 0.25, 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, virtualworld, interior);    
    
    Iter_Add(DroppedItems, id);
    
   /* if(savetodb)
    {
        new query[256];
        mysql_format(g_SQL, query, sizeof(query), 
            "INSERT INTO dropped_items (item_type, amount, weapon_id, x, y, z, interior, virtualworld) VALUES ('%e', %d, 0, %f, %f, %f, %d, %d)",
            itemtype, amount, x, y, z, interior, virtualworld);
        new Cache:result = mysql_query(g_SQL, query);
        DropItemData[id][dItemDBID] = cache_insert_id();
        cache_delete(result);
    }*/
    
    return id;
}

stock CreateDroppedWeapon(weaponid, ammo, Float:x, Float:y, Float:z, interior, virtualworld)
{
    new id = Iter_Free(DroppedItems);
    if(id == INVALID_ITERATOR_SLOT) return -1;
    
    format(DropItemData[id][dItemType], 32, "weapon");
    DropItemData[id][dItemAmount] = ammo;
    DropItemData[id][dItemWeaponID] = weaponid;
    DropItemData[id][dItemX] = x;
    DropItemData[id][dItemY] = y;
    DropItemData[id][dItemZ] = z - 0.9;
    DropItemData[id][dItemInt] = interior;
    DropItemData[id][dItemVW] = virtualworld;
    DropItemData[id][dItemExists] = true;
    DropItemData[id][dItemDBID] = 0;
    
    new modelid = GetWeaponModel(weaponid);
    if(IsWeaponModel(modelid))
    {
        DropItemData[id][dItemObject] = CreateDynamicObject(modelid, x, y, z - 0.9, 93.7, 120.0, 120.0, virtualworld, interior);
    }
    else
    {
        DropItemData[id][dItemObject] = CreateDynamicObject(modelid, x, y, z - 0.9, 0.0, 0.0, 0.0, virtualworld, interior);
    }
    
    new labeltext[128];
    format(labeltext, sizeof(labeltext), "{FFFF00}%s\n{FFFFFF}Ammo: {00FF00}%d\n{FFFFFF}Press {FFFF00}'N' {FFFFFF}to pickup", 
           ReturnWeaponName(weaponid), ammo);
    // Untuk object kecil (item drop), posisinya sedikit di bawah
    DropItemData[id][dItemLabel] = CreateDynamic3DTextLabel(labeltext, 0xFFFFFFFF, x, y, z - 0.25, 2.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, virtualworld, interior);    
    Iter_Add(DroppedItems, id);
    
    // Save to database
    new query[256];
    mysql_format(g_SQL, query, sizeof(query), 
        "INSERT INTO dropped_items (item_type, amount, weapon_id, x, y, z, interior, virtualworld) VALUES ('weapon', %d, %d, %f, %f, %f, %d, %d)",
        ammo, weaponid, x, y, z, interior, virtualworld);
    new Cache:result = mysql_query(g_SQL, query);
    DropItemData[id][dItemDBID] = cache_insert_id();
    cache_delete(result);
    
    return id;
}

stock DeleteDroppedItem(itemid)
{
    if(!Iter_Contains(DroppedItems, itemid)) return 0;
    if(!DropItemData[itemid][dItemExists]) return 0;
    
    if(DropItemData[itemid][dItemDBID] > 0)
    {
        new query[128];
        mysql_format(g_SQL, query, sizeof(query), "DELETE FROM dropped_items WHERE id = %d", DropItemData[itemid][dItemDBID]);
        mysql_tquery(g_SQL, query);
    }
    
    if(IsValidDynamicObject(DropItemData[itemid][dItemObject]))
        DestroyDynamicObject(DropItemData[itemid][dItemObject]);
    
    if(IsValidDynamic3DTextLabel(DropItemData[itemid][dItemLabel]))
        DestroyDynamic3DTextLabel(DropItemData[itemid][dItemLabel]);
    
    DropItemData[itemid][dItemExists] = false;
    DropItemData[itemid][dItemDBID] = 0;
    DropItemData[itemid][dItemWeaponID] = 0;
    Iter_Remove(DroppedItems, itemid);
    
    return 1;
}

/*stock LoadDroppedItems()
{
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "SELECT * FROM dropped_items");
    new Cache:result = mysql_query(g_SQL, query);
    
    new rows = cache_num_rows();
    if(rows)
    {
        new id, dbid, itemtype[32], amount, weaponid, Float:x, Float:y, Float:z, interior, vw;
        
        for(new i = 0; i < rows; i++)
        {
            cache_get_value_name_int(i, "id", dbid);
            cache_get_value_name(i, "item_type", itemtype, 32);
            cache_get_value_name_int(i, "amount", amount);
            cache_get_value_name_int(i, "weapon_id", weaponid);
            cache_get_value_name_float(i, "x", x);
            cache_get_value_name_float(i, "y", y);
            cache_get_value_name_float(i, "z", z);
            cache_get_value_name_int(i, "interior", interior);
            cache_get_value_name_int(i, "virtualworld", vw);
            
            if(strcmp(itemtype, "weapon", true) == 0)
            {
                id = CreateDroppedWeapon(weaponid, amount, x, y, z + 0.9, interior, vw);
            }
            else
            {
                id = CreateDroppedItem(itemtype, amount, x, y, z + 0.9, interior, vw, false);
            }
            
            if(id != -1)
            {
                DropItemData[id][dItemDBID] = dbid;
            }
        }
        printf("[Dropped Items]: %d items loaded from database.", rows);
    }
    
    cache_delete(result);
    return 1;
}*/

// COMMAND: /drop
CMD:drop(playerid, params[])
{
    if(IsAtEvent[playerid] == 1)
        return Error(playerid, "Anda sedang mengikuti event & tidak bisa melakukan ini");
    
    new itemtype[32], amount;
    if(sscanf(params, "s[32]D(0)", itemtype, amount))
    {
        Usage(playerid, "/drop [item] [amount]");
        Info(playerid, "Items: bandage, medicine, snack, sprunk, redmoney, material, component, marijuana, obat, gas, weapon");
        return 1;
    }
    
    new Float:x, Float:y, Float:z, Float:angle;
    GetPlayerPos(playerid, x, y, z);
    
    new bool:valid = false;
    
    // Drop weapon
    if(strcmp(itemtype, "weapon", true) == 0)
    {
        new weaponid = GetPlayerWeaponEx(playerid);
        new ammo = GetPlayerAmmoEx(playerid);
        
        if(!weaponid)
            return Error(playerid, "You are not holding a weapon!");
        
        GetPlayerFacingAngle(playerid, angle);
        x += 1 * floatsin(-angle, degrees);
        y += 1 * floatcos(-angle, degrees);
        
        CreateDroppedWeapon(weaponid, ammo, x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
        ResetWeapon(playerid, weaponid);
        
        ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
        Info(playerid, "You dropped %s with %d ammo on the ground.", ReturnWeaponName(weaponid), ammo);
        SendNearbyMessage(playerid, 30.0, COLOR_PURPLE, "* %s takes out a %s and drops it on the floor.", ReturnName(playerid), ReturnWeaponName(weaponid));
        return 1;
    }
    
    if(amount < 1 || amount > 500)
        return Error(playerid, "Amount must be between 1 and 500!");
    
    if(strcmp(itemtype, "bandage", true) == 0 && pData[playerid][pBandage] >= amount) {
        pData[playerid][pBandage] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "medicine", true) == 0 && pData[playerid][pMedicine] >= amount) {
        pData[playerid][pMedicine] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "snack", true) == 0 && pData[playerid][pSnack] >= amount) {
        pData[playerid][pSnack] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "sprunk", true) == 0 && pData[playerid][pSprunk] >= amount) {
        pData[playerid][pSprunk] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "redmoney", true) == 0 && pData[playerid][pRedMoney] >= amount) {
        pData[playerid][pRedMoney] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "material", true) == 0 && pData[playerid][pMaterial] >= amount) {
        pData[playerid][pMaterial] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "component", true) == 0 && pData[playerid][pComponent] >= amount) {
        pData[playerid][pComponent] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "marijuana", true) == 0 && pData[playerid][pMarijuana] >= amount) {
        pData[playerid][pMarijuana] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "obat", true) == 0 && pData[playerid][pObat] >= amount) {
        pData[playerid][pObat] -= amount;
        valid = true;
    }
    else if(strcmp(itemtype, "gas", true) == 0 && pData[playerid][pGas] >= amount) {
        pData[playerid][pGas] -= amount;
        valid = true;
    }
    
    if(!valid)
        return Error(playerid, "You don't have enough %s!", GetItemDisplayName(itemtype));
    
    CreateDroppedItem(itemtype, amount, x, y, z, GetPlayerInterior(playerid), GetPlayerVirtualWorld(playerid));
    
    ApplyAnimation(playerid, "GRENADE", "WEAPON_throwu", 4.1, 0, 0, 0, 0, 0);
    Info(playerid, "You dropped %d %s on the ground.", amount, GetItemDisplayName(itemtype));
    
    return 1;
}

CMD:pickup(playerid, params[])
{
    new itemid = GetNearestDroppedItem(playerid, 2.0);
    
    if(itemid == -1)
        return Error(playerid, "There's no item near you!");
    
    new itemtype[32], amount;
    format(itemtype, sizeof(itemtype), DropItemData[itemid][dItemType]);
    amount = DropItemData[itemid][dItemAmount];
    
    new bool:valid = false;
    
    if(strcmp(itemtype, "weapon", true) == 0)
    {
        new weaponid = DropItemData[itemid][dItemWeaponID];
        GivePlayerWeaponEx(playerid, weaponid, amount);
        ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
        Info(playerid, "You picked up %s with %d ammo.", ReturnWeaponName(weaponid), amount);
        DeleteDroppedItem(itemid);
        return 1;
    }
    else if(strcmp(itemtype, "bandage", true) == 0) {
        pData[playerid][pBandage] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "medicine", true) == 0) {
        pData[playerid][pMedicine] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "snack", true) == 0) {
        pData[playerid][pSnack] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "sprunk", true) == 0) {
        pData[playerid][pSprunk] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "redmoney", true) == 0) {
        pData[playerid][pRedMoney] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "material", true) == 0) {
        if(pData[playerid][pMaterial] + amount > 500)
            return Error(playerid, "You can't carry more than 500 materials!");
        pData[playerid][pMaterial] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "component", true) == 0) {
        if(pData[playerid][pComponent] + amount > 500)
            return Error(playerid, "You can't carry more than 500 components!");
        pData[playerid][pComponent] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "marijuana", true) == 0) {
        pData[playerid][pMarijuana] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "obat", true) == 0) {
        pData[playerid][pObat] += amount;
        valid = true;
    }
    else if(strcmp(itemtype, "gas", true) == 0) {
        pData[playerid][pGas] += amount;
        valid = true;
    }
    
    if(!valid)
        return Error(playerid, "Failed to pickup item!");
    
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
    Info(playerid, "You picked up %d %s.", amount, GetItemDisplayName(itemtype));
    
    DeleteDroppedItem(itemid);
    
    return 1;
}
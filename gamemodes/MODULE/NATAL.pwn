/*
    Sistem Kado Natal SA-MP - One Time Use (No Respawn)
*/

#define MAX_KADO 100

enum E_KADO
{
    // loaded from db
    Float:kadoX,
    Float:kadoY,
    Float:kadoZ,
    Float:kadoRX,
    Float:kadoRY,
    Float:kadoRZ,
    // temp
    bool:kadoTaken,
    kadoObjID,
    Text3D:kadoLabel
}

new KadoData[MAX_KADO][E_KADO],
    Iterator:Kados<MAX_KADO>;

function LoadKados()
{
    new kid;
    
    new rows = cache_num_rows();
    if(rows)
    {
        for(new i; i < rows; i++)
        {
            cache_get_value_name_int(i, "id", kid);
            cache_get_value_name_float(i, "posx", KadoData[kid][kadoX]);
            cache_get_value_name_float(i, "posy", KadoData[kid][kadoY]);
            cache_get_value_name_float(i, "posz", KadoData[kid][kadoZ]);
            cache_get_value_name_float(i, "posrx", KadoData[kid][kadoRX]);
            cache_get_value_name_float(i, "posry", KadoData[kid][kadoRY]);
            cache_get_value_name_float(i, "posrz", KadoData[kid][kadoRZ]);
            
            new label[128];
            format(label, sizeof(label), "{00FF00}Christmas Gift (%d)\n{FFFFFF}/claimgift", kid);
            KadoData[kid][kadoLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ] + 0.5, 5.0);
            KadoData[kid][kadoObjID] = CreateDynamicObject(19054, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ], KadoData[kid][kadoRX], KadoData[kid][kadoRY], KadoData[kid][kadoRZ]);
            Iter_Add(Kados, kid);
            
            KadoData[kid][kadoTaken] = false;
        }
        printf("[Christmas Gifts]: %d Loaded.", rows);
    }
}

Kado_Save(kid)
{
    new cQuery[512];
    format(cQuery, sizeof(cQuery), "UPDATE kados SET posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f' WHERE id='%d'",
        KadoData[kid][kadoX],
        KadoData[kid][kadoY],
        KadoData[kid][kadoZ],
        KadoData[kid][kadoRX],
        KadoData[kid][kadoRY],
        KadoData[kid][kadoRZ],
        kid
    );
    return mysql_tquery(g_SQL, cQuery);
}

GetClosestKado(playerid, Float:range = 2.0)
{
    new id = -1, Float:dist = range, Float:tempdist;
    foreach(new i : Kados)
    {
        if(KadoData[i][kadoTaken]) continue; // Skip kado yang sudah diambil
        
        tempdist = GetPlayerDistanceFromPoint(playerid, KadoData[i][kadoX], KadoData[i][kadoY], KadoData[i][kadoZ]);

        if(tempdist > range) continue;
        if(tempdist <= dist)
        {
            dist = tempdist;
            id = i;
        }
    }
    return id;
}

Kado_Delete(kid)
{
    if(!Iter_Contains(Kados, kid)) return 0;
    
    // Hapus object dan label
    if(IsValidDynamicObject(KadoData[kid][kadoObjID]))
        DestroyDynamicObject(KadoData[kid][kadoObjID]);
    
    if(IsValidDynamic3DTextLabel(KadoData[kid][kadoLabel]))
        DestroyDynamic3DTextLabel(KadoData[kid][kadoLabel]);
    
    // Hapus dari database
    new query[128];
    mysql_format(g_SQL, query, sizeof(query), "DELETE FROM kados WHERE id=%d", kid);
    mysql_tquery(g_SQL, query);
    
    // Hapus dari iterator
    KadoData[kid][kadoTaken] = true;
    KadoData[kid][kadoObjID] = -1;
    KadoData[kid][kadoLabel] = Text3D:-1;
    Iter_Remove(Kados, kid);
    
    return 1;
}

//-------[ Commands ]----------

CMD:createkado(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
        
    new kid = Iter_Free(Kados), query[512];
    if(kid == -1) return Error(playerid, "Can't add any more christmas gifts.");
    
    new Float:x, Float:y, Float:z, Float:a;
    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);
    x += (1.5 * floatsin(-a, degrees));
    y += (1.5 * floatcos(-a, degrees));
    z -= 0.8;
    
    KadoData[kid][kadoX] = x;
    KadoData[kid][kadoY] = y;
    KadoData[kid][kadoZ] = z;
    KadoData[kid][kadoRX] = 0.0;
    KadoData[kid][kadoRY] = 0.0;
    KadoData[kid][kadoRZ] = float(random(360));
    
    new label[128];
    format(label, sizeof(label), "{00FF00}Christmas Gift (%d)\n{FFFFFF}/claimgift", kid);
    KadoData[kid][kadoLabel] = CreateDynamic3DTextLabel(label, COLOR_GREEN, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ] + 0.5, 5.0);
    KadoData[kid][kadoObjID] = CreateDynamicObject(19054, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ], KadoData[kid][kadoRX], KadoData[kid][kadoRY], KadoData[kid][kadoRZ]);
    
    KadoData[kid][kadoTaken] = false;
    
    Iter_Add(Kados, kid);
    
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO kados SET id='%d', posx='%f', posy='%f', posz='%f', posrx='%f', posry='%f', posrz='%f'", 
        kid, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ], KadoData[kid][kadoRX], KadoData[kid][kadoRY], KadoData[kid][kadoRZ]);
    mysql_tquery(g_SQL, query, "OnKadoCreated", "di", playerid, kid);
    return 1;
}

function OnKadoCreated(playerid, kid)
{
    Kado_Save(kid);
    
    pData[playerid][EditingKadoID] = kid;
    EditDynamicObject(playerid, KadoData[kid][kadoObjID]);
    Servers(playerid, "Christmas gift created (ID: %d).", kid);
    Servers(playerid, "You can edit it right now, or cancel editing and edit it later.");
    return 1;
}

CMD:editkado(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
        
    new kid;
    if(sscanf(params, "i", kid)) return Usage(playerid, "/editkado [kado id]");
    if(!Iter_Contains(Kados, kid)) return Error(playerid, "Invalid kado ID.");
    if(!IsPlayerInRangeOfPoint(playerid, 30.0, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ])) 
        return Error(playerid, "You're not near the gift you want to edit.");
    
    pData[playerid][EditingKado] = kid; // FIXED: Set EditingKado
    EditDynamicObject(playerid, KadoData[kid][kadoObjID]);
    Info(playerid, "Editing christmas gift ID %d", kid);
    return 1;
}

CMD:removekado(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
        
    new kid;
    if(sscanf(params, "i", kid)) return Usage(playerid, "/removekado [kado id]");
    if(!Iter_Contains(Kados, kid)) return Error(playerid, "Invalid kado ID.");
    
    Kado_Delete(kid);
    Servers(playerid, "Christmas gift removed.");
    return 1;
}

CMD:gotokado(playerid, params[])
{
    new kid;
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
        
    if(sscanf(params, "d", kid))
        return Usage(playerid, "/gotokado [id]");
        
    if(!Iter_Contains(Kados, kid)) return Error(playerid, "The gift you specified doesn't exist.");
    
    SetPlayerPosition(playerid, KadoData[kid][kadoX], KadoData[kid][kadoY], KadoData[kid][kadoZ], 2.0);
    pData[playerid][pInBiz] = -1;
    pData[playerid][pInHouse] = -1;
    pData[playerid][pInDoor] = -1;
    pData[playerid][pInFamily] = -1;    
    SetPlayerInterior(playerid, 0);
    SetPlayerVirtualWorld(playerid, 0);
    Servers(playerid, "You have teleported to gift id %d", kid);
    return 1;
}

CMD:kadolist(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
    
    new count, str[256];
    SendClientMessage(playerid, COLOR_YELLOW, "=== Daftar Kado Natal ===");
    
    foreach(new i : Kados)
    {
        new status[32];
        if(KadoData[i][kadoTaken])
            format(status, sizeof(status), "{FF0000}Taken");
        else
            format(status, sizeof(status), "{00FF00}Available");
            
        format(str, sizeof(str), "Kado #%d | %.1f, %.1f, %.1f | Status: %s", 
            i, KadoData[i][kadoX], KadoData[i][kadoY], KadoData[i][kadoZ], status);
        SendClientMessage(playerid, -1, str);
        count++;
    }
    
    format(str, sizeof(str), "{FFFF00}Total: %d kado natal", count);
    SendClientMessage(playerid, COLOR_YELLOW, str);
    return 1;
}

CMD:claimgift(playerid, params[])
{
    new kid = GetClosestKado(playerid, 2.0);
    
    if(kid == -1)
        return Error(playerid, "You're not near any christmas gift!");
    
    if(KadoData[kid][kadoTaken])
        return Error(playerid, "This gift has already been taken!");
    
    // Random hadiah
    new hadiah = random(4); // 0-3 (4 jenis hadiah)
    
    switch(hadiah)
    {
        case 0: // VIP
        {
            new viplevel = random(4); // 0-3
            new vipdays = 1 + random(15); // 1-15 hari
            
            pData[playerid][pVip] = viplevel;
            pData[playerid][pVipTime] = vipdays * 86400; // Convert ke detik
            
            Servers(playerid, "Selamat Anda mendapat VIP Level %d selama %d hari!", viplevel, vipdays);
        }
        case 1: // Money
        {
            new money = 1000 + random(100000); // $1,000 - $100,000
            
            GivePlayerMoneyEx(playerid, money);
            
            Servers(playerid, "Selamat Anda mendapat uang {FFFF00}$%s{FFFFFF}!", FormatMoney(money));
        }
        case 2: // Gold
        {
            new gold = 10 + random(41); // 10-50 gold
            
            pData[playerid][pGold] += gold;
            
            Servers(playerid, "Selamat Anda mendapat {FFFF00}%d Gold{FFFFFF}!", gold);
        }
        case 3: // Combo (Money + Gold)
        {
            new money = 5000 + random(50000);
            new gold = 50 + random(450);
            
            GivePlayerMoneyEx(playerid, money);
            pData[playerid][pGold] += gold;
            
            Servers(playerid, "Selamat Anda mendapat {FFFF00}$%s {FFFFFF}dan {FFFF00}%d Gold{FFFFFF}!", FormatMoney(money), gold);
        }
    }
    
    // Sound effect
    PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
    
    // Animation
    ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0);
    
    // Hapus kado secara permanen
    Kado_Delete(kid);
    
    return 1;
}

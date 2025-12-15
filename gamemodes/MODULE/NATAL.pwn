/*
    Sistem Kado Natal SA-MP - Versi Simple
    /createkado - Buat kado (admin)
    /ambilkado - Ambil kado terdekat
*/

#define MAX_KADO 100
#define KADO_MODEL 19054

// Warna
#define RED 0xFF0000AA
#define GREEN 0x00FF00AA
#define YELLOW 0xFFFF00AA

// Data kado
enum E_KADO {
    bool:aktif,
    Float:x, Float:y, Float:z,
    pickup,
    Text3D:label,
    vw, interior
}
new Kado[MAX_KADO][E_KADO];

// Command /createkado
CMD:createkado(playerid) {
    if(pData[playerid][pAdmin] < 5) 
        return SendClientMessage(playerid, RED, "Akses ditolak!");
    
    // Cari slot kosong
    new slot = -1;
    for(new i; i < MAX_KADO; i++) {
        if(!Kado[i][aktif]) { slot = i; break; }
    }
    if(slot == -1) 
        return SendClientMessage(playerid, RED, "Slot kado penuh!");
    
    // Ambil posisi player
    new Float:a;
    GetPlayerPos(playerid, Kado[slot][x], Kado[slot][y], Kado[slot][z]);
    GetPlayerFacingAngle(playerid, a);
    
    // Letakkan di depan player
    Kado[slot][x] += (1.5 * floatsin(-a, degrees));
    Kado[slot][y] += (1.5 * floatcos(-a, degrees));
    Kado[slot][vw] = GetPlayerVirtualWorld(playerid);
    Kado[slot][interior] = GetPlayerInterior(playerid);
    
    // Buat pickup & label
    Kado[slot][pickup] = CreateDynamicPickup(KADO_MODEL, 1, 
        Kado[slot][x], Kado[slot][y], Kado[slot][z], 
        Kado[slot][vw], Kado[slot][interior]);
    
    Kado[slot][label] = CreateDynamic3DTextLabel(
        "{00FF00}Kado Natal\n{FFFFFF}/ambilkado", 
        -1, Kado[slot][x], Kado[slot][y], Kado[slot][z] + 0.8, 
        10.0, .worldid = Kado[slot][vw], .interiorid = Kado[slot][interior]);
    
    Kado[slot][aktif] = true;
    
    new str[90], nama[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nama, MAX_PLAYER_NAME);
    format(str, 90, "Kado #%d dibuat!", slot);
    SendClientMessage(playerid, GREEN, str);
    
    format(str, 90, "** %s meletakkan kado natal!", nama);
    SendClientMessageToAll(YELLOW, str);
    return 1;
}

// Command /ambilkado
CMD:ambilkado(playerid) {
    new Float:px, Float:py, Float:pz, vw = GetPlayerVirtualWorld(playerid);
    GetPlayerPos(playerid, px, py, pz);
    
    // Cari kado terdekat
    for(new i; i < MAX_KADO; i++) {
        if(!Kado[i][aktif] || Kado[i][vw] != vw) continue;
        
        if(IsPlayerInRangeOfPoint(playerid, 1.5, Kado[i][x], Kado[i][y], Kado[i][z])) {
            // Berikan hadiah
            new hadiah = 5000 + random(45001);
            GivePlayerMoney(playerid, hadiah);
            
            // Kirim pesan
            new str[90], nama[MAX_PLAYER_NAME];
            GetPlayerName(playerid, nama, MAX_PLAYER_NAME);
            format(str, 90, "Anda dapat $%d! Selamat Natal!", hadiah);
            SendClientMessage(playerid, GREEN, str);
            
            format(str, 90, "** %s mengambil kado ($%d)", nama, hadiah);
            SendClientMessageToAll(YELLOW, str);
            
            // Hapus kado
            DestroyDynamicPickup(Kado[i][pickup]);
            DestroyDynamic3DTextLabel(Kado[i][label]);
            Kado[i][aktif] = false;
            
            PlayerPlaySound(playerid, 1057, 0.0, 0.0, 0.0);
            return 1;
        }
    }
    SendClientMessage(playerid, RED, "Tidak ada kado di dekat Anda!");
    return 1;
}

// Command /deletekado
CMD:deletekado(playerid) {
    if(pData[playerid][pAdmin] < 5) 
        return SendClientMessage(playerid, RED, "Akses ditolak!");
    
    new Float:px, Float:py, Float:pz;
    GetPlayerPos(playerid, px, py, pz);
    
    for(new i; i < MAX_KADO; i++) {
        if(!Kado[i][aktif]) continue;
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Kado[i][x], Kado[i][y], Kado[i][z])) {
            DestroyDynamicPickup(Kado[i][pickup]);
            DestroyDynamic3DTextLabel(Kado[i][label]);
            Kado[i][aktif] = false;
            return SendClientMessage(playerid, GREEN, "Kado dihapus!");
        }
    }
    SendClientMessage(playerid, RED, "Tidak ada kado terdekat!");
    return 1;
}

// Command /kadolist
CMD:kadolist(playerid) {
    if(pData[playerid][pAdmin] < 5) 
        return SendClientMessage(playerid, RED, "Akses ditolak!");
    
    new count, str[128];
    SendClientMessage(playerid, YELLOW, "=== Daftar Kado ===");
    
    for(new i; i < MAX_KADO; i++) {
        if(Kado[i][aktif]) {
            format(str, 128, "#%d | %.1f, %.1f, %.1f | VW:%d", 
                i, Kado[i][x], Kado[i][y], Kado[i][z], Kado[i][vw]);
            SendClientMessage(playerid, -1, str);
            count++;
        }
    }
    format(str, 128, "Total: %d kado", count);
    SendClientMessage(playerid, YELLOW, str);
    return 1;
}

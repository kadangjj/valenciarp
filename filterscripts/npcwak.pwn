// npcwak.pwn
#include <a_samp>  // Sertakan a_samp untuk fungsi SA-MP
#include <a_npc>   // Sertakan a_npc untuk mode NPC

// Define posisi dan arah NPC
#define NPC_X 1958.0
#define NPC_Y 1343.0
#define NPC_Z 15.0
#define NPC_ANGLE 90.0

// Forward declaration untuk OnPlayerSpawn
forward OnPlayerSpawn(playerid);

forward OnNPCModeInit();
public OnNPCModeInit() {
    // NPC akan tetap diam
}

public OnPlayerSpawn(playerid) {
    // Atur posisi dan arah NPC saat spawn
    SetPlayerPos(playerid, NPC_X, NPC_Y, NPC_Z);
    SetPlayerFacingAngle(playerid, NPC_ANGLE);
    return 1;
}


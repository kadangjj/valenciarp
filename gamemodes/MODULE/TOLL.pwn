#define BARRIER_SPEED 	0.030
#define TEAM_NONE       (0)
#define BARRIER_COUNT   10
#define Toll(%1,%2) SendClientMessage(%1, COLOR_YELLOW , "TOLL: "WHITE_E""%2)

new gBarrier[10];

enum brInfo
{
	brOrg,
    Float:brPos_X,
    Float:brPos_Y,
    Float:brPos_Z,
    Float:brPos_A,
    bool:brOpen,
    brForBarrierID 
};

new BarrierInfo[10][brInfo] =
{
    {TEAM_NONE,     57.626400,  	-1536.844482,   3.944200,   81.9535,    	false, -1},
	{TEAM_NONE, 	59.734100,  	-1521.458862,   3.944200,   81.9535,    	false, -1},
	{TEAM_NONE, 	1808.153442,	811.798828,     9.793500,   0.00,       	false, -1},
	{TEAM_NONE, 	1792.503540,	811.798828,     9.843500,   0.00,       	false, -1},
	{TEAM_NONE, 	428.671,    	615.601,        17.941,     34.000,     	false, -1},
	{TEAM_NONE, 	423.585,    	599.148,        17.941,     213.997,    	false, -1},
	{TEAM_NONE, 	-144.712,   	482.638,        11.078,     165.997,    	false, -1},
	{TEAM_NONE, 	-128.746,   	490.219,        10.383,     345.992,    	false, -1},
	{TEAM_NONE, 	-37.640369, 	-830.544311, 	10.925383,  -24.900001,    	false, -1},
	{TEAM_NONE, 	-52.961547, 	-831.017395, 	11.365384,  157.100051,    	false, -1}
};

function BarrierClose(barrier)
{
	BarrierInfo[barrier][brOpen] = false;
	MoveDynamicObject(gBarrier[barrier],BarrierInfo[barrier][brPos_X],BarrierInfo[barrier][brPos_Y],BarrierInfo[barrier][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[barrier][brPos_A]+180);
	new barrierid = BarrierInfo[barrier][brForBarrierID];
	if(barrierid != -1)
	{
		BarrierInfo[barrierid][brOpen] = false;
		MoveDynamicObject(gBarrier[barrierid],BarrierInfo[barrierid][brPos_X],BarrierInfo[barrierid][brPos_Y],BarrierInfo[barrierid][brPos_Z]+0.75,BARRIER_SPEED,0.0,90.0,BarrierInfo[barrierid][brPos_A]+180);
	}
	return true;
}

ShiftCords(style, &Float:x, &Float:y, Float:a, Float:distance)
{
	switch(style)
	{
	case 0:
		{
			x += (distance * floatsin(-a, degrees));
			y += (distance * floatcos(-a, degrees));
		}
	case 1:
		{
			x -= (distance * floatsin(-a, degrees));
			y -= (distance * floatcos(-a, degrees));
		}
	default: return false;
	}
	return true;
}

MuchNumber(...)
{
	new count = numargs(), maxnum;
	for(new i; i < count; i ++)
	{
		new temp = getarg(i);
		if(temp > maxnum) maxnum = temp;
	}
	return maxnum;
}

CMD:opengate(playerid, params[])
{
    if(GetPlayerState(playerid) == PLAYER_STATE_SPECTATING) return 0;

    for(new i = 0; i < BARRIER_COUNT; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 40.0, BarrierInfo[i][brPos_X], BarrierInfo[i][brPos_Y], BarrierInfo[i][brPos_Z])) // jarak dinaikkan
        {
            if(BarrierInfo[i][brOrg] != TEAM_NONE)
            {
                return Error(playerid, "Kamu tidak bisa membuka pintu Toll ini!");
            }
            if(BarrierInfo[i][brOpen])
            {
                return Error(playerid, "Pintu tol sudah terbuka.");
            }

            // cek apakah punya kartu eToll (unlimited pass)
            if(pData[playerid][pEToll] == 1) // Punya kartu eToll
            {
                //Toll(playerid, "Kamu telah melewati tol menggunakan kartu eToll.");
            }
            else if(pData[playerid][pMoney] >= 500) // Bayar cash
            {
                pData[playerid][pMoney] -= 500;
                //Toll(playerid, "Kamu telah membayar toll menggunakan uang tunai.");
            }
            else
            {
                return Error(playerid, "Kamu tidak memiliki kartu eToll atau uang tunai yang cukup!");
            }

            MoveDynamicObject(gBarrier[i], BarrierInfo[i][brPos_X], BarrierInfo[i][brPos_Y], BarrierInfo[i][brPos_Z] + 0.7, BARRIER_SPEED, 0.0, 0.0, BarrierInfo[i][brPos_A] + 180.0);
            SetTimerEx("BarrierClose", 9000, 0, "i", i);
            BarrierInfo[i][brOpen] = true;
            Toll(playerid, "Toll akan menutup kembali setelah 9 detik");

            if(BarrierInfo[i][brForBarrierID] != -1)
            {
                new bid = BarrierInfo[i][brForBarrierID];
                MoveDynamicObject(gBarrier[bid], BarrierInfo[bid][brPos_X], BarrierInfo[bid][brPos_Y], BarrierInfo[bid][brPos_Z] + 0.7, BARRIER_SPEED, 0.0, 0.0, BarrierInfo[bid][brPos_A] + 180.0);
                BarrierInfo[bid][brOpen] = true;
            }
            break;
        }
    }
    return 1;
}

#define MAX_VOUCHER 50

enum E_VOUCHER
{
	voucID,
	voucCode[32], // Ubah dari integer ke string
	voucVIP,
	voucVIPTime,
	voucMoney,
	voucGold,
	voucAdmin[16],
	voucDonature[16],
	voucClaim,
};
new VoucData[MAX_VOUCHER][E_VOUCHER],
	Iterator: Vouchers<MAX_VOUCHER>;
	
function LoadVouchers()
{
    new voucid, admin[16], donature[16], tempString[64];
	
	new rows = cache_num_rows();
 	if(rows)
  	{
		for(new i; i < rows; i++)
		{
			cache_get_value_name_int(i, "id", voucid);
			cache_get_value_name(i, "code", tempString, sizeof(tempString));
			format(VoucData[voucid][voucCode], 32, tempString);
			cache_get_value_name_int(i, "vip", VoucData[voucid][voucVIP]);
			cache_get_value_name_int(i, "vip_time", VoucData[voucid][voucVIPTime]);
			cache_get_value_name_int(i, "money", VoucData[voucid][voucMoney]);
			cache_get_value_name_int(i, "gold", VoucData[voucid][voucGold]);
			cache_get_value_name(i, "admin", admin, sizeof(admin));
			format(VoucData[voucid][voucAdmin], 16, admin);
			cache_get_value_name(i, "donature", donature, sizeof(donature));
			format(VoucData[voucid][voucDonature], 16, donature);
			cache_get_value_name_int(i, "claim", VoucData[voucid][voucClaim]);
			Iter_Add(Vouchers, voucid);
		}
		printf("[Vouchers]: %d Loaded.", rows);
	}
}

Voucher_Save(voucid)
{
	new cQuery[512];
	format(cQuery, sizeof(cQuery), "UPDATE vouchers SET code='%s', vip='%d', vip_time='%d', money='%d', gold='%d', admin='%s', donature='%s', claim='%d' WHERE id='%d'",
	VoucData[voucid][voucCode],
	VoucData[voucid][voucVIP],
	VoucData[voucid][voucVIPTime],
	VoucData[voucid][voucMoney],
	VoucData[voucid][voucGold],
	VoucData[voucid][voucAdmin],
	VoucData[voucid][voucDonature],
	VoucData[voucid][voucClaim],
	voucid
	);
	return mysql_tquery(g_SQL, cQuery);
}

CMD:createvoucher(playerid, params[])
{
    if(pData[playerid][pAdmin] < 5)
        return PermissionError(playerid);
    
    new code[32], vip, viptime, gold, money;
    if(sscanf(params, "s[32]dddd", code, vip, viptime, money, gold)) 
        return Usage(playerid, "/createvoucher [CODE] [VIP] [VIP-TIME(Days)] [MONEY(x100)] [GOLD]");
    
    // Validasi panjang code
    if(strlen(code) < 5 || strlen(code) > 20) 
        return Error(playerid, "Panjang code invalid (5-20 karakter)");
    
    // Validasi karakter code (opsional - hanya alphanumeric)
    for(new i = 0; i < strlen(code); i++) {
        if(!((code[i] >= '0' && code[i] <= '9') || (code[i] >= 'A' && code[i] <= 'Z') || (code[i] >= 'a' && code[i] <= 'z'))) {
            return Error(playerid, "Code hanya boleh huruf dan angka!");
        }
    }
    
    if(vip < 0 || vip > 3) 
        return Error(playerid, "Invalid vip level (0-3)");
    if(viptime < 0 || viptime > 60) 
        return Error(playerid, "Invalid vip time (0-60 days)");
    if(money < 0 || money > 100000) 
        return Error(playerid, "Invalid money (0-100000)");
    if(gold < 0 || gold > 1000) 
        return Error(playerid, "Invalid gold (0-1000)");
    
    // Cek apakah code sudah ada
    foreach(new vo : Vouchers)
    {
        if(!strcmp(VoucData[vo][voucCode], code, true))
        {
            return Error(playerid, "Code voucher sudah terdaftar! gunakan code lain!");
        }
    }
    
    new voucid = Iter_Free(Vouchers);
    if(voucid == -1) return Error(playerid, "Tidak bisa membuat voucher lagi! (limit tercapai)");
    
    // Kalikan money dengan 100
    new final_money = money * 100;
    
    // Set data voucher
    format(VoucData[voucid][voucCode], 32, "%s", code);
    VoucData[voucid][voucVIP] = vip;
    VoucData[voucid][voucVIPTime] = viptime;
    VoucData[voucid][voucMoney] = final_money;
    VoucData[voucid][voucGold] = gold;
    format(VoucData[voucid][voucAdmin], 32, "%s", pData[playerid][pAdminname]);
    format(VoucData[voucid][voucDonature], 32, "None");
    VoucData[voucid][voucClaim] = 0;
    
    // Insert ke database dengan %e untuk escape string
    new query[256];
    mysql_format(g_SQL, query, sizeof(query), 
        "INSERT INTO vouchers (id, code, vip, vip_time, money, gold, admin, donature, claim) VALUES (%d, '%e', %d, %d, %d, %d, '%e', 'None', 0)", 
        voucid, code, vip, viptime, final_money, gold, pData[playerid][pAdminname]);
    mysql_tquery(g_SQL, query, "OnVoucherCreated", "i", voucid);
    
    Servers(playerid, "Voucher dibuat ID:%d | Code:%s | VIP:%d | VIPTime:%d | Money:%s | Gold:%d | Admin:%s", voucid, code, vip, viptime, FormatMoney(final_money), gold, pData[playerid][pAdminname]);
    return 1;
}

function OnVoucherCreated(voucid)
{
	Voucher_Save(voucid);
	return 1;
}
/*
CMD:voucher(playerid, params[])
{
	new code;
	if(sscanf(params, "d", code)) return Usage(playerid, "/voucher [CODE]");
	
	foreach(new vo : Vouchers)
	{
		if(VoucData[vo][voucCode] == code)
		{
			if(VoucData[vo][voucClaim] == 0)
			{
				if(VoucData[vo][voucVIP] == 0)
				{
					pData[playerid][pGold] += VoucData[vo][voucGold];
					
					VoucData[vo][voucClaim] = 1;
					format(VoucData[vo][voucDonature], 16, pData[playerid][pName]);
					Voucher_Save(vo);
					
					Info(playerid, "Voucher claimed. gold: %d | claimby: %s.", VoucData[vo][voucGold], pData[playerid][pName]);
				}
				else
				{
					new dayz = VoucData[vo][voucVIPTime];
					pData[playerid][pGold] += VoucData[vo][voucGold];
					pData[playerid][pMoney] += VoucData[vo][voucMoney];
					pData[playerid][pVip] = VoucData[vo][voucVIP];
					pData[playerid][pVipTime] = gettime() + (dayz * 86400);
					
					VoucData[vo][voucClaim] = 1;
					format(VoucData[vo][voucDonature], 16, pData[playerid][pName]);
					Voucher_Save(vo);
					
					Info(playerid, "Voucher claimed. VIP: %d | VIP TIME: %d days | money: %s | gold: %d | claimby: %s.", VoucData[vo][voucVIP], dayz, FormatMoney(VoucData[vo][voucMoney]), VoucData[vo][voucGold], pData[playerid][pName]);
				}
			}
			else return Error(playerid, "Voucher has been expired!");
		}
	}
	return 1;
}*/
CMD:voucher(playerid, params[])
{
    ShowPlayerDialog(playerid, DIALOG_VOUCHER, DIALOG_STYLE_INPUT, "Voucher Redemption", "Enter your voucher code:", "Redeem", "Cancel");
    return 1;
}




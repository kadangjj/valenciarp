#define LOCATION_UNKNOWN -1
#define LOCATION_LS 0
#define LOCATION_LV 1
#define LOCATION_SF 2

forward DCC_DM(str[]);
public DCC_DM(str[])
{
    new DCC_Channel:PM;
	PM = DCC_GetCreatedPrivateChannel();
	DCC_SendChannelMessage(PM, str);
	return 1;
}

forward DCC_DM_EMBED(str[], pin, id[]);
public DCC_DM_EMBED(str[], pin, id[])
{
    new DCC_Channel:PM, query[200];
	PM = DCC_GetCreatedPrivateChannel();

	new DCC_Embed:embed = DCC_CreateEmbed(.title="Valencia Roleplay", .image_url="https://media.discordapp.net/attachments/1028591969930313800/1280442489525764096/Valencia.jpg?ex=66d8187e&is=66d6c6fe&hm=7ee85520073ee0e7fe86fae2a8398b29f5483238615e97b751c1b710e967578d&=&format=webp");
	new str1[256], str2[256];

	format(str1, sizeof str1, "\nSelamat!\nAkun UCP kamu telah berhasil diverifikasi, Gunakan PIN dibawah ini untuk login ke Game\n Jika ada kendala atau pertanyaan, segera hubungi Administrator. Kami siap membantu kapan saja!");
	DCC_SetEmbedDescription(embed, str1);
	format(str1, sizeof str1, "UCP");
	format(str2, sizeof str2, "\n```%s```", str);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "PIN");
	format(str2, sizeof str2, "\n```%d```", pin);
	DCC_AddEmbedField(embed, str1, str2, bool:1);
	format(str1, sizeof str1, "NOTE");
	format(str2, sizeof str2, "\n```Jangan berikan informasi ini kepada siapa pun termasuk Valencia Team Administrator```");
	DCC_AddEmbedField(embed, str1, str2, bool:1);

	DCC_SendChannelEmbedMessage(PM, embed);

	mysql_format(g_SQL, query, sizeof query, "INSERT INTO `playerucp` (`ucp`, `verifycode`, `DiscordID`) VALUES ('%e', '%d', '%e')", str, pin, id);
	mysql_tquery(g_SQL, query);
	return 1;
}

forward CheckDiscordUCP(DiscordID[], Nama_UCP[]);
public CheckDiscordUCP(DiscordID[], Nama_UCP[])
{
	new DCC_Role: WARGA, DCC_Guild: guild, DCC_User: user, dc[100];
	new verifycode = RandomEx(111111, 988888);
	new rows = cache_num_rows();
	if(rows > 0)
	{
		return SendDiscordMessage(7, "**INFO:** Nama UCP account tersebut sudah terdaftar");
	}
	else 
	{
		guild = DCC_FindGuildById("1028591968684617779");
		WARGA = DCC_FindRoleById("1028591968684617781");
		user = DCC_FindUserById(DiscordID);
		DCC_SetGuildMemberNickname(guild, user, Nama_UCP);
		DCC_AddGuildMemberRole(guild, user, WARGA);

		format(dc, sizeof(dc),  "**UCP: __%s__** is now Verified.", Nama_UCP);
		SendDiscordMessage(7, dc);
		DCC_CreatePrivateChannel(user, "DCC_DM_EMBED", "sds", Nama_UCP, verifycode, DiscordID);
	}
	return 1;
}

forward CheckDiscordID(DiscordID[], Nama_UCP[]);
public CheckDiscordID(DiscordID[], Nama_UCP[])
{
	new rows = cache_num_rows(), ucp[20], dc[100];
	if(rows > 0)
	{
		cache_get_value_name(0, "ucp", ucp);

		format(dc, sizeof(dc),  "**INFO:** You have already registered a UCP with the name **%s**", ucp);
		return SendDiscordMessage(7, dc);
	}
	else 
	{
		new characterQuery[178];
		mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `ucp` = '%s'", Nama_UCP);
		mysql_tquery(g_SQL, characterQuery, "CheckDiscordUCP", "ss", DiscordID, Nama_UCP);
	}
	return 1;
}

forward OnBanQueryResult(NameToBan[], banReason[], banTime, discordId);
public OnBanQueryResult(NameToBan[], banReason[], banTime, discordId)
{
    if (!cache_num_rows())
    {
        DCC_SendChannelMessage(DCC_FindChannelById("1280254425918869727"), "Account '%s' does not exist.", NameToBan);
        return;
    }

    new PlayerIP[16];
    cache_get_value_index(0, 1, PlayerIP);

    new datez = (banTime != 0) ? gettime() + (banTime * 86400) : 0;
    new query[256];
    mysql_format(g_SQL, query, sizeof(query), "INSERT INTO banneds(name, ip, admin, reason, ban_date, ban_expire) VALUES ('%s', '%s', '%s', '%s', UNIX_TIMESTAMP(), %d)", NameToBan, PlayerIP, discordId, banReason, datez);
    mysql_tquery(g_SQL, query);

    new dc[512];
    if (banTime != 0)
        format(dc, sizeof(dc), "```\nServer: Admin %s has temp-banned UCP %s for %d days. [Reason: %s]```", discordId, NameToBan, banTime, banReason);
    else
        format(dc, sizeof(dc), "```\nServer: Admin %s has permanently banned UCP %s. [Reason: %s]```", discordId, NameToBan, banReason);
    SendDiscordMessage(3, dc);
}

DCMD:register(user, channel, params[])
{
	new id[21];
    if(channel != DCC_FindChannelById("1330494882950676579"))
		return 1;
    if(isnull(params)) 
		return DCC_SendChannelMessage(channel, "**USAGE:** __!register__ (UCP NAME)");
	if(!IsValidNameUCP(params))
		return DCC_SendChannelMessage(channel, "**Gunakan nama UCP bukan nama IC!**");
	
	DCC_GetUserId(user, id, sizeof id);

	new characterQuery[512];
	mysql_format(g_SQL, characterQuery, sizeof(characterQuery), "SELECT * FROM `playerucp` WHERE `DiscordID` = '%s'", id);
	mysql_tquery(g_SQL, characterQuery, "CheckDiscordID", "ss", id, params);
	return 1;
}

/*DCMD:activecs(user, channel, params[])
{
   // new id[21];
    if (channel != DCC_FindChannelById("1330494882778845304"))
        return 1;

    if(isnull(params)) return DCC_SendChannelMessage(channel, "**!activecs [name_character]**");

	new query[528], bebas[400];
    mysql_format(g_SQL, query, sizeof(query), "SELECT username FROM players WHERE username='%e'", params);
	mysql_query(g_SQL, query);

    if(cache_num_rows() == 0) return DCC_SendChannelMessage(channel, "**CS: :x: Nama Character tidak ada!**");
    
	new rand = 1;
	new cQuery[521];
	mysql_format(g_SQL, cQuery, sizeof(cQuery), "UPDATE `players` SET `characterstory` = '%d' WHERE `username` = '%e'", rand, params);
	mysql_tquery(g_SQL, cQuery);

	format(bebas ,sizeof(bebas),"**:exclamation: Character Story %s is active**", params);
	DCC_SendChannelMessage(channel, bebas);
	return 1;
}*/

DCMD:dobanucp(user, channel, params[])
{
    if(channel != DCC_FindChannelById("1444800090827915375"))
        return 1;

    if(isnull(params))
        return DCC_SendChannelMessage(channel, "**USAGE:** __!dobanucp__ <UCPName> <time (in days) 0 for permanent> <reason>");

    new NameToBan[60], banReason[128], banTime;

    if(sscanf(params, "s[60]ds[128]", NameToBan, banTime, banReason))
        return DCC_SendChannelMessage(channel, "**USAGE:** __!dobanucp__ <UCPName> <time (in days) 0 for permanent> <reason>");

    // Validasi ban time
    if(banTime < 0 || banTime > 365)
        return DCC_SendChannelMessage(channel, "**ERROR:** Ban time must be between 0 (permanent) and 365 days.");

    // Validasi reason
    if(strlen(banReason) < 3)
        return DCC_SendChannelMessage(channel, "**ERROR:** Ban reason must be at least 3 characters.");

    // Get Discord user ID
    new discordID[21];
    DCC_GetUserId(user, discordID, sizeof(discordID));

    // Query untuk cek apakah UCP exist
    new query[512];
    mysql_format(g_SQL, query, sizeof(query), 
        "SELECT reg_id, username FROM playerucp WHERE ucp = '%e' LIMIT 1", 
        NameToBan
    );
    
    // Pass data langsung tanpa parsing kompleks
    mysql_tquery(g_SQL, query, "OnDiscordBanUCPQuery", "sisds", 
        _:channel, 
        NameToBan, 
        banTime, 
        banReason, 
        discordID
    );
    
    return 1;
}

forward OnDiscordBanUCPQuery(DCC_Channel:channel, const NameToBan[], banTime, const banReason[], const discordID[]);
public OnDiscordBanUCPQuery(DCC_Channel:channel, const NameToBan[], banTime, const banReason[], const discordID[])
{
    new cache = cache_num_rows();
    
    if(!cache)
    {
        new response[128];
        format(response, sizeof(response), "**ERROR:** UCP account `%s` not found.", NameToBan);
        return DCC_SendChannelMessage(channel, response);
    }
    
    // Get player data dari cache
    new playerID, playerUsername[MAX_PLAYER_NAME];
    cache_get_value_name_int(0, "reg_id", playerID);
    cache_get_value_name(0, "username", playerUsername, MAX_PLAYER_NAME);
    
    // Hitung ban expire time
    new banExpire;
    if(banTime == 0)
    {
        banExpire = 0; // Permanent ban
    }
    else
    {
        banExpire = gettime() + (banTime * 86400); // banTime days
    }
    
    // Insert ban ke database
    new query[512];
    mysql_format(g_SQL, query, sizeof(query), 
        "INSERT INTO bans (ucp, username, reason, banned_by, ban_time, expire_time, ban_type) VALUES ('%e', '%e', '%e', 'Discord:%e', %d, %d, 1)",
        NameToBan, playerUsername, banReason, discordID, gettime(), banExpire
    );
    mysql_tquery(g_SQL, query);
    
    // Kick player kalau online
    foreach(new i : Player)
    {
        if(!strcmp(pData[i][pUCP], NameToBan, true))
        {
            new kickMsg[128];
            if(banTime == 0)
            {
                format(kickMsg, sizeof(kickMsg), "You have been permanently banned from the server. Reason: %s", banReason);
            }
            else
            {
                format(kickMsg, sizeof(kickMsg), "You have been banned for %d days. Reason: %s", banTime, banReason);
            }
            
            SendClientMessage(i, COLOR_RED, kickMsg);
            SetTimerEx("KickPlayer", 500, false, "d", i);
            break;
        }
    }
    
    // Send success message ke Discord
    new response[256];
    if(banTime == 0)
    {
        format(response, sizeof(response), 
            "✅ **PERMANENT BAN**\n**UCP:** `%s`\n**Username:** `%s`\n**Reason:** %s\n**By:** <@%s>", 
            NameToBan, playerUsername, banReason, discordID
        );
    }
    else
    {
        format(response, sizeof(response), 
            "✅ **BANNED**\n**UCP:** `%s`\n**Username:** `%s`\n**Duration:** %d days\n**Reason:** %s\n**By:** <@%s>", 
            NameToBan, playerUsername, banTime, banReason, discordID
        );
    }
    
    DCC_SendChannelMessage(channel, response);
    
    // Log ban
    printf("[Discord Ban] %s banned UCP %s (%s) for %d days. Reason: %s", 
        discordID, NameToBan, playerUsername, banTime, banReason
    );
    
    return 1;
}
DCMD:price(user, channel, params[])
{
    // Only active in a specific channel
    if(channel != DCC_FindChannelById("1444800090827915375"))
        return 1;

    new string[2048];
    
    format(string, sizeof(string), 
        "**=== SERVER PRICE LIST ===**\n\n\
        **Materials & Components:**\n\
        • Material: %s\n\
        • Lumber: %s\n\
        • Component: %s\n\
        • Metal: %s\n\n\
        **Energy & Resources:**\n\
        • Gas Oil: %s\n\
        • Coal: %s\n\
        • Gas Station: %s\n\n\
        **Medical & Health:**\n\
        • Medicine: %s\n\
        • Medkit: %s\n\
        • Obat: %s\n\n\
        **Food & Agriculture:**\n\
        • Food: %s\n\
        • Seed: %s\n\
        • Potato: %s\n\
        • Wheat: %s\n\
        • Orange: %s\n\n\
        **Other Products:**\n\
        • Product: %s\n\
        • Fish: %s\n\
        • Marijuana: %s\n\n\
        **Server Money:** %s",
        FormatMoney(MaterialPrice),
        FormatMoney(LumberPrice),
        FormatMoney(ComponentPrice),
        FormatMoney(MetalPrice),
        FormatMoney(GasOilPrice),
        FormatMoney(CoalPrice),
        FormatMoney(GStationPrice),
        FormatMoney(MedicinePrice),
        FormatMoney(MedkitPrice),
        FormatMoney(ObatPrice),
        FormatMoney(FoodPrice),
        FormatMoney(SeedPrice),
        FormatMoney(PotatoPrice),
        FormatMoney(WheatPrice),
        FormatMoney(OrangePrice),
        FormatMoney(ProductPrice),
        FormatMoney(FishPrice),
        FormatMoney(MarijuanaPrice),
        FormatMoney(ServerMoney)
    );
    
    DCC_SendChannelMessage(channel, string);
    return 1;
}
DCMD:setprice(user, channel, params[]) 
{
	// Only active in a specific channel
	if(channel != DCC_FindChannelById("1444800090827915375"))
		return 1;

	if(isnull(params))
	{
		DCC_SendChannelMessage(channel, "**USAGE:** __!setprice__ <name> <price>");
		DCC_SendChannelMessage(channel, "**NAMES:** materialprice, lumberprice, componentprice, metalprice, gasoilprice, coalprice, productprice");
		DCC_SendChannelMessage(channel, "**NAMES:** foodprice, fishprice, gsprice, obatprice, potatoprice, orangeprice, wheatprice");
		return 1;
	}

	new name[64], priceStr[32];
	if(sscanf(params, "s[64]s[32]", name, priceStr))
	{
		DCC_SendChannelMessage(channel, "**USAGE:** __!setprice__ <name> <price>");
		return 1;
	}

	// Parse harga dari string (mendukung desimal)
	new Float:priceFloat = floatstr(priceStr);
	
	if(priceFloat < 0.0 || priceFloat > 5000.0)
	{
		DCC_SendChannelMessage(channel, "❌ **ERROR:** Price must be between 0.00 and 5,000.00");
		return 1;
	}

	// Konversi ke format internal (dikali 100)
	new price = floatround(priceFloat * 100.0);
	new message[256], itemName[64];

	if(!strcmp(name, "materialprice", true))
	{
		MaterialPrice = price;
		itemName = "Material";
	}
	else if(!strcmp(name, "lumberprice", true))
	{
		LumberPrice = price;
		itemName = "Lumber";
	}
	else if(!strcmp(name, "componentprice", true))
	{
		ComponentPrice = price;
		itemName = "Component";
	}
	else if(!strcmp(name, "metalprice", true))
	{
		MetalPrice = price;
		itemName = "Metal";
	}
	else if(!strcmp(name, "gasoilprice", true))
	{
		GasOilPrice = price;
		itemName = "Gas Oil";
	}
	else if(!strcmp(name, "coalprice", true))
	{
		CoalPrice = price;
		itemName = "Coal";
	}
	else if(!strcmp(name, "productprice", true))
	{
		ProductPrice = price;
		itemName = "Product";
	}
	else if(!strcmp(name, "foodprice", true))
	{
		FoodPrice = price;
		itemName = "Food";
	}
	else if(!strcmp(name, "fishprice", true))
	{
		FishPrice = price;
		itemName = "Fish";
	}
	else if(!strcmp(name, "gsprice", true))
	{
		GStationPrice = price;
		foreach(new gsid : GStation)
		{
			if(Iter_Contains(GStation, gsid))
			{
				GStation_Save(gsid);
				GStation_Refresh(gsid);
			}
		}
		itemName = "Gas Station";
	}
	else if(!strcmp(name, "obatprice", true))
	{
		ObatPrice = price;
		itemName = "Obat";
	}
	else if(!strcmp(name, "potatoprice", true))
	{
		PotatoPrice = price;
		itemName = "Potato";
	}
	else if(!strcmp(name, "orangeprice", true))
	{
		OrangePrice = price;
		itemName = "Orange";
	}
	else if(!strcmp(name, "wheatprice", true))
	{
		WheatPrice = price;
		itemName = "Wheat";
	}
	else if(!strcmp(name, "rawcomponent", true))
	{
		RawComponent = price;
		itemName = "Raw Component";
	}
	else
	{
		DCC_SendChannelMessage(channel, "❌ **ERROR:** Invalid item name!");
		return 1;
	}

	Server_Save();

	// Send message to all admins in-game
	SendAdminMessage(COLOR_RED, "[Discord Admin] Set %s price to %s", itemName, FormatMoney(price));

	// Log to server
	new logStr[150];
	format(logStr, sizeof(logStr), "[Discord]: Set %s price to %s", itemName, FormatMoney(price));
	LogServer("Discord", logStr);

	// Response to Discord
	format(message, sizeof(message), "✅ **%s** price has been set to **%s**", itemName, FormatMoney(price));
	return DCC_SendChannelMessage(channel, message);
}

DCMD:setstock(user, channel, params[]) 
{
	// Only active in a specific channel
	if(channel != DCC_FindChannelById("1444800090827915375"))
		return 1;

	if(isnull(params))
	{
		DCC_SendChannelMessage(channel, "**USAGE:** __!setstock__ <name> <amount>");
		DCC_SendChannelMessage(channel, "**NAMES:** material, component, product, gasoil, apotek, food, obat, rawcomponent, rawfish");
		return 1;
	}

	new name[64], stok;
	if(sscanf(params, "s[64]d", name, stok))
	{
		DCC_SendChannelMessage(channel, "**USAGE:** __!setstock__ <name> <amount>");
		return 1;
	}

	if(stok < 0 || stok > 5000)
	{
		DCC_SendChannelMessage(channel, "❌ **ERROR:** Stock must be between 0 and 5000");
		return 1;
	}

	new message[256], itemName[64];

	if(!strcmp(name, "material", true))
	{
		Material = stok;
		itemName = "Material";
	}
	else if(!strcmp(name, "component", true))
	{
		Component = stok;
		itemName = "Component";
	}
	else if(!strcmp(name, "product", true))
	{
		Product = stok;
		itemName = "Product";
	}
	else if(!strcmp(name, "gasoil", true))
	{
		GasOil = stok;
		itemName = "Gas Oil";
	}
	else if(!strcmp(name, "apotek", true))
	{
		Apotek = stok;
		itemName = "Apotek";
	}
	else if(!strcmp(name, "food", true))
	{
		Food = stok;
		itemName = "Food";
	}
	else if(!strcmp(name, "obat", true))
	{
		ObatMyr = stok;
		itemName = "Obat";
	}
	else if(!strcmp(name, "rawcomponent", true))
	{
		RawComponent = stok;
		itemName = "Raw Component";
	}
	else if(!strcmp(name, "rawfish", true))
	{
		RawFish = stok;
		itemName = "Raw Fish";
	}
	else
	{
		DCC_SendChannelMessage(channel, "❌ **ERROR:** Invalid item name!");
		return 1;
	}

	Server_Save();

	// Send message to all admins in-game
	SendAdminMessage(COLOR_RED, "[Discord Admin] Set %s stock to %d", itemName, stok);

	// Log to server
	new logStr[150];
	format(logStr, sizeof(logStr), "[Discord]: Set %s stock to %d", itemName, stok);
	LogServer("Discord", logStr);

	// Response to Discord
	format(message, sizeof(message), "✅ **%s** stock has been set to **%d**", itemName, stok);
	return DCC_SendChannelMessage(channel, message);
}
DCMD:slap(user, channel, params[]) 
{
	// Only active in a specific channel
	if(channel != DCC_FindChannelById("1444800090827915375"))
		return 1;

	if(isnull(params))
		return DCC_SendChannelMessage(channel, "**USAGE:** __!slap__ <player>");

	new PlayerName[MAX_PLAYER_NAME];

	// Parse parameters
	if(sscanf(params, "s[24]", PlayerName))
	{
		return DCC_SendChannelMessage(channel, "**USAGE:** __!slap__ <player>");
	}

	// Get player ID from name
	new targetPlayerID = GetPlayerIdByName(PlayerName);
	if(targetPlayerID == INVALID_PLAYER_ID)
	{
		new response[128];
		format(response, sizeof(response), "**ERROR:** Player `%s` not found or offline.", PlayerName);
		return DCC_SendChannelMessage(channel, response);
	}

	// Get current position and slap player up
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetPlayerID, x, y, z);
	SetPlayerPos(targetPlayerID, x, y, z + 5.0); // Slap 5 units up

	// Apply damage (optional)
	new Float:health;
	GetPlayerHealth(targetPlayerID, health);
	if(health > 10.0)
		SetPlayerHealth(targetPlayerID, health - 10.0);

	// Send sound effect
	PlayerPlaySound(targetPlayerID, 1130, 0.0, 0.0, 0.0);

	// Message to player
	Servers(targetPlayerID, "You have been slapped by Discord Admin!");

	// Log to server
	new logStr[150];
	format(logStr, sizeof(logStr), "[Discord]: %s slapped", PlayerName);
	LogServer("Discord", logStr);

	// Response to Discord
	new message[128];
	format(message, sizeof(message), "✅ Player **%s** has been slapped!", PlayerName);
	return DCC_SendChannelMessage(channel, message);
}

DCMD:sendto(user, channel, params[]) 
{
    // Only active in a specific channel
    if(channel != DCC_FindChannelById("1444800090827915375"))
        return 1;

    if(isnull(params))
        return DCC_SendChannelMessage(channel, "**USAGE:** __!sendto__ <player> <location>");

    new PlayerName[MAX_PLAYER_NAME], LocationName[24];

    // Parse parameters (FIXED)
    if(sscanf(params, "s[24]s[24]", PlayerName, LocationName)) // ← FIXED!
    {
        return DCC_SendChannelMessage(channel, "**USAGE:** __!sendto__ <player> <location>");
    }

    // Get player ID from name
    new targetPlayerID = GetPlayerIdByName(PlayerName);
    if(targetPlayerID == INVALID_PLAYER_ID)
    {
        new response[128];
        format(response, sizeof(response), "**ERROR:** Player `%s` not found or offline.", PlayerName);
        return DCC_SendChannelMessage(channel, response);
    }

    // Choose location and teleport player
    new locationID = GetLocationID(LocationName);
    if(locationID == LOCATION_UNKNOWN)
    {
        new response[128];
        format(response, sizeof(response), "**ERROR:** Unknown location `%s`. Available: ls, lv, sf", LocationName);
        return DCC_SendChannelMessage(channel, response);
    }

    TeleportPlayer(targetPlayerID, locationID);
    
    new message[128];
    format(message, sizeof(message), "✅ Player **%s** teleported to **%s**.", PlayerName, LocationName);
    return DCC_SendChannelMessage(channel, message);
}

// ============================================
// DCMD DISCORD COMMANDS (For Online Players)
// ============================================

DCMD:setcs(user, channel, params[])
{
	// Only active in a specific channel
	if(channel != DCC_FindChannelById("1444800090827915375"))
		return 1;

	if(isnull(params))
		return DCC_SendChannelMessage(channel, "**USAGE:** __!setcs__ <player>");

	new PlayerName[MAX_PLAYER_NAME];

	// Parse parameters
	if(sscanf(params, "s[24]", PlayerName))
	{
		return DCC_SendChannelMessage(channel, "**USAGE:** __!setcs__ <player>");
	}

	// Get player ID from name
	new targetPlayerID = GetPlayerIdByName(PlayerName);
	if(targetPlayerID == INVALID_PLAYER_ID)
	{
		new response[128];
		format(response, sizeof(response), "**ERROR:** Player `%s` not found or offline. Use slash command `/setcs` for offline players.", PlayerName);
		return DCC_SendChannelMessage(channel, response);
	}

	// Check if player already has CS
	if(pData[targetPlayerID][pPlayerCS] != 0)
	{
		new response[128];
		format(response, sizeof(response), "**ERROR:** Player `%s` sudah memiliki Character Story!", PlayerName);
		return DCC_SendChannelMessage(channel, response);
	}

	// Set Character Story
	pData[targetPlayerID][pPlayerCS] = 1;

	// Update database
	new query[256];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET characterstory = 1 WHERE reg_id = %i", pData[targetPlayerID][pID]);
	mysql_tquery(g_SQL, query);

	// Get Discord username who executed command
	new DCC_User:author;
	DCC_GetMessageAuthor(DCC_Message:0, author);
	new discordName[32];
	//DCC_GetUserName(author, discordName, sizeof(discordName));

	// Message to player in-game
	Info(targetPlayerID, "Discord Admin telah memberikan Character Story kepada kamu!");
	//SendClientMessage(targetPlayerID, COLOR_GREEN, "Kamu sekarang bisa menggunakan senjata!");

	// Log to server
	new logStr[150];
	format(logStr, sizeof(logStr), "[Discord]: %s set CS for %s (ONLINE)", discordName, PlayerName);
	LogServer("Discord", logStr);

	// Response to Discord
	new message[150];
	format(message, sizeof(message), "✅ Character Story berhasil diberikan kepada **%s** (ONLINE)!", PlayerName);
	return DCC_SendChannelMessage(channel, message);
}

DCMD:unsetcs(user, channel, params[])
{
	// Only active in a specific channel
	if(channel != DCC_FindChannelById("1444800090827915375"))
		return 1;

	if(isnull(params))
		return DCC_SendChannelMessage(channel, "**USAGE:** __!unsetcs__ <player>");

	new PlayerName[MAX_PLAYER_NAME];

	// Parse parameters
	if(sscanf(params, "s[24]", PlayerName))
	{
		return DCC_SendChannelMessage(channel, "**USAGE:** __!unsetcs__ <player>");
	}

	// Get player ID from name
	new targetPlayerID = GetPlayerIdByName(PlayerName);
	if(targetPlayerID == INVALID_PLAYER_ID)
	{
		new response[128];
		format(response, sizeof(response), "**ERROR:** Player `%s` not found or offline. Use slash command `/unsetcs` for offline players.", PlayerName);
		return DCC_SendChannelMessage(channel, response);
	}

	// Check if player has CS
	if(pData[targetPlayerID][pPlayerCS] != 1)
	{
		new response[128];
		format(response, sizeof(response), "**ERROR:** Player `%s` tidak memiliki Character Story!", PlayerName);
		return DCC_SendChannelMessage(channel, response);
	}

	// Remove Character Story
	pData[targetPlayerID][pPlayerCS] = 0;

	// Remove all weapons
	ResetPlayerWeapons(targetPlayerID);

	// Update database
	new query[256];
	mysql_format(g_SQL, query, sizeof(query), "UPDATE players SET characterstory = 0 WHERE reg_id = %i", pData[targetPlayerID][pID]);
	mysql_tquery(g_SQL, query);

	// Get Discord username who executed command
	new DCC_User:author;
	DCC_GetMessageAuthor(DCC_Message:0, author);
	new discordName[32];
	//DCC_GetUserName(author, discordName, sizeof(discordName));

	// Message to player in-game
	Info(targetPlayerID, "Discord Admin telah menghapus Character Story kamu!");
	//SendClientMessage(targetPlayerID, COLOR_RED, "Semua senjatamu telah dihapus!");

	// Log to server
	new logStr[150];
	format(logStr, sizeof(logStr), "[Discord]: %s unset CS for %s (ONLINE)", discordName, PlayerName);
	LogServer("Discord", logStr);

	// Response to Discord
	new message[150];
	format(message, sizeof(message), "✅ Character Story berhasil dihapus dari **%s** (ONLINE)!", PlayerName);
	return DCC_SendChannelMessage(channel, message);
}

// ═══════════════════════════════════════════════════════
// HELPER FUNCTIONS
// ═══════════════════════════════════════════════════════
stock GetPlayerIdByName(const playerName[]) 
{
    foreach(new playerid : Player) 
    {
        new name[MAX_PLAYER_NAME];
        GetPlayerName(playerid, name, sizeof(name));
        if(!strcmp(name, playerName, true))
            return playerid;
    }
    return INVALID_PLAYER_ID;
}

stock GetLocationID(const locationName[]) 
{
    if(!strcmp(locationName, "ls", true)) return LOCATION_LS;
    if(!strcmp(locationName, "lv", true)) return LOCATION_LV;
    if(!strcmp(locationName, "sf", true)) return LOCATION_SF;
    
    return LOCATION_UNKNOWN;
}

stock TeleportPlayer(playerid, locationID) 
{
    switch(locationID) 
    {
        case LOCATION_LS:
        {
            SetPlayerPos(playerid, 1482.0356, -1724.5726, 13.5469);
            SetPlayerFacingAngle(playerid, 179.4088);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SendClientMessage(playerid, -1, "SERVER: You have been teleported to Los Santos by admin via Discord.");
        }
        case LOCATION_LV:
        {
            SetPlayerPos(playerid, 1686.0118, 1448.9471, 10.7695);
            SetPlayerFacingAngle(playerid, 179.4088);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SendClientMessage(playerid, -1, "SERVER: You have been teleported to Las Venturas by admin via Discord.");
        }
        case LOCATION_SF:
        {
            SetPlayerPos(playerid, -1425.8307, -292.4445, 14.1484);
            SetPlayerFacingAngle(playerid, 179.4088);
            SetPlayerInterior(playerid, 0);
            SetPlayerVirtualWorld(playerid, 0);
            SendClientMessage(playerid, -1, "SERVER: You have been teleported to San Fierro by admin via Discord.");
        }
    }
}

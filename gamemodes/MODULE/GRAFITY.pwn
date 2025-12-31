
forward Tags_Load();
public Tags_Load()
{
	if(cache_num_rows())
	{
		for(new i = 0; i != cache_num_rows(); i++)
		{
			Iter_Add(Tags, i);

			cache_get_value_name_int(i, "tagId", TagsData[i][tagID] );
			cache_get_value_name_int(i, "tagOwner", TagsData[i][tagPlayerID] );
			cache_get_value_name_int(i, "tagBold", TagsData[i][tagBold] );
			cache_get_value_name_int(i, "tagFontsize", TagsData[i][tagSize] );
			cache_get_value_name_int(i, "tagColor", TagsData[i][tagColor] );
			cache_get_value_name_int(i, "tagExpired", TagsData[i][tagExpired] );

			cache_get_value_name(i, "tagText", TagsData[i][tagText]);
			cache_get_value_name(i, "tagFont", TagsData[i][tagFont]);
			cache_get_value_name(i, "tagCreated", TagsData[i][tagPlayerName]);

			cache_get_value_name_float(i, "tagPosx", TagsData[i][tagPosition][0]);
			cache_get_value_name_float(i, "tagPosy", TagsData[i][tagPosition][1]);
			cache_get_value_name_float(i, "tagPosz", TagsData[i][tagPosition][2]);

			cache_get_value_name_float(i, "tagRotx", TagsData[i][tagRotation][0]);
			cache_get_value_name_float(i, "tagRoty", TagsData[i][tagRotation][1]);
			cache_get_value_name_float(i, "tagRotz", TagsData[i][tagRotation][2]);

			Tags_Sync(i);
		}
		printf("*** Loaded %d spray tags.", cache_num_rows());
	}
	return 1;	
}

forward OnTagsCreated(index);
public OnTagsCreated(index)
{
	TagsData[index][tagID] = cache_insert_id();

	Tags_Sync(index);
	return 1;	
}

hook OnPlayerEditDynObj(playerid, objectid, response, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz)
{
	if(IsPlayerEditingTags(playerid))
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			if(!IsPlayerInRangeOfPoint(playerid, 5.0, x, y, z))
				return Tags_Menu(playerid), Tags_ObjectSync(playerid, true), Error(playerid, "Posisi "YELLOW_E"object "WHITE_E"melebihi "ORANGE_E"5 meter "WHITE_E"dari posisimu!!");

			SetPVarFloat(playerid, "TagsPosX", x);
			SetPVarFloat(playerid, "TagsPosY", y);
			SetPVarFloat(playerid, "TagsPosZ", z);

			SetPVarFloat(playerid, "TagsPosRX", rx);
			SetPVarFloat(playerid, "TagsPosRY", ry);
			SetPVarFloat(playerid, "TagsPosRZ", rz);

			Tags_Menu(playerid);
			Tags_ObjectSync(playerid);

			Servers(playerid, "Sukses memperbaharui posisi "YELLOW_E"object");
		}
		else if(response == EDIT_RESPONSE_CANCEL)
		{			
			Tags_Menu(playerid);
			Tags_ObjectSync(playerid, true);

			Error(playerid, "Gagal memperbaharui posisi object, object akan berubah keposisi sebelumnya.");
		}
	}
	return 1;
}

// Global Function
Tags_Create(playerid)
{
	static index;

	if((index = Iter_Free(Tags)) != cellmin)
	{
		Iter_Add(Tags, index);

		new text[TAGS_TEXT_LENGTH], font[TAGS_FONT_LENGTH];

		GetPVarString(playerid, "TagsText", text, sizeof(text));
		GetPVarString(playerid, "TagsFont", font, sizeof(font));

		format(TagsData[index][tagText], TAGS_TEXT_LENGTH, text);
		format(TagsData[index][tagFont], TAGS_FONT_LENGTH, font);
		format(TagsData[index][tagPlayerName], MAX_PLAYER_NAME, pData[playerid][pName]);

		TagsData[index][tagPosition][0] = GetPVarFloat(playerid, "TagsPosX");
		TagsData[index][tagPosition][1] = GetPVarFloat(playerid, "TagsPosY");
		TagsData[index][tagPosition][2] = GetPVarFloat(playerid, "TagsPosZ");

		TagsData[index][tagRotation][0] = GetPVarFloat(playerid, "TagsPosRX");
		TagsData[index][tagRotation][1] = GetPVarFloat(playerid, "TagsPosRY");
		TagsData[index][tagRotation][2] = GetPVarFloat(playerid, "TagsPosRZ");

		TagsData[index][tagPlayerID] = pData[playerid][pID];

		TagsData[index][tagBold] = GetPVarInt(playerid, "TagsBold");
		TagsData[index][tagSize] = GetPVarInt(playerid, "TagsSize");
		TagsData[index][tagColor] = GetPVarInt(playerid, "TagsColor");
		TagsData[index][tagExpired] = gettime() + 259200;

		new output[700];
		mysql_format(g_SQL, output, sizeof(output), "INSERT INTO `tags`(`tagText`, `tagFont`, `tagCreated`, `tagColor`, `tagFontsize`, `tagBold`, `tagOwner`, `tagPosx`, `tagPosy`, `tagPosz`, `tagRotx`, `tagRoty`, `tagRotz`, `tagExpired`) VALUES ('%s','%s','%s','%d','%d','%d','%d','%.3f','%.3f','%.3f','%.3f','%.3f','%.3f','%d')", 
			TagsData[index][tagText],			
			TagsData[index][tagFont],			
			TagsData[index][tagPlayerName],			
			TagsData[index][tagColor],			
			TagsData[index][tagSize],			
			TagsData[index][tagBold],			
			TagsData[index][tagPlayerID],			
			TagsData[index][tagPosition][0],			
			TagsData[index][tagPosition][1],			
			TagsData[index][tagPosition][2],
			TagsData[index][tagRotation][0],
			TagsData[index][tagRotation][1],
			TagsData[index][tagRotation][2],
			TagsData[index][tagExpired]
		);
		mysql_tquery(g_SQL, output, "OnTagsCreated", "d", index);
		return index;
	}
	return -1;
}

Tags_Delete(index)
{
	if(Tags_IsExists(index))
	{
		new output[212];
		mysql_format(g_SQL, output, sizeof(output), "DELETE FROM `tags` WHERE `tagId`='%d';", TagsData[index][tagID]);
		mysql_tquery(g_SQL, output);

		if (IsValidDynamicObject(TagsData[index][tagObjectID]))
			DestroyDynamicObject(TagsData[index][tagObjectID]);

		new tmp_TagsData[E_TAGS_DATA];
		TagsData[index] = tmp_TagsData;

		TagsData[index][tagObjectID] = INVALID_STREAMER_ID;
		Iter_Remove(Tags, index);
	}
	return 1;
}


Tags_IsExists(index)
{
	if(!Iter_Contains(Tags, index))
		return 0;

	return 1;
}

Tags_Sync(index)
{
	if(Tags_IsExists(index))
	{
		if(IsValidDynamicObject(TagsData[index][tagObjectID]))
		{
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_X, TagsData[index][tagPosition][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_Y, TagsData[index][tagPosition][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_Z, TagsData[index][tagPosition][2]);

			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_X, TagsData[index][tagRotation][0]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_Y, TagsData[index][tagRotation][1]);
			Streamer_SetFloatData(STREAMER_TYPE_OBJECT, TagsData[index][tagObjectID], E_STREAMER_R_Z, TagsData[index][tagRotation][2]);

		}
		else TagsData[index][tagObjectID] = CreateDynamicObject(18661, TagsData[index][tagPosition][0], TagsData[index][tagPosition][1], TagsData[index][tagPosition][2], TagsData[index][tagRotation][0], TagsData[index][tagRotation][1], TagsData[index][tagRotation][2], 0, 0, -1, 30, 30);

		SetDynamicObjectMaterialText(TagsData[index][tagObjectID], 0, TagsData[index][tagText], OBJECT_MATERIAL_SIZE_512x512, TagsData[index][tagFont], TagsData[index][tagSize], TagsData[index][tagBold], RGBAToARGB(ColorList[TagsData[index][tagColor]]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	}
	return 1;
}

Tags_Nearest(playerid, Float:range = 3.0)
{
	new id = -1, Float: playerdist, Float: tempdist = 9999.0;
	
	foreach(new i : Tags) 
	{
        playerdist = GetPlayerDistanceFromPoint(playerid, TagsData[i][tagPosition][0], TagsData[i][tagPosition][1], TagsData[i][tagPosition][2]);
        
        if(playerdist > range) continue;

	    if(playerdist <= tempdist) {
	        tempdist = playerdist;
	        id = i;
	    }
	}
	return id;
}

// Player Function
Tags_Menu(playerid)
{
	return ShowPlayerDialog(playerid, DIALOG_TAGS_MENU, DIALOG_STYLE_LIST, "Spray Tag", "Edit Position\nEdit Text\nFont Name\nFont Size\nText Color\nBold Text\nStart Spray!", "Select", "Close");
}
Tags_Reset(playerid)
{
	if(IsPlayerEditingTags(playerid))
	{
		SetPlayerEditingTags(playerid, false);

		if(IsValidDynamicObject(editing_object[playerid]))
			DestroyDynamicObject(editing_object[playerid]);

		editing_object[playerid] = INVALID_STREAMER_ID;
		DeletePVar(playerid, "TagsReady");
		DeletePVar(playerid, "TagsTimer");
	}
	return 1;
}

Tags_GetCount(playerid)
{
	new count;
	foreach(new i : Tags)
	{
		if(TagsData[i][tagPlayerID] != pData[playerid][pID])
			continue;

		count++;
	}
	return count;
}

Tags_ObjectSync(playerid, bool:editing_position = false)
{
	if(!IsPlayerEditingTags(playerid))
		return 0;

	new tags_text[TAGS_TEXT_LENGTH], font_name[TAGS_FONT_LENGTH];

	GetPVarString(playerid, "TagsText", tags_text, TAGS_TEXT_LENGTH);
	GetPVarString(playerid, "TagsFont", font_name, TAGS_FONT_LENGTH);

	if(editing_position)
	{
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_X, GetPVarFloat(playerid, "TagsPosX"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_Y, GetPVarFloat(playerid, "TagsPosY"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_Z, GetPVarFloat(playerid, "TagsPosZ"));

		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_X, GetPVarFloat(playerid, "TagsPosRX"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_Y, GetPVarFloat(playerid, "TagsPosRY"));
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT, editing_object[playerid], E_STREAMER_R_Z, GetPVarFloat(playerid, "TagsPosRZ"));
	}
	SetDynamicObjectMaterialText(editing_object[playerid], 0, tags_text, OBJECT_MATERIAL_SIZE_512x512, font_name, GetPVarInt(playerid, "TagsSize"), GetPVarInt(playerid, "TagsBold"), RGBAToARGB(ColorList[GetPVarInt(playerid, "TagsColor")]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	return 1;
}

Tags_DefaultVar(playerid, Float:x, Float:y, Float:z, Float:angle)
{
	SetPVarString(playerid, "TagsText", "TEXT");
	SetPVarString(playerid, "TagsFont", "Arial");

	SetPVarFloat(playerid, "TagsPosX", x);
	SetPVarFloat(playerid, "TagsPosY", y);
	SetPVarFloat(playerid, "TagsPosZ", z);
	
	SetPVarFloat(playerid, "TagsPosRX", 0);
	SetPVarFloat(playerid, "TagsPosRY", 0);
	SetPVarFloat(playerid, "TagsPosRZ", angle);

	SetPVarInt(playerid, "TagsBold", 1);
	SetPVarInt(playerid, "TagsColor", 1);
	SetPVarInt(playerid, "TagsSize", TAGS_DEFAULT_SIZE);
	return 1;
}

CMD:tags(playerid, params[])
{
	new options[7];

	if (sscanf(params, "s[7]", options))
		return Usage(playerid, "/tags [create/track/clean/info]");

	if(!strcmp(options, "create", true))
	{
		if (pData[playerid][pLevel] < 5 || pData[playerid][pPlayerCS] == 0)
            return Error(playerid, "Must be level 5 and have a character story to use this!");

		if (GetPlayerWeapon(playerid) != 41)
    		return Error(playerid, "Kamu harus menggunakan spray untuk melakukan ini!");

		if(GetPlayerVirtualWorld(playerid) > 0 || GetPlayerInterior(playerid) > 0)
			return Error(playerid, "Tidak bisa menggunakan perintah ini didalam interior!");

		if(Tags_GetCount(playerid) >= 3)
			return Error(playerid, "Kamu sudah memiliki 3 tags!");

		new Float:x, Float:y, Float:z, Float:angle;

		if(IsPlayerEditingTags(playerid))
			return Usage(playerid, "Selesaikan proses pembuatan tag terlebih dahulu!");

		GetPlayerPos(playerid, x, y, z);
		GetPlayerFacingAngle(playerid, angle);

		x += 0.5 * floatsin(-angle, degrees);
		y += 0.5 * floatcos(-angle, degrees);
		z += 0.5;
		angle += 90;

		Tags_Menu(playerid);
		SetPlayerEditingTags(playerid, true);
		Tags_DefaultVar(playerid, x, y, z, angle);

		editing_object[playerid] = CreateDynamicObject(18661, x, y, z, 0, 0, angle, 0, 0);
		SetDynamicObjectMaterialText(editing_object[playerid], 0, "TEXT", OBJECT_MATERIAL_SIZE_512x512, "Arial", TAGS_DEFAULT_SIZE, 1, RGBAToARGB(ColorList[1]), 0, OBJECT_MATERIAL_TEXT_ALIGN_CENTER);
	}
	else if (!strcmp(options, "clean", true))
	{
		new index;

		if((index = Tags_Nearest(playerid)) != -1)
		{
			if((pData[playerid][pFaction] != 1) && (TagsData[index][tagPlayerID] != pData[playerid][pID]) && (!pData[playerid][pAdmin]))
				return Error(playerid, "~r~ERROR: ~w~Ini bukan tag milikmu!.");

			Tags_Delete(index);
			Custom(playerid, "TAGS: "WHITE_E"Spray tag didekatmu telah dihapus!");
		}
		else Error(playerid, "Tidak ada tag didekatmu!");
	}
	else if (!strcmp(options, "info", true))
    {
        if(pData[playerid][pAdmin] < 1)
            return PermissionError(playerid);

        static index;

        if((index = Tags_Nearest(playerid)) != -1)
        {
            new infoString[256];
            format(infoString, sizeof(infoString), "Text: "YELLOW_E"%s\n"WHITE_E"Created by: "YELLOW_E"%s\n"WHITE_E"Expired Date: "YELLOW_E"%s",
                TagsData[index][tagText],
                TagsData[index][tagPlayerName],
                TagsData[index][tagExpired]);
            
            ShowPlayerDialog(playerid, DIALOG_UNUSED, DIALOG_STYLE_MSGBOX, "Spray Tag - Info", infoString, "Close", "");
        }
        else
            Error(playerid, "Tidak ada tag didekatmu!");
    }
	else if (!strcmp(options, "track", true))
	{
		if(!Tags_GetCount(playerid))
			return Error(playerid, "Kamu tidak memiliki tags!");

		new output[128];

		strcat(output, "Index\tLocation\n");
		foreach(new i : Tags) if(TagsData[i][tagPlayerID] == pData[playerid][pID])
			format(output, sizeof(output), "%s%d\t%s\n", output, i, GetLocation(TagsData[i][tagPosition][0], TagsData[i][tagPosition][1], TagsData[i][tagPosition][2]));

		ShowPlayerDialog(playerid, DIALOG_TAGS_TRACK, DIALOG_STYLE_TABLIST_HEADERS, "My Tags", output, "Track", "Close");
	}
	else Usage(playerid, "/tag [create/track/clean/info]");
	return 1;
}
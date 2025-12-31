//Enums
#define MAX_REPORTS (50)
#define MAX_ASKS (50)

enum reportData {
    bool:rExists,
    rType,
    rPlayer,
    rText[128 char]
};
new ReportData[MAX_REPORTS][reportData];

enum askData {
    bool:askExists,
    askType,
    askPlayer,
    askText[128 char]
};
new AskData[MAX_ASKS][askData];

// Variable untuk tracking ask/report yang dipilih
new PlayerAnsweringAsk[MAX_PLAYERS] = {-1, ...};
new PlayerAnsweringReport[MAX_PLAYERS] = {-1, ...};

// ========== REPORT FUNCTIONS ==========
Report_GetCount(playerid)
{
    new count;
    for (new i = 0; i != MAX_REPORTS; i ++)
    {
        if(ReportData[i][rExists] && ReportData[i][rPlayer] == playerid)
        {
			count++;
        }
    }
    return count;
}

Report_Clear(playerid)
{
    for (new i = 0; i != MAX_REPORTS; i ++)
    {
        if(ReportData[i][rExists] && ReportData[i][rPlayer] == playerid)
        {
            Report_Remove(i);
        }
    }
}

Report_Add(playerid, const text[], type = 1)
{
    for (new i = 0; i != MAX_REPORTS; i ++)
    {
        if(!ReportData[i][rExists])
        {
            ReportData[i][rExists] = true;
            ReportData[i][rType] = type;
            ReportData[i][rPlayer] = playerid;
            strpack(ReportData[i][rText], text, 128 char);
            return i;
        }
    }
    return -1;
}

Report_Remove(reportid)
{
    if(reportid != -1 && ReportData[reportid][rExists] == true)
    {
        ReportData[reportid][rExists] = false;
        ReportData[reportid][rPlayer] = INVALID_PLAYER_ID;
    }
    return 1;
}

// ========== ASK FUNCTIONS ==========
Ask_GetCount(playerid)
{
    new count;
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists] && AskData[i][askPlayer] == playerid)
        {
			count++;
        }
    }
    return count;
}

Ask_Clear(playerid)
{
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists] && AskData[i][askPlayer] == playerid)
        {
            Ask_Remove(i);
        }
    }
}

Ask_Add(playerid, const text[], type = 1)
{
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(!AskData[i][askExists])
        {
            AskData[i][askExists] = true;
            AskData[i][askType] = type;
            AskData[i][askPlayer] = playerid;
            strpack(AskData[i][askText], text, 128 char);
            return i;
        }
    }
    return -1;
}

Ask_Remove(reportid)
{
    if(reportid != -1 && AskData[reportid][askExists] == true)
    {
        AskData[reportid][askExists] = false;
        AskData[reportid][askPlayer] = INVALID_PLAYER_ID;
    }
    return 1;
}

// ========== PLAYER COMMANDS ==========
CMD:report(playerid, params[])
{
    new reportid = -1;

    if(isnull(params))
    {
        Usage(playerid, "/report [alasan]");
        Info(playerid, "Harap gunakan ini untuk melapor dalam IC/OOC.");
        return 1;
    }
    if(Report_GetCount(playerid) > 3)
        return Error(playerid, "Kamu telah memiliki 3 Laporan aktif!");

    if(pData[playerid][pReportTime] >= gettime())
        return Error(playerid, "Kamu harus menunggu %d detik untuk melakukan laporan.", pData[playerid][pReportTime] - gettime());

    if((reportid = Report_Add(playerid, params)) != -1)
    {
        Servers(playerid, "LAPORAN ANDA: {FFFF00}%s", params);
        SendStaffMessage(COLOR_RED, "[Report: #%d] "WHITE_E"%s (ID: %d) reported: %s", reportid, pData[playerid][pName], playerid, params);
        pData[playerid][pReportTime] = gettime() + 180;
    }
    else Error(playerid, "Laporan penuh, harap tunggu.");
    return 1;
}

CMD:ask(playerid, params[])
{
    new reportid = -1;

    if(isnull(params))
    {
        Usage(playerid, "/ask [pertanyaan]");
        Info(playerid, "Command ini khusus untuk pertanyaan.");
        return 1;
    }
    if(Ask_GetCount(playerid) > 1)
        return Error(playerid, "Kamu sudah memiliki 1 Pertanyaan!");

    if(pData[playerid][pAskTime] >= gettime())
        return Error(playerid, "Mohon tunggu %d detik untuk mengajukan pertanyaan.", pData[playerid][pAskTime] - gettime());

    if((reportid = Ask_Add(playerid, params)) != -1)
    {
        Servers(playerid, "YOUR QUESTION: {FFFF00}%s", params);
        SendStaffMessage(COLOR_RED, "{7fff00}[ASK: #%d] "WHITE_E"%s (ID: %d) QUESTION: %s", reportid, pData[playerid][pName], playerid, params);
        pData[playerid][pAskTime] = gettime() + 180;
    }
    else Error(playerid, "Pertanyaan sedang penuh!");
    return 1;
}

// ========== ADMIN/HELPER COMMANDS ==========
CMD:asks(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
	
	// Cek apakah ada ask yang aktif
	new bool:hasAsk = false;
	for(new i = 0; i < MAX_ASKS; i++)
	{
	    if(AskData[i][askExists])
	    {
	        hasAsk = true;
	        break;
	    }
	}
	
	if(!hasAsk)
	    return Error(playerid, "Tidak ada Pertanyaan yang aktif.");
			
	new gstr[1024], mstr[128], lstr[512];
    strcat(gstr,"ID\tASKer\tPertanyaan \n",sizeof(gstr));

    for (new i = 0; i < MAX_ASKS; i++)
    {
        if(AskData[i][askExists])
        {
            strunpack(mstr, AskData[i][askText]);

            if(strlen(mstr) > 32)
                format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%.32s ...\n", i, pData[AskData[i][askPlayer]][pName], AskData[i][askPlayer], mstr);
            else
                format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%s\n", i, pData[AskData[i][askPlayer]][pName], AskData[i][askPlayer], mstr);

            strcat(gstr,lstr,sizeof(gstr));
        }
    }
    ShowPlayerDialog(playerid, DIALOG_ASKS, DIALOG_STYLE_TABLIST_HEADERS,"Ask's",gstr,"Select","Cancel");
    return 1;
}

CMD:reports(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
	
	// Cek apakah ada report yang aktif
	new bool:hasReport = false;
	for(new i = 0; i < MAX_REPORTS; i++)
	{
	    if(ReportData[i][rExists])
	    {
	        hasReport = true;
	        break;
	    }
	}
	
	if(!hasReport)
	    return Error(playerid, "Tidak ada Report yang aktif.");
			
	new gstr[1024], mstr[128], lstr[512];
    strcat(gstr,"ID\tReported\tReport\n",sizeof(gstr));

    for (new i = 0; i < MAX_REPORTS; i++)
    {
        if(ReportData[i][rExists])
        {
            strunpack(mstr, ReportData[i][rText]);

            if(strlen(mstr) > 32)
            {
                format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%.32s ...\n", i, pData[ReportData[i][rPlayer]][pName], ReportData[i][rPlayer], mstr);
            }
            else
            {
                format(lstr,sizeof(lstr), "#%d\t%s (%d)\t%s\n", i, pData[ReportData[i][rPlayer]][pName], ReportData[i][rPlayer], mstr);
            }
            strcat(gstr,lstr,sizeof(gstr));
        }
    }
    ShowPlayerDialog(playerid, DIALOG_REPORTS, DIALOG_STYLE_TABLIST_HEADERS,"Report's",gstr,"Select","Cancel");
    return 1;
}

CMD:ans(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);
    
    new answer[128], askid;
    
    // Cek apakah ada ask yang dipilih dari dialog
    if(PlayerAnsweringAsk[playerid] != -1)
    {
        // Cara dialog: /ans <jawaban>
        if(sscanf(params, "s[128]", answer))
            return Usage(playerid, "/ans <jawaban>");
        
        new id = PlayerAnsweringAsk[playerid];
        
        if(!AskData[id][askExists])
        {
            PlayerAnsweringAsk[playerid] = -1;
            return Error(playerid, "Ask ini sudah tidak valid.");
        }
        
        new targetid = AskData[id][askPlayer];
        
        if(!IsPlayerConnected(targetid))
        {
            Ask_Remove(id);
            PlayerAnsweringAsk[playerid] = -1;
            return Error(playerid, "Player yang bertanya sudah disconnect.");
        }
        
        SendStaffMessage(COLOR_RED, "%s telah menjawab pertanyaan %s(%d).", pData[playerid][pAdminname], pData[targetid][pName], targetid);
        Servers(targetid, "ANSWER: {FF0000}%s {FFFFFF}: %s.", pData[playerid][pAdminname], answer);
        
        Ask_Remove(id);
        PlayerAnsweringAsk[playerid] = -1;
        return 1;
    }
    
    // Cara lama: /ans [ask id] [jawaban]
    if(sscanf(params, "ds[128]", askid, answer))
        return Usage(playerid, "/ans [ask id] [jawaban] atau pilih dari /asks lalu /ans [jawaban]");

    if((askid < 0 || askid >= MAX_ASKS) || !AskData[askid][askExists])
        return Error(playerid, "ID Ask tidak valid, Listitem dari 0 sampai %d.", MAX_ASKS);

    new targetid = AskData[askid][askPlayer];
    
    if(!IsPlayerConnected(targetid))
        return Error(playerid, "Player yang bertanya sudah disconnect.");

    SendStaffMessage(COLOR_RED, "%s telah menjawab pertanyaan %s(%d).", pData[playerid][pAdminname], pData[targetid][pName], targetid);
    Servers(targetid, "ANSWER: {FF0000}%s {FFFFFF}: %s.", pData[playerid][pAdminname], answer);

    Ask_Remove(askid);
    return 1;
}

CMD:ar(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return PermissionError(playerid);

    new answer[128], reportid;
    
    // Cek apakah ada report yang dipilih dari dialog
    if(PlayerAnsweringReport[playerid] != -1)
    {
        // Cara dialog: /ar <jawaban>
        if(sscanf(params, "s[128]", answer))
            return Usage(playerid, "/ar <jawaban>");
        
        new id = PlayerAnsweringReport[playerid];
        
        if(!ReportData[id][rExists])
        {
            PlayerAnsweringReport[playerid] = -1;
            return Error(playerid, "Report ini sudah tidak valid.");
        }
        
        new targetid = ReportData[id][rPlayer];
        
        if(!IsPlayerConnected(targetid))
        {
            Report_Remove(id);
            PlayerAnsweringReport[playerid] = -1;
            return Error(playerid, "Player yang report sudah disconnect.");
        }
        
        SendStaffMessage(COLOR_RED, "%s has accepted %s(%d) report.", pData[playerid][pAdminname], pData[targetid][pName], targetid);
        Servers(targetid, "ACCEPT REPORT: {FF0000}%s {FFFFFF}accept your report: %s", pData[playerid][pAdminname], answer);
        
        Report_Remove(id);
        PlayerAnsweringReport[playerid] = -1;
        return 1;
    }
    
    // Cara lama: /ar [report id] [jawaban]
    if(sscanf(params, "ds[128]", reportid, answer))
        return Usage(playerid, "/ar [report id] [jawaban] atau pilih dari /reports lalu /ar [jawaban]");

    if((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
        return Error(playerid, "Invalid report ID. Reports list from 0 to %d.", MAX_REPORTS);

    new targetid = ReportData[reportid][rPlayer];
    
    if(!IsPlayerConnected(targetid))
        return Error(playerid, "Player yang report sudah disconnect.");

    SendStaffMessage(COLOR_RED, "%s has accepted %s(%d) report.", pData[playerid][pAdminname], pData[targetid][pName], targetid);
    
    if(isnull(answer))
        Servers(targetid, "ACCEPT REPORT: {FF0000}%s {FFFFFF}accept your report.", pData[playerid][pAdminname]);
    else
        Servers(targetid, "ACCEPT REPORT: {FF0000}%s {FFFFFF}accept your report: %s", pData[playerid][pAdminname], answer);
    
    Report_Remove(reportid);
    return 1;
}

CMD:dr(playerid, params[])
{
    if(pData[playerid][pAdmin] < 1)
   		if(pData[playerid][pHelper] == 0)
     		return Error(playerid, "Kamu tidak memiliki izin!");

    new msg[128], reportid;
    
    // Cek apakah sedang memilih report dari dialog
    if(PlayerAnsweringReport[playerid] != -1)
    {
        // Cara dialog: /dr <alasan>
        if(sscanf(params, "s[128]", msg))
            return Usage(playerid, "/dr <alasan>");
        
        new id = PlayerAnsweringReport[playerid];
        
        if(!ReportData[id][rExists])
        {
            PlayerAnsweringReport[playerid] = -1;
            return Error(playerid, "Report ini sudah tidak valid.");
        }
        
        new targetid = ReportData[id][rPlayer];
        
        if(!IsPlayerConnected(targetid))
        {
            Report_Remove(id);
            PlayerAnsweringReport[playerid] = -1;
            return Error(playerid, "Player yang report sudah disconnect.");
        }
        
        SendStaffMessage(COLOR_RED, "%s has denied %s(%d) report.", pData[playerid][pAdminname], pData[targetid][pName], targetid);
        Servers(targetid, "DENY REPORT: {FF0000}%s {FFFFFF}denied your report: %s.", pData[playerid][pAdminname], msg);
        
        Report_Remove(id);
        PlayerAnsweringReport[playerid] = -1;
        return 1;
    }
    
    // Cara lama: /dr [report id] [reason]
    if(sscanf(params,"ds[128]", reportid, msg))
        return Usage(playerid, "/dr [report id] [reason] atau pilih dari /reports lalu /dr [reason]");

    if((reportid < 0 || reportid >= MAX_REPORTS) || !ReportData[reportid][rExists])
        return Error(playerid, "ID Report tidak valid, listitem 0 sampai %d.", MAX_REPORTS);

    new targetid = ReportData[reportid][rPlayer];
    
    if(!IsPlayerConnected(targetid))
        return Error(playerid, "Player yang report sudah disconnect.");

    SendStaffMessage(COLOR_RED, "%s has denied %s(%d) report.", pData[playerid][pAdminname], pData[targetid][pName], targetid);
    Servers(targetid, "DENY REPORT: {FF0000}%s {FFFFFF}denied your report: %s.", pData[playerid][pAdminname], msg);

    Report_Remove(reportid);
    return 1;
}

CMD:clearreports(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
        
    new count;
    for (new i = 0; i != MAX_REPORTS; i ++)
    {
        if(ReportData[i][rExists]) 
        {
            Report_Remove(i);
            count++;
        }
    }
    
    if(!count)
        return Error(playerid, "There are no active reports to display.");
            
    SendStaffMessage(COLOR_RED, "%s has removed all reports on the server.", pData[playerid][pAdminname]);
    return 1;
}

CMD:clearask(playerid, params[])
{
    if(pData[playerid][pAdmin] < 3)
        return PermissionError(playerid);
        
    new count;
    for (new i = 0; i != MAX_ASKS; i ++)
    {
        if(AskData[i][askExists]) 
        {
            Ask_Remove(i);
            count++;
        }
    }
    
    if(!count)
        return Error(playerid, "Tidak ada Pertanyaan yang aktif.");
            
    SendStaffMessage(COLOR_RED, "%s has removed all asks on the server.", pData[playerid][pAdminname]);
    return 1;
}


// ========== END OF FILE ==========
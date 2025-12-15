// Server Define
#define TEXT_GAMEMODE	"VL v1.2.1 Brasscore"
#define TEXT_WEBURL		"valenciaroleplay.id"
#define TEXT_LANGUAGE	"Indonesia/English"
#define SERVER_BOT      "ValenciaBot"
#define SERVER_NAME     "Valencia Roleplay #StillHigh"

// MySQL configuration
#define		MYSQL_HOST 			"10.148.0.7"
#define		MYSQL_USER 			"u2_CpeEnbl1rr"
#define		MYSQL_PASSWORD 		"s6r73442++xxqWeXG^0RiaiJ"
#define		MYSQL_DATABASE 		"s2_valencia"

// how many seconds until it kicks the player for taking too long to login
#define		SECONDS_TO_LOGIN 	200

// default spawn point: Las Venturas (The High Roller)
#define 	DEFAULT_POS_X 		1744.3411
#define 	DEFAULT_POS_Y 		-1862.8655
#define 	DEFAULT_POS_Z 		13.3983
#define 	DEFAULT_POS_A 		270.0000

//Android Client Check
//#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0

#define Loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

// Message
#define function%0(%1) forward %0(%1); public %0(%1)
#define Servers(%1,%2) SendClientMessageEx(%1, ARWIN, "SERVER: "WHITE_E""%2)
#define Info(%1,%2) SendClientMessageEx(%1, ARWIN, "INFO: "WHITE_E""%2)
#define Vehicle(%1,%2) SendClientMessageEx(%1, ARWIN, "VEHICLE: "WHITE_E""%2)
#define Usage(%1,%2) SendClientMessage(%1, ARWIN , "USAGE: "WHITEP_E""%2)
#define Error(%1,%2) SendClientMessageEx(%1, COLOR_GREY3, ""RED_E"[!] "GREY3_E""%2)
#define AdminCMD(%1,%2) SendClientMessageEx(%1, COLOR_RED , "AdmCmd: "WHITEP_E""%2)
#define Gps(%1,%2) SendClientMessageEx(%1, COLOR_GREY3, ""COLOR_GPS"GPS: "WHITE_E""%2)
#define PermissionError(%0) SendClientMessage(%0, COLOR_RED, "ERROR: "WHITE_E"Kamu tidak memiliki akses untuk melakukan command ini!")
#define SCM SendClientMessage
#define SM(%0,%1) \
    SendClientMessageEx(%0, COLOR_YELLOW, %1)

#define PRESSED(%0) \
    (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//Converter
#define minplus(%1) \
        (((%1) < 0) ? (-(%1)) : ((%1)))

// AntiCaps
#define UpperToLower(%1) for( new ToLowerChar; ToLowerChar < strlen( %1 ); ToLowerChar ++ ) if ( %1[ ToLowerChar ]> 64 && %1[ ToLowerChar ] < 91 ) %1[ ToLowerChar ] += 32

// Banneds
const BAN_MASK = (-1 << (32 - (/*this is the CIDR ip detection range [def: 26]*/26)));

//---------[ Define Faction ]-----
#define SAPD	1		//locker 1573.26, -1652.93, -40.59
#define	SAGS	2		// 1464.10, -1790.31, 2349.68
#define SAMD	3		// -1100.25, 1980.02, -58.91
#define SANEW	4		// 256.14, 1776.99, 701.08
//---------[ JOB ]---------//
#define BOX_INDEX            9 // Index Box Barang
new MOTD[128] = "Warga baru? '/claimsp'"; // Set default MOTD

new color_string[3256], object_font[200];
new const FontNames[][] = {
    "Arial",
    "Calibri",
    "Comic Sans MS",
    "Georgia",
    "Times New Roman",
    "Consolas",
    "Constantia",
    "Corbel",
    "Courier New",
    "Impact",
    "Lucida Console",
    "Palatino Linotype",
    "Tahoma",
    "Trebuchet MS",
    "Verdana",
    "Custom Font"
}; 




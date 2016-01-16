data
export holdSPString
align 1
LABELV holdSPString
char 1 0
skip 1023
align 4
LABELV MonthAbbrev
address $149
address $150
address $151
address $152
address $153
address $154
address $155
address $156
address $157
address $158
address $159
address $160
align 4
LABELV skillLevels
address $161
address $162
address $163
address $164
address $165
lit
align 4
LABELV numSkillLevels
byte 4 5
data
align 4
LABELV netSources
address $166
address $167
address $168
lit
align 4
LABELV numNetSources
byte 4 3
align 4
LABELV serverFilters
address $169
address $170
address $171
address $170
data
align 4
LABELV teamArenaGameTypes
address $172
address $173
address $174
address $175
address $176
address $177
address $178
address $179
address $180
address $181
lit
align 4
LABELV numTeamArenaGameTypes
byte 4 10
align 4
LABELV numServerFilters
byte 4 2
data
align 4
LABELV netnames
address $182
address $183
address $184
byte 4 0
align 4
LABELV gamecodetoui
byte 4 4
byte 4 2
byte 4 3
byte 4 0
byte 4 5
byte 4 1
byte 4 6
align 4
LABELV uitogamecode
byte 4 4
byte 4 6
byte 4 2
byte 4 3
byte 4 1
byte 4 5
byte 4 7
export uiSkinColor
align 4
LABELV uiSkinColor
byte 4 0
export vmMain
code
proc vmMain 12 8
file "../ui_main.c"
line 124
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:/*
;4:=======================================================================
;5:
;6:USER INTERFACE MAIN
;7:
;8:=======================================================================
;9:*/
;10:
;11:// use this to get a demo build without an explicit demo build, i.e. to get the demo ui files to build
;12://#define PRE_RELEASE_TADEMO
;13:
;14:#include "ui_local.h"
;15:#include "../qcommon/qfiles.h"
;16:#include "../qcommon/game_version.h"
;17:#include "ui_force.h"
;18:
;19:menuDef_t *Menus_FindByName(const char *p);
;20:void Menu_ShowItemByName(menuDef_t *menu, const char *p, qboolean bShow);
;21:void UpdateForceUsed();
;22:
;23:char holdSPString[1024]={0};
;24:
;25:uiInfo_t uiInfo;
;26:
;27:static const char *MonthAbbrev[] = {
;28:	"Jan","Feb","Mar",
;29:	"Apr","May","Jun",
;30:	"Jul","Aug","Sep",
;31:	"Oct","Nov","Dec"
;32:};
;33:
;34:
;35:static const char *skillLevels[] = {
;36:  "SKILL1",//"I Can Win",
;37:  "SKILL2",//"Bring It On",
;38:  "SKILL3",//"Hurt Me Plenty",
;39:  "SKILL4",//"Hardcore",
;40:  "SKILL5"//"Nightmare"
;41:};
;42:
;43:static const int numSkillLevels = sizeof(skillLevels) / sizeof(const char*);
;44:
;45:
;46:static const char *netSources[] = {
;47:	"Local",
;48:	"Internet",
;49:	"Favorites"
;50://	"Mplayer"
;51:};
;52:static const int numNetSources = sizeof(netSources) / sizeof(const char*);
;53:
;54:static const serverFilter_t serverFilters[] = {
;55:	{"All", "" },
;56:	{"Jedi Knight 2", "" },
;57:};
;58:
;59:static const char *teamArenaGameTypes[] = {
;60:	"FFA",
;61:	"HOLOCRON",
;62:	"JEDIMASTER",
;63:	"DUEL",
;64:	"SP",
;65:	"TEAM FFA",
;66:	"N/A",
;67:	"CTF",
;68:	"CTY",
;69:	"TEAMTOURNAMENT"
;70:};
;71:
;72:static int const numTeamArenaGameTypes = sizeof(teamArenaGameTypes) / sizeof(const char*);
;73:
;74:
;75:static const int numServerFilters = sizeof(serverFilters) / sizeof(serverFilter_t);
;76:
;77:
;78:static char* netnames[] = {
;79:	"???",
;80:	"UDP",
;81:	"IPX",
;82:	NULL
;83:};
;84:
;85:static int gamecodetoui[] = {4,2,3,0,5,1,6};
;86:static int uitogamecode[] = {4,6,2,3,1,5,7};
;87:
;88:
;89:static void UI_StartServerRefresh(qboolean full);
;90:static void UI_StopServerRefresh( void );
;91:static void UI_DoServerRefresh( void );
;92:static void UI_BuildServerDisplayList(qboolean force);
;93:static void UI_BuildServerStatus(qboolean force);
;94:static void UI_BuildFindPlayerList(qboolean force);
;95:static int QDECL UI_ServersQsortCompare( const void *arg1, const void *arg2 );
;96:static int UI_MapCountByGameType(qboolean singlePlayer);
;97:static int UI_HeadCountByTeam( void );
;98:static int UI_HeadCountByColor( void );
;99:static void UI_ParseGameInfo(const char *teamFile);
;100:static const char *UI_SelectedMap(int index, int *actual);
;101:static const char *UI_SelectedHead(int index, int *actual);
;102:static int UI_GetIndexFromSelection(int actual);
;103:
;104:int ProcessNewUI( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6 );
;105:int	uiSkinColor=TEAM_FREE;
;106:
;107:/*
;108:================
;109:vmMain
;110:
;111:This is the only way control passes into the module.
;112:This must be the very first function compiled into the .qvm file
;113:================
;114:*/
;115:vmCvar_t  ui_debug;
;116:vmCvar_t  ui_initialized;
;117:
;118:void _UI_Init( qboolean );
;119:void _UI_Shutdown( void );
;120:void _UI_KeyEvent( int key, qboolean down );
;121:void _UI_MouseEvent( int dx, int dy );
;122:void _UI_Refresh( int realtime );
;123:qboolean _UI_IsFullscreen( void );
;124:int vmMain( int command, int arg0, int arg1, int arg2, int arg3, int arg4, int arg5, int arg6, int arg7, int arg8, int arg9, int arg10, int arg11  ) {
line 125
;125:  switch ( command ) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $186
ADDRLP4 0
INDIRI4
CNSTI4 10
GTI4 $186
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $199
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $199
address $188
address $189
address $190
address $191
address $192
address $193
address $194
address $195
address $196
address $197
address $198
code
LABELV $188
line 127
;126:	  case UI_GETAPIVERSION:
;127:		  return UI_API_VERSION;
CNSTI4 6
RETI4
ADDRGP4 $185
JUMPV
LABELV $189
line 130
;128:
;129:	  case UI_INIT:
;130:		  _UI_Init(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Init
CALLV
pop
line 131
;131:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $190
line 134
;132:
;133:	  case UI_SHUTDOWN:
;134:		  _UI_Shutdown();
ADDRGP4 _UI_Shutdown
CALLV
pop
line 135
;135:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $191
line 138
;136:
;137:	  case UI_KEY_EVENT:
;138:		  _UI_KeyEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_KeyEvent
CALLV
pop
line 139
;139:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $192
line 142
;140:
;141:	  case UI_MOUSE_EVENT:
;142:		  _UI_MouseEvent( arg0, arg1 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 _UI_MouseEvent
CALLV
pop
line 143
;143:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $193
line 146
;144:
;145:	  case UI_REFRESH:
;146:		  _UI_Refresh( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_Refresh
CALLV
pop
line 147
;147:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $194
line 150
;148:
;149:	  case UI_IS_FULLSCREEN:
;150:		  return _UI_IsFullscreen();
ADDRLP4 4
ADDRGP4 _UI_IsFullscreen
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $185
JUMPV
LABELV $195
line 153
;151:
;152:	  case UI_SET_ACTIVE_MENU:
;153:		  _UI_SetActiveMenu( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 154
;154:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $196
line 157
;155:
;156:	  case UI_CONSOLE_COMMAND:
;157:		  return UI_ConsoleCommand(arg0);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 UI_ConsoleCommand
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $185
JUMPV
LABELV $197
line 160
;158:
;159:	  case UI_DRAW_CONNECT_SCREEN:
;160:		  UI_DrawConnectScreen( arg0 );
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_DrawConnectScreen
CALLV
pop
line 161
;161:		  return 0;
CNSTI4 0
RETI4
ADDRGP4 $185
JUMPV
LABELV $198
line 163
;162:	  case UI_HASUNIQUECDKEY: // mod authors need to observe this
;163:	    return qtrue; // bk010117 - change this to qfalse for mods!
CNSTI4 1
RETI4
ADDRGP4 $185
JUMPV
LABELV $186
line 167
;164:
;165:	}
;166:
;167:	return -1;
CNSTI4 -1
RETI4
LABELV $185
endproc vmMain 12 8
export AssetCache
proc AssetCache 84 8
line 172
;168:}
;169:
;170:
;171:
;172:void AssetCache() {
line 178
;173:	int n;
;174:	//if (Assets.textFont == NULL) {
;175:	//}
;176:	//Assets.background = trap_R_RegisterShaderNoMip( ASSET_BACKGROUND );
;177:	//Com_Printf("Menu Size: %i bytes\n", sizeof(Menus));
;178:	uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip( ASSET_GRADIENTBAR );
ADDRGP4 $203
ARGP4
ADDRLP4 4
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+28
ADDRLP4 4
INDIRI4
ASGNI4
line 179
;179:	uiInfo.uiDC.Assets.fxBasePic = trap_R_RegisterShaderNoMip( ART_FX_BASE );
ADDRGP4 $206
ARGP4
ADDRLP4 8
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+136
ADDRLP4 8
INDIRI4
ASGNI4
line 180
;180:	uiInfo.uiDC.Assets.fxPic[0] = trap_R_RegisterShaderNoMip( ART_FX_RED );
ADDRGP4 $209
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140
ADDRLP4 12
INDIRI4
ASGNI4
line 181
;181:	uiInfo.uiDC.Assets.fxPic[1] = trap_R_RegisterShaderNoMip( ART_FX_ORANGE );//trap_R_RegisterShaderNoMip( ART_FX_YELLOW );
ADDRGP4 $213
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+4
ADDRLP4 16
INDIRI4
ASGNI4
line 182
;182:	uiInfo.uiDC.Assets.fxPic[2] = trap_R_RegisterShaderNoMip( ART_FX_YELLOW );//trap_R_RegisterShaderNoMip( ART_FX_GREEN );
ADDRGP4 $217
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+8
ADDRLP4 20
INDIRI4
ASGNI4
line 183
;183:	uiInfo.uiDC.Assets.fxPic[3] = trap_R_RegisterShaderNoMip( ART_FX_GREEN );//trap_R_RegisterShaderNoMip( ART_FX_TEAL );
ADDRGP4 $221
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+12
ADDRLP4 24
INDIRI4
ASGNI4
line 184
;184:	uiInfo.uiDC.Assets.fxPic[4] = trap_R_RegisterShaderNoMip( ART_FX_BLUE );
ADDRGP4 $225
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+16
ADDRLP4 28
INDIRI4
ASGNI4
line 185
;185:	uiInfo.uiDC.Assets.fxPic[5] = trap_R_RegisterShaderNoMip( ART_FX_PURPLE );//trap_R_RegisterShaderNoMip( ART_FX_CYAN );
ADDRGP4 $229
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+20
ADDRLP4 32
INDIRI4
ASGNI4
line 186
;186:	uiInfo.uiDC.Assets.fxPic[6] = trap_R_RegisterShaderNoMip( ART_FX_WHITE );
ADDRGP4 $233
ARGP4
ADDRLP4 36
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+140+24
ADDRLP4 36
INDIRI4
ASGNI4
line 187
;187:	uiInfo.uiDC.Assets.scrollBar = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR );
ADDRGP4 $236
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+48
ADDRLP4 40
INDIRI4
ASGNI4
line 188
;188:	uiInfo.uiDC.Assets.scrollBarArrowDown = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWDOWN );
ADDRGP4 $239
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+36
ADDRLP4 44
INDIRI4
ASGNI4
line 189
;189:	uiInfo.uiDC.Assets.scrollBarArrowUp = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWUP );
ADDRGP4 $242
ARGP4
ADDRLP4 48
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+32
ADDRLP4 48
INDIRI4
ASGNI4
line 190
;190:	uiInfo.uiDC.Assets.scrollBarArrowLeft = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWLEFT );
ADDRGP4 $245
ARGP4
ADDRLP4 52
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+40
ADDRLP4 52
INDIRI4
ASGNI4
line 191
;191:	uiInfo.uiDC.Assets.scrollBarArrowRight = trap_R_RegisterShaderNoMip( ASSET_SCROLLBAR_ARROWRIGHT );
ADDRGP4 $248
ARGP4
ADDRLP4 56
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+44
ADDRLP4 56
INDIRI4
ASGNI4
line 192
;192:	uiInfo.uiDC.Assets.scrollBarThumb = trap_R_RegisterShaderNoMip( ASSET_SCROLL_THUMB );
ADDRGP4 $251
ARGP4
ADDRLP4 60
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+52
ADDRLP4 60
INDIRI4
ASGNI4
line 193
;193:	uiInfo.uiDC.Assets.sliderBar = trap_R_RegisterShaderNoMip( ASSET_SLIDER_BAR );
ADDRGP4 $254
ARGP4
ADDRLP4 64
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+68
ADDRLP4 64
INDIRI4
ASGNI4
line 194
;194:	uiInfo.uiDC.Assets.sliderThumb = trap_R_RegisterShaderNoMip( ASSET_SLIDER_THUMB );
ADDRGP4 $257
ARGP4
ADDRLP4 68
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+72
ADDRLP4 68
INDIRI4
ASGNI4
line 196
;195:
;196:	for( n = 0; n < NUM_CROSSHAIRS; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $258
line 197
;197:		uiInfo.uiDC.Assets.crosshairShader[n] = trap_R_RegisterShaderNoMip( va("gfx/2d/crosshair%c", 'a' + n ) );
ADDRGP4 $264
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 97
ADDI4
ARGI4
ADDRLP4 76
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+252+168
ADDP4
ADDRLP4 80
INDIRI4
ASGNI4
line 198
;198:	}
LABELV $259
line 196
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $258
line 200
;199:
;200:	uiInfo.newHighScoreSound = 0;//trap_S_RegisterSound("sound/feedback/voc_newhighscore.wav");
ADDRGP4 uiInfo+60728
CNSTI4 0
ASGNI4
line 201
;201:}
LABELV $200
endproc AssetCache 84 8
export _UI_DrawSides
proc _UI_DrawSides 12 36
line 203
;202:
;203:void _UI_DrawSides(float x, float y, float w, float h, float size) {
line 204
;204:	size *= uiInfo.uiDC.xscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+224
INDIRF4
MULF4
ASGNF4
line 205
;205:	trap_R_DrawStretchPic( x, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 uiInfo+11792
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 206
;206:	trap_R_DrawStretchPic( x + w - size, y, size, h, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 0
INDIRF4
ADDRFP4 8
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 uiInfo+11792
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 207
;207:}
LABELV $266
endproc _UI_DrawSides 12 36
export _UI_DrawTopBottom
proc _UI_DrawTopBottom 12 36
line 209
;208:
;209:void _UI_DrawTopBottom(float x, float y, float w, float h, float size) {
line 210
;210:	size *= uiInfo.uiDC.yscale;
ADDRFP4 16
ADDRFP4 16
INDIRF4
ADDRGP4 uiInfo+220
INDIRF4
MULF4
ASGNF4
line 211
;211:	trap_R_DrawStretchPic( x, y, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRLP4 0
CNSTF4 0
ASGNF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRLP4 0
INDIRF4
ARGF4
ADDRGP4 uiInfo+11792
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 212
;212:	trap_R_DrawStretchPic( x, y + h - size, w, size, 0, 0, 0, 0, uiInfo.uiDC.whiteShader );
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRFP4 16
INDIRF4
ASGNF4
ADDRFP4 4
INDIRF4
ADDRFP4 12
INDIRF4
ADDF4
ADDRLP4 4
INDIRF4
SUBF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 4
INDIRF4
ARGF4
ADDRLP4 8
CNSTF4 0
ASGNF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRGP4 uiInfo+11792
INDIRI4
ARGI4
ADDRGP4 trap_R_DrawStretchPic
CALLV
pop
line 213
;213:}
LABELV $270
endproc _UI_DrawTopBottom 12 36
export _UI_DrawRect
proc _UI_DrawRect 0 20
line 221
;214:/*
;215:================
;216:UI_DrawRect
;217:
;218:Coordinates are 640*480 virtual values
;219:=================
;220:*/
;221:void _UI_DrawRect( float x, float y, float width, float height, float size, const float *color ) {
line 222
;222:	trap_R_SetColor( color );
ADDRFP4 20
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 224
;223:
;224:  _UI_DrawTopBottom(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawTopBottom
CALLV
pop
line 225
;225:  _UI_DrawSides(x, y, width, height, size);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRF4
ARGF4
ADDRGP4 _UI_DrawSides
CALLV
pop
line 227
;226:
;227:	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 228
;228:}
LABELV $274
endproc _UI_DrawRect 0 20
export MenuFontToHandle
proc MenuFontToHandle 4 0
line 231
;229:
;230:int MenuFontToHandle(int iMenuFont)
;231:{
line 232
;232:	switch (iMenuFont)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $278
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $281
ADDRLP4 0
INDIRI4
CNSTI4 3
EQI4 $284
ADDRGP4 $276
JUMPV
line 233
;233:	{
LABELV $278
line 234
;234:		case 1: return uiInfo.uiDC.Assets.qhSmallFont;
ADDRGP4 uiInfo+252+12
INDIRI4
RETI4
ADDRGP4 $275
JUMPV
LABELV $281
line 235
;235:		case 2: return uiInfo.uiDC.Assets.qhMediumFont;
ADDRGP4 uiInfo+252+16
INDIRI4
RETI4
ADDRGP4 $275
JUMPV
LABELV $284
line 236
;236:		case 3: return uiInfo.uiDC.Assets.qhBigFont;
ADDRGP4 uiInfo+252+20
INDIRI4
RETI4
ADDRGP4 $275
JUMPV
LABELV $276
line 239
;237:	}
;238:
;239:	return uiInfo.uiDC.Assets.qhMediumFont;	// 0;
ADDRGP4 uiInfo+252+16
INDIRI4
RETI4
LABELV $275
endproc MenuFontToHandle 4 0
export Text_Width
proc Text_Width 12 12
line 243
;240:}
;241:
;242:int Text_Width(const char *text, float scale, int iMenuFont) 
;243:{	
line 244
;244:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 246
;245:
;246:	return trap_R_Font_StrLenPixels(text, iFontIndex, scale);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $289
endproc Text_Width 12 12
export Text_Height
proc Text_Height 12 8
line 250
;247:}
;248:
;249:int Text_Height(const char *text, float scale, int iMenuFont) 
;250:{
line 251
;251:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 253
;252:
;253:	return trap_R_Font_HeightPixels(iFontIndex, scale);
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 trap_R_Font_HeightPixels
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
LABELV $290
endproc Text_Height 12 8
export Text_Paint
proc Text_Paint 20 28
line 257
;254:}
;255:
;256:void Text_Paint(float x, float y, float scale, vec4_t color, const char *text, float adjust, int limit, int style, int iMenuFont)
;257:{
line 258
;258:	int iStyleOR = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 260
;259:
;260:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 32
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 264
;261:	//
;262:	// kludge.. convert JK2 menu styles to SOF2 printstring ctrl codes...
;263:	//	
;264:	switch (style)
ADDRLP4 12
ADDRFP4 28
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
LTI4 $292
ADDRLP4 12
INDIRI4
CNSTI4 6
GTI4 $292
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $301
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $301
address $294
address $295
address $296
address $297
address $298
address $299
address $300
code
line 265
;265:	{
LABELV $294
line 266
;266:	case  ITEM_TEXTSTYLE_NORMAL:			iStyleOR = 0;break;					// JK2 normal text
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $295
line 267
;267:	case  ITEM_TEXTSTYLE_BLINK:				iStyleOR = (int)STYLE_BLINK;break;		// JK2 fast blinking
ADDRLP4 0
CNSTI4 1073741824
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $296
line 268
;268:	case  ITEM_TEXTSTYLE_PULSE:				iStyleOR = (int)STYLE_BLINK;break;		// JK2 slow pulsing
ADDRLP4 0
CNSTI4 1073741824
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $297
line 269
;269:	case  ITEM_TEXTSTYLE_SHADOWED:			iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $298
line 270
;270:	case  ITEM_TEXTSTYLE_OUTLINED:			iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $299
line 271
;271:	case  ITEM_TEXTSTYLE_OUTLINESHADOWED:	iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
ADDRGP4 $293
JUMPV
LABELV $300
line 272
;272:	case  ITEM_TEXTSTYLE_SHADOWEDMORE:		iStyleOR = (int)STYLE_DROPSHADOW;break;	// JK2 drop shadow
ADDRLP4 0
CNSTU4 2147483648
CVUI4 4
ASGNI4
LABELV $292
LABELV $293
line 275
;273:	}
;274:
;275:	trap_R_Font_DrawString(	x,		// int ox
ADDRFP4 0
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
BORI4
ARGI4
ADDRFP4 24
INDIRI4
CNSTI4 0
NEI4 $303
ADDRLP4 16
CNSTI4 -1
ASGNI4
ADDRGP4 $304
JUMPV
LABELV $303
ADDRLP4 16
ADDRFP4 24
INDIRI4
ASGNI4
LABELV $304
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 8
INDIRF4
ARGF4
ADDRGP4 trap_R_Font_DrawString
CALLV
pop
line 283
;276:							y,		// int oy
;277:							text,	// const char *text
;278:							color,	// paletteRGBA_c c
;279:							iStyleOR | iFontIndex,	// const int iFontHandle
;280:							!limit?-1:limit,		// iCharLimit (-1 = none)
;281:							scale	// const float scale = 1.0f
;282:							);
;283:}
LABELV $291
endproc Text_Paint 20 28
export Text_PaintWithCursor
proc Text_PaintWithCursor 1076 36
ADDRFP4 24
ADDRFP4 24
INDIRI4
CVII1 4
ASGNI1
line 287
;284:
;285:
;286:void Text_PaintWithCursor(float x, float y, float scale, vec4_t color, const char *text, int cursorPos, char cursor, int limit, int style, int iMenuFont) 
;287:{
line 288
;288:	Text_Paint(x, y, scale, color, text, 0, limit, style, iMenuFont);
ADDRFP4 0
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 292
;289:
;290:	// now print the cursor as well...  (excuse the braces, it's for porting C++ to C)
;291:	//
;292:	{
line 294
;293:		char sTemp[1024];
;294:		int iCopyCount = limit ? min(strlen(text), limit) : strlen(text);
ADDRFP4 28
INDIRI4
CNSTI4 0
EQI4 $308
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
ADDRFP4 28
INDIRI4
GEI4 $310
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 1040
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1040
INDIRI4
ASGNI4
ADDRGP4 $311
JUMPV
LABELV $310
ADDRLP4 1032
ADDRFP4 28
INDIRI4
ASGNI4
LABELV $311
ADDRLP4 1028
ADDRLP4 1032
INDIRI4
ASGNI4
ADDRGP4 $309
JUMPV
LABELV $308
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 1044
INDIRI4
ASGNI4
LABELV $309
ADDRLP4 0
ADDRLP4 1028
INDIRI4
ASGNI4
line 295
;295:			iCopyCount = min(iCopyCount,cursorPos);
ADDRLP4 0
INDIRI4
ADDRFP4 20
INDIRI4
GEI4 $313
ADDRLP4 1048
ADDRLP4 0
INDIRI4
ASGNI4
ADDRGP4 $314
JUMPV
LABELV $313
ADDRLP4 1048
ADDRFP4 20
INDIRI4
ASGNI4
LABELV $314
ADDRLP4 0
ADDRLP4 1048
INDIRI4
ASGNI4
line 296
;296:			iCopyCount = min(iCopyCount,sizeof(sTemp));
ADDRLP4 0
INDIRI4
CVIU4 4
CNSTU4 1024
GEU4 $316
ADDRLP4 1052
ADDRLP4 0
INDIRI4
CVIU4 4
ASGNU4
ADDRGP4 $317
JUMPV
LABELV $316
ADDRLP4 1052
CNSTU4 1024
ASGNU4
LABELV $317
ADDRLP4 0
ADDRLP4 1052
INDIRU4
CVUI4 4
ASGNI4
line 300
;297:
;298:			// copy text into temp buffer for pixel measure...
;299:			//			
;300:			strncpy(sTemp,text,iCopyCount);
ADDRLP4 4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 strncpy
CALLP4
pop
line 301
;301:					sTemp[iCopyCount] = '\0';
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 303
;302:
;303:			{
line 304
;304:				int iFontIndex = MenuFontToHandle( iMenuFont );	
ADDRFP4 36
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 1056
ADDRLP4 1064
INDIRI4
ASGNI4
line 305
;305:				int iNextXpos  = trap_R_Font_StrLenPixels(sTemp, iFontIndex, scale );
ADDRLP4 4
ARGP4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRFP4 8
INDIRF4
ARGF4
ADDRLP4 1068
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRLP4 1060
ADDRLP4 1068
INDIRI4
ASGNI4
line 307
;306:
;307:				Text_Paint(x+iNextXpos, y, scale, color, va("%c",cursor), 0, limit, style|ITEM_TEXTSTYLE_BLINK, iMenuFont);
ADDRGP4 $318
ARGP4
ADDRFP4 24
INDIRI1
CVII4 1
ARGI4
ADDRLP4 1072
ADDRGP4 va
CALLP4
ASGNP4
ADDRFP4 0
INDIRF4
ADDRLP4 1060
INDIRI4
CVIF4 4
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
ADDRFP4 32
INDIRI4
CNSTI4 1
BORI4
ARGI4
ADDRFP4 36
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 308
;308:			}
line 309
;309:	}
line 310
;310:}
LABELV $305
endproc Text_PaintWithCursor 1076 36
lit
align 1
LABELV $322
char 1 0
skip 4095
code
proc Text_Paint_Limit 4140 36
line 316
;311:
;312:
;313:// maxX param is initially an X limit, but is also used as feedback. 0 = text was clipped to fit within, else maxX = next pos
;314://
;315:static void Text_Paint_Limit(float *maxX, float x, float y, float scale, vec4_t color, const char* text, float adjust, int limit, int iMenuFont) 
;316:{
line 319
;317:	// this is kinda dirty, but...
;318:	//
;319:	int iFontIndex = MenuFontToHandle(iMenuFont);
ADDRFP4 32
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 MenuFontToHandle
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 322
;320:	
;321:	//float fMax = *maxX;
;322:	int iPixelLen = trap_R_Font_StrLenPixels(text, iFontIndex, scale);
ADDRFP4 20
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 323
;323:	if (x + iPixelLen > *maxX)
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDF4
ADDRFP4 0
INDIRP4
INDIRF4
LEF4 $320
line 324
;324:	{
line 328
;325:		// whole text won't fit, so we need to print just the amount that does...
;326:		//  Ok, this is slow and tacky, but only called occasionally, and it works...
;327:		//
;328:		char sTemp[4096]={0};	// lazy assumption
ADDRLP4 24
ADDRGP4 $322
INDIRB
ASGNB 4096
line 329
;329:		const char *psText = text;
ADDRLP4 4120
ADDRFP4 20
INDIRP4
ASGNP4
line 330
;330:		char *psOut = &sTemp[0];
ADDRLP4 16
ADDRLP4 24
ASGNP4
line 331
;331:		char *psOutLastGood = psOut;
ADDRLP4 4124
ADDRLP4 16
INDIRP4
ASGNP4
ADDRGP4 $324
JUMPV
LABELV $323
line 337
;332:		unsigned int uiLetter;
;333:
;334:		while (*psText && (x + trap_R_Font_StrLenPixels(sTemp, iFontIndex, scale)<=*maxX) 
;335:			   && psOut < &sTemp[sizeof(sTemp)-1]	// sanity
;336:				)
;337:		{
line 338
;338:			psOutLastGood = psOut;
ADDRLP4 4124
ADDRLP4 16
INDIRP4
ASGNP4
line 340
;339:			
;340:			uiLetter = trap_AnyLanguage_ReadCharFromString(&psText);
ADDRLP4 4120
ARGP4
ADDRLP4 4128
ADDRGP4 trap_AnyLanguage_ReadCharFromString
CALLU4
ASGNU4
ADDRLP4 20
ADDRLP4 4128
INDIRU4
ASGNU4
line 341
;341:			if (uiLetter > 255)
ADDRLP4 20
INDIRU4
CNSTU4 255
LEU4 $327
line 342
;342:			{
line 343
;343:				*psOut++ = uiLetter>>8;
ADDRLP4 4132
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4132
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4132
INDIRP4
ADDRLP4 20
INDIRU4
CNSTI4 8
RSHU4
CVUI4 4
CVII1 4
ASGNI1
line 344
;344:				*psOut++ = uiLetter&0xFF;
ADDRLP4 4136
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4136
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4136
INDIRP4
ADDRLP4 20
INDIRU4
CNSTU4 255
BANDU4
CVUI4 4
CVII1 4
ASGNI1
line 345
;345:			}
ADDRGP4 $328
JUMPV
LABELV $327
line 347
;346:			else
;347:			{
line 348
;348:				*psOut++ = uiLetter&0xFF;
ADDRLP4 4132
ADDRLP4 16
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 4132
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4132
INDIRP4
ADDRLP4 20
INDIRU4
CNSTU4 255
BANDU4
CVUI4 4
CVII1 4
ASGNI1
line 349
;349:			}
LABELV $328
line 350
;350:		}
LABELV $324
line 334
ADDRLP4 4120
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $330
ADDRLP4 24
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 12
INDIRF4
ARGF4
ADDRLP4 4128
ADDRGP4 trap_R_Font_StrLenPixels
CALLI4
ASGNI4
ADDRFP4 4
INDIRF4
ADDRLP4 4128
INDIRI4
CVIF4 4
ADDF4
ADDRFP4 0
INDIRP4
INDIRF4
GTF4 $330
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 24+4095
CVPU4 4
LTU4 $323
LABELV $330
line 351
;351:		*psOutLastGood = '\0';
ADDRLP4 4124
INDIRP4
CNSTI1 0
ASGNI1
line 353
;352:
;353:		*maxX = 0;	// feedback
ADDRFP4 0
INDIRP4
CNSTF4 0
ASGNF4
line 354
;354:		Text_Paint(x, y, scale, color, sTemp, adjust, limit, ITEM_TEXTSTYLE_NORMAL, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 355
;355:	}
ADDRGP4 $321
JUMPV
LABELV $320
line 357
;356:	else
;357:	{
line 360
;358:		// whole text fits fine, so print it all...
;359:		//
;360:		*maxX = x + iPixelLen;	// feedback the next position, as the caller expects		
ADDRFP4 0
INDIRP4
ADDRFP4 4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 361
;361:		Text_Paint(x, y, scale, color, text, adjust, limit, ITEM_TEXTSTYLE_NORMAL, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 20
INDIRP4
ARGP4
ADDRFP4 24
INDIRF4
ARGF4
ADDRFP4 28
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 362
;362:	}
LABELV $321
line 363
;363:}
LABELV $319
endproc Text_Paint_Limit 4140 36
export UI_ShowPostGame
proc UI_ShowPostGame 0 8
line 366
;364:
;365:
;366:void UI_ShowPostGame(qboolean newHigh) {
line 367
;367:	trap_Cvar_Set ("cg_cameraOrbit", "0");
ADDRGP4 $332
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 368
;368:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $334
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 369
;369:	trap_Cvar_Set( "sv_killserver", "1" );
ADDRGP4 $335
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 370
;370:	uiInfo.soundHighScore = newHigh;
ADDRGP4 uiInfo+11828
ADDRFP4 0
INDIRI4
ASGNI4
line 371
;371:  _UI_SetActiveMenu(UIMENU_POSTGAME);
CNSTI4 5
ARGI4
ADDRGP4 _UI_SetActiveMenu
CALLV
pop
line 372
;372:}
LABELV $331
endproc UI_ShowPostGame 0 8
export UI_DrawCenteredPic
proc UI_DrawCenteredPic 8 20
line 379
;373:/*
;374:=================
;375:_UI_Refresh
;376:=================
;377:*/
;378:
;379:void UI_DrawCenteredPic(qhandle_t image, int w, int h) {
line 381
;380:  int x, y;
;381:  x = (SCREEN_WIDTH - w) / 2;
ADDRLP4 0
CNSTI4 640
ADDRFP4 4
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 382
;382:  y = (SCREEN_HEIGHT - h) / 2;
ADDRLP4 4
CNSTI4 480
ADDRFP4 8
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ASGNI4
line 383
;383:  UI_DrawHandlePic(x, y, w, h, image);
ADDRLP4 0
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 384
;384:}
LABELV $338
endproc UI_DrawCenteredPic 8 20
data
export frameCount
align 4
LABELV frameCount
byte 4 0
align 1
LABELV $340
char 1 0
skip 1023
export UI_GetStripEdString
code
proc UI_GetStripEdString 4 12
line 396
;385:
;386:int frameCount = 0;
;387:int startTime;
;388:
;389:vmCvar_t	ui_rankChange;
;390:static void UI_BuildPlayerList();
;391:char parsedFPMessage[1024];
;392:extern int FPMessageTime;
;393:void Text_PaintCenter(float x, float y, float scale, vec4_t color, const char *text, float adjust, int iMenuFont);
;394:
;395:const char *UI_GetStripEdString(char *refSection, char *refName)
;396:{
line 399
;397:	static char text[1024]={0};
;398:
;399:	trap_SP_GetStringTextString(va("%s_%s", refSection, refName), text, sizeof(text));
ADDRGP4 $341
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $340
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 400
;400:	return text;
ADDRGP4 $340
RETP4
LABELV $339
endproc UI_GetStripEdString 4 12
bss
align 4
LABELV $343
skip 4
align 4
LABELV $344
skip 16
export _UI_Refresh
code
proc _UI_Refresh 32 20
line 405
;401:}
;402:
;403:#define	UI_FPS_FRAMES	4
;404:void _UI_Refresh( int realtime )
;405:{
line 413
;406:	static int index;
;407:	static int	previousTimes[UI_FPS_FRAMES];
;408:
;409:	//if ( !( trap_Key_GetCatcher() & KEYCATCH_UI ) ) {
;410:	//	return;
;411:	//}
;412:
;413:	uiInfo.uiDC.frameTime = realtime - uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+236
ADDRFP4 0
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
SUBI4
ASGNI4
line 414
;414:	uiInfo.uiDC.realTime = realtime;
ADDRGP4 uiInfo+232
ADDRFP4 0
INDIRI4
ASGNI4
line 416
;415:
;416:	previousTimes[index % UI_FPS_FRAMES] = uiInfo.uiDC.frameTime;
ADDRGP4 $343
INDIRI4
CNSTI4 4
MODI4
CNSTI4 2
LSHI4
ADDRGP4 $344
ADDP4
ADDRGP4 uiInfo+236
INDIRI4
ASGNI4
line 417
;417:	index++;
ADDRLP4 0
ADDRGP4 $343
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 418
;418:	if ( index > UI_FPS_FRAMES ) {
ADDRGP4 $343
INDIRI4
CNSTI4 4
LEI4 $349
line 421
;419:		int i, total;
;420:		// average multiple frames together to smooth changes out a bit
;421:		total = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 422
;422:		for ( i = 0 ; i < UI_FPS_FRAMES ; i++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
LABELV $351
line 423
;423:			total += previousTimes[i];
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $344
ADDP4
INDIRI4
ADDI4
ASGNI4
line 424
;424:		}
LABELV $352
line 422
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $351
line 425
;425:		if ( !total ) {
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $355
line 426
;426:			total = 1;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 427
;427:		}
LABELV $355
line 428
;428:		uiInfo.uiDC.FPS = 1000 * UI_FPS_FRAMES / total;
ADDRGP4 uiInfo+11804
CNSTI4 4000
ADDRLP4 8
INDIRI4
DIVI4
CVIF4 4
ASGNF4
line 429
;429:	}
LABELV $349
line 433
;430:
;431:
;432:
;433:	UI_UpdateCvars();
ADDRGP4 UI_UpdateCvars
CALLV
pop
line 435
;434:
;435:	if (Menu_Count() > 0) {
ADDRLP4 4
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $358
line 437
;436:		// paint all the menus
;437:		Menu_PaintAll();
ADDRGP4 Menu_PaintAll
CALLV
pop
line 439
;438:		// refresh server browser list
;439:		UI_DoServerRefresh();
ADDRGP4 UI_DoServerRefresh
CALLV
pop
line 441
;440:		// refresh server status
;441:		UI_BuildServerStatus(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 443
;442:		// refresh find player list
;443:		UI_BuildFindPlayerList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 444
;444:	} 
LABELV $358
line 447
;445:	
;446:	// draw cursor
;447:	UI_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 448
;448:	if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $360
line 449
;449:		UI_DrawHandlePic( uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory, 48, 48, uiInfo.uiDC.Assets.cursor);
ADDRGP4 uiInfo+240
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 uiInfo+244
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 12
CNSTF4 1111490560
ASGNF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRLP4 12
INDIRF4
ARGF4
ADDRGP4 uiInfo+252+24
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 450
;450:	}
LABELV $360
line 453
;451:
;452:#ifndef NDEBUG
;453:	if (uiInfo.uiDC.debug)
ADDRGP4 uiInfo+248
INDIRI4
CNSTI4 0
EQI4 $366
line 454
;454:	{
line 458
;455:		// cursor coordinates
;456:		//FIXME
;457:		//UI_DrawString( 0, 0, va("(%d,%d)",uis.cursorx,uis.cursory), UI_LEFT|UI_SMALLFONT, colorRed );
;458:	}
LABELV $366
line 461
;459:#endif
;460:
;461:	if (ui_rankChange.integer)
ADDRGP4 ui_rankChange+12
INDIRI4
CNSTI4 0
EQI4 $369
line 462
;462:	{
line 463
;463:		FPMessageTime = realtime + 3000;
ADDRGP4 FPMessageTime
ADDRFP4 0
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 465
;464:
;465:		if (!parsedFPMessage[0] /*&& uiMaxRank > ui_rankChange.integer*/)
ADDRGP4 parsedFPMessage
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $372
line 466
;466:		{
line 467
;467:			const char *printMessage = UI_GetStripEdString("INGAMETEXT", "SET_NEW_RANK");
ADDRGP4 $374
ARGP4
ADDRGP4 $375
ARGP4
ADDRLP4 28
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 20
ADDRLP4 28
INDIRP4
ASGNP4
line 469
;468:
;469:			int i = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 470
;470:			int p = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 471
;471:			int linecount = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRGP4 $377
JUMPV
LABELV $376
line 474
;472:
;473:			while (printMessage[i] && p < 1024)
;474:			{
line 475
;475:				parsedFPMessage[p] = printMessage[i];
ADDRLP4 12
INDIRI4
ADDRGP4 parsedFPMessage
ADDP4
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 476
;476:				p++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 477
;477:				i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 478
;478:				linecount++;
ADDRLP4 24
ADDRLP4 24
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 480
;479:
;480:				if (linecount > 64 && printMessage[i] == ' ')
ADDRLP4 24
INDIRI4
CNSTI4 64
LEI4 $379
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 32
NEI4 $379
line 481
;481:				{
line 482
;482:					parsedFPMessage[p] = '\n';
ADDRLP4 12
INDIRI4
ADDRGP4 parsedFPMessage
ADDP4
CNSTI1 10
ASGNI1
line 483
;483:					p++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 484
;484:					linecount = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 485
;485:				}
LABELV $379
line 486
;486:			}
LABELV $377
line 473
ADDRLP4 16
INDIRI4
ADDRLP4 20
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $381
ADDRLP4 12
INDIRI4
CNSTI4 1024
LTI4 $376
LABELV $381
line 487
;487:			parsedFPMessage[p] = '\0';
ADDRLP4 12
INDIRI4
ADDRGP4 parsedFPMessage
ADDP4
CNSTI1 0
ASGNI1
line 488
;488:		}
LABELV $372
line 491
;489:
;490:		//if (uiMaxRank > ui_rankChange.integer)
;491:		{
line 492
;492:			uiMaxRank = ui_rankChange.integer;
ADDRGP4 uiMaxRank
ADDRGP4 ui_rankChange+12
INDIRI4
ASGNI4
line 493
;493:			uiForceRank = uiMaxRank;
ADDRGP4 uiForceRank
ADDRGP4 uiMaxRank
INDIRI4
ASGNI4
line 507
;494:
;495:			/*
;496:			while (x < NUM_FORCE_POWERS)
;497:			{
;498:				//For now just go ahead and clear force powers upon rank change
;499:				uiForcePowersRank[x] = 0;
;500:				x++;
;501:			}
;502:			uiForcePowersRank[FP_LEVITATION] = 1;
;503:			uiForceUsed = 0;
;504:			*/
;505:
;506:			//Use BG_LegalizedForcePowers and transfer the result into the UI force settings
;507:			UI_ReadLegalForce();
ADDRGP4 UI_ReadLegalForce
CALLV
pop
line 508
;508:		}
line 510
;509:
;510:		if (ui_freeSaber.integer && uiForcePowersRank[FP_SABERATTACK] < 1)
ADDRGP4 ui_freeSaber+12
INDIRI4
CNSTI4 0
EQI4 $383
ADDRGP4 uiForcePowersRank+60
INDIRI4
CNSTI4 1
GEI4 $383
line 511
;511:		{
line 512
;512:			uiForcePowersRank[FP_SABERATTACK] = 1;
ADDRGP4 uiForcePowersRank+60
CNSTI4 1
ASGNI4
line 513
;513:		}
LABELV $383
line 514
;514:		if (ui_freeSaber.integer && uiForcePowersRank[FP_SABERDEFEND] < 1)
ADDRGP4 ui_freeSaber+12
INDIRI4
CNSTI4 0
EQI4 $388
ADDRGP4 uiForcePowersRank+64
INDIRI4
CNSTI4 1
GEI4 $388
line 515
;515:		{
line 516
;516:			uiForcePowersRank[FP_SABERDEFEND] = 1;
ADDRGP4 uiForcePowersRank+64
CNSTI4 1
ASGNI4
line 517
;517:		}
LABELV $388
line 518
;518:		trap_Cvar_Set("ui_rankChange", "0");
ADDRGP4 $393
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 521
;519:
;520:		//remember to update the force power count after changing the max rank
;521:		UpdateForceUsed();
ADDRGP4 UpdateForceUsed
CALLV
pop
line 522
;522:	}
LABELV $369
line 524
;523:
;524:	if (ui_freeSaber.integer)
ADDRGP4 ui_freeSaber+12
INDIRI4
CNSTI4 0
EQI4 $394
line 525
;525:	{
line 526
;526:		bgForcePowerCost[FP_SABERATTACK][FORCE_LEVEL_1] = 0;
ADDRGP4 bgForcePowerCost+240+4
CNSTI4 0
ASGNI4
line 527
;527:		bgForcePowerCost[FP_SABERDEFEND][FORCE_LEVEL_1] = 0;
ADDRGP4 bgForcePowerCost+256+4
CNSTI4 0
ASGNI4
line 528
;528:	}
ADDRGP4 $395
JUMPV
LABELV $394
line 530
;529:	else
;530:	{
line 531
;531:		bgForcePowerCost[FP_SABERATTACK][FORCE_LEVEL_1] = 1;
ADDRGP4 bgForcePowerCost+240+4
CNSTI4 1
ASGNI4
line 532
;532:		bgForcePowerCost[FP_SABERDEFEND][FORCE_LEVEL_1] = 1;
ADDRGP4 bgForcePowerCost+256+4
CNSTI4 1
ASGNI4
line 533
;533:	}
LABELV $395
line 562
;534:
;535:	/*
;536:	if (parsedFPMessage[0] && FPMessageTime > realtime)
;537:	{
;538:		vec4_t txtCol;
;539:		int txtStyle = ITEM_TEXTSTYLE_SHADOWED;
;540:
;541:		if ((FPMessageTime - realtime) < 2000)
;542:		{
;543:			txtCol[0] = colorWhite[0];
;544:			txtCol[1] = colorWhite[1];
;545:			txtCol[2] = colorWhite[2];
;546:			txtCol[3] = (((float)FPMessageTime - (float)realtime)/2000);
;547:
;548:			txtStyle = 0;
;549:		}
;550:		else
;551:		{
;552:			txtCol[0] = colorWhite[0];
;553:			txtCol[1] = colorWhite[1];
;554:			txtCol[2] = colorWhite[2];
;555:			txtCol[3] = colorWhite[3];
;556:		}
;557:
;558:		Text_Paint(10, 0, 1, txtCol, parsedFPMessage, 0, 1024, txtStyle, FONT_MEDIUM);
;559:	}
;560:	*/
;561:	//For now, don't bother.
;562:}
LABELV $342
endproc _UI_Refresh 32 20
export _UI_Shutdown
proc _UI_Shutdown 0 0
line 569
;563:
;564:/*
;565:=================
;566:_UI_Shutdown
;567:=================
;568:*/
;569:void _UI_Shutdown( void ) {
line 570
;570:	trap_LAN_SaveCachedServers();
ADDRGP4 trap_LAN_SaveCachedServers
CALLV
pop
line 571
;571:}
LABELV $405
endproc _UI_Shutdown 0 0
data
export defaultMenu
align 4
LABELV defaultMenu
byte 4 0
bss
align 1
LABELV $407
skip 32768
export GetMenuBuffer
code
proc GetMenuBuffer 16 16
line 575
;572:
;573:char *defaultMenu = NULL;
;574:
;575:char *GetMenuBuffer(const char *filename) {
line 580
;576:	int	len;
;577:	fileHandle_t	f;
;578:	static char buf[MAX_MENUFILE];
;579:
;580:	len = trap_FS_FOpenFile( filename, &f, FS_READ );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 8
ADDRGP4 trap_FS_FOpenFile
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 581
;581:	if ( !f ) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $408
line 582
;582:		trap_Print( va( S_COLOR_RED "menu file not found: %s, using default\n", filename ) );
ADDRGP4 $410
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 583
;583:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $406
JUMPV
LABELV $408
line 585
;584:	}
;585:	if ( len >= MAX_MENUFILE ) {
ADDRLP4 0
INDIRI4
CNSTI4 32768
LTI4 $411
line 586
;586:		trap_Print( va( S_COLOR_RED "menu file too large: %s is %i, max allowed is %i", filename, len, MAX_MENUFILE ) );
ADDRGP4 $413
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 32768
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Print
CALLV
pop
line 587
;587:		trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 588
;588:		return defaultMenu;
ADDRGP4 defaultMenu
INDIRP4
RETP4
ADDRGP4 $406
JUMPV
LABELV $411
line 591
;589:	}
;590:
;591:	trap_FS_Read( buf, len, f );
ADDRGP4 $407
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_Read
CALLV
pop
line 592
;592:	buf[len] = 0;
ADDRLP4 0
INDIRI4
ADDRGP4 $407
ADDP4
CNSTI1 0
ASGNI1
line 593
;593:	trap_FS_FCloseFile( f );
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 595
;594:	//COM_Compress(buf);
;595:  return buf;
ADDRGP4 $407
RETP4
LABELV $406
endproc GetMenuBuffer 16 16
export Asset_Parse
proc Asset_Parse 2152 12
line 599
;596:
;597:}
;598:
;599:qboolean Asset_Parse(int handle) {
line 604
;600:	char	stripedFile[MAX_STRING_CHARS];
;601:	pc_token_t token;
;602:	const char *tempStr;
;603:
;604:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2068
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2068
INDIRI4
CNSTI4 0
NEI4 $415
line 605
;605:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $415
line 606
;606:	if (Q_stricmp(token.string, "{") != 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $420
ARGP4
ADDRLP4 2072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2072
INDIRI4
CNSTI4 0
EQI4 $422
line 607
;607:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $421
line 610
;608:	}
;609:    
;610:	while ( 1 ) {
line 612
;611:
;612:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 614
;613:
;614:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 2076
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 2076
INDIRI4
CNSTI4 0
NEI4 $424
line 615
;615:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $424
line 617
;616:
;617:		if (Q_stricmp(token.string, "}") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $429
ARGP4
ADDRLP4 2080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2080
INDIRI4
CNSTI4 0
NEI4 $426
line 618
;618:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $414
JUMPV
LABELV $426
line 622
;619:		}
;620:
;621:		// font
;622:		if (Q_stricmp(token.string, "font") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $433
ARGP4
ADDRLP4 2084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2084
INDIRI4
CNSTI4 0
NEI4 $430
line 624
;623:			int pointSize;
;624:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2092
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2092
INDIRI4
CNSTI4 0
EQI4 $436
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 2088
ARGP4
ADDRLP4 2096
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 2096
INDIRI4
CNSTI4 0
NEI4 $434
LABELV $436
line 625
;625:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $434
line 628
;626:			}			
;627:			//trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.textFont);
;628:			uiInfo.uiDC.Assets.qhMediumFont = trap_R_RegisterFont(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2100
ADDRGP4 trap_R_RegisterFont
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+16
ADDRLP4 2100
INDIRI4
ASGNI4
line 629
;629:			uiInfo.uiDC.Assets.fontRegistered = qtrue;
ADDRGP4 uiInfo+252+132
CNSTI4 1
ASGNI4
line 630
;630:			continue;
ADDRGP4 $422
JUMPV
LABELV $430
line 633
;631:		}
;632:
;633:		if (Q_stricmp(token.string, "smallFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $444
ARGP4
ADDRLP4 2088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2088
INDIRI4
CNSTI4 0
NEI4 $441
line 635
;634:			int pointSize;
;635:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2096
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2096
INDIRI4
CNSTI4 0
EQI4 $447
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 2092
ARGP4
ADDRLP4 2100
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 2100
INDIRI4
CNSTI4 0
NEI4 $445
LABELV $447
line 636
;636:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $445
line 639
;637:			}
;638:			//trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.smallFont);
;639:			uiInfo.uiDC.Assets.qhSmallFont = trap_R_RegisterFont(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2104
ADDRGP4 trap_R_RegisterFont
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+12
ADDRLP4 2104
INDIRI4
ASGNI4
line 640
;640:			continue;
ADDRGP4 $422
JUMPV
LABELV $441
line 643
;641:		}
;642:
;643:		if (Q_stricmp(token.string, "bigFont") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $453
ARGP4
ADDRLP4 2092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2092
INDIRI4
CNSTI4 0
NEI4 $450
line 645
;644:			int pointSize;
;645:			if (!PC_String_Parse(handle, &tempStr) || !PC_Int_Parse(handle,&pointSize)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2100
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2100
INDIRI4
CNSTI4 0
EQI4 $456
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 2096
ARGP4
ADDRLP4 2104
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $454
LABELV $456
line 646
;646:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $454
line 649
;647:			}
;648:			//trap_R_RegisterFont(tempStr, pointSize, &uiInfo.uiDC.Assets.bigFont);
;649:			uiInfo.uiDC.Assets.qhBigFont = trap_R_RegisterFont(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2108
ADDRGP4 trap_R_RegisterFont
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+20
ADDRLP4 2108
INDIRI4
ASGNI4
line 650
;650:			continue;
ADDRGP4 $422
JUMPV
LABELV $450
line 653
;651:		}
;652:
;653:		if (Q_stricmp(token.string, "stripedFile") == 0) 
ADDRLP4 0+16
ARGP4
ADDRGP4 $462
ARGP4
ADDRLP4 2096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2096
INDIRI4
CNSTI4 0
NEI4 $459
line 654
;654:		{
line 655
;655:			if (!PC_String_Parse(handle, &tempStr))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2100
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2100
INDIRI4
CNSTI4 0
NEI4 $463
line 656
;656:			{
line 657
;657:				Com_Printf(S_COLOR_YELLOW,"Bad 1st parameter for keyword 'stripedFile'");
ADDRGP4 $465
ARGP4
ADDRGP4 $466
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 658
;658:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $463
line 660
;659:			}
;660:			Q_strncpyz( stripedFile, tempStr,  sizeof(stripedFile) );
ADDRLP4 1044
ARGP4
ADDRLP4 1040
INDIRP4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 661
;661:			trap_SP_Register(stripedFile);
ADDRLP4 1044
ARGP4
ADDRGP4 trap_SP_Register
CALLI4
pop
line 662
;662:			continue;
ADDRGP4 $422
JUMPV
LABELV $459
line 665
;663:		}
;664:
;665:		if (Q_stricmp(token.string, "cursor") == 0) 
ADDRLP4 0+16
ARGP4
ADDRGP4 $470
ARGP4
ADDRLP4 2100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2100
INDIRI4
CNSTI4 0
NEI4 $467
line 666
;666:		{
line 667
;667:			if (!PC_String_Parse(handle, &uiInfo.uiDC.Assets.cursorStr))
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+4
ARGP4
ADDRLP4 2104
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $471
line 668
;668:			{
line 669
;669:				Com_Printf(S_COLOR_YELLOW,"Bad 1st parameter for keyword 'cursor'");
ADDRGP4 $465
ARGP4
ADDRGP4 $475
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 670
;670:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $471
line 672
;671:			}
;672:			uiInfo.uiDC.Assets.cursor = trap_R_RegisterShaderNoMip( uiInfo.uiDC.Assets.cursorStr);
ADDRGP4 uiInfo+252+4
INDIRP4
ARGP4
ADDRLP4 2108
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+24
ADDRLP4 2108
INDIRI4
ASGNI4
line 673
;673:			continue;
ADDRGP4 $422
JUMPV
LABELV $467
line 677
;674:		}
;675:
;676:		// gradientbar
;677:		if (Q_stricmp(token.string, "gradientbar") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $483
ARGP4
ADDRLP4 2104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2104
INDIRI4
CNSTI4 0
NEI4 $480
line 678
;678:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2108
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2108
INDIRI4
CNSTI4 0
NEI4 $484
line 679
;679:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $484
line 681
;680:			}
;681:			uiInfo.uiDC.Assets.gradientBar = trap_R_RegisterShaderNoMip(tempStr);
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2112
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+28
ADDRLP4 2112
INDIRI4
ASGNI4
line 682
;682:			continue;
ADDRGP4 $422
JUMPV
LABELV $480
line 686
;683:		}
;684:
;685:		// enterMenuSound
;686:		if (Q_stricmp(token.string, "menuEnterSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $491
ARGP4
ADDRLP4 2108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2108
INDIRI4
CNSTI4 0
NEI4 $488
line 687
;687:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2112
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $492
line 688
;688:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $492
line 690
;689:			}
;690:			uiInfo.uiDC.Assets.menuEnterSound = trap_S_RegisterSound( tempStr );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2116
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+76
ADDRLP4 2116
INDIRI4
ASGNI4
line 691
;691:			continue;
ADDRGP4 $422
JUMPV
LABELV $488
line 695
;692:		}
;693:
;694:		// exitMenuSound
;695:		if (Q_stricmp(token.string, "menuExitSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $499
ARGP4
ADDRLP4 2112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2112
INDIRI4
CNSTI4 0
NEI4 $496
line 696
;696:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2116
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2116
INDIRI4
CNSTI4 0
NEI4 $500
line 697
;697:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $500
line 699
;698:			}
;699:			uiInfo.uiDC.Assets.menuExitSound = trap_S_RegisterSound( tempStr );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2120
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+80
ADDRLP4 2120
INDIRI4
ASGNI4
line 700
;700:			continue;
ADDRGP4 $422
JUMPV
LABELV $496
line 704
;701:		}
;702:
;703:		// itemFocusSound
;704:		if (Q_stricmp(token.string, "itemFocusSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $507
ARGP4
ADDRLP4 2116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2116
INDIRI4
CNSTI4 0
NEI4 $504
line 705
;705:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2120
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2120
INDIRI4
CNSTI4 0
NEI4 $508
line 706
;706:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $508
line 708
;707:			}
;708:			uiInfo.uiDC.Assets.itemFocusSound = trap_S_RegisterSound( tempStr );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2124
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+88
ADDRLP4 2124
INDIRI4
ASGNI4
line 709
;709:			continue;
ADDRGP4 $422
JUMPV
LABELV $504
line 713
;710:		}
;711:
;712:		// menuBuzzSound
;713:		if (Q_stricmp(token.string, "menuBuzzSound") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $515
ARGP4
ADDRLP4 2120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2120
INDIRI4
CNSTI4 0
NEI4 $512
line 714
;714:			if (!PC_String_Parse(handle, &tempStr)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 1040
ARGP4
ADDRLP4 2124
ADDRGP4 PC_String_Parse
CALLI4
ASGNI4
ADDRLP4 2124
INDIRI4
CNSTI4 0
NEI4 $516
line 715
;715:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $516
line 717
;716:			}
;717:			uiInfo.uiDC.Assets.menuBuzzSound = trap_S_RegisterSound( tempStr );
ADDRLP4 1040
INDIRP4
ARGP4
ADDRLP4 2128
ADDRGP4 trap_S_RegisterSound
CALLI4
ASGNI4
ADDRGP4 uiInfo+252+84
ADDRLP4 2128
INDIRI4
ASGNI4
line 718
;718:			continue;
ADDRGP4 $422
JUMPV
LABELV $512
line 721
;719:		}
;720:
;721:		if (Q_stricmp(token.string, "fadeClamp") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $523
ARGP4
ADDRLP4 2124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2124
INDIRI4
CNSTI4 0
NEI4 $520
line 722
;722:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeClamp)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+92
ARGP4
ADDRLP4 2128
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 2128
INDIRI4
CNSTI4 0
NEI4 $422
line 723
;723:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
line 725
;724:			}
;725:			continue;
LABELV $520
line 728
;726:		}
;727:
;728:		if (Q_stricmp(token.string, "fadeCycle") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $531
ARGP4
ADDRLP4 2128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2128
INDIRI4
CNSTI4 0
NEI4 $528
line 729
;729:			if (!PC_Int_Parse(handle, &uiInfo.uiDC.Assets.fadeCycle)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+96
ARGP4
ADDRLP4 2132
ADDRGP4 PC_Int_Parse
CALLI4
ASGNI4
ADDRLP4 2132
INDIRI4
CNSTI4 0
NEI4 $422
line 730
;730:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
line 732
;731:			}
;732:			continue;
LABELV $528
line 735
;733:		}
;734:
;735:		if (Q_stricmp(token.string, "fadeAmount") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $539
ARGP4
ADDRLP4 2132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2132
INDIRI4
CNSTI4 0
NEI4 $536
line 736
;736:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.fadeAmount)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+100
ARGP4
ADDRLP4 2136
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 2136
INDIRI4
CNSTI4 0
NEI4 $422
line 737
;737:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
line 739
;738:			}
;739:			continue;
LABELV $536
line 742
;740:		}
;741:
;742:		if (Q_stricmp(token.string, "shadowX") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $547
ARGP4
ADDRLP4 2136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2136
INDIRI4
CNSTI4 0
NEI4 $544
line 743
;743:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowX)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+104
ARGP4
ADDRLP4 2140
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 2140
INDIRI4
CNSTI4 0
NEI4 $422
line 744
;744:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
line 746
;745:			}
;746:			continue;
LABELV $544
line 749
;747:		}
;748:
;749:		if (Q_stricmp(token.string, "shadowY") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $555
ARGP4
ADDRLP4 2140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2140
INDIRI4
CNSTI4 0
NEI4 $552
line 750
;750:			if (!PC_Float_Parse(handle, &uiInfo.uiDC.Assets.shadowY)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+108
ARGP4
ADDRLP4 2144
ADDRGP4 PC_Float_Parse
CALLI4
ASGNI4
ADDRLP4 2144
INDIRI4
CNSTI4 0
NEI4 $422
line 751
;751:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
line 753
;752:			}
;753:			continue;
LABELV $552
line 756
;754:		}
;755:
;756:		if (Q_stricmp(token.string, "shadowColor") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $563
ARGP4
ADDRLP4 2144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 2144
INDIRI4
CNSTI4 0
NEI4 $560
line 757
;757:			if (!PC_Color_Parse(handle, &uiInfo.uiDC.Assets.shadowColor)) {
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 uiInfo+252+112
ARGP4
ADDRLP4 2148
ADDRGP4 PC_Color_Parse
CALLI4
ASGNI4
ADDRLP4 2148
INDIRI4
CNSTI4 0
NEI4 $564
line 758
;758:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $414
JUMPV
LABELV $564
line 760
;759:			}
;760:			uiInfo.uiDC.Assets.shadowFadeClamp = uiInfo.uiDC.Assets.shadowColor[3];
ADDRGP4 uiInfo+252+128
ADDRGP4 uiInfo+252+112+12
INDIRF4
ASGNF4
line 761
;761:			continue;
LABELV $560
line 764
;762:		}
;763:
;764:	}
LABELV $422
line 610
ADDRGP4 $421
JUMPV
line 765
;765:	return qfalse;
CNSTI4 0
RETI4
LABELV $414
endproc Asset_Parse 2152 12
export UI_Report
proc UI_Report 0 0
line 769
;766:}
;767:
;768:
;769:void UI_Report() {
line 770
;770:  String_Report();
ADDRGP4 String_Report
CALLV
pop
line 773
;771:  //Font_Report();
;772:
;773:}
LABELV $573
endproc UI_Report 0 0
export UI_ParseMenu
proc UI_ParseMenu 1060 12
line 775
;774:
;775:void UI_ParseMenu(const char *menuFile) {
line 779
;776:	int handle;
;777:	pc_token_t token;
;778:
;779:	Com_Printf("Parsing menu file:%s\n", menuFile);
ADDRGP4 $575
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 781
;780:
;781:	handle = trap_PC_LoadSource(menuFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1044
INDIRI4
ASGNI4
line 782
;782:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $579
line 783
;783:		return;
ADDRGP4 $574
JUMPV
LABELV $578
line 786
;784:	}
;785:
;786:	while ( 1 ) {
line 787
;787:		memset(&token, 0, sizeof(pc_token_t));
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
CNSTI4 1040
ARGI4
ADDRGP4 memset
CALLP4
pop
line 788
;788:		if (!trap_PC_ReadToken( handle, &token )) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1048
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $581
line 789
;789:			break;
ADDRGP4 $580
JUMPV
LABELV $581
line 802
;790:		}
;791:
;792:		//if ( Q_stricmp( token, "{" ) ) {
;793:		//	Com_Printf( "Missing { in menu file\n" );
;794:		//	break;
;795:		//}
;796:
;797:		//if ( menuCount == MAX_MENUS ) {
;798:		//	Com_Printf( "Too many menus!\n" );
;799:		//	break;
;800:		//}
;801:
;802:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $583
line 803
;803:			break;
ADDRGP4 $580
JUMPV
LABELV $583
line 806
;804:		}
;805:
;806:		if (Q_stricmp(token.string, "assetGlobalDef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $589
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $586
line 807
;807:			if (Asset_Parse(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1056
ADDRGP4 Asset_Parse
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $580
line 808
;808:				continue;
ADDRGP4 $579
JUMPV
line 809
;809:			} else {
line 810
;810:				break;
LABELV $586
line 814
;811:			}
;812:		}
;813:
;814:		if (Q_stricmp(token.string, "menudef") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $595
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $592
line 816
;815:			// start a new menu
;816:			Menu_New(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Menu_New
CALLV
pop
line 817
;817:		}
LABELV $592
line 818
;818:	}
LABELV $579
line 786
ADDRGP4 $578
JUMPV
LABELV $580
line 819
;819:	trap_PC_FreeSource(handle);
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 820
;820:}
LABELV $574
endproc UI_ParseMenu 1060 12
export Load_Menu
proc Load_Menu 1048 8
line 822
;821:
;822:qboolean Load_Menu(int handle) {
line 825
;823:	pc_token_t token;
;824:
;825:	if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1040
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $597
line 826
;826:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $596
JUMPV
LABELV $597
line 827
;827:	if (token.string[0] != '{') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $603
line 828
;828:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $596
JUMPV
LABELV $602
line 831
;829:	}
;830:
;831:	while ( 1 ) {
line 833
;832:
;833:		if (!trap_PC_ReadToken(handle, &token))
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1044
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $605
line 834
;834:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $596
JUMPV
LABELV $605
line 836
;835:    
;836:		if ( token.string[0] == 0 ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $607
line 837
;837:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $596
JUMPV
LABELV $607
line 840
;838:		}
;839:
;840:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $610
line 841
;841:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $596
JUMPV
LABELV $610
line 844
;842:		}
;843:
;844:		UI_ParseMenu(token.string); 
ADDRLP4 0+16
ARGP4
ADDRGP4 UI_ParseMenu
CALLV
pop
line 845
;845:	}
LABELV $603
line 831
ADDRGP4 $602
JUMPV
line 846
;846:	return qfalse;
CNSTI4 0
RETI4
LABELV $596
endproc Load_Menu 1048 8
export UI_LoadMenus
proc UI_LoadMenus 1068 8
line 849
;847:}
;848:
;849:void UI_LoadMenus(const char *menuFile, qboolean reset) {
line 854
;850:	pc_token_t token;
;851:	int handle;
;852:	int start;
;853:
;854:	start = trap_Milliseconds();
ADDRLP4 1048
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1048
INDIRI4
ASGNI4
line 856
;855:
;856:	trap_PC_LoadGlobalDefines ( "ui/jk2mp/menudef.h" );
ADDRGP4 $615
ARGP4
ADDRGP4 trap_PC_LoadGlobalDefines
CALLI4
pop
line 858
;857:
;858:	handle = trap_PC_LoadSource( menuFile );
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1052
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1052
INDIRI4
ASGNI4
line 859
;859:	if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $616
line 860
;860:		Com_Printf( S_COLOR_YELLOW "menu file not found: %s, using default\n", menuFile );
ADDRGP4 $618
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 861
;861:		handle = trap_PC_LoadSource( "ui/jk2mpmenus.txt" );
ADDRGP4 $619
ARGP4
ADDRLP4 1056
ADDRGP4 trap_PC_LoadSource
CALLI4
ASGNI4
ADDRLP4 1040
ADDRLP4 1056
INDIRI4
ASGNI4
line 862
;862:		if (!handle) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $620
line 863
;863:			trap_Error( va( S_COLOR_RED "default menu file not found: ui/menus.txt, unable to continue!\n", menuFile ) );
ADDRGP4 $622
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1060
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1060
INDIRP4
ARGP4
ADDRGP4 trap_Error
CALLV
pop
line 864
;864:		}
LABELV $620
line 865
;865:	}
LABELV $616
line 867
;866:
;867:	if (reset) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $626
line 868
;868:		Menu_Reset();
ADDRGP4 Menu_Reset
CALLV
pop
line 869
;869:	}
ADDRGP4 $626
JUMPV
LABELV $625
line 871
;870:
;871:	while ( 1 ) {
line 872
;872:		if (!trap_PC_ReadToken(handle, &token))
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 1056
ADDRGP4 trap_PC_ReadToken
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $628
line 873
;873:			break;
ADDRGP4 $627
JUMPV
LABELV $628
line 874
;874:		if( token.string[0] == 0 || token.string[0] == '}') {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $634
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $630
LABELV $634
line 875
;875:			break;
ADDRGP4 $627
JUMPV
LABELV $630
line 878
;876:		}
;877:
;878:		if ( token.string[0] == '}' ) {
ADDRLP4 0+16
INDIRI1
CVII4 1
CNSTI4 125
NEI4 $635
line 879
;879:			break;
ADDRGP4 $627
JUMPV
LABELV $635
line 882
;880:		}
;881:
;882:		if (Q_stricmp(token.string, "loadmenu") == 0) {
ADDRLP4 0+16
ARGP4
ADDRGP4 $641
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $638
line 883
;883:			if (Load_Menu(handle)) {
ADDRLP4 1040
INDIRI4
ARGI4
ADDRLP4 1064
ADDRGP4 Load_Menu
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
EQI4 $627
line 884
;884:				continue;
line 885
;885:			} else {
line 886
;886:				break;
LABELV $638
line 889
;887:			}
;888:		}
;889:	}
LABELV $626
line 871
ADDRGP4 $625
JUMPV
LABELV $627
line 891
;890:
;891:	Com_Printf("UI menu load time = %d milli seconds\n", trap_Milliseconds() - start);
ADDRLP4 1056
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRGP4 $644
ARGP4
ADDRLP4 1056
INDIRI4
ADDRLP4 1044
INDIRI4
SUBI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 893
;892:
;893:	trap_PC_FreeSource( handle );
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 trap_PC_FreeSource
CALLI4
pop
line 895
;894:
;895:	trap_PC_RemoveAllGlobalDefines ( );
ADDRGP4 trap_PC_RemoveAllGlobalDefines
CALLV
pop
line 896
;896:}
LABELV $614
endproc UI_LoadMenus 1068 8
export UI_Load
proc UI_Load 1048 8
line 898
;897:
;898:void UI_Load() {
line 901
;899:	char *menuSet;
;900:	char lastName[1024];
;901:	menuDef_t *menu = Menu_GetFocused();
ADDRLP4 1032
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 1032
INDIRP4
ASGNP4
line 903
;902:
;903:	if (menu && menu->window.name) {
ADDRLP4 1040
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 1040
INDIRU4
EQU4 $646
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1040
INDIRU4
EQU4 $646
line 904
;904:		strcpy(lastName, menu->window.name);
ADDRLP4 8
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 905
;905:	}
ADDRGP4 $647
JUMPV
LABELV $646
line 907
;906:	else
;907:	{
line 908
;908:		lastName[0] = 0;
ADDRLP4 8
CNSTI1 0
ASGNI1
line 909
;909:	}
LABELV $647
line 911
;910:
;911:	if (uiInfo.inGameLoad)
ADDRGP4 uiInfo+95064
INDIRI4
CNSTI4 0
EQI4 $648
line 912
;912:	{
line 913
;913:		menuSet= "ui/jk2mpingame.txt";
ADDRLP4 0
ADDRGP4 $651
ASGNP4
line 914
;914:	}
ADDRGP4 $649
JUMPV
LABELV $648
line 916
;915:	else
;916:	{
line 917
;917:		menuSet= UI_Cvar_VariableString("ui_menuFilesMP");
ADDRGP4 $652
ARGP4
ADDRLP4 1044
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1044
INDIRP4
ASGNP4
line 918
;918:	}
LABELV $649
line 919
;919:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $655
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $653
LABELV $655
line 920
;920:		menuSet = "ui/jk2mpmenus.txt";
ADDRLP4 0
ADDRGP4 $619
ASGNP4
line 921
;921:	}
LABELV $653
line 923
;922:
;923:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 928
;924:
;925:#ifdef PRE_RELEASE_TADEMO
;926:	UI_ParseGameInfo("demogameinfo.txt");
;927:#else
;928:	UI_ParseGameInfo("ui/jk2mp/gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 929
;929:	UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 932
;930:#endif
;931:
;932:	UI_LoadMenus(menuSet, qtrue);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 933
;933:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 934
;934:	Menus_ActivateByName(lastName);
ADDRLP4 8
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 936
;935:
;936:}
LABELV $645
endproc UI_Load 1048 8
data
align 4
LABELV handicapValues
address $657
address $658
address $659
address $660
address $661
address $662
address $663
address $664
address $665
address $666
address $667
address $668
address $669
address $670
address $671
address $672
address $673
address $674
address $675
address $676
byte 4 0
code
proc UI_DrawHandicap 20 36
line 940
;937:
;938:static const char *handicapValues[] = {"None","95","90","85","80","75","70","65","60","55","50","45","40","35","30","25","20","15","10","5",NULL};
;939:
;940:static void UI_DrawHandicap(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 943
;941:  int i, h;
;942:
;943:  h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 944
;944:  i = 20 - h / 5;
ADDRLP4 0
CNSTI4 20
ADDRLP4 4
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 946
;945:
;946:  Text_Paint(rect->x, rect->y, scale, color, handicapValues[i], 0, 0, textStyle, iMenuFont);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 947
;947:}
LABELV $677
endproc UI_DrawHandicap 20 36
proc UI_DrawClanName 8 36
line 949
;948:
;949:static void UI_DrawClanName(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 950
;950:  Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_teamName"), 0, 0, textStyle, iMenuFont);
ADDRGP4 $680
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 951
;951:}
LABELV $679
endproc UI_DrawClanName 8 36
proc UI_SetCapFragLimits 16 8
line 954
;952:
;953:
;954:static void UI_SetCapFragLimits(qboolean uiVars) {
line 955
;955:	int cap = 5;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 956
;956:	int frag = 10;
ADDRLP4 4
CNSTI4 10
ASGNI4
line 958
;957:
;958:	if (uiVars) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $682
line 959
;959:		trap_Cvar_Set("ui_captureLimit", va("%d", cap));
ADDRGP4 $685
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $684
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 960
;960:		trap_Cvar_Set("ui_fragLimit", va("%d", frag));
ADDRGP4 $685
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $686
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 961
;961:	} else {
ADDRGP4 $683
JUMPV
LABELV $682
line 962
;962:		trap_Cvar_Set("capturelimit", va("%d", cap));
ADDRGP4 $685
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $687
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 963
;963:		trap_Cvar_Set("fraglimit", va("%d", frag));
ADDRGP4 $685
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $688
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 964
;964:	}
LABELV $683
line 965
;965:}
LABELV $681
endproc UI_SetCapFragLimits 16 8
proc UI_DrawGameType 4 36
line 967
;966:// ui_gameType assumes gametype 0 is -1 ALL and will not show
;967:static void UI_DrawGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 968
;968:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_gameType.integer].gameType, 0, 0, textStyle, iMenuFont);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 969
;969:}
LABELV $689
endproc UI_DrawGameType 4 36
proc UI_DrawNetGameType 4 36
line 971
;970:
;971:static void UI_DrawNetGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 972
;972:	if (ui_netGameType.integer < 0 || ui_netGameType.integer > uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $698
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+17736
INDIRI4
LEI4 $693
LABELV $698
line 973
;973:		trap_Cvar_Set("ui_netGameType", "0");
ADDRGP4 $699
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 974
;974:		trap_Cvar_Set("ui_actualNetGameType", "0");
ADDRGP4 $700
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 975
;975:	}
LABELV $693
line 976
;976:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[ui_netGameType.integer].gameType , 0, 0, textStyle, iMenuFont);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 977
;977:}
LABELV $692
endproc UI_DrawNetGameType 4 36
proc UI_DrawAutoSwitch 28 36
line 979
;978:
;979:static void UI_DrawAutoSwitch(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 980
;980:	int switchVal = trap_Cvar_VariableValue("cg_autoswitch");
ADDRGP4 $704
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 981
;981:	const char *switchString = "AUTOSWITCH1";
ADDRLP4 4
ADDRGP4 $705
ASGNP4
line 982
;982:	const char *stripString = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 984
;983:
;984:	switch(switchVal)
ADDRLP4 16
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $712
ADDRLP4 16
INDIRI4
CNSTI4 2
EQI4 $708
ADDRLP4 16
INDIRI4
CNSTI4 3
EQI4 $710
ADDRGP4 $707
JUMPV
line 985
;985:	{
LABELV $708
line 987
;986:	case 2:
;987:		switchString = "AUTOSWITCH2";
ADDRLP4 4
ADDRGP4 $709
ASGNP4
line 988
;988:		break;
ADDRGP4 $707
JUMPV
LABELV $710
line 990
;989:	case 3:
;990:		switchString = "AUTOSWITCH3";
ADDRLP4 4
ADDRGP4 $711
ASGNP4
line 991
;991:		break;
ADDRGP4 $707
JUMPV
LABELV $712
line 993
;992:	case 0:
;993:		switchString = "AUTOSWITCH0";
ADDRLP4 4
ADDRGP4 $713
ASGNP4
line 994
;994:		break;
line 996
;995:	default:
;996:		break;
LABELV $707
line 999
;997:	}
;998:
;999:	stripString = UI_GetStripEdString("INGAMETEXT", (char *)switchString);
ADDRGP4 $374
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 1001
;1000:
;1001:	if (stripString)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $714
line 1002
;1002:	{
line 1003
;1003:		Text_Paint(rect->x, rect->y, scale, color, stripString, 0, 0, textStyle, iMenuFont);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1004
;1004:	}
LABELV $714
line 1005
;1005:}
LABELV $703
endproc UI_DrawAutoSwitch 28 36
proc UI_DrawJoinGameType 4 36
line 1007
;1006:
;1007:static void UI_DrawJoinGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1008
;1008:	if (ui_joinGameType.integer < 0 || ui_joinGameType.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
LTI4 $722
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+17868
INDIRI4
LEI4 $717
LABELV $722
line 1009
;1009:		trap_Cvar_Set("ui_joinGameType", "0");
ADDRGP4 $723
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1010
;1010:	}
LABELV $717
line 1011
;1011:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.joinGameTypes[ui_joinGameType.integer].gameType , 0, 0, textStyle, iMenuFont);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17872
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1012
;1012:}
LABELV $716
endproc UI_DrawJoinGameType 4 36
proc UI_TeamIndexFromName 12 8
line 1016
;1013:
;1014:
;1015:
;1016:static int UI_TeamIndexFromName(const char *name) {
line 1019
;1017:  int i;
;1018:
;1019:  if (name && *name) {
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $727
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $727
line 1020
;1020:    for (i = 0; i < uiInfo.teamCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $732
JUMPV
LABELV $729
line 1021
;1021:      if (Q_stricmp(name, uiInfo.teamList[i].teamName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $734
line 1022
;1022:        return i;
ADDRLP4 0
INDIRI4
RETI4
ADDRGP4 $726
JUMPV
LABELV $734
line 1024
;1023:      }
;1024:    }
LABELV $730
line 1020
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $732
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $729
line 1025
;1025:  } 
LABELV $727
line 1027
;1026:
;1027:  return 0;
CNSTI4 0
RETI4
LABELV $726
endproc UI_TeamIndexFromName 12 8
proc UI_DrawClanLogo 48 20
line 1031
;1028:
;1029:}
;1030:
;1031:static void UI_DrawClanLogo(rectDef_t *rect, float scale, vec4_t color) {
line 1033
;1032:  int i;
;1033:  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1034
;1034:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $738
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $738
line 1035
;1035:  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1037
;1036:
;1037:		if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $741
line 1038
;1038:      uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 16
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 1039
;1039:      uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 24
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 32
INDIRI4
ASGNI4
line 1040
;1040:      uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 36
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 1041
;1041:		}
LABELV $741
line 1043
;1042:
;1043:  	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1044
;1044:    trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1045
;1045:  }
LABELV $738
line 1046
;1046:}
LABELV $737
endproc UI_DrawClanLogo 48 20
proc UI_DrawClanCinematic 32 24
line 1048
;1047:
;1048:static void UI_DrawClanCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1050
;1049:  int i;
;1050:  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1051
;1051:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $762
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $762
line 1053
;1052:
;1053:		if (uiInfo.teamList[i].cinematic >= -2) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
CNSTI4 -2
LTI4 $765
line 1054
;1054:			if (uiInfo.teamList[i].cinematic == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $769
line 1055
;1055:				uiInfo.teamList[i].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.teamList[i].imageName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRLP4 16
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 28
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+14152+52
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1056
;1056:			}
LABELV $769
line 1057
;1057:			if (uiInfo.teamList[i].cinematic >= 0) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
CNSTI4 0
LTI4 $778
line 1058
;1058:			  trap_CIN_RunCinematic(uiInfo.teamList[i].cinematic);
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1059
;1059:				trap_CIN_SetExtents(uiInfo.teamList[i].cinematic, rect->x, rect->y, rect->w, rect->h);
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1060
;1060:	 			trap_CIN_DrawCinematic(uiInfo.teamList[i].cinematic);
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1061
;1061:			} else {
ADDRGP4 $766
JUMPV
LABELV $778
line 1062
;1062:			  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1063
;1063:				UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1064
;1064:				trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1065
;1065:				uiInfo.teamList[i].cinematic = -2;
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
CNSTI4 -2
ASGNI4
line 1066
;1066:			}
line 1067
;1067:		} else {
ADDRGP4 $766
JUMPV
LABELV $765
line 1068
;1068:	  	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1069
;1069:			UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1070
;1070:			trap_R_SetColor(NULL);
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1071
;1071:		}
LABELV $766
line 1072
;1072:	}
LABELV $762
line 1074
;1073:
;1074:}
LABELV $761
endproc UI_DrawClanCinematic 32 24
proc UI_DrawPreviewCinematic 16 24
line 1076
;1075:
;1076:static void UI_DrawPreviewCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1077
;1077:	if (uiInfo.previewMovie > -2) {
ADDRGP4 uiInfo+36244
INDIRI4
CNSTI4 -2
LEI4 $795
line 1078
;1078:		uiInfo.previewMovie = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.movieList[uiInfo.movieIndex]), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRGP4 uiInfo+36240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+35212
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 8
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+36244
ADDRLP4 8
INDIRI4
ASGNI4
line 1079
;1079:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+36244
INDIRI4
CNSTI4 0
LTI4 $801
line 1080
;1080:		  trap_CIN_RunCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+36244
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1081
;1081:			trap_CIN_SetExtents(uiInfo.previewMovie, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+36244
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1082
;1082: 			trap_CIN_DrawCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+36244
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1083
;1083:		} else {
ADDRGP4 $802
JUMPV
LABELV $801
line 1084
;1084:			uiInfo.previewMovie = -2;
ADDRGP4 uiInfo+36244
CNSTI4 -2
ASGNI4
line 1085
;1085:		}
LABELV $802
line 1086
;1086:	} 
LABELV $795
line 1088
;1087:
;1088:}
LABELV $794
endproc UI_DrawPreviewCinematic 16 24
proc UI_DrawSkill 20 36
line 1090
;1089:
;1090:static void UI_DrawSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1092
;1091:  int i;
;1092:	i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $809
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1093
;1093:  if (i < 1 || i > numSkillLevels) {
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $812
ADDRLP4 0
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $810
LABELV $812
line 1094
;1094:    i = 1;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 1095
;1095:  }
LABELV $810
line 1096
;1096:  Text_Paint(rect->x, rect->y, scale, color, (char *)UI_GetStripEdString("INGAMETEXT", (char *)skillLevels[i-1]),0, 0, textStyle, iMenuFont);
ADDRGP4 $374
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1097
;1097:}
LABELV $808
endproc UI_DrawSkill 20 36
proc UI_DrawGenericNum 268 36
line 1101
;1098:
;1099:
;1100:static void UI_DrawGenericNum(rectDef_t *rect, float scale, vec4_t color, int textStyle, int val, int min, int max, int type,int iMenuFont) 
;1101:{
line 1105
;1102:	int i;
;1103:	char s[256];
;1104:
;1105:	i = val;
ADDRLP4 0
ADDRFP4 16
INDIRI4
ASGNI4
line 1106
;1106:	if (i < min || i > max) 
ADDRLP4 0
INDIRI4
ADDRFP4 20
INDIRI4
LTI4 $817
ADDRLP4 0
INDIRI4
ADDRFP4 24
INDIRI4
LEI4 $815
LABELV $817
line 1107
;1107:	{
line 1108
;1108:		i = min;
ADDRLP4 0
ADDRFP4 20
INDIRI4
ASGNI4
line 1109
;1109:	}
LABELV $815
line 1111
;1110:
;1111:	Com_sprintf(s, sizeof(s), "%i\0", val);
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $818
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 1112
;1112:	Text_Paint(rect->x, rect->y, scale, color, s,0, 0, textStyle, iMenuFont);
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
INDIRF4
ARGF4
ADDRLP4 264
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 32
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1113
;1113:}
LABELV $814
endproc UI_DrawGenericNum 268 36
proc UI_DrawForceMastery 20 36
line 1116
;1114:
;1115:static void UI_DrawForceMastery(rectDef_t *rect, float scale, vec4_t color, int textStyle, int val, int min, int max, int iMenuFont)
;1116:{
line 1120
;1117:	int i;
;1118:	char *s;
;1119:
;1120:	i = val;
ADDRLP4 0
ADDRFP4 16
INDIRI4
ASGNI4
line 1121
;1121:	if (i < min || i > max) 
ADDRLP4 0
INDIRI4
ADDRFP4 20
INDIRI4
LTI4 $822
ADDRLP4 0
INDIRI4
ADDRFP4 24
INDIRI4
LEI4 $820
LABELV $822
line 1122
;1122:	{
line 1123
;1123:		i = min;
ADDRLP4 0
ADDRFP4 20
INDIRI4
ASGNI4
line 1124
;1124:	}
LABELV $820
line 1126
;1125:
;1126:	s = (char *)UI_GetStripEdString("INGAMETEXT", forceMasteryLevels[val]);
ADDRGP4 $374
ARGP4
ADDRFP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forceMasteryLevels
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 1127
;1127:	Text_Paint(rect->x, rect->y, scale, color, s, 0, 0, textStyle, iMenuFont);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1128
;1128:}
LABELV $819
endproc UI_DrawForceMastery 20 36
proc UI_DrawSkinColor 272 36
line 1132
;1129:
;1130:
;1131:static void UI_DrawSkinColor(rectDef_t *rect, float scale, vec4_t color, int textStyle, int val, int min, int max, int iMenuFont)
;1132:{
line 1136
;1133:	int i;
;1134:	char s[256];
;1135:
;1136:	i = val;
ADDRLP4 0
ADDRFP4 16
INDIRI4
ASGNI4
line 1137
;1137:	if (i < min || i > max) 
ADDRLP4 0
INDIRI4
ADDRFP4 20
INDIRI4
LTI4 $826
ADDRLP4 0
INDIRI4
ADDRFP4 24
INDIRI4
LEI4 $824
LABELV $826
line 1138
;1138:	{
line 1139
;1139:		i = min;
ADDRLP4 0
ADDRFP4 20
INDIRI4
ASGNI4
line 1140
;1140:	}
LABELV $824
line 1142
;1141:
;1142:	switch(val)
ADDRLP4 264
ADDRFP4 16
INDIRI4
ASGNI4
ADDRLP4 264
INDIRI4
CNSTI4 1
EQI4 $829
ADDRLP4 264
INDIRI4
CNSTI4 2
EQI4 $831
ADDRGP4 $827
JUMPV
line 1143
;1143:	{
LABELV $829
line 1145
;1144:	case TEAM_RED:
;1145:		Com_sprintf(s, sizeof(s), "Red\0");
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $830
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1146
;1146:		break;
ADDRGP4 $828
JUMPV
LABELV $831
line 1148
;1147:	case TEAM_BLUE:
;1148:		Com_sprintf(s, sizeof(s), "Blue\0");
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $832
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1149
;1149:		break;
ADDRGP4 $828
JUMPV
LABELV $827
line 1151
;1150:	default:
;1151:		Com_sprintf(s, sizeof(s), "Default\0");
ADDRLP4 4
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $833
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1152
;1152:		break;
LABELV $828
line 1155
;1153:	}
;1154:
;1155:	Text_Paint(rect->x, rect->y, scale, color, s,0, 0, textStyle, iMenuFont);
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
INDIRF4
ARGF4
ADDRLP4 268
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1156
;1156:}
LABELV $823
endproc UI_DrawSkinColor 272 36
proc UI_DrawForceSide 1312 36
line 1159
;1157:
;1158:static void UI_DrawForceSide(rectDef_t *rect, float scale, vec4_t color, int textStyle, int val, int min, int max, int iMenuFont)
;1159:{
line 1166
;1160:	int i;
;1161:	char s[256];
;1162:	menuDef_t *menu;
;1163:	
;1164:	char info[MAX_INFO_VALUE];
;1165:
;1166:	i = val;
ADDRLP4 1028
ADDRFP4 16
INDIRI4
ASGNI4
line 1167
;1167:	if (i < min || i > max) 
ADDRLP4 1028
INDIRI4
ADDRFP4 20
INDIRI4
LTI4 $837
ADDRLP4 1028
INDIRI4
ADDRFP4 24
INDIRI4
LEI4 $835
LABELV $837
line 1168
;1168:	{
line 1169
;1169:		i = min;
ADDRLP4 1028
ADDRFP4 20
INDIRI4
ASGNI4
line 1170
;1170:	}
LABELV $835
line 1172
;1171:
;1172:	info[0] = '\0';
ADDRLP4 4
CNSTI1 0
ASGNI1
line 1173
;1173:	trap_GetConfigString(CS_SERVERINFO, info, sizeof(info));
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1175
;1174:
;1175:	if (atoi( Info_ValueForKey( info, "g_forceBasedTeams" ) ))
ADDRLP4 4
ARGP4
ADDRGP4 $840
ARGP4
ADDRLP4 1292
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1292
INDIRP4
ARGP4
ADDRLP4 1296
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1296
INDIRI4
CNSTI4 0
EQI4 $838
line 1176
;1176:	{
line 1177
;1177:		switch((int)(trap_Cvar_VariableValue("ui_myteam")))
ADDRGP4 $843
ARGP4
ADDRLP4 1304
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1300
ADDRLP4 1304
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 1300
INDIRI4
CNSTI4 1
EQI4 $845
ADDRLP4 1300
INDIRI4
CNSTI4 2
EQI4 $846
ADDRGP4 $842
JUMPV
line 1178
;1178:		{
LABELV $845
line 1180
;1179:		case TEAM_RED:
;1180:			uiForceSide = FORCE_DARKSIDE;
ADDRGP4 uiForceSide
CNSTI4 2
ASGNI4
line 1181
;1181:			color[0] = 0.2;
ADDRFP4 8
INDIRP4
CNSTF4 1045220557
ASGNF4
line 1182
;1182:			color[1] = 0.2;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1045220557
ASGNF4
line 1183
;1183:			color[2] = 0.2;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1045220557
ASGNF4
line 1184
;1184:			break;
ADDRGP4 $842
JUMPV
LABELV $846
line 1186
;1185:		case TEAM_BLUE:
;1186:			uiForceSide = FORCE_LIGHTSIDE;
ADDRGP4 uiForceSide
CNSTI4 1
ASGNI4
line 1187
;1187:			color[0] = 0.2;
ADDRFP4 8
INDIRP4
CNSTF4 1045220557
ASGNF4
line 1188
;1188:			color[1] = 0.2;
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1045220557
ASGNF4
line 1189
;1189:			color[2] = 0.2;
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1045220557
ASGNF4
line 1190
;1190:			break;
line 1192
;1191:		default:
;1192:			break;
LABELV $842
line 1194
;1193:		}
;1194:	}
LABELV $838
line 1196
;1195:
;1196:	if (val == FORCE_LIGHTSIDE)
ADDRFP4 16
INDIRI4
CNSTI4 1
NEI4 $847
line 1197
;1197:	{
line 1198
;1198:		Com_sprintf(s, sizeof(s), "Light\0");
ADDRLP4 1032
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $849
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1199
;1199:		menu = Menus_FindByName("forcealloc");
ADDRGP4 $850
ARGP4
ADDRLP4 1300
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1300
INDIRP4
ASGNP4
line 1200
;1200:		if (menu)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $851
line 1201
;1201:		{
line 1202
;1202:			Menu_ShowItemByName(menu, "lightpowers", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $853
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1203
;1203:			Menu_ShowItemByName(menu, "darkpowers", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $854
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1204
;1204:			Menu_ShowItemByName(menu, "darkpowers_team", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $855
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1206
;1205:
;1206:			Menu_ShowItemByName(menu, "lightpowers_team", qtrue);//(ui_gameType.integer >= GT_TEAM));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $856
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1208
;1207:
;1208:		}
LABELV $851
line 1209
;1209:		menu = Menus_FindByName("ingame_playerforce");
ADDRGP4 $857
ARGP4
ADDRLP4 1304
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1304
INDIRP4
ASGNP4
line 1210
;1210:		if (menu)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $848
line 1211
;1211:		{
line 1212
;1212:			Menu_ShowItemByName(menu, "lightpowers", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $853
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1213
;1213:			Menu_ShowItemByName(menu, "darkpowers", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $854
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1214
;1214:			Menu_ShowItemByName(menu, "darkpowers_team", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $855
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1216
;1215:
;1216:			Menu_ShowItemByName(menu, "lightpowers_team", qtrue);//(ui_gameType.integer >= GT_TEAM));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $856
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1217
;1217:		}
line 1218
;1218:	}
ADDRGP4 $848
JUMPV
LABELV $847
line 1220
;1219:	else
;1220:	{
line 1221
;1221:		Com_sprintf(s, sizeof(s), "Dark\0");
ADDRLP4 1032
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $860
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 1223
;1222:
;1223:		menu = Menus_FindByName("forcealloc");
ADDRGP4 $850
ARGP4
ADDRLP4 1300
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1300
INDIRP4
ASGNP4
line 1224
;1224:		if (menu)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $861
line 1225
;1225:		{
line 1226
;1226:			Menu_ShowItemByName(menu, "lightpowers", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $853
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1227
;1227:			Menu_ShowItemByName(menu, "lightpowers_team", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $856
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1228
;1228:			Menu_ShowItemByName(menu, "darkpowers", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $854
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1230
;1229:
;1230:			Menu_ShowItemByName(menu, "darkpowers_team", qtrue);//(ui_gameType.integer >= GT_TEAM));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $855
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1231
;1231:		}
LABELV $861
line 1232
;1232:		menu = Menus_FindByName("ingame_playerforce");
ADDRGP4 $857
ARGP4
ADDRLP4 1304
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 1304
INDIRP4
ASGNP4
line 1233
;1233:		if (menu)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $863
line 1234
;1234:		{
line 1235
;1235:			Menu_ShowItemByName(menu, "lightpowers", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $853
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1236
;1236:			Menu_ShowItemByName(menu, "lightpowers_team", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $856
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1237
;1237:			Menu_ShowItemByName(menu, "darkpowers", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $854
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1239
;1238:
;1239:			Menu_ShowItemByName(menu, "darkpowers_team", qtrue);//(ui_gameType.integer >= GT_TEAM));
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $855
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1240
;1240:		}
LABELV $863
line 1241
;1241:	}
LABELV $848
line 1243
;1242:
;1243:	Text_Paint(rect->x, rect->y, scale, color, s,0, 0, textStyle, iMenuFont);
ADDRLP4 1300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1300
INDIRP4
INDIRF4
ARGF4
ADDRLP4 1300
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 1032
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 28
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1244
;1244:}
LABELV $834
endproc UI_DrawForceSide 1312 36
proc UI_DrawTeamName 32 36
line 1247
;1245:
;1246:
;1247:static void UI_DrawTeamName(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int textStyle, int iMenuFont) {
line 1249
;1248:  int i;
;1249:  i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $869
ADDRLP4 4
ADDRGP4 $866
ASGNP4
ADDRGP4 $870
JUMPV
LABELV $869
ADDRLP4 4
ADDRGP4 $867
ASGNP4
LABELV $870
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1250
;1250:  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $871
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $871
line 1251
;1251:    Text_Paint(rect->x, rect->y, scale, color, va("%s: %s", (blue) ? "Blue" : "Red", uiInfo.teamList[i].teamName),0, 0, textStyle, iMenuFont);
ADDRGP4 $874
ARGP4
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $879
ADDRLP4 20
ADDRGP4 $875
ASGNP4
ADDRGP4 $880
JUMPV
LABELV $879
ADDRLP4 20
ADDRGP4 $876
ASGNP4
LABELV $880
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1252
;1252:  }
LABELV $871
line 1253
;1253:}
LABELV $865
endproc UI_DrawTeamName 32 36
proc UI_DrawTeamMember 56 36
line 1256
;1254:
;1255:static void UI_DrawTeamMember(rectDef_t *rect, float scale, vec4_t color, qboolean blue, int num, int textStyle, int iMenuFont) 
;1256:{
line 1260
;1257:	// 0 - None
;1258:	// 1 - Human
;1259:	// 2..NumCharacters - Bot
;1260:	int value = trap_Cvar_VariableValue(va(blue ? "ui_blueteam%i" : "ui_redteam%i", num));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $885
ADDRLP4 32
ADDRGP4 $882
ASGNP4
ADDRGP4 $886
JUMPV
LABELV $885
ADDRLP4 32
ADDRGP4 $883
ASGNP4
LABELV $886
ADDRLP4 32
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 40
INDIRF4
CVFI4 4
ASGNI4
line 1262
;1261:	const char *text;
;1262:	int maxcl = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $887
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 28
ADDRLP4 44
INDIRF4
CVFI4 4
ASGNI4
line 1264
;1263:	vec4_t finalColor;
;1264:	int numval = num;
ADDRLP4 20
ADDRFP4 16
INDIRI4
ASGNI4
line 1266
;1265:
;1266:	numval *= 2;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 1268
;1267:
;1268:	if (blue)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $888
line 1269
;1269:	{
line 1270
;1270:		numval -= 1;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1271
;1271:	}
LABELV $888
line 1273
;1272:
;1273:	finalColor[0] = color[0];
ADDRLP4 0
ADDRFP4 8
INDIRP4
INDIRF4
ASGNF4
line 1274
;1274:	finalColor[1] = color[1];
ADDRLP4 0+4
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ASGNF4
line 1275
;1275:	finalColor[2] = color[2];
ADDRLP4 0+8
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ASGNF4
line 1276
;1276:	finalColor[3] = color[3];
ADDRLP4 0+12
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ASGNF4
line 1278
;1277:
;1278:	if (numval > maxcl)
ADDRLP4 20
INDIRI4
ADDRLP4 28
INDIRI4
LEI4 $893
line 1279
;1279:	{
line 1280
;1280:		finalColor[0] *= 0.2;
ADDRLP4 0
CNSTF4 1045220557
ADDRLP4 0
INDIRF4
MULF4
ASGNF4
line 1281
;1281:		finalColor[1] *= 0.2;
ADDRLP4 0+4
CNSTF4 1045220557
ADDRLP4 0+4
INDIRF4
MULF4
ASGNF4
line 1282
;1282:		finalColor[2] *= 0.2;
ADDRLP4 0+8
CNSTF4 1045220557
ADDRLP4 0+8
INDIRF4
MULF4
ASGNF4
line 1284
;1283:
;1284:		value = -1;
ADDRLP4 16
CNSTI4 -1
ASGNI4
line 1285
;1285:	}
LABELV $893
line 1287
;1286:
;1287:	if (value <= 1) {
ADDRLP4 16
INDIRI4
CNSTI4 1
GTI4 $897
line 1288
;1288:		if (value == -1)
ADDRLP4 16
INDIRI4
CNSTI4 -1
NEI4 $899
line 1289
;1289:		{
line 1290
;1290:			text = "Closed";
ADDRLP4 24
ADDRGP4 $901
ASGNP4
line 1291
;1291:		}
ADDRGP4 $898
JUMPV
LABELV $899
line 1293
;1292:		else
;1293:		{
line 1294
;1294:			text = "Human";
ADDRLP4 24
ADDRGP4 $902
ASGNP4
line 1295
;1295:		}
line 1296
;1296:	} else {
ADDRGP4 $898
JUMPV
LABELV $897
line 1297
;1297:		value -= 2;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1305
;1298:
;1299:		/*if (ui_actualNetGameType.integer >= GT_TEAM) {
;1300:			if (value >= uiInfo.characterCount) {
;1301:				value = 0;
;1302:			}
;1303:			text = uiInfo.characterList[value].name;
;1304:		} else {*/
;1305:			if (value >= UI_GetNumBots()) {
ADDRLP4 48
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRLP4 48
INDIRI4
LTI4 $903
line 1306
;1306:				value = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 1307
;1307:			}
LABELV $903
line 1308
;1308:			text = UI_GetBotNameByNumber(value);
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 24
ADDRLP4 52
INDIRP4
ASGNP4
line 1310
;1309:		//}
;1310:	}
LABELV $898
line 1312
;1311:
;1312:  Text_Paint(rect->x, rect->y, scale, finalColor, text, 0, 0, textStyle, iMenuFont);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1313
;1313:}
LABELV $881
endproc UI_DrawTeamMember 56 36
proc UI_DrawEffects 4 20
line 1316
;1314:
;1315:static void UI_DrawEffects(rectDef_t *rect, float scale, vec4_t color) 
;1316:{
line 1317
;1317:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiSaberColorShaders[uiInfo.effectsColor]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+95060
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiSaberColorShaders
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1318
;1318:}
LABELV $905
endproc UI_DrawEffects 4 20
proc UI_DrawMapPreview 20 20
line 1320
;1319:
;1320:static void UI_DrawMapPreview(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1321
;1321:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $911
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $912
JUMPV
LABELV $911
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $912
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1322
;1322:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $916
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LEI4 $913
LABELV $916
line 1323
;1323:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $917
line 1324
;1324:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1325
;1325:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $920
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1326
;1326:		} else {
ADDRGP4 $918
JUMPV
LABELV $917
line 1327
;1327:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1328
;1328:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $922
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1329
;1329:		}
LABELV $918
line 1330
;1330:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1331
;1331:	}
LABELV $913
line 1333
;1332:
;1333:	if (uiInfo.mapList[map].levelShot == -1) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $923
line 1334
;1334:		uiInfo.mapList[map].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[map].imageName);
ADDRLP4 12
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1335
;1335:	}
LABELV $923
line 1337
;1336:
;1337:	if (uiInfo.mapList[map].levelShot > 0) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
INDIRI4
CNSTI4 0
LEI4 $931
line 1338
;1338:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.mapList[map].levelShot);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1339
;1339:	} else {
ADDRGP4 $932
JUMPV
LABELV $931
line 1340
;1340:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $937
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1341
;1341:	}
LABELV $932
line 1342
;1342:}						 
LABELV $907
endproc UI_DrawMapPreview 20 20
proc UI_DrawMapTimeToBeat 20 36
line 1345
;1343:
;1344:
;1345:static void UI_DrawMapTimeToBeat(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1347
;1346:	int minutes, seconds, time;
;1347:	if (ui_currentMap.integer < 0 || ui_currentMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentMap+12
INDIRI4
CNSTI4 0
LTI4 $944
ADDRGP4 ui_currentMap+12
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LEI4 $939
LABELV $944
line 1348
;1348:		ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1349
;1349:		trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $922
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1350
;1350:	}
LABELV $939
line 1352
;1351:
;1352:	time = uiInfo.mapList[ui_currentMap.integer].timeToBeat[uiInfo.gameTypes[ui_gameType.integer].gtEnum];
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+28
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1354
;1353:
;1354:	minutes = time / 60;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 60
DIVI4
ASGNI4
line 1355
;1355:	seconds = time % 60;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 60
MODI4
ASGNI4
line 1357
;1356:
;1357:  Text_Paint(rect->x, rect->y, scale, color, va("%02i:%02i", minutes, seconds), 0, 0, textStyle, iMenuFont);
ADDRGP4 $952
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1358
;1358:}
LABELV $938
endproc UI_DrawMapTimeToBeat 20 36
proc UI_DrawMapCinematic 28 24
line 1362
;1359:
;1360:
;1361:
;1362:static void UI_DrawMapCinematic(rectDef_t *rect, float scale, vec4_t color, qboolean net) {
line 1364
;1363:
;1364:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer; 
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $957
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $958
JUMPV
LABELV $957
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $958
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1365
;1365:	if (map < 0 || map > uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $962
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LEI4 $959
LABELV $962
line 1366
;1366:		if (net) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $963
line 1367
;1367:			ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1368
;1368:			trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $920
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1369
;1369:		} else {
ADDRGP4 $964
JUMPV
LABELV $963
line 1370
;1370:			ui_currentMap.integer = 0;
ADDRGP4 ui_currentMap+12
CNSTI4 0
ASGNI4
line 1371
;1371:			trap_Cvar_Set("ui_currentMap", "0");
ADDRGP4 $922
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1372
;1372:		}
LABELV $964
line 1373
;1373:		map = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1374
;1374:	}
LABELV $959
line 1376
;1375:
;1376:	if (uiInfo.mapList[map].cinematic >= -1) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
CNSTI4 -1
LTI4 $967
line 1377
;1377:		if (uiInfo.mapList[map].cinematic == -1) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $971
line 1378
;1378:			uiInfo.mapList[map].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[map].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRLP4 12
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 24
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+24
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1379
;1379:		}
LABELV $971
line 1380
;1380:		if (uiInfo.mapList[map].cinematic >= 0) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $979
line 1381
;1381:		  trap_CIN_RunCinematic(uiInfo.mapList[map].cinematic);
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1382
;1382:		  trap_CIN_SetExtents(uiInfo.mapList[map].cinematic, rect->x, rect->y, rect->w, rect->h);
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1383
;1383: 			trap_CIN_DrawCinematic(uiInfo.mapList[map].cinematic);
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1384
;1384:		} else {
ADDRGP4 $968
JUMPV
LABELV $979
line 1385
;1385:			uiInfo.mapList[map].cinematic = -2;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
CNSTI4 -2
ASGNI4
line 1386
;1386:		}
line 1387
;1387:	} else {
ADDRGP4 $968
JUMPV
LABELV $967
line 1388
;1388:		UI_DrawMapPreview(rect, scale, color, net);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 1389
;1389:	}
LABELV $968
line 1390
;1390:}
LABELV $953
endproc UI_DrawMapCinematic 28 24
export UpdateForceStatus
proc UpdateForceStatus 1052 12
line 1394
;1391:
;1392:
;1393:void UpdateForceStatus()
;1394:{
line 1411
;1395:	menuDef_t *menu;
;1396:
;1397:	// Currently we don't make a distinction between those that wish to play Jedi of lower than maximum skill.
;1398:/*	if (ui_forcePowerDisable.integer)
;1399:	{
;1400:		uiForceRank = 0;
;1401:		uiForceAvailable = 0;
;1402:		uiForceUsed = 0;
;1403:	}
;1404:	else
;1405:	{
;1406:		uiForceRank = uiMaxRank;
;1407:		uiForceUsed = 0;
;1408:		uiForceAvailable = forceMasteryPoints[uiForceRank];
;1409:	}
;1410:*/
;1411:	menu = Menus_FindByName("ingame_player");
ADDRGP4 $992
ARGP4
ADDRLP4 4
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 1412
;1412:	if (menu)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $993
line 1413
;1413:	{
line 1416
;1414:		char	info[MAX_INFO_STRING];
;1415:
;1416:		if (uiForcePowersRank[FP_SABERATTACK] > 0)
ADDRGP4 uiForcePowersRank+60
INDIRI4
CNSTI4 0
LEI4 $995
line 1417
;1417:		{	// Show lightsaber stuff.
line 1418
;1418:			Menu_ShowItemByName(menu, "nosaber", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $998
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1419
;1419:			Menu_ShowItemByName(menu, "yessaber", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $999
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1420
;1420:		}
ADDRGP4 $996
JUMPV
LABELV $995
line 1422
;1421:		else
;1422:		{
line 1423
;1423:			Menu_ShowItemByName(menu, "nosaber", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $998
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1424
;1424:			Menu_ShowItemByName(menu, "yessaber", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $999
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1425
;1425:		}
LABELV $996
line 1427
;1426:	
;1427:		trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) );
CNSTI4 0
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 1431
;1428:
;1429:		//already have serverinfo at this point for stuff below. Don't bother trying to use ui_forcePowerDisable.
;1430:		//if (ui_forcePowerDisable.integer)
;1431:		if (atoi(Info_ValueForKey(info, "g_forcePowerDisable")))
ADDRLP4 8
ARGP4
ADDRGP4 $1002
ARGP4
ADDRLP4 1032
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1032
INDIRP4
ARGP4
ADDRLP4 1036
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
EQI4 $1000
line 1432
;1432:		{	// No force stuff
line 1433
;1433:			Menu_ShowItemByName(menu, "noforce", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1003
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1434
;1434:			Menu_ShowItemByName(menu, "yesforce", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1004
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1436
;1435:			// We don't want the saber explanation to say "configure saber attack 1" since we can't.
;1436:			Menu_ShowItemByName(menu, "sabernoneconfigme", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1005
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1437
;1437:		}
ADDRGP4 $1001
JUMPV
LABELV $1000
line 1439
;1438:		else
;1439:		{
line 1440
;1440:			Menu_ShowItemByName(menu, "noforce", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1003
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1441
;1441:			Menu_ShowItemByName(menu, "yesforce", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1004
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1442
;1442:		}
LABELV $1001
line 1445
;1443:
;1444:		// The leftmost button should be "apply" unless you are in spectator, where you can join any team.
;1445:		if ((int)(trap_Cvar_VariableValue("ui_myteam")) != TEAM_SPECTATOR)
ADDRGP4 $843
ARGP4
ADDRLP4 1040
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1040
INDIRF4
CVFI4 4
CNSTI4 3
EQI4 $1006
line 1446
;1446:		{
line 1447
;1447:			Menu_ShowItemByName(menu, "playerapply", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1008
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1448
;1448:			Menu_ShowItemByName(menu, "playerforcejoin", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1009
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1449
;1449:			Menu_ShowItemByName(menu, "playerforcered", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1450
;1450:			Menu_ShowItemByName(menu, "playerforceblue", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1451
;1451:			Menu_ShowItemByName(menu, "playerforcespectate", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1012
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1452
;1452:		}
ADDRGP4 $1007
JUMPV
LABELV $1006
line 1454
;1453:		else
;1454:		{
line 1456
;1455:			// Set or reset buttons based on choices
;1456:			if (atoi(Info_ValueForKey(info, "g_gametype")) >= GT_TEAM)
ADDRLP4 8
ARGP4
ADDRGP4 $1015
ARGP4
ADDRLP4 1044
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1044
INDIRP4
ARGP4
ADDRLP4 1048
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 5
LTI4 $1013
line 1457
;1457:			{	// This is a team-based game.
line 1458
;1458:				Menu_ShowItemByName(menu, "playerforcespectate", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1012
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1461
;1459:				
;1460:				// This is disabled, always show both sides from spectator.
;1461:				if ( 0 && atoi(Info_ValueForKey(info, "g_forceBasedTeams")))
ADDRGP4 $1016
JUMPV
line 1462
;1462:				{	// Show red or blue based on what side is chosen.
line 1463
;1463:					if (uiForceSide==FORCE_LIGHTSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 1
NEI4 $1018
line 1464
;1464:					{
line 1465
;1465:						Menu_ShowItemByName(menu, "playerforcered", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1466
;1466:						Menu_ShowItemByName(menu, "playerforceblue", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1467
;1467:					}
ADDRGP4 $1014
JUMPV
LABELV $1018
line 1468
;1468:					else if (uiForceSide==FORCE_DARKSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 2
NEI4 $1020
line 1469
;1469:					{
line 1470
;1470:						Menu_ShowItemByName(menu, "playerforcered", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1471
;1471:						Menu_ShowItemByName(menu, "playerforceblue", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1472
;1472:					}
ADDRGP4 $1014
JUMPV
LABELV $1020
line 1474
;1473:					else
;1474:					{
line 1475
;1475:						Menu_ShowItemByName(menu, "playerforcered", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1476
;1476:						Menu_ShowItemByName(menu, "playerforceblue", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1477
;1477:					}
line 1478
;1478:				}
ADDRGP4 $1014
JUMPV
LABELV $1016
line 1480
;1479:				else
;1480:				{
line 1481
;1481:					Menu_ShowItemByName(menu, "playerforcered", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1482
;1482:					Menu_ShowItemByName(menu, "playerforceblue", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1483
;1483:				}
line 1484
;1484:			}
ADDRGP4 $1014
JUMPV
LABELV $1013
line 1486
;1485:			else
;1486:			{
line 1487
;1487:				Menu_ShowItemByName(menu, "playerforcered", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1010
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1488
;1488:				Menu_ShowItemByName(menu, "playerforceblue", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1011
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1489
;1489:			}
LABELV $1014
line 1491
;1490:
;1491:			Menu_ShowItemByName(menu, "playerapply", qfalse);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1008
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1492
;1492:			Menu_ShowItemByName(menu, "playerforcejoin", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1009
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1493
;1493:			Menu_ShowItemByName(menu, "playerforcespectate", qtrue);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $1012
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_ShowItemByName
CALLV
pop
line 1494
;1494:		}
LABELV $1007
line 1495
;1495:	}
LABELV $993
line 1499
;1496:
;1497:
;1498:	// Take the current team and force a skin color based on it.
;1499:	switch((int)(trap_Cvar_VariableValue("ui_myteam")))
ADDRGP4 $843
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 1
EQI4 $1025
ADDRLP4 8
INDIRI4
CNSTI4 2
EQI4 $1027
ADDRGP4 $1022
JUMPV
line 1500
;1500:	{
LABELV $1025
line 1502
;1501:	case TEAM_RED:
;1502:		uiSkinColor = TEAM_RED;
ADDRGP4 uiSkinColor
CNSTI4 1
ASGNI4
line 1503
;1503:		uiInfo.effectsColor = SABER_RED;
ADDRGP4 uiInfo+95060
CNSTI4 0
ASGNI4
line 1504
;1504:		break;
ADDRGP4 $1023
JUMPV
LABELV $1027
line 1506
;1505:	case TEAM_BLUE:
;1506:		uiSkinColor = TEAM_BLUE;
ADDRGP4 uiSkinColor
CNSTI4 2
ASGNI4
line 1507
;1507:		uiInfo.effectsColor = SABER_BLUE;
ADDRGP4 uiInfo+95060
CNSTI4 4
ASGNI4
line 1508
;1508:		break;
ADDRGP4 $1023
JUMPV
LABELV $1022
line 1510
;1509:	default:
;1510:		uiSkinColor = TEAM_FREE;
ADDRGP4 uiSkinColor
CNSTI4 0
ASGNI4
line 1511
;1511:		break;
LABELV $1023
line 1513
;1512:	}
;1513:}
LABELV $991
endproc UpdateForceStatus 1052 12
data
align 4
LABELV updateModel
byte 4 1
align 4
LABELV q3Model
byte 4 0
code
proc UI_DrawNetSource 8 36
line 1564
;1514:
;1515:
;1516:
;1517:static qboolean updateModel = qtrue;
;1518:static qboolean q3Model = qfalse;
;1519:/*
;1520:
;1521:static void UI_DrawPlayerModel(rectDef_t *rect) {
;1522:  static playerInfo_t info;
;1523:  char model[MAX_QPATH];
;1524:  char team[256];
;1525:	char head[256];
;1526:	vec3_t	viewangles;
;1527:	vec3_t	moveangles;
;1528:
;1529:	  if (trap_Cvar_VariableValue("ui_Q3Model")) {
;1530:	  strcpy(model, UI_Cvar_VariableString("model"));
;1531:		strcpy(head, UI_Cvar_VariableString("headmodel"));
;1532:		if (!q3Model) {
;1533:			q3Model = qtrue;
;1534:			updateModel = qtrue;
;1535:		}
;1536:		team[0] = '\0';
;1537:	} else {
;1538:
;1539:		strcpy(team, UI_Cvar_VariableString("ui_teamName"));
;1540:		strcpy(model, UI_Cvar_VariableString("team_model"));
;1541:		strcpy(head, UI_Cvar_VariableString("team_headmodel"));
;1542:		if (q3Model) {
;1543:			q3Model = qfalse;
;1544:			updateModel = qtrue;
;1545:		}
;1546:	}
;1547:  if (updateModel) {
;1548:  	memset( &info, 0, sizeof(playerInfo_t) );
;1549:  	viewangles[YAW]   = 180 - 10;
;1550:  	viewangles[PITCH] = 0;
;1551:  	viewangles[ROLL]  = 0;
;1552:  	VectorClear( moveangles );
;1553:    UI_PlayerInfo_SetModel( &info, model, head, team);
;1554:    UI_PlayerInfo_SetInfo( &info, TORSO_WEAPONREADY3, TORSO_WEAPONREADY3, viewangles, vec3_origin, WP_BRYAR_PISTOL, qfalse );
;1555://		UI_RegisterClientModelname( &info, model, head, team);
;1556:    updateModel = qfalse;
;1557:  }
;1558:
;1559:  UI_DrawPlayer( rect->x, rect->y, rect->w, rect->h, &info, uiInfo.uiDC.realTime / 2);
;1560:
;1561:}
;1562:*/
;1563:static void UI_DrawNetSource(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) 
;1564:{
line 1565
;1565:	if (ui_netSource.integer < 0 || ui_netSource.integer > uiInfo.numGameTypes) 
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1035
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 uiInfo+17736
INDIRI4
LEI4 $1030
LABELV $1035
line 1566
;1566:	{
line 1567
;1567:		ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 1568
;1568:	}
LABELV $1030
line 1570
;1569:
;1570:	trap_SP_GetStringTextString("MENUS3_SOURCE", holdSPString, sizeof(holdSPString) );
ADDRGP4 $1037
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 1571
;1571:	Text_Paint(rect->x, rect->y, scale, color, va("%s %s",holdSPString,
ADDRGP4 $1038
ARGP4
ADDRGP4 holdSPString
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1573
;1572:		 netSources[ui_netSource.integer]), 0, 0, textStyle, iMenuFont);
;1573:}
LABELV $1029
endproc UI_DrawNetSource 8 36
proc UI_DrawNetMapPreview 8 20
line 1575
;1574:
;1575:static void UI_DrawNetMapPreview(rectDef_t *rect, float scale, vec4_t color) {
line 1577
;1576:
;1577:	if (uiInfo.serverStatus.currentServerPreview > 0) {
ADDRGP4 uiInfo+40604+10428
INDIRI4
CNSTI4 0
LEI4 $1041
line 1578
;1578:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.serverStatus.currentServerPreview);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+40604+10428
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1579
;1579:	} else {
ADDRGP4 $1042
JUMPV
LABELV $1041
line 1580
;1580:		UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, trap_R_RegisterShaderNoMip("menu/art/unknownmap"));
ADDRGP4 $937
ARGP4
ADDRLP4 0
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1581
;1581:	}
LABELV $1042
line 1582
;1582:}
LABELV $1040
endproc UI_DrawNetMapPreview 8 20
proc UI_DrawNetMapCinematic 4 20
line 1584
;1583:
;1584:static void UI_DrawNetMapCinematic(rectDef_t *rect, float scale, vec4_t color) {
line 1585
;1585:	if (ui_currentNetMap.integer < 0 || ui_currentNetMap.integer > uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $1053
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LEI4 $1048
LABELV $1053
line 1586
;1586:		ui_currentNetMap.integer = 0;
ADDRGP4 ui_currentNetMap+12
CNSTI4 0
ASGNI4
line 1587
;1587:		trap_Cvar_Set("ui_currentNetMap", "0");
ADDRGP4 $920
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1588
;1588:	}
LABELV $1048
line 1590
;1589:
;1590:	if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+40604+10432
INDIRI4
CNSTI4 0
LTI4 $1055
line 1591
;1591:	  trap_CIN_RunCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+40604+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 1592
;1592:	  trap_CIN_SetExtents(uiInfo.serverStatus.currentServerCinematic, rect->x, rect->y, rect->w, rect->h);
ADDRGP4 uiInfo+40604+10432
INDIRI4
ARGI4
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 1593
;1593: 	  trap_CIN_DrawCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+40604+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 1594
;1594:	} else {
ADDRGP4 $1056
JUMPV
LABELV $1055
line 1595
;1595:		UI_DrawNetMapPreview(rect, scale, color);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 1596
;1596:	}
LABELV $1056
line 1597
;1597:}
LABELV $1047
endproc UI_DrawNetMapCinematic 4 20
proc UI_DrawNetFilter 8 36
line 1602
;1598:
;1599:
;1600:
;1601:static void UI_DrawNetFilter(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) 
;1602:{
line 1603
;1603:	if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) 
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1070
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LEI4 $1066
LABELV $1070
line 1604
;1604:	{
line 1605
;1605:		ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 1606
;1606:	}
LABELV $1066
line 1608
;1607:
;1608:	trap_SP_GetStringTextString("MENUS3_GAME", holdSPString, sizeof(holdSPString));
ADDRGP4 $1072
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 1609
;1609:	Text_Paint(rect->x, rect->y, scale, color, va("%s %s",holdSPString,
ADDRGP4 $1038
ARGP4
ADDRGP4 holdSPString
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1611
;1610:		 serverFilters[ui_serverFilterType.integer].description), 0, 0, textStyle, iMenuFont);
;1611:}
LABELV $1065
endproc UI_DrawNetFilter 8 36
proc UI_DrawTier 20 36
line 1614
;1612:
;1613:
;1614:static void UI_DrawTier(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1616
;1615:  int i;
;1616:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $1075
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1617
;1617:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1079
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+33012
INDIRI4
LTI4 $1076
LABELV $1079
line 1618
;1618:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1619
;1619:  }
LABELV $1076
line 1620
;1620:  Text_Paint(rect->x, rect->y, scale, color, va("Tier: %s", uiInfo.tierList[i].tierName),0, 0, textStyle, iMenuFont);
ADDRGP4 $1080
ARGP4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+33016
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1621
;1621:}
LABELV $1074
endproc UI_DrawTier 20 36
proc UI_DrawTierMap 28 20
line 1623
;1622:
;1623:static void UI_DrawTierMap(rectDef_t *rect, int index) {
line 1625
;1624:  int i;
;1625:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $1075
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 1626
;1626:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1086
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+33012
INDIRI4
LTI4 $1083
LABELV $1086
line 1627
;1627:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1628
;1628:  }
LABELV $1083
line 1630
;1629:
;1630:	if (uiInfo.tierList[i].mapHandles[index] == -1) {
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+33016+28
ADDP4
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1087
line 1631
;1631:		uiInfo.tierList[i].mapHandles[index] = trap_R_RegisterShaderNoMip(va("levelshots/%s", uiInfo.tierList[i].maps[index]));
ADDRGP4 $1093
ARGP4
ADDRLP4 12
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 16
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+33016+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+33016+28
ADDP4
ADDP4
ADDRLP4 24
INDIRI4
ASGNI4
line 1632
;1632:	}
LABELV $1087
line 1634
;1633:												 
;1634:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.tierList[i].mapHandles[index]);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+33016+28
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1635
;1635:}
LABELV $1082
endproc UI_DrawTierMap 28 20
proc UI_EnglishMapName 8 8
line 1637
;1636:
;1637:static const char *UI_EnglishMapName(const char *map) {
line 1639
;1638:	int i;
;1639:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1102
JUMPV
LABELV $1099
line 1640
;1640:		if (Q_stricmp(map, uiInfo.mapList[i].mapLoadName) == 0) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1104
line 1641
;1641:			return uiInfo.mapList[i].mapName;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212
ADDP4
INDIRP4
RETP4
ADDRGP4 $1098
JUMPV
LABELV $1104
line 1643
;1642:		}
;1643:	}
LABELV $1100
line 1639
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1102
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LTI4 $1099
line 1644
;1644:	return "";
ADDRGP4 $170
RETP4
LABELV $1098
endproc UI_EnglishMapName 8 8
proc UI_DrawTierMapName 32 36
line 1647
;1645:}
;1646:
;1647:static void UI_DrawTierMapName(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1649
;1648:  int i, j;
;1649:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $1075
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1650
;1650:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1113
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+33012
INDIRI4
LTI4 $1110
LABELV $1113
line 1651
;1651:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1652
;1652:  }
LABELV $1110
line 1653
;1653:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $922
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1654
;1654:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1116
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1114
LABELV $1116
line 1655
;1655:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1656
;1656:	}
LABELV $1114
line 1658
;1657:
;1658:  Text_Paint(rect->x, rect->y, scale, color, UI_EnglishMapName(uiInfo.tierList[i].maps[j]), 0, 0, textStyle, iMenuFont);
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+33016+4
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_EnglishMapName
CALLP4
ASGNP4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
INDIRF4
ARGF4
ADDRLP4 28
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1659
;1659:}
LABELV $1109
endproc UI_DrawTierMapName 32 36
proc UI_DrawTierGameType 28 36
line 1661
;1660:
;1661:static void UI_DrawTierGameType(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1663
;1662:  int i, j;
;1663:	i = trap_Cvar_VariableValue( "ui_currentTier" );
ADDRGP4 $1075
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 1664
;1664:  if (i < 0 || i >= uiInfo.tierCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1123
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+33012
INDIRI4
LTI4 $1120
LABELV $1123
line 1665
;1665:    i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1666
;1666:  }
LABELV $1120
line 1667
;1667:	j = trap_Cvar_VariableValue("ui_currentMap");
ADDRGP4 $922
ARGP4
ADDRLP4 16
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 16
INDIRF4
CVFI4 4
ASGNI4
line 1668
;1668:	if (j < 0 || j > MAPS_PER_TIER) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $1126
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $1124
LABELV $1126
line 1669
;1669:		j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1670
;1670:	}
LABELV $1124
line 1672
;1671:
;1672:  Text_Paint(rect->x, rect->y, scale, color, uiInfo.gameTypes[uiInfo.tierList[i].gameTypes[j]].gameType , 0, 0, textStyle,iMenuFont);
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
INDIRF4
ARGF4
ADDRLP4 24
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 40
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+33016+16
ADDP4
ADDP4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1673
;1673:}
LABELV $1119
endproc UI_DrawTierGameType 28 36
proc UI_AIFromName 8 8
line 1676
;1674:
;1675:
;1676:static const char *UI_AIFromName(const char *name) {
line 1678
;1677:	int j;
;1678:	for (j = 0; j < uiInfo.aliasCount; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1134
JUMPV
LABELV $1131
line 1679
;1679:		if (Q_stricmp(uiInfo.aliasList[j].name, name) == 0) {
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+13380
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $1136
line 1680
;1680:			return uiInfo.aliasList[j].ai;
CNSTI4 12
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+13380+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $1130
JUMPV
LABELV $1136
line 1682
;1681:		}
;1682:	}
LABELV $1132
line 1678
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1134
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+13376
INDIRI4
LTI4 $1131
line 1683
;1683:	return "Kyle";
ADDRGP4 $1141
RETP4
LABELV $1130
endproc UI_AIFromName 8 8
proc UI_NextOpponent 24 8
line 1718
;1684:}
;1685:
;1686:
;1687:/*
;1688:static qboolean updateOpponentModel = qtrue;
;1689:static void UI_DrawOpponent(rectDef_t *rect) {
;1690:  static playerInfo_t info2;
;1691:  char model[MAX_QPATH];
;1692:  char headmodel[MAX_QPATH];
;1693:  char team[256];
;1694:	vec3_t	viewangles;
;1695:	vec3_t	moveangles;
;1696:  
;1697:	if (updateOpponentModel) {
;1698:		
;1699:		strcpy(model, UI_Cvar_VariableString("ui_opponentModel"));
;1700:	  strcpy(headmodel, UI_Cvar_VariableString("ui_opponentModel"));
;1701:		team[0] = '\0';
;1702:
;1703:  	memset( &info2, 0, sizeof(playerInfo_t) );
;1704:  	viewangles[YAW]   = 180 - 10;
;1705:  	viewangles[PITCH] = 0;
;1706:  	viewangles[ROLL]  = 0;
;1707:  	VectorClear( moveangles );
;1708:    UI_PlayerInfo_SetModel( &info2, model, headmodel, "");
;1709:    UI_PlayerInfo_SetInfo( &info2, TORSO_WEAPONREADY3, TORSO_WEAPONREADY3, viewangles, vec3_origin, WP_BRYAR_PISTOL, qfalse );
;1710:		UI_RegisterClientModelname( &info2, model, headmodel, team);
;1711:    updateOpponentModel = qfalse;
;1712:  }
;1713:
;1714:  UI_DrawPlayer( rect->x, rect->y, rect->w, rect->h, &info2, uiInfo.uiDC.realTime / 2);
;1715:
;1716:}
;1717:*/
;1718:static void UI_NextOpponent() {
line 1719
;1719:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1720
;1720:  int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1721
;1721:	i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1722
;1722:	if (i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $1144
line 1723
;1723:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1724
;1724:	}
LABELV $1144
line 1725
;1725:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1147
line 1726
;1726:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1727
;1727:		if ( i >= uiInfo.teamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $1149
line 1728
;1728:			i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1729
;1729:		}
LABELV $1149
line 1730
;1730:	}
LABELV $1147
line 1731
;1731: 	trap_Cvar_Set( "ui_opponentName", uiInfo.teamList[i].teamName );
ADDRGP4 $1143
ARGP4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1732
;1732:}
LABELV $1142
endproc UI_NextOpponent 24 8
proc UI_PriorOpponent 24 8
line 1734
;1733:
;1734:static void UI_PriorOpponent() {
line 1735
;1735:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 1736
;1736:  int j = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
ASGNI4
line 1737
;1737:	i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1738
;1738:	if (i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1154
line 1739
;1739:		i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+14148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1740
;1740:	}
LABELV $1154
line 1741
;1741:	if (i == j) {
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
NEI4 $1157
line 1742
;1742:		i--;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1743
;1743:		if ( i < 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
GEI4 $1159
line 1744
;1744:			i = uiInfo.teamCount - 1;
ADDRLP4 0
ADDRGP4 uiInfo+14148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1745
;1745:		}
LABELV $1159
line 1746
;1746:	}
LABELV $1157
line 1747
;1747: 	trap_Cvar_Set( "ui_opponentName", uiInfo.teamList[i].teamName );
ADDRGP4 $1143
ARGP4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 1748
;1748:}
LABELV $1153
endproc UI_PriorOpponent 24 8
proc UI_DrawPlayerLogo 44 20
line 1750
;1749:
;1750:static void	UI_DrawPlayerLogo(rectDef_t *rect, vec3_t color) {
line 1751
;1751:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1753
;1752:
;1753:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1164
line 1754
;1754:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1755
;1755:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1756
;1756:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1757
;1757:	}
LABELV $1164
line 1759
;1758:
;1759: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1760
;1760:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1761
;1761: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1762
;1762:}
LABELV $1163
endproc UI_DrawPlayerLogo 44 20
proc UI_DrawPlayerLogoMetal 44 20
line 1764
;1763:
;1764:static void	UI_DrawPlayerLogoMetal(rectDef_t *rect, vec3_t color) {
line 1765
;1765:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1766
;1766:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1183
line 1767
;1767:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1768
;1768:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1769
;1769:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1770
;1770:	}
LABELV $1183
line 1772
;1771:
;1772: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1773
;1773:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1774
;1774: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1775
;1775:}
LABELV $1182
endproc UI_DrawPlayerLogoMetal 44 20
proc UI_DrawPlayerLogoName 44 20
line 1777
;1776:
;1777:static void	UI_DrawPlayerLogoName(rectDef_t *rect, vec3_t color) {
line 1778
;1778:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1779
;1779:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1202
line 1780
;1780:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1781
;1781:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1782
;1782:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1783
;1783:	}
LABELV $1202
line 1785
;1784:
;1785: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1786
;1786:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1787
;1787: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1788
;1788:}
LABELV $1201
endproc UI_DrawPlayerLogoName 44 20
proc UI_DrawOpponentLogo 44 20
line 1790
;1789:
;1790:static void	UI_DrawOpponentLogo(rectDef_t *rect, vec3_t color) {
line 1791
;1791:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1792
;1792:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1221
line 1793
;1793:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1794
;1794:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1795
;1795:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1796
;1796:	}
LABELV $1221
line 1798
;1797:
;1798: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1799
;1799:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1800
;1800: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1801
;1801:}
LABELV $1220
endproc UI_DrawOpponentLogo 44 20
proc UI_DrawOpponentLogoMetal 44 20
line 1803
;1802:
;1803:static void	UI_DrawOpponentLogoMetal(rectDef_t *rect, vec3_t color) {
line 1804
;1804:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1805
;1805:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1240
line 1806
;1806:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1807
;1807:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1808
;1808:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1809
;1809:	}
LABELV $1240
line 1811
;1810:
;1811: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1812
;1812:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Metal );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+44
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1813
;1813: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1814
;1814:}
LABELV $1239
endproc UI_DrawOpponentLogoMetal 44 20
proc UI_DrawOpponentLogoName 44 20
line 1816
;1815:
;1816:static void	UI_DrawOpponentLogoName(rectDef_t *rect, vec3_t color) {
line 1817
;1817:  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1818
;1818:	if (uiInfo.teamList[i].teamIcon == -1) {
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+40
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $1259
line 1819
;1819:    uiInfo.teamList[i].teamIcon = trap_R_RegisterShaderNoMip(uiInfo.teamList[i].imageName);
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+14152+40
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 1820
;1820:    uiInfo.teamList[i].teamIcon_Metal = trap_R_RegisterShaderNoMip(va("%s_metal",uiInfo.teamList[i].imageName));
ADDRGP4 $751
ARGP4
ADDRLP4 20
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
ADDRGP4 uiInfo+14152+44
ADDP4
ADDRLP4 28
INDIRI4
ASGNI4
line 1821
;1821:    uiInfo.teamList[i].teamIcon_Name = trap_R_RegisterShaderNoMip(va("%s_name", uiInfo.teamList[i].imageName));
ADDRGP4 $756
ARGP4
ADDRLP4 32
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+14152+48
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 1822
;1822:	}
LABELV $1259
line 1824
;1823:
;1824: 	trap_R_SetColor( color );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1825
;1825:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.teamList[i].teamIcon_Name );
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+48
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 1826
;1826: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 1827
;1827:}
LABELV $1258
endproc UI_DrawOpponentLogoName 44 20
proc UI_DrawAllMapsSelection 16 36
line 1829
;1828:
;1829:static void UI_DrawAllMapsSelection(rectDef_t *rect, float scale, vec4_t color, int textStyle, qboolean net, int iMenuFont) {
line 1830
;1830:	int map = (net) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 16
INDIRI4
CNSTI4 0
EQI4 $1281
ADDRLP4 4
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $1282
JUMPV
LABELV $1281
ADDRLP4 4
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $1282
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 1831
;1831:	if (map >= 0 && map < uiInfo.mapCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1283
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
GEI4 $1283
line 1832
;1832:	  Text_Paint(rect->x, rect->y, scale, color, uiInfo.mapList[map].mapName, 0, 0, textStyle, iMenuFont);
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
INDIRF4
ARGF4
ADDRLP4 12
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 20
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1833
;1833:	}
LABELV $1283
line 1834
;1834:}
LABELV $1277
endproc UI_DrawAllMapsSelection 16 36
proc UI_DrawOpponentName 8 36
line 1836
;1835:
;1836:static void UI_DrawOpponentName(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 1837
;1837:  Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("ui_opponentName"), 0, 0, textStyle, iMenuFont);
ADDRGP4 $1143
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 1838
;1838:}
LABELV $1287
endproc UI_DrawOpponentName 8 36
proc UI_OwnerDrawWidth 148 12
line 1840
;1839:
;1840:static int UI_OwnerDrawWidth(int ownerDraw, float scale) {
line 1841
;1841:	int i, h, value, findex, iUse = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1843
;1842:	const char *text;
;1843:	const char *s = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 1846
;1844:
;1845:
;1846:  switch (ownerDraw) {
ADDRLP4 28
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 200
LTI4 $1290
ADDRLP4 28
INDIRI4
CNSTI4 287
GTI4 $1290
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1382-800
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1382
address $1291
address $1290
address $1290
address $1315
address $1290
address $1316
address $1290
address $1319
address $1324
address $1329
address $1334
address $1334
address $1334
address $1334
address $1334
address $1344
address $1344
address $1344
address $1344
address $1344
address $1353
address $1290
address $1362
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1379
address $1290
address $1290
address $1375
address $1290
address $1290
address $1290
address $1290
address $1290
address $1290
address $1298
address $1306
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1310
address $1290
address $1290
address $1290
address $1334
address $1334
address $1334
address $1344
address $1344
address $1344
address $1290
address $1292
code
LABELV $1291
line 1848
;1847:    case UI_HANDICAP:
;1848:			  h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 32
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 1849
;1849:				i = 20 - h / 5;
ADDRLP4 4
CNSTI4 20
ADDRLP4 24
INDIRI4
CNSTI4 5
DIVI4
SUBI4
ASGNI4
line 1850
;1850:				s = handicapValues[i];
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 handicapValues
ADDP4
INDIRP4
ASGNP4
line 1851
;1851:      break;
ADDRGP4 $1290
JUMPV
LABELV $1292
line 1853
;1852:    case UI_SKIN_COLOR:
;1853:		switch(uiSkinColor)
ADDRLP4 40
ADDRGP4 uiSkinColor
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
EQI4 $1295
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $1296
ADDRGP4 $1293
JUMPV
line 1854
;1854:		{
LABELV $1295
line 1856
;1855:		case TEAM_RED:
;1856:			s = "Red";
ADDRLP4 0
ADDRGP4 $876
ASGNP4
line 1857
;1857:			break;
ADDRGP4 $1290
JUMPV
LABELV $1296
line 1859
;1858:		case TEAM_BLUE:
;1859:			s = "Blue";
ADDRLP4 0
ADDRGP4 $875
ASGNP4
line 1860
;1860:			break;
ADDRGP4 $1290
JUMPV
LABELV $1293
line 1862
;1861:		default:
;1862:			s = "Default";
ADDRLP4 0
ADDRGP4 $1297
ASGNP4
line 1863
;1863:			break;
line 1865
;1864:		}
;1865:		break;
ADDRGP4 $1290
JUMPV
LABELV $1298
line 1867
;1866:    case UI_FORCE_SIDE:
;1867:		i = uiForceSide;
ADDRLP4 4
ADDRGP4 uiForceSide
INDIRI4
ASGNI4
line 1868
;1868:		if (i < 1 || i > 2) {
ADDRLP4 44
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1
LTI4 $1301
ADDRLP4 44
INDIRI4
CNSTI4 2
LEI4 $1299
LABELV $1301
line 1869
;1869:			i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1870
;1870:		}
LABELV $1299
line 1872
;1871:
;1872:		if (i == FORCE_LIGHTSIDE)
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1302
line 1873
;1873:		{
line 1874
;1874:			s = "Light";
ADDRLP4 0
ADDRGP4 $1304
ASGNP4
line 1875
;1875:		}
ADDRGP4 $1290
JUMPV
LABELV $1302
line 1877
;1876:		else
;1877:		{
line 1878
;1878:			s = "Dark";
ADDRLP4 0
ADDRGP4 $1305
ASGNP4
line 1879
;1879:		}
line 1880
;1880:		break;
ADDRGP4 $1290
JUMPV
LABELV $1306
line 1882
;1881:    case UI_FORCE_RANK:
;1882:		i = uiForceRank;
ADDRLP4 4
ADDRGP4 uiForceRank
INDIRI4
ASGNI4
line 1883
;1883:		if (i < 1 || i > MAX_FORCE_RANK) {
ADDRLP4 48
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 1
LTI4 $1309
ADDRLP4 48
INDIRI4
CNSTI4 7
LEI4 $1307
LABELV $1309
line 1884
;1884:			i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1885
;1885:		}
LABELV $1307
line 1887
;1886:
;1887:		s = (char *)UI_GetStripEdString("INGAMETEXT", forceMasteryLevels[i]);
ADDRGP4 $374
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forceMasteryLevels
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 1888
;1888:		break;
ADDRGP4 $1290
JUMPV
LABELV $1310
line 1907
;1889:	case UI_FORCE_RANK_HEAL:
;1890:	case UI_FORCE_RANK_LEVITATION:
;1891:	case UI_FORCE_RANK_SPEED:
;1892:	case UI_FORCE_RANK_PUSH:
;1893:	case UI_FORCE_RANK_PULL:
;1894:	case UI_FORCE_RANK_TELEPATHY:
;1895:	case UI_FORCE_RANK_GRIP:
;1896:	case UI_FORCE_RANK_LIGHTNING:
;1897:	case UI_FORCE_RANK_RAGE:
;1898:	case UI_FORCE_RANK_PROTECT:
;1899:	case UI_FORCE_RANK_ABSORB:
;1900:	case UI_FORCE_RANK_TEAM_HEAL:
;1901:	case UI_FORCE_RANK_TEAM_FORCE:
;1902:	case UI_FORCE_RANK_DRAIN:
;1903:	case UI_FORCE_RANK_SEE:
;1904:	case UI_FORCE_RANK_SABERATTACK:
;1905:	case UI_FORCE_RANK_SABERDEFEND:
;1906:	case UI_FORCE_RANK_SABERTHROW:
;1907:		findex = (ownerDraw - UI_FORCE_RANK)-1;
ADDRLP4 20
ADDRFP4 0
INDIRI4
CNSTI4 258
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 1909
;1908:		//this will give us the index as long as UI_FORCE_RANK is always one below the first force rank index
;1909:		i = uiForcePowersRank[findex];
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiForcePowersRank
ADDP4
INDIRI4
ASGNI4
line 1911
;1910:
;1911:		if (i < 0 || i > NUM_FORCE_POWER_LEVELS-1)
ADDRLP4 56
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
LTI4 $1313
ADDRLP4 56
INDIRI4
CNSTI4 3
LEI4 $1311
LABELV $1313
line 1912
;1912:		{
line 1913
;1913:			i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 1914
;1914:		}
LABELV $1311
line 1916
;1915:
;1916:		s = va("%i", uiForcePowersRank[findex]);
ADDRGP4 $1314
ARGP4
ADDRLP4 20
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiForcePowersRank
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 60
INDIRP4
ASGNP4
line 1917
;1917:		break;
ADDRGP4 $1290
JUMPV
LABELV $1315
line 1919
;1918:    case UI_CLANNAME:
;1919:				s = UI_Cvar_VariableString("ui_teamName");
ADDRGP4 $680
ARGP4
ADDRLP4 64
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 64
INDIRP4
ASGNP4
line 1920
;1920:      break;
ADDRGP4 $1290
JUMPV
LABELV $1316
line 1922
;1921:    case UI_GAMETYPE:
;1922:				s = uiInfo.gameTypes[ui_gameType.integer].gameType;
ADDRLP4 0
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740
ADDP4
INDIRP4
ASGNP4
line 1923
;1923:      break;
ADDRGP4 $1290
JUMPV
LABELV $1319
line 1925
;1924:    case UI_SKILL:
;1925:				i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $809
ARGP4
ADDRLP4 68
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 68
INDIRF4
CVFI4 4
ASGNI4
line 1926
;1926:				if (i < 1 || i > numSkillLevels) {
ADDRLP4 72
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $1322
ADDRLP4 72
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1320
LABELV $1322
line 1927
;1927:					i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1928
;1928:				}
LABELV $1320
line 1929
;1929:			  s = (char *)UI_GetStripEdString("INGAMETEXT", (char *)skillLevels[i-1]);
ADDRGP4 $374
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels-4
ADDP4
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
line 1930
;1930:      break;
ADDRGP4 $1290
JUMPV
LABELV $1324
line 1932
;1931:    case UI_BLUETEAMNAME:
;1932:			  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_blueTeam"));
ADDRGP4 $866
ARGP4
ADDRLP4 80
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ASGNI4
line 1933
;1933:			  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 88
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
LTI4 $1290
ADDRLP4 88
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $1290
line 1934
;1934:			    s = va("%s: %s", "Blue", uiInfo.teamList[i].teamName);
ADDRGP4 $874
ARGP4
ADDRGP4 $875
ARGP4
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 92
INDIRP4
ASGNP4
line 1935
;1935:			  }
line 1936
;1936:      break;
ADDRGP4 $1290
JUMPV
LABELV $1329
line 1938
;1937:    case UI_REDTEAMNAME:
;1938:			  i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_redTeam"));
ADDRGP4 $867
ARGP4
ADDRLP4 92
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 92
INDIRP4
ARGP4
ADDRLP4 96
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 96
INDIRI4
ASGNI4
line 1939
;1939:			  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 100
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
LTI4 $1290
ADDRLP4 100
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $1290
line 1940
;1940:			    s = va("%s: %s", "Red", uiInfo.teamList[i].teamName);
ADDRGP4 $874
ARGP4
ADDRGP4 $876
ARGP4
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
ASGNP4
line 1941
;1941:			  }
line 1942
;1942:      break;
ADDRGP4 $1290
JUMPV
LABELV $1334
line 1951
;1943:    case UI_BLUETEAM1:
;1944:		case UI_BLUETEAM2:
;1945:		case UI_BLUETEAM3:
;1946:		case UI_BLUETEAM4:
;1947:		case UI_BLUETEAM5:
;1948:		case UI_BLUETEAM6:
;1949:		case UI_BLUETEAM7:
;1950:		case UI_BLUETEAM8:
;1951:			if (ownerDraw <= UI_BLUETEAM5)
ADDRFP4 0
INDIRI4
CNSTI4 214
GTI4 $1335
line 1952
;1952:			{
line 1953
;1953:			  iUse = ownerDraw-UI_BLUETEAM1 + 1;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1954
;1954:			}
ADDRGP4 $1336
JUMPV
LABELV $1335
line 1956
;1955:			else
;1956:			{
line 1957
;1957:			  iUse = ownerDraw-274; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 8
ADDRFP4 0
INDIRI4
CNSTI4 274
SUBI4
ASGNI4
line 1958
;1958:			}
LABELV $1336
line 1960
;1959:
;1960:			value = trap_Cvar_VariableValue(va("ui_blueteam%i", iUse));
ADDRGP4 $882
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 104
INDIRP4
ARGP4
ADDRLP4 108
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 108
INDIRF4
CVFI4 4
ASGNI4
line 1961
;1961:			if (value <= 1) {
ADDRLP4 12
INDIRI4
CNSTI4 1
GTI4 $1337
line 1962
;1962:				text = "Human";
ADDRLP4 16
ADDRGP4 $902
ASGNP4
line 1963
;1963:			} else {
ADDRGP4 $1338
JUMPV
LABELV $1337
line 1964
;1964:				value -= 2;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1965
;1965:				if (value >= uiInfo.aliasCount) {
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+13376
INDIRI4
LTI4 $1339
line 1966
;1966:					value = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1967
;1967:				}
LABELV $1339
line 1968
;1968:				text = uiInfo.aliasList[value].name;
ADDRLP4 16
CNSTI4 12
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+13380
ADDP4
INDIRP4
ASGNP4
line 1969
;1969:			}
LABELV $1338
line 1970
;1970:			s = va("%i. %s", iUse, text);
ADDRGP4 $1343
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
ASGNP4
line 1971
;1971:      break;
ADDRGP4 $1290
JUMPV
LABELV $1344
line 1980
;1972:    case UI_REDTEAM1:
;1973:		case UI_REDTEAM2:
;1974:		case UI_REDTEAM3:
;1975:		case UI_REDTEAM4:
;1976:		case UI_REDTEAM5:
;1977:		case UI_REDTEAM6:
;1978:		case UI_REDTEAM7:
;1979:		case UI_REDTEAM8:
;1980:			if (ownerDraw <= UI_REDTEAM5)
ADDRFP4 0
INDIRI4
CNSTI4 219
GTI4 $1345
line 1981
;1981:			{
line 1982
;1982:			  iUse = ownerDraw-UI_REDTEAM1 + 1;
ADDRLP4 8
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 1983
;1983:			}
ADDRGP4 $1346
JUMPV
LABELV $1345
line 1985
;1984:			else
;1985:			{
line 1986
;1986:			  iUse = ownerDraw-277; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 8
ADDRFP4 0
INDIRI4
CNSTI4 277
SUBI4
ASGNI4
line 1987
;1987:			}
LABELV $1346
line 1989
;1988:
;1989:			value = trap_Cvar_VariableValue(va("ui_redteam%i", iUse));
ADDRGP4 $883
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 116
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
ADDRLP4 120
INDIRF4
CVFI4 4
ASGNI4
line 1990
;1990:			if (value <= 1) {
ADDRLP4 12
INDIRI4
CNSTI4 1
GTI4 $1347
line 1991
;1991:				text = "Human";
ADDRLP4 16
ADDRGP4 $902
ASGNP4
line 1992
;1992:			} else {
ADDRGP4 $1348
JUMPV
LABELV $1347
line 1993
;1993:				value -= 2;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 1994
;1994:				if (value >= uiInfo.aliasCount) {
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+13376
INDIRI4
LTI4 $1349
line 1995
;1995:					value = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1996
;1996:				}
LABELV $1349
line 1997
;1997:				text = uiInfo.aliasList[value].name;
ADDRLP4 16
CNSTI4 12
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+13380
ADDP4
INDIRP4
ASGNP4
line 1998
;1998:			}
LABELV $1348
line 1999
;1999:			s = va("%i. %s", iUse, text);
ADDRGP4 $1343
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 124
INDIRP4
ASGNP4
line 2000
;2000:      break;
ADDRGP4 $1290
JUMPV
LABELV $1353
line 2002
;2001:		case UI_NETSOURCE:
;2002:			if (ui_netSource.integer < 0 || ui_netSource.integer > uiInfo.numJoinGameTypes) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
LTI4 $1359
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 uiInfo+17868
INDIRI4
LEI4 $1354
LABELV $1359
line 2003
;2003:				ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 2004
;2004:			}
LABELV $1354
line 2005
;2005:			trap_SP_GetStringTextString("MENUS3_SOURCE", holdSPString, sizeof(holdSPString));
ADDRGP4 $1037
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 2006
;2006:			s = va("%s %s", holdSPString, netSources[ui_netSource.integer]);
ADDRGP4 $1038
ARGP4
ADDRGP4 holdSPString
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netSources
ADDP4
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 128
INDIRP4
ASGNP4
line 2007
;2007:			break;
ADDRGP4 $1290
JUMPV
LABELV $1362
line 2009
;2008:		case UI_NETFILTER:
;2009:			if (ui_serverFilterType.integer < 0 || ui_serverFilterType.integer > numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LTI4 $1367
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LEI4 $1363
LABELV $1367
line 2010
;2010:				ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 2011
;2011:			}
LABELV $1363
line 2012
;2012:			trap_SP_GetStringTextString("MENUS3_GAME", holdSPString, sizeof(holdSPString));
ADDRGP4 $1072
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 2013
;2013:			s = va("%s %s", holdSPString, serverFilters[ui_serverFilterType.integer].description );
ADDRGP4 $1038
ARGP4
ADDRGP4 holdSPString
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters
ADDP4
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 132
INDIRP4
ASGNP4
line 2014
;2014:			break;
ADDRGP4 $1290
JUMPV
line 2016
;2015:		case UI_TIER:
;2016:			break;
line 2018
;2017:		case UI_TIER_MAPNAME:
;2018:			break;
line 2020
;2019:		case UI_TIER_GAMETYPE:
;2020:			break;
line 2022
;2021:		case UI_ALLMAPS_SELECTION:
;2022:			break;
line 2024
;2023:		case UI_OPPONENT_NAME:
;2024:			break;
LABELV $1375
line 2026
;2025:		case UI_KEYBINDSTATUS:
;2026:			if (Display_KeyBindPending()) {
ADDRLP4 136
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 136
INDIRI4
CNSTI4 0
EQI4 $1290
line 2027
;2027:				s = UI_GetStripEdString("INGAMETEXT", "WAITING_FOR_NEW_KEY");
ADDRGP4 $374
ARGP4
ADDRGP4 $1378
ARGP4
ADDRLP4 140
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 140
INDIRP4
ASGNP4
line 2028
;2028:			} else {
line 2030
;2029:			//	s = "Press ENTER or CLICK to change, Press BACKSPACE to clear";
;2030:			}
line 2031
;2031:			break;
ADDRGP4 $1290
JUMPV
LABELV $1379
line 2033
;2032:		case UI_SERVERREFRESHDATE:
;2033:			s = UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer));
ADDRGP4 $1380
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 140
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 140
INDIRP4
ARGP4
ADDRLP4 144
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 144
INDIRP4
ASGNP4
line 2034
;2034:			break;
line 2036
;2035:    default:
;2036:      break;
LABELV $1290
line 2039
;2037:  }
;2038:
;2039:	if (s) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1384
line 2040
;2040:		return Text_Width(s, scale, 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $1288
JUMPV
LABELV $1384
line 2042
;2041:	}
;2042:	return 0;
CNSTI4 0
RETI4
LABELV $1288
endproc UI_OwnerDrawWidth 148 12
proc UI_DrawBotName 20 36
line 2046
;2043:}
;2044:
;2045:static void UI_DrawBotName(rectDef_t *rect, float scale, vec4_t color, int textStyle,int iMenuFont) 
;2046:{
line 2047
;2047:	int value = uiInfo.botIndex;
ADDRLP4 0
ADDRGP4 uiInfo+11836
INDIRI4
ASGNI4
line 2049
;2048://	int game = trap_Cvar_VariableValue("g_gametype");
;2049:	const char *text = "";
ADDRLP4 4
ADDRGP4 $170
ASGNP4
line 2058
;2050:	/*
;2051:	if (game >= GT_TEAM) {
;2052:		if (value >= uiInfo.characterCount) {
;2053:			value = 0;
;2054:		}
;2055:		text = uiInfo.characterList[value].name;
;2056:	} else {
;2057:	*/
;2058:		if (value >= UI_GetNumBots()) {
ADDRLP4 8
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $1388
line 2059
;2059:			value = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2060
;2060:		}
LABELV $1388
line 2061
;2061:		text = UI_GetBotNameByNumber(value);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 12
INDIRP4
ASGNP4
line 2064
;2062:	//}
;2063://  Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle);
;2064:  Text_Paint(rect->x, rect->y, scale, color, text, 0, 0, textStyle,iMenuFont);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 16
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2065
;2065:}
LABELV $1386
endproc UI_DrawBotName 20 36
proc UI_DrawBotSkill 8 36
line 2068
;2066:
;2067:static void UI_DrawBotSkill(rectDef_t *rect, float scale, vec4_t color, int textStyle,int iMenuFont) 
;2068:{
line 2069
;2069:	if (uiInfo.skillIndex >= 0 && uiInfo.skillIndex < numSkillLevels) 
ADDRGP4 uiInfo+33656
INDIRI4
CNSTI4 0
LTI4 $1391
ADDRGP4 uiInfo+33656
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
GEI4 $1391
line 2070
;2070:	{
line 2071
;2071:		Text_Paint(rect->x, rect->y, scale, color, (char *)UI_GetStripEdString("INGAMETEXT", (char *)skillLevels[uiInfo.skillIndex]), 0, 0, textStyle,iMenuFont);
ADDRGP4 $374
ARGP4
ADDRGP4 uiInfo+33656
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 skillLevels
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2072
;2072:	}
LABELV $1391
line 2073
;2073:}
LABELV $1390
endproc UI_DrawBotSkill 8 36
proc UI_DrawRedBlue 8 36
line 2076
;2074:
;2075:static void UI_DrawRedBlue(rectDef_t *rect, float scale, vec4_t color, int textStyle,int iMenuFont) 
;2076:{
line 2077
;2077:	Text_Paint(rect->x, rect->y, scale, color, (uiInfo.redBlue == 0) ? "Red" : "Blue", 0, 0, textStyle,iMenuFont);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+18000
INDIRI4
CNSTI4 0
NEI4 $1399
ADDRLP4 0
ADDRGP4 $876
ASGNP4
ADDRGP4 $1400
JUMPV
LABELV $1399
ADDRLP4 0
ADDRGP4 $875
ASGNP4
LABELV $1400
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2078
;2078:}
LABELV $1396
endproc UI_DrawRedBlue 8 36
proc UI_DrawCrosshair 4 20
line 2080
;2079:
;2080:static void UI_DrawCrosshair(rectDef_t *rect, float scale, vec4_t color) {
line 2081
;2081: 	trap_R_SetColor( color );
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2082
;2082:	if (uiInfo.currentCrosshair < 0 || uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+60720
INDIRI4
CNSTI4 0
LTI4 $1406
ADDRGP4 uiInfo+60720
INDIRI4
CNSTI4 10
LTI4 $1402
LABELV $1406
line 2083
;2083:		uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+60720
CNSTI4 0
ASGNI4
line 2084
;2084:	}
LABELV $1402
line 2085
;2085:	UI_DrawHandlePic( rect->x, rect->y, rect->w, rect->h, uiInfo.uiDC.Assets.crosshairShader[uiInfo.currentCrosshair]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ARGF4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ARGF4
ADDRGP4 uiInfo+60720
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+252+168
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandlePic
CALLV
pop
line 2086
;2086: 	trap_R_SetColor( NULL );
CNSTP4 0
ARGP4
ADDRGP4 trap_R_SetColor
CALLV
pop
line 2087
;2087:}
LABELV $1401
endproc UI_DrawCrosshair 4 20
proc UI_BuildPlayerList 4176 12
line 2094
;2088:
;2089:/*
;2090:===============
;2091:UI_BuildPlayerList
;2092:===============
;2093:*/
;2094:static void UI_BuildPlayerList() {
line 2099
;2095:	uiClientState_t	cs;
;2096:	int		n, count, team, team2, playerTeamNumber;
;2097:	char	info[MAX_INFO_STRING];
;2098:
;2099:	trap_GetClientState( &cs );
ADDRLP4 1040
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 2100
;2100:	trap_GetConfigString( CS_PLAYERS + cs.clientNum, info, MAX_INFO_STRING );
ADDRLP4 1040+8
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 2101
;2101:	uiInfo.playerNumber = cs.clientNum;
ADDRGP4 uiInfo+18024
ADDRLP4 1040+8
INDIRI4
ASGNI4
line 2102
;2102:	uiInfo.teamLeader = atoi(Info_ValueForKey(info, "tl"));
ADDRLP4 4
ARGP4
ADDRGP4 $1416
ARGP4
ADDRLP4 4128
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4128
INDIRP4
ARGP4
ADDRLP4 4132
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 uiInfo+18028
ADDRLP4 4132
INDIRI4
ASGNI4
line 2103
;2103:	team = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1417
ARGP4
ADDRLP4 4136
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4136
INDIRP4
ARGP4
ADDRLP4 4140
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 4140
INDIRI4
ASGNI4
line 2104
;2104:	trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) );
CNSTI4 0
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 2105
;2105:	count = atoi( Info_ValueForKey( info, "sv_maxclients" ) );
ADDRLP4 4
ARGP4
ADDRGP4 $1418
ARGP4
ADDRLP4 4144
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4144
INDIRP4
ARGP4
ADDRLP4 4148
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1028
ADDRLP4 4148
INDIRI4
ASGNI4
line 2106
;2106:	uiInfo.playerCount = 0;
ADDRGP4 uiInfo+18004
CNSTI4 0
ASGNI4
line 2107
;2107:	uiInfo.myTeamCount = 0;
ADDRGP4 uiInfo+18008
CNSTI4 0
ASGNI4
line 2108
;2108:	playerTeamNumber = 0;
ADDRLP4 4124
CNSTI4 0
ASGNI4
line 2109
;2109:	for( n = 0; n < count; n++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1424
JUMPV
LABELV $1421
line 2110
;2110:		trap_GetConfigString( CS_PLAYERS + n, info, MAX_INFO_STRING );
ADDRLP4 0
INDIRI4
CNSTI4 544
ADDI4
ARGI4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_GetConfigString
CALLI4
pop
line 2112
;2111:
;2112:		if (info[0]) {
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $1425
line 2113
;2113:			Q_strncpyz( uiInfo.playerNames[uiInfo.playerCount], Info_ValueForKey( info, "n" ), MAX_NAME_LENGTH );
ADDRLP4 4
ARGP4
ADDRGP4 $1429
ARGP4
ADDRLP4 4152
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+18004
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+18032
ADDP4
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2114
;2114:			Q_CleanStr( uiInfo.playerNames[uiInfo.playerCount] );
ADDRGP4 uiInfo+18004
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+18032
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 2115
;2115:			uiInfo.playerCount++;
ADDRLP4 4156
ADDRGP4 uiInfo+18004
ASGNP4
ADDRLP4 4156
INDIRP4
ADDRLP4 4156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2116
;2116:			team2 = atoi(Info_ValueForKey(info, "t"));
ADDRLP4 4
ARGP4
ADDRGP4 $1417
ARGP4
ADDRLP4 4160
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4160
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 4164
INDIRI4
ASGNI4
line 2117
;2117:			if (team2 == team && n != uiInfo.playerNumber) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1036
INDIRI4
NEI4 $1433
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+18024
INDIRI4
EQI4 $1433
line 2118
;2118:				Q_strncpyz( uiInfo.teamNames[uiInfo.myTeamCount], Info_ValueForKey( info, "n" ), MAX_NAME_LENGTH );
ADDRLP4 4
ARGP4
ADDRGP4 $1429
ARGP4
ADDRLP4 4168
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 uiInfo+18008
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRLP4 4168
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2119
;2119:				Q_CleanStr( uiInfo.teamNames[uiInfo.myTeamCount] );
ADDRGP4 uiInfo+18008
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 2120
;2120:				uiInfo.teamClientNums[uiInfo.myTeamCount] = n;
ADDRGP4 uiInfo+18008
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+20080
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 2121
;2121:				if (uiInfo.playerNumber == n) {
ADDRGP4 uiInfo+18024
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $1442
line 2122
;2122:					playerTeamNumber = uiInfo.myTeamCount;
ADDRLP4 4124
ADDRGP4 uiInfo+18008
INDIRI4
ASGNI4
line 2123
;2123:				}
LABELV $1442
line 2124
;2124:				uiInfo.myTeamCount++;
ADDRLP4 4172
ADDRGP4 uiInfo+18008
ASGNP4
ADDRLP4 4172
INDIRP4
ADDRLP4 4172
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2125
;2125:			}
LABELV $1433
line 2126
;2126:		}
LABELV $1425
line 2127
;2127:	}
LABELV $1422
line 2109
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $1424
ADDRLP4 0
INDIRI4
ADDRLP4 1028
INDIRI4
LTI4 $1421
line 2129
;2128:
;2129:	if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+18028
INDIRI4
CNSTI4 0
NEI4 $1447
line 2130
;2130:		trap_Cvar_Set("cg_selectedPlayer", va("%d", playerTeamNumber));
ADDRGP4 $685
ARGP4
ADDRLP4 4124
INDIRI4
ARGI4
ADDRLP4 4152
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1450
ARGP4
ADDRLP4 4152
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2131
;2131:	}
LABELV $1447
line 2133
;2132:
;2133:	n = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1450
ARGP4
ADDRLP4 4152
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4152
INDIRF4
CVFI4 4
ASGNI4
line 2134
;2134:	if (n < 0 || n > uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $1454
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
LEI4 $1451
LABELV $1454
line 2135
;2135:		n = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2136
;2136:	}
LABELV $1451
line 2139
;2137:
;2138:
;2139:	if (n < uiInfo.myTeamCount) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $1455
line 2140
;2140:		trap_Cvar_Set("cg_selectedPlayerName", uiInfo.teamNames[n]);
ADDRGP4 $1458
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2141
;2141:	}
ADDRGP4 $1456
JUMPV
LABELV $1455
line 2143
;2142:	else
;2143:	{
line 2144
;2144:		trap_Cvar_Set("cg_selectedPlayerName", "Everyone");
ADDRGP4 $1458
ARGP4
ADDRGP4 $1460
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2145
;2145:	}
LABELV $1456
line 2147
;2146:
;2147:	if (!team || team == TEAM_SPECTATOR || !uiInfo.teamLeader)
ADDRLP4 4164
CNSTI4 0
ASGNI4
ADDRLP4 1036
INDIRI4
ADDRLP4 4164
INDIRI4
EQI4 $1465
ADDRLP4 1036
INDIRI4
CNSTI4 3
EQI4 $1465
ADDRGP4 uiInfo+18028
INDIRI4
ADDRLP4 4164
INDIRI4
NEI4 $1461
LABELV $1465
line 2148
;2148:	{
line 2149
;2149:		n = uiInfo.myTeamCount;
ADDRLP4 0
ADDRGP4 uiInfo+18008
INDIRI4
ASGNI4
line 2150
;2150:		trap_Cvar_Set("cg_selectedPlayer", va("%d", n));
ADDRGP4 $685
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4168
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1450
ARGP4
ADDRLP4 4168
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2151
;2151:		trap_Cvar_Set("cg_selectedPlayerName", "N/A");
ADDRGP4 $1458
ARGP4
ADDRGP4 $178
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2152
;2152:	}
LABELV $1461
line 2153
;2153:}
LABELV $1411
endproc UI_BuildPlayerList 4176 12
proc UI_DrawSelectedPlayer 8 36
line 2156
;2154:
;2155:
;2156:static void UI_DrawSelectedPlayer(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) {
line 2157
;2157:	if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) {
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+18016
INDIRI4
LEI4 $1468
line 2158
;2158:		uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+18016
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 2159
;2159:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 2160
;2160:	}
LABELV $1468
line 2161
;2161:  Text_Paint(rect->x, rect->y, scale, color, UI_Cvar_VariableString("cg_selectedPlayerName"), 0, 0, textStyle, iMenuFont);
ADDRGP4 $1458
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
INDIRF4
ARGF4
ADDRLP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2162
;2162:}
LABELV $1467
endproc UI_DrawSelectedPlayer 8 36
proc UI_DrawServerRefreshDate 80 36
line 2165
;2163:
;2164:static void UI_DrawServerRefreshDate(rectDef_t *rect, float scale, vec4_t color, int textStyle, int iMenuFont) 
;2165:{
line 2166
;2166:	if (uiInfo.serverStatus.refreshActive) 
ADDRGP4 uiInfo+40604+2212
INDIRI4
CNSTI4 0
EQI4 $1475
line 2167
;2167:	{
line 2169
;2168:		vec4_t lowLight, newColor;
;2169:		lowLight[0] = 0.8 * color[0]; 
ADDRLP4 0
CNSTF4 1061997773
ADDRFP4 8
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2170
;2170:		lowLight[1] = 0.8 * color[1]; 
ADDRLP4 0+4
CNSTF4 1061997773
ADDRFP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ASGNF4
line 2171
;2171:		lowLight[2] = 0.8 * color[2]; 
ADDRLP4 0+8
CNSTF4 1061997773
ADDRFP4 8
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ASGNF4
line 2172
;2172:		lowLight[3] = 0.8 * color[3]; 
ADDRLP4 0+12
CNSTF4 1061997773
ADDRFP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ASGNF4
line 2173
;2173:		LerpColor(color,lowLight,newColor,0.5+0.5*sin(uiInfo.uiDC.realTime / PULSE_DIVISOR));
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 75
DIVI4
CVIF4 4
ARGF4
ADDRLP4 32
ADDRGP4 sin
CALLF4
ASGNF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 16
ARGP4
CNSTF4 1056964608
ADDRLP4 32
INDIRF4
MULF4
CNSTF4 1056964608
ADDF4
ARGF4
ADDRGP4 LerpColor
CALLV
pop
line 2175
;2174:
;2175:		trap_SP_GetStringTextString("INGAMETEXT_GETTINGINFOFORSERVERS", holdSPString, sizeof(holdSPString));
ADDRGP4 $1483
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 2176
;2176:		Text_Paint(rect->x, rect->y, scale, newColor, va((char *) holdSPString, trap_LAN_GetServerCount(ui_netSource.integer)), 0, 0, textStyle, iMenuFont);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRGP4 holdSPString
ARGP4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 16
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2177
;2177:	} 
ADDRGP4 $1476
JUMPV
LABELV $1475
line 2179
;2178:	else 
;2179:	{
line 2181
;2180:		char buff[64];
;2181:		Q_strncpyz(buff, UI_Cvar_VariableString(va("ui_lastServerRefresh_%i", ui_netSource.integer)), 64);
ADDRGP4 $1380
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 64
INDIRP4
ARGP4
ADDRLP4 68
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
ADDRLP4 68
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2182
;2182:		trap_SP_GetStringTextString("INGAMETEXT_SERVER_REFRESHTIME", holdSPString, sizeof(holdSPString));
ADDRGP4 $1486
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 2184
;2183:
;2184:		Text_Paint(rect->x, rect->y, scale, color, va("%s: %s", holdSPString, buff), 0, 0, textStyle, iMenuFont);
ADDRGP4 $874
ARGP4
ADDRGP4 holdSPString
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 72
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
INDIRF4
ARGF4
ADDRLP4 76
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 72
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2185
;2185:	}
LABELV $1476
line 2186
;2186:}
LABELV $1474
endproc UI_DrawServerRefreshDate 80 36
proc UI_DrawServerMOTD 24 36
line 2188
;2187:
;2188:static void UI_DrawServerMOTD(rectDef_t *rect, float scale, vec4_t color, int iMenuFont) {
line 2189
;2189:	if (uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+40604+10436
INDIRI4
CNSTI4 0
EQI4 $1488
line 2192
;2190:		float maxX;
;2191:	 
;2192:		if (uiInfo.serverStatus.motdWidth == -1) {
ADDRGP4 uiInfo+40604+10440
INDIRI4
CNSTI4 -1
NEI4 $1492
line 2193
;2193:			uiInfo.serverStatus.motdWidth = 0;
ADDRGP4 uiInfo+40604+10440
CNSTI4 0
ASGNI4
line 2194
;2194:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+40604+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2195
;2195:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+40604+10448
CNSTI4 -1
ASGNI4
line 2196
;2196:		}
LABELV $1492
line 2198
;2197:
;2198:		if (uiInfo.serverStatus.motdOffset > uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+40604+10452
INDIRI4
ADDRGP4 uiInfo+40604+10436
INDIRI4
LEI4 $1502
line 2199
;2199:			uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+40604+10452
CNSTI4 0
ASGNI4
line 2200
;2200:			uiInfo.serverStatus.motdPaintX = rect->x + 1;
ADDRGP4 uiInfo+40604+10444
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 2201
;2201:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+40604+10448
CNSTI4 -1
ASGNI4
line 2202
;2202:		}
LABELV $1502
line 2204
;2203:
;2204:		if (uiInfo.uiDC.realTime > uiInfo.serverStatus.motdTime) {
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+40604+10456
INDIRI4
LEI4 $1514
line 2205
;2205:			uiInfo.serverStatus.motdTime = uiInfo.uiDC.realTime + 10;
ADDRGP4 uiInfo+40604+10456
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 2206
;2206:			if (uiInfo.serverStatus.motdPaintX <= rect->x + 2) {
ADDRGP4 uiInfo+40604+10444
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
GTF4 $1522
line 2207
;2207:				if (uiInfo.serverStatus.motdOffset < uiInfo.serverStatus.motdLen) {
ADDRGP4 uiInfo+40604+10452
INDIRI4
ADDRGP4 uiInfo+40604+10436
INDIRI4
GEI4 $1526
line 2208
;2208:					uiInfo.serverStatus.motdPaintX += Text_Width(&uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], scale, 1) - 1;
ADDRGP4 uiInfo+40604+10452
INDIRI4
ADDRGP4 uiInfo+40604+10460
ADDP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 8
ADDRGP4 uiInfo+40604+10444
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ADDI4
ASGNI4
line 2209
;2209:					uiInfo.serverStatus.motdOffset++;
ADDRLP4 12
ADDRGP4 uiInfo+40604+10452
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2210
;2210:				} else {
ADDRGP4 $1523
JUMPV
LABELV $1526
line 2211
;2211:					uiInfo.serverStatus.motdOffset = 0;
ADDRGP4 uiInfo+40604+10452
CNSTI4 0
ASGNI4
line 2212
;2212:					if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+40604+10448
INDIRI4
CNSTI4 0
LTI4 $1542
line 2213
;2213:						uiInfo.serverStatus.motdPaintX = uiInfo.serverStatus.motdPaintX2;
ADDRGP4 uiInfo+40604+10444
ADDRGP4 uiInfo+40604+10448
INDIRI4
ASGNI4
line 2214
;2214:					} else {
ADDRGP4 $1543
JUMPV
LABELV $1542
line 2215
;2215:						uiInfo.serverStatus.motdPaintX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+40604+10444
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 2216
;2216:					}
LABELV $1543
line 2217
;2217:					uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+40604+10448
CNSTI4 -1
ASGNI4
line 2218
;2218:				}
line 2219
;2219:			} else {
ADDRGP4 $1523
JUMPV
LABELV $1522
line 2221
;2220:				//serverStatus.motdPaintX--;
;2221:				uiInfo.serverStatus.motdPaintX -= 2;
ADDRLP4 4
ADDRGP4 uiInfo+40604+10444
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 2222
;2222:				if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+40604+10448
INDIRI4
CNSTI4 0
LTI4 $1556
line 2224
;2223:					//serverStatus.motdPaintX2--;
;2224:					uiInfo.serverStatus.motdPaintX2 -= 2;
ADDRLP4 8
ADDRGP4 uiInfo+40604+10448
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 2
SUBI4
ASGNI4
line 2225
;2225:				}
LABELV $1556
line 2226
;2226:			}
LABELV $1523
line 2227
;2227:		}
LABELV $1514
line 2229
;2228:
;2229:		maxX = rect->x + rect->w - 2;
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2230
;2230:		Text_Paint_Limit(&maxX, uiInfo.serverStatus.motdPaintX, rect->y + rect->h - 3, scale, color, &uiInfo.serverStatus.motd[uiInfo.serverStatus.motdOffset], 0, 0, iMenuFont); 
ADDRLP4 0
ARGP4
ADDRGP4 uiInfo+40604+10444
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+40604+10452
INDIRI4
ADDRGP4 uiInfo+40604+10460
ADDP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 2231
;2231:		if (uiInfo.serverStatus.motdPaintX2 >= 0) {
ADDRGP4 uiInfo+40604+10448
INDIRI4
CNSTI4 0
LTI4 $1568
line 2232
;2232:			float maxX2 = rect->x + rect->w - 2;
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 16
INDIRP4
INDIRF4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
ASGNF4
line 2233
;2233:			Text_Paint_Limit(&maxX2, uiInfo.serverStatus.motdPaintX2, rect->y + rect->h - 3, scale, color, uiInfo.serverStatus.motd, 0, uiInfo.serverStatus.motdOffset, iMenuFont); 
ADDRLP4 12
ARGP4
ADDRGP4 uiInfo+40604+10448
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1077936128
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 uiInfo+40604+10460
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 uiInfo+40604+10452
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 Text_Paint_Limit
CALLV
pop
line 2234
;2234:		}
LABELV $1568
line 2235
;2235:		if (uiInfo.serverStatus.motdOffset && maxX > 0) {
ADDRGP4 uiInfo+40604+10452
INDIRI4
CNSTI4 0
EQI4 $1578
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $1578
line 2237
;2236:			// if we have an offset ( we are skipping the first part of the string ) and we fit the string
;2237:			if (uiInfo.serverStatus.motdPaintX2 == -1) {
ADDRGP4 uiInfo+40604+10448
INDIRI4
CNSTI4 -1
NEI4 $1579
line 2238
;2238:						uiInfo.serverStatus.motdPaintX2 = rect->x + rect->w - 2;
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRGP4 uiInfo+40604+10448
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
SUBF4
CVFI4 4
ASGNI4
line 2239
;2239:			}
line 2240
;2240:		} else {
ADDRGP4 $1579
JUMPV
LABELV $1578
line 2241
;2241:			uiInfo.serverStatus.motdPaintX2 = -1;
ADDRGP4 uiInfo+40604+10448
CNSTI4 -1
ASGNI4
line 2242
;2242:		}
LABELV $1579
line 2244
;2243:
;2244:	}
LABELV $1488
line 2245
;2245:}
LABELV $1487
endproc UI_DrawServerMOTD 24 36
proc UI_DrawKeyBindStatus 12 36
line 2247
;2246:
;2247:static void UI_DrawKeyBindStatus(rectDef_t *rect, float scale, vec4_t color, int textStyle,int iMenuFont) {
line 2249
;2248://	int ofs = 0; TTimo: unused
;2249:	if (Display_KeyBindPending()) 
ADDRLP4 0
ADDRGP4 Display_KeyBindPending
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $1591
line 2250
;2250:	{
line 2251
;2251:		Text_Paint(rect->x, rect->y, scale, color, UI_GetStripEdString("INGAMETEXT", "WAITING_FOR_NEW_KEY"), 0, 0, textStyle,iMenuFont);
ADDRGP4 $374
ARGP4
ADDRGP4 $1378
ARGP4
ADDRLP4 4
ADDRGP4 UI_GetStripEdString
CALLP4
ASGNP4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2252
;2252:	} else {
LABELV $1591
line 2254
;2253://		Text_Paint(rect->x, rect->y, scale, color, "Press ENTER or CLICK to change, Press BACKSPACE to clear", 0, 0, textStyle,iMenuFont);
;2254:	}
LABELV $1592
line 2255
;2255:}
LABELV $1590
endproc UI_DrawKeyBindStatus 12 36
proc UI_DrawGLInfo 4664 36
line 2258
;2256:
;2257:static void UI_DrawGLInfo(rectDef_t *rect, float scale, vec4_t color, int textStyle,int iMenuFont) 
;2258:{
line 2264
;2259:	char * eptr;
;2260:	char buff[4096];
;2261:	const char *lines[128];
;2262:	int y, numLines, i;
;2263:
;2264:	Text_Paint(rect->x + 2, rect->y, scale, color, va("GL_VENDOR: %s", uiInfo.uiDC.glconfig.vendor_string), 0, 30, textStyle,iMenuFont);
ADDRGP4 $1594
ARGP4
ADDRGP4 uiInfo+460+1024
ARGP4
ADDRLP4 4624
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4628
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4628
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4628
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4624
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2265
;2265:	Text_Paint(rect->x + 2, rect->y + 15, scale, color, va("GL_VERSION: %s: %s", uiInfo.uiDC.glconfig.version_string,uiInfo.uiDC.glconfig.renderer_string), 0, 30, textStyle,iMenuFont);
ADDRGP4 $1597
ARGP4
ADDRGP4 uiInfo+460+2048
ARGP4
ADDRGP4 uiInfo+460
ARGP4
ADDRLP4 4632
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4636
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4636
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4636
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1097859072
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4632
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2266
;2266:	Text_Paint(rect->x + 2, rect->y + 30, scale, color, va ("GL_PIXELFORMAT: color(%d-bits) Z(%d-bits) stencil(%d-bits)", uiInfo.uiDC.glconfig.colorBits, uiInfo.uiDC.glconfig.depthBits, uiInfo.uiDC.glconfig.stencilBits), 0, 30, textStyle,iMenuFont);
ADDRGP4 $1601
ARGP4
ADDRGP4 uiInfo+460+11272
INDIRI4
ARGI4
ADDRGP4 uiInfo+460+11276
INDIRI4
ARGI4
ADDRGP4 uiInfo+460+11280
INDIRI4
ARGI4
ADDRLP4 4640
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4644
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4644
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4644
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1106247680
ADDF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4640
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 30
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2269
;2267:
;2268:	// build null terminated extension strings
;2269:	Q_strncpyz(buff, uiInfo.uiDC.glconfig.extensions_string, 4096);
ADDRLP4 528
ARGP4
ADDRGP4 uiInfo+460+3072
ARGP4
CNSTI4 4096
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 2270
;2270:	eptr = buff;
ADDRLP4 0
ADDRLP4 528
ASGNP4
line 2271
;2271:	y = rect->y + 45;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
CNSTF4 1110704128
ADDF4
CVFI4 4
ASGNI4
line 2272
;2272:	numLines = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1611
JUMPV
line 2274
;2273:	while ( y < rect->y + rect->h && *eptr )
;2274:	{
LABELV $1613
line 2276
;2275:		while ( *eptr && *eptr == ' ' )
;2276:			*eptr++ = '\0';
ADDRLP4 4648
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4648
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 4648
INDIRP4
CNSTI1 0
ASGNI1
LABELV $1614
line 2275
ADDRLP4 4652
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4652
INDIRI4
CNSTI4 0
EQI4 $1616
ADDRLP4 4652
INDIRI4
CNSTI4 32
EQI4 $1613
LABELV $1616
line 2279
;2277:
;2278:		// track start of valid string
;2279:		if (*eptr && *eptr != ' ') 
ADDRLP4 4656
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4656
INDIRI4
CNSTI4 0
EQI4 $1620
ADDRLP4 4656
INDIRI4
CNSTI4 32
EQI4 $1620
line 2280
;2280:		{
line 2281
;2281:			lines[numLines++] = eptr;
ADDRLP4 4660
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 12
ADDRLP4 4660
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4660
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2282
;2282:		}
ADDRGP4 $1620
JUMPV
LABELV $1619
line 2285
;2283:
;2284:		while ( *eptr && *eptr != ' ' )
;2285:			eptr++;
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
LABELV $1620
line 2284
ADDRLP4 4660
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 4660
INDIRI4
CNSTI4 0
EQI4 $1622
ADDRLP4 4660
INDIRI4
CNSTI4 32
NEI4 $1619
LABELV $1622
line 2286
;2286:	}
LABELV $1611
line 2273
ADDRLP4 4648
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 4648
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4648
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
GEF4 $1623
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $1614
LABELV $1623
line 2288
;2287:
;2288:	i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1625
JUMPV
LABELV $1624
line 2290
;2289:	while (i < numLines) 
;2290:	{
line 2291
;2291:		Text_Paint(rect->x + 2, y, scale, color, lines[i++], 0, 20, textStyle,iMenuFont);
ADDRFP4 0
INDIRP4
INDIRF4
CNSTF4 1073741824
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4652
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 4652
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4652
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2292
;2292:		if (i < numLines) 
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
GEI4 $1627
line 2293
;2293:		{
line 2294
;2294:			Text_Paint(rect->x + rect->w / 2, y, scale, color, lines[i++], 0, 20, textStyle,iMenuFont);
ADDRLP4 4660
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4660
INDIRP4
INDIRF4
ADDRLP4 4660
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1073741824
DIVF4
ADDF4
ARGF4
ADDRLP4 4
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRLP4 4656
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 8
ADDRLP4 4656
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4656
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
ADDP4
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 20
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 2295
;2295:		}
LABELV $1627
line 2296
;2296:		y += 10;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 10
ADDI4
ASGNI4
line 2297
;2297:		if (y > rect->y + rect->h - 11) 
ADDRLP4 4656
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
CVIF4 4
ADDRLP4 4656
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 4656
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
ADDF4
CNSTF4 1093664768
SUBF4
LEF4 $1629
line 2298
;2298:		{
line 2299
;2299:			break;
ADDRGP4 $1626
JUMPV
LABELV $1629
line 2301
;2300:		}
;2301:	}
LABELV $1625
line 2289
ADDRLP4 8
INDIRI4
ADDRLP4 12
INDIRI4
LTI4 $1624
LABELV $1626
line 2304
;2302:
;2303:
;2304:}
LABELV $1593
endproc UI_DrawGLInfo 4664 36
proc UI_Version 16 36
line 2312
;2305:
;2306:/*
;2307:=================
;2308:UI_Version
;2309:=================
;2310:*/
;2311:static void UI_Version(rectDef_t *rect, float scale, vec4_t color, int iMenuFont) 
;2312:{
line 2315
;2313:	int width;
;2314:	
;2315:	width = uiInfo.uiDC.textWidth(Q3_VERSION, scale, iMenuFont);
ADDRGP4 $1633
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 uiInfo+20
INDIRP4
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2317
;2316:
;2317:	uiInfo.uiDC.drawText(rect->x - width, rect->y, scale, color, Q3_VERSION, 0, 0, 0, iMenuFont);
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
INDIRF4
ADDRLP4 0
INDIRI4
CVIF4 4
SUBF4
ARGF4
ADDRLP4 8
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 $1633
ARGP4
CNSTF4 0
ARGF4
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 12
INDIRI4
ARGI4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 uiInfo+16
INDIRP4
CALLV
pop
line 2318
;2318:}
LABELV $1631
endproc UI_Version 16 36
proc UI_OwnerDraw 48 36
line 2328
;2319:
;2320:/*
;2321:=================
;2322:UI_OwnerDraw
;2323:=================
;2324:*/
;2325:// FIXME: table drive
;2326://
;2327:static void UI_OwnerDraw(float x, float y, float w, float h, float text_x, float text_y, int ownerDraw, int ownerDrawFlags, int align, float special, float scale, vec4_t color, qhandle_t shader, int textStyle,int iMenuFont) 
;2328:{
line 2331
;2329:	rectDef_t rect;
;2330:	int findex;
;2331:	int drawRank = 0, iUse = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2333
;2332:
;2333:	rect.x = x + text_x;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 16
INDIRF4
ADDF4
ASGNF4
line 2334
;2334:	rect.y = y + text_y;
ADDRLP4 0+4
ADDRFP4 4
INDIRF4
ADDRFP4 20
INDIRF4
ADDF4
ASGNF4
line 2335
;2335:	rect.w = w;
ADDRLP4 0+8
ADDRFP4 8
INDIRF4
ASGNF4
line 2336
;2336:	rect.h = h;
ADDRLP4 0+12
ADDRFP4 12
INDIRF4
ASGNF4
line 2338
;2337:
;2338:  switch (ownerDraw) 
ADDRLP4 28
ADDRFP4 24
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 200
LTI4 $1640
ADDRLP4 28
INDIRI4
CNSTI4 288
GTI4 $1640
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $1705-800
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $1705
address $1641
address $1651
address $1640
address $1653
address $1654
address $1657
address $1661
address $1665
address $1667
address $1668
address $1669
address $1669
address $1669
address $1669
address $1669
address $1672
address $1672
address $1672
address $1672
address $1672
address $1675
address $1676
address $1678
address $1679
address $1640
address $1681
address $1682
address $1683
address $1684
address $1687
address $1685
address $1688
address $1686
address $1689
address $1690
address $1691
address $1692
address $1694
address $1640
address $1695
address $1696
address $1697
address $1698
address $1699
address $1663
address $1658
address $1677
address $1700
address $1701
address $1702
address $1703
address $1655
address $1662
address $1660
address $1656
address $1664
address $1693
address $1643
address $1647
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1648
address $1704
address $1640
address $1659
address $1669
address $1669
address $1669
address $1672
address $1672
address $1672
address $1646
address $1642
address $1644
code
line 2339
;2339:  {
LABELV $1641
line 2341
;2340:    case UI_HANDICAP:
;2341:      UI_DrawHandicap(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawHandicap
CALLV
pop
line 2342
;2342:      break;
ADDRGP4 $1640
JUMPV
LABELV $1642
line 2344
;2343:    case UI_SKIN_COLOR:
;2344:      UI_DrawSkinColor(&rect, scale, color, textStyle, uiSkinColor, TEAM_FREE, TEAM_BLUE, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 uiSkinColor
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawSkinColor
CALLV
pop
line 2345
;2345:      break;
ADDRGP4 $1640
JUMPV
LABELV $1643
line 2347
;2346:	case UI_FORCE_SIDE:
;2347:      UI_DrawForceSide(&rect, scale, color, textStyle, uiForceSide, 1, 2, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 uiForceSide
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawForceSide
CALLV
pop
line 2348
;2348:      break;
ADDRGP4 $1640
JUMPV
LABELV $1644
line 2350
;2349:    case UI_FORCE_POINTS:
;2350:      UI_DrawGenericNum(&rect, scale, color, textStyle, uiForceAvailable, 1, forceMasteryPoints[MAX_FORCE_RANK], ownerDraw,iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 uiForceAvailable
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 forceMasteryPoints+28
INDIRI4
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawGenericNum
CALLV
pop
line 2351
;2351:      break;
ADDRGP4 $1640
JUMPV
LABELV $1646
line 2353
;2352:	case UI_FORCE_MASTERY_SET:
;2353:      UI_DrawForceMastery(&rect, scale, color, textStyle, uiForceRank, 0, MAX_FORCE_RANK, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 uiForceRank
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 7
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawForceMastery
CALLV
pop
line 2354
;2354:      break;
ADDRGP4 $1640
JUMPV
LABELV $1647
line 2356
;2355:    case UI_FORCE_RANK:
;2356:      UI_DrawForceMastery(&rect, scale, color, textStyle, uiForceRank, 0, MAX_FORCE_RANK, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRGP4 uiForceRank
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 7
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawForceMastery
CALLV
pop
line 2357
;2357:      break;
ADDRGP4 $1640
JUMPV
LABELV $1648
line 2391
;2358:	case UI_FORCE_RANK_HEAL:
;2359:	case UI_FORCE_RANK_LEVITATION:
;2360:	case UI_FORCE_RANK_SPEED:
;2361:	case UI_FORCE_RANK_PUSH:
;2362:	case UI_FORCE_RANK_PULL:
;2363:	case UI_FORCE_RANK_TELEPATHY:
;2364:	case UI_FORCE_RANK_GRIP:
;2365:	case UI_FORCE_RANK_LIGHTNING:
;2366:	case UI_FORCE_RANK_RAGE:
;2367:	case UI_FORCE_RANK_PROTECT:
;2368:	case UI_FORCE_RANK_ABSORB:
;2369:	case UI_FORCE_RANK_TEAM_HEAL:
;2370:	case UI_FORCE_RANK_TEAM_FORCE:
;2371:	case UI_FORCE_RANK_DRAIN:
;2372:	case UI_FORCE_RANK_SEE:
;2373:	case UI_FORCE_RANK_SABERATTACK:
;2374:	case UI_FORCE_RANK_SABERDEFEND:
;2375:	case UI_FORCE_RANK_SABERTHROW:
;2376:
;2377://		uiForceRank
;2378:/*
;2379:		uiForceUsed
;2380:		// Only fields for white stars
;2381:		if (uiForceUsed<3)
;2382:		{
;2383:		    Menu_ShowItemByName(menu, "lightpowers_team", qtrue);
;2384:		}
;2385:		else if (uiForceUsed<6)
;2386:		{
;2387:		    Menu_ShowItemByName(menu, "lightpowers_team", qtrue);
;2388:		}
;2389:*/
;2390:
;2391:		findex = (ownerDraw - UI_FORCE_RANK)-1;
ADDRLP4 24
ADDRFP4 24
INDIRI4
CNSTI4 258
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 2393
;2392:		//this will give us the index as long as UI_FORCE_RANK is always one below the first force rank index
;2393:		if (uiForcePowerDarkLight[findex] && uiForceSide != uiForcePowerDarkLight[findex])
ADDRLP4 32
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiForcePowerDarkLight
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1649
ADDRGP4 uiForceSide
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $1649
line 2394
;2394:		{
line 2395
;2395:			color[0] *= 0.5;
ADDRLP4 36
ADDRFP4 44
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTF4 1056964608
ADDRLP4 36
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2396
;2396:			color[1] *= 0.5;
ADDRLP4 40
ADDRFP4 44
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTF4 1056964608
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2397
;2397:			color[2] *= 0.5;
ADDRLP4 44
ADDRFP4 44
INDIRP4
CNSTI4 8
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTF4 1056964608
ADDRLP4 44
INDIRP4
INDIRF4
MULF4
ASGNF4
line 2398
;2398:		}
LABELV $1649
line 2399
;2399:/*		else if (uiForceRank < UI_ForceColorMinRank[bgForcePowerCost[findex][FORCE_LEVEL_1]])
ADDRLP4 20
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiForcePowersRank
ADDP4
INDIRI4
ASGNI4
line 2407
;2400:		{
;2401:			color[0] *= 0.5;
;2402:			color[1] *= 0.5;
;2403:			color[2] *= 0.5;
;2404:		}
;2405:*/		drawRank = uiForcePowersRank[findex];
;2406:
;2407:		UI_DrawForceStars(&rect, scale, color, textStyle, findex, drawRank, 0, NUM_FORCE_POWER_LEVELS-1);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRLP4 24
INDIRI4
ARGI4
ADDRLP4 20
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRGP4 UI_DrawForceStars
CALLV
pop
line 2408
;2408:		break;
ADDRGP4 $1640
JUMPV
LABELV $1651
line 2410
;2409:    case UI_EFFECTS:
;2410:      UI_DrawEffects(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawEffects
CALLV
pop
line 2411
;2411:      break;
ADDRGP4 $1640
JUMPV
line 2414
;2412:    case UI_PLAYERMODEL:
;2413:      //UI_DrawPlayerModel(&rect);
;2414:      break;
LABELV $1653
line 2416
;2415:    case UI_CLANNAME:
;2416:      UI_DrawClanName(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawClanName
CALLV
pop
line 2417
;2417:      break;
ADDRGP4 $1640
JUMPV
LABELV $1654
line 2419
;2418:    case UI_CLANLOGO:
;2419:      UI_DrawClanLogo(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanLogo
CALLV
pop
line 2420
;2420:      break;
ADDRGP4 $1640
JUMPV
LABELV $1655
line 2422
;2421:    case UI_CLANCINEMATIC:
;2422:      UI_DrawClanCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawClanCinematic
CALLV
pop
line 2423
;2423:      break;
ADDRGP4 $1640
JUMPV
LABELV $1656
line 2425
;2424:    case UI_PREVIEWCINEMATIC:
;2425:      UI_DrawPreviewCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPreviewCinematic
CALLV
pop
line 2426
;2426:      break;
ADDRGP4 $1640
JUMPV
LABELV $1657
line 2428
;2427:    case UI_GAMETYPE:
;2428:      UI_DrawGameType(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawGameType
CALLV
pop
line 2429
;2429:      break;
ADDRGP4 $1640
JUMPV
LABELV $1658
line 2431
;2430:    case UI_NETGAMETYPE:
;2431:      UI_DrawNetGameType(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetGameType
CALLV
pop
line 2432
;2432:      break;
ADDRGP4 $1640
JUMPV
LABELV $1659
line 2434
;2433:    case UI_AUTOSWITCHLIST:
;2434:      UI_DrawAutoSwitch(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawAutoSwitch
CALLV
pop
line 2435
;2435:      break;
ADDRGP4 $1640
JUMPV
LABELV $1660
line 2437
;2436:    case UI_JOINGAMETYPE:
;2437:	  UI_DrawJoinGameType(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawJoinGameType
CALLV
pop
line 2438
;2438:	  break;
ADDRGP4 $1640
JUMPV
LABELV $1661
line 2440
;2439:    case UI_MAPPREVIEW:
;2440:      UI_DrawMapPreview(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapPreview
CALLV
pop
line 2441
;2441:      break;
ADDRGP4 $1640
JUMPV
LABELV $1662
line 2443
;2442:    case UI_MAP_TIMETOBEAT:
;2443:      UI_DrawMapTimeToBeat(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawMapTimeToBeat
CALLV
pop
line 2444
;2444:      break;
ADDRGP4 $1640
JUMPV
LABELV $1663
line 2446
;2445:    case UI_MAPCINEMATIC:
;2446:      UI_DrawMapCinematic(&rect, scale, color, qfalse);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 2447
;2447:      break;
ADDRGP4 $1640
JUMPV
LABELV $1664
line 2449
;2448:    case UI_STARTMAPCINEMATIC:
;2449:      UI_DrawMapCinematic(&rect, scale, color, qtrue);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawMapCinematic
CALLV
pop
line 2450
;2450:      break;
ADDRGP4 $1640
JUMPV
LABELV $1665
line 2452
;2451:    case UI_SKILL:
;2452:      UI_DrawSkill(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawSkill
CALLV
pop
line 2453
;2453:      break;
ADDRGP4 $1640
JUMPV
line 2456
;2454:    case UI_TOTALFORCESTARS:
;2455://      UI_DrawTotalForceStars(&rect, scale, color, textStyle);
;2456:      break;
LABELV $1667
line 2458
;2457:    case UI_BLUETEAMNAME:
;2458:      UI_DrawTeamName(&rect, scale, color, qtrue, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 2459
;2459:      break;
ADDRGP4 $1640
JUMPV
LABELV $1668
line 2461
;2460:    case UI_REDTEAMNAME:
;2461:      UI_DrawTeamName(&rect, scale, color, qfalse, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamName
CALLV
pop
line 2462
;2462:      break;
ADDRGP4 $1640
JUMPV
LABELV $1669
line 2471
;2463:    case UI_BLUETEAM1:
;2464:		case UI_BLUETEAM2:
;2465:		case UI_BLUETEAM3:
;2466:		case UI_BLUETEAM4:
;2467:		case UI_BLUETEAM5:
;2468:		case UI_BLUETEAM6:
;2469:		case UI_BLUETEAM7:
;2470:		case UI_BLUETEAM8:
;2471:	if (ownerDraw <= UI_BLUETEAM5)
ADDRFP4 24
INDIRI4
CNSTI4 214
GTI4 $1670
line 2472
;2472:	{
line 2473
;2473:	  iUse = ownerDraw-UI_BLUETEAM1 + 1;
ADDRLP4 16
ADDRFP4 24
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2474
;2474:	}
ADDRGP4 $1671
JUMPV
LABELV $1670
line 2476
;2475:	else
;2476:	{
line 2477
;2477:	  iUse = ownerDraw-274; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 16
ADDRFP4 24
INDIRI4
CNSTI4 274
SUBI4
ASGNI4
line 2478
;2478:	}
LABELV $1671
line 2479
;2479:      UI_DrawTeamMember(&rect, scale, color, qtrue, iUse, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 2480
;2480:      break;
ADDRGP4 $1640
JUMPV
LABELV $1672
line 2489
;2481:    case UI_REDTEAM1:
;2482:		case UI_REDTEAM2:
;2483:		case UI_REDTEAM3:
;2484:		case UI_REDTEAM4:
;2485:		case UI_REDTEAM5:
;2486:		case UI_REDTEAM6:
;2487:		case UI_REDTEAM7:
;2488:		case UI_REDTEAM8:
;2489:	if (ownerDraw <= UI_REDTEAM5)
ADDRFP4 24
INDIRI4
CNSTI4 219
GTI4 $1673
line 2490
;2490:	{
line 2491
;2491:	  iUse = ownerDraw-UI_REDTEAM1 + 1;
ADDRLP4 16
ADDRFP4 24
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 2492
;2492:	}
ADDRGP4 $1674
JUMPV
LABELV $1673
line 2494
;2493:	else
;2494:	{
line 2495
;2495:	  iUse = ownerDraw-277; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 16
ADDRFP4 24
INDIRI4
CNSTI4 277
SUBI4
ASGNI4
line 2496
;2496:	}
LABELV $1674
line 2497
;2497:      UI_DrawTeamMember(&rect, scale, color, qfalse, iUse, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTeamMember
CALLV
pop
line 2498
;2498:      break;
ADDRGP4 $1640
JUMPV
LABELV $1675
line 2500
;2499:		case UI_NETSOURCE:
;2500:      UI_DrawNetSource(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetSource
CALLV
pop
line 2501
;2501:			break;
ADDRGP4 $1640
JUMPV
LABELV $1676
line 2503
;2502:    case UI_NETMAPPREVIEW:
;2503:      UI_DrawNetMapPreview(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapPreview
CALLV
pop
line 2504
;2504:      break;
ADDRGP4 $1640
JUMPV
LABELV $1677
line 2506
;2505:    case UI_NETMAPCINEMATIC:
;2506:      UI_DrawNetMapCinematic(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawNetMapCinematic
CALLV
pop
line 2507
;2507:      break;
ADDRGP4 $1640
JUMPV
LABELV $1678
line 2509
;2508:		case UI_NETFILTER:
;2509:      UI_DrawNetFilter(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawNetFilter
CALLV
pop
line 2510
;2510:			break;
ADDRGP4 $1640
JUMPV
LABELV $1679
line 2512
;2511:		case UI_TIER:
;2512:			UI_DrawTier(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTier
CALLV
pop
line 2513
;2513:			break;
ADDRGP4 $1640
JUMPV
line 2516
;2514:		case UI_OPPONENTMODEL:
;2515:			//UI_DrawOpponent(&rect);
;2516:			break;
LABELV $1681
line 2518
;2517:		case UI_TIERMAP1:
;2518:			UI_DrawTierMap(&rect, 0);
ADDRLP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2519
;2519:			break;
ADDRGP4 $1640
JUMPV
LABELV $1682
line 2521
;2520:		case UI_TIERMAP2:
;2521:			UI_DrawTierMap(&rect, 1);
ADDRLP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2522
;2522:			break;
ADDRGP4 $1640
JUMPV
LABELV $1683
line 2524
;2523:		case UI_TIERMAP3:
;2524:			UI_DrawTierMap(&rect, 2);
ADDRLP4 0
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 UI_DrawTierMap
CALLV
pop
line 2525
;2525:			break;
ADDRGP4 $1640
JUMPV
LABELV $1684
line 2527
;2526:		case UI_PLAYERLOGO:
;2527:			UI_DrawPlayerLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogo
CALLV
pop
line 2528
;2528:			break;
ADDRGP4 $1640
JUMPV
LABELV $1685
line 2530
;2529:		case UI_PLAYERLOGO_METAL:
;2530:			UI_DrawPlayerLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoMetal
CALLV
pop
line 2531
;2531:			break;
ADDRGP4 $1640
JUMPV
LABELV $1686
line 2533
;2532:		case UI_PLAYERLOGO_NAME:
;2533:			UI_DrawPlayerLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawPlayerLogoName
CALLV
pop
line 2534
;2534:			break;
ADDRGP4 $1640
JUMPV
LABELV $1687
line 2536
;2535:		case UI_OPPONENTLOGO:
;2536:			UI_DrawOpponentLogo(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogo
CALLV
pop
line 2537
;2537:			break;
ADDRGP4 $1640
JUMPV
LABELV $1688
line 2539
;2538:		case UI_OPPONENTLOGO_METAL:
;2539:			UI_DrawOpponentLogoMetal(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoMetal
CALLV
pop
line 2540
;2540:			break;
ADDRGP4 $1640
JUMPV
LABELV $1689
line 2542
;2541:		case UI_OPPONENTLOGO_NAME:
;2542:			UI_DrawOpponentLogoName(&rect, color);
ADDRLP4 0
ARGP4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawOpponentLogoName
CALLV
pop
line 2543
;2543:			break;
ADDRGP4 $1640
JUMPV
LABELV $1690
line 2545
;2544:		case UI_TIER_MAPNAME:
;2545:			UI_DrawTierMapName(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierMapName
CALLV
pop
line 2546
;2546:			break;
ADDRGP4 $1640
JUMPV
LABELV $1691
line 2548
;2547:		case UI_TIER_GAMETYPE:
;2548:			UI_DrawTierGameType(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawTierGameType
CALLV
pop
line 2549
;2549:			break;
ADDRGP4 $1640
JUMPV
LABELV $1692
line 2551
;2550:		case UI_ALLMAPS_SELECTION:
;2551:			UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qtrue, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2552
;2552:			break;
ADDRGP4 $1640
JUMPV
LABELV $1693
line 2554
;2553:		case UI_MAPS_SELECTION:
;2554:			UI_DrawAllMapsSelection(&rect, scale, color, textStyle, qfalse, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawAllMapsSelection
CALLV
pop
line 2555
;2555:			break;
ADDRGP4 $1640
JUMPV
LABELV $1694
line 2557
;2556:		case UI_OPPONENT_NAME:
;2557:			UI_DrawOpponentName(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawOpponentName
CALLV
pop
line 2558
;2558:			break;
ADDRGP4 $1640
JUMPV
LABELV $1695
line 2560
;2559:		case UI_BOTNAME:
;2560:			UI_DrawBotName(&rect, scale, color, textStyle,iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotName
CALLV
pop
line 2561
;2561:			break;
ADDRGP4 $1640
JUMPV
LABELV $1696
line 2563
;2562:		case UI_BOTSKILL:
;2563:			UI_DrawBotSkill(&rect, scale, color, textStyle,iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawBotSkill
CALLV
pop
line 2564
;2564:			break;
ADDRGP4 $1640
JUMPV
LABELV $1697
line 2566
;2565:		case UI_REDBLUE:
;2566:			UI_DrawRedBlue(&rect, scale, color, textStyle,iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawRedBlue
CALLV
pop
line 2567
;2567:			break;
ADDRGP4 $1640
JUMPV
LABELV $1698
line 2569
;2568:		case UI_CROSSHAIR:
;2569:			UI_DrawCrosshair(&rect, scale, color);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRGP4 UI_DrawCrosshair
CALLV
pop
line 2570
;2570:			break;
ADDRGP4 $1640
JUMPV
LABELV $1699
line 2572
;2571:		case UI_SELECTEDPLAYER:
;2572:			UI_DrawSelectedPlayer(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawSelectedPlayer
CALLV
pop
line 2573
;2573:			break;
ADDRGP4 $1640
JUMPV
LABELV $1700
line 2575
;2574:		case UI_SERVERREFRESHDATE:
;2575:			UI_DrawServerRefreshDate(&rect, scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawServerRefreshDate
CALLV
pop
line 2576
;2576:			break;
ADDRGP4 $1640
JUMPV
LABELV $1701
line 2578
;2577:		case UI_SERVERMOTD:
;2578:			UI_DrawServerMOTD(&rect, scale, color, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawServerMOTD
CALLV
pop
line 2579
;2579:			break;
ADDRGP4 $1640
JUMPV
LABELV $1702
line 2581
;2580:		case UI_GLINFO:
;2581:			UI_DrawGLInfo(&rect,scale, color, textStyle, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawGLInfo
CALLV
pop
line 2582
;2582:			break;
ADDRGP4 $1640
JUMPV
LABELV $1703
line 2584
;2583:		case UI_KEYBINDSTATUS:
;2584:			UI_DrawKeyBindStatus(&rect,scale, color, textStyle,iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 52
INDIRI4
ARGI4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_DrawKeyBindStatus
CALLV
pop
line 2585
;2585:			break;
ADDRGP4 $1640
JUMPV
LABELV $1704
line 2587
;2586:		case UI_VERSION:
;2587:			UI_Version(&rect, scale, color, iMenuFont);
ADDRLP4 0
ARGP4
ADDRFP4 40
INDIRF4
ARGF4
ADDRFP4 44
INDIRP4
ARGP4
ADDRFP4 56
INDIRI4
ARGI4
ADDRGP4 UI_Version
CALLV
pop
line 2588
;2588:			break;
line 2590
;2589:    default:
;2590:      break;
LABELV $1640
line 2593
;2591:  }
;2592:
;2593:}
LABELV $1635
endproc UI_OwnerDraw 48 36
proc UI_OwnerDrawVisible 16 4
line 2595
;2594:
;2595:static qboolean UI_OwnerDrawVisible(int flags) {
line 2596
;2596:	qboolean vis = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
ADDRGP4 $1709
JUMPV
LABELV $1708
line 2598
;2597:
;2598:	while (flags) {
line 2600
;2599:
;2600:		if (flags & UI_SHOW_FFA) {
ADDRFP4 0
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $1711
line 2601
;2601:			if (trap_Cvar_VariableValue("g_gametype") != GT_FFA && trap_Cvar_VariableValue("g_gametype") != GT_HOLOCRON && trap_Cvar_VariableValue("g_gametype") != GT_JEDIMASTER) {
ADDRGP4 $1015
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $1713
ADDRGP4 $1015
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
EQF4 $1713
ADDRGP4 $1015
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
EQF4 $1713
line 2602
;2602:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2603
;2603:			}
LABELV $1713
line 2604
;2604:			flags &= ~UI_SHOW_FFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -257
BANDI4
ASGNI4
line 2605
;2605:		}
LABELV $1711
line 2607
;2606:
;2607:		if (flags & UI_SHOW_NOTFFA) {
ADDRFP4 0
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $1715
line 2608
;2608:			if (trap_Cvar_VariableValue("g_gametype") == GT_FFA || trap_Cvar_VariableValue("g_gametype") == GT_HOLOCRON || trap_Cvar_VariableValue("g_gametype") != GT_JEDIMASTER) {
ADDRGP4 $1015
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
EQF4 $1720
ADDRGP4 $1015
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
INDIRF4
CNSTF4 1065353216
EQF4 $1720
ADDRGP4 $1015
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
CNSTF4 1073741824
EQF4 $1717
LABELV $1720
line 2609
;2609:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2610
;2610:			}
LABELV $1717
line 2611
;2611:			flags &= ~UI_SHOW_NOTFFA;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -513
BANDI4
ASGNI4
line 2612
;2612:		}
LABELV $1715
line 2614
;2613:
;2614:		if (flags & UI_SHOW_LEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $1721
line 2616
;2615:			// these need to show when this client can give orders to a player or a group
;2616:			if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+18028
INDIRI4
CNSTI4 0
NEI4 $1723
line 2617
;2617:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2618
;2618:			} else {
ADDRGP4 $1724
JUMPV
LABELV $1723
line 2620
;2619:				// if showing yourself
;2620:				if (ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber) { 
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $1726
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+20080
ADDP4
INDIRI4
ADDRGP4 uiInfo+18024
INDIRI4
NEI4 $1726
line 2621
;2621:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2622
;2622:				}
LABELV $1726
line 2623
;2623:			}
LABELV $1724
line 2624
;2624:			flags &= ~UI_SHOW_LEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2
BANDI4
ASGNI4
line 2625
;2625:		} 
LABELV $1721
line 2626
;2626:		if (flags & UI_SHOW_NOTLEADER) {
ADDRFP4 0
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $1733
line 2628
;2627:			// these need to show when this client is assigning their own status or they are NOT the leader
;2628:			if (uiInfo.teamLeader) {
ADDRGP4 uiInfo+18028
INDIRI4
CNSTI4 0
EQI4 $1735
line 2630
;2629:				// if not showing yourself
;2630:				if (!(ui_selectedPlayer.integer < uiInfo.myTeamCount && uiInfo.teamClientNums[ui_selectedPlayer.integer] == uiInfo.playerNumber)) { 
ADDRGP4 ui_selectedPlayer+12
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $1745
ADDRGP4 ui_selectedPlayer+12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+20080
ADDP4
INDIRI4
ADDRGP4 uiInfo+18024
INDIRI4
EQI4 $1738
LABELV $1745
line 2631
;2631:					vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2632
;2632:				}
LABELV $1738
line 2634
;2633:				// these need to show when this client can give orders to a player or a group
;2634:			}
LABELV $1735
line 2635
;2635:			flags &= ~UI_SHOW_NOTLEADER;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -3
BANDI4
ASGNI4
line 2636
;2636:		} 
LABELV $1733
line 2637
;2637:		if (flags & UI_SHOW_FAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $1746
line 2639
;2638:			// this assumes you only put this type of display flag on something showing in the proper context
;2639:			if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $1748
line 2640
;2640:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2641
;2641:			}
LABELV $1748
line 2642
;2642:			flags &= ~UI_SHOW_FAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -5
BANDI4
ASGNI4
line 2643
;2643:		} 
LABELV $1746
line 2644
;2644:		if (flags & UI_SHOW_NOTFAVORITESERVERS) {
ADDRFP4 0
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1751
line 2646
;2645:			// this assumes you only put this type of display flag on something showing in the proper context
;2646:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $1753
line 2647
;2647:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2648
;2648:			}
LABELV $1753
line 2649
;2649:			flags &= ~UI_SHOW_NOTFAVORITESERVERS;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -4097
BANDI4
ASGNI4
line 2650
;2650:		} 
LABELV $1751
line 2651
;2651:		if (flags & UI_SHOW_ANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $1756
line 2652
;2652:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum <= GT_TEAM ) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CNSTI4 5
GTI4 $1758
line 2653
;2653:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2654
;2654:			}
LABELV $1758
line 2655
;2655:			flags &= ~UI_SHOW_ANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -17
BANDI4
ASGNI4
line 2656
;2656:		} 
LABELV $1756
line 2657
;2657:		if (flags & UI_SHOW_ANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $1763
line 2658
;2658:			if (uiInfo.gameTypes[ui_gameType.integer].gtEnum > GT_TEAM ) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1765
line 2659
;2659:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2660
;2660:			}
LABELV $1765
line 2661
;2661:			flags &= ~UI_SHOW_ANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -9
BANDI4
ASGNI4
line 2662
;2662:		} 
LABELV $1763
line 2663
;2663:		if (flags & UI_SHOW_NETANYTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $1770
line 2664
;2664:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum <= GT_TEAM ) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CNSTI4 5
GTI4 $1772
line 2665
;2665:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2666
;2666:			}
LABELV $1772
line 2667
;2667:			flags &= ~UI_SHOW_NETANYTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 2668
;2668:		} 
LABELV $1770
line 2669
;2669:		if (flags & UI_SHOW_NETANYNONTEAMGAME) {
ADDRFP4 0
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $1777
line 2670
;2670:			if (uiInfo.gameTypes[ui_netGameType.integer].gtEnum > GT_TEAM ) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CNSTI4 5
LEI4 $1779
line 2671
;2671:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2672
;2672:			}
LABELV $1779
line 2673
;2673:			flags &= ~UI_SHOW_NETANYNONTEAMGAME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -1025
BANDI4
ASGNI4
line 2674
;2674:		} 
LABELV $1777
line 2675
;2675:		if (flags & UI_SHOW_NEWHIGHSCORE) {
ADDRFP4 0
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $1784
line 2676
;2676:			if (uiInfo.newHighScoreTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+11808
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
GEI4 $1786
line 2677
;2677:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2678
;2678:			} else {
ADDRGP4 $1787
JUMPV
LABELV $1786
line 2679
;2679:				if (uiInfo.soundHighScore) {
ADDRGP4 uiInfo+11828
INDIRI4
CNSTI4 0
EQI4 $1790
line 2680
;2680:					if (trap_Cvar_VariableValue("sv_killserver") == 0) {
ADDRGP4 $335
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1793
line 2683
;2681:						// wait on server to go down before playing sound
;2682:						//trap_S_StartLocalSound(uiInfo.newHighScoreSound, CHAN_ANNOUNCER);
;2683:						uiInfo.soundHighScore = qfalse;
ADDRGP4 uiInfo+11828
CNSTI4 0
ASGNI4
line 2684
;2684:					}
LABELV $1793
line 2685
;2685:				}
LABELV $1790
line 2686
;2686:			}
LABELV $1787
line 2687
;2687:			flags &= ~UI_SHOW_NEWHIGHSCORE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -33
BANDI4
ASGNI4
line 2688
;2688:		} 
LABELV $1784
line 2689
;2689:		if (flags & UI_SHOW_NEWBESTTIME) {
ADDRFP4 0
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $1796
line 2690
;2690:			if (uiInfo.newBestTime < uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+11812
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
GEI4 $1798
line 2691
;2691:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2692
;2692:			}
LABELV $1798
line 2693
;2693:			flags &= ~UI_SHOW_NEWBESTTIME;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -129
BANDI4
ASGNI4
line 2694
;2694:		} 
LABELV $1796
line 2695
;2695:		if (flags & UI_SHOW_DEMOAVAILABLE) {
ADDRFP4 0
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $1802
line 2696
;2696:			if (!uiInfo.demoAvailable) {
ADDRGP4 uiInfo+11824
INDIRI4
CNSTI4 0
NEI4 $1804
line 2697
;2697:				vis = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2698
;2698:			}
LABELV $1804
line 2699
;2699:			flags &= ~UI_SHOW_DEMOAVAILABLE;
ADDRFP4 0
ADDRFP4 0
INDIRI4
CNSTI4 -65
BANDI4
ASGNI4
line 2700
;2700:		} else {
ADDRGP4 $1803
JUMPV
LABELV $1802
line 2701
;2701:			flags = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 2702
;2702:		}
LABELV $1803
line 2703
;2703:	}
LABELV $1709
line 2598
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $1708
line 2704
;2704:  return vis;
ADDRLP4 0
INDIRI4
RETI4
LABELV $1707
endproc UI_OwnerDrawVisible 16 4
proc UI_Handicap_HandleKey 20 12
line 2707
;2705:}
;2706:
;2707:static qboolean UI_Handicap_HandleKey(int flags, float *special, int key) {
line 2708
;2708:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1812
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1812
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1812
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1808
LABELV $1812
line 2710
;2709:    int h;
;2710:    h = Com_Clamp( 5, 100, trap_Cvar_VariableValue("handicap") );
ADDRGP4 $678
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
CNSTF4 1084227584
ARGF4
CNSTF4 1120403456
ARGF4
ADDRLP4 8
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 2711
;2711:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1813
line 2712
;2712:	    h -= 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
SUBI4
ASGNI4
line 2713
;2713:		} else {
ADDRGP4 $1814
JUMPV
LABELV $1813
line 2714
;2714:	    h += 5;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 5
ADDI4
ASGNI4
line 2715
;2715:		}
LABELV $1814
line 2716
;2716:    if (h > 100) {
ADDRLP4 4
INDIRI4
CNSTI4 100
LEI4 $1815
line 2717
;2717:      h = 5;
ADDRLP4 4
CNSTI4 5
ASGNI4
line 2718
;2718:    } else if (h < 0) {
ADDRGP4 $1816
JUMPV
LABELV $1815
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1817
line 2719
;2719:			h = 100;
ADDRLP4 4
CNSTI4 100
ASGNI4
line 2720
;2720:		}
LABELV $1817
LABELV $1816
line 2721
;2721:  	trap_Cvar_Set( "handicap", va( "%i", h) );
ADDRGP4 $1314
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $678
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2722
;2722:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1807
JUMPV
LABELV $1808
line 2724
;2723:  }
;2724:  return qfalse;
CNSTI4 0
RETI4
LABELV $1807
endproc UI_Handicap_HandleKey 20 12
proc UI_Effects_HandleKey 20 8
line 2727
;2725:}
;2726:
;2727:static qboolean UI_Effects_HandleKey(int flags, float *special, int key) {
line 2728
;2728:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1824
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1824
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1824
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1820
LABELV $1824
line 2730
;2729:
;2730:	  int team = (int)(trap_Cvar_VariableValue("ui_myteam"));
ADDRGP4 $843
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2732
;2731:
;2732:	  if (team == TEAM_RED || team==TEAM_BLUE)
ADDRLP4 12
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $1827
ADDRLP4 12
INDIRI4
CNSTI4 2
NEI4 $1825
LABELV $1827
line 2733
;2733:	  {
line 2734
;2734:		  return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $1819
JUMPV
LABELV $1825
line 2738
;2735:	  }
;2736:
;2737:
;2738:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1828
line 2739
;2739:	    uiInfo.effectsColor--;
ADDRLP4 16
ADDRGP4 uiInfo+95060
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2740
;2740:		} else {
ADDRGP4 $1829
JUMPV
LABELV $1828
line 2741
;2741:	    uiInfo.effectsColor++;
ADDRLP4 16
ADDRGP4 uiInfo+95060
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2742
;2742:		}
LABELV $1829
line 2744
;2743:
;2744:    if( uiInfo.effectsColor > 5 ) {
ADDRGP4 uiInfo+95060
INDIRI4
CNSTI4 5
LEI4 $1832
line 2745
;2745:	  	uiInfo.effectsColor = 0;
ADDRGP4 uiInfo+95060
CNSTI4 0
ASGNI4
line 2746
;2746:		} else if (uiInfo.effectsColor < 0) {
ADDRGP4 $1833
JUMPV
LABELV $1832
ADDRGP4 uiInfo+95060
INDIRI4
CNSTI4 0
GEI4 $1836
line 2747
;2747:	  	uiInfo.effectsColor = 5;
ADDRGP4 uiInfo+95060
CNSTI4 5
ASGNI4
line 2748
;2748:		}
LABELV $1836
LABELV $1833
line 2750
;2749:
;2750:	  trap_Cvar_SetValue( "color1", /*uitogamecode[uiInfo.effectsColor]*/uiInfo.effectsColor );
ADDRGP4 $1840
ARGP4
ADDRGP4 uiInfo+95060
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 2751
;2751:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1819
JUMPV
LABELV $1820
line 2753
;2752:  }
;2753:  return qfalse;
CNSTI4 0
RETI4
LABELV $1819
endproc UI_Effects_HandleKey 20 8
proc UI_ClanName_HandleKey 16 8
line 2756
;2754:}
;2755:
;2756:static qboolean UI_ClanName_HandleKey(int flags, float *special, int key) {
line 2757
;2757:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1847
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1847
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1847
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1843
LABELV $1847
line 2759
;2758:    int i;
;2759:    i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 2760
;2760:		if (uiInfo.teamList[i].cinematic >= 0) {
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
CNSTI4 0
LTI4 $1848
line 2761
;2761:		  trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 2762
;2762:			uiInfo.teamList[i].cinematic = -1;
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
CNSTI4 -1
ASGNI4
line 2763
;2763:		}
LABELV $1848
line 2764
;2764:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1856
line 2765
;2765:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2766
;2766:		} else {
ADDRGP4 $1857
JUMPV
LABELV $1856
line 2767
;2767:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2768
;2768:		}
LABELV $1857
line 2769
;2769:    if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $1858
line 2770
;2770:      i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2771
;2771:    } else if (i < 0) {
ADDRGP4 $1859
JUMPV
LABELV $1858
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1861
line 2772
;2772:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+14148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2773
;2773:		}
LABELV $1861
LABELV $1859
line 2774
;2774:  	trap_Cvar_Set( "ui_teamName", uiInfo.teamList[i].teamName);
ADDRGP4 $680
ARGP4
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2775
;2775:	UI_HeadCountByTeam();
ADDRGP4 UI_HeadCountByTeam
CALLI4
pop
line 2776
;2776:	UI_FeederSelection(FEEDER_HEADS, 0);
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLI4
pop
line 2777
;2777:	updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 2778
;2778:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1842
JUMPV
LABELV $1843
line 2780
;2779:  }
;2780:  return qfalse;
CNSTI4 0
RETI4
LABELV $1842
endproc UI_ClanName_HandleKey 16 8
proc UI_GameType_HandleKey 24 16
line 2783
;2781:}
;2782:
;2783:static qboolean UI_GameType_HandleKey(int flags, float *special, int key, qboolean resetMap) {
line 2784
;2784:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1870
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1870
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1870
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1866
LABELV $1870
line 2785
;2785:		int oldCount = UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ASGNI4
line 2788
;2786:
;2787:		// hard coded mess here
;2788:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1871
line 2789
;2789:			ui_gameType.integer--;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2790
;2790:			if (ui_gameType.integer == 2) {
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1874
line 2791
;2791:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2792
;2792:			} else if (ui_gameType.integer < 2) {
ADDRGP4 $1872
JUMPV
LABELV $1874
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
GEI4 $1872
line 2793
;2793:				ui_gameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_gameType+12
ADDRGP4 uiInfo+17736
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2794
;2794:			}
line 2795
;2795:		} else {
ADDRGP4 $1872
JUMPV
LABELV $1871
line 2796
;2796:			ui_gameType.integer++;
ADDRLP4 12
ADDRGP4 ui_gameType+12
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2797
;2797:			if (ui_gameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 ui_gameType+12
INDIRI4
ADDRGP4 uiInfo+17736
INDIRI4
LTI4 $1884
line 2798
;2798:				ui_gameType.integer = 1;
ADDRGP4 ui_gameType+12
CNSTI4 1
ASGNI4
line 2799
;2799:			} else if (ui_gameType.integer == 2) {
ADDRGP4 $1885
JUMPV
LABELV $1884
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 2
NEI4 $1889
line 2800
;2800:				ui_gameType.integer = 3;
ADDRGP4 ui_gameType+12
CNSTI4 3
ASGNI4
line 2801
;2801:			}
LABELV $1889
LABELV $1885
line 2802
;2802:		}
LABELV $1872
line 2804
;2803:    
;2804:		if (uiInfo.gameTypes[ui_gameType.integer].gtEnum == GT_TOURNAMENT) {
ADDRLP4 12
CNSTI4 3
ASGNI4
ADDRGP4 ui_gameType+12
INDIRI4
ADDRLP4 12
INDIRI4
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
NEI4 $1893
line 2805
;2805:			trap_Cvar_Set("ui_Q3Model", "1");
ADDRGP4 $1898
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2806
;2806:		} else {
ADDRGP4 $1894
JUMPV
LABELV $1893
line 2807
;2807:			trap_Cvar_Set("ui_Q3Model", "0");
ADDRGP4 $1898
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2808
;2808:		}
LABELV $1894
line 2810
;2809:
;2810:		trap_Cvar_Set("ui_gameType", va("%d", ui_gameType.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1899
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2811
;2811:		UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 2812
;2812:		UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 2813
;2813:		if (resetMap && oldCount != UI_MapCountByGameType(qtrue)) {
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1907
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $1907
line 2814
;2814:	  	trap_Cvar_Set( "ui_currentMap", "0");
ADDRGP4 $922
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2815
;2815:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2816
;2816:		}
LABELV $1907
line 2817
;2817:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1865
JUMPV
LABELV $1866
line 2819
;2818:  }
;2819:  return qfalse;
CNSTI4 0
RETI4
LABELV $1865
endproc UI_GameType_HandleKey 24 16
proc UI_NetGameType_HandleKey 12 16
line 2822
;2820:}
;2821:
;2822:static qboolean UI_NetGameType_HandleKey(int flags, float *special, int key) {
line 2823
;2823:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1914
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1914
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1914
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1910
LABELV $1914
line 2825
;2824:
;2825:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1915
line 2826
;2826:			ui_netGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2827
;2827:		} else {
ADDRGP4 $1916
JUMPV
LABELV $1915
line 2828
;2828:			ui_netGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_netGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2829
;2829:		}
LABELV $1916
line 2831
;2830:
;2831:    if (ui_netGameType.integer < 0) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
GEI4 $1919
line 2832
;2832:      ui_netGameType.integer = uiInfo.numGameTypes - 1;
ADDRGP4 ui_netGameType+12
ADDRGP4 uiInfo+17736
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2833
;2833:		} else if (ui_netGameType.integer >= uiInfo.numGameTypes) {
ADDRGP4 $1920
JUMPV
LABELV $1919
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+17736
INDIRI4
LTI4 $1924
line 2834
;2834:      ui_netGameType.integer = 0;
ADDRGP4 ui_netGameType+12
CNSTI4 0
ASGNI4
line 2835
;2835:    } 
LABELV $1924
LABELV $1920
line 2837
;2836:
;2837:  	trap_Cvar_Set( "ui_netGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $699
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2838
;2838:  	trap_Cvar_Set( "ui_actualnetGameType", va("%d", uiInfo.gameTypes[ui_netGameType.integer].gtEnum));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1930
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2839
;2839:  	trap_Cvar_Set( "ui_currentNetMap", "0");
ADDRGP4 $920
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2840
;2840:		UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 2841
;2841:		Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 2842
;2842:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1909
JUMPV
LABELV $1910
line 2844
;2843:  }
;2844:  return qfalse;
CNSTI4 0
RETI4
LABELV $1909
endproc UI_NetGameType_HandleKey 12 16
proc UI_AutoSwitch_HandleKey 16 8
line 2847
;2845:}
;2846:
;2847:static qboolean UI_AutoSwitch_HandleKey(int flags, float *special, int key) {
line 2848
;2848:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1939
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1939
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1939
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1935
LABELV $1939
line 2849
;2849:	 int switchVal = trap_Cvar_VariableValue("cg_autoswitch");
ADDRGP4 $704
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2851
;2850:
;2851:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1940
line 2852
;2852:			switchVal--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2853
;2853:		} else {
ADDRGP4 $1941
JUMPV
LABELV $1940
line 2854
;2854:			switchVal++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2855
;2855:		}
LABELV $1941
line 2857
;2856:
;2857:    if (switchVal < 0)
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1942
line 2858
;2858:	{
line 2859
;2859:		switchVal = 2;
ADDRLP4 4
CNSTI4 2
ASGNI4
line 2860
;2860:	}
ADDRGP4 $1943
JUMPV
LABELV $1942
line 2861
;2861:	else if (switchVal >= 3)
ADDRLP4 4
INDIRI4
CNSTI4 3
LTI4 $1944
line 2862
;2862:	{
line 2863
;2863:      switchVal = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2864
;2864:    } 
LABELV $1944
LABELV $1943
line 2866
;2865:
;2866:  	trap_Cvar_Set( "cg_autoswitch", va("%i", switchVal));
ADDRGP4 $1314
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $704
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2867
;2867:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1934
JUMPV
LABELV $1935
line 2869
;2868:  }
;2869:  return qfalse;
CNSTI4 0
RETI4
LABELV $1934
endproc UI_AutoSwitch_HandleKey 16 8
proc UI_JoinGameType_HandleKey 8 8
line 2872
;2870:}
;2871:
;2872:static qboolean UI_JoinGameType_HandleKey(int flags, float *special, int key) {
line 2873
;2873:	if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1951
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1951
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1951
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1947
LABELV $1951
line 2875
;2874:
;2875:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1952
line 2876
;2876:			ui_joinGameType.integer--;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2877
;2877:		} else {
ADDRGP4 $1953
JUMPV
LABELV $1952
line 2878
;2878:			ui_joinGameType.integer++;
ADDRLP4 4
ADDRGP4 ui_joinGameType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2879
;2879:		}
LABELV $1953
line 2881
;2880:
;2881:		if (ui_joinGameType.integer < 0) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 0
GEI4 $1956
line 2882
;2882:			ui_joinGameType.integer = uiInfo.numJoinGameTypes - 1;
ADDRGP4 ui_joinGameType+12
ADDRGP4 uiInfo+17868
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2883
;2883:		} else if (ui_joinGameType.integer >= uiInfo.numJoinGameTypes) {
ADDRGP4 $1957
JUMPV
LABELV $1956
ADDRGP4 ui_joinGameType+12
INDIRI4
ADDRGP4 uiInfo+17868
INDIRI4
LTI4 $1961
line 2884
;2884:			ui_joinGameType.integer = 0;
ADDRGP4 ui_joinGameType+12
CNSTI4 0
ASGNI4
line 2885
;2885:		}
LABELV $1961
LABELV $1957
line 2887
;2886:
;2887:		trap_Cvar_Set( "ui_joinGameType", va("%d", ui_joinGameType.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_joinGameType+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $723
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2888
;2888:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 2889
;2889:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1946
JUMPV
LABELV $1947
line 2891
;2890:	}
;2891:	return qfalse;
CNSTI4 0
RETI4
LABELV $1946
endproc UI_JoinGameType_HandleKey 8 8
proc UI_Skill_HandleKey 16 8
line 2896
;2892:}
;2893:
;2894:
;2895:
;2896:static qboolean UI_Skill_HandleKey(int flags, float *special, int key) {
line 2897
;2897:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1972
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1968
LABELV $1972
line 2898
;2898:  	int i = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $809
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 2900
;2899:
;2900:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1973
line 2901
;2901:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2902
;2902:		} else {
ADDRGP4 $1974
JUMPV
LABELV $1973
line 2903
;2903:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2904
;2904:		}
LABELV $1974
line 2906
;2905:
;2906:    if (i < 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $1975
line 2907
;2907:			i = numSkillLevels;
ADDRLP4 4
ADDRGP4 numSkillLevels
INDIRI4
ASGNI4
line 2908
;2908:		} else if (i > numSkillLevels) {
ADDRGP4 $1976
JUMPV
LABELV $1975
ADDRLP4 4
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LEI4 $1977
line 2909
;2909:      i = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2910
;2910:    }
LABELV $1977
LABELV $1976
line 2912
;2911:
;2912:    trap_Cvar_Set("g_spSkill", va("%i", i));
ADDRGP4 $1314
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $809
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2913
;2913:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1967
JUMPV
LABELV $1968
line 2915
;2914:  }
;2915:  return qfalse;
CNSTI4 0
RETI4
LABELV $1967
endproc UI_Skill_HandleKey 16 8
proc UI_TeamName_HandleKey 24 8
line 2919
;2916:}
;2917:
;2918:
;2919:static qboolean UI_TeamName_HandleKey(int flags, float *special, int key, qboolean blue) {
line 2920
;2920:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $1984
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $1984
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $1984
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $1980
LABELV $1984
line 2922
;2921:    int i;
;2922:    i = UI_TeamIndexFromName(UI_Cvar_VariableString((blue) ? "ui_blueTeam" : "ui_redTeam"));
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1986
ADDRLP4 8
ADDRGP4 $866
ASGNP4
ADDRGP4 $1987
JUMPV
LABELV $1986
ADDRLP4 8
ADDRGP4 $867
ASGNP4
LABELV $1987
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 2924
;2923:
;2924:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $1988
line 2925
;2925:	    i--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2926
;2926:		} else {
ADDRGP4 $1989
JUMPV
LABELV $1988
line 2927
;2927:	    i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2928
;2928:		}
LABELV $1989
line 2930
;2929:
;2930:    if (i >= uiInfo.teamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $1990
line 2931
;2931:      i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2932
;2932:    } else if (i < 0) {
ADDRGP4 $1991
JUMPV
LABELV $1990
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $1993
line 2933
;2933:			i = uiInfo.teamCount - 1;
ADDRLP4 4
ADDRGP4 uiInfo+14148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2934
;2934:		}
LABELV $1993
LABELV $1991
line 2936
;2935:
;2936:    trap_Cvar_Set( (blue) ? "ui_blueTeam" : "ui_redTeam", uiInfo.teamList[i].teamName);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $1998
ADDRLP4 20
ADDRGP4 $866
ASGNP4
ADDRGP4 $1999
JUMPV
LABELV $1998
ADDRLP4 20
ADDRGP4 $867
ASGNP4
LABELV $1999
ADDRLP4 20
INDIRP4
ARGP4
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2938
;2937:
;2938:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $1979
JUMPV
LABELV $1980
line 2940
;2939:  }
;2940:  return qfalse;
CNSTI4 0
RETI4
LABELV $1979
endproc UI_TeamName_HandleKey 24 8
proc UI_TeamMember_HandleKey 44 8
line 2943
;2941:}
;2942:
;2943:static qboolean UI_TeamMember_HandleKey(int flags, float *special, int key, qboolean blue, int num) {
line 2944
;2944:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2005
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2005
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2005
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2001
LABELV $2005
line 2948
;2945:		// 0 - None
;2946:		// 1 - Human
;2947:		// 2..NumCharacters - Bot
;2948:		char *cvar = va(blue ? "ui_blueteam%i" : "ui_redteam%i", num);
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $2007
ADDRLP4 20
ADDRGP4 $882
ASGNP4
ADDRGP4 $2008
JUMPV
LABELV $2007
ADDRLP4 20
ADDRGP4 $883
ASGNP4
LABELV $2008
ADDRLP4 20
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
ADDRLP4 24
INDIRP4
ASGNP4
line 2949
;2949:		int value = trap_Cvar_VariableValue(cvar);
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 28
INDIRF4
CVFI4 4
ASGNI4
line 2950
;2950:		int maxcl = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $887
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 2951
;2951:		int numval = num;
ADDRLP4 8
ADDRFP4 16
INDIRI4
ASGNI4
line 2953
;2952:
;2953:		numval *= 2;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 2955
;2954:
;2955:		if (blue)
ADDRFP4 12
INDIRI4
CNSTI4 0
EQI4 $2009
line 2956
;2956:		{
line 2957
;2957:			numval -= 1;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2958
;2958:		}
LABELV $2009
line 2960
;2959:
;2960:		if (numval > maxcl)
ADDRLP4 8
INDIRI4
ADDRLP4 16
INDIRI4
LEI4 $2011
line 2961
;2961:		{
line 2962
;2962:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2000
JUMPV
LABELV $2011
line 2965
;2963:		}
;2964:
;2965:		if (value < 1)
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $2013
line 2966
;2966:		{
line 2967
;2967:			value = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2968
;2968:		}
LABELV $2013
line 2970
;2969:
;2970:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2015
line 2971
;2971:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 2972
;2972:		} else {
ADDRGP4 $2016
JUMPV
LABELV $2015
line 2973
;2973:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2974
;2974:		}
LABELV $2016
line 2983
;2975:
;2976:		/*if (ui_actualNetGameType.integer >= GT_TEAM) {
;2977:			if (value >= uiInfo.characterCount + 2) {
;2978:				value = 0;
;2979:			} else if (value < 0) {
;2980:				value = uiInfo.characterCount + 2 - 1;
;2981:			}
;2982:		} else {*/
;2983:			if (value >= UI_GetNumBots() + 2) {
ADDRLP4 36
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 36
INDIRI4
CNSTI4 2
ADDI4
LTI4 $2017
line 2984
;2984:				value = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 2985
;2985:			} else if (value < 1) {
ADDRGP4 $2018
JUMPV
LABELV $2017
ADDRLP4 4
INDIRI4
CNSTI4 1
GEI4 $2019
line 2986
;2986:				value = UI_GetNumBots() + 2 - 1;
ADDRLP4 40
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 40
INDIRI4
CNSTI4 2
ADDI4
CNSTI4 1
SUBI4
ASGNI4
line 2987
;2987:			}
LABELV $2019
LABELV $2018
line 2990
;2988:		//}
;2989:
;2990:		trap_Cvar_Set(cvar, va("%i", value));
ADDRGP4 $1314
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 2991
;2991:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2000
JUMPV
LABELV $2001
line 2993
;2992:  }
;2993:  return qfalse;
CNSTI4 0
RETI4
LABELV $2000
endproc UI_TeamMember_HandleKey 44 8
proc UI_NetSource_HandleKey 8 8
line 2996
;2994:}
;2995:
;2996:static qboolean UI_NetSource_HandleKey(int flags, float *special, int key) {
line 2997
;2997:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2026
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2026
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2026
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2022
LABELV $2026
line 2999
;2998:		
;2999:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2027
line 3000
;3000:			ui_netSource.integer--;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3001
;3001:		} else {
ADDRGP4 $2028
JUMPV
LABELV $2027
line 3002
;3002:			ui_netSource.integer++;
ADDRLP4 4
ADDRGP4 ui_netSource+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3003
;3003:		}
LABELV $2028
line 3005
;3004:    
;3005:		if (ui_netSource.integer >= numNetSources) {
ADDRGP4 ui_netSource+12
INDIRI4
ADDRGP4 numNetSources
INDIRI4
LTI4 $2031
line 3006
;3006:      ui_netSource.integer = 0;
ADDRGP4 ui_netSource+12
CNSTI4 0
ASGNI4
line 3007
;3007:    } else if (ui_netSource.integer < 0) {
ADDRGP4 $2032
JUMPV
LABELV $2031
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
GEI4 $2035
line 3008
;3008:      ui_netSource.integer = numNetSources - 1;
ADDRGP4 ui_netSource+12
ADDRGP4 numNetSources
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3009
;3009:		}
LABELV $2035
LABELV $2032
line 3011
;3010:
;3011:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3012
;3012:		if (ui_netSource.integer != AS_GLOBAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
EQI4 $2039
line 3013
;3013:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 3014
;3014:		}
LABELV $2039
line 3015
;3015:  	trap_Cvar_Set( "ui_netSource", va("%d", ui_netSource.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2042
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3016
;3016:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2021
JUMPV
LABELV $2022
line 3018
;3017:  }
;3018:  return qfalse;
CNSTI4 0
RETI4
LABELV $2021
endproc UI_NetSource_HandleKey 8 8
proc UI_NetFilter_HandleKey 8 4
line 3021
;3019:}
;3020:
;3021:static qboolean UI_NetFilter_HandleKey(int flags, float *special, int key) {
line 3022
;3022:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2049
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2049
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2049
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2045
LABELV $2049
line 3024
;3023:
;3024:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2050
line 3025
;3025:			ui_serverFilterType.integer--;
ADDRLP4 4
ADDRGP4 ui_serverFilterType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3026
;3026:		} else {
ADDRGP4 $2051
JUMPV
LABELV $2050
line 3027
;3027:			ui_serverFilterType.integer++;
ADDRLP4 4
ADDRGP4 ui_serverFilterType+12
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3028
;3028:		}
LABELV $2051
line 3030
;3029:
;3030:    if (ui_serverFilterType.integer >= numServerFilters) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
ADDRGP4 numServerFilters
INDIRI4
LTI4 $2054
line 3031
;3031:      ui_serverFilterType.integer = 0;
ADDRGP4 ui_serverFilterType+12
CNSTI4 0
ASGNI4
line 3032
;3032:    } else if (ui_serverFilterType.integer < 0) {
ADDRGP4 $2055
JUMPV
LABELV $2054
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
GEI4 $2058
line 3033
;3033:      ui_serverFilterType.integer = numServerFilters - 1;
ADDRGP4 ui_serverFilterType+12
ADDRGP4 numServerFilters
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3034
;3034:		}
LABELV $2058
LABELV $2055
line 3035
;3035:		UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 3036
;3036:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2044
JUMPV
LABELV $2045
line 3038
;3037:  }
;3038:  return qfalse;
CNSTI4 0
RETI4
LABELV $2044
endproc UI_NetFilter_HandleKey 8 4
proc UI_OpponentName_HandleKey 4 0
line 3041
;3039:}
;3040:
;3041:static qboolean UI_OpponentName_HandleKey(int flags, float *special, int key) {
line 3042
;3042:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2067
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2067
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2067
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2063
LABELV $2067
line 3043
;3043:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2068
line 3044
;3044:			UI_PriorOpponent();
ADDRGP4 UI_PriorOpponent
CALLV
pop
line 3045
;3045:		} else {
ADDRGP4 $2069
JUMPV
LABELV $2068
line 3046
;3046:			UI_NextOpponent();
ADDRGP4 UI_NextOpponent
CALLV
pop
line 3047
;3047:		}
LABELV $2069
line 3048
;3048:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2062
JUMPV
LABELV $2063
line 3050
;3049:  }
;3050:  return qfalse;
CNSTI4 0
RETI4
LABELV $2062
endproc UI_OpponentName_HandleKey 4 0
proc UI_BotName_HandleKey 16 0
line 3053
;3051:}
;3052:
;3053:static qboolean UI_BotName_HandleKey(int flags, float *special, int key) {
line 3054
;3054:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2075
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2075
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2075
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2071
LABELV $2075
line 3056
;3055://		int game = trap_Cvar_VariableValue("g_gametype");
;3056:		int value = uiInfo.botIndex;
ADDRLP4 4
ADDRGP4 uiInfo+11836
INDIRI4
ASGNI4
line 3058
;3057:
;3058:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2077
line 3059
;3059:			value--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3060
;3060:		} else {
ADDRGP4 $2078
JUMPV
LABELV $2077
line 3061
;3061:			value++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3062
;3062:		}
LABELV $2078
line 3073
;3063:
;3064:		/*
;3065:		if (game >= GT_TEAM) {
;3066:			if (value >= uiInfo.characterCount + 2) {
;3067:				value = 0;
;3068:			} else if (value < 0) {
;3069:				value = uiInfo.characterCount + 2 - 1;
;3070:			}
;3071:		} else {
;3072:		*/
;3073:			if (value >= UI_GetNumBots()/* + 2*/) {
ADDRLP4 8
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2079
line 3074
;3074:				value = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3075
;3075:			} else if (value < 0) {
ADDRGP4 $2080
JUMPV
LABELV $2079
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2081
line 3076
;3076:				value = UI_GetNumBots()/* + 2*/ - 1;
ADDRLP4 12
ADDRGP4 UI_GetNumBots
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3077
;3077:			}
LABELV $2081
LABELV $2080
line 3079
;3078:		//}
;3079:		uiInfo.botIndex = value;
ADDRGP4 uiInfo+11836
ADDRLP4 4
INDIRI4
ASGNI4
line 3080
;3080:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2070
JUMPV
LABELV $2071
line 3082
;3081:  }
;3082:  return qfalse;
CNSTI4 0
RETI4
LABELV $2070
endproc UI_BotName_HandleKey 16 0
proc UI_BotSkill_HandleKey 8 0
line 3085
;3083:}
;3084:
;3085:static qboolean UI_BotSkill_HandleKey(int flags, float *special, int key) {
line 3086
;3086:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2089
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2089
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2089
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2085
LABELV $2089
line 3087
;3087:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2090
line 3088
;3088:			uiInfo.skillIndex--;
ADDRLP4 4
ADDRGP4 uiInfo+33656
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3089
;3089:		} else {
ADDRGP4 $2091
JUMPV
LABELV $2090
line 3090
;3090:			uiInfo.skillIndex++;
ADDRLP4 4
ADDRGP4 uiInfo+33656
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3091
;3091:		}
LABELV $2091
line 3092
;3092:		if (uiInfo.skillIndex >= numSkillLevels) {
ADDRGP4 uiInfo+33656
INDIRI4
ADDRGP4 numSkillLevels
INDIRI4
LTI4 $2094
line 3093
;3093:			uiInfo.skillIndex = 0;
ADDRGP4 uiInfo+33656
CNSTI4 0
ASGNI4
line 3094
;3094:		} else if (uiInfo.skillIndex < 0) {
ADDRGP4 $2095
JUMPV
LABELV $2094
ADDRGP4 uiInfo+33656
INDIRI4
CNSTI4 0
GEI4 $2098
line 3095
;3095:			uiInfo.skillIndex = numSkillLevels-1;
ADDRGP4 uiInfo+33656
ADDRGP4 numSkillLevels
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3096
;3096:		}
LABELV $2098
LABELV $2095
line 3097
;3097:    return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2084
JUMPV
LABELV $2085
line 3099
;3098:  }
;3099:	return qfalse;
CNSTI4 0
RETI4
LABELV $2084
endproc UI_BotSkill_HandleKey 8 0
proc UI_RedBlue_HandleKey 8 0
line 3102
;3100:}
;3101:
;3102:static qboolean UI_RedBlue_HandleKey(int flags, float *special, int key) {
line 3103
;3103:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2107
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2107
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2107
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2103
LABELV $2107
line 3104
;3104:		uiInfo.redBlue ^= 1;
ADDRLP4 4
ADDRGP4 uiInfo+18000
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
BXORI4
ASGNI4
line 3105
;3105:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2102
JUMPV
LABELV $2103
line 3107
;3106:	}
;3107:	return qfalse;
CNSTI4 0
RETI4
LABELV $2102
endproc UI_RedBlue_HandleKey 8 0
proc UI_Crosshair_HandleKey 8 8
line 3110
;3108:}
;3109:
;3110:static qboolean UI_Crosshair_HandleKey(int flags, float *special, int key) {
line 3111
;3111:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2114
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2114
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2114
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2110
LABELV $2114
line 3112
;3112:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2115
line 3113
;3113:			uiInfo.currentCrosshair--;
ADDRLP4 4
ADDRGP4 uiInfo+60720
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3114
;3114:		} else {
ADDRGP4 $2116
JUMPV
LABELV $2115
line 3115
;3115:			uiInfo.currentCrosshair++;
ADDRLP4 4
ADDRGP4 uiInfo+60720
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3116
;3116:		}
LABELV $2116
line 3118
;3117:
;3118:		if (uiInfo.currentCrosshair >= NUM_CROSSHAIRS) {
ADDRGP4 uiInfo+60720
INDIRI4
CNSTI4 10
LTI4 $2119
line 3119
;3119:			uiInfo.currentCrosshair = 0;
ADDRGP4 uiInfo+60720
CNSTI4 0
ASGNI4
line 3120
;3120:		} else if (uiInfo.currentCrosshair < 0) {
ADDRGP4 $2120
JUMPV
LABELV $2119
ADDRGP4 uiInfo+60720
INDIRI4
CNSTI4 0
GEI4 $2123
line 3121
;3121:			uiInfo.currentCrosshair = NUM_CROSSHAIRS - 1;
ADDRGP4 uiInfo+60720
CNSTI4 9
ASGNI4
line 3122
;3122:		}
LABELV $2123
LABELV $2120
line 3123
;3123:		trap_Cvar_Set("cg_drawCrosshair", va("%d", uiInfo.currentCrosshair)); 
ADDRGP4 $685
ARGP4
ADDRGP4 uiInfo+60720
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2127
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3124
;3124:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2109
JUMPV
LABELV $2110
line 3126
;3125:	}
;3126:	return qfalse;
CNSTI4 0
RETI4
LABELV $2109
endproc UI_Crosshair_HandleKey 8 8
proc UI_SelectedPlayer_HandleKey 16 8
line 3131
;3127:}
;3128:
;3129:
;3130:
;3131:static qboolean UI_SelectedPlayer_HandleKey(int flags, float *special, int key) {
line 3132
;3132:  if (key == K_MOUSE1 || key == K_MOUSE2 || key == K_ENTER || key == K_KP_ENTER) {
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 178
EQI4 $2134
ADDRLP4 0
INDIRI4
CNSTI4 179
EQI4 $2134
ADDRLP4 0
INDIRI4
CNSTI4 13
EQI4 $2134
ADDRLP4 0
INDIRI4
CNSTI4 169
NEI4 $2130
LABELV $2134
line 3135
;3133:		int selected;
;3134:
;3135:		UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 3136
;3136:		if (!uiInfo.teamLeader) {
ADDRGP4 uiInfo+18028
INDIRI4
CNSTI4 0
NEI4 $2135
line 3137
;3137:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2129
JUMPV
LABELV $2135
line 3139
;3138:		}
;3139:		selected = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1450
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 8
INDIRF4
CVFI4 4
ASGNI4
line 3141
;3140:		
;3141:		if (key == K_MOUSE2) {
ADDRFP4 8
INDIRI4
CNSTI4 179
NEI4 $2138
line 3142
;3142:			selected--;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3143
;3143:		} else {
ADDRGP4 $2139
JUMPV
LABELV $2138
line 3144
;3144:			selected++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3145
;3145:		}
LABELV $2139
line 3147
;3146:
;3147:		if (selected > uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
LEI4 $2140
line 3148
;3148:			selected = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3149
;3149:		} else if (selected < 0) {
ADDRGP4 $2141
JUMPV
LABELV $2140
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $2143
line 3150
;3150:			selected = uiInfo.myTeamCount;
ADDRLP4 4
ADDRGP4 uiInfo+18008
INDIRI4
ASGNI4
line 3151
;3151:		}
LABELV $2143
LABELV $2141
line 3153
;3152:
;3153:		if (selected == uiInfo.myTeamCount) {
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
NEI4 $2146
line 3154
;3154:		 	trap_Cvar_Set( "cg_selectedPlayerName", "Everyone");
ADDRGP4 $1458
ARGP4
ADDRGP4 $1460
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3155
;3155:		} else {
ADDRGP4 $2147
JUMPV
LABELV $2146
line 3156
;3156:		 	trap_Cvar_Set( "cg_selectedPlayerName", uiInfo.teamNames[selected]);
ADDRGP4 $1458
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3157
;3157:		}
LABELV $2147
line 3158
;3158:	 	trap_Cvar_Set( "cg_selectedPlayer", va("%d", selected));
ADDRGP4 $685
ARGP4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1450
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3159
;3159:	}
LABELV $2130
line 3160
;3160:	return qfalse;
CNSTI4 0
RETI4
LABELV $2129
endproc UI_SelectedPlayer_HandleKey 16 8
proc UI_OwnerDrawHandleKey 76 28
line 3164
;3161:}
;3162:
;3163:
;3164:static qboolean UI_OwnerDrawHandleKey(int ownerDraw, int flags, float *special, int key) {
line 3165
;3165:	int findex, iUse = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3167
;3166:
;3167:  switch (ownerDraw) {
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 200
LTI4 $2152
ADDRLP4 8
INDIRI4
CNSTI4 287
GTI4 $2152
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2182-800
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2182
address $2153
address $2159
address $2152
address $2160
address $2152
address $2161
address $2152
address $2165
address $2166
address $2167
address $2168
address $2168
address $2168
address $2168
address $2168
address $2171
address $2171
address $2171
address $2171
address $2171
address $2174
address $2152
address $2175
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2176
address $2152
address $2177
address $2178
address $2179
address $2180
address $2181
address $2152
address $2162
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2152
address $2164
address $2152
address $2152
address $2152
address $2155
address $2152
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2158
address $2152
address $2152
address $2163
address $2168
address $2168
address $2168
address $2171
address $2171
address $2171
address $2156
address $2154
code
LABELV $2153
line 3169
;3168:    case UI_HANDICAP:
;3169:      return UI_Handicap_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 UI_Handicap_HandleKey
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3170
;3170:      break;
LABELV $2154
line 3172
;3171:    case UI_SKIN_COLOR:
;3172:      return UI_SkinColor_HandleKey(flags, special, key, uiSkinColor, TEAM_FREE, TEAM_BLUE, ownerDraw);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 uiSkinColor
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_SkinColor_HandleKey
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3173
;3173:      break;
LABELV $2155
line 3175
;3174:    case UI_FORCE_SIDE:
;3175:      return UI_ForceSide_HandleKey(flags, special, key, uiForceSide, 1, 2, ownerDraw);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 uiForceSide
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 2
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 UI_ForceSide_HandleKey
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3176
;3176:      break;
LABELV $2156
line 3178
;3177:	case UI_FORCE_MASTERY_SET:
;3178:      return UI_ForceMaxRank_HandleKey(flags, special, key, uiForceRank, 1, MAX_FORCE_RANK, ownerDraw);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 uiForceRank
INDIRI4
ARGI4
CNSTI4 1
ARGI4
CNSTI4 7
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 24
ADDRGP4 UI_ForceMaxRank_HandleKey
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3179
;3179:      break;
line 3181
;3180:    case UI_FORCE_RANK:
;3181:		break;		
LABELV $2158
line 3200
;3182:	case UI_FORCE_RANK_HEAL:
;3183:	case UI_FORCE_RANK_LEVITATION:
;3184:	case UI_FORCE_RANK_SPEED:
;3185:	case UI_FORCE_RANK_PUSH:
;3186:	case UI_FORCE_RANK_PULL:
;3187:	case UI_FORCE_RANK_TELEPATHY:
;3188:	case UI_FORCE_RANK_GRIP:
;3189:	case UI_FORCE_RANK_LIGHTNING:
;3190:	case UI_FORCE_RANK_RAGE:
;3191:	case UI_FORCE_RANK_PROTECT:
;3192:	case UI_FORCE_RANK_ABSORB:
;3193:	case UI_FORCE_RANK_TEAM_HEAL:
;3194:	case UI_FORCE_RANK_TEAM_FORCE:
;3195:	case UI_FORCE_RANK_DRAIN:
;3196:	case UI_FORCE_RANK_SEE:
;3197:	case UI_FORCE_RANK_SABERATTACK:
;3198:	case UI_FORCE_RANK_SABERDEFEND:
;3199:	case UI_FORCE_RANK_SABERTHROW:
;3200:		findex = (ownerDraw - UI_FORCE_RANK)-1;
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 258
SUBI4
CNSTI4 1
SUBI4
ASGNI4
line 3202
;3201:		//this will give us the index as long as UI_FORCE_RANK is always one below the first force rank index
;3202:		return UI_ForcePowerRank_HandleKey(flags, special, key, uiForcePowersRank[findex], 0, NUM_FORCE_POWER_LEVELS-1, ownerDraw);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiForcePowersRank
ADDP4
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 UI_ForcePowerRank_HandleKey
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3203
;3203:		break;
LABELV $2159
line 3205
;3204:    case UI_EFFECTS:
;3205:      return UI_Effects_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 UI_Effects_HandleKey
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3206
;3206:      break;
LABELV $2160
line 3208
;3207:    case UI_CLANNAME:
;3208:      return UI_ClanName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 36
ADDRGP4 UI_ClanName_HandleKey
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3209
;3209:      break;
LABELV $2161
line 3211
;3210:    case UI_GAMETYPE:
;3211:      return UI_GameType_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 UI_GameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3212
;3212:      break;
LABELV $2162
line 3214
;3213:    case UI_NETGAMETYPE:
;3214:      return UI_NetGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 UI_NetGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3215
;3215:      break;
LABELV $2163
line 3217
;3216:    case UI_AUTOSWITCHLIST:
;3217:      return UI_AutoSwitch_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 UI_AutoSwitch_HandleKey
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3218
;3218:      break;
LABELV $2164
line 3220
;3219:    case UI_JOINGAMETYPE:
;3220:      return UI_JoinGameType_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 52
ADDRGP4 UI_JoinGameType_HandleKey
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3221
;3221:      break;
LABELV $2165
line 3223
;3222:    case UI_SKILL:
;3223:      return UI_Skill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 56
ADDRGP4 UI_Skill_HandleKey
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3224
;3224:      break;
LABELV $2166
line 3226
;3225:    case UI_BLUETEAMNAME:
;3226:      return UI_TeamName_HandleKey(flags, special, key, qtrue);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 60
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3227
;3227:      break;
LABELV $2167
line 3229
;3228:    case UI_REDTEAMNAME:
;3229:      return UI_TeamName_HandleKey(flags, special, key, qfalse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 64
ADDRGP4 UI_TeamName_HandleKey
CALLI4
ASGNI4
ADDRLP4 64
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3230
;3230:      break;
LABELV $2168
line 3239
;3231:    case UI_BLUETEAM1:
;3232:		case UI_BLUETEAM2:
;3233:		case UI_BLUETEAM3:
;3234:		case UI_BLUETEAM4:
;3235:		case UI_BLUETEAM5:
;3236:		case UI_BLUETEAM6:
;3237:		case UI_BLUETEAM7:
;3238:		case UI_BLUETEAM8:
;3239:	if (ownerDraw <= UI_BLUETEAM5)
ADDRFP4 0
INDIRI4
CNSTI4 214
GTI4 $2169
line 3240
;3240:	{
line 3241
;3241:	  iUse = ownerDraw-UI_BLUETEAM1 + 1;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 210
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 3242
;3242:	}
ADDRGP4 $2170
JUMPV
LABELV $2169
line 3244
;3243:	else
;3244:	{
line 3245
;3245:	  iUse = ownerDraw-274; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 274
SUBI4
ASGNI4
line 3246
;3246:	}
LABELV $2170
line 3248
;3247:
;3248:      UI_TeamMember_HandleKey(flags, special, key, qtrue, iUse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 3249
;3249:      break;
ADDRGP4 $2152
JUMPV
LABELV $2171
line 3258
;3250:    case UI_REDTEAM1:
;3251:		case UI_REDTEAM2:
;3252:		case UI_REDTEAM3:
;3253:		case UI_REDTEAM4:
;3254:		case UI_REDTEAM5:
;3255:		case UI_REDTEAM6:
;3256:		case UI_REDTEAM7:
;3257:		case UI_REDTEAM8:
;3258:	if (ownerDraw <= UI_REDTEAM5)
ADDRFP4 0
INDIRI4
CNSTI4 219
GTI4 $2172
line 3259
;3259:	{
line 3260
;3260:	  iUse = ownerDraw-UI_REDTEAM1 + 1;
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 215
SUBI4
CNSTI4 1
ADDI4
ASGNI4
line 3261
;3261:	}
ADDRGP4 $2173
JUMPV
LABELV $2172
line 3263
;3262:	else
;3263:	{
line 3264
;3264:	  iUse = ownerDraw-277; //unpleasent hack because I don't want to move up all the UI_BLAHTEAM# defines
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 277
SUBI4
ASGNI4
line 3265
;3265:	}
LABELV $2173
line 3266
;3266:      UI_TeamMember_HandleKey(flags, special, key, qfalse, iUse);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_TeamMember_HandleKey
CALLI4
pop
line 3267
;3267:      break;
ADDRGP4 $2152
JUMPV
LABELV $2174
line 3269
;3268:		case UI_NETSOURCE:
;3269:      UI_NetSource_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetSource_HandleKey
CALLI4
pop
line 3270
;3270:			break;
ADDRGP4 $2152
JUMPV
LABELV $2175
line 3272
;3271:		case UI_NETFILTER:
;3272:      UI_NetFilter_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_NetFilter_HandleKey
CALLI4
pop
line 3273
;3273:			break;
ADDRGP4 $2152
JUMPV
LABELV $2176
line 3275
;3274:		case UI_OPPONENT_NAME:
;3275:			UI_OpponentName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_OpponentName_HandleKey
CALLI4
pop
line 3276
;3276:			break;
ADDRGP4 $2152
JUMPV
LABELV $2177
line 3278
;3277:		case UI_BOTNAME:
;3278:			return UI_BotName_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 UI_BotName_HandleKey
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3279
;3279:			break;
LABELV $2178
line 3281
;3280:		case UI_BOTSKILL:
;3281:			return UI_BotSkill_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRLP4 72
ADDRGP4 UI_BotSkill_HandleKey
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
RETI4
ADDRGP4 $2150
JUMPV
line 3282
;3282:			break;
LABELV $2179
line 3284
;3283:		case UI_REDBLUE:
;3284:			UI_RedBlue_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_RedBlue_HandleKey
CALLI4
pop
line 3285
;3285:			break;
ADDRGP4 $2152
JUMPV
LABELV $2180
line 3287
;3286:		case UI_CROSSHAIR:
;3287:			UI_Crosshair_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_Crosshair_HandleKey
CALLI4
pop
line 3288
;3288:			break;
ADDRGP4 $2152
JUMPV
LABELV $2181
line 3290
;3289:		case UI_SELECTEDPLAYER:
;3290:			UI_SelectedPlayer_HandleKey(flags, special, key);
ADDRFP4 4
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
ADDRGP4 UI_SelectedPlayer_HandleKey
CALLI4
pop
line 3291
;3291:			break;
line 3293
;3292:    default:
;3293:      break;
LABELV $2152
line 3296
;3294:  }
;3295:
;3296:  return qfalse;
CNSTI4 0
RETI4
LABELV $2150
endproc UI_OwnerDrawHandleKey 76 28
proc UI_GetValue 0 0
line 3300
;3297:}
;3298:
;3299:
;3300:static float UI_GetValue(int ownerDraw) {
line 3301
;3301:  return 0;
CNSTF4 0
RETF4
LABELV $2184
endproc UI_GetValue 0 0
proc UI_ServersQsortCompare 4 20
line 3309
;3302:}
;3303:
;3304:/*
;3305:=================
;3306:UI_ServersQsortCompare
;3307:=================
;3308:*/
;3309:static int QDECL UI_ServersQsortCompare( const void *arg1, const void *arg2 ) {
line 3310
;3310:	return trap_LAN_CompareServers( ui_netSource.integer, uiInfo.serverStatus.sortKey, uiInfo.serverStatus.sortDir, *(int*)arg1, *(int*)arg2);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $2185
endproc UI_ServersQsortCompare 4 20
export UI_ServersSort
proc UI_ServersSort 0 16
line 3319
;3311:}
;3312:
;3313:
;3314:/*
;3315:=================
;3316:UI_ServersSort
;3317:=================
;3318:*/
;3319:void UI_ServersSort(int column, qboolean force) {
line 3321
;3320:
;3321:	if ( !force ) {
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $2192
line 3322
;3322:		if ( uiInfo.serverStatus.sortKey == column ) {
ADDRGP4 uiInfo+40604+2200
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $2194
line 3323
;3323:			return;
ADDRGP4 $2191
JUMPV
LABELV $2194
line 3325
;3324:		}
;3325:	}
LABELV $2192
line 3327
;3326:
;3327:	uiInfo.serverStatus.sortKey = column;
ADDRGP4 uiInfo+40604+2200
ADDRFP4 0
INDIRI4
ASGNI4
line 3328
;3328:	qsort( &uiInfo.serverStatus.displayServers[0], uiInfo.serverStatus.numDisplayServers, sizeof(int), UI_ServersQsortCompare);
ADDRGP4 uiInfo+40604+2220
ARGP4
ADDRGP4 uiInfo+40604+10412
INDIRI4
ARGI4
CNSTI4 4
ARGI4
ADDRGP4 UI_ServersQsortCompare
ARGP4
ADDRGP4 qsort
CALLV
pop
line 3329
;3329:}
LABELV $2191
endproc UI_ServersSort 0 16
proc UI_LoadMods 2092 16
line 3376
;3330:
;3331:/*
;3332:static void UI_StartSinglePlayer() {
;3333:	int i,j, k, skill;
;3334:	char buff[1024];
;3335:	i = trap_Cvar_VariableValue( "ui_currentTier" );
;3336:  if (i < 0 || i >= tierCount) {
;3337:    i = 0;
;3338:  }
;3339:	j = trap_Cvar_VariableValue("ui_currentMap");
;3340:	if (j < 0 || j > MAPS_PER_TIER) {
;3341:		j = 0;
;3342:	}
;3343:
;3344: 	trap_Cvar_SetValue( "singleplayer", 1 );
;3345: 	trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, 7, tierList[i].gameTypes[j] ) );
;3346:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", tierList[i].maps[j] ) );
;3347:	skill = trap_Cvar_VariableValue( "g_spSkill" );
;3348:
;3349:	if (j == MAPS_PER_TIER-1) {
;3350:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;3351:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[0]), skill, "", teamList[k].teamMembers[0]);
;3352:	} else {
;3353:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
;3354:		for (i = 0; i < PLAYERS_PER_TEAM; i++) {
;3355:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Blue", teamList[k].teamMembers[i]);
;3356:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;3357:		}
;3358:
;3359:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
;3360:		for (i = 1; i < PLAYERS_PER_TEAM; i++) {
;3361:			Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %i %s 250 %s\n", UI_AIFromName(teamList[k].teamMembers[i]), skill, "Red", teamList[k].teamMembers[i]);
;3362:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
;3363:		}
;3364:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
;3365:	}
;3366:	
;3367:
;3368:}
;3369:*/
;3370:
;3371:/*
;3372:===============
;3373:UI_LoadMods
;3374:===============
;3375:*/
;3376:static void UI_LoadMods() {
line 3384
;3377:	int		numdirs;
;3378:	char	dirlist[2048];
;3379:	char	*dirptr;
;3380:  char  *descptr;
;3381:	int		i;
;3382:	int		dirlen;
;3383:
;3384:	uiInfo.modCount = 0;
ADDRGP4 uiInfo+34172
CNSTI4 0
ASGNI4
line 3385
;3385:	numdirs = trap_FS_GetFileList( "$modlist", "", dirlist, sizeof(dirlist) );
ADDRGP4 $2206
ARGP4
ADDRGP4 $170
ARGP4
ADDRLP4 20
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2068
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 2068
INDIRI4
ASGNI4
line 3386
;3386:	dirptr  = dirlist;
ADDRLP4 0
ADDRLP4 20
ASGNP4
line 3387
;3387:	for( i = 0; i < numdirs; i++ ) {
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $2210
JUMPV
LABELV $2207
line 3388
;3388:		dirlen = strlen( dirptr ) + 1;
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2072
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 2072
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3389
;3389:    descptr = dirptr + dirlen;
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 3390
;3390:		uiInfo.modList[uiInfo.modCount].modName = String_Alloc(dirptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2076
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+34172
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+33660
ADDP4
ADDRLP4 2076
INDIRP4
ASGNP4
line 3391
;3391:		uiInfo.modList[uiInfo.modCount].modDescr = String_Alloc(descptr);
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2080
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRGP4 uiInfo+34172
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+33660+4
ADDP4
ADDRLP4 2080
INDIRP4
ASGNP4
line 3392
;3392:    dirptr += dirlen + strlen(descptr) + 1;
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 2084
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ADDRLP4 2084
INDIRI4
ADDI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 3393
;3393:		uiInfo.modCount++;
ADDRLP4 2088
ADDRGP4 uiInfo+34172
ASGNP4
ADDRLP4 2088
INDIRP4
ADDRLP4 2088
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3394
;3394:		if (uiInfo.modCount >= MAX_MODS) {
ADDRGP4 uiInfo+34172
INDIRI4
CNSTI4 64
LTI4 $2217
line 3395
;3395:			break;
ADDRGP4 $2209
JUMPV
LABELV $2217
line 3397
;3396:		}
;3397:	}
LABELV $2208
line 3387
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2210
ADDRLP4 12
INDIRI4
ADDRLP4 16
INDIRI4
LTI4 $2207
LABELV $2209
line 3399
;3398:
;3399:}
LABELV $2204
endproc UI_LoadMods 2092 16
proc UI_LoadMovies 4124 16
line 3407
;3400:
;3401:
;3402:/*
;3403:===============
;3404:UI_LoadMovies
;3405:===============
;3406:*/
;3407:static void UI_LoadMovies() {
line 3412
;3408:	char	movielist[4096];
;3409:	char	*moviename;
;3410:	int		i, len;
;3411:
;3412:	uiInfo.movieCount = trap_FS_GetFileList( "video", "roq", movielist, 4096 );
ADDRGP4 $2222
ARGP4
ADDRGP4 $2223
ARGP4
ADDRLP4 12
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4108
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+36236
ADDRLP4 4108
INDIRI4
ASGNI4
line 3414
;3413:
;3414:	if (uiInfo.movieCount) {
ADDRGP4 uiInfo+36236
INDIRI4
CNSTI4 0
EQI4 $2224
line 3415
;3415:		if (uiInfo.movieCount > MAX_MOVIES) {
ADDRGP4 uiInfo+36236
INDIRI4
CNSTI4 256
LEI4 $2227
line 3416
;3416:			uiInfo.movieCount = MAX_MOVIES;
ADDRGP4 uiInfo+36236
CNSTI4 256
ASGNI4
line 3417
;3417:		}
LABELV $2227
line 3418
;3418:		moviename = movielist;
ADDRLP4 0
ADDRLP4 12
ASGNP4
line 3419
;3419:		for ( i = 0; i < uiInfo.movieCount; i++ ) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $2234
JUMPV
LABELV $2231
line 3420
;3420:			len = strlen( moviename );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4112
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4112
INDIRI4
ASGNI4
line 3421
;3421:			if (!Q_stricmp(moviename +  len - 4,".roq")) {
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI4 -4
ADDP4
ARGP4
ADDRGP4 $2238
ARGP4
ADDRLP4 4116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4116
INDIRI4
CNSTI4 0
NEI4 $2236
line 3422
;3422:				moviename[len-4] = '\0';
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 3423
;3423:			}
LABELV $2236
line 3424
;3424:			Q_strupr(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3425
;3425:			uiInfo.movieList[i] = String_Alloc(moviename);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4120
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+35212
ADDP4
ADDRLP4 4120
INDIRP4
ASGNP4
line 3426
;3426:			moviename += len + 1;
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 3427
;3427:		}
LABELV $2232
line 3419
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2234
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+36236
INDIRI4
LTI4 $2231
line 3428
;3428:	}
LABELV $2224
line 3430
;3429:
;3430:}
LABELV $2220
endproc UI_LoadMovies 4124 16
proc UI_LoadDemos 4168 16
line 3439
;3431:
;3432:
;3433:
;3434:/*
;3435:===============
;3436:UI_LoadDemos
;3437:===============
;3438:*/
;3439:static void UI_LoadDemos() {
line 3445
;3440:	char	demolist[4096];
;3441:	char demoExt[32];
;3442:	char	*demoname;
;3443:	int		i, len;
;3444:
;3445:	Com_sprintf(demoExt, sizeof(demoExt), "dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2242
ARGP4
ADDRLP4 4140
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2241
ARGP4
ADDRLP4 4140
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3447
;3446:
;3447:	uiInfo.demoCount = trap_FS_GetFileList( "demos", demoExt, demolist, 4096 );
ADDRGP4 $2244
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 44
ARGP4
CNSTI4 4096
ARGI4
ADDRLP4 4144
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRGP4 uiInfo+35204
ADDRLP4 4144
INDIRI4
ASGNI4
line 3449
;3448:
;3449:	Com_sprintf(demoExt, sizeof(demoExt), ".dm_%d", (int)trap_Cvar_VariableValue("protocol"));
ADDRGP4 $2242
ARGP4
ADDRLP4 4148
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $2245
ARGP4
ADDRLP4 4148
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3451
;3450:
;3451:	if (uiInfo.demoCount) {
ADDRGP4 uiInfo+35204
INDIRI4
CNSTI4 0
EQI4 $2246
line 3452
;3452:		if (uiInfo.demoCount > MAX_DEMOS) {
ADDRGP4 uiInfo+35204
INDIRI4
CNSTI4 256
LEI4 $2249
line 3453
;3453:			uiInfo.demoCount = MAX_DEMOS;
ADDRGP4 uiInfo+35204
CNSTI4 256
ASGNI4
line 3454
;3454:		}
LABELV $2249
line 3455
;3455:		demoname = demolist;
ADDRLP4 0
ADDRLP4 44
ASGNP4
line 3456
;3456:		for ( i = 0; i < uiInfo.demoCount; i++ ) {
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRGP4 $2256
JUMPV
LABELV $2253
line 3457
;3457:			len = strlen( demoname );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4152
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 4152
INDIRI4
ASGNI4
line 3458
;3458:			if (!Q_stricmp(demoname +  len - strlen(demoExt), demoExt)) {
ADDRLP4 4
ARGP4
ADDRLP4 4156
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 0
INDIRP4
ADDP4
ADDRLP4 4156
INDIRI4
SUBP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 4160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4160
INDIRI4
CNSTI4 0
NEI4 $2258
line 3459
;3459:				demoname[len-strlen(demoExt)] = '\0';
ADDRLP4 4
ARGP4
ADDRLP4 4164
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 4164
INDIRI4
SUBI4
ADDRLP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 3460
;3460:			}
LABELV $2258
line 3461
;3461:			Q_strupr(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 Q_strupr
CALLP4
pop
line 3462
;3462:			uiInfo.demoList[i] = String_Alloc(demoname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 4164
ADDRGP4 String_Alloc
CALLP4
ASGNP4
ADDRLP4 40
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+34180
ADDP4
ADDRLP4 4164
INDIRP4
ASGNP4
line 3463
;3463:			demoname += len + 1;
ADDRLP4 0
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
line 3464
;3464:		}
LABELV $2254
line 3456
ADDRLP4 40
ADDRLP4 40
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2256
ADDRLP4 40
INDIRI4
ADDRGP4 uiInfo+35204
INDIRI4
LTI4 $2253
line 3465
;3465:	}
LABELV $2246
line 3467
;3466:
;3467:}
LABELV $2240
endproc UI_LoadDemos 4168 16
proc UI_SetNextMap 8 16
line 3470
;3468:
;3469:
;3470:static qboolean UI_SetNextMap(int actual, int index) {
line 3472
;3471:	int i;
;3472:	for (i = actual + 1; i < uiInfo.mapCount; i++) {
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $2265
JUMPV
LABELV $2262
line 3473
;3473:		if (uiInfo.mapList[i].active) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2267
line 3474
;3474:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, index + 1, "skirmish");
CNSTP4 0
ARGP4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ARGI4
ADDRGP4 $2271
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3475
;3475:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2261
JUMPV
LABELV $2267
line 3477
;3476:		}
;3477:	}
LABELV $2263
line 3472
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2265
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LTI4 $2262
line 3478
;3478:	return qfalse;
CNSTI4 0
RETI4
LABELV $2261
endproc UI_SetNextMap 8 16
proc UI_StartSkirmish 1180 32
line 3482
;3479:}
;3480:
;3481:
;3482:static void UI_StartSkirmish(qboolean next) {
line 3487
;3483:	int i, k, g, delay, temp;
;3484:	float skill;
;3485:	char buff[MAX_STRING_CHARS];
;3486:
;3487:	temp = trap_Cvar_VariableValue( "g_gametype" );
ADDRGP4 $1015
ARGP4
ADDRLP4 1048
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1048
INDIRF4
CVFI4 4
ASGNI4
line 3488
;3488:	trap_Cvar_Set("ui_gameType", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1052
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1899
ARGP4
ADDRLP4 1052
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3490
;3489:
;3490:	if (next) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2273
line 3492
;3491:		int actual;
;3492:		int index = trap_Cvar_VariableValue("ui_mapIndex");
ADDRGP4 $2275
ARGP4
ADDRLP4 1064
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1056
ADDRLP4 1064
INDIRF4
CVFI4 4
ASGNI4
line 3493
;3493:	 	UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3494
;3494:		UI_SelectedMap(index, &actual);
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1060
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 3495
;3495:		if (UI_SetNextMap(actual, index)) {
ADDRLP4 1060
INDIRI4
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRLP4 1068
ADDRGP4 UI_SetNextMap
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
EQI4 $2276
line 3496
;3496:		} else {
ADDRGP4 $2277
JUMPV
LABELV $2276
line 3497
;3497:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
ADDRLP4 1072
CNSTI4 0
ASGNI4
ADDRLP4 1072
INDIRI4
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
ADDRLP4 1072
INDIRI4
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3498
;3498:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3499
;3499:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, 0, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 $2271
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3500
;3500:		}
LABELV $2277
line 3501
;3501:	}
LABELV $2273
line 3503
;3502:
;3503:	g = uiInfo.gameTypes[ui_gameType.integer].gtEnum;
ADDRLP4 1040
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ASGNI4
line 3504
;3504:	trap_Cvar_SetValue( "g_gametype", g );
ADDRGP4 $1015
ARGP4
ADDRLP4 1040
INDIRI4
CVIF4 4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3505
;3505:	trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName) );
ADDRGP4 $2281
ARGP4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1056
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1056
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3506
;3506:	skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $809
ARGP4
ADDRLP4 1060
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1044
ADDRLP4 1060
INDIRF4
ASGNF4
line 3507
;3507:	trap_Cvar_Set("ui_scoreMap", uiInfo.mapList[ui_currentMap.integer].mapName);
ADDRGP4 $2285
ARGP4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3509
;3508:
;3509:	k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 1064
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1064
INDIRP4
ARGP4
ADDRLP4 1068
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1068
INDIRI4
ASGNI4
line 3511
;3510:
;3511:	trap_Cvar_Set("ui_singlePlayerActive", "1");
ADDRGP4 $2288
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3514
;3512:
;3513:	// set up sp overrides, will be replaced on postgame
;3514:	temp = trap_Cvar_VariableValue( "capturelimit" );
ADDRGP4 $687
ARGP4
ADDRLP4 1072
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1072
INDIRF4
CVFI4 4
ASGNI4
line 3515
;3515:	trap_Cvar_Set("ui_saveCaptureLimit", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2289
ARGP4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3516
;3516:	temp = trap_Cvar_VariableValue( "fraglimit" );
ADDRGP4 $688
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1080
INDIRF4
CVFI4 4
ASGNI4
line 3517
;3517:	trap_Cvar_Set("ui_saveFragLimit", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2290
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3518
;3518:	temp = trap_Cvar_VariableValue( "duel_fraglimit" );
ADDRGP4 $2291
ARGP4
ADDRLP4 1088
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1088
INDIRF4
CVFI4 4
ASGNI4
line 3519
;3519:	trap_Cvar_Set("ui_saveDuelLimit", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1092
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2292
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3521
;3520:
;3521:	UI_SetCapFragLimits(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 3523
;3522:
;3523:	temp = trap_Cvar_VariableValue( "cg_drawTimer" );
ADDRGP4 $2293
ARGP4
ADDRLP4 1096
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1096
INDIRF4
CVFI4 4
ASGNI4
line 3524
;3524:	trap_Cvar_Set("ui_drawTimer", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2294
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3525
;3525:	temp = trap_Cvar_VariableValue( "g_doWarmup" );
ADDRGP4 $2295
ARGP4
ADDRLP4 1104
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1104
INDIRF4
CVFI4 4
ASGNI4
line 3526
;3526:	trap_Cvar_Set("ui_doWarmup", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2296
ARGP4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3527
;3527:	temp = trap_Cvar_VariableValue( "g_friendlyFire" );
ADDRGP4 $2297
ARGP4
ADDRLP4 1112
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1112
INDIRF4
CVFI4 4
ASGNI4
line 3528
;3528:	trap_Cvar_Set("ui_friendlyFire", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2298
ARGP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3529
;3529:	temp = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $887
ARGP4
ADDRLP4 1120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1120
INDIRF4
CVFI4 4
ASGNI4
line 3530
;3530:	trap_Cvar_Set("ui_maxClients", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2299
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3531
;3531:	temp = trap_Cvar_VariableValue( "g_warmup" );
ADDRGP4 $2300
ARGP4
ADDRLP4 1128
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1128
INDIRF4
CVFI4 4
ASGNI4
line 3532
;3532:	trap_Cvar_Set("ui_Warmup", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1132
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2301
ARGP4
ADDRLP4 1132
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3533
;3533:	temp = trap_Cvar_VariableValue( "sv_pure" );
ADDRGP4 $2302
ARGP4
ADDRLP4 1136
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1028
ADDRLP4 1136
INDIRF4
CVFI4 4
ASGNI4
line 3534
;3534:	trap_Cvar_Set("ui_pure", va("%i", temp));
ADDRGP4 $1314
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2303
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3536
;3535:
;3536:	trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $332
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3537
;3537:	trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $334
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3538
;3538:	trap_Cvar_Set("cg_drawTimer", "1");
ADDRGP4 $2293
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3539
;3539:	trap_Cvar_Set("g_doWarmup", "1");
ADDRGP4 $2295
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3540
;3540:	trap_Cvar_Set("g_warmup", "15");
ADDRGP4 $2300
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3541
;3541:	trap_Cvar_Set("sv_pure", "0");
ADDRGP4 $2302
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3542
;3542:	trap_Cvar_Set("g_friendlyFire", "0");
ADDRGP4 $2297
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3543
;3543:	trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1144
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2304
ARGP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3544
;3544:	trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 1148
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2305
ARGP4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3546
;3545:
;3546:	if (trap_Cvar_VariableValue("ui_recordSPDemo")) {
ADDRGP4 $2308
ARGP4
ADDRLP4 1152
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1152
INDIRF4
CNSTF4 0
EQF4 $2306
line 3547
;3547:		Com_sprintf(buff, MAX_STRING_CHARS, "%s_%i", uiInfo.mapList[ui_currentMap.integer].mapLoadName, g);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2309
ARGP4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1040
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3548
;3548:		trap_Cvar_Set("ui_recordSPDemoName", buff);
ADDRGP4 $2313
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3549
;3549:	}
LABELV $2306
line 3551
;3550:
;3551:	delay = 500;
ADDRLP4 1036
CNSTI4 500
ASGNI4
line 3553
;3552:
;3553:	if (g == GT_TOURNAMENT) {
ADDRLP4 1040
INDIRI4
CNSTI4 3
NEI4 $2314
line 3554
;3554:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1028
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3555
;3555:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $685
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1156
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $887
ARGP4
ADDRLP4 1156
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3556
;3556:		Com_sprintf( buff, sizeof(buff), "wait ; addbot %s %f "", %i \n", uiInfo.mapList[ui_currentMap.integer].opponentName, skill, delay);
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2319
ARGP4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 3557
;3557:		trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3558
;3558:	} else if (g == GT_HOLOCRON || g == GT_JEDIMASTER) {
ADDRGP4 $2315
JUMPV
LABELV $2314
ADDRLP4 1040
INDIRI4
CNSTI4 1
EQI4 $2325
ADDRLP4 1040
INDIRI4
CNSTI4 2
NEI4 $2323
LABELV $2325
line 3559
;3559:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1028
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3560
;3560:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $685
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1160
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $887
ARGP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3561
;3561:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2332
JUMPV
LABELV $2329
line 3562
;3562:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_HOLOCRON) ? "" : "Blue", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1168
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2336
ARGP4
ADDRLP4 1168
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 1
NEI4 $2342
ADDRLP4 1164
ADDRGP4 $170
ASGNP4
ADDRGP4 $2343
JUMPV
LABELV $2342
ADDRLP4 1164
ADDRGP4 $875
ASGNP4
LABELV $2343
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3563
;3563:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3564
;3564:			delay += 500;
ADDRLP4 1036
ADDRLP4 1036
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3565
;3565:		}
LABELV $2330
line 3561
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2332
ADDRLP4 0
INDIRI4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
LTI4 $2329
line 3566
;3566:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1164
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1168
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1168
INDIRI4
ASGNI4
line 3567
;3567:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers-1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2347
JUMPV
LABELV $2344
line 3568
;3568:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_HOLOCRON) ? "" : "Red", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1176
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2336
ARGP4
ADDRLP4 1176
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 1
NEI4 $2356
ADDRLP4 1172
ADDRGP4 $170
ASGNP4
ADDRGP4 $2357
JUMPV
LABELV $2356
ADDRLP4 1172
ADDRGP4 $876
ASGNP4
LABELV $2357
ADDRLP4 1172
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3569
;3569:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3570
;3570:			delay += 500;
ADDRLP4 1036
ADDRLP4 1036
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3571
;3571:		}
LABELV $2345
line 3567
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2347
ADDRLP4 0
INDIRI4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2344
line 3572
;3572:	} else {
ADDRGP4 $2324
JUMPV
LABELV $2323
line 3573
;3573:		temp = uiInfo.mapList[ui_currentMap.integer].teamMembers * 2;
ADDRLP4 1028
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3574
;3574:		trap_Cvar_Set("sv_maxClients", va("%d", temp));
ADDRGP4 $685
ARGP4
ADDRLP4 1028
INDIRI4
ARGI4
ADDRLP4 1160
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $887
ARGP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3575
;3575:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2364
JUMPV
LABELV $2361
line 3576
;3576:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Blue", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1168
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2336
ARGP4
ADDRLP4 1168
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2373
ADDRLP4 1164
ADDRGP4 $170
ASGNP4
ADDRGP4 $2374
JUMPV
LABELV $2373
ADDRLP4 1164
ADDRGP4 $875
ASGNP4
LABELV $2374
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3577
;3577:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3578
;3578:			delay += 500;
ADDRLP4 1036
ADDRLP4 1036
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3579
;3579:		}
LABELV $2362
line 3575
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2364
ADDRLP4 0
INDIRI4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
LTI4 $2361
line 3580
;3580:		k = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1164
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1168
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1168
INDIRI4
ASGNI4
line 3581
;3581:		for (i =0; i < uiInfo.mapList[ui_currentMap.integer].teamMembers-1; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2378
JUMPV
LABELV $2375
line 3582
;3582:			Com_sprintf( buff, sizeof(buff), "addbot %s %f %s %i %s\n", UI_AIFromName(uiInfo.teamList[k].teamMembers[i]), skill, (g == GT_FFA) ? "" : "Red", delay, uiInfo.teamList[k].teamMembers[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1176
ADDRGP4 UI_AIFromName
CALLP4
ASGNP4
ADDRLP4 4
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2336
ARGP4
ADDRLP4 1176
INDIRP4
ARGP4
ADDRLP4 1044
INDIRF4
ARGF4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2387
ADDRLP4 1172
ADDRGP4 $170
ASGNP4
ADDRGP4 $2388
JUMPV
LABELV $2387
ADDRLP4 1172
ADDRGP4 $876
ASGNP4
LABELV $2388
ADDRLP4 1172
INDIRP4
ARGP4
ADDRLP4 1036
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 1032
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3583
;3583:			trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3584
;3584:			delay += 500;
ADDRLP4 1036
ADDRLP4 1036
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 3585
;3585:		}
LABELV $2376
line 3581
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2378
ADDRLP4 0
INDIRI4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
LTI4 $2375
line 3586
;3586:	}
LABELV $2324
LABELV $2315
line 3587
;3587:	if (g >= GT_TEAM ) {
ADDRLP4 1040
INDIRI4
CNSTI4 5
LTI4 $2389
line 3588
;3588:		trap_Cmd_ExecuteText( EXEC_APPEND, "wait 5; team Red\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2391
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3589
;3589:	}
LABELV $2389
line 3590
;3590:}
LABELV $2272
endproc UI_StartSkirmish 1180 32
proc UI_Update 40 8
line 3592
;3591:
;3592:static void UI_Update(const char *name) {
line 3593
;3593:	int	val = trap_Cvar_VariableValue(name);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 4
INDIRF4
CVFI4 4
ASGNI4
line 3595
;3594:
;3595:	if (Q_stricmp(name, "s_khz") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2395
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2393
line 3596
;3596:	{
line 3597
;3597:		trap_Cmd_ExecuteText( EXEC_APPEND, "snd_restart\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2396
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3598
;3598:		return;
ADDRGP4 $2392
JUMPV
LABELV $2393
line 3601
;3599:	}
;3600:
;3601: 	if (Q_stricmp(name, "ui_SetName") == 0) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2399
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2397
line 3602
;3602:		trap_Cvar_Set( "name", UI_Cvar_VariableString("ui_Name"));
ADDRGP4 $2401
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2400
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3603
;3603: 	} else if (Q_stricmp(name, "ui_setRate") == 0) {
ADDRGP4 $2398
JUMPV
LABELV $2397
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2404
ARGP4
ADDRLP4 16
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2402
line 3604
;3604:		float rate = trap_Cvar_VariableValue("rate");
ADDRGP4 $2405
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 24
INDIRF4
ASGNF4
line 3605
;3605:		if (rate >= 5000) {
ADDRLP4 20
INDIRF4
CNSTF4 1167867904
LTF4 $2406
line 3606
;3606:			trap_Cvar_Set("cl_maxpackets", "30");
ADDRGP4 $2408
ARGP4
ADDRGP4 $671
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3607
;3607:			trap_Cvar_Set("cl_packetdup", "1");
ADDRGP4 $2409
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3608
;3608:		} else if (rate >= 4000) {
ADDRGP4 $2403
JUMPV
LABELV $2406
ADDRLP4 20
INDIRF4
CNSTF4 1165623296
LTF4 $2410
line 3609
;3609:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2408
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3610
;3610:			trap_Cvar_Set("cl_packetdup", "2");		// favor less prediction errors when there's packet loss
ADDRGP4 $2409
ARGP4
ADDRGP4 $2412
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3611
;3611:		} else {
ADDRGP4 $2403
JUMPV
LABELV $2410
line 3612
;3612:			trap_Cvar_Set("cl_maxpackets", "15");
ADDRGP4 $2408
ARGP4
ADDRGP4 $674
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3613
;3613:			trap_Cvar_Set("cl_packetdup", "1");		// favor lower bandwidth
ADDRGP4 $2409
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3614
;3614:		}
line 3615
;3615: 	} 
ADDRGP4 $2403
JUMPV
LABELV $2402
line 3616
;3616:	else if (Q_stricmp(name, "ui_GetName") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2415
ARGP4
ADDRLP4 20
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2413
line 3617
;3617:	{
line 3618
;3618:		trap_Cvar_Set( "ui_Name", UI_Cvar_VariableString("name"));
ADDRGP4 $2400
ARGP4
ADDRLP4 24
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2401
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3619
;3619:	}
ADDRGP4 $2414
JUMPV
LABELV $2413
line 3620
;3620:	else if (Q_stricmp(name, "ui_r_colorbits") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2418
ARGP4
ADDRLP4 24
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2416
line 3621
;3621:	{
line 3622
;3622:		switch (val) 
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
CNSTI4 16
ASGNI4
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
EQI4 $2423
ADDRLP4 28
INDIRI4
ADDRLP4 32
INDIRI4
GTI4 $2426
LABELV $2425
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $2421
ADDRGP4 $2417
JUMPV
LABELV $2426
ADDRLP4 0
INDIRI4
CNSTI4 32
EQI4 $2424
ADDRGP4 $2417
JUMPV
line 3623
;3623:		{
LABELV $2421
line 3625
;3624:			case 0:
;3625:				trap_Cvar_SetValue( "ui_r_depthbits", 0 );
ADDRGP4 $2422
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3626
;3626:				break;
ADDRGP4 $2417
JUMPV
LABELV $2423
line 3629
;3627:
;3628:			case 16:
;3629:				trap_Cvar_SetValue( "ui_r_depthbits", 16 );
ADDRGP4 $2422
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3630
;3630:				break;
ADDRGP4 $2417
JUMPV
LABELV $2424
line 3633
;3631:
;3632:			case 32:
;3633:				trap_Cvar_SetValue( "ui_r_depthbits", 24 );
ADDRGP4 $2422
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3634
;3634:				break;
line 3636
;3635:		}
;3636:	} 
ADDRGP4 $2417
JUMPV
LABELV $2416
line 3637
;3637:	else if (Q_stricmp(name, "ui_r_lodbias") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2429
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $2427
line 3638
;3638:	{
line 3639
;3639:		switch (val) 
ADDRLP4 32
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2432
ADDRLP4 32
INDIRI4
CNSTI4 1
EQI4 $2434
ADDRLP4 32
INDIRI4
CNSTI4 2
EQI4 $2435
ADDRGP4 $2428
JUMPV
line 3640
;3640:		{
LABELV $2432
line 3642
;3641:			case 0:
;3642:				trap_Cvar_SetValue( "ui_r_subdivisions", 4 );
ADDRGP4 $2433
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3643
;3643:				break;
ADDRGP4 $2428
JUMPV
LABELV $2434
line 3645
;3644:			case 1:
;3645:				trap_Cvar_SetValue( "ui_r_subdivisions", 12 );
ADDRGP4 $2433
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3646
;3646:				break;
ADDRGP4 $2428
JUMPV
LABELV $2435
line 3649
;3647:
;3648:			case 2:
;3649:				trap_Cvar_SetValue( "ui_r_subdivisions", 20 );
ADDRGP4 $2433
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3650
;3650:				break;
line 3652
;3651:		}
;3652:	} 
ADDRGP4 $2428
JUMPV
LABELV $2427
line 3653
;3653:	else if (Q_stricmp(name, "ui_r_glCustom") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2438
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2436
line 3654
;3654:	{
line 3655
;3655:		switch (val) 
ADDRLP4 36
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
LTI4 $2437
ADDRLP4 36
INDIRI4
CNSTI4 3
GTI4 $2437
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2454
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2454
address $2441
address $2450
address $2451
address $2453
code
line 3656
;3656:		{
LABELV $2441
line 3659
;3657:			case 0:	// high quality
;3658:
;3659:				trap_Cvar_SetValue( "ui_r_fullScreen", 1 );
ADDRGP4 $2442
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3660
;3660:				trap_Cvar_SetValue( "ui_r_subdivisions", 4 );
ADDRGP4 $2433
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3661
;3661:				trap_Cvar_SetValue( "ui_r_lodbias", 0 );
ADDRGP4 $2429
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3662
;3662:				trap_Cvar_SetValue( "ui_r_colorbits", 32 );
ADDRGP4 $2418
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3663
;3663:				trap_Cvar_SetValue( "ui_r_depthbits", 24 );
ADDRGP4 $2422
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3664
;3664:				trap_Cvar_SetValue( "ui_r_picmip", 0 );
ADDRGP4 $2443
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3665
;3665:				trap_Cvar_SetValue( "ui_r_mode", 4 );
ADDRGP4 $2444
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3666
;3666:				trap_Cvar_SetValue( "ui_r_texturebits", 32 );
ADDRGP4 $2445
ARGP4
CNSTF4 1107296256
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3667
;3667:				trap_Cvar_SetValue( "ui_r_fastSky", 0 );
ADDRGP4 $2446
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3668
;3668:				trap_Cvar_SetValue( "ui_r_inGameVideo", 1 );
ADDRGP4 $2447
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3670
;3669:				//trap_Cvar_SetValue( "ui_cg_shadows", 2 );//stencil
;3670:				trap_Cvar_Set( "ui_r_texturemode", "GL_LINEAR_MIPMAP_LINEAR" );
ADDRGP4 $2448
ARGP4
ADDRGP4 $2449
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3671
;3671:				break;
ADDRGP4 $2437
JUMPV
LABELV $2450
line 3674
;3672:
;3673:			case 1: // normal 
;3674:				trap_Cvar_SetValue( "ui_r_fullScreen", 1 );
ADDRGP4 $2442
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3675
;3675:				trap_Cvar_SetValue( "ui_r_subdivisions", 4 );
ADDRGP4 $2433
ARGP4
CNSTF4 1082130432
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3676
;3676:				trap_Cvar_SetValue( "ui_r_lodbias", 0 );
ADDRGP4 $2429
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3677
;3677:				trap_Cvar_SetValue( "ui_r_colorbits", 0 );
ADDRGP4 $2418
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3678
;3678:				trap_Cvar_SetValue( "ui_r_depthbits", 24 );
ADDRGP4 $2422
ARGP4
CNSTF4 1103101952
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3679
;3679:				trap_Cvar_SetValue( "ui_r_picmip", 1 );
ADDRGP4 $2443
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3680
;3680:				trap_Cvar_SetValue( "ui_r_mode", 3 );
ADDRGP4 $2444
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3681
;3681:				trap_Cvar_SetValue( "ui_r_texturebits", 0 );
ADDRGP4 $2445
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3682
;3682:				trap_Cvar_SetValue( "ui_r_fastSky", 0 );
ADDRGP4 $2446
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3683
;3683:				trap_Cvar_SetValue( "ui_r_inGameVideo", 1 );
ADDRGP4 $2447
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3685
;3684:				//trap_Cvar_SetValue( "ui_cg_shadows", 2 );
;3685:				trap_Cvar_Set( "ui_r_texturemode", "GL_LINEAR_MIPMAP_LINEAR" );
ADDRGP4 $2448
ARGP4
ADDRGP4 $2449
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3686
;3686:				break;
ADDRGP4 $2437
JUMPV
LABELV $2451
line 3690
;3687:
;3688:			case 2: // fast
;3689:
;3690:				trap_Cvar_SetValue( "ui_r_fullScreen", 1 );
ADDRGP4 $2442
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3691
;3691:				trap_Cvar_SetValue( "ui_r_subdivisions", 12 );
ADDRGP4 $2433
ARGP4
CNSTF4 1094713344
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3692
;3692:				trap_Cvar_SetValue( "ui_r_lodbias", 1 );
ADDRGP4 $2429
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3693
;3693:				trap_Cvar_SetValue( "ui_r_colorbits", 0 );
ADDRGP4 $2418
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3694
;3694:				trap_Cvar_SetValue( "ui_r_depthbits", 0 );
ADDRGP4 $2422
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3695
;3695:				trap_Cvar_SetValue( "ui_r_picmip", 2 );
ADDRGP4 $2443
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3696
;3696:				trap_Cvar_SetValue( "ui_r_mode", 3 );
ADDRGP4 $2444
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3697
;3697:				trap_Cvar_SetValue( "ui_r_texturebits", 0 );
ADDRGP4 $2445
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3698
;3698:				trap_Cvar_SetValue( "ui_r_fastSky", 1 );
ADDRGP4 $2446
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3699
;3699:				trap_Cvar_SetValue( "ui_r_inGameVideo", 0 );
ADDRGP4 $2447
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3701
;3700:				//trap_Cvar_SetValue( "ui_cg_shadows", 1 );
;3701:				trap_Cvar_Set( "ui_r_texturemode", "GL_LINEAR_MIPMAP_NEAREST" );
ADDRGP4 $2448
ARGP4
ADDRGP4 $2452
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3702
;3702:				break;
ADDRGP4 $2437
JUMPV
LABELV $2453
line 3706
;3703:
;3704:			case 3: // fastest
;3705:
;3706:				trap_Cvar_SetValue( "ui_r_fullScreen", 1 );
ADDRGP4 $2442
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3707
;3707:				trap_Cvar_SetValue( "ui_r_subdivisions", 20 );
ADDRGP4 $2433
ARGP4
CNSTF4 1101004800
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3708
;3708:				trap_Cvar_SetValue( "ui_r_lodbias", 2 );
ADDRGP4 $2429
ARGP4
CNSTF4 1073741824
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3709
;3709:				trap_Cvar_SetValue( "ui_r_colorbits", 16 );
ADDRGP4 $2418
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3710
;3710:				trap_Cvar_SetValue( "ui_r_depthbits", 16 );
ADDRGP4 $2422
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3711
;3711:				trap_Cvar_SetValue( "ui_r_mode", 3 );
ADDRGP4 $2444
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3712
;3712:				trap_Cvar_SetValue( "ui_r_picmip", 3 );
ADDRGP4 $2443
ARGP4
CNSTF4 1077936128
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3713
;3713:				trap_Cvar_SetValue( "ui_r_texturebits", 16 );
ADDRGP4 $2445
ARGP4
CNSTF4 1098907648
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3714
;3714:				trap_Cvar_SetValue( "ui_r_fastSky", 1 );
ADDRGP4 $2446
ARGP4
CNSTF4 1065353216
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3715
;3715:				trap_Cvar_SetValue( "ui_r_inGameVideo", 0 );
ADDRGP4 $2447
ARGP4
CNSTF4 0
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3717
;3716:				//trap_Cvar_SetValue( "ui_cg_shadows", 0 );
;3717:				trap_Cvar_Set( "ui_r_texturemode", "GL_LINEAR_MIPMAP_NEAREST" );
ADDRGP4 $2448
ARGP4
ADDRGP4 $2452
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3718
;3718:			break;
line 3720
;3719:		}
;3720:	} 
ADDRGP4 $2437
JUMPV
LABELV $2436
line 3721
;3721:	else if (Q_stricmp(name, "ui_mousePitch") == 0) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2457
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $2455
line 3722
;3722:	{
line 3723
;3723:		if (val == 0) 
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2458
line 3724
;3724:		{
line 3725
;3725:			trap_Cvar_SetValue( "m_pitch", 0.022f );
ADDRGP4 $2460
ARGP4
CNSTF4 1018444120
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3726
;3726:		} 
ADDRGP4 $2459
JUMPV
LABELV $2458
line 3728
;3727:		else 
;3728:		{
line 3729
;3729:			trap_Cvar_SetValue( "m_pitch", -0.022f );
ADDRGP4 $2460
ARGP4
CNSTF4 3165927768
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3730
;3730:		}
LABELV $2459
line 3731
;3731:	}
LABELV $2455
LABELV $2437
LABELV $2428
LABELV $2417
LABELV $2414
LABELV $2403
LABELV $2398
line 3732
;3732:}
LABELV $2392
endproc UI_Update 40 8
data
export gUISelectedMap
align 4
LABELV gUISelectedMap
byte 4 0
code
proc UI_DeferMenuScript 32 8
line 3744
;3733:
;3734:int gUISelectedMap = 0;
;3735:
;3736:/*
;3737:===============
;3738:UI_DeferMenuScript
;3739:
;3740:Return true if the menu script should be deferred for later
;3741:===============
;3742:*/
;3743:static qboolean UI_DeferMenuScript ( char **args )
;3744:{
line 3748
;3745:	const char* name;
;3746:
;3747:	// Whats the reason for being deferred?
;3748:	if (!String_Parse( (char**)args, &name)) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $2462
line 3749
;3749:	{
line 3750
;3750:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2461
JUMPV
LABELV $2462
line 3754
;3751:	}
;3752:
;3753:	// Handle the custom cases
;3754:	if ( !Q_stricmp ( name, "VideoSetup" ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $2466
ARGP4
ADDRLP4 8
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $2464
line 3755
;3755:	{
line 3760
;3756:		const char* warningMenuName;
;3757:		qboolean	deferred;
;3758:
;3759:		// No warning menu specified
;3760:		if ( !String_Parse( (char**)args, &warningMenuName) )
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $2467
line 3761
;3761:		{
line 3762
;3762:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $2461
JUMPV
LABELV $2467
line 3766
;3763:		}
;3764:
;3765:		// Defer if the video options were modified
;3766:		deferred = trap_Cvar_VariableValue ( "ui_r_modified" ) ? qtrue : qfalse;
ADDRGP4 $2469
ARGP4
ADDRLP4 28
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 28
INDIRF4
CNSTF4 0
EQF4 $2471
ADDRLP4 24
CNSTI4 1
ASGNI4
ADDRGP4 $2472
JUMPV
LABELV $2471
ADDRLP4 24
CNSTI4 0
ASGNI4
LABELV $2472
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 3768
;3767:
;3768:		if ( deferred )
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2473
line 3769
;3769:		{
line 3771
;3770:			// Open the warning menu
;3771:			Menus_OpenByName(warningMenuName);
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 3772
;3772:		}
LABELV $2473
line 3774
;3773:
;3774:		return deferred;
ADDRLP4 12
INDIRI4
RETI4
ADDRGP4 $2461
JUMPV
LABELV $2464
line 3776
;3775:	}
;3776:	else if ( !Q_stricmp ( name, "RulesBackout" ) )
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $2477
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2475
line 3777
;3777:	{
line 3780
;3778:		qboolean deferred;
;3779:		
;3780:		deferred = trap_Cvar_VariableValue ( "ui_rules_backout" ) ? qtrue : qfalse ;
ADDRGP4 $2478
ARGP4
ADDRLP4 24
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 0
EQF4 $2480
ADDRLP4 20
CNSTI4 1
ASGNI4
ADDRGP4 $2481
JUMPV
LABELV $2480
ADDRLP4 20
CNSTI4 0
ASGNI4
LABELV $2481
ADDRLP4 16
ADDRLP4 20
INDIRI4
ASGNI4
line 3782
;3781:
;3782:		trap_Cvar_Set ( "ui_rules_backout", "0" );
ADDRGP4 $2478
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3784
;3783:
;3784:		return deferred;
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $2461
JUMPV
LABELV $2475
line 3787
;3785:	}
;3786:
;3787:	return qfalse;
CNSTI4 0
RETI4
LABELV $2461
endproc UI_DeferMenuScript 32 8
export UI_UpdateVideoSetup
proc UI_UpdateVideoSetup 60 8
line 3800
;3788:}
;3789:
;3790:/*
;3791:=================
;3792:UI_UpdateVideoSetup
;3793:
;3794:Copies the temporary user interface version of the video cvars into
;3795:their real counterparts.  This is to create a interface which allows 
;3796:you to discard your changes if you did something you didnt want
;3797:=================
;3798:*/
;3799:void UI_UpdateVideoSetup ( void )
;3800:{
line 3801
;3801:	trap_Cvar_Set ( "r_mode", UI_Cvar_VariableString ( "ui_r_mode" ) );
ADDRGP4 $2444
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2483
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3802
;3802:	trap_Cvar_Set ( "r_fullscreen", UI_Cvar_VariableString ( "ui_r_fullscreen" ) );
ADDRGP4 $2485
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2484
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3803
;3803:	trap_Cvar_Set ( "r_colorbits", UI_Cvar_VariableString ( "ui_r_colorbits" ) );
ADDRGP4 $2418
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2486
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3804
;3804:	trap_Cvar_Set ( "r_lodbias", UI_Cvar_VariableString ( "ui_r_lodbias" ) );
ADDRGP4 $2429
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2487
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3805
;3805:	trap_Cvar_Set ( "r_picmip", UI_Cvar_VariableString ( "ui_r_picmip" ) );
ADDRGP4 $2443
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2488
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3806
;3806:	trap_Cvar_Set ( "r_texturebits", UI_Cvar_VariableString ( "ui_r_texturebits" ) );
ADDRGP4 $2445
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2489
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3807
;3807:	trap_Cvar_Set ( "r_texturemode", UI_Cvar_VariableString ( "ui_r_texturemode" ) );
ADDRGP4 $2448
ARGP4
ADDRLP4 24
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2490
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3808
;3808:	trap_Cvar_Set ( "r_detailtextures", UI_Cvar_VariableString ( "ui_r_detailtextures" ) );
ADDRGP4 $2492
ARGP4
ADDRLP4 28
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2491
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3809
;3809:	trap_Cvar_Set ( "r_ext_compress_textures", UI_Cvar_VariableString ( "ui_r_ext_compress_textures" ) );
ADDRGP4 $2494
ARGP4
ADDRLP4 32
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2493
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3810
;3810:	trap_Cvar_Set ( "r_depthbits", UI_Cvar_VariableString ( "ui_r_depthbits" ) );
ADDRGP4 $2422
ARGP4
ADDRLP4 36
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2495
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3811
;3811:	trap_Cvar_Set ( "r_subdivisions", UI_Cvar_VariableString ( "ui_r_subdivisions" ) );
ADDRGP4 $2433
ARGP4
ADDRLP4 40
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2496
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3812
;3812:	trap_Cvar_Set ( "r_fastSky", UI_Cvar_VariableString ( "ui_r_fastSky" ) );
ADDRGP4 $2446
ARGP4
ADDRLP4 44
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2497
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3813
;3813:	trap_Cvar_Set ( "r_inGameVideo", UI_Cvar_VariableString ( "ui_r_inGameVideo" ) );
ADDRGP4 $2447
ARGP4
ADDRLP4 48
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2498
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3814
;3814:	trap_Cvar_Set ( "r_allowExtensions", UI_Cvar_VariableString ( "ui_r_allowExtensions" ) );
ADDRGP4 $2500
ARGP4
ADDRLP4 52
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2499
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3815
;3815:	trap_Cvar_Set ( "cg_shadows", UI_Cvar_VariableString ( "ui_cg_shadows" ) );
ADDRGP4 $2502
ARGP4
ADDRLP4 56
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2501
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3816
;3816:	trap_Cvar_Set ( "ui_r_modified", "0" );
ADDRGP4 $2469
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3818
;3817:
;3818:	trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $2503
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3819
;3819:}
LABELV $2482
endproc UI_UpdateVideoSetup 60 8
export UI_GetVideoSetup
proc UI_GetVideoSetup 60 16
line 3830
;3820:
;3821:/*
;3822:=================
;3823:UI_GetVideoSetup
;3824:
;3825:Retrieves the current actual video settings into the temporary user
;3826:interface versions of the cvars.
;3827:=================
;3828:*/
;3829:void UI_GetVideoSetup ( void )
;3830:{
line 3832
;3831:	// Make sure the cvars are registered as read only.
;3832:	trap_Cvar_Register ( NULL, "ui_r_glCustom",				"4", CVAR_ROM|CVAR_INTERNAL|CVAR_ARCHIVE );
CNSTP4 0
ARGP4
ADDRGP4 $2438
ARGP4
ADDRGP4 $2505
ARGP4
CNSTI4 2113
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3834
;3833:
;3834:	trap_Cvar_Register ( NULL, "ui_r_mode",					"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2444
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3835
;3835:	trap_Cvar_Register ( NULL, "ui_r_fullscreen",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2485
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3836
;3836:	trap_Cvar_Register ( NULL, "ui_r_colorbits",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2418
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3837
;3837:	trap_Cvar_Register ( NULL, "ui_r_lodbias",				"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2429
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3838
;3838:	trap_Cvar_Register ( NULL, "ui_r_picmip",				"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2443
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3839
;3839:	trap_Cvar_Register ( NULL, "ui_r_texturebits",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2445
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3840
;3840:	trap_Cvar_Register ( NULL, "ui_r_texturemode",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2448
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3841
;3841:	trap_Cvar_Register ( NULL, "ui_r_detailtextures",		"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2492
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3842
;3842:	trap_Cvar_Register ( NULL, "ui_r_ext_compress_textures","0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2494
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3843
;3843:	trap_Cvar_Register ( NULL, "ui_r_depthbits",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2422
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3844
;3844:	trap_Cvar_Register ( NULL, "ui_r_subdivisions",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2433
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3845
;3845:	trap_Cvar_Register ( NULL, "ui_r_fastSky",				"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2446
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3846
;3846:	trap_Cvar_Register ( NULL, "ui_r_inGameVideo",			"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2447
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3847
;3847:	trap_Cvar_Register ( NULL, "ui_r_allowExtensions",		"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2500
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3848
;3848:	trap_Cvar_Register ( NULL, "ui_cg_shadows",				"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2502
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3849
;3849:	trap_Cvar_Register ( NULL, "ui_r_modified",				"0", CVAR_ROM|CVAR_INTERNAL );
CNSTP4 0
ARGP4
ADDRGP4 $2469
ARGP4
ADDRGP4 $333
ARGP4
CNSTI4 2112
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 3852
;3850:	
;3851:	// Copy over the real video cvars into their temporary counterparts
;3852:	trap_Cvar_Set ( "ui_r_mode",		UI_Cvar_VariableString ( "r_mode" ) );
ADDRGP4 $2483
ARGP4
ADDRLP4 0
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2444
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3853
;3853:	trap_Cvar_Set ( "ui_r_colorbits",	UI_Cvar_VariableString ( "r_colorbits" ) );
ADDRGP4 $2486
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2418
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3854
;3854:	trap_Cvar_Set ( "ui_r_fullscreen",	UI_Cvar_VariableString ( "r_fullscreen" ) );
ADDRGP4 $2484
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2485
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3855
;3855:	trap_Cvar_Set ( "ui_r_lodbias",		UI_Cvar_VariableString ( "r_lodbias" ) );
ADDRGP4 $2487
ARGP4
ADDRLP4 12
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2429
ARGP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3856
;3856:	trap_Cvar_Set ( "ui_r_picmip",		UI_Cvar_VariableString ( "r_picmip" ) );
ADDRGP4 $2488
ARGP4
ADDRLP4 16
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2443
ARGP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3857
;3857:	trap_Cvar_Set ( "ui_r_texturebits", UI_Cvar_VariableString ( "r_texturebits" ) );
ADDRGP4 $2489
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2445
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3858
;3858:	trap_Cvar_Set ( "ui_r_texturemode", UI_Cvar_VariableString ( "r_texturemode" ) );
ADDRGP4 $2490
ARGP4
ADDRLP4 24
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2448
ARGP4
ADDRLP4 24
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3859
;3859:	trap_Cvar_Set ( "ui_r_detailtextures", UI_Cvar_VariableString ( "r_detailtextures" ) );
ADDRGP4 $2491
ARGP4
ADDRLP4 28
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2492
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3860
;3860:	trap_Cvar_Set ( "ui_r_ext_compress_textures", UI_Cvar_VariableString ( "r_ext_compress_textures" ) );
ADDRGP4 $2493
ARGP4
ADDRLP4 32
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2494
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3861
;3861:	trap_Cvar_Set ( "ui_r_depthbits", UI_Cvar_VariableString ( "r_depthbits" ) );
ADDRGP4 $2495
ARGP4
ADDRLP4 36
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2422
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3862
;3862:	trap_Cvar_Set ( "ui_r_subdivisions", UI_Cvar_VariableString ( "r_subdivisions" ) );
ADDRGP4 $2496
ARGP4
ADDRLP4 40
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2433
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3863
;3863:	trap_Cvar_Set ( "ui_r_fastSky", UI_Cvar_VariableString ( "r_fastSky" ) );
ADDRGP4 $2497
ARGP4
ADDRLP4 44
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2446
ARGP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3864
;3864:	trap_Cvar_Set ( "ui_r_inGameVideo", UI_Cvar_VariableString ( "r_inGameVideo" ) );
ADDRGP4 $2498
ARGP4
ADDRLP4 48
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2447
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3865
;3865:	trap_Cvar_Set ( "ui_r_allowExtensions", UI_Cvar_VariableString ( "r_allowExtensions" ) );
ADDRGP4 $2499
ARGP4
ADDRLP4 52
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2500
ARGP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3866
;3866:	trap_Cvar_Set ( "ui_cg_shadows", UI_Cvar_VariableString ( "cg_shadows" ) );
ADDRGP4 $2501
ARGP4
ADDRLP4 56
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2502
ARGP4
ADDRLP4 56
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3867
;3867:	trap_Cvar_Set ( "ui_r_modified", "0" );
ADDRGP4 $2469
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3868
;3868:}
LABELV $2504
endproc UI_GetVideoSetup 60 16
proc UI_RunMenuScript 1300 24
line 3871
;3869:
;3870:static void UI_RunMenuScript(char **args) 
;3871:{
line 3875
;3872:	const char *name, *name2;
;3873:	char buff[1024];
;3874:
;3875:	if (String_Parse(args, &name)) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1024
ARGP4
ADDRLP4 1032
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1032
INDIRI4
CNSTI4 0
EQI4 $2507
line 3876
;3876:	{
line 3877
;3877:		if (Q_stricmp(name, "StartServer") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2511
ARGP4
ADDRLP4 1036
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1036
INDIRI4
CNSTI4 0
NEI4 $2509
line 3878
;3878:		{
line 3879
;3879:			int i, added = 0;
ADDRLP4 1044
CNSTI4 0
ASGNI4
line 3881
;3880:			float skill;
;3881:			int warmupTime = 0;
ADDRLP4 1048
CNSTI4 0
ASGNI4
line 3882
;3882:			int doWarmup = 0;
ADDRLP4 1056
CNSTI4 0
ASGNI4
line 3884
;3883:
;3884:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $334
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3885
;3885:			trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $332
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3886
;3886:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2288
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3887
;3887:			trap_Cvar_SetValue( "dedicated", Com_Clamp( 0, 2, ui_dedicated.integer ) );
CNSTF4 0
ARGF4
CNSTF4 1073741824
ARGF4
ADDRGP4 ui_dedicated+12
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1060
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $2512
ARGP4
ADDRLP4 1060
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3888
;3888:			trap_Cvar_SetValue( "g_gametype", Com_Clamp( 0, 8, uiInfo.gameTypes[ui_netGameType.integer].gtEnum ) );
CNSTF4 0
ARGF4
CNSTF4 1090519040
ARGF4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
CVIF4 4
ARGF4
ADDRLP4 1064
ADDRGP4 Com_Clamp
CALLF4
ASGNF4
ADDRGP4 $1015
ARGP4
ADDRLP4 1064
INDIRF4
ARGF4
ADDRGP4 trap_Cvar_SetValue
CALLV
pop
line 3889
;3889:			trap_Cvar_Set("g_redTeam", UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 1068
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2304
ARGP4
ADDRLP4 1068
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3890
;3890:			trap_Cvar_Set("g_blueTeam", UI_Cvar_VariableString("ui_opponentName"));
ADDRGP4 $1143
ARGP4
ADDRLP4 1072
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRGP4 $2305
ARGP4
ADDRLP4 1072
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3891
;3891:			trap_Cmd_ExecuteText( EXEC_APPEND, va( "wait ; wait ; map %s\n", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName ) );
ADDRGP4 $2281
ARGP4
CNSTI4 100
ADDRGP4 ui_currentNetMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1076
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1076
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3892
;3892:			skill = trap_Cvar_VariableValue( "g_spSkill" );
ADDRGP4 $809
ARGP4
ADDRLP4 1080
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1052
ADDRLP4 1080
INDIRF4
ASGNF4
line 3895
;3893:
;3894:			//Cap the warmup values in case the user tries a dumb setting.
;3895:			warmupTime = trap_Cvar_VariableValue( "g_warmup" );
ADDRGP4 $2300
ARGP4
ADDRLP4 1084
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1048
ADDRLP4 1084
INDIRF4
CVFI4 4
ASGNI4
line 3896
;3896:			doWarmup = trap_Cvar_VariableValue( "g_doWarmup" );
ADDRGP4 $2295
ARGP4
ADDRLP4 1088
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1056
ADDRLP4 1088
INDIRF4
CVFI4 4
ASGNI4
line 3898
;3897:
;3898:			if (doWarmup && warmupTime < 1)
ADDRLP4 1056
INDIRI4
CNSTI4 0
EQI4 $2520
ADDRLP4 1048
INDIRI4
CNSTI4 1
GEI4 $2520
line 3899
;3899:			{
line 3900
;3900:				trap_Cvar_Set("g_doWarmup", "0");
ADDRGP4 $2295
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3901
;3901:			}
LABELV $2520
line 3902
;3902:			if (warmupTime < 5)
ADDRLP4 1048
INDIRI4
CNSTI4 5
GEI4 $2522
line 3903
;3903:			{
line 3904
;3904:				trap_Cvar_Set("g_warmup", "5");
ADDRGP4 $2300
ARGP4
ADDRGP4 $676
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3905
;3905:			}
LABELV $2522
line 3906
;3906:			if (warmupTime > 120)
ADDRLP4 1048
INDIRI4
CNSTI4 120
LEI4 $2524
line 3907
;3907:			{
line 3908
;3908:				trap_Cvar_Set("g_warmup", "120");
ADDRGP4 $2300
ARGP4
ADDRGP4 $2526
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3909
;3909:			}
LABELV $2524
line 3911
;3910:
;3911:			if (trap_Cvar_VariableValue( "g_gametype" ) == GT_TOURNAMENT)
ADDRGP4 $1015
ARGP4
ADDRLP4 1092
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1092
INDIRF4
CNSTF4 1077936128
NEF4 $2527
line 3912
;3912:			{ //always set fraglimit 1 when starting a duel game
line 3913
;3913:				trap_Cvar_Set("fraglimit", "1");
ADDRGP4 $688
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3914
;3914:			}
LABELV $2527
line 3916
;3915:
;3916:			for (i = 0; i < PLAYERS_PER_TEAM; i++) 
ADDRLP4 1040
CNSTI4 0
ASGNI4
LABELV $2529
line 3917
;3917:			{
line 3918
;3918:				int bot = trap_Cvar_VariableValue( va("ui_blueteam%i", i+1));
ADDRGP4 $882
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1104
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1104
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1096
ADDRLP4 1108
INDIRF4
CVFI4 4
ASGNI4
line 3919
;3919:				int maxcl = trap_Cvar_VariableValue( "sv_maxClients" );
ADDRGP4 $887
ARGP4
ADDRLP4 1112
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1100
ADDRLP4 1112
INDIRF4
CVFI4 4
ASGNI4
line 3921
;3920:
;3921:				if (bot > 1) 
ADDRLP4 1096
INDIRI4
CNSTI4 1
LEI4 $2533
line 3922
;3922:				{
line 3923
;3923:					int numval = i+1;
ADDRLP4 1116
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3925
;3924:
;3925:					numval *= 2;
ADDRLP4 1116
ADDRLP4 1116
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3927
;3926:
;3927:					numval -= 1;
ADDRLP4 1116
ADDRLP4 1116
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3929
;3928:
;3929:					if (numval <= maxcl)
ADDRLP4 1116
INDIRI4
ADDRLP4 1100
INDIRI4
GTI4 $2535
line 3930
;3930:					{
line 3931
;3931:						if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 5
LTI4 $2537
line 3932
;3932:							Com_sprintf( buff, sizeof(buff), "addbot %s %f %s\n", UI_GetBotNameByNumber(bot-2), skill, "Blue");
ADDRLP4 1096
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1120
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2540
ARGP4
ADDRLP4 1120
INDIRP4
ARGP4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRGP4 $875
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3933
;3933:						} else {
ADDRGP4 $2538
JUMPV
LABELV $2537
line 3934
;3934:							Com_sprintf( buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot-2), skill);
ADDRLP4 1096
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1120
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2541
ARGP4
ADDRLP4 1120
INDIRP4
ARGP4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 3935
;3935:						}
LABELV $2538
line 3936
;3936:						trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3937
;3937:						added++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3938
;3938:					}
LABELV $2535
line 3939
;3939:				}
LABELV $2533
line 3940
;3940:				bot = trap_Cvar_VariableValue( va("ui_redteam%i", i+1));
ADDRGP4 $883
ARGP4
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1116
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1116
INDIRP4
ARGP4
ADDRLP4 1120
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1096
ADDRLP4 1120
INDIRF4
CVFI4 4
ASGNI4
line 3941
;3941:				if (bot > 1) {
ADDRLP4 1096
INDIRI4
CNSTI4 1
LEI4 $2542
line 3942
;3942:					int numval = i+1;
ADDRLP4 1124
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3944
;3943:
;3944:					numval *= 2;
ADDRLP4 1124
ADDRLP4 1124
INDIRI4
CNSTI4 1
LSHI4
ASGNI4
line 3946
;3945:
;3946:					if (numval <= maxcl)
ADDRLP4 1124
INDIRI4
ADDRLP4 1100
INDIRI4
GTI4 $2544
line 3947
;3947:					{
line 3948
;3948:						if (ui_actualNetGameType.integer >= GT_TEAM) {
ADDRGP4 ui_actualNetGameType+12
INDIRI4
CNSTI4 5
LTI4 $2546
line 3949
;3949:							Com_sprintf( buff, sizeof(buff), "addbot %s %f %s\n", UI_GetBotNameByNumber(bot-2), skill, "Red");
ADDRLP4 1096
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1128
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2540
ARGP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRGP4 $876
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 3950
;3950:						} else {
ADDRGP4 $2547
JUMPV
LABELV $2546
line 3951
;3951:							Com_sprintf( buff, sizeof(buff), "addbot %s %f \n", UI_GetBotNameByNumber(bot-2), skill);
ADDRLP4 1096
INDIRI4
CNSTI4 2
SUBI4
ARGI4
ADDRLP4 1128
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2541
ARGP4
ADDRLP4 1128
INDIRP4
ARGP4
ADDRLP4 1052
INDIRF4
ARGF4
ADDRGP4 Com_sprintf
CALLV
pop
line 3952
;3952:						}
LABELV $2547
line 3953
;3953:						trap_Cmd_ExecuteText( EXEC_APPEND, buff );
CNSTI4 2
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3954
;3954:						added++;
ADDRLP4 1044
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3955
;3955:					}
LABELV $2544
line 3956
;3956:				}
LABELV $2542
line 3957
;3957:				if (added >= maxcl)
ADDRLP4 1044
INDIRI4
ADDRLP4 1100
INDIRI4
LTI4 $2549
line 3958
;3958:				{ //this means the client filled up all their slots in the UI with bots. So stretch out an extra slot for them, and then stop adding bots.
line 3959
;3959:					trap_Cvar_Set("sv_maxClients", va("%i", added+1));
ADDRGP4 $1314
ARGP4
ADDRLP4 1044
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRLP4 1124
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $887
ARGP4
ADDRLP4 1124
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3960
;3960:					break;
ADDRGP4 $2510
JUMPV
LABELV $2549
line 3962
;3961:				}
;3962:			}
LABELV $2530
line 3916
ADDRLP4 1040
ADDRLP4 1040
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 8
LTI4 $2529
line 3963
;3963:		} else if (Q_stricmp(name, "updateSPMenu") == 0) {
ADDRGP4 $2510
JUMPV
LABELV $2509
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2553
ARGP4
ADDRLP4 1040
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $2551
line 3964
;3964:			UI_SetCapFragLimits(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_SetCapFragLimits
CALLV
pop
line 3965
;3965:			UI_MapCountByGameType(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 3966
;3966:			ui_mapIndex.integer = UI_GetIndexFromSelection(ui_currentMap.integer);
ADDRGP4 ui_currentMap+12
INDIRI4
ARGI4
ADDRLP4 1044
ADDRGP4 UI_GetIndexFromSelection
CALLI4
ASGNI4
ADDRGP4 ui_mapIndex+12
ADDRLP4 1044
INDIRI4
ASGNI4
line 3967
;3967:			trap_Cvar_Set("ui_mapIndex", va("%d", ui_mapIndex.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRLP4 1048
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2275
ARGP4
ADDRLP4 1048
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3968
;3968:			Menu_SetFeederSelection(NULL, FEEDER_MAPS, ui_mapIndex.integer, "skirmish");
CNSTP4 0
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 ui_mapIndex+12
INDIRI4
ARGI4
ADDRGP4 $2271
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 3969
;3969:			UI_GameType_HandleKey(0, 0, K_MOUSE1, qfalse);
ADDRLP4 1052
CNSTI4 0
ASGNI4
ADDRLP4 1052
INDIRI4
ARGI4
CNSTP4 0
ARGP4
CNSTI4 178
ARGI4
ADDRLP4 1052
INDIRI4
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3970
;3970:			UI_GameType_HandleKey(0, 0, K_MOUSE2, qfalse);
ADDRLP4 1056
CNSTI4 0
ASGNI4
ADDRLP4 1056
INDIRI4
ARGI4
CNSTP4 0
ARGP4
CNSTI4 179
ARGI4
ADDRLP4 1056
INDIRI4
ARGI4
ADDRGP4 UI_GameType_HandleKey
CALLI4
pop
line 3971
;3971:		} else if (Q_stricmp(name, "resetDefaults") == 0) {
ADDRGP4 $2552
JUMPV
LABELV $2551
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2560
ARGP4
ADDRLP4 1044
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1044
INDIRI4
CNSTI4 0
NEI4 $2558
line 3972
;3972:			trap_Cmd_ExecuteText( EXEC_APPEND, "exec mpdefault.cfg\n");
CNSTI4 2
ARGI4
ADDRGP4 $2561
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3973
;3973:			trap_Cmd_ExecuteText( EXEC_APPEND, "cvar_restart\n");
CNSTI4 2
ARGI4
ADDRGP4 $2562
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 3974
;3974:			Controls_SetDefaults();
ADDRGP4 Controls_SetDefaults
CALLV
pop
line 3975
;3975:			trap_Cvar_Set("com_introPlayed", "1" );
ADDRGP4 $2563
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 3976
;3976:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2564
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4010
;3977:#ifdef USE_CD_KEY
;3978:		} else if (Q_stricmp(name, "getCDKey") == 0) {
;3979:			char out[17];
;3980:			trap_GetCDKey(buff, 17);
;3981:			trap_Cvar_Set("cdkey1", "");
;3982:			trap_Cvar_Set("cdkey2", "");
;3983:			trap_Cvar_Set("cdkey3", "");
;3984:			trap_Cvar_Set("cdkey4", "");
;3985:			if (strlen(buff) == CDKEY_LEN) {
;3986:				Q_strncpyz(out, buff, 5);
;3987:				trap_Cvar_Set("cdkey1", out);
;3988:				Q_strncpyz(out, buff + 4, 5);
;3989:				trap_Cvar_Set("cdkey2", out);
;3990:				Q_strncpyz(out, buff + 8, 5);
;3991:				trap_Cvar_Set("cdkey3", out);
;3992:				Q_strncpyz(out, buff + 12, 5);
;3993:				trap_Cvar_Set("cdkey4", out);
;3994:			}
;3995:
;3996:		} else if (Q_stricmp(name, "verifyCDKey") == 0) {
;3997:			buff[0] = '\0';
;3998:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey1")); 
;3999:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey2")); 
;4000:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey3")); 
;4001:			Q_strcat(buff, 1024, UI_Cvar_VariableString("cdkey4")); 
;4002:			trap_Cvar_Set("cdkey", buff);
;4003:			if (trap_VerifyCDKey(buff, UI_Cvar_VariableString("cdkeychecksum"))) {
;4004:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key Appears to be valid.");
;4005:				trap_SetCDKey(buff);
;4006:			} else {
;4007:				trap_Cvar_Set("ui_cdkeyvalid", "CD Key does not appear to be valid.");
;4008:			}
;4009:#endif // USE_CD_KEY
;4010:		} else if (Q_stricmp(name, "loadArenas") == 0) {
ADDRGP4 $2559
JUMPV
LABELV $2558
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2567
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $2565
line 4011
;4011:			UI_LoadArenas();
ADDRGP4 UI_LoadArenas
CALLV
pop
line 4012
;4012:			UI_MapCountByGameType(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_MapCountByGameType
CALLI4
pop
line 4013
;4013:			Menu_SetFeederSelection(NULL, FEEDER_ALLMAPS, gUISelectedMap, "createserver");
CNSTP4 0
ARGP4
CNSTI4 4
ARGI4
ADDRGP4 gUISelectedMap
INDIRI4
ARGI4
ADDRGP4 $2568
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4014
;4014:			uiForceRank = trap_Cvar_VariableValue("g_maxForceRank");
ADDRGP4 $2569
ARGP4
ADDRLP4 1052
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiForceRank
ADDRLP4 1052
INDIRF4
CVFI4 4
ASGNI4
line 4015
;4015:		} else if (Q_stricmp(name, "saveControls") == 0) {
ADDRGP4 $2566
JUMPV
LABELV $2565
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2572
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $2570
line 4016
;4016:			Controls_SetConfig(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 Controls_SetConfig
CALLV
pop
line 4017
;4017:		} else if (Q_stricmp(name, "loadControls") == 0) {
ADDRGP4 $2571
JUMPV
LABELV $2570
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2575
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $2573
line 4018
;4018:			Controls_GetConfig();
ADDRGP4 Controls_GetConfig
CALLV
pop
line 4019
;4019:		} else if (Q_stricmp(name, "clearError") == 0) {
ADDRGP4 $2574
JUMPV
LABELV $2573
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2578
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $2576
line 4020
;4020:			trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2579
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4021
;4021:		} else if (Q_stricmp(name, "loadGameInfo") == 0) {
ADDRGP4 $2577
JUMPV
LABELV $2576
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2582
ARGP4
ADDRLP4 1064
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1064
INDIRI4
CNSTI4 0
NEI4 $2580
line 4025
;4022:#ifdef PRE_RELEASE_TADEMO
;4023:			UI_ParseGameInfo("demogameinfo.txt");
;4024:#else
;4025:			UI_ParseGameInfo("ui/jk2mp/gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 4027
;4026:#endif
;4027:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 4028
;4028:		} else if (Q_stricmp(name, "resetScores") == 0) {
ADDRGP4 $2581
JUMPV
LABELV $2580
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2591
ARGP4
ADDRLP4 1068
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1068
INDIRI4
CNSTI4 0
NEI4 $2589
line 4029
;4029:			UI_ClearScores();
ADDRGP4 UI_ClearScores
CALLV
pop
line 4030
;4030:		} else if (Q_stricmp(name, "RefreshServers") == 0) {
ADDRGP4 $2590
JUMPV
LABELV $2589
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2594
ARGP4
ADDRLP4 1072
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $2592
line 4031
;4031:			UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 4032
;4032:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 4033
;4033:		} else if (Q_stricmp(name, "RefreshFilter") == 0) {
ADDRGP4 $2593
JUMPV
LABELV $2592
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2597
ARGP4
ADDRLP4 1076
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1076
INDIRI4
CNSTI4 0
NEI4 $2595
line 4034
;4034:			UI_StartServerRefresh(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 4035
;4035:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 4036
;4036:		} else if (Q_stricmp(name, "RunSPDemo") == 0) {
ADDRGP4 $2596
JUMPV
LABELV $2595
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2600
ARGP4
ADDRLP4 1080
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1080
INDIRI4
CNSTI4 0
NEI4 $2598
line 4037
;4037:			if (uiInfo.demoAvailable) {
ADDRGP4 uiInfo+11824
INDIRI4
CNSTI4 0
EQI4 $2599
line 4038
;4038:			  trap_Cmd_ExecuteText( EXEC_APPEND, va("demo %s_%i\n", uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum));
ADDRGP4 $2604
ARGP4
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1084
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4039
;4039:			}
line 4040
;4040:		} else if (Q_stricmp(name, "LoadDemos") == 0) {
ADDRGP4 $2599
JUMPV
LABELV $2598
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2613
ARGP4
ADDRLP4 1084
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1084
INDIRI4
CNSTI4 0
NEI4 $2611
line 4041
;4041:			UI_LoadDemos();
ADDRGP4 UI_LoadDemos
CALLV
pop
line 4042
;4042:		} else if (Q_stricmp(name, "LoadMovies") == 0) {
ADDRGP4 $2612
JUMPV
LABELV $2611
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2616
ARGP4
ADDRLP4 1088
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1088
INDIRI4
CNSTI4 0
NEI4 $2614
line 4043
;4043:			UI_LoadMovies();
ADDRGP4 UI_LoadMovies
CALLV
pop
line 4044
;4044:		} else if (Q_stricmp(name, "LoadMods") == 0) {
ADDRGP4 $2615
JUMPV
LABELV $2614
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2619
ARGP4
ADDRLP4 1092
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1092
INDIRI4
CNSTI4 0
NEI4 $2617
line 4045
;4045:			UI_LoadMods();
ADDRGP4 UI_LoadMods
CALLV
pop
line 4046
;4046:		} else if (Q_stricmp(name, "playMovie") == 0) {
ADDRGP4 $2618
JUMPV
LABELV $2617
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2622
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
NEI4 $2620
line 4047
;4047:			if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+36244
INDIRI4
CNSTI4 0
LTI4 $2623
line 4048
;4048:			  trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+36244
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 4049
;4049:			}
LABELV $2623
line 4050
;4050:			trap_Cmd_ExecuteText( EXEC_APPEND, va("cinematic %s.roq 2\n", uiInfo.movieList[uiInfo.movieIndex]));
ADDRGP4 $2627
ARGP4
ADDRGP4 uiInfo+36240
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+35212
ADDP4
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4051
;4051:		} else if (Q_stricmp(name, "RunMod") == 0) {
ADDRGP4 $2621
JUMPV
LABELV $2620
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2632
ARGP4
ADDRLP4 1100
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $2630
line 4052
;4052:			trap_Cvar_Set( "fs_game", uiInfo.modList[uiInfo.modIndex].modName);
ADDRGP4 $2633
ARGP4
ADDRGP4 uiInfo+34176
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+33660
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4053
;4053:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $2503
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4054
;4054:		} else if (Q_stricmp(name, "RunDemo") == 0) {
ADDRGP4 $2631
JUMPV
LABELV $2630
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2638
ARGP4
ADDRLP4 1104
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1104
INDIRI4
CNSTI4 0
NEI4 $2636
line 4055
;4055:			trap_Cmd_ExecuteText( EXEC_APPEND, va("demo \"%s\"\n", uiInfo.demoList[uiInfo.demoIndex]));
ADDRGP4 $2639
ARGP4
ADDRGP4 uiInfo+35208
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+34180
ADDP4
INDIRP4
ARGP4
ADDRLP4 1108
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1108
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4056
;4056:		} else if (Q_stricmp(name, "Quake3") == 0) {
ADDRGP4 $2637
JUMPV
LABELV $2636
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2644
ARGP4
ADDRLP4 1108
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1108
INDIRI4
CNSTI4 0
NEI4 $2642
line 4057
;4057:			trap_Cvar_Set( "fs_game", "");
ADDRGP4 $2633
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4058
;4058:			trap_Cmd_ExecuteText( EXEC_APPEND, "vid_restart;" );
CNSTI4 2
ARGI4
ADDRGP4 $2503
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4059
;4059:		} else if (Q_stricmp(name, "closeJoin") == 0) {
ADDRGP4 $2643
JUMPV
LABELV $2642
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2647
ARGP4
ADDRLP4 1112
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1112
INDIRI4
CNSTI4 0
NEI4 $2645
line 4060
;4060:			if (uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+40604+2212
INDIRI4
CNSTI4 0
EQI4 $2648
line 4061
;4061:				UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 4062
;4062:				uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+40604+10420
CNSTI4 0
ASGNI4
line 4063
;4063:				uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+55388
CNSTI4 0
ASGNI4
line 4064
;4064:				uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+60716
CNSTI4 0
ASGNI4
line 4065
;4065:				UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 4066
;4066:			} else {
ADDRGP4 $2646
JUMPV
LABELV $2648
line 4067
;4067:				Menus_CloseByName("joinserver");
ADDRGP4 $2656
ARGP4
ADDRGP4 Menus_CloseByName
CALLV
pop
line 4068
;4068:				Menus_OpenByName("main");
ADDRGP4 $2657
ARGP4
ADDRGP4 Menus_OpenByName
CALLV
pop
line 4069
;4069:			}
line 4070
;4070:		} else if (Q_stricmp(name, "StopRefresh") == 0) {
ADDRGP4 $2646
JUMPV
LABELV $2645
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2660
ARGP4
ADDRLP4 1116
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1116
INDIRI4
CNSTI4 0
NEI4 $2658
line 4071
;4071:			UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 4072
;4072:			uiInfo.serverStatus.nextDisplayRefresh = 0;
ADDRGP4 uiInfo+40604+10420
CNSTI4 0
ASGNI4
line 4073
;4073:			uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+55388
CNSTI4 0
ASGNI4
line 4074
;4074:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+60716
CNSTI4 0
ASGNI4
line 4075
;4075:		} else if (Q_stricmp(name, "UpdateFilter") == 0) {
ADDRGP4 $2659
JUMPV
LABELV $2658
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2667
ARGP4
ADDRLP4 1120
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1120
INDIRI4
CNSTI4 0
NEI4 $2665
line 4076
;4076:			if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $2668
line 4077
;4077:				UI_StartServerRefresh(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartServerRefresh
CALLV
pop
line 4078
;4078:			}
LABELV $2668
line 4079
;4079:			UI_BuildServerDisplayList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 4080
;4080:			UI_FeederSelection(FEEDER_SERVERS, 0);
CNSTF4 1073741824
ARGF4
CNSTI4 0
ARGI4
ADDRGP4 UI_FeederSelection
CALLI4
pop
line 4081
;4081:		} else if (Q_stricmp(name, "ServerStatus") == 0) {
ADDRGP4 $2666
JUMPV
LABELV $2665
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2673
ARGP4
ADDRLP4 1124
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1124
INDIRI4
CNSTI4 0
NEI4 $2671
line 4082
;4082:			trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], uiInfo.serverStatusAddress, sizeof(uiInfo.serverStatusAddress));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 uiInfo+52088
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 4083
;4083:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 4084
;4084:		} else if (Q_stricmp(name, "FoundPlayerServerStatus") == 0) {
ADDRGP4 $2672
JUMPV
LABELV $2671
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2683
ARGP4
ADDRLP4 1128
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1128
INDIRI4
CNSTI4 0
NEI4 $2681
line 4085
;4085:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+52088
ARGP4
ADDRGP4 uiInfo+60708
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+58660
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4086
;4086:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 4087
;4087:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4088
;4088:		} else if (Q_stricmp(name, "FindPlayer") == 0) {
ADDRGP4 $2682
JUMPV
LABELV $2681
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2690
ARGP4
ADDRLP4 1132
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1132
INDIRI4
CNSTI4 0
NEI4 $2688
line 4089
;4089:			UI_BuildFindPlayerList(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildFindPlayerList
CALLV
pop
line 4091
;4090:			// clear the displayed server status info
;4091:			uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+52152+3232
CNSTI4 0
ASGNI4
line 4092
;4092:			Menu_SetFeederSelection(NULL, FEEDER_FINDPLAYER, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4093
;4093:		} else if (Q_stricmp(name, "JoinServer") == 0) {
ADDRGP4 $2689
JUMPV
LABELV $2688
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2695
ARGP4
ADDRLP4 1136
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 0
NEI4 $2693
line 4094
;4094:			trap_Cvar_Set("cg_thirdPerson", "0");
ADDRGP4 $334
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4095
;4095:			trap_Cvar_Set("cg_cameraOrbit", "0");
ADDRGP4 $332
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4096
;4096:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2288
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4097
;4097:			if (uiInfo.serverStatus.currentServer >= 0 && uiInfo.serverStatus.currentServer < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+40604+2216
INDIRI4
CNSTI4 0
LTI4 $2694
ADDRGP4 uiInfo+40604+2216
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
GEI4 $2694
line 4098
;4098:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, 1024);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 4099
;4099:				trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", buff ) );
ADDRGP4 $2709
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1140
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4100
;4100:			}
line 4101
;4101:		} else if (Q_stricmp(name, "FoundPlayerJoinServer") == 0) {
ADDRGP4 $2694
JUMPV
LABELV $2693
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2712
ARGP4
ADDRLP4 1140
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $2710
line 4102
;4102:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2288
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4103
;4103:			if (uiInfo.currentFoundPlayerServer >= 0 && uiInfo.currentFoundPlayerServer < uiInfo.numFoundPlayerServers) {
ADDRGP4 uiInfo+60708
INDIRI4
CNSTI4 0
LTI4 $2711
ADDRGP4 uiInfo+60708
INDIRI4
ADDRGP4 uiInfo+60712
INDIRI4
GEI4 $2711
line 4104
;4104:				trap_Cmd_ExecuteText( EXEC_APPEND, va( "connect %s\n", uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer] ) );
ADDRGP4 $2709
ARGP4
ADDRGP4 uiInfo+60708
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+58660
ADDP4
ARGP4
ADDRLP4 1144
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4105
;4105:			}
line 4106
;4106:		} else if (Q_stricmp(name, "Quit") == 0) {
ADDRGP4 $2711
JUMPV
LABELV $2710
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2722
ARGP4
ADDRLP4 1144
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1144
INDIRI4
CNSTI4 0
NEI4 $2720
line 4107
;4107:			trap_Cvar_Set("ui_singlePlayerActive", "0");
ADDRGP4 $2288
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4108
;4108:			trap_Cmd_ExecuteText( EXEC_NOW, "quit");
CNSTI4 0
ARGI4
ADDRGP4 $2723
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4109
;4109:		} else if (Q_stricmp(name, "Controls") == 0) {
ADDRGP4 $2721
JUMPV
LABELV $2720
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2726
ARGP4
ADDRLP4 1148
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
NEI4 $2724
line 4110
;4110:		  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4111
;4111:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4112
;4112:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4113
;4113:			Menus_ActivateByName("setup_menu2");
ADDRGP4 $2728
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 4114
;4114:		} 
ADDRGP4 $2725
JUMPV
LABELV $2724
line 4115
;4115:		else if (Q_stricmp(name, "Leave") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2731
ARGP4
ADDRLP4 1152
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $2729
line 4116
;4116:		{
line 4117
;4117:			trap_Cmd_ExecuteText( EXEC_APPEND, "disconnect\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2732
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4118
;4118:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4119
;4119:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4120
;4120:			Menus_ActivateByName("main");
ADDRGP4 $2657
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 4121
;4121:		} 
ADDRGP4 $2730
JUMPV
LABELV $2729
line 4122
;4122:		else if (Q_stricmp(name, "getvideosetup") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2735
ARGP4
ADDRLP4 1156
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $2733
line 4123
;4123:		{
line 4124
;4124:			UI_GetVideoSetup ( );
ADDRGP4 UI_GetVideoSetup
CALLV
pop
line 4125
;4125:		}
ADDRGP4 $2734
JUMPV
LABELV $2733
line 4126
;4126:		else if (Q_stricmp(name, "updatevideosetup") == 0)
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2738
ARGP4
ADDRLP4 1160
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
NEI4 $2736
line 4127
;4127:		{
line 4128
;4128:			UI_UpdateVideoSetup ( );
ADDRGP4 UI_UpdateVideoSetup
CALLV
pop
line 4129
;4129:		}
ADDRGP4 $2737
JUMPV
LABELV $2736
line 4130
;4130:		else if (Q_stricmp(name, "ServerSort") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2741
ARGP4
ADDRLP4 1164
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $2739
line 4131
;4131:		{
line 4133
;4132:			int sortColumn;
;4133:			if (Int_Parse(args, &sortColumn)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1168
ARGP4
ADDRLP4 1172
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
EQI4 $2740
line 4135
;4134:				// if same column we're already sorting on then flip the direction
;4135:				if (sortColumn == uiInfo.serverStatus.sortKey) {
ADDRLP4 1168
INDIRI4
ADDRGP4 uiInfo+40604+2200
INDIRI4
NEI4 $2744
line 4136
;4136:					uiInfo.serverStatus.sortDir = !uiInfo.serverStatus.sortDir;
ADDRGP4 uiInfo+40604+2204
INDIRI4
CNSTI4 0
NEI4 $2753
ADDRLP4 1176
CNSTI4 1
ASGNI4
ADDRGP4 $2754
JUMPV
LABELV $2753
ADDRLP4 1176
CNSTI4 0
ASGNI4
LABELV $2754
ADDRGP4 uiInfo+40604+2204
ADDRLP4 1176
INDIRI4
ASGNI4
line 4137
;4137:				}
LABELV $2744
line 4139
;4138:				// make sure we sort again
;4139:				UI_ServersSort(sortColumn, qtrue);
ADDRLP4 1168
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 UI_ServersSort
CALLV
pop
line 4140
;4140:			}
line 4141
;4141:		} else if (Q_stricmp(name, "nextSkirmish") == 0) {
ADDRGP4 $2740
JUMPV
LABELV $2739
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2757
ARGP4
ADDRLP4 1168
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 0
NEI4 $2755
line 4142
;4142:			UI_StartSkirmish(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 4143
;4143:		} else if (Q_stricmp(name, "SkirmishStart") == 0) {
ADDRGP4 $2756
JUMPV
LABELV $2755
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2760
ARGP4
ADDRLP4 1172
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1172
INDIRI4
CNSTI4 0
NEI4 $2758
line 4144
;4144:			UI_StartSkirmish(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_StartSkirmish
CALLV
pop
line 4145
;4145:		} else if (Q_stricmp(name, "closeingame") == 0) {
ADDRGP4 $2759
JUMPV
LABELV $2758
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2763
ARGP4
ADDRLP4 1176
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1176
INDIRI4
CNSTI4 0
NEI4 $2761
line 4146
;4146:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1180
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4147
;4147:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4148
;4148:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4149
;4149:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4150
;4150:		} else if (Q_stricmp(name, "voteMap") == 0) {
ADDRGP4 $2762
JUMPV
LABELV $2761
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2766
ARGP4
ADDRLP4 1180
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 0
NEI4 $2764
line 4151
;4151:			if (ui_currentNetMap.integer >=0 && ui_currentNetMap.integer < uiInfo.mapCount) {
ADDRGP4 ui_currentNetMap+12
INDIRI4
CNSTI4 0
LTI4 $2765
ADDRGP4 ui_currentNetMap+12
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
GEI4 $2765
line 4152
;4152:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote map %s\n",uiInfo.mapList[ui_currentNetMap.integer].mapLoadName) );
ADDRGP4 $2772
ARGP4
CNSTI4 100
ADDRGP4 ui_currentNetMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1184
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4153
;4153:			}
line 4154
;4154:		} else if (Q_stricmp(name, "voteKick") == 0) {
ADDRGP4 $2765
JUMPV
LABELV $2764
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2778
ARGP4
ADDRLP4 1184
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1184
INDIRI4
CNSTI4 0
NEI4 $2776
line 4155
;4155:			if (uiInfo.playerIndex >= 0 && uiInfo.playerIndex < uiInfo.playerCount) {
ADDRGP4 uiInfo+18020
INDIRI4
CNSTI4 0
LTI4 $2777
ADDRGP4 uiInfo+18020
INDIRI4
ADDRGP4 uiInfo+18004
INDIRI4
GEI4 $2777
line 4156
;4156:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote kick \"%s\"\n",uiInfo.playerNames[uiInfo.playerIndex]) );
ADDRGP4 $2784
ARGP4
ADDRGP4 uiInfo+18020
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+18032
ADDP4
ARGP4
ADDRLP4 1188
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1188
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4157
;4157:			}
line 4158
;4158:		} else if (Q_stricmp(name, "voteGame") == 0) {
ADDRGP4 $2777
JUMPV
LABELV $2776
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2789
ARGP4
ADDRLP4 1188
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 0
NEI4 $2787
line 4159
;4159:			if (ui_netGameType.integer >= 0 && ui_netGameType.integer < uiInfo.numGameTypes) {
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 0
LTI4 $2788
ADDRGP4 ui_netGameType+12
INDIRI4
ADDRGP4 uiInfo+17736
INDIRI4
GEI4 $2788
line 4160
;4160:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callvote g_gametype %i\n",uiInfo.gameTypes[ui_netGameType.integer].gtEnum) );
ADDRGP4 $2795
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 1192
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4161
;4161:			}
line 4162
;4162:		} else if (Q_stricmp(name, "voteLeader") == 0) {
ADDRGP4 $2788
JUMPV
LABELV $2787
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2801
ARGP4
ADDRLP4 1192
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 0
NEI4 $2799
line 4163
;4163:			if (uiInfo.teamIndex >= 0 && uiInfo.teamIndex < uiInfo.myTeamCount) {
ADDRGP4 uiInfo+18012
INDIRI4
CNSTI4 0
LTI4 $2800
ADDRGP4 uiInfo+18012
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $2800
line 4164
;4164:				trap_Cmd_ExecuteText( EXEC_APPEND, va("callteamvote leader \"%s\"\n",uiInfo.teamNames[uiInfo.teamIndex]) );
ADDRGP4 $2807
ARGP4
ADDRGP4 uiInfo+18012
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRLP4 1196
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1196
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4165
;4165:			}
line 4166
;4166:		} else if (Q_stricmp(name, "addBot") == 0) {
ADDRGP4 $2800
JUMPV
LABELV $2799
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2812
ARGP4
ADDRLP4 1196
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
NEI4 $2810
line 4167
;4167:			if (trap_Cvar_VariableValue("g_gametype") >= GT_TEAM) {
ADDRGP4 $1015
ARGP4
ADDRLP4 1200
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1200
INDIRF4
CNSTF4 1084227584
LTF4 $2813
line 4168
;4168:				trap_Cmd_ExecuteText( EXEC_APPEND, va("addbot %s %i %s\n", UI_GetBotNameByNumber(uiInfo.botIndex), uiInfo.skillIndex+1, (uiInfo.redBlue == 0) ? "Red" : "Blue") );
ADDRGP4 uiInfo+11836
INDIRI4
ARGI4
ADDRLP4 1208
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRGP4 $2815
ARGP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 uiInfo+33656
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+18000
INDIRI4
CNSTI4 0
NEI4 $2820
ADDRLP4 1204
ADDRGP4 $876
ASGNP4
ADDRGP4 $2821
JUMPV
LABELV $2820
ADDRLP4 1204
ADDRGP4 $875
ASGNP4
LABELV $2821
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4169
;4169:			} else {
ADDRGP4 $2811
JUMPV
LABELV $2813
line 4170
;4170:				trap_Cmd_ExecuteText( EXEC_APPEND, va("addbot %s %i %s\n", UI_GetBotNameByNumber(uiInfo.botIndex), uiInfo.skillIndex+1, (uiInfo.redBlue == 0) ? "Red" : "Blue") );
ADDRGP4 uiInfo+11836
INDIRI4
ARGI4
ADDRLP4 1208
ADDRGP4 UI_GetBotNameByNumber
CALLP4
ASGNP4
ADDRGP4 $2815
ARGP4
ADDRLP4 1208
INDIRP4
ARGP4
ADDRGP4 uiInfo+33656
INDIRI4
CNSTI4 1
ADDI4
ARGI4
ADDRGP4 uiInfo+18000
INDIRI4
CNSTI4 0
NEI4 $2826
ADDRLP4 1204
ADDRGP4 $876
ASGNP4
ADDRGP4 $2827
JUMPV
LABELV $2826
ADDRLP4 1204
ADDRGP4 $875
ASGNP4
LABELV $2827
ADDRLP4 1204
INDIRP4
ARGP4
ADDRLP4 1212
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1212
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4171
;4171:			}
line 4172
;4172:		} else if (Q_stricmp(name, "addFavorite") == 0) 
ADDRGP4 $2811
JUMPV
LABELV $2810
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2830
ARGP4
ADDRLP4 1200
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
NEI4 $2828
line 4173
;4173:		{
line 4174
;4174:			if (ui_netSource.integer != AS_FAVORITES) 
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $2829
line 4175
;4175:			{
line 4180
;4176:				char name[MAX_NAME_LENGTH];
;4177:				char addr[MAX_NAME_LENGTH];
;4178:				int res;
;4179:
;4180:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4181
;4181:				name[0] = addr[0] = '\0';
ADDRLP4 1272
CNSTI1 0
ASGNI1
ADDRLP4 1204
ADDRLP4 1272
INDIRI1
ASGNI1
ADDRLP4 1236
ADDRLP4 1272
INDIRI1
ASGNI1
line 4182
;4182:				Q_strncpyz(name, 	Info_ValueForKey(buff, "hostname"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2839
ARGP4
ADDRLP4 1276
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1236
ARGP4
ADDRLP4 1276
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4183
;4183:				Q_strncpyz(addr, 	Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2840
ARGP4
ADDRLP4 1280
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1204
ARGP4
ADDRLP4 1280
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4184
;4184:				if (strlen(name) > 0 && strlen(addr) > 0) 
ADDRLP4 1236
ARGP4
ADDRLP4 1284
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1284
INDIRI4
CNSTI4 0
LEI4 $2829
ADDRLP4 1204
ARGP4
ADDRLP4 1288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1288
INDIRI4
CNSTI4 0
LEI4 $2829
line 4185
;4185:				{
line 4186
;4186:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 2
ARGI4
ADDRLP4 1236
ARGP4
ADDRLP4 1204
ARGP4
ADDRLP4 1292
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1268
ADDRLP4 1292
INDIRI4
ASGNI4
line 4187
;4187:					if (res == 0) 
ADDRLP4 1268
INDIRI4
CNSTI4 0
NEI4 $2843
line 4188
;4188:					{
line 4190
;4189:						// server already in the list
;4190:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2845
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4191
;4191:					}
ADDRGP4 $2829
JUMPV
LABELV $2843
line 4192
;4192:					else if (res == -1) 
ADDRLP4 1268
INDIRI4
CNSTI4 -1
NEI4 $2846
line 4193
;4193:					{
line 4195
;4194:						// list full
;4195:						Com_Printf("Favorite list full\n");
ADDRGP4 $2848
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4196
;4196:					}
ADDRGP4 $2829
JUMPV
LABELV $2846
line 4198
;4197:					else 
;4198:					{
line 4200
;4199:						// successfully added
;4200:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2849
ARGP4
ADDRLP4 1204
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4206
;4201:
;4202:
;4203://						trap_SP_GetStringTextString((char *)va("%s_GETTINGINFOFORSERVERS",uiInfo.uiDC.Assets.stripedFile), holdSPString, sizeof(holdSPString));
;4204://						Text_Paint(rect->x, rect->y, scale, newColor, va((char *) holdSPString, trap_LAN_GetServerCount(ui_netSource.integer)), 0, 0, textStyle);
;4205:
;4206:					}
line 4207
;4207:				}
line 4208
;4208:			}
line 4209
;4209:		} 
ADDRGP4 $2829
JUMPV
LABELV $2828
line 4210
;4210:		else if (Q_stricmp(name, "deleteFavorite") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2852
ARGP4
ADDRLP4 1204
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1204
INDIRI4
CNSTI4 0
NEI4 $2850
line 4211
;4211:		{
line 4212
;4212:			if (ui_netSource.integer == AS_FAVORITES) 
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $2851
line 4213
;4213:			{
line 4215
;4214:				char addr[MAX_NAME_LENGTH];
;4215:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.serverStatus.currentServer], buff, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2216
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4216
;4216:				addr[0] = '\0';
ADDRLP4 1208
CNSTI1 0
ASGNI1
line 4217
;4217:				Q_strncpyz(addr, 	Info_ValueForKey(buff, "addr"), MAX_NAME_LENGTH);
ADDRLP4 0
ARGP4
ADDRGP4 $2840
ARGP4
ADDRLP4 1240
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1208
ARGP4
ADDRLP4 1240
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4218
;4218:				if (strlen(addr) > 0) 
ADDRLP4 1208
ARGP4
ADDRLP4 1244
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 0
LEI4 $2851
line 4219
;4219:				{
line 4220
;4220:					trap_LAN_RemoveServer(AS_FAVORITES, addr);
CNSTI4 2
ARGI4
ADDRLP4 1208
ARGP4
ADDRGP4 trap_LAN_RemoveServer
CALLV
pop
line 4221
;4221:				}
line 4222
;4222:			}
line 4223
;4223:		} 
ADDRGP4 $2851
JUMPV
LABELV $2850
line 4224
;4224:		else if (Q_stricmp(name, "createFavorite") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2865
ARGP4
ADDRLP4 1208
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
NEI4 $2863
line 4225
;4225:		{
line 4228
;4226:		//	if (ui_netSource.integer == AS_FAVORITES) 
;4227:		//rww - don't know why this check was here.. why would you want to only add new favorites when the filter was favorites?
;4228:			{
line 4233
;4229:				char name[MAX_NAME_LENGTH];
;4230:				char addr[MAX_NAME_LENGTH];
;4231:				int res;
;4232:
;4233:				name[0] = addr[0] = '\0';
ADDRLP4 1280
CNSTI1 0
ASGNI1
ADDRLP4 1212
ADDRLP4 1280
INDIRI1
ASGNI1
ADDRLP4 1244
ADDRLP4 1280
INDIRI1
ASGNI1
line 4234
;4234:				Q_strncpyz(name, 	UI_Cvar_VariableString("ui_favoriteName"), MAX_NAME_LENGTH);
ADDRGP4 $2866
ARGP4
ADDRLP4 1284
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1244
ARGP4
ADDRLP4 1284
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4235
;4235:				Q_strncpyz(addr, 	UI_Cvar_VariableString("ui_favoriteAddress"), MAX_NAME_LENGTH);
ADDRGP4 $2867
ARGP4
ADDRLP4 1288
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1212
ARGP4
ADDRLP4 1288
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4236
;4236:				if (/*strlen(name) > 0 &&*/ strlen(addr) > 0) {
ADDRLP4 1212
ARGP4
ADDRLP4 1292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1292
INDIRI4
CNSTI4 0
LEI4 $2864
line 4237
;4237:					res = trap_LAN_AddServer(AS_FAVORITES, name, addr);
CNSTI4 2
ARGI4
ADDRLP4 1244
ARGP4
ADDRLP4 1212
ARGP4
ADDRLP4 1296
ADDRGP4 trap_LAN_AddServer
CALLI4
ASGNI4
ADDRLP4 1276
ADDRLP4 1296
INDIRI4
ASGNI4
line 4238
;4238:					if (res == 0) {
ADDRLP4 1276
INDIRI4
CNSTI4 0
NEI4 $2870
line 4240
;4239:						// server already in the list
;4240:						Com_Printf("Favorite already in list\n");
ADDRGP4 $2845
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4241
;4241:					}
ADDRGP4 $2864
JUMPV
LABELV $2870
line 4242
;4242:					else if (res == -1) {
ADDRLP4 1276
INDIRI4
CNSTI4 -1
NEI4 $2872
line 4244
;4243:						// list full
;4244:						Com_Printf("Favorite list full\n");
ADDRGP4 $2848
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4245
;4245:					}
ADDRGP4 $2864
JUMPV
LABELV $2872
line 4246
;4246:					else {
line 4248
;4247:						// successfully added
;4248:						Com_Printf("Added favorite server %s\n", addr);
ADDRGP4 $2849
ARGP4
ADDRLP4 1212
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4249
;4249:					}
line 4250
;4250:				}
line 4251
;4251:			}
line 4252
;4252:		} else if (Q_stricmp(name, "orders") == 0) {
ADDRGP4 $2864
JUMPV
LABELV $2863
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2876
ARGP4
ADDRLP4 1212
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
NEI4 $2874
line 4254
;4253:			const char *orders;
;4254:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1216
ARGP4
ADDRLP4 1220
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
EQI4 $2875
line 4255
;4255:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1450
ARGP4
ADDRLP4 1228
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1224
ADDRLP4 1228
INDIRF4
CVFI4 4
ASGNI4
line 4256
;4256:				if (selectedPlayer < uiInfo.myTeamCount) {
ADDRLP4 1224
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $2879
line 4257
;4257:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4258
;4258:					trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamClientNums[selectedPlayer]) );
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+20080
ADDP4
INDIRI4
ARGI4
ADDRLP4 1232
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1232
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4259
;4259:					trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2883
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4260
;4260:				} else {
ADDRGP4 $2880
JUMPV
LABELV $2879
line 4262
;4261:					int i;
;4262:					for (i = 0; i < uiInfo.myTeamCount; i++) {
ADDRLP4 1232
CNSTI4 0
ASGNI4
ADDRGP4 $2887
JUMPV
LABELV $2884
line 4263
;4263:						if (Q_stricmp(UI_Cvar_VariableString("name"), uiInfo.teamNames[i]) == 0) {
ADDRGP4 $2400
ARGP4
ADDRLP4 1236
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 1236
INDIRP4
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRLP4 1240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $2889
line 4264
;4264:							continue;
ADDRGP4 $2885
JUMPV
LABELV $2889
line 4266
;4265:						}
;4266:						strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1216
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4267
;4267:						trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamNames[i]) );
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
ARGP4
ADDRLP4 1244
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1244
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4268
;4268:						trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2883
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4269
;4269:					}
LABELV $2885
line 4262
ADDRLP4 1232
ADDRLP4 1232
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2887
ADDRLP4 1232
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
LTI4 $2884
line 4270
;4270:				}
LABELV $2880
line 4271
;4271:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1232
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4272
;4272:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4273
;4273:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4274
;4274:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4275
;4275:			}
line 4276
;4276:		} else if (Q_stricmp(name, "voiceOrdersTeam") == 0) {
ADDRGP4 $2875
JUMPV
LABELV $2874
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2895
ARGP4
ADDRLP4 1216
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1216
INDIRI4
CNSTI4 0
NEI4 $2893
line 4278
;4277:			const char *orders;
;4278:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1220
ARGP4
ADDRLP4 1224
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
EQI4 $2894
line 4279
;4279:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1450
ARGP4
ADDRLP4 1232
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1228
ADDRLP4 1232
INDIRF4
CVFI4 4
ASGNI4
line 4280
;4280:				if (selectedPlayer == uiInfo.myTeamCount) {
ADDRLP4 1228
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
NEI4 $2898
line 4281
;4281:					trap_Cmd_ExecuteText( EXEC_APPEND, orders );
CNSTI4 2
ARGI4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4282
;4282:					trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2883
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4283
;4283:				}
LABELV $2898
line 4284
;4284:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1236
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4285
;4285:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4286
;4286:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4287
;4287:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4288
;4288:			}
line 4289
;4289:		} else if (Q_stricmp(name, "voiceOrders") == 0) {
ADDRGP4 $2894
JUMPV
LABELV $2893
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2903
ARGP4
ADDRLP4 1220
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 0
NEI4 $2901
line 4291
;4290:			const char *orders;
;4291:			if (String_Parse(args, &orders)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1224
ARGP4
ADDRLP4 1228
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
EQI4 $2902
line 4292
;4292:				int selectedPlayer = trap_Cvar_VariableValue("cg_selectedPlayer");
ADDRGP4 $1450
ARGP4
ADDRLP4 1236
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1232
ADDRLP4 1236
INDIRF4
CVFI4 4
ASGNI4
line 4294
;4293:
;4294:				if (selectedPlayer == uiInfo.myTeamCount)
ADDRLP4 1232
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
NEI4 $2906
line 4295
;4295:				{
line 4296
;4296:					selectedPlayer = -1;
ADDRLP4 1232
CNSTI4 -1
ASGNI4
line 4297
;4297:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4298
;4298:					trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, selectedPlayer) );
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
ARGI4
ADDRLP4 1240
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1240
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4299
;4299:				}
ADDRGP4 $2907
JUMPV
LABELV $2906
line 4301
;4300:				else
;4301:				{
line 4302
;4302:					strcpy(buff, orders);
ADDRLP4 0
ARGP4
ADDRLP4 1224
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4303
;4303:					trap_Cmd_ExecuteText( EXEC_APPEND, va(buff, uiInfo.teamClientNums[selectedPlayer]) );
ADDRLP4 0
ARGP4
ADDRLP4 1232
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+20080
ADDP4
INDIRI4
ARGI4
ADDRLP4 1240
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 2
ARGI4
ADDRLP4 1240
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4304
;4304:				}
LABELV $2907
line 4305
;4305:				trap_Cmd_ExecuteText( EXEC_APPEND, "\n" );
CNSTI4 2
ARGI4
ADDRGP4 $2883
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 4307
;4306:
;4307:				trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 1240
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 4308
;4308:				trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 4309
;4309:				trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4310
;4310:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 4311
;4311:			}
line 4312
;4312:		}
ADDRGP4 $2902
JUMPV
LABELV $2901
line 4313
;4313:		else if (Q_stricmp(name, "setForce") == 0)
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2912
ARGP4
ADDRLP4 1224
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1224
INDIRI4
CNSTI4 0
NEI4 $2910
line 4314
;4314:		{
line 4317
;4315:			const char *teamArg;
;4316:
;4317:			if (String_Parse(args, &teamArg))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1228
ARGP4
ADDRLP4 1232
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
EQI4 $2913
line 4318
;4318:			{
line 4319
;4319:				UI_UpdateClientForcePowers(teamArg);
ADDRLP4 1228
INDIRP4
ARGP4
ADDRGP4 UI_UpdateClientForcePowers
CALLV
pop
line 4320
;4320:			}
ADDRGP4 $2911
JUMPV
LABELV $2913
line 4322
;4321:			else
;4322:			{
line 4323
;4323:				UI_UpdateClientForcePowers(NULL);
CNSTP4 0
ARGP4
ADDRGP4 UI_UpdateClientForcePowers
CALLV
pop
line 4324
;4324:			}
line 4325
;4325:		}
ADDRGP4 $2911
JUMPV
LABELV $2910
line 4326
;4326:		else if (Q_stricmp(name, "saveTemplate") == 0) {
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2917
ARGP4
ADDRLP4 1228
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1228
INDIRI4
CNSTI4 0
NEI4 $2915
line 4327
;4327:			UI_SaveForceTemplate();
ADDRGP4 UI_SaveForceTemplate
CALLV
pop
line 4328
;4328:		} else if (Q_stricmp(name, "refreshForce") == 0) {
ADDRGP4 $2916
JUMPV
LABELV $2915
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2920
ARGP4
ADDRLP4 1232
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1232
INDIRI4
CNSTI4 0
NEI4 $2918
line 4329
;4329:			UI_UpdateForcePowers();
ADDRGP4 UI_UpdateForcePowers
CALLV
pop
line 4330
;4330:		} else if (Q_stricmp(name, "glCustom") == 0) {
ADDRGP4 $2919
JUMPV
LABELV $2918
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2923
ARGP4
ADDRLP4 1236
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1236
INDIRI4
CNSTI4 0
NEI4 $2921
line 4331
;4331:			trap_Cvar_Set("ui_r_glCustom", "4");
ADDRGP4 $2438
ARGP4
ADDRGP4 $2505
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4332
;4332:		} 
ADDRGP4 $2922
JUMPV
LABELV $2921
line 4333
;4333:		else if (Q_stricmp(name, "forcePowersDisable") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2926
ARGP4
ADDRLP4 1240
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1240
INDIRI4
CNSTI4 0
NEI4 $2924
line 4334
;4334:		{
line 4337
;4335:			int	forcePowerDisable,i;
;4336:
;4337:			forcePowerDisable = trap_Cvar_VariableValue("g_forcePowerDisable");
ADDRGP4 $1002
ARGP4
ADDRLP4 1252
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1248
ADDRLP4 1252
INDIRF4
CVFI4 4
ASGNI4
line 4340
;4338:
;4339:			// It was set to something, so might as well make sure it got all flags set.
;4340:			if (forcePowerDisable)
ADDRLP4 1248
INDIRI4
CNSTI4 0
EQI4 $2925
line 4341
;4341:			{
line 4342
;4342:				for (i=0;i<NUM_FORCE_POWERS;i++)
ADDRLP4 1244
CNSTI4 0
ASGNI4
LABELV $2929
line 4343
;4343:				{
line 4344
;4344:					forcePowerDisable |= (1<<i);
ADDRLP4 1248
ADDRLP4 1248
INDIRI4
CNSTI4 1
ADDRLP4 1244
INDIRI4
LSHI4
BORI4
ASGNI4
line 4345
;4345:				}
LABELV $2930
line 4342
ADDRLP4 1244
ADDRLP4 1244
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 18
LTI4 $2929
line 4347
;4346:
;4347:				forcePowerDisable &= ~(1<<FP_SABERATTACK);
ADDRLP4 1248
ADDRLP4 1248
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 4348
;4348:				forcePowerDisable &= ~(1<<FP_SABERDEFEND);
ADDRLP4 1248
ADDRLP4 1248
INDIRI4
CNSTI4 -65537
BANDI4
ASGNI4
line 4349
;4349:				forcePowerDisable &= ~(1<<FP_SABERTHROW);
ADDRLP4 1248
ADDRLP4 1248
INDIRI4
CNSTI4 -131073
BANDI4
ASGNI4
line 4351
;4350:
;4351:				trap_Cvar_Set("g_forcePowerDisable", va("%i",forcePowerDisable));
ADDRGP4 $1314
ARGP4
ADDRLP4 1248
INDIRI4
ARGI4
ADDRLP4 1256
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $1002
ARGP4
ADDRLP4 1256
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4352
;4352:			}
line 4354
;4353:
;4354:		} 
ADDRGP4 $2925
JUMPV
LABELV $2924
line 4355
;4355:		else if (Q_stricmp(name, "weaponDisable") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2935
ARGP4
ADDRLP4 1244
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1244
INDIRI4
CNSTI4 0
NEI4 $2933
line 4356
;4356:		{
line 4360
;4357:			int	weaponDisable,i;
;4358:			const char *cvarString;
;4359:
;4360:			if (ui_netGameType.integer == GT_TOURNAMENT)
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
NEI4 $2936
line 4361
;4361:			{
line 4362
;4362:				cvarString = "g_duelWeaponDisable";
ADDRLP4 1256
ADDRGP4 $2939
ASGNP4
line 4363
;4363:			}
ADDRGP4 $2937
JUMPV
LABELV $2936
line 4365
;4364:			else
;4365:			{
line 4366
;4366:				cvarString = "g_weaponDisable";
ADDRLP4 1256
ADDRGP4 $2940
ASGNP4
line 4367
;4367:			}
LABELV $2937
line 4369
;4368:
;4369:			weaponDisable = trap_Cvar_VariableValue(cvarString);
ADDRLP4 1256
INDIRP4
ARGP4
ADDRLP4 1260
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 1252
ADDRLP4 1260
INDIRF4
CVFI4 4
ASGNI4
line 4372
;4370:
;4371:			// It was set to something, so might as well make sure it got all flags set.
;4372:			if (weaponDisable)
ADDRLP4 1252
INDIRI4
CNSTI4 0
EQI4 $2934
line 4373
;4373:			{
line 4374
;4374:				for (i=0;i<WP_NUM_WEAPONS;i++)
ADDRLP4 1248
CNSTI4 0
ASGNI4
LABELV $2943
line 4375
;4375:				{
line 4376
;4376:					if (i!=WP_SABER)
ADDRLP4 1248
INDIRI4
CNSTI4 2
EQI4 $2947
line 4377
;4377:					{
line 4378
;4378:						weaponDisable |= (1<<i);
ADDRLP4 1252
ADDRLP4 1252
INDIRI4
CNSTI4 1
ADDRLP4 1248
INDIRI4
LSHI4
BORI4
ASGNI4
line 4379
;4379:					}
LABELV $2947
line 4380
;4380:				}
LABELV $2944
line 4374
ADDRLP4 1248
ADDRLP4 1248
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 1248
INDIRI4
CNSTI4 16
LTI4 $2943
line 4382
;4381:
;4382:				trap_Cvar_Set(cvarString, va("%i",weaponDisable));
ADDRGP4 $1314
ARGP4
ADDRLP4 1252
INDIRI4
ARGI4
ADDRLP4 1264
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 1256
INDIRP4
ARGP4
ADDRLP4 1264
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4383
;4383:			}
line 4384
;4384:		} 
ADDRGP4 $2934
JUMPV
LABELV $2933
line 4385
;4385:		else if (Q_stricmp(name, "updateForceStatus") == 0)
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2951
ARGP4
ADDRLP4 1248
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1248
INDIRI4
CNSTI4 0
NEI4 $2949
line 4386
;4386:		{
line 4387
;4387:			UpdateForceStatus();
ADDRGP4 UpdateForceStatus
CALLV
pop
line 4388
;4388:		}
ADDRGP4 $2950
JUMPV
LABELV $2949
line 4389
;4389:		else if (Q_stricmp(name, "update") == 0) 
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 $2954
ARGP4
ADDRLP4 1252
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1252
INDIRI4
CNSTI4 0
NEI4 $2952
line 4390
;4390:		{
line 4391
;4391:			if (String_Parse(args, &name2)) 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1028
ARGP4
ADDRLP4 1256
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 1256
INDIRI4
CNSTI4 0
EQI4 $2953
line 4392
;4392:			{
line 4393
;4393:				UI_Update(name2);
ADDRLP4 1028
INDIRP4
ARGP4
ADDRGP4 UI_Update
CALLV
pop
line 4394
;4394:			}
line 4395
;4395:		}
ADDRGP4 $2953
JUMPV
LABELV $2952
line 4397
;4396:		else 
;4397:		{
line 4398
;4398:			Com_Printf("unknown UI script %s\n", name);
ADDRGP4 $2957
ARGP4
ADDRLP4 1024
INDIRP4
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 4399
;4399:		}
LABELV $2953
LABELV $2950
LABELV $2934
LABELV $2925
LABELV $2922
LABELV $2919
LABELV $2916
LABELV $2911
LABELV $2902
LABELV $2894
LABELV $2875
LABELV $2864
LABELV $2851
LABELV $2829
LABELV $2811
LABELV $2800
LABELV $2788
LABELV $2777
LABELV $2765
LABELV $2762
LABELV $2759
LABELV $2756
LABELV $2740
LABELV $2737
LABELV $2734
LABELV $2730
LABELV $2725
LABELV $2721
LABELV $2711
LABELV $2694
LABELV $2689
LABELV $2682
LABELV $2672
LABELV $2666
LABELV $2659
LABELV $2646
LABELV $2643
LABELV $2637
LABELV $2631
LABELV $2621
LABELV $2618
LABELV $2615
LABELV $2612
LABELV $2599
LABELV $2596
LABELV $2593
LABELV $2590
LABELV $2581
LABELV $2577
LABELV $2574
LABELV $2571
LABELV $2566
LABELV $2559
LABELV $2552
LABELV $2510
line 4400
;4400:	}
LABELV $2507
line 4401
;4401:}
LABELV $2506
endproc UI_RunMenuScript 1300 24
proc UI_GetTeamColor 0 0
line 4403
;4402:
;4403:static void UI_GetTeamColor(vec4_t *color) {
line 4404
;4404:}
LABELV $2958
endproc UI_GetTeamColor 0 0
proc UI_MapCountByGameType 20 0
line 4411
;4405:
;4406:/*
;4407:==================
;4408:UI_MapCountByGameType
;4409:==================
;4410:*/
;4411:static int UI_MapCountByGameType(qboolean singlePlayer) {
line 4413
;4412:	int i, c, game;
;4413:	c = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4414
;4414:	game = singlePlayer ? uiInfo.gameTypes[ui_gameType.integer].gtEnum : uiInfo.gameTypes[ui_netGameType.integer].gtEnum;
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2967
ADDRLP4 12
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ASGNI4
ADDRGP4 $2968
JUMPV
LABELV $2967
ADDRLP4 12
ADDRGP4 ui_netGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ASGNI4
LABELV $2968
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 4415
;4415:	if (game == GT_SINGLE_PLAYER) {
ADDRLP4 4
INDIRI4
CNSTI4 4
NEI4 $2969
line 4416
;4416:		game++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4417
;4417:	} 
LABELV $2969
line 4418
;4418:	if (game == GT_TEAM) {
ADDRLP4 4
INDIRI4
CNSTI4 5
NEI4 $2971
line 4419
;4419:		game = GT_FFA;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4420
;4420:	}
LABELV $2971
line 4421
;4421:	if (game == GT_HOLOCRON || game == GT_JEDIMASTER) {
ADDRLP4 4
INDIRI4
CNSTI4 1
EQI4 $2975
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $2973
LABELV $2975
line 4422
;4422:		game = GT_FFA;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4423
;4423:	}
LABELV $2973
line 4425
;4424:
;4425:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2979
JUMPV
LABELV $2976
line 4426
;4426:		uiInfo.mapList[i].active = qfalse;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+96
ADDP4
CNSTI4 0
ASGNI4
line 4427
;4427:		if ( uiInfo.mapList[i].typeBits & (1 << game)) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2983
line 4428
;4428:			if (singlePlayer) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2987
line 4429
;4429:				if (!(uiInfo.mapList[i].typeBits & (1 << GT_SINGLE_PLAYER))) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+20
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
NEI4 $2989
line 4430
;4430:					continue;
ADDRGP4 $2977
JUMPV
LABELV $2989
line 4432
;4431:				}
;4432:			}
LABELV $2987
line 4433
;4433:			c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4434
;4434:			uiInfo.mapList[i].active = qtrue;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+96
ADDP4
CNSTI4 1
ASGNI4
line 4435
;4435:		}
LABELV $2983
line 4436
;4436:	}
LABELV $2977
line 4425
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $2979
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LTI4 $2976
line 4437
;4437:	return c;
ADDRLP4 8
INDIRI4
RETI4
LABELV $2959
endproc UI_MapCountByGameType 20 0
export UI_hasSkinForBase
proc UI_hasSkinForBase 1028 20
line 4440
;4438:}
;4439:
;4440:qboolean UI_hasSkinForBase(const char *base, const char *team) {
line 4444
;4441:	char	test[1024];
;4442:	fileHandle_t	f;
;4443:	
;4444:	Com_sprintf( test, sizeof( test ), "models/players/%s/%s/lower_default.skin", base, team );
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2996
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4445
;4445:	trap_FS_FOpenFile(test, &f, FS_READ);
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 4446
;4446:	if (f != 0) {
ADDRLP4 1024
INDIRI4
CNSTI4 0
EQI4 $2997
line 4447
;4447:		trap_FS_FCloseFile(f);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 4448
;4448:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2995
JUMPV
LABELV $2997
line 4450
;4449:	}
;4450:	Com_sprintf( test, sizeof( test ), "models/players/characters/%s/%s/lower_default.skin", base, team );
ADDRLP4 0
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $2999
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 4451
;4451:	trap_FS_FOpenFile(test, &f, FS_READ);
ADDRLP4 0
ARGP4
ADDRLP4 1024
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 4452
;4452:	if (f != 0) {
ADDRLP4 1024
INDIRI4
CNSTI4 0
EQI4 $3000
line 4453
;4453:		trap_FS_FCloseFile(f);
ADDRLP4 1024
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 4454
;4454:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2995
JUMPV
LABELV $3000
line 4456
;4455:	}
;4456:	return qfalse;
CNSTI4 0
RETI4
LABELV $2995
endproc UI_hasSkinForBase 1028 20
data
align 4
LABELV $3003
byte 4 0
code
proc UI_HeadCountByTeam 40 8
line 4464
;4457:}
;4458:
;4459:/*
;4460:==================
;4461:UI_MapCountByTeam
;4462:==================
;4463:*/
;4464:static int UI_HeadCountByTeam() {
line 4468
;4465:	static int init = 0;
;4466:	int i, j, k, c, tIndex;
;4467:	
;4468:	c = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 4469
;4469:	if (!init) {
ADDRGP4 $3003
INDIRI4
CNSTI4 0
NEI4 $3004
line 4470
;4470:		for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3009
JUMPV
LABELV $3006
line 4471
;4471:			uiInfo.characterList[i].reference = 0;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+20
ADDP4
CNSTI4 0
ASGNI4
line 4472
;4472:			for (j = 0; j < uiInfo.teamCount; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $3016
JUMPV
LABELV $3013
line 4473
;4473:			  if (UI_hasSkinForBase(uiInfo.characterList[i].base, uiInfo.teamList[j].teamName)) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+12
ADDP4
INDIRP4
ARGP4
CNSTI4 56
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 uiInfo+14152
ADDP4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 UI_hasSkinForBase
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $3018
line 4474
;4474:					uiInfo.characterList[i].reference |= (1<<j);
ADDRLP4 24
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+20
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 8
INDIRI4
LSHI4
BORI4
ASGNI4
line 4475
;4475:			  }
LABELV $3018
line 4476
;4476:			}
LABELV $3014
line 4472
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3016
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
LTI4 $3013
line 4477
;4477:		}
LABELV $3007
line 4470
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3009
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
LTI4 $3006
line 4478
;4478:		init = 1;
ADDRGP4 $3003
CNSTI4 1
ASGNI4
line 4479
;4479:	}
LABELV $3004
line 4481
;4480:
;4481:	tIndex = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 20
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 24
INDIRI4
ASGNI4
line 4484
;4482:
;4483:	// do names
;4484:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3028
JUMPV
LABELV $3025
line 4485
;4485:		uiInfo.characterList[i].active = qfalse;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+16
ADDP4
CNSTI4 0
ASGNI4
line 4486
;4486:		for(j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $3032
line 4487
;4487:			if (uiInfo.teamList[tIndex].teamMembers[j] != NULL) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3036
line 4488
;4488:				if (uiInfo.characterList[i].reference&(1<<tIndex)) {// && Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.characterList[i].name)==0) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $3040
line 4489
;4489:					uiInfo.characterList[i].active = qtrue;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+16
ADDP4
CNSTI4 1
ASGNI4
line 4490
;4490:					c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4491
;4491:					break;
ADDRGP4 $3034
JUMPV
LABELV $3040
line 4493
;4492:				}
;4493:			}
LABELV $3036
line 4494
;4494:		}
LABELV $3033
line 4486
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 8
LTI4 $3032
LABELV $3034
line 4495
;4495:	}
LABELV $3026
line 4484
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3028
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
LTI4 $3025
line 4498
;4496:
;4497:	// and then aliases
;4498:	for(j = 0; j < TEAM_MEMBERS; j++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $3046
line 4499
;4499:		for(k = 0; k < uiInfo.aliasCount; k++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3053
JUMPV
LABELV $3050
line 4500
;4500:			if (uiInfo.aliasList[k].name != NULL) {
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+13380
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3055
line 4501
;4501:				if (Q_stricmp(uiInfo.teamList[tIndex].teamMembers[j], uiInfo.aliasList[k].name)==0) {
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
CNSTI4 56
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+8
ADDP4
ADDP4
INDIRP4
ARGP4
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+13380
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3058
line 4502
;4502:					for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3066
JUMPV
LABELV $3063
line 4503
;4503:						if (uiInfo.characterList[i].headImage != -1 && uiInfo.characterList[i].reference&(1<<tIndex) && Q_stricmp(uiInfo.aliasList[k].ai, uiInfo.characterList[i].name)==0) {
ADDRLP4 32
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+11840+8
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $3068
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+11840+20
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 12
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $3068
CNSTI4 12
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+13380+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 32
INDIRI4
ADDRGP4 uiInfo+11840
ADDP4
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $3068
line 4504
;4504:							if (uiInfo.characterList[i].active == qfalse) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+16
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3065
line 4505
;4505:								uiInfo.characterList[i].active = qtrue;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+16
ADDP4
CNSTI4 1
ASGNI4
line 4506
;4506:								c++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4507
;4507:							}
line 4508
;4508:							break;
ADDRGP4 $3065
JUMPV
LABELV $3068
line 4510
;4509:						}
;4510:					}
LABELV $3064
line 4502
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3066
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
LTI4 $3063
LABELV $3065
line 4511
;4511:				}
LABELV $3058
line 4512
;4512:			}
LABELV $3055
line 4513
;4513:		}
LABELV $3051
line 4499
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3053
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+13376
INDIRI4
LTI4 $3050
line 4514
;4514:	}
LABELV $3047
line 4498
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 8
LTI4 $3046
line 4515
;4515:	return c;
ADDRLP4 16
INDIRI4
RETI4
LABELV $3002
endproc UI_HeadCountByTeam 40 8
proc UI_HeadCountByColor 24 8
line 4523
;4516:}
;4517:
;4518:/*
;4519:==================
;4520:UI_HeadCountByColor
;4521:==================
;4522:*/
;4523:static int UI_HeadCountByColor() {
line 4527
;4524:	int i, c;
;4525:	char *teamname;
;4526:
;4527:	c = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4529
;4528:
;4529:	switch(uiSkinColor)
ADDRLP4 12
ADDRGP4 uiSkinColor
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $3088
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $3086
ADDRGP4 $3084
JUMPV
line 4530
;4530:	{
LABELV $3086
line 4532
;4531:		case TEAM_BLUE:
;4532:			teamname = "/blue";
ADDRLP4 4
ADDRGP4 $3087
ASGNP4
line 4533
;4533:			break;
ADDRGP4 $3085
JUMPV
LABELV $3088
line 4535
;4534:		case TEAM_RED:
;4535:			teamname = "/red";
ADDRLP4 4
ADDRGP4 $3089
ASGNP4
line 4536
;4536:			break;
ADDRGP4 $3085
JUMPV
LABELV $3084
line 4538
;4537:		default:
;4538:			teamname = "/default";
ADDRLP4 4
ADDRGP4 $3090
ASGNP4
line 4539
;4539:	}
LABELV $3085
line 4542
;4540:
;4541:	// Count each head with this color
;4542:	for (i=0; i<uiInfo.q3HeadCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3094
JUMPV
LABELV $3091
line 4543
;4543:	{
line 4544
;4544:		if (uiInfo.q3HeadNames[i] && strstr(uiInfo.q3HeadNames[i], teamname))
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+60736
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $3096
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3096
line 4545
;4545:		{
line 4546
;4546:			c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4547
;4547:		}
LABELV $3096
line 4548
;4548:	}
LABELV $3092
line 4542
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3094
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+60732
INDIRI4
LTI4 $3091
line 4549
;4549:	return c;
ADDRLP4 8
INDIRI4
RETI4
LABELV $3083
endproc UI_HeadCountByColor 24 8
proc UI_InsertServerIntoDisplayList 16 0
line 4557
;4550:}
;4551:
;4552:/*
;4553:==================
;4554:UI_InsertServerIntoDisplayList
;4555:==================
;4556:*/
;4557:static void UI_InsertServerIntoDisplayList(int num, int position) {
line 4560
;4558:	int i;
;4559:
;4560:	if (position < 0 || position > uiInfo.serverStatus.numDisplayServers ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3105
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
LEI4 $3101
LABELV $3105
line 4561
;4561:		return;
ADDRGP4 $3100
JUMPV
LABELV $3101
line 4564
;4562:	}
;4563:	//
;4564:	uiInfo.serverStatus.numDisplayServers++;
ADDRLP4 8
ADDRGP4 uiInfo+40604+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4565
;4565:	for (i = uiInfo.serverStatus.numDisplayServers; i > position; i--) {
ADDRLP4 0
ADDRGP4 uiInfo+40604+10412
INDIRI4
ASGNI4
ADDRGP4 $3111
JUMPV
LABELV $3108
line 4566
;4566:		uiInfo.serverStatus.displayServers[i] = uiInfo.serverStatus.displayServers[i-1];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+40604+2220
ADDP4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+40604+2220-4
ADDP4
INDIRI4
ASGNI4
line 4567
;4567:	}
LABELV $3109
line 4565
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
LABELV $3111
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
GTI4 $3108
line 4568
;4568:	uiInfo.serverStatus.displayServers[position] = num;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 4569
;4569:}
LABELV $3100
endproc UI_InsertServerIntoDisplayList 16 0
proc UI_RemoveServerFromDisplayList 16 0
line 4576
;4570:
;4571:/*
;4572:==================
;4573:UI_RemoveServerFromDisplayList
;4574:==================
;4575:*/
;4576:static void UI_RemoveServerFromDisplayList(int num) {
line 4579
;4577:	int i, j;
;4578:
;4579:	for (i = 0; i < uiInfo.serverStatus.numDisplayServers; i++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3125
JUMPV
LABELV $3122
line 4580
;4580:		if (uiInfo.serverStatus.displayServers[i] == num) {
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3128
line 4581
;4581:			uiInfo.serverStatus.numDisplayServers--;
ADDRLP4 8
ADDRGP4 uiInfo+40604+10412
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 4582
;4582:			for (j = i; j < uiInfo.serverStatus.numDisplayServers; j++) {
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $3137
JUMPV
LABELV $3134
line 4583
;4583:				uiInfo.serverStatus.displayServers[j] = uiInfo.serverStatus.displayServers[j+1];
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+40604+2220
ADDP4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+40604+2220+4
ADDP4
INDIRI4
ASGNI4
line 4584
;4584:			}
LABELV $3135
line 4582
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3137
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
LTI4 $3134
line 4585
;4585:			return;
ADDRGP4 $3121
JUMPV
LABELV $3128
line 4587
;4586:		}
;4587:	}
LABELV $3123
line 4579
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3125
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
LTI4 $3122
line 4588
;4588:}
LABELV $3121
endproc UI_RemoveServerFromDisplayList 16 0
proc UI_BinaryServerInsertion 20 20
line 4595
;4589:
;4590:/*
;4591:==================
;4592:UI_BinaryServerInsertion
;4593:==================
;4594:*/
;4595:static void UI_BinaryServerInsertion(int num) {
line 4599
;4596:	int mid, offset, res, len;
;4597:
;4598:	// use binary search to insert server
;4599:	len = uiInfo.serverStatus.numDisplayServers;
ADDRLP4 12
ADDRGP4 uiInfo+40604+10412
INDIRI4
ASGNI4
line 4600
;4600:	mid = len;
ADDRLP4 0
ADDRLP4 12
INDIRI4
ASGNI4
line 4601
;4601:	offset = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4602
;4602:	res = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3149
JUMPV
LABELV $3148
line 4603
;4603:	while(mid > 0) {
line 4604
;4604:		mid = len >> 1;
ADDRLP4 0
ADDRLP4 12
INDIRI4
CNSTI4 1
RSHI4
ASGNI4
line 4606
;4605:		//
;4606:		res = trap_LAN_CompareServers( ui_netSource.integer, uiInfo.serverStatus.sortKey,
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2200
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+2204
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 trap_LAN_CompareServers
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 16
INDIRI4
ASGNI4
line 4609
;4607:					uiInfo.serverStatus.sortDir, num, uiInfo.serverStatus.displayServers[offset+mid]);
;4608:		// if equal
;4609:		if (res == 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $3158
line 4610
;4610:			UI_InsertServerIntoDisplayList(num, offset+mid);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 4611
;4611:			return;
ADDRGP4 $3145
JUMPV
LABELV $3158
line 4614
;4612:		}
;4613:		// if larger
;4614:		else if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $3160
line 4615
;4615:			offset += mid;
ADDRLP4 8
ADDRLP4 8
INDIRI4
ADDRLP4 0
INDIRI4
ADDI4
ASGNI4
line 4616
;4616:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 4617
;4617:		}
ADDRGP4 $3161
JUMPV
LABELV $3160
line 4619
;4618:		// if smaller
;4619:		else {
line 4620
;4620:			len -= mid;
ADDRLP4 12
ADDRLP4 12
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 4621
;4621:		}
LABELV $3161
line 4622
;4622:	}
LABELV $3149
line 4603
ADDRLP4 0
INDIRI4
CNSTI4 0
GTI4 $3148
line 4623
;4623:	if (res == 1) {
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $3162
line 4624
;4624:		offset++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4625
;4625:	}
LABELV $3162
line 4626
;4626:	UI_InsertServerIntoDisplayList(num, offset);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 UI_InsertServerIntoDisplayList
CALLV
pop
line 4627
;4627:}
LABELV $3145
endproc UI_BinaryServerInsertion 20 20
bss
align 4
LABELV $3165
skip 4
code
proc UI_BuildServerDisplayList 1100 16
line 4634
;4628:
;4629:/*
;4630:==================
;4631:UI_BuildServerDisplayList
;4632:==================
;4633:*/
;4634:static void UI_BuildServerDisplayList(qboolean force) {
line 4640
;4635:	int i, count, clients, maxClients, ping, game, len, visible;
;4636:	char info[MAX_STRING_CHARS];
;4637://	qboolean startRefresh = qtrue; TTimo: unused
;4638:	static int numinvisible;
;4639:
;4640:	if (!(force || uiInfo.uiDC.realTime > uiInfo.serverStatus.nextDisplayRefresh)) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3166
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+40604+10420
INDIRI4
GTI4 $3166
line 4641
;4641:		return;
ADDRGP4 $3164
JUMPV
LABELV $3166
line 4644
;4642:	}
;4643:	// if we shouldn't reset
;4644:	if ( force == 2 ) {
ADDRFP4 0
INDIRI4
CNSTI4 2
NEI4 $3171
line 4645
;4645:		force = 0;
ADDRFP4 0
CNSTI4 0
ASGNI4
line 4646
;4646:	}
LABELV $3171
line 4649
;4647:
;4648:	// do motd updates here too
;4649:	trap_Cvar_VariableStringBuffer( "cl_motdString", uiInfo.serverStatus.motd, sizeof(uiInfo.serverStatus.motd) );
ADDRGP4 $3173
ARGP4
ADDRGP4 uiInfo+40604+10460
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4650
;4650:	len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+40604+10460
ARGP4
ADDRLP4 1056
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1056
INDIRI4
ASGNI4
line 4651
;4651:	if (len == 0) {
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $3180
line 4652
;4652:		strcpy(uiInfo.serverStatus.motd, "Welcome to JK2MP!");
ADDRGP4 uiInfo+40604+10460
ARGP4
ADDRGP4 $3184
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 4653
;4653:		len = strlen(uiInfo.serverStatus.motd);
ADDRGP4 uiInfo+40604+10460
ARGP4
ADDRLP4 1060
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1060
INDIRI4
ASGNI4
line 4654
;4654:	} 
LABELV $3180
line 4655
;4655:	if (len != uiInfo.serverStatus.motdLen) {
ADDRLP4 1052
INDIRI4
ADDRGP4 uiInfo+40604+10436
INDIRI4
EQI4 $3187
line 4656
;4656:		uiInfo.serverStatus.motdLen = len;
ADDRGP4 uiInfo+40604+10436
ADDRLP4 1052
INDIRI4
ASGNI4
line 4657
;4657:		uiInfo.serverStatus.motdWidth = -1;
ADDRGP4 uiInfo+40604+10440
CNSTI4 -1
ASGNI4
line 4658
;4658:	} 
LABELV $3187
line 4660
;4659:
;4660:	if (force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $3195
line 4661
;4661:		numinvisible = 0;
ADDRGP4 $3165
CNSTI4 0
ASGNI4
line 4663
;4662:		// clear number of displayed servers
;4663:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+40604+10412
CNSTI4 0
ASGNI4
line 4664
;4664:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+40604+10416
CNSTI4 0
ASGNI4
line 4666
;4665:		// set list box index to zero
;4666:		Menu_SetFeederSelection(NULL, FEEDER_SERVERS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 2
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 4668
;4667:		// mark all servers as visible so we store ping updates for them
;4668:		trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4669
;4669:	}
LABELV $3195
line 4672
;4670:
;4671:	// get the server count (comes from the master)
;4672:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 1060
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 1036
ADDRLP4 1060
INDIRI4
ASGNI4
line 4673
;4673:	if (count == -1 || (ui_netSource.integer == AS_LOCAL && count == 0) ) {
ADDRLP4 1036
INDIRI4
CNSTI4 -1
EQI4 $3206
ADDRLP4 1068
CNSTI4 0
ASGNI4
ADDRGP4 ui_netSource+12
INDIRI4
ADDRLP4 1068
INDIRI4
NEI4 $3203
ADDRLP4 1036
INDIRI4
ADDRLP4 1068
INDIRI4
NEI4 $3203
LABELV $3206
line 4675
;4674:		// still waiting on a response from the master
;4675:		uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+40604+10412
CNSTI4 0
ASGNI4
line 4676
;4676:		uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+40604+10416
CNSTI4 0
ASGNI4
line 4677
;4677:		uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+40604+10420
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 4678
;4678:		return;
ADDRGP4 $3164
JUMPV
LABELV $3203
line 4681
;4679:	}
;4680:
;4681:	visible = qfalse;
ADDRLP4 1040
CNSTI4 0
ASGNI4
line 4682
;4682:	for (i = 0; i < count; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3217
JUMPV
LABELV $3214
line 4684
;4683:		// if we already got info for this server
;4684:		if (!trap_LAN_ServerIsVisible(ui_netSource.integer, i)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1072
ADDRGP4 trap_LAN_ServerIsVisible
CALLI4
ASGNI4
ADDRLP4 1072
INDIRI4
CNSTI4 0
NEI4 $3218
line 4685
;4685:			continue;
ADDRGP4 $3215
JUMPV
LABELV $3218
line 4687
;4686:		}
;4687:		visible = qtrue;
ADDRLP4 1040
CNSTI4 1
ASGNI4
line 4689
;4688:		// get the ping for this server
;4689:		ping = trap_LAN_GetServerPing(ui_netSource.integer, i);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 1076
ADDRGP4 trap_LAN_GetServerPing
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 1076
INDIRI4
ASGNI4
line 4690
;4690:		if (ping > 0 || ui_netSource.integer == AS_FAVORITES) {
ADDRLP4 4
INDIRI4
CNSTI4 0
GTI4 $3225
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $3222
LABELV $3225
line 4692
;4691:
;4692:			trap_LAN_GetServerInfo(ui_netSource.integer, i, info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 4694
;4693:
;4694:			clients = atoi(Info_ValueForKey(info, "clients"));
ADDRLP4 8
ARGP4
ADDRGP4 $3227
ARGP4
ADDRLP4 1080
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1084
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1032
ADDRLP4 1084
INDIRI4
ASGNI4
line 4695
;4695:			uiInfo.serverStatus.numPlayersOnServers += clients;
ADDRLP4 1088
ADDRGP4 uiInfo+40604+10416
ASGNP4
ADDRLP4 1088
INDIRP4
ADDRLP4 1088
INDIRP4
INDIRI4
ADDRLP4 1032
INDIRI4
ADDI4
ASGNI4
line 4697
;4696:
;4697:			if (ui_browserShowEmpty.integer == 0) {
ADDRGP4 ui_browserShowEmpty+12
INDIRI4
CNSTI4 0
NEI4 $3230
line 4698
;4698:				if (clients == 0) {
ADDRLP4 1032
INDIRI4
CNSTI4 0
NEI4 $3233
line 4699
;4699:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4700
;4700:					continue;
ADDRGP4 $3215
JUMPV
LABELV $3233
line 4702
;4701:				}
;4702:			}
LABELV $3230
line 4704
;4703:
;4704:			if (ui_browserShowFull.integer == 0) {
ADDRGP4 ui_browserShowFull+12
INDIRI4
CNSTI4 0
NEI4 $3236
line 4705
;4705:				maxClients = atoi(Info_ValueForKey(info, "sv_maxclients"));
ADDRLP4 8
ARGP4
ADDRGP4 $1418
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1044
ADDRLP4 1096
INDIRI4
ASGNI4
line 4706
;4706:				if (clients == maxClients) {
ADDRLP4 1032
INDIRI4
ADDRLP4 1044
INDIRI4
NEI4 $3239
line 4707
;4707:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4708
;4708:					continue;
ADDRGP4 $3215
JUMPV
LABELV $3239
line 4710
;4709:				}
;4710:			}
LABELV $3236
line 4712
;4711:
;4712:			if (uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum != -1) {
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17872+4
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $3242
line 4713
;4713:				game = atoi(Info_ValueForKey(info, "gametype"));
ADDRLP4 8
ARGP4
ADDRGP4 $3247
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 1048
ADDRLP4 1096
INDIRI4
ASGNI4
line 4714
;4714:				if (game != uiInfo.joinGameTypes[ui_joinGameType.integer].gtEnum) {
ADDRLP4 1048
INDIRI4
ADDRGP4 ui_joinGameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17872+4
ADDP4
INDIRI4
EQI4 $3248
line 4715
;4715:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4716
;4716:					continue;
ADDRGP4 $3215
JUMPV
LABELV $3248
line 4718
;4717:				}
;4718:			}
LABELV $3242
line 4720
;4719:				
;4720:			if (ui_serverFilterType.integer > 0) {
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 0
LEI4 $3254
line 4721
;4721:				if (Q_stricmp(Info_ValueForKey(info, "game"), serverFilters[ui_serverFilterType.integer].basedir) != 0) {
ADDRLP4 8
ARGP4
ADDRGP4 $3259
ARGP4
ADDRLP4 1092
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 ui_serverFilterType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverFilters+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 1096
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1096
INDIRI4
CNSTI4 0
EQI4 $3257
line 4722
;4722:					trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4723
;4723:					continue;
ADDRGP4 $3215
JUMPV
LABELV $3257
line 4725
;4724:				}
;4725:			}
LABELV $3254
line 4727
;4726:			// make sure we never add a favorite server twice
;4727:			if (ui_netSource.integer == AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
NEI4 $3263
line 4728
;4728:				UI_RemoveServerFromDisplayList(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_RemoveServerFromDisplayList
CALLV
pop
line 4729
;4729:			}
LABELV $3263
line 4731
;4730:			// insert the server into the list
;4731:			UI_BinaryServerInsertion(i);
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_BinaryServerInsertion
CALLV
pop
line 4733
;4732:			// done with this server
;4733:			if (ping > 0) {
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $3266
line 4734
;4734:				trap_LAN_MarkServerVisible(ui_netSource.integer, i, qfalse);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 4735
;4735:				numinvisible++;
ADDRLP4 1092
ADDRGP4 $3165
ASGNP4
ADDRLP4 1092
INDIRP4
ADDRLP4 1092
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4736
;4736:			}
LABELV $3266
line 4737
;4737:		}
LABELV $3222
line 4738
;4738:	}
LABELV $3215
line 4682
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3217
ADDRLP4 0
INDIRI4
ADDRLP4 1036
INDIRI4
LTI4 $3214
line 4740
;4739:
;4740:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime;
ADDRGP4 uiInfo+40604+2192
ADDRGP4 uiInfo+232
INDIRI4
ASGNI4
line 4743
;4741:
;4742:	// if there were no servers visible for ping updates
;4743:	if (!visible) {
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $3272
line 4746
;4744://		UI_StopServerRefresh();
;4745://		uiInfo.serverStatus.nextDisplayRefresh = 0;
;4746:	}
LABELV $3272
line 4747
;4747:}
LABELV $3164
endproc UI_BuildServerDisplayList 1100 16
data
export serverStatusCvars
align 4
LABELV serverStatusCvars
address $3275
address $3276
address $3277
address $170
address $3278
address $3279
address $1015
address $3280
address $3281
address $3282
address $3283
address $170
address $2242
address $170
address $3284
address $170
address $688
address $170
byte 4 0
byte 4 0
code
proc UI_SortServerStatusInfo 56 8
line 4772
;4748:
;4749:typedef struct
;4750:{
;4751:	char *name, *altName;
;4752:} serverStatusCvar_t;
;4753:
;4754:serverStatusCvar_t serverStatusCvars[] = {
;4755:	{"sv_hostname", "Name"},
;4756:	{"Address", ""},
;4757:	{"gamename", "Game name"},
;4758:	{"g_gametype", "Game type"},
;4759:	{"mapname", "Map"},
;4760:	{"version", ""},
;4761:	{"protocol", ""},
;4762:	{"timelimit", ""},
;4763:	{"fraglimit", ""},
;4764:	{NULL, NULL}
;4765:};
;4766:
;4767:/*
;4768:==================
;4769:UI_SortServerStatusInfo
;4770:==================
;4771:*/
;4772:static void UI_SortServerStatusInfo( serverStatusInfo_t *info ) {
line 4779
;4773:	int i, j, index;
;4774:	char *tmp1, *tmp2;
;4775:
;4776:	// FIXME: if "gamename" == "base" or "missionpack" then
;4777:	// replace the gametype number by FFA, CTF etc.
;4778:	//
;4779:	index = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 4780
;4780:	for (i = 0; serverStatusCvars[i].name; i++) {
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $3289
JUMPV
LABELV $3286
line 4781
;4781:		for (j = 0; j < info->numLines; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3293
JUMPV
LABELV $3290
line 4782
;4782:			if ( !info->lines[j][1] || info->lines[j][1][0] ) {
ADDRLP4 20
CNSTI4 4
ASGNI4
ADDRLP4 24
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3296
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3294
LABELV $3296
line 4783
;4783:				continue;
ADDRGP4 $3291
JUMPV
LABELV $3294
line 4785
;4784:			}
;4785:			if ( !Q_stricmp(serverStatusCvars[i].name, info->lines[j][0]) ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $3297
line 4787
;4786:				// swap lines
;4787:				tmp1 = info->lines[index][0];
ADDRLP4 12
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
INDIRP4
ASGNP4
line 4788
;4788:				tmp2 = info->lines[index][3];
ADDRLP4 16
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
INDIRP4
ASGNP4
line 4789
;4789:				info->lines[index][0] = info->lines[j][0];
ADDRLP4 32
CNSTI4 4
ASGNI4
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 4
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRLP4 36
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 32
INDIRI4
LSHI4
ADDRLP4 36
INDIRP4
ADDP4
INDIRP4
ASGNP4
line 4790
;4790:				info->lines[index][3] = info->lines[j][3];
ADDRLP4 40
CNSTI4 4
ASGNI4
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ASGNP4
ADDRLP4 48
CNSTI4 12
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 40
INDIRI4
LSHI4
ADDRLP4 44
INDIRP4
ADDP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 40
INDIRI4
LSHI4
ADDRLP4 44
INDIRP4
ADDP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
ASGNP4
line 4791
;4791:				info->lines[j][0] = tmp1;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 4792
;4792:				info->lines[j][3] = tmp2;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 4794
;4793:				//
;4794:				if ( strlen(serverStatusCvars[i].altName) ) {
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 52
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $3299
line 4795
;4795:					info->lines[index][0] = serverStatusCvars[i].altName;
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars+4
ADDP4
INDIRP4
ASGNP4
line 4796
;4796:				}
LABELV $3299
line 4797
;4797:				index++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4798
;4798:			}
LABELV $3297
line 4799
;4799:		}
LABELV $3291
line 4781
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3293
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
LTI4 $3290
line 4800
;4800:	}
LABELV $3287
line 4780
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3289
ADDRLP4 8
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 serverStatusCvars
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3286
line 4801
;4801:}
LABELV $3285
endproc UI_SortServerStatusInfo 56 8
proc UI_GetServerStatusInfo 168 16
line 4808
;4802:
;4803:/*
;4804:==================
;4805:UI_GetServerStatusInfo
;4806:==================
;4807:*/
;4808:static int UI_GetServerStatusInfo( const char *serverAddress, serverStatusInfo_t *info ) {
line 4812
;4809:	char *p, *score, *ping, *name;
;4810:	int i, len;
;4811:
;4812:	if (!info) {
ADDRFP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3304
line 4813
;4813:		trap_LAN_ServerStatus( serverAddress, NULL, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 4814
;4814:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3303
JUMPV
LABELV $3304
line 4816
;4815:	}
;4816:	memset(info, 0, sizeof(*info));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 3236
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4817
;4817:	if ( trap_LAN_ServerStatus( serverAddress, info->text, sizeof(info->text)) ) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 24
ADDRGP4 trap_LAN_ServerStatus
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $3306
line 4818
;4818:		Q_strncpyz(info->address, serverAddress, sizeof(info->address));
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4819
;4819:		p = info->text;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 2112
ADDP4
ASGNP4
line 4820
;4820:		info->numLines = 0;
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
CNSTI4 0
ASGNI4
line 4821
;4821:		info->lines[info->numLines][0] = "Address";
ADDRLP4 28
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 28
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3277
ASGNP4
line 4822
;4822:		info->lines[info->numLines][1] = "";
ADDRLP4 32
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 36
CNSTI4 4
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
LSHI4
ADDRLP4 32
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 36
INDIRI4
ADDP4
ADDRGP4 $170
ASGNP4
line 4823
;4823:		info->lines[info->numLines][2] = "";
ADDRLP4 40
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $170
ASGNP4
line 4824
;4824:		info->lines[info->numLines][3] = info->address;
ADDRLP4 44
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 44
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 44
INDIRP4
ASGNP4
line 4825
;4825:		info->numLines++;
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRGP4 $3309
JUMPV
LABELV $3308
line 4827
;4826:		// get the cvars
;4827:		while (p && *p) {
line 4828
;4828:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 52
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 52
INDIRP4
ASGNP4
line 4829
;4829:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3311
ADDRGP4 $3310
JUMPV
LABELV $3311
line 4830
;4830:			*p++ = '\0';
ADDRLP4 56
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI1 0
ASGNI1
line 4831
;4831:			if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3313
line 4832
;4832:				break;
ADDRGP4 $3310
JUMPV
LABELV $3313
line 4833
;4833:			info->lines[info->numLines][0] = p;
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4834
;4834:			info->lines[info->numLines][1] = "";
ADDRLP4 64
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
CNSTI4 4
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
LSHI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 68
INDIRI4
ADDP4
ADDRGP4 $170
ASGNP4
line 4835
;4835:			info->lines[info->numLines][2] = "";
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $170
ASGNP4
line 4836
;4836:			p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 76
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 76
INDIRP4
ASGNP4
line 4837
;4837:			if (!p) break;
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3315
ADDRGP4 $3310
JUMPV
LABELV $3315
line 4838
;4838:			*p++ = '\0';
ADDRLP4 80
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI1 0
ASGNI1
line 4839
;4839:			info->lines[info->numLines][3] = p;
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4841
;4840:
;4841:			info->numLines++;
ADDRLP4 88
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
ASGNP4
ADDRLP4 88
INDIRP4
ADDRLP4 88
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4842
;4842:			if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3317
line 4843
;4843:				break;
ADDRGP4 $3310
JUMPV
LABELV $3317
line 4844
;4844:		}
LABELV $3309
line 4827
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3319
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3308
LABELV $3319
LABELV $3310
line 4846
;4845:		// get the player list
;4846:		if (info->numLines < MAX_SERVERSTATUS_LINES-3) {
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 125
GEI4 $3320
line 4848
;4847:			// empty line
;4848:			info->lines[info->numLines][0] = "";
ADDRLP4 56
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $170
ASGNP4
line 4849
;4849:			info->lines[info->numLines][1] = "";
ADDRLP4 60
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 64
CNSTI4 4
ASGNI4
ADDRLP4 60
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
ADDRLP4 64
INDIRI4
LSHI4
ADDRLP4 60
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 64
INDIRI4
ADDP4
ADDRGP4 $170
ASGNP4
line 4850
;4850:			info->lines[info->numLines][2] = "";
ADDRLP4 68
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 68
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $170
ASGNP4
line 4851
;4851:			info->lines[info->numLines][3] = "";
ADDRLP4 72
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 72
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $170
ASGNP4
line 4852
;4852:			info->numLines++;
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4854
;4853:			// header
;4854:			info->lines[info->numLines][0] = "num";
ADDRLP4 80
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 80
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 80
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRGP4 $3322
ASGNP4
line 4855
;4855:			info->lines[info->numLines][1] = "score";
ADDRLP4 84
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTI4 4
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
LSHI4
ADDRLP4 84
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 88
INDIRI4
ADDP4
ADDRGP4 $3323
ASGNP4
line 4856
;4856:			info->lines[info->numLines][2] = "ping";
ADDRLP4 92
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 92
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRGP4 $3324
ASGNP4
line 4857
;4857:			info->lines[info->numLines][3] = "name";
ADDRLP4 96
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 96
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRGP4 $2400
ASGNP4
line 4858
;4858:			info->numLines++;
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4860
;4859:			// parse players
;4860:			i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4861
;4861:			len = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3326
JUMPV
LABELV $3325
line 4862
;4862:			while (p && *p) {
line 4863
;4863:				if (*p == '\\')
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 92
NEI4 $3328
line 4864
;4864:					*p++ = '\0';
ADDRLP4 104
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 104
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
CNSTI1 0
ASGNI1
LABELV $3328
line 4865
;4865:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3330
line 4866
;4866:					break;
ADDRGP4 $3327
JUMPV
LABELV $3330
line 4867
;4867:				score = p;
ADDRLP4 12
ADDRLP4 0
INDIRP4
ASGNP4
line 4868
;4868:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 108
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRP4
ASGNP4
line 4869
;4869:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3332
line 4870
;4870:					break;
ADDRGP4 $3327
JUMPV
LABELV $3332
line 4871
;4871:				*p++ = '\0';
ADDRLP4 112
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 112
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI1 0
ASGNI1
line 4872
;4872:				ping = p;
ADDRLP4 16
ADDRLP4 0
INDIRP4
ASGNP4
line 4873
;4873:				p = strchr(p, ' ');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 116
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 116
INDIRP4
ASGNP4
line 4874
;4874:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3334
line 4875
;4875:					break;
ADDRGP4 $3327
JUMPV
LABELV $3334
line 4876
;4876:				*p++ = '\0';
ADDRLP4 120
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 120
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI1 0
ASGNI1
line 4877
;4877:				name = p;
ADDRLP4 20
ADDRLP4 0
INDIRP4
ASGNP4
line 4878
;4878:				Com_sprintf(&info->pings[len], sizeof(info->pings)-len, "%d", i);
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
CNSTU4 96
ADDRLP4 4
INDIRI4
CVIU4 4
SUBU4
CVUI4 4
ARGI4
ADDRGP4 $685
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4879
;4879:				info->lines[info->numLines][0] = &info->pings[len];
ADDRLP4 128
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 128
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 4
INDIRI4
ADDRLP4 128
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ASGNP4
line 4880
;4880:				len += strlen(&info->pings[len]) + 1;
ADDRLP4 4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 3136
ADDP4
ADDP4
ARGP4
ADDRLP4 136
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ADDI4
ASGNI4
line 4881
;4881:				info->lines[info->numLines][1] = score;
ADDRLP4 140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 144
CNSTI4 4
ASGNI4
ADDRLP4 140
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
ADDRLP4 144
INDIRI4
LSHI4
ADDRLP4 140
INDIRP4
CNSTI4 64
ADDP4
ADDP4
ADDRLP4 144
INDIRI4
ADDP4
ADDRLP4 12
INDIRP4
ASGNP4
line 4882
;4882:				info->lines[info->numLines][2] = ping;
ADDRLP4 148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 148
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 148
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 8
ADDP4
ADDRLP4 16
INDIRP4
ASGNP4
line 4883
;4883:				info->lines[info->numLines][3] = name;
ADDRLP4 152
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 152
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 152
INDIRP4
CNSTI4 64
ADDP4
ADDP4
CNSTI4 12
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 4884
;4884:				info->numLines++;
ADDRLP4 156
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
ASGNP4
ADDRLP4 156
INDIRP4
ADDRLP4 156
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4885
;4885:				if (info->numLines >= MAX_SERVERSTATUS_LINES)
ADDRFP4 4
INDIRP4
CNSTI4 3232
ADDP4
INDIRI4
CNSTI4 128
LTI4 $3336
line 4886
;4886:					break;
ADDRGP4 $3327
JUMPV
LABELV $3336
line 4887
;4887:				p = strchr(p, '\\');
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 92
ARGI4
ADDRLP4 160
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 160
INDIRP4
ASGNP4
line 4888
;4888:				if (!p)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $3338
line 4889
;4889:					break;
ADDRGP4 $3327
JUMPV
LABELV $3338
line 4890
;4890:				*p++ = '\0';
ADDRLP4 164
ADDRLP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 164
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 164
INDIRP4
CNSTI1 0
ASGNI1
line 4892
;4891:				//
;4892:				i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4893
;4893:			}
LABELV $3326
line 4862
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3340
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3325
LABELV $3340
LABELV $3327
line 4894
;4894:		}
LABELV $3320
line 4895
;4895:		UI_SortServerStatusInfo( info );
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 UI_SortServerStatusInfo
CALLV
pop
line 4896
;4896:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $3303
JUMPV
LABELV $3306
line 4898
;4897:	}
;4898:	return qfalse;
CNSTI4 0
RETI4
LABELV $3303
endproc UI_GetServerStatusInfo 168 16
proc stristr 12 4
line 4906
;4899:}
;4900:
;4901:/*
;4902:==================
;4903:stristr
;4904:==================
;4905:*/
;4906:static char *stristr(char *str, char *charset) {
ADDRGP4 $3343
JUMPV
LABELV $3342
line 4909
;4907:	int i;
;4908:
;4909:	while(*str) {
line 4910
;4910:		for (i = 0; charset[i] && str[i]; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3348
JUMPV
LABELV $3345
line 4911
;4911:			if (toupper(charset[i]) != toupper(str[i])) break;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 4
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ARGI4
ADDRLP4 8
ADDRGP4 toupper
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $3349
ADDRGP4 $3347
JUMPV
LABELV $3349
line 4912
;4912:		}
LABELV $3346
line 4910
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3348
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
EQI4 $3351
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
ADDRLP4 8
INDIRI4
NEI4 $3345
LABELV $3351
LABELV $3347
line 4913
;4913:		if (!charset[i]) return str;
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3352
ADDRFP4 0
INDIRP4
RETP4
ADDRGP4 $3341
JUMPV
LABELV $3352
line 4914
;4914:		str++;
ADDRFP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
line 4915
;4915:	}
LABELV $3343
line 4909
ADDRFP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3342
line 4916
;4916:	return NULL;
CNSTP4 0
RETP4
LABELV $3341
endproc stristr 12 4
bss
align 4
LABELV $3355
skip 4
align 4
LABELV $3356
skip 4
code
proc UI_BuildFindPlayerList 4328 24
line 4924
;4917:}
;4918:
;4919:/*
;4920:==================
;4921:UI_BuildFindPlayerList
;4922:==================
;4923:*/
;4924:static void UI_BuildFindPlayerList(qboolean force) {
line 4931
;4925:	static int numFound, numTimeOuts;
;4926:	int i, j, resend;
;4927:	serverStatusInfo_t info;
;4928:	char name[MAX_NAME_LENGTH+2];
;4929:	char infoString[MAX_STRING_CHARS];
;4930:
;4931:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3357
line 4932
;4932:		if (!uiInfo.nextFindPlayerRefresh || uiInfo.nextFindPlayerRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+60716
INDIRI4
CNSTI4 0
EQI4 $3364
ADDRGP4 uiInfo+60716
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
LEI4 $3358
LABELV $3364
line 4933
;4933:			return;
ADDRGP4 $3354
JUMPV
line 4935
;4934:		}
;4935:	}
LABELV $3357
line 4936
;4936:	else {
line 4937
;4937:		memset(&uiInfo.pendingServerStatus, 0, sizeof(uiInfo.pendingServerStatus));
ADDRGP4 uiInfo+55392
ARGP4
CNSTI4 0
ARGI4
CNSTI4 2244
ARGI4
ADDRGP4 memset
CALLP4
pop
line 4938
;4938:		uiInfo.numFoundPlayerServers = 0;
ADDRGP4 uiInfo+60712
CNSTI4 0
ASGNI4
line 4939
;4939:		uiInfo.currentFoundPlayerServer = 0;
ADDRGP4 uiInfo+60708
CNSTI4 0
ASGNI4
line 4940
;4940:		trap_Cvar_VariableStringBuffer( "ui_findPlayer", uiInfo.findPlayerName, sizeof(uiInfo.findPlayerName));
ADDRGP4 $3369
ARGP4
ADDRGP4 uiInfo+57636
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 4941
;4941:		Q_CleanStr(uiInfo.findPlayerName);
ADDRGP4 uiInfo+57636
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 4943
;4942:		// should have a string of some length
;4943:		if (!strlen(uiInfo.findPlayerName)) {
ADDRGP4 uiInfo+57636
ARGP4
ADDRLP4 4308
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4308
INDIRI4
CNSTI4 0
NEI4 $3373
line 4944
;4944:			uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+60716
CNSTI4 0
ASGNI4
line 4945
;4945:			return;
ADDRGP4 $3354
JUMPV
LABELV $3373
line 4948
;4946:		}
;4947:		// set resend time
;4948:		resend = ui_serverStatusTimeOut.integer / 2 - 10;
ADDRLP4 4304
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
CNSTI4 2
DIVI4
CNSTI4 10
SUBI4
ASGNI4
line 4949
;4949:		if (resend < 50) {
ADDRLP4 4304
INDIRI4
CNSTI4 50
GEI4 $3378
line 4950
;4950:			resend = 50;
ADDRLP4 4304
CNSTI4 50
ASGNI4
line 4951
;4951:		}
LABELV $3378
line 4952
;4952:		trap_Cvar_Set("cl_serverStatusResendTime", va("%d", resend));
ADDRGP4 $685
ARGP4
ADDRLP4 4304
INDIRI4
ARGI4
ADDRLP4 4312
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3380
ARGP4
ADDRLP4 4312
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 4954
;4953:		// reset all server status requests
;4954:		trap_LAN_ServerStatus( NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 4956
;4955:		//
;4956:		uiInfo.numFoundPlayerServers = 1;
ADDRGP4 uiInfo+60712
CNSTI4 1
ASGNI4
line 4957
;4957:		Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3388
ARGP4
ADDRGP4 uiInfo+55392
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 4960
;4958:						sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;4959:							"searching %d...", uiInfo.pendingServerStatus.num);
;4960:		numFound = 0;
ADDRGP4 $3355
CNSTI4 0
ASGNI4
line 4961
;4961:		numTimeOuts++;
ADDRLP4 4316
ADDRGP4 $3356
ASGNP4
ADDRLP4 4316
INDIRP4
ADDRLP4 4316
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4962
;4962:	}
LABELV $3358
line 4963
;4963:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3390
line 4965
;4964:		// if this pending server is valid
;4965:		if (uiInfo.pendingServerStatus.server[i].valid) {
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3394
line 4967
;4966:			// try to get the server status for this server
;4967:			if (UI_GetServerStatusInfo( uiInfo.pendingServerStatus.server[i].adrstr, &info ) ) {
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4
ADDP4
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 4308
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 4308
INDIRI4
CNSTI4 0
EQI4 $3399
line 4969
;4968:				//
;4969:				numFound++;
ADDRLP4 4312
ADDRGP4 $3355
ASGNP4
ADDRLP4 4312
INDIRP4
ADDRLP4 4312
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4971
;4970:				// parse through the server status lines
;4971:				for (j = 0; j < info.numLines; j++) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $3406
JUMPV
LABELV $3403
line 4973
;4972:					// should have ping info
;4973:					if ( !info.lines[j][2] || !info.lines[j][2][0] ) {
ADDRLP4 4316
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
ADDRLP4 4316
INDIRI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3414
ADDRLP4 4316
INDIRI4
ADDRLP4 8+64+8
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3408
LABELV $3414
line 4974
;4974:						continue;
ADDRGP4 $3404
JUMPV
LABELV $3408
line 4977
;4975:					}
;4976:					// clean string first
;4977:					Q_strncpyz(name, info.lines[j][3], sizeof(name));
ADDRLP4 3244
ARGP4
ADDRLP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRLP4 8+64+12
ADDP4
INDIRP4
ARGP4
CNSTI4 34
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4978
;4978:					Q_CleanStr(name);
ADDRLP4 3244
ARGP4
ADDRGP4 Q_CleanStr
CALLP4
pop
line 4980
;4979:					// if the player name is a substring
;4980:					if (stristr(name, uiInfo.findPlayerName)) {
ADDRLP4 3244
ARGP4
ADDRGP4 uiInfo+57636
ARGP4
ADDRLP4 4320
ADDRGP4 stristr
CALLP4
ASGNP4
ADDRLP4 4320
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3417
line 4982
;4981:						// add to found server list if we have space (always leave space for a line with the number found)
;4982:						if (uiInfo.numFoundPlayerServers < MAX_FOUNDPLAYER_SERVERS-1) {
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 15
GEI4 $3420
line 4984
;4983:							//
;4984:							Q_strncpyz(uiInfo.foundPlayerServerAddresses[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+58660-64
ADDP4
ARGP4
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4987
;4985:										uiInfo.pendingServerStatus.server[i].adrstr,
;4986:											sizeof(uiInfo.foundPlayerServerAddresses[0]));
;4987:							Q_strncpyz(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 4990
;4988:										uiInfo.pendingServerStatus.server[i].name,
;4989:											sizeof(uiInfo.foundPlayerServerNames[0]));
;4990:							uiInfo.numFoundPlayerServers++;
ADDRLP4 4324
ADDRGP4 uiInfo+60712
ASGNP4
ADDRLP4 4324
INDIRP4
ADDRLP4 4324
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4991
;4991:						}
ADDRGP4 $3421
JUMPV
LABELV $3420
line 4992
;4992:						else {
line 4994
;4993:							// can't add any more so we're done
;4994:							uiInfo.pendingServerStatus.num = uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+55392
ADDRGP4 uiInfo+40604+10412
INDIRI4
ASGNI4
line 4995
;4995:						}
LABELV $3421
line 4996
;4996:					}
LABELV $3417
line 4997
;4997:				}
LABELV $3404
line 4971
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3406
ADDRLP4 4
INDIRI4
ADDRLP4 8+3232
INDIRI4
LTI4 $3403
line 4998
;4998:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3446
ARGP4
ADDRGP4 uiInfo+55392
INDIRI4
ARGI4
ADDRGP4 $3355
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 5002
;4999:								sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;5000:									"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;5001:				// retrieved the server status so reuse this spot
;5002:				uiInfo.pendingServerStatus.server[i].valid = qfalse;
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
CNSTI4 0
ASGNI4
line 5003
;5003:			}
LABELV $3399
line 5004
;5004:		}
LABELV $3394
line 5006
;5005:		// if empty pending slot or timed out
;5006:		if (!uiInfo.pendingServerStatus.server[i].valid ||
ADDRLP4 4308
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 4308
INDIRI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3461
ADDRLP4 4308
INDIRI4
ADDRGP4 uiInfo+55392+4+128
ADDP4
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 ui_serverStatusTimeOut+12
INDIRI4
SUBI4
GEI4 $3451
LABELV $3461
line 5007
;5007:			uiInfo.pendingServerStatus.server[i].startTime < uiInfo.uiDC.realTime - ui_serverStatusTimeOut.integer) {
line 5008
;5008:			if (uiInfo.pendingServerStatus.server[i].valid) {
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3462
line 5009
;5009:				numTimeOuts++;
ADDRLP4 4312
ADDRGP4 $3356
ASGNP4
ADDRLP4 4312
INDIRP4
ADDRLP4 4312
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5010
;5010:			}
LABELV $3462
line 5012
;5011:			// reset server status request for this address
;5012:			UI_GetServerStatusInfo( uiInfo.pendingServerStatus.server[i].adrstr, NULL );
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4
ADDP4
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 5014
;5013:			// reuse pending slot
;5014:			uiInfo.pendingServerStatus.server[i].valid = qfalse;
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
CNSTI4 0
ASGNI4
line 5016
;5015:			// if we didn't try to get the status of all servers in the main browser yet
;5016:			if (uiInfo.pendingServerStatus.num < uiInfo.serverStatus.numDisplayServers) {
ADDRGP4 uiInfo+55392
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
GEI4 $3472
line 5017
;5017:				uiInfo.pendingServerStatus.server[i].startTime = uiInfo.uiDC.realTime;
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+128
ADDP4
ADDRGP4 uiInfo+232
INDIRI4
ASGNI4
line 5018
;5018:				trap_LAN_GetServerAddressString(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num],
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+55392
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 trap_LAN_GetServerAddressString
CALLV
pop
line 5020
;5019:							uiInfo.pendingServerStatus.server[i].adrstr, sizeof(uiInfo.pendingServerStatus.server[i].adrstr));
;5020:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[uiInfo.pendingServerStatus.num], infoString, sizeof(infoString));
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 uiInfo+55392
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRLP4 3278
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 5021
;5021:				Q_strncpyz(uiInfo.pendingServerStatus.server[i].name, Info_ValueForKey(infoString, "hostname"), sizeof(uiInfo.pendingServerStatus.server[0].name));
ADDRLP4 3278
ARGP4
ADDRGP4 $2839
ARGP4
ADDRLP4 4312
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+64
ADDP4
ARGP4
ADDRLP4 4312
INDIRP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 5022
;5022:				uiInfo.pendingServerStatus.server[i].valid = qtrue;
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
CNSTI4 1
ASGNI4
line 5023
;5023:				uiInfo.pendingServerStatus.num++;
ADDRLP4 4316
ADDRGP4 uiInfo+55392
ASGNP4
ADDRLP4 4316
INDIRP4
ADDRLP4 4316
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5024
;5024:				Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1],
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3446
ARGP4
ADDRGP4 uiInfo+55392
INDIRI4
ARGI4
ADDRGP4 $3355
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 5027
;5025:								sizeof(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1]),
;5026:									"searching %d/%d...", uiInfo.pendingServerStatus.num, numFound);
;5027:			}
LABELV $3472
line 5028
;5028:		}
LABELV $3451
line 5029
;5029:	}
LABELV $3391
line 4963
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3390
line 5030
;5030:	for (i = 0; i < MAX_SERVERSTATUSREQUESTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $3510
line 5031
;5031:		if (uiInfo.pendingServerStatus.server[i].valid) {
CNSTI4 140
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+55392+4+136
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3514
line 5032
;5032:			break;
ADDRGP4 $3512
JUMPV
LABELV $3514
line 5034
;5033:		}
;5034:	}
LABELV $3511
line 5030
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $3510
LABELV $3512
line 5036
;5035:	// if still trying to retrieve server status info
;5036:	if (i < MAX_SERVERSTATUSREQUESTS) {
ADDRLP4 0
INDIRI4
CNSTI4 16
GEI4 $3519
line 5037
;5037:		uiInfo.nextFindPlayerRefresh = uiInfo.uiDC.realTime + 25;
ADDRGP4 uiInfo+60716
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 5038
;5038:	}
ADDRGP4 $3520
JUMPV
LABELV $3519
line 5039
;5039:	else {
line 5041
;5040:		// add a line that shows the number of servers found
;5041:		if (!uiInfo.numFoundPlayerServers) 
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 0
NEI4 $3523
line 5042
;5042:		{
line 5043
;5043:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1], sizeof(uiInfo.foundPlayerServerAddresses[0]), "no servers found");
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 $3530
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5044
;5044:		}
ADDRGP4 $3524
JUMPV
LABELV $3523
line 5046
;5045:		else 
;5046:		{
line 5047
;5047:			trap_SP_GetStringTextString("MENUS3_SERVERS_FOUNDWITH", holdSPString, sizeof(holdSPString));
ADDRGP4 $3531
ARGP4
ADDRGP4 holdSPString
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 5048
;5048:			Com_sprintf(uiInfo.foundPlayerServerNames[uiInfo.numFoundPlayerServers-1], sizeof(uiInfo.foundPlayerServerAddresses[0]),
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684-64
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 holdSPString
ARGP4
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 1
SUBI4
ARGI4
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 2
NEI4 $3541
ADDRLP4 4308
ADDRGP4 $170
ASGNP4
ADDRGP4 $3542
JUMPV
LABELV $3541
ADDRLP4 4308
ADDRGP4 $3538
ASGNP4
LABELV $3542
ADDRLP4 4308
INDIRP4
ARGP4
ADDRGP4 uiInfo+57636
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5051
;5049:						holdSPString, uiInfo.numFoundPlayerServers-1,
;5050:						uiInfo.numFoundPlayerServers == 2 ? "":"s", uiInfo.findPlayerName);
;5051:		}
LABELV $3524
line 5052
;5052:		uiInfo.nextFindPlayerRefresh = 0;
ADDRGP4 uiInfo+60716
CNSTI4 0
ASGNI4
line 5054
;5053:		// show the server status info for the selected server
;5054:		UI_FeederSelection(FEEDER_FINDPLAYER, uiInfo.currentFoundPlayerServer);
CNSTF4 1096810496
ARGF4
ADDRGP4 uiInfo+60708
INDIRI4
ARGI4
ADDRGP4 UI_FeederSelection
CALLI4
pop
line 5055
;5055:	}
LABELV $3520
line 5056
;5056:}
LABELV $3354
endproc UI_BuildFindPlayerList 4328 24
proc UI_BuildServerStatus 8 16
line 5063
;5057:
;5058:/*
;5059:==================
;5060:UI_BuildServerStatus
;5061:==================
;5062:*/
;5063:static void UI_BuildServerStatus(qboolean force) {
line 5065
;5064:
;5065:	if (uiInfo.nextFindPlayerRefresh) {
ADDRGP4 uiInfo+60716
INDIRI4
CNSTI4 0
EQI4 $3546
line 5066
;5066:		return;
ADDRGP4 $3545
JUMPV
LABELV $3546
line 5068
;5067:	}
;5068:	if (!force) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $3549
line 5069
;5069:		if (!uiInfo.nextServerStatusRefresh || uiInfo.nextServerStatusRefresh > uiInfo.uiDC.realTime) {
ADDRGP4 uiInfo+55388
INDIRI4
CNSTI4 0
EQI4 $3556
ADDRGP4 uiInfo+55388
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
LEI4 $3550
LABELV $3556
line 5070
;5070:			return;
ADDRGP4 $3545
JUMPV
line 5072
;5071:		}
;5072:	}
LABELV $3549
line 5073
;5073:	else {
line 5074
;5074:		Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 5075
;5075:		uiInfo.serverStatusInfo.numLines = 0;
ADDRGP4 uiInfo+52152+3232
CNSTI4 0
ASGNI4
line 5077
;5076:		// reset all server status requests
;5077:		trap_LAN_ServerStatus( NULL, NULL, 0);
CNSTP4 0
ARGP4
CNSTP4 0
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_LAN_ServerStatus
CALLI4
pop
line 5078
;5078:	}
LABELV $3550
line 5079
;5079:	if (uiInfo.serverStatus.currentServer < 0 || uiInfo.serverStatus.currentServer > uiInfo.serverStatus.numDisplayServers || uiInfo.serverStatus.numDisplayServers == 0) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 uiInfo+40604+2216
INDIRI4
ADDRLP4 0
INDIRI4
LTI4 $3570
ADDRGP4 uiInfo+40604+2216
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
GTI4 $3570
ADDRGP4 uiInfo+40604+10412
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $3559
LABELV $3570
line 5080
;5080:		return;
ADDRGP4 $3545
JUMPV
LABELV $3559
line 5082
;5081:	}
;5082:	if (UI_GetServerStatusInfo( uiInfo.serverStatusAddress, &uiInfo.serverStatusInfo ) ) {
ADDRGP4 uiInfo+52088
ARGP4
ADDRGP4 uiInfo+52152
ARGP4
ADDRLP4 4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $3571
line 5083
;5083:		uiInfo.nextServerStatusRefresh = 0;
ADDRGP4 uiInfo+55388
CNSTI4 0
ASGNI4
line 5084
;5084:		UI_GetServerStatusInfo( uiInfo.serverStatusAddress, NULL );
ADDRGP4 uiInfo+52088
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 UI_GetServerStatusInfo
CALLI4
pop
line 5085
;5085:	}
ADDRGP4 $3572
JUMPV
LABELV $3571
line 5086
;5086:	else {
line 5087
;5087:		uiInfo.nextServerStatusRefresh = uiInfo.uiDC.realTime + 500;
ADDRGP4 uiInfo+55388
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 5088
;5088:	}
LABELV $3572
line 5089
;5089:}
LABELV $3545
endproc UI_BuildServerStatus 8 16
proc UI_FeederCount 20 4
line 5097
;5090:
;5091:/*
;5092:==================
;5093:UI_FeederCount
;5094:==================
;5095:*/
;5096:static int UI_FeederCount(float feederID) 
;5097:{
line 5098
;5098:	switch ( (int)feederID )
ADDRLP4 0
ADDRFP4 0
INDIRF4
CVFI4 4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $3580
ADDRLP4 0
INDIRI4
CNSTI4 16
GTI4 $3580
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3624-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $3624
address $3592
address $3596
address $3580
address $3592
address $3580
address $3580
address $3604
address $3612
address $3620
address $3622
address $3580
address $3583
address $3599
address $3602
address $3590
address $3584
code
line 5099
;5099:	{
LABELV $3583
line 5104
;5100://		case FEEDER_HEADS:
;5101://			return UI_HeadCountByTeam();
;5102:
;5103:		case FEEDER_Q3HEADS:
;5104:			return UI_HeadCountByColor();
ADDRLP4 8
ADDRGP4 UI_HeadCountByColor
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3584
line 5107
;5105:
;5106:		case FEEDER_FORCECFG:
;5107:			if (uiForceSide == FORCE_LIGHTSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 1
NEI4 $3585
line 5108
;5108:			{
line 5109
;5109:				return uiInfo.forceConfigCount-uiInfo.forceConfigLightIndexBegin;
ADDRGP4 uiInfo+78148
INDIRI4
ADDRGP4 uiInfo+95056
INDIRI4
SUBI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3585
line 5112
;5110:			}
;5111:			else
;5112:			{
line 5113
;5113:				return uiInfo.forceConfigLightIndexBegin+1;
ADDRGP4 uiInfo+95056
INDIRI4
CNSTI4 1
ADDI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3590
line 5118
;5114:			}
;5115:			//return uiInfo.forceConfigCount;
;5116:
;5117:		case FEEDER_CINEMATICS:
;5118:			return uiInfo.movieCount;
ADDRGP4 uiInfo+36236
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3592
line 5122
;5119:
;5120:		case FEEDER_MAPS:
;5121:		case FEEDER_ALLMAPS:
;5122:			return UI_MapCountByGameType(feederID == FEEDER_MAPS ? qtrue : qfalse);
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3594
ADDRLP4 12
CNSTI4 1
ASGNI4
ADDRGP4 $3595
JUMPV
LABELV $3594
ADDRLP4 12
CNSTI4 0
ASGNI4
LABELV $3595
ADDRLP4 12
INDIRI4
ARGI4
ADDRLP4 16
ADDRGP4 UI_MapCountByGameType
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3596
line 5125
;5123:	
;5124:		case FEEDER_SERVERS:
;5125:			return uiInfo.serverStatus.numDisplayServers;
ADDRGP4 uiInfo+40604+10412
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3599
line 5128
;5126:	
;5127:		case FEEDER_SERVERSTATUS:
;5128:			return uiInfo.serverStatusInfo.numLines;
ADDRGP4 uiInfo+52152+3232
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3602
line 5131
;5129:	
;5130:		case FEEDER_FINDPLAYER:
;5131:			return uiInfo.numFoundPlayerServers;
ADDRGP4 uiInfo+60712
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3604
line 5134
;5132:
;5133:		case FEEDER_PLAYER_LIST:
;5134:			if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) 
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+18016
INDIRI4
LEI4 $3605
line 5135
;5135:			{
line 5136
;5136:				uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+18016
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 5137
;5137:				UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 5138
;5138:			}
LABELV $3605
line 5139
;5139:			return uiInfo.playerCount;
ADDRGP4 uiInfo+18004
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3612
line 5142
;5140:
;5141:		case FEEDER_TEAM_LIST:
;5142:			if (uiInfo.uiDC.realTime > uiInfo.playerRefresh) 
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+18016
INDIRI4
LEI4 $3613
line 5143
;5143:			{
line 5144
;5144:				uiInfo.playerRefresh = uiInfo.uiDC.realTime + 3000;
ADDRGP4 uiInfo+18016
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 3000
ADDI4
ASGNI4
line 5145
;5145:				UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 5146
;5146:			}
LABELV $3613
line 5147
;5147:			return uiInfo.myTeamCount;
ADDRGP4 uiInfo+18008
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3620
line 5150
;5148:
;5149:		case FEEDER_MODS:
;5150:			return uiInfo.modCount;
ADDRGP4 uiInfo+34172
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3622
line 5153
;5151:	
;5152:		case FEEDER_DEMOS:
;5153:			return uiInfo.demoCount;
ADDRGP4 uiInfo+35204
INDIRI4
RETI4
ADDRGP4 $3579
JUMPV
LABELV $3580
line 5156
;5154:	}
;5155:
;5156:	return 0;
CNSTI4 0
RETI4
LABELV $3579
endproc UI_FeederCount 20 4
proc UI_SelectedMap 8 0
line 5159
;5157:}
;5158:
;5159:static const char *UI_SelectedMap(int index, int *actual) {
line 5161
;5160:	int i, c;
;5161:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5162
;5162:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 5164
;5163:
;5164:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3630
JUMPV
LABELV $3627
line 5165
;5165:		if (uiInfo.mapList[i].active) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3632
line 5166
;5166:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3636
line 5167
;5167:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 5168
;5168:				return uiInfo.mapList[i].mapName;
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212
ADDP4
INDIRP4
RETP4
ADDRGP4 $3626
JUMPV
LABELV $3636
line 5169
;5169:			} else {
line 5170
;5170:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5171
;5171:			}
line 5172
;5172:		}
LABELV $3632
line 5173
;5173:	}
LABELV $3628
line 5164
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3630
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LTI4 $3627
line 5174
;5174:	return "";
ADDRGP4 $170
RETP4
LABELV $3626
endproc UI_SelectedMap 8 0
proc UI_SelectedHead 8 0
line 5177
;5175:}
;5176:
;5177:static const char *UI_SelectedHead(int index, int *actual) {
line 5179
;5178:	int i, c;
;5179:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5180
;5180:	*actual = 0;
ADDRFP4 4
INDIRP4
CNSTI4 0
ASGNI4
line 5181
;5181:	for (i = 0; i < uiInfo.characterCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3643
JUMPV
LABELV $3640
line 5182
;5182:		if (uiInfo.characterList[i].active) {
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+16
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3645
line 5183
;5183:			if (c == index) {
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3649
line 5184
;5184:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 5185
;5185:				return uiInfo.characterList[i].name;
CNSTI4 24
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+11840
ADDP4
INDIRP4
RETP4
ADDRGP4 $3639
JUMPV
LABELV $3649
line 5186
;5186:			} else {
line 5187
;5187:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5188
;5188:			}
line 5189
;5189:		}
LABELV $3645
line 5190
;5190:	}
LABELV $3641
line 5181
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3643
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
LTI4 $3640
line 5191
;5191:	return "";
ADDRGP4 $170
RETP4
LABELV $3639
endproc UI_SelectedHead 8 0
proc UI_SelectedTeamHead 24 8
line 5199
;5192:}
;5193:
;5194:/*
;5195:==================
;5196:UI_HeadCountByColor
;5197:==================
;5198:*/
;5199:static const char *UI_SelectedTeamHead(int index, int *actual) {
line 5201
;5200:	char *teamname;
;5201:	int i,c=0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 5203
;5202:
;5203:	switch(uiSkinColor)
ADDRLP4 12
ADDRGP4 uiSkinColor
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 1
EQI4 $3656
ADDRLP4 12
INDIRI4
CNSTI4 2
EQI4 $3655
ADDRGP4 $3653
JUMPV
line 5204
;5204:	{
LABELV $3655
line 5206
;5205:		case TEAM_BLUE:
;5206:			teamname = "/blue";
ADDRLP4 4
ADDRGP4 $3087
ASGNP4
line 5207
;5207:			break;
ADDRGP4 $3654
JUMPV
LABELV $3656
line 5209
;5208:		case TEAM_RED:
;5209:			teamname = "/red";
ADDRLP4 4
ADDRGP4 $3089
ASGNP4
line 5210
;5210:			break;
ADDRGP4 $3654
JUMPV
LABELV $3653
line 5212
;5211:		default:
;5212:			teamname = "/default";
ADDRLP4 4
ADDRGP4 $3090
ASGNP4
line 5213
;5213:			break;
LABELV $3654
line 5218
;5214:	}
;5215:
;5216:	// Count each head with this color
;5217:
;5218:	for (i=0; i<uiInfo.q3HeadCount; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3660
JUMPV
LABELV $3657
line 5219
;5219:	{
line 5220
;5220:		if (uiInfo.q3HeadNames[i] && strstr(uiInfo.q3HeadNames[i], teamname))
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ASGNI4
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+60736
ADDP4
CVPU4 4
CNSTU4 0
EQU4 $3662
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3662
line 5221
;5221:		{
line 5222
;5222:			if (c==index)
ADDRLP4 8
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3666
line 5223
;5223:			{
line 5224
;5224:				*actual = i;
ADDRFP4 4
INDIRP4
ADDRLP4 0
INDIRI4
ASGNI4
line 5225
;5225:				return uiInfo.q3HeadNames[i];
ADDRLP4 0
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
RETP4
ADDRGP4 $3652
JUMPV
LABELV $3666
line 5228
;5226:			}
;5227:			else
;5228:			{
line 5229
;5229:				c++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5230
;5230:			}
line 5231
;5231:		}
LABELV $3662
line 5232
;5232:	}
LABELV $3658
line 5218
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3660
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+60732
INDIRI4
LTI4 $3657
line 5233
;5233:	return "";
ADDRGP4 $170
RETP4
LABELV $3652
endproc UI_SelectedTeamHead 24 8
proc UI_GetIndexFromSelection 8 0
line 5237
;5234:}
;5235:
;5236:
;5237:static int UI_GetIndexFromSelection(int actual) {
line 5239
;5238:	int i, c;
;5239:	c = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5240
;5240:	for (i = 0; i < uiInfo.mapCount; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $3673
JUMPV
LABELV $3670
line 5241
;5241:		if (uiInfo.mapList[i].active) {
CNSTI4 100
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+96
ADDP4
INDIRI4
CNSTI4 0
EQI4 $3675
line 5242
;5242:			if (i == actual) {
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
NEI4 $3679
line 5243
;5243:				return c;
ADDRLP4 4
INDIRI4
RETI4
ADDRGP4 $3669
JUMPV
LABELV $3679
line 5245
;5244:			}
;5245:				c++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5246
;5246:		}
LABELV $3675
line 5247
;5247:	}
LABELV $3671
line 5240
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $3673
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
LTI4 $3670
line 5248
;5248:  return 0;
CNSTI4 0
RETI4
LABELV $3669
endproc UI_GetIndexFromSelection 8 0
proc UI_UpdatePendingPings 0 4
line 5251
;5249:}
;5250:
;5251:static void UI_UpdatePendingPings() { 
line 5252
;5252:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 5253
;5253:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+40604+2212
CNSTI4 1
ASGNI4
line 5254
;5254:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+40604+2192
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 5256
;5255:
;5256:}
LABELV $3681
endproc UI_UpdatePendingPings 0 4
bss
align 1
LABELV $3689
skip 1024
align 1
LABELV $3690
skip 1024
align 1
LABELV $3691
skip 32
data
align 4
LABELV $3692
byte 4 -1
align 4
LABELV $3693
byte 4 0
code
proc UI_FeederItemText 56 20
line 5258
;5257:
;5258:static const char *UI_FeederItemText(float feederID, int index, int column, qhandle_t *handle) {
line 5264
;5259:	static char info[MAX_STRING_CHARS];
;5260:	static char hostname[1024];
;5261:	static char clientBuff[32];
;5262:	static int lastColumn = -1;
;5263:	static int lastTime = 0;
;5264:	*handle = -1;
ADDRFP4 12
INDIRP4
CNSTI4 -1
ASGNI4
line 5265
;5265:	if (feederID == FEEDER_HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3694
line 5267
;5266:		int actual;
;5267:		return UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 UI_SelectedHead
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3694
line 5268
;5268:	} else if (feederID == FEEDER_Q3HEADS) {
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3696
line 5270
;5269:		int actual;
;5270:		return UI_SelectedTeamHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRLP4 4
ADDRGP4 UI_SelectedTeamHead
CALLP4
ASGNP4
ADDRLP4 4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3696
line 5271
;5271:	} else if (feederID == FEEDER_FORCECFG) {
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
NEF4 $3698
line 5272
;5272:		if (index >= 0 && index < uiInfo.forceConfigCount) {
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $3699
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
GEI4 $3699
line 5273
;5273:			if (index == 0)
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $3703
line 5274
;5274:			{ //always show "custom"
line 5275
;5275:				return uiInfo.forceConfigNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 uiInfo+78156
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3703
line 5278
;5276:			}
;5277:			else
;5278:			{
line 5279
;5279:				if (uiForceSide == FORCE_LIGHTSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 1
NEI4 $3706
line 5280
;5280:				{
line 5281
;5281:					index += uiInfo.forceConfigLightIndexBegin;
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+95056
INDIRI4
ADDI4
ASGNI4
line 5282
;5282:					if (index < 0)
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $3709
line 5283
;5283:					{
line 5284
;5284:						return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3709
line 5286
;5285:					}
;5286:					if (index >= uiInfo.forceConfigCount)
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
LTI4 $3711
line 5287
;5287:					{
line 5288
;5288:						return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3711
line 5290
;5289:					}
;5290:					return uiInfo.forceConfigNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 uiInfo+78156
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3706
line 5292
;5291:				}
;5292:				else if (uiForceSide == FORCE_DARKSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 2
NEI4 $3715
line 5293
;5293:				{
line 5294
;5294:					index += uiInfo.forceConfigDarkIndexBegin;
ADDRFP4 4
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+95052
INDIRI4
ADDI4
ASGNI4
line 5295
;5295:					if (index < 0)
ADDRFP4 4
INDIRI4
CNSTI4 0
GEI4 $3718
line 5296
;5296:					{
line 5297
;5297:						return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3718
line 5299
;5298:					}
;5299:					if (index > uiInfo.forceConfigLightIndexBegin)
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+95056
INDIRI4
LEI4 $3720
line 5300
;5300:					{ //dark gets read in before light
line 5301
;5301:						return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3720
line 5303
;5302:					}
;5303:					if (index >= uiInfo.forceConfigCount)
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
LTI4 $3723
line 5304
;5304:					{
line 5305
;5305:						return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3723
line 5307
;5306:					}
;5307:					return uiInfo.forceConfigNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 uiInfo+78156
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3715
line 5310
;5308:				}
;5309:				else
;5310:				{
line 5311
;5311:					return NULL;
CNSTP4 0
RETP4
ADDRGP4 $3688
JUMPV
line 5315
;5312:				}
;5313:			}
;5314:		}
;5315:	} else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) {
LABELV $3698
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3729
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3727
LABELV $3729
line 5317
;5316:		int actual;
;5317:		return UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRLP4 8
ADDRGP4 UI_SelectedMap
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3727
line 5318
;5318:	} else if (feederID == FEEDER_SERVERS) {
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3730
line 5319
;5319:		if (index >= 0 && index < uiInfo.serverStatus.numDisplayServers) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3731
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
GEI4 $3731
line 5321
;5320:			int ping, game;
;5321:			if (lastColumn != column || lastTime > uiInfo.uiDC.realTime + 5000) {
ADDRGP4 $3692
INDIRI4
ADDRFP4 8
INDIRI4
NEI4 $3739
ADDRGP4 $3693
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 5000
ADDI4
LEI4 $3736
LABELV $3739
line 5322
;5322:				trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3689
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 5323
;5323:				lastColumn = column;
ADDRGP4 $3692
ADDRFP4 8
INDIRI4
ASGNI4
line 5324
;5324:				lastTime = uiInfo.uiDC.realTime;
ADDRGP4 $3693
ADDRGP4 uiInfo+232
INDIRI4
ASGNI4
line 5325
;5325:			}
LABELV $3736
line 5326
;5326:			ping = atoi(Info_ValueForKey(info, "ping"));
ADDRGP4 $3689
ARGP4
ADDRGP4 $3324
ARGP4
ADDRLP4 16
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 5327
;5327:			if (ping == -1) {
ADDRLP4 8
INDIRI4
CNSTI4 -1
NEI4 $3744
line 5330
;5328:				// if we ever see a ping that is out of date, do a server refresh
;5329:				// UI_UpdatePendingPings();
;5330:			}
LABELV $3744
line 5331
;5331:			switch (column) {
ADDRLP4 24
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
LTI4 $3731
ADDRLP4 24
INDIRI4
CNSTI4 4
GTI4 $3731
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $3772
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $3772
address $3748
address $3761
address $3762
address $3764
address $3768
code
LABELV $3748
line 5333
;5332:				case SORT_HOST : 
;5333:					if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3749
line 5334
;5334:						return Info_ValueForKey(info, "addr");
ADDRGP4 $3689
ARGP4
ADDRGP4 $2840
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3749
line 5335
;5335:					} else {
line 5336
;5336:						if ( ui_netSource.integer == AS_LOCAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $3751
line 5337
;5337:							Com_sprintf( hostname, sizeof(hostname), "%s [%s]",
ADDRGP4 $3689
ARGP4
ADDRGP4 $2839
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3689
ARGP4
ADDRGP4 $3755
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRGP4 $3690
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3754
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 36
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 netnames
ADDP4
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5340
;5338:											Info_ValueForKey(info, "hostname"),
;5339:											netnames[atoi(Info_ValueForKey(info, "nettype"))] );
;5340:							return hostname;
ADDRGP4 $3690
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3751
line 5342
;5341:						}
;5342:						else {
line 5343
;5343:							if (atoi(Info_ValueForKey(info, "sv_allowAnonymous")) != 0) {				// anonymous server
ADDRGP4 $3689
ARGP4
ADDRGP4 $3758
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $3756
line 5344
;5344:								Com_sprintf( hostname, sizeof(hostname), "(A) %s",
ADDRGP4 $3689
ARGP4
ADDRGP4 $2839
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3690
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3759
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5346
;5345:												Info_ValueForKey(info, "hostname"));
;5346:							} else {
ADDRGP4 $3757
JUMPV
LABELV $3756
line 5347
;5347:								Com_sprintf( hostname, sizeof(hostname), "%s",
ADDRGP4 $3689
ARGP4
ADDRGP4 $2839
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3690
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 $3760
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5349
;5348:												Info_ValueForKey(info, "hostname"));
;5349:							}
LABELV $3757
line 5350
;5350:							return hostname;
ADDRGP4 $3690
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3761
line 5353
;5351:						}
;5352:					}
;5353:				case SORT_MAP : return Info_ValueForKey(info, "mapname");
ADDRGP4 $3689
ARGP4
ADDRGP4 $3281
ARGP4
ADDRLP4 28
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3762
line 5355
;5354:				case SORT_CLIENTS : 
;5355:					Com_sprintf( clientBuff, sizeof(clientBuff), "%s (%s)", Info_ValueForKey(info, "clients"), Info_ValueForKey(info, "sv_maxclients"));
ADDRGP4 $3689
ARGP4
ADDRGP4 $3227
ARGP4
ADDRLP4 32
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3689
ARGP4
ADDRGP4 $1418
ARGP4
ADDRLP4 36
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $3691
ARGP4
CNSTI4 32
ARGI4
ADDRGP4 $3763
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5356
;5356:					return clientBuff;
ADDRGP4 $3691
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3764
line 5358
;5357:				case SORT_GAME : 
;5358:					game = atoi(Info_ValueForKey(info, "gametype"));
ADDRGP4 $3689
ARGP4
ADDRGP4 $3247
ARGP4
ADDRLP4 40
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 atoi
CALLI4
ASGNI4
ADDRLP4 12
ADDRLP4 44
INDIRI4
ASGNI4
line 5359
;5359:					if (game >= 0 && game < numTeamArenaGameTypes) {
ADDRLP4 48
ADDRLP4 12
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
LTI4 $3765
ADDRLP4 48
INDIRI4
ADDRGP4 numTeamArenaGameTypes
INDIRI4
GEI4 $3765
line 5360
;5360:						return teamArenaGameTypes[game];
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamArenaGameTypes
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3765
line 5361
;5361:					} else {
line 5362
;5362:						return "Unknown";
ADDRGP4 $3767
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3768
line 5365
;5363:					}
;5364:				case SORT_PING : 
;5365:					if (ping <= 0) {
ADDRLP4 8
INDIRI4
CNSTI4 0
GTI4 $3769
line 5366
;5366:						return "...";
ADDRGP4 $3771
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3769
line 5367
;5367:					} else {
line 5368
;5368:						return Info_ValueForKey(info, "ping");
ADDRGP4 $3689
ARGP4
ADDRGP4 $3324
ARGP4
ADDRLP4 52
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 52
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
line 5371
;5369:					}
;5370:			}
;5371:		}
line 5372
;5372:	} else if (feederID == FEEDER_SERVERSTATUS) {
LABELV $3730
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3773
line 5373
;5373:		if ( index >= 0 && index < uiInfo.serverStatusInfo.numLines ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3774
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+52152+3232
INDIRI4
GEI4 $3774
line 5374
;5374:			if ( column >= 0 && column < 4 ) {
ADDRLP4 8
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3774
ADDRLP4 8
INDIRI4
CNSTI4 4
GEI4 $3774
line 5375
;5375:				return uiInfo.serverStatusInfo.lines[index][column];
ADDRFP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 uiInfo+52152+64
ADDP4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
line 5377
;5376:			}
;5377:		}
line 5378
;5378:	} else if (feederID == FEEDER_FINDPLAYER) {
LABELV $3773
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3783
line 5379
;5379:		if ( index >= 0 && index < uiInfo.numFoundPlayerServers ) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3784
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+60712
INDIRI4
GEI4 $3784
line 5381
;5380:			//return uiInfo.foundPlayerServerAddresses[index];
;5381:			return uiInfo.foundPlayerServerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+59684
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
line 5383
;5382:		}
;5383:	} else if (feederID == FEEDER_PLAYER_LIST) {
LABELV $3783
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $3789
line 5384
;5384:		if (index >= 0 && index < uiInfo.playerCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3790
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+18004
INDIRI4
GEI4 $3790
line 5385
;5385:			return uiInfo.playerNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+18032
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
line 5387
;5386:		}
;5387:	} else if (feederID == FEEDER_TEAM_LIST) {
LABELV $3789
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $3795
line 5388
;5388:		if (index >= 0 && index < uiInfo.myTeamCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3796
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+18008
INDIRI4
GEI4 $3796
line 5389
;5389:			return uiInfo.teamNames[index];
ADDRFP4 4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 uiInfo+19056
ADDP4
RETP4
ADDRGP4 $3688
JUMPV
line 5391
;5390:		}
;5391:	} else if (feederID == FEEDER_MODS) {
LABELV $3795
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $3801
line 5392
;5392:		if (index >= 0 && index < uiInfo.modCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3802
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+34172
INDIRI4
GEI4 $3802
line 5393
;5393:			if (uiInfo.modList[index].modDescr && *uiInfo.modList[index].modDescr) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+33660+4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3806
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+33660+4
ADDP4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3806
line 5394
;5394:				return uiInfo.modList[index].modDescr;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+33660+4
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3806
line 5395
;5395:			} else {
line 5396
;5396:				return uiInfo.modList[index].modName;
ADDRFP4 4
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+33660
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
line 5399
;5397:			}
;5398:		}
;5399:	} else if (feederID == FEEDER_CINEMATICS) {
LABELV $3801
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $3815
line 5400
;5400:		if (index >= 0 && index < uiInfo.movieCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3816
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+36236
INDIRI4
GEI4 $3816
line 5401
;5401:			return uiInfo.movieList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+35212
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
line 5403
;5402:		}
;5403:	} else if (feederID == FEEDER_DEMOS) {
LABELV $3815
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $3821
line 5404
;5404:		if (index >= 0 && index < uiInfo.demoCount) {
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3823
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+35204
INDIRI4
GEI4 $3823
line 5405
;5405:			return uiInfo.demoList[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+34180
ADDP4
INDIRP4
RETP4
ADDRGP4 $3688
JUMPV
LABELV $3823
line 5407
;5406:		}
;5407:	} 
LABELV $3821
LABELV $3816
LABELV $3802
LABELV $3796
LABELV $3790
LABELV $3784
LABELV $3774
LABELV $3731
LABELV $3699
line 5408
;5408:	return "";
ADDRGP4 $170
RETP4
LABELV $3688
endproc UI_FeederItemText 56 20
proc UI_FeederItemImage 296 16
line 5412
;5409:}
;5410:
;5411:
;5412:static qhandle_t UI_FeederItemImage(float feederID, int index) {
line 5413
;5413:	if (feederID == FEEDER_HEADS) 
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3828
line 5414
;5414:	{
line 5416
;5415:		int actual;
;5416:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 5417
;5417:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 5418
;5418:		if (index >= 0 && index < uiInfo.characterCount) 
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3829
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
GEI4 $3829
line 5419
;5419:		{
line 5420
;5420:			if (uiInfo.characterList[index].headImage == -1) 
CNSTI4 24
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+8
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3833
line 5421
;5421:			{
line 5422
;5422:				uiInfo.characterList[index].headImage = trap_R_RegisterShaderNoMip(uiInfo.characterList[index].imageName);
ADDRLP4 8
CNSTI4 24
ADDRFP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+11840+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+11840+8
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 5423
;5423:			}
LABELV $3833
line 5424
;5424:			return uiInfo.characterList[index].headImage;
CNSTI4 24
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+8
ADDP4
INDIRI4
RETI4
ADDRGP4 $3827
JUMPV
line 5426
;5425:		}
;5426:	} 
LABELV $3828
line 5427
;5427:	else if (feederID == FEEDER_Q3HEADS) 
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3843
line 5428
;5428:	{
line 5430
;5429:		int actual;
;5430:		UI_SelectedTeamHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedTeamHead
CALLP4
pop
line 5431
;5431:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 5433
;5432:
;5433:		if (index >= 0 && index < uiInfo.q3HeadCount)
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3844
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+60732
INDIRI4
GEI4 $3844
line 5434
;5434:		{ //we want it to load them as it draws them, like the TA feeder
line 5436
;5435:		      //return uiInfo.q3HeadIcons[index];
;5436:			int selModel = trap_Cvar_VariableValue("ui_selectedModelIndex");
ADDRGP4 $3848
ARGP4
ADDRLP4 12
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
CVFI4 4
ASGNI4
line 5438
;5437:
;5438:			if (selModel != -1)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $3849
line 5439
;5439:			{
line 5440
;5440:				if (uiInfo.q3SelectedHead != selModel)
ADDRGP4 uiInfo+78144
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $3851
line 5441
;5441:				{
line 5442
;5442:					uiInfo.q3SelectedHead = selModel;
ADDRGP4 uiInfo+78144
ADDRLP4 8
INDIRI4
ASGNI4
line 5444
;5443:					//UI_FeederSelection(FEEDER_Q3HEADS, uiInfo.q3SelectedHead);
;5444:					Menu_SetFeederSelection(NULL, FEEDER_Q3HEADS, selModel, NULL);
CNSTP4 0
ARGP4
CNSTI4 12
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 5445
;5445:				}
LABELV $3851
line 5446
;5446:			}
LABELV $3849
line 5448
;5447:
;5448:			if (!uiInfo.q3HeadIcons[index])
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+77120
ADDP4
INDIRI4
CNSTI4 0
NEI4 $3855
line 5449
;5449:			{ //this isn't the best way of doing this I guess, but I didn't want a whole seperate string array
line 5453
;5450:			  //for storing shader names. I can't just replace q3HeadNames with the shader name, because we
;5451:			  //print what's in q3HeadNames and the icon name would look funny.
;5452:				char iconNameFromSkinName[256];
;5453:				int i = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5456
;5454:				int skinPlace;
;5455:
;5456:				i = strlen(uiInfo.q3HeadNames[index]);
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRLP4 280
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 280
INDIRI4
ASGNI4
ADDRGP4 $3860
JUMPV
LABELV $3859
line 5459
;5457:
;5458:				while (uiInfo.q3HeadNames[index][i] != '/')
;5459:				{
line 5460
;5460:					i--;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5461
;5461:				}
LABELV $3860
line 5458
ADDRLP4 16
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $3859
line 5463
;5462:
;5463:				i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5464
;5464:				skinPlace = i; //remember that this is where the skin name begins
ADDRLP4 20
ADDRLP4 16
INDIRI4
ASGNI4
line 5467
;5465:
;5466:				//now, build a full path out of what's in q3HeadNames, into iconNameFromSkinName
;5467:				Com_sprintf(iconNameFromSkinName, sizeof(iconNameFromSkinName), "models/players/%s", uiInfo.q3HeadNames[index]);
ADDRLP4 24
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3863
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5469
;5468:
;5469:				i = strlen(iconNameFromSkinName);
ADDRLP4 24
ARGP4
ADDRLP4 284
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 284
INDIRI4
ASGNI4
ADDRGP4 $3866
JUMPV
LABELV $3865
line 5472
;5470:
;5471:				while (iconNameFromSkinName[i] != '/')
;5472:				{
line 5473
;5473:					i--;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5474
;5474:				}
LABELV $3866
line 5471
ADDRLP4 16
INDIRI4
ADDRLP4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $3865
line 5476
;5475:				
;5476:				i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5477
;5477:				iconNameFromSkinName[i] = 0; //terminate, and append..
ADDRLP4 16
INDIRI4
ADDRLP4 24
ADDP4
CNSTI1 0
ASGNI1
line 5478
;5478:				Q_strcat(iconNameFromSkinName, 256, "icon_");
ADDRLP4 24
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 $3868
ARGP4
ADDRGP4 Q_strcat
CALLV
pop
line 5481
;5479:
;5480:				//and now, for the final step, append the skin name from q3HeadNames onto the end of iconNameFromSkinName
;5481:				i = strlen(iconNameFromSkinName);
ADDRLP4 24
ARGP4
ADDRLP4 288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 288
INDIRI4
ASGNI4
ADDRGP4 $3870
JUMPV
LABELV $3869
line 5484
;5482:
;5483:				while (uiInfo.q3HeadNames[index][skinPlace])
;5484:				{
line 5485
;5485:					iconNameFromSkinName[i] = uiInfo.q3HeadNames[index][skinPlace];
ADDRLP4 16
INDIRI4
ADDRLP4 24
ADDP4
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ADDP4
INDIRI1
ASGNI1
line 5486
;5486:					i++;
ADDRLP4 16
ADDRLP4 16
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5487
;5487:					skinPlace++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5488
;5488:				}
LABELV $3870
line 5483
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3869
line 5489
;5489:				iconNameFromSkinName[i] = 0;
ADDRLP4 16
INDIRI4
ADDRLP4 24
ADDP4
CNSTI1 0
ASGNI1
line 5492
;5490:
;5491:				//and now we are ready to register (thankfully this will only happen once)
;5492:				uiInfo.q3HeadIcons[index] = trap_R_RegisterShaderNoMip(iconNameFromSkinName);
ADDRLP4 24
ARGP4
ADDRLP4 292
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+77120
ADDP4
ADDRLP4 292
INDIRI4
ASGNI4
line 5493
;5493:			}
LABELV $3855
line 5494
;5494:			return uiInfo.q3HeadIcons[index];
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+77120
ADDP4
INDIRI4
RETI4
ADDRGP4 $3827
JUMPV
line 5496
;5495:		}
;5496:    }
LABELV $3843
line 5497
;5497:	else if (feederID == FEEDER_ALLMAPS || feederID == FEEDER_MAPS) 
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
EQF4 $3878
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3876
LABELV $3878
line 5498
;5498:	{
line 5500
;5499:		int actual;
;5500:		UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 5501
;5501:		index = actual;
ADDRFP4 4
ADDRLP4 4
INDIRI4
ASGNI4
line 5502
;5502:		if (index >= 0 && index < uiInfo.mapCount) {
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3879
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
GEI4 $3879
line 5503
;5503:			if (uiInfo.mapList[index].levelShot == -1) {
CNSTI4 100
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $3882
line 5504
;5504:				uiInfo.mapList[index].levelShot = trap_R_RegisterShaderNoMip(uiInfo.mapList[index].imageName);
ADDRLP4 12
CNSTI4 100
ADDRFP4 4
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+8
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 uiInfo+20212+92
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 5505
;5505:			}
LABELV $3882
line 5506
;5506:			return uiInfo.mapList[index].levelShot;
CNSTI4 100
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
INDIRI4
RETI4
ADDRGP4 $3827
JUMPV
LABELV $3879
line 5508
;5507:		}
;5508:	}
LABELV $3876
LABELV $3844
LABELV $3829
line 5509
;5509:  return 0;
CNSTI4 0
RETI4
LABELV $3827
endproc UI_FeederItemImage 296 16
bss
align 1
LABELV $3893
skip 1024
export UI_FeederSelection
code
proc UI_FeederSelection 52 24
line 5512
;5510:}
;5511:
;5512:qboolean UI_FeederSelection(float feederID, int index) {
line 5514
;5513:	static char info[MAX_STRING_CHARS];
;5514:	if (feederID == FEEDER_HEADS) 
ADDRFP4 0
INDIRF4
CNSTF4 0
NEF4 $3894
line 5515
;5515:	{
line 5517
;5516:		int actual;
;5517:		UI_SelectedHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedHead
CALLP4
pop
line 5518
;5518:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 5519
;5519:		if (index >= 0 && index < uiInfo.characterCount) 
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3895
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+11832
INDIRI4
GEI4 $3895
line 5520
;5520:		{
line 5521
;5521:			trap_Cvar_Set( "team_model", va("%s", uiInfo.characterList[index].base));
ADDRGP4 $3760
ARGP4
CNSTI4 24
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+11840+12
ADDP4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3899
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5523
;5522:			//trap_Cvar_Set( "team_headmodel", va("*%s", uiInfo.characterList[index].name)); 
;5523:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 5524
;5524:		}
line 5525
;5525:	} 
ADDRGP4 $3895
JUMPV
LABELV $3894
line 5526
;5526:	else if (feederID == FEEDER_Q3HEADS) 
ADDRFP4 0
INDIRF4
CNSTF4 1094713344
NEF4 $3902
line 5527
;5527:	{
line 5529
;5528:		int actual;
;5529:		UI_SelectedTeamHead(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 0
ARGP4
ADDRGP4 UI_SelectedTeamHead
CALLP4
pop
line 5530
;5530:		uiInfo.q3SelectedHead = index;
ADDRGP4 uiInfo+78144
ADDRFP4 4
INDIRI4
ASGNI4
line 5531
;5531:		trap_Cvar_Set("ui_selectedModelIndex", va("%i", index));
ADDRGP4 $1314
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $3848
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5532
;5532:		index = actual;
ADDRFP4 4
ADDRLP4 0
INDIRI4
ASGNI4
line 5533
;5533:		if (index >= 0 && index < uiInfo.q3HeadCount) 
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LTI4 $3903
ADDRLP4 8
INDIRI4
ADDRGP4 uiInfo+60732
INDIRI4
GEI4 $3903
line 5534
;5534:		{
line 5535
;5535:			trap_Cvar_Set( "model", uiInfo.q3HeadNames[index]);
ADDRGP4 $3908
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5539
;5536:			//trap_Cvar_Set( "headmodel", uiInfo.q3HeadNames[index]);
;5537:
;5538:			//Update team_model for now here also, because we're using a different team skin system
;5539:			trap_Cvar_Set( "team_model", uiInfo.q3HeadNames[index]);
ADDRGP4 $3899
ARGP4
ADDRFP4 4
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5542
;5540:			//trap_Cvar_Set( "team_headmodel", uiInfo.q3HeadNames[index]); 
;5541:
;5542:			updateModel = qtrue;
ADDRGP4 updateModel
CNSTI4 1
ASGNI4
line 5543
;5543:		}
line 5544
;5544:	} 
ADDRGP4 $3903
JUMPV
LABELV $3902
line 5545
;5545:	else if (feederID == FEEDER_FORCECFG) 
ADDRFP4 0
INDIRF4
CNSTF4 1098907648
NEF4 $3911
line 5546
;5546:	{
line 5547
;5547:		int newindex = index;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 5549
;5548:
;5549:		if (uiForceSide == FORCE_LIGHTSIDE)
ADDRGP4 uiForceSide
INDIRI4
CNSTI4 1
NEI4 $3913
line 5550
;5550:		{
line 5551
;5551:			newindex += uiInfo.forceConfigLightIndexBegin;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+95056
INDIRI4
ADDI4
ASGNI4
line 5552
;5552:			if (newindex >= uiInfo.forceConfigCount)
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
LTI4 $3914
line 5553
;5553:			{
line 5554
;5554:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3892
JUMPV
line 5556
;5555:			}
;5556:		}
LABELV $3913
line 5558
;5557:		else
;5558:		{ //else dark
line 5559
;5559:			newindex += uiInfo.forceConfigDarkIndexBegin;
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+95052
INDIRI4
ADDI4
ASGNI4
line 5560
;5560:			if (newindex >= uiInfo.forceConfigCount || newindex > uiInfo.forceConfigLightIndexBegin)
ADDRLP4 4
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
GEI4 $3924
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+95056
INDIRI4
LEI4 $3920
LABELV $3924
line 5561
;5561:			{ //dark gets read in before light
line 5562
;5562:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $3892
JUMPV
LABELV $3920
line 5564
;5563:			}
;5564:		}
LABELV $3914
line 5566
;5565:
;5566:		if (index >= 0 && index < uiInfo.forceConfigCount) 
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
LTI4 $3912
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+78148
INDIRI4
GEI4 $3912
line 5567
;5567:		{
line 5568
;5568:				UI_ForceConfigHandle(uiInfo.forceConfigSelected, index);
ADDRGP4 uiInfo+78152
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ForceConfigHandle
CALLV
pop
line 5569
;5569:				uiInfo.forceConfigSelected = index;
ADDRGP4 uiInfo+78152
ADDRFP4 4
INDIRI4
ASGNI4
line 5570
;5570:		}
line 5571
;5571:	} 
ADDRGP4 $3912
JUMPV
LABELV $3911
line 5572
;5572:	else if (feederID == FEEDER_MAPS || feederID == FEEDER_ALLMAPS) 
ADDRLP4 0
ADDRFP4 0
INDIRF4
ASGNF4
ADDRLP4 0
INDIRF4
CNSTF4 1065353216
EQF4 $3932
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3930
LABELV $3932
line 5573
;5573:	{
line 5575
;5574:		int actual, map;
;5575:		const char *checkValid = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 5577
;5576:
;5577:		map = (feederID == FEEDER_ALLMAPS) ? ui_currentNetMap.integer : ui_currentMap.integer;
ADDRFP4 0
INDIRF4
CNSTF4 1082130432
NEF4 $3936
ADDRLP4 16
ADDRGP4 ui_currentNetMap+12
INDIRI4
ASGNI4
ADDRGP4 $3937
JUMPV
LABELV $3936
ADDRLP4 16
ADDRGP4 ui_currentMap+12
INDIRI4
ASGNI4
LABELV $3937
ADDRLP4 12
ADDRLP4 16
INDIRI4
ASGNI4
line 5578
;5578:		if (uiInfo.mapList[map].cinematic >= 0) {
CNSTI4 100
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $3938
line 5579
;5579:		  trap_CIN_StopCinematic(uiInfo.mapList[map].cinematic);
CNSTI4 100
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5580
;5580:		  uiInfo.mapList[map].cinematic = -1;
CNSTI4 100
ADDRLP4 12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
CNSTI4 -1
ASGNI4
line 5581
;5581:		}
LABELV $3938
line 5582
;5582:		checkValid = UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRLP4 20
ADDRGP4 UI_SelectedMap
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 5584
;5583:
;5584:		if (!checkValid || !checkValid[0])
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3948
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $3946
LABELV $3948
line 5585
;5585:		{ //this isn't a valid map to select, so reselect the current
line 5586
;5586:			index = ui_mapIndex.integer;
ADDRFP4 4
ADDRGP4 ui_mapIndex+12
INDIRI4
ASGNI4
line 5587
;5587:			UI_SelectedMap(index, &actual);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
ADDRGP4 UI_SelectedMap
CALLP4
pop
line 5588
;5588:		}
LABELV $3946
line 5590
;5589:
;5590:		trap_Cvar_Set("ui_mapIndex", va("%d", index));
ADDRGP4 $685
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $2275
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5591
;5591:		gUISelectedMap = index;
ADDRGP4 gUISelectedMap
ADDRFP4 4
INDIRI4
ASGNI4
line 5592
;5592:		ui_mapIndex.integer = index;
ADDRGP4 ui_mapIndex+12
ADDRFP4 4
INDIRI4
ASGNI4
line 5594
;5593:
;5594:		if (feederID == FEEDER_MAPS) {
ADDRFP4 0
INDIRF4
CNSTF4 1065353216
NEF4 $3951
line 5595
;5595:			ui_currentMap.integer = actual;
ADDRGP4 ui_currentMap+12
ADDRLP4 8
INDIRI4
ASGNI4
line 5596
;5596:			trap_Cvar_Set("ui_currentMap", va("%d", actual));
ADDRGP4 $685
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $922
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5597
;5597:		uiInfo.mapList[ui_currentMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRLP4 36
CNSTI4 100
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 48
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 5598
;5598:			UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 5601
;5599:			//trap_Cvar_Set("ui_opponentModel", uiInfo.mapList[ui_currentMap.integer].opponentName);
;5600:			//updateOpponentModel = qtrue;
;5601:		} else {
ADDRGP4 $3931
JUMPV
LABELV $3951
line 5602
;5602:			ui_currentNetMap.integer = actual;
ADDRGP4 ui_currentNetMap+12
ADDRLP4 8
INDIRI4
ASGNI4
line 5603
;5603:			trap_Cvar_Set("ui_currentNetMap", va("%d", actual));
ADDRGP4 $685
ARGP4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $920
ARGP4
ADDRLP4 32
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5604
;5604:		uiInfo.mapList[ui_currentNetMap.integer].cinematic = trap_CIN_PlayCinematic(va("%s.roq", uiInfo.mapList[ui_currentNetMap.integer].mapLoadName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRLP4 36
CNSTI4 100
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 ui_currentNetMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 48
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 ui_currentNetMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
ADDRLP4 48
INDIRI4
ASGNI4
line 5605
;5605:		}
line 5607
;5606:
;5607:	} else if (feederID == FEEDER_SERVERS) {
ADDRGP4 $3931
JUMPV
LABELV $3930
ADDRFP4 0
INDIRF4
CNSTF4 1073741824
NEF4 $3973
line 5608
;5608:		const char *mapName = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 5609
;5609:		uiInfo.serverStatus.currentServer = index;
ADDRGP4 uiInfo+40604+2216
ADDRFP4 4
INDIRI4
ASGNI4
line 5610
;5610:		trap_LAN_GetServerInfo(ui_netSource.integer, uiInfo.serverStatus.displayServers[index], info, MAX_STRING_CHARS);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+40604+2220
ADDP4
INDIRI4
ARGI4
ADDRGP4 $3893
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_LAN_GetServerInfo
CALLV
pop
line 5611
;5611:		uiInfo.serverStatus.currentServerPreview = trap_R_RegisterShaderNoMip(va("levelshots/%s", Info_ValueForKey(info, "mapname")));
ADDRGP4 $3893
ARGP4
ADDRGP4 $3281
ARGP4
ADDRLP4 8
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRGP4 $1093
ARGP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+40604+10428
ADDRLP4 16
INDIRI4
ASGNI4
line 5612
;5612:		if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+40604+10432
INDIRI4
CNSTI4 0
LTI4 $3982
line 5613
;5613:		  trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+40604+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5614
;5614:			uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+40604+10432
CNSTI4 -1
ASGNI4
line 5615
;5615:		}
LABELV $3982
line 5616
;5616:		mapName = Info_ValueForKey(info, "mapname");
ADDRGP4 $3893
ARGP4
ADDRGP4 $3281
ARGP4
ADDRLP4 20
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 20
INDIRP4
ASGNP4
line 5617
;5617:		if (mapName && *mapName) {
ADDRLP4 24
ADDRLP4 4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $3974
ADDRLP4 24
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $3974
line 5618
;5618:			uiInfo.serverStatus.currentServerCinematic = trap_CIN_PlayCinematic(va("%s.roq", mapName), 0, 0, 0, 0, (CIN_loop | CIN_silent) );
ADDRGP4 $775
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
ADDRLP4 32
INDIRI4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 36
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRGP4 uiInfo+40604+10432
ADDRLP4 36
INDIRI4
ASGNI4
line 5619
;5619:		}
line 5620
;5620:	} else if (feederID == FEEDER_SERVERSTATUS) {
ADDRGP4 $3974
JUMPV
LABELV $3973
ADDRFP4 0
INDIRF4
CNSTF4 1095761920
NEF4 $3994
line 5622
;5621:		//
;5622:	} else if (feederID == FEEDER_FINDPLAYER) {
ADDRGP4 $3995
JUMPV
LABELV $3994
ADDRFP4 0
INDIRF4
CNSTF4 1096810496
NEF4 $3996
line 5623
;5623:	  uiInfo.currentFoundPlayerServer = index;
ADDRGP4 uiInfo+60708
ADDRFP4 4
INDIRI4
ASGNI4
line 5625
;5624:	  //
;5625:	  if ( index < uiInfo.numFoundPlayerServers-1) {
ADDRFP4 4
INDIRI4
ADDRGP4 uiInfo+60712
INDIRI4
CNSTI4 1
SUBI4
GEI4 $3997
line 5627
;5626:			// build a new server status for this server
;5627:			Q_strncpyz(uiInfo.serverStatusAddress, uiInfo.foundPlayerServerAddresses[uiInfo.currentFoundPlayerServer], sizeof(uiInfo.serverStatusAddress));
ADDRGP4 uiInfo+52088
ARGP4
ADDRGP4 uiInfo+60708
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+58660
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRGP4 Q_strncpyz
CALLV
pop
line 5628
;5628:			Menu_SetFeederSelection(NULL, FEEDER_SERVERSTATUS, 0, NULL);
CNSTP4 0
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
CNSTP4 0
ARGP4
ADDRGP4 Menu_SetFeederSelection
CALLV
pop
line 5629
;5629:			UI_BuildServerStatus(qtrue);
CNSTI4 1
ARGI4
ADDRGP4 UI_BuildServerStatus
CALLV
pop
line 5630
;5630:	  }
line 5631
;5631:	} else if (feederID == FEEDER_PLAYER_LIST) {
ADDRGP4 $3997
JUMPV
LABELV $3996
ADDRFP4 0
INDIRF4
CNSTF4 1088421888
NEF4 $4006
line 5632
;5632:		uiInfo.playerIndex = index;
ADDRGP4 uiInfo+18020
ADDRFP4 4
INDIRI4
ASGNI4
line 5633
;5633:	} else if (feederID == FEEDER_TEAM_LIST) {
ADDRGP4 $4007
JUMPV
LABELV $4006
ADDRFP4 0
INDIRF4
CNSTF4 1090519040
NEF4 $4009
line 5634
;5634:		uiInfo.teamIndex = index;
ADDRGP4 uiInfo+18012
ADDRFP4 4
INDIRI4
ASGNI4
line 5635
;5635:	} else if (feederID == FEEDER_MODS) {
ADDRGP4 $4010
JUMPV
LABELV $4009
ADDRFP4 0
INDIRF4
CNSTF4 1091567616
NEF4 $4012
line 5636
;5636:		uiInfo.modIndex = index;
ADDRGP4 uiInfo+34176
ADDRFP4 4
INDIRI4
ASGNI4
line 5637
;5637:	} else if (feederID == FEEDER_CINEMATICS) {
ADDRGP4 $4013
JUMPV
LABELV $4012
ADDRFP4 0
INDIRF4
CNSTF4 1097859072
NEF4 $4015
line 5638
;5638:		uiInfo.movieIndex = index;
ADDRGP4 uiInfo+36240
ADDRFP4 4
INDIRI4
ASGNI4
line 5639
;5639:		if (uiInfo.previewMovie >= 0) {
ADDRGP4 uiInfo+36244
INDIRI4
CNSTI4 0
LTI4 $4018
line 5640
;5640:		  trap_CIN_StopCinematic(uiInfo.previewMovie);
ADDRGP4 uiInfo+36244
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5641
;5641:		}
LABELV $4018
line 5642
;5642:		uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+36244
CNSTI4 -1
ASGNI4
line 5643
;5643:	} else if (feederID == FEEDER_DEMOS) {
ADDRGP4 $4016
JUMPV
LABELV $4015
ADDRFP4 0
INDIRF4
CNSTF4 1092616192
NEF4 $4023
line 5644
;5644:		uiInfo.demoIndex = index;
ADDRGP4 uiInfo+35208
ADDRFP4 4
INDIRI4
ASGNI4
line 5645
;5645:	}
LABELV $4023
LABELV $4016
LABELV $4013
LABELV $4010
LABELV $4007
LABELV $3997
LABELV $3995
LABELV $3974
LABELV $3931
LABELV $3912
LABELV $3903
LABELV $3895
line 5647
;5646:
;5647:	return qtrue;
CNSTI4 1
RETI4
LABELV $3892
endproc UI_FeederSelection 52 24
proc GameType_Parse 28 8
line 5651
;5648:}
;5649:
;5650:
;5651:static qboolean GameType_Parse(char **p, qboolean join) {
line 5654
;5652:	char *token;
;5653:
;5654:	token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5656
;5655:
;5656:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $4027
line 5657
;5657:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4026
JUMPV
LABELV $4027
line 5660
;5658:	}
;5659:
;5660:	if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4029
line 5661
;5661:		uiInfo.numJoinGameTypes = 0;
ADDRGP4 uiInfo+17868
CNSTI4 0
ASGNI4
line 5662
;5662:	} else {
ADDRGP4 $4034
JUMPV
LABELV $4029
line 5663
;5663:		uiInfo.numGameTypes = 0;
ADDRGP4 uiInfo+17736
CNSTI4 0
ASGNI4
line 5664
;5664:	}
ADDRGP4 $4034
JUMPV
LABELV $4033
line 5666
;5665:
;5666:	while ( 1 ) {
line 5667
;5667:		token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 5669
;5668:
;5669:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $429
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $4036
line 5670
;5670:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $4026
JUMPV
LABELV $4036
line 5673
;5671:		}
;5672:
;5673:		if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4040
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4038
LABELV $4040
line 5674
;5674:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4026
JUMPV
LABELV $4038
line 5677
;5675:		}
;5676:
;5677:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $4041
line 5679
;5678:			// two tokens per line, character name and sex
;5679:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4043
line 5680
;5680:				if (!String_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gameType) || !Int_Parse(p, &uiInfo.joinGameTypes[uiInfo.numJoinGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+17868
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17872
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $4052
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+17868
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17872+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $4044
LABELV $4052
line 5681
;5681:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4026
JUMPV
line 5683
;5682:				}
;5683:			} else {
LABELV $4043
line 5684
;5684:				if (!String_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gameType) || !Int_Parse(p, &uiInfo.gameTypes[uiInfo.numGameTypes].gtEnum)) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+17736
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $4060
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 uiInfo+17736
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $4053
LABELV $4060
line 5685
;5685:					return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4026
JUMPV
LABELV $4053
line 5687
;5686:				}
;5687:			}
LABELV $4044
line 5689
;5688:    
;5689:			if (join) {
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4061
line 5690
;5690:				if (uiInfo.numJoinGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+17868
INDIRI4
CNSTI4 16
GEI4 $4063
line 5691
;5691:					uiInfo.numJoinGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+17868
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5692
;5692:				} else {
ADDRGP4 $4062
JUMPV
LABELV $4063
line 5693
;5693:					Com_Printf("Too many net game types, last one replace!\n");
ADDRGP4 $4067
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5694
;5694:				}		
line 5695
;5695:			} else {
ADDRGP4 $4062
JUMPV
LABELV $4061
line 5696
;5696:				if (uiInfo.numGameTypes < MAX_GAMETYPES) {
ADDRGP4 uiInfo+17736
INDIRI4
CNSTI4 16
GEI4 $4068
line 5697
;5697:					uiInfo.numGameTypes++;
ADDRLP4 20
ADDRGP4 uiInfo+17736
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5698
;5698:				} else {
ADDRGP4 $4069
JUMPV
LABELV $4068
line 5699
;5699:					Com_Printf("Too many game types, last one replace!\n");
ADDRGP4 $4072
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5700
;5700:				}		
LABELV $4069
line 5701
;5701:			}
LABELV $4062
line 5703
;5702:     
;5703:			token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 20
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 20
INDIRP4
ASGNP4
line 5704
;5704:			if (token[0] != '}') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 125
EQI4 $4073
line 5705
;5705:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4026
JUMPV
LABELV $4073
line 5707
;5706:			}
;5707:		}
LABELV $4041
line 5708
;5708:	}
LABELV $4034
line 5666
ADDRGP4 $4033
JUMPV
line 5709
;5709:	return qfalse;
CNSTI4 0
RETI4
LABELV $4026
endproc GameType_Parse 28 8
proc MapList_Parse 52 8
line 5712
;5710:}
;5711:
;5712:static qboolean MapList_Parse(char **p) {
line 5715
;5713:	char *token;
;5714:
;5715:	token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 5717
;5716:
;5717:	if (token[0] != '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
EQI4 $4076
line 5718
;5718:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4075
JUMPV
LABELV $4076
line 5721
;5719:	}
;5720:
;5721:	uiInfo.mapCount = 0;
ADDRGP4 uiInfo+20208
CNSTI4 0
ASGNI4
ADDRGP4 $4080
JUMPV
LABELV $4079
line 5723
;5722:
;5723:	while ( 1 ) {
line 5724
;5724:		token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 8
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
ASGNP4
line 5726
;5725:
;5726:		if (Q_stricmp(token, "}") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $429
ARGP4
ADDRLP4 12
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $4082
line 5727
;5727:			return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $4075
JUMPV
LABELV $4082
line 5730
;5728:		}
;5729:
;5730:		if ( !token || token[0] == 0 ) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4086
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4084
LABELV $4086
line 5731
;5731:			return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4075
JUMPV
LABELV $4084
line 5734
;5732:		}
;5733:
;5734:		if (token[0] == '{') {
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 123
NEI4 $4087
line 5735
;5735:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapName) || !String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].mapLoadName) 
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212
ADDP4
ARGP4
ADDRLP4 20
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $4100
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
ARGP4
ADDRLP4 24
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $4100
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+16
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $4089
LABELV $4100
line 5736
;5736:				||!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].teamMembers) ) {
line 5737
;5737:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4075
JUMPV
LABELV $4089
line 5740
;5738:			}
;5739:
;5740:			if (!String_Parse(p, &uiInfo.mapList[uiInfo.mapCount].opponentName)) {
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+12
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 String_Parse
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $4101
line 5741
;5741:				return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4075
JUMPV
LABELV $4101
line 5744
;5742:			}
;5743:
;5744:			uiInfo.mapList[uiInfo.mapCount].typeBits = 0;
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+20
ADDP4
CNSTI4 0
ASGNI4
ADDRGP4 $4110
JUMPV
LABELV $4109
line 5746
;5745:
;5746:			while (1) {
line 5747
;5747:				token = COM_ParseExt((const char **)p, qtrue);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 36
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 36
INDIRP4
ASGNP4
line 5748
;5748:				if (token[0] >= '0' && token[0] <= '9') {
ADDRLP4 40
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 48
LTI4 $4111
ADDRLP4 40
INDIRI4
CNSTI4 57
GTI4 $4111
line 5749
;5749:					uiInfo.mapList[uiInfo.mapCount].typeBits |= (1 << (token[0] - 0x030));
ADDRLP4 44
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+20
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 48
SUBI4
LSHI4
BORI4
ASGNI4
line 5750
;5750:					if (!Int_Parse(p, &uiInfo.mapList[uiInfo.mapCount].timeToBeat[token[0] - 0x30])) {
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 2
LSHI4
CNSTI4 192
SUBI4
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+28
ADDP4
ADDP4
ARGP4
ADDRLP4 48
ADDRGP4 Int_Parse
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $4113
line 5751
;5751:						return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $4075
JUMPV
line 5753
;5752:					}
;5753:				} else {
line 5754
;5754:					break;
LABELV $4113
line 5756
;5755:				} 
;5756:			}
LABELV $4110
line 5746
ADDRGP4 $4109
JUMPV
LABELV $4111
line 5763
;5757:
;5758:			//mapList[mapCount].imageName = String_Alloc(va("levelshots/%s", mapList[mapCount].mapLoadName));
;5759:			//if (uiInfo.mapCount == 0) {
;5760:			  // only load the first cinematic, selection loads the others
;5761:  			//  uiInfo.mapList[uiInfo.mapCount].cinematic = trap_CIN_PlayCinematic(va("%s.roq",uiInfo.mapList[uiInfo.mapCount].mapLoadName), qfalse, qfalse, qtrue, 0, 0, 0, 0);
;5762:			//}
;5763:  		uiInfo.mapList[uiInfo.mapCount].cinematic = -1;
CNSTI4 100
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
CNSTI4 -1
ASGNI4
line 5764
;5764:			uiInfo.mapList[uiInfo.mapCount].levelShot = trap_R_RegisterShaderNoMip(va("levelshots/%s_small", uiInfo.mapList[uiInfo.mapCount].mapLoadName));
ADDRGP4 $4128
ARGP4
ADDRLP4 36
CNSTI4 100
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRGP4 uiInfo+20208
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+92
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 5766
;5765:
;5766:			if (uiInfo.mapCount < MAX_MAPS) {
ADDRGP4 uiInfo+20208
INDIRI4
CNSTI4 128
GEI4 $4132
line 5767
;5767:				uiInfo.mapCount++;
ADDRLP4 48
ADDRGP4 uiInfo+20208
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5768
;5768:			} else {
ADDRGP4 $4133
JUMPV
LABELV $4132
line 5769
;5769:				Com_Printf("Too many maps, last one replaced!\n");
ADDRGP4 $4136
ARGP4
ADDRGP4 Com_Printf
CALLV
pop
line 5770
;5770:			}
LABELV $4133
line 5771
;5771:		}
LABELV $4087
line 5772
;5772:	}
LABELV $4080
line 5723
ADDRGP4 $4079
JUMPV
line 5773
;5773:	return qfalse;
CNSTI4 0
RETI4
LABELV $4075
endproc MapList_Parse 52 8
proc UI_ParseGameInfo 44 8
line 5776
;5774:}
;5775:
;5776:static void UI_ParseGameInfo(const char *teamFile) {
line 5779
;5777:	char	*token;
;5778:	char *p;
;5779:	char *buff = NULL;
ADDRLP4 8
CNSTP4 0
ASGNP4
line 5782
;5780:	//int mode = 0; TTimo: unused
;5781:
;5782:	buff = GetMenuBuffer(teamFile);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 GetMenuBuffer
CALLP4
ASGNP4
ADDRLP4 8
ADDRLP4 12
INDIRP4
ASGNP4
line 5783
;5783:	if (!buff) {
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $4138
line 5784
;5784:		return;
ADDRGP4 $4137
JUMPV
LABELV $4138
line 5787
;5785:	}
;5786:
;5787:	p = buff;
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
ADDRGP4 $4141
JUMPV
LABELV $4140
line 5789
;5788:
;5789:	while ( 1 ) {
line 5790
;5790:		token = COM_ParseExt( (const char **)(&p), qtrue );
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 16
ADDRGP4 COM_ParseExt
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 16
INDIRP4
ASGNP4
line 5791
;5791:		if( !token || token[0] == 0 || token[0] == '}') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4146
ADDRLP4 24
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $4146
ADDRLP4 24
INDIRI4
CNSTI4 125
NEI4 $4143
LABELV $4146
line 5792
;5792:			break;
ADDRGP4 $4142
JUMPV
LABELV $4143
line 5795
;5793:		}
;5794:
;5795:		if ( Q_stricmp( token, "}" ) == 0 ) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $429
ARGP4
ADDRLP4 28
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $4147
line 5796
;5796:			break;
ADDRGP4 $4142
JUMPV
LABELV $4147
line 5799
;5797:		}
;5798:
;5799:		if (Q_stricmp(token, "gametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4151
ARGP4
ADDRLP4 32
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $4149
line 5801
;5800:
;5801:			if (GameType_Parse(&p, qfalse)) {
ADDRLP4 4
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 36
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
EQI4 $4142
line 5802
;5802:				continue;
ADDRGP4 $4141
JUMPV
line 5803
;5803:			} else {
line 5804
;5804:				break;
LABELV $4149
line 5808
;5805:			}
;5806:		}
;5807:
;5808:		if (Q_stricmp(token, "joingametypes") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4156
ARGP4
ADDRLP4 36
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 0
NEI4 $4154
line 5810
;5809:
;5810:			if (GameType_Parse(&p, qtrue)) {
ADDRLP4 4
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 GameType_Parse
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $4142
line 5811
;5811:				continue;
ADDRGP4 $4141
JUMPV
line 5812
;5812:			} else {
line 5813
;5813:				break;
LABELV $4154
line 5817
;5814:			}
;5815:		}
;5816:
;5817:		if (Q_stricmp(token, "maps") == 0) {
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $4161
ARGP4
ADDRLP4 40
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
NEI4 $4159
line 5819
;5818:			// start a new menu
;5819:			MapList_Parse(&p);
ADDRLP4 4
ARGP4
ADDRGP4 MapList_Parse
CALLI4
pop
line 5820
;5820:		}
LABELV $4159
line 5822
;5821:
;5822:	}
LABELV $4141
line 5789
ADDRGP4 $4140
JUMPV
LABELV $4142
line 5823
;5823:}
LABELV $4137
endproc UI_ParseGameInfo 44 8
proc UI_Pause 4 8
line 5825
;5824:
;5825:static void UI_Pause(qboolean b) {
line 5826
;5826:	if (b) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $4163
line 5828
;5827:		// pause the game and set the ui keycatcher
;5828:	  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5829
;5829:		trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5830
;5830:	} else {
ADDRGP4 $4164
JUMPV
LABELV $4163
line 5832
;5831:		// unpause the game and clear the ui keycatcher
;5832:		trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 0
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 5833
;5833:		trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 5834
;5834:		trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 5835
;5835:	}
LABELV $4164
line 5836
;5836:}
LABELV $4162
endproc UI_Pause 4 8
proc UI_PlayCinematic 4 24
line 5838
;5837:
;5838:static int UI_PlayCinematic(const char *name, float x, float y, float w, float h) {
line 5839
;5839:  return trap_CIN_PlayCinematic(name, x, y, w, h, (CIN_loop | CIN_silent));
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 0
ADDRGP4 trap_CIN_PlayCinematic
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4165
endproc UI_PlayCinematic 4 24
proc UI_StopCinematic 20 4
line 5842
;5840:}
;5841:
;5842:static void UI_StopCinematic(int handle) {
line 5843
;5843:	if (handle >= 0) {
ADDRFP4 0
INDIRI4
CNSTI4 0
LTI4 $4167
line 5844
;5844:	  trap_CIN_StopCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5845
;5845:	} else {
ADDRGP4 $4168
JUMPV
LABELV $4167
line 5846
;5846:		handle = abs(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 0
ADDRGP4 abs
CALLI4
ASGNI4
ADDRFP4 0
ADDRLP4 0
INDIRI4
ASGNI4
line 5847
;5847:		if (handle == UI_MAPCINEMATIC) {
ADDRFP4 0
INDIRI4
CNSTI4 244
NEI4 $4169
line 5848
;5848:			if (uiInfo.mapList[ui_currentMap.integer].cinematic >= 0) {
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4170
line 5849
;5849:			  trap_CIN_StopCinematic(uiInfo.mapList[ui_currentMap.integer].cinematic);
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5850
;5850:			  uiInfo.mapList[ui_currentMap.integer].cinematic = -1;
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+24
ADDP4
CNSTI4 -1
ASGNI4
line 5851
;5851:			}
line 5852
;5852:		} else if (handle == UI_NETMAPCINEMATIC) {
ADDRGP4 $4170
JUMPV
LABELV $4169
ADDRFP4 0
INDIRI4
CNSTI4 246
NEI4 $4182
line 5853
;5853:			if (uiInfo.serverStatus.currentServerCinematic >= 0) {
ADDRGP4 uiInfo+40604+10432
INDIRI4
CNSTI4 0
LTI4 $4183
line 5854
;5854:			  trap_CIN_StopCinematic(uiInfo.serverStatus.currentServerCinematic);
ADDRGP4 uiInfo+40604+10432
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5855
;5855:				uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+40604+10432
CNSTI4 -1
ASGNI4
line 5856
;5856:			}
line 5857
;5857:		} else if (handle == UI_CLANCINEMATIC) {
ADDRGP4 $4183
JUMPV
LABELV $4182
ADDRFP4 0
INDIRI4
CNSTI4 251
NEI4 $4192
line 5858
;5858:		  int i = UI_TeamIndexFromName(UI_Cvar_VariableString("ui_teamName"));
ADDRGP4 $680
ARGP4
ADDRLP4 8
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 8
INDIRP4
ARGP4
ADDRLP4 12
ADDRGP4 UI_TeamIndexFromName
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 5859
;5859:		  if (i >= 0 && i < uiInfo.teamCount) {
ADDRLP4 16
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
LTI4 $4194
ADDRLP4 16
INDIRI4
ADDRGP4 uiInfo+14148
INDIRI4
GEI4 $4194
line 5860
;5860:				if (uiInfo.teamList[i].cinematic >= 0) {
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
CNSTI4 0
LTI4 $4197
line 5861
;5861:				  trap_CIN_StopCinematic(uiInfo.teamList[i].cinematic);
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_CIN_StopCinematic
CALLI4
pop
line 5862
;5862:					uiInfo.teamList[i].cinematic = -1;
CNSTI4 56
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 uiInfo+14152+52
ADDP4
CNSTI4 -1
ASGNI4
line 5863
;5863:				}
LABELV $4197
line 5864
;5864:			}
LABELV $4194
line 5865
;5865:		}
LABELV $4192
LABELV $4183
LABELV $4170
line 5866
;5866:	}
LABELV $4168
line 5867
;5867:}
LABELV $4166
endproc UI_StopCinematic 20 4
proc UI_DrawCinematic 0 20
line 5869
;5868:
;5869:static void UI_DrawCinematic(int handle, float x, float y, float w, float h) {
line 5870
;5870:	trap_CIN_SetExtents(handle, x, y, w, h);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 12
INDIRF4
CVFI4 4
ARGI4
ADDRFP4 16
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 trap_CIN_SetExtents
CALLV
pop
line 5871
;5871:  trap_CIN_DrawCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_DrawCinematic
CALLV
pop
line 5872
;5872:}
LABELV $4205
endproc UI_DrawCinematic 0 20
proc UI_RunCinematicFrame 0 4
line 5874
;5873:
;5874:static void UI_RunCinematicFrame(int handle) {
line 5875
;5875:  trap_CIN_RunCinematic(handle);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_CIN_RunCinematic
CALLI4
pop
line 5876
;5876:}
LABELV $4206
endproc UI_RunCinematicFrame 0 4
export UI_LoadForceConfig_List
proc UI_LoadForceConfig_List 2208 16
line 5886
;5877:
;5878:
;5879:/*
;5880:=================
;5881:UI_LoadForceConfig_List
;5882:=================
;5883:Looks in the directory for force config files (.fcf) and loads the name in
;5884:*/
;5885:void UI_LoadForceConfig_List( void )
;5886:{
line 5887
;5887:	int			numfiles = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 5890
;5888:	char		filelist[2048];
;5889:	char		configname[128];
;5890:	char		*fileptr = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 5891
;5891:	int			j = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5892
;5892:	int			filelen = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 5893
;5893:	qboolean	lightSearch = qfalse;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 5895
;5894:
;5895:	uiInfo.forceConfigCount = 0;
ADDRGP4 uiInfo+78148
CNSTI4 0
ASGNI4
line 5896
;5896:	Com_sprintf( uiInfo.forceConfigNames[uiInfo.forceConfigCount], sizeof(uiInfo.forceConfigNames[uiInfo.forceConfigCount]), "Custom");
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 uiInfo+78156
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRGP4 $4213
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5897
;5897:	uiInfo.forceConfigCount++;
ADDRLP4 2196
ADDRGP4 uiInfo+78148
ASGNP4
ADDRLP4 2196
INDIRP4
ADDRLP4 2196
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $4215
line 5901
;5898:	//Always reserve index 0 as the "custom" config
;5899:
;5900:nextSearch:
;5901:	if (lightSearch)
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $4216
line 5902
;5902:	{ //search light side folder
line 5903
;5903:		numfiles = trap_FS_GetFileList("forcecfg/light", "fcf", filelist, 2048 );
ADDRGP4 $4218
ARGP4
ADDRGP4 $4219
ARGP4
ADDRLP4 148
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2200
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 2200
INDIRI4
ASGNI4
line 5904
;5904:		uiInfo.forceConfigLightIndexBegin = uiInfo.forceConfigCount-1;
ADDRGP4 uiInfo+95056
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5905
;5905:	}
ADDRGP4 $4217
JUMPV
LABELV $4216
line 5907
;5906:	else
;5907:	{ //search dark side folder
line 5908
;5908:		numfiles = trap_FS_GetFileList("forcecfg/dark", "fcf", filelist, 2048 );
ADDRGP4 $4222
ARGP4
ADDRGP4 $4219
ARGP4
ADDRLP4 148
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 2200
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 2200
INDIRI4
ASGNI4
line 5909
;5909:		uiInfo.forceConfigDarkIndexBegin = uiInfo.forceConfigCount-1;
ADDRGP4 uiInfo+95052
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 5910
;5910:	}
LABELV $4217
line 5912
;5911:
;5912:	fileptr = filelist;
ADDRLP4 0
ADDRLP4 148
ASGNP4
line 5914
;5913:
;5914:	for (j=0; j<numfiles && uiInfo.forceConfigCount < MAX_FORCE_CONFIGS;j++,fileptr+=filelen+1)
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $4228
JUMPV
LABELV $4225
line 5915
;5915:	{
line 5916
;5916:		filelen = strlen(fileptr);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 2200
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 2200
INDIRI4
ASGNI4
line 5917
;5917:		COM_StripExtension(fileptr, configname);
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 12
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 5919
;5918:
;5919:		if (lightSearch)
ADDRLP4 140
INDIRI4
CNSTI4 0
EQI4 $4230
line 5920
;5920:		{
line 5921
;5921:			uiInfo.forceConfigSide[uiInfo.forceConfigCount] = qtrue; //light side config
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+94540
ADDP4
CNSTI4 1
ASGNI4
line 5922
;5922:		}
ADDRGP4 $4231
JUMPV
LABELV $4230
line 5924
;5923:		else
;5924:		{
line 5925
;5925:			uiInfo.forceConfigSide[uiInfo.forceConfigCount] = qfalse; //dark side config
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+94540
ADDP4
CNSTI4 0
ASGNI4
line 5926
;5926:		}
LABELV $4231
line 5928
;5927:
;5928:		Com_sprintf( uiInfo.forceConfigNames[uiInfo.forceConfigCount], sizeof(uiInfo.forceConfigNames[uiInfo.forceConfigCount]), configname);
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 7
LSHI4
ADDRGP4 uiInfo+78156
ADDP4
ARGP4
CNSTI4 128
ARGI4
ADDRLP4 12
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 5929
;5929:		uiInfo.forceConfigCount++;
ADDRLP4 2204
ADDRGP4 uiInfo+78148
ASGNP4
ADDRLP4 2204
INDIRP4
ADDRLP4 2204
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5930
;5930:	}
LABELV $4226
line 5914
ADDRLP4 2200
CNSTI4 1
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRLP4 2200
INDIRI4
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ADDRLP4 2200
INDIRI4
ADDI4
ADDRLP4 0
INDIRP4
ADDP4
ASGNP4
LABELV $4228
ADDRLP4 4
INDIRI4
ADDRLP4 144
INDIRI4
GEI4 $4241
ADDRGP4 uiInfo+78148
INDIRI4
CNSTI4 128
LTI4 $4225
LABELV $4241
line 5932
;5931:
;5932:	if (!lightSearch)
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $4242
line 5933
;5933:	{
line 5934
;5934:		lightSearch = qtrue;
ADDRLP4 140
CNSTI4 1
ASGNI4
line 5935
;5935:		goto nextSearch;
ADDRGP4 $4215
JUMPV
LABELV $4242
line 5937
;5936:	}
;5937:}
LABELV $4207
endproc UI_LoadForceConfig_List 2208 16
proc UI_BuildQ3Model_List 6320 20
line 5946
;5938:
;5939:
;5940:/*
;5941:=================
;5942:PlayerModel_BuildList
;5943:=================
;5944:*/
;5945:static void UI_BuildQ3Model_List( void )
;5946:{
line 5959
;5947:	int		numdirs;
;5948:	int		numfiles;
;5949:	char	dirlist[2048];
;5950:	char	filelist[2048];
;5951:	char	skinname[64];
;5952:	char*	dirptr;
;5953:	char*	fileptr;
;5954:	int		i;
;5955:	int		j, k, p, s;
;5956:	int		dirlen;
;5957:	int		filelen;
;5958:
;5959:	uiInfo.q3HeadCount = 0;
ADDRGP4 uiInfo+60732
CNSTI4 0
ASGNI4
line 5962
;5960:
;5961:	// iterate directory of all player models
;5962:	numdirs = trap_FS_GetFileList("models/players", "/", dirlist, 2048 );
ADDRGP4 $4246
ARGP4
ADDRGP4 $4247
ARGP4
ADDRLP4 2156
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 4204
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 2152
ADDRLP4 4204
INDIRI4
ASGNI4
line 5963
;5963:	dirptr  = dirlist;
ADDRLP4 76
ADDRLP4 2156
ASGNP4
line 5964
;5964:	for (i=0; i<numdirs && uiInfo.q3HeadCount < MAX_PLAYERMODELS; i++,dirptr+=dirlen+1)
ADDRLP4 100
CNSTI4 0
ASGNI4
ADDRGP4 $4251
JUMPV
LABELV $4248
line 5965
;5965:	{
line 5966
;5966:		int f = 0;
ADDRLP4 4208
CNSTI4 0
ASGNI4
line 5969
;5967:		char fpath[2048];
;5968:
;5969:		dirlen = strlen(dirptr);
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 6260
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 6260
INDIRI4
ASGNI4
line 5971
;5970:		
;5971:		if (dirlen && dirptr[dirlen-1]=='/') dirptr[dirlen-1]='\0';
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $4253
ADDRLP4 96
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 47
NEI4 $4253
ADDRLP4 96
INDIRI4
CNSTI4 1
SUBI4
ADDRLP4 76
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
LABELV $4253
line 5973
;5972:
;5973:		if (!strcmp(dirptr,".") || !strcmp(dirptr,".."))
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $4257
ARGP4
ADDRLP4 6268
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 6268
INDIRI4
CNSTI4 0
EQI4 $4259
ADDRLP4 76
INDIRP4
ARGP4
ADDRGP4 $4258
ARGP4
ADDRLP4 6272
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 6272
INDIRI4
CNSTI4 0
NEI4 $4255
LABELV $4259
line 5974
;5974:			continue;
ADDRGP4 $4249
JUMPV
LABELV $4255
line 5977
;5975:			
;5976:
;5977:		numfiles = trap_FS_GetFileList( va("models/players/%s",dirptr), "skin", filelist, 2048 );
ADDRGP4 $3863
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 6276
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 6276
INDIRP4
ARGP4
ADDRGP4 $4260
ARGP4
ADDRLP4 104
ARGP4
CNSTI4 2048
ARGI4
ADDRLP4 6280
ADDRGP4 trap_FS_GetFileList
CALLI4
ASGNI4
ADDRLP4 92
ADDRLP4 6280
INDIRI4
ASGNI4
line 5978
;5978:		fileptr  = filelist;
ADDRLP4 80
ADDRLP4 104
ASGNP4
line 5979
;5979:		for (j=0; j<numfiles && uiInfo.q3HeadCount < MAX_PLAYERMODELS;j++,fileptr+=filelen+1)
ADDRLP4 84
CNSTI4 0
ASGNI4
ADDRGP4 $4264
JUMPV
LABELV $4261
line 5980
;5980:		{
line 5981
;5981:			int skinLen = 0;
ADDRLP4 6284
CNSTI4 0
ASGNI4
line 5983
;5982:
;5983:			filelen = strlen(fileptr);
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 6288
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 88
ADDRLP4 6288
INDIRI4
ASGNI4
line 5985
;5984:
;5985:			COM_StripExtension(fileptr,skinname);
ADDRLP4 80
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 COM_StripExtension
CALLV
pop
line 5987
;5986:
;5987:			skinLen = strlen(skinname);
ADDRLP4 4
ARGP4
ADDRLP4 6292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 6284
ADDRLP4 6292
INDIRI4
ASGNI4
line 5988
;5988:			k = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $4267
JUMPV
LABELV $4266
line 5990
;5989:			while (k < skinLen && skinname[k] && skinname[k] != '_')
;5990:			{
line 5991
;5991:				k++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5992
;5992:			}
LABELV $4267
line 5989
ADDRLP4 0
INDIRI4
ADDRLP4 6284
INDIRI4
GEI4 $4270
ADDRLP4 6300
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 6300
INDIRI4
CNSTI4 0
EQI4 $4270
ADDRLP4 6300
INDIRI4
CNSTI4 95
NEI4 $4266
LABELV $4270
line 5993
;5993:			if (skinname[k] == '_')
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $4271
line 5994
;5994:			{
line 5995
;5995:				p = 0;
ADDRLP4 72
CNSTI4 0
ASGNI4
ADDRGP4 $4274
JUMPV
LABELV $4273
line 5998
;5996:
;5997:				while (skinname[k])
;5998:				{
line 5999
;5999:					skinname[p] = skinname[k];
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
ASGNI1
line 6000
;6000:					k++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6001
;6001:					p++;
ADDRLP4 72
ADDRLP4 72
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6002
;6002:				}
LABELV $4274
line 5997
ADDRLP4 0
INDIRI4
ADDRLP4 4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4273
line 6003
;6003:				skinname[p] = '\0';
ADDRLP4 72
INDIRI4
ADDRLP4 4
ADDP4
CNSTI1 0
ASGNI1
line 6004
;6004:			}
LABELV $4271
line 6006
;6005:
;6006:			Com_sprintf(fpath, 2048, "models/players/%s/icon%s.jpg", dirptr, skinname);
ADDRLP4 4212
ARGP4
CNSTI4 2048
ARGI4
ADDRGP4 $4276
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 6008
;6007:
;6008:			trap_FS_FOpenFile(fpath, &f, FS_READ);
ADDRLP4 4212
ARGP4
ADDRLP4 4208
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_FS_FOpenFile
CALLI4
pop
line 6010
;6009:
;6010:			if (f)
ADDRLP4 4208
INDIRI4
CNSTI4 0
EQI4 $4277
line 6011
;6011:			{ //if it exists
line 6012
;6012:				qboolean iconExists = qfalse;
ADDRLP4 6304
CNSTI4 0
ASGNI4
line 6014
;6013:
;6014:				trap_FS_FCloseFile(f);
ADDRLP4 4208
INDIRI4
ARGI4
ADDRGP4 trap_FS_FCloseFile
CALLV
pop
line 6016
;6015:
;6016:				if (skinname[0] == '_')
ADDRLP4 4
INDIRI1
CVII4 1
CNSTI4 95
NEI4 $4279
line 6017
;6017:				{ //change character to append properly
line 6018
;6018:					skinname[0] = '/';
ADDRLP4 4
CNSTI1 47
ASGNI1
line 6019
;6019:				}
LABELV $4279
line 6021
;6020:
;6021:				s = 0;
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRGP4 $4282
JUMPV
LABELV $4281
line 6024
;6022:
;6023:				while (s < uiInfo.q3HeadCount)
;6024:				{ //check for dupes
line 6025
;6025:					if (!Q_stricmp(va("%s%s", dirptr, skinname), uiInfo.q3HeadNames[s]))
ADDRGP4 $4287
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 6308
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 6308
INDIRP4
ARGP4
ADDRLP4 68
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
ADDRLP4 6312
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 6312
INDIRI4
CNSTI4 0
NEI4 $4285
line 6026
;6026:					{
line 6027
;6027:						iconExists = qtrue;
ADDRLP4 6304
CNSTI4 1
ASGNI4
line 6028
;6028:						break;
ADDRGP4 $4283
JUMPV
LABELV $4285
line 6030
;6029:					}
;6030:					s++;
ADDRLP4 68
ADDRLP4 68
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6031
;6031:				}
LABELV $4282
line 6023
ADDRLP4 68
INDIRI4
ADDRGP4 uiInfo+60732
INDIRI4
LTI4 $4281
LABELV $4283
line 6033
;6032:
;6033:				if (iconExists)
ADDRLP4 6304
INDIRI4
CNSTI4 0
EQI4 $4289
line 6034
;6034:				{
line 6035
;6035:					continue;
ADDRGP4 $4262
JUMPV
LABELV $4289
line 6038
;6036:				}
;6037:
;6038:				Com_sprintf( uiInfo.q3HeadNames[uiInfo.q3HeadCount], sizeof(uiInfo.q3HeadNames[uiInfo.q3HeadCount]), va("%s%s", dirptr, skinname));
ADDRGP4 $4287
ARGP4
ADDRLP4 76
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRLP4 6308
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 uiInfo+60732
INDIRI4
CNSTI4 6
LSHI4
ADDRGP4 uiInfo+60736
ADDP4
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 6308
INDIRP4
ARGP4
ADDRGP4 Com_sprintf
CALLV
pop
line 6039
;6039:				uiInfo.q3HeadIcons[uiInfo.q3HeadCount++] = 0;//trap_R_RegisterShaderNoMip(fpath);
ADDRLP4 6316
ADDRGP4 uiInfo+60732
ASGNP4
ADDRLP4 6312
ADDRLP4 6316
INDIRP4
INDIRI4
ASGNI4
ADDRLP4 6316
INDIRP4
ADDRLP4 6312
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 6312
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 uiInfo+77120
ADDP4
CNSTI4 0
ASGNI4
line 6041
;6040:				//rww - we are now registering them as they are drawn like the TA feeder, so as to decrease UI load time.
;6041:			}
LABELV $4277
line 6043
;6042:
;6043:			if (uiInfo.q3HeadCount >= MAX_PLAYERMODELS)
ADDRGP4 uiInfo+60732
INDIRI4
CNSTI4 256
LTI4 $4297
line 6044
;6044:			{
line 6045
;6045:				return;
ADDRGP4 $4244
JUMPV
LABELV $4297
line 6047
;6046:			}
;6047:		}
LABELV $4262
line 5979
ADDRLP4 6284
CNSTI4 1
ASGNI4
ADDRLP4 84
ADDRLP4 84
INDIRI4
ADDRLP4 6284
INDIRI4
ADDI4
ASGNI4
ADDRLP4 80
ADDRLP4 88
INDIRI4
ADDRLP4 6284
INDIRI4
ADDI4
ADDRLP4 80
INDIRP4
ADDP4
ASGNP4
LABELV $4264
ADDRLP4 84
INDIRI4
ADDRLP4 92
INDIRI4
GEI4 $4300
ADDRGP4 uiInfo+60732
INDIRI4
CNSTI4 256
LTI4 $4261
LABELV $4300
line 6048
;6048:	}	
LABELV $4249
line 5964
ADDRLP4 4208
CNSTI4 1
ASGNI4
ADDRLP4 100
ADDRLP4 100
INDIRI4
ADDRLP4 4208
INDIRI4
ADDI4
ASGNI4
ADDRLP4 76
ADDRLP4 96
INDIRI4
ADDRLP4 4208
INDIRI4
ADDI4
ADDRLP4 76
INDIRP4
ADDP4
ASGNP4
LABELV $4251
ADDRLP4 100
INDIRI4
ADDRLP4 2152
INDIRI4
GEI4 $4301
ADDRGP4 uiInfo+60732
INDIRI4
CNSTI4 256
LTI4 $4248
LABELV $4301
line 6050
;6049:
;6050:}
LABELV $4244
endproc UI_BuildQ3Model_List 6320 20
export _UI_Init
proc _UI_Init 52 16
line 6059
;6051:
;6052:
;6053:
;6054:/*
;6055:=================
;6056:UI_Init
;6057:=================
;6058:*/
;6059:void _UI_Init( qboolean inGameLoad ) {
line 6064
;6060:	int i;
;6061:	const char *menuSet;
;6062:	int start;
;6063:
;6064:	uiInfo.inGameLoad = inGameLoad;
ADDRGP4 uiInfo+95064
ADDRFP4 0
INDIRI4
ASGNI4
line 6066
;6065:
;6066:	UI_UpdateForcePowers();
ADDRGP4 UI_UpdateForcePowers
CALLV
pop
line 6068
;6067:
;6068:	UI_RegisterCvars();
ADDRGP4 UI_RegisterCvars
CALLV
pop
line 6069
;6069:	UI_InitMemory();
ADDRGP4 UI_InitMemory
CALLV
pop
line 6072
;6070:
;6071:	// cache redundant calulations
;6072:	trap_GetGlconfig( &uiInfo.uiDC.glconfig );
ADDRGP4 uiInfo+460
ARGP4
ADDRGP4 trap_GetGlconfig
CALLV
pop
line 6075
;6073:
;6074:	// for 640x480 virtualized screen
;6075:	uiInfo.uiDC.yscale = uiInfo.uiDC.glconfig.vidHeight * (1.0/480.0);
ADDRGP4 uiInfo+220
CNSTF4 990414985
ADDRGP4 uiInfo+460+11308
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 6076
;6076:	uiInfo.uiDC.xscale = uiInfo.uiDC.glconfig.vidWidth * (1.0/640.0);
ADDRGP4 uiInfo+224
CNSTF4 986500301
ADDRGP4 uiInfo+460+11304
INDIRI4
CVIF4 4
MULF4
ASGNF4
line 6077
;6077:	if ( uiInfo.uiDC.glconfig.vidWidth * 480 > uiInfo.uiDC.glconfig.vidHeight * 640 ) {
CNSTI4 480
ADDRGP4 uiInfo+460+11304
INDIRI4
MULI4
CNSTI4 640
ADDRGP4 uiInfo+460+11308
INDIRI4
MULI4
LEI4 $4311
line 6079
;6078:		// wide screen
;6079:		uiInfo.uiDC.bias = 0.5 * ( uiInfo.uiDC.glconfig.vidWidth - ( uiInfo.uiDC.glconfig.vidHeight * (640.0/480.0) ) );
ADDRGP4 uiInfo+228
CNSTF4 1056964608
ADDRGP4 uiInfo+460+11304
INDIRI4
CVIF4 4
CNSTF4 1068149419
ADDRGP4 uiInfo+460+11308
INDIRI4
CVIF4 4
MULF4
SUBF4
MULF4
ASGNF4
line 6080
;6080:	}
ADDRGP4 $4312
JUMPV
LABELV $4311
line 6081
;6081:	else {
line 6083
;6082:		// no wide screen
;6083:		uiInfo.uiDC.bias = 0;
ADDRGP4 uiInfo+228
CNSTF4 0
ASGNF4
line 6084
;6084:	}
LABELV $4312
line 6088
;6085:
;6086:
;6087:  //UI_Load();
;6088:	uiInfo.uiDC.registerShaderNoMip = &trap_R_RegisterShaderNoMip;
ADDRGP4 uiInfo
ADDRGP4 trap_R_RegisterShaderNoMip
ASGNP4
line 6089
;6089:	uiInfo.uiDC.setColor = &UI_SetColor;
ADDRGP4 uiInfo+4
ADDRGP4 UI_SetColor
ASGNP4
line 6090
;6090:	uiInfo.uiDC.drawHandlePic = &UI_DrawHandlePic;
ADDRGP4 uiInfo+8
ADDRGP4 UI_DrawHandlePic
ASGNP4
line 6091
;6091:	uiInfo.uiDC.drawStretchPic = &trap_R_DrawStretchPic;
ADDRGP4 uiInfo+12
ADDRGP4 trap_R_DrawStretchPic
ASGNP4
line 6092
;6092:	uiInfo.uiDC.drawText = &Text_Paint;
ADDRGP4 uiInfo+16
ADDRGP4 Text_Paint
ASGNP4
line 6093
;6093:	uiInfo.uiDC.textWidth = &Text_Width;
ADDRGP4 uiInfo+20
ADDRGP4 Text_Width
ASGNP4
line 6094
;6094:	uiInfo.uiDC.textHeight = &Text_Height;
ADDRGP4 uiInfo+24
ADDRGP4 Text_Height
ASGNP4
line 6095
;6095:	uiInfo.uiDC.registerModel = &trap_R_RegisterModel;
ADDRGP4 uiInfo+28
ADDRGP4 trap_R_RegisterModel
ASGNP4
line 6096
;6096:	uiInfo.uiDC.modelBounds = &trap_R_ModelBounds;
ADDRGP4 uiInfo+32
ADDRGP4 trap_R_ModelBounds
ASGNP4
line 6097
;6097:	uiInfo.uiDC.fillRect = &UI_FillRect;
ADDRGP4 uiInfo+36
ADDRGP4 UI_FillRect
ASGNP4
line 6098
;6098:	uiInfo.uiDC.drawRect = &_UI_DrawRect;
ADDRGP4 uiInfo+40
ADDRGP4 _UI_DrawRect
ASGNP4
line 6099
;6099:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 6100
;6100:	uiInfo.uiDC.drawTopBottom = &_UI_DrawTopBottom;
ADDRGP4 uiInfo+48
ADDRGP4 _UI_DrawTopBottom
ASGNP4
line 6101
;6101:	uiInfo.uiDC.clearScene = &trap_R_ClearScene;
ADDRGP4 uiInfo+52
ADDRGP4 trap_R_ClearScene
ASGNP4
line 6102
;6102:	uiInfo.uiDC.drawSides = &_UI_DrawSides;
ADDRGP4 uiInfo+44
ADDRGP4 _UI_DrawSides
ASGNP4
line 6103
;6103:	uiInfo.uiDC.addRefEntityToScene = &trap_R_AddRefEntityToScene;
ADDRGP4 uiInfo+56
ADDRGP4 trap_R_AddRefEntityToScene
ASGNP4
line 6104
;6104:	uiInfo.uiDC.renderScene = &trap_R_RenderScene;
ADDRGP4 uiInfo+60
ADDRGP4 trap_R_RenderScene
ASGNP4
line 6105
;6105:	uiInfo.uiDC.RegisterFont = &trap_R_RegisterFont;
ADDRGP4 uiInfo+64
ADDRGP4 trap_R_RegisterFont
ASGNP4
line 6106
;6106:	uiInfo.uiDC.Font_StrLenPixels = trap_R_Font_StrLenPixels;
ADDRGP4 uiInfo+68
ADDRGP4 trap_R_Font_StrLenPixels
ASGNP4
line 6107
;6107:	uiInfo.uiDC.Font_StrLenChars = trap_R_Font_StrLenChars;
ADDRGP4 uiInfo+72
ADDRGP4 trap_R_Font_StrLenChars
ASGNP4
line 6108
;6108:	uiInfo.uiDC.Font_HeightPixels = trap_R_Font_HeightPixels;
ADDRGP4 uiInfo+76
ADDRGP4 trap_R_Font_HeightPixels
ASGNP4
line 6109
;6109:	uiInfo.uiDC.Font_DrawString = trap_R_Font_DrawString;
ADDRGP4 uiInfo+80
ADDRGP4 trap_R_Font_DrawString
ASGNP4
line 6110
;6110:	uiInfo.uiDC.AnyLanguage_ReadCharFromString = trap_AnyLanguage_ReadCharFromString;
ADDRGP4 uiInfo+84
ADDRGP4 trap_AnyLanguage_ReadCharFromString
ASGNP4
line 6111
;6111:	uiInfo.uiDC.ownerDrawItem = &UI_OwnerDraw;
ADDRGP4 uiInfo+88
ADDRGP4 UI_OwnerDraw
ASGNP4
line 6112
;6112:	uiInfo.uiDC.getValue = &UI_GetValue;
ADDRGP4 uiInfo+92
ADDRGP4 UI_GetValue
ASGNP4
line 6113
;6113:	uiInfo.uiDC.ownerDrawVisible = &UI_OwnerDrawVisible;
ADDRGP4 uiInfo+96
ADDRGP4 UI_OwnerDrawVisible
ASGNP4
line 6114
;6114:	uiInfo.uiDC.runScript = &UI_RunMenuScript;
ADDRGP4 uiInfo+100
ADDRGP4 UI_RunMenuScript
ASGNP4
line 6115
;6115:	uiInfo.uiDC.deferScript = &UI_DeferMenuScript;
ADDRGP4 uiInfo+104
ADDRGP4 UI_DeferMenuScript
ASGNP4
line 6116
;6116:	uiInfo.uiDC.getTeamColor = &UI_GetTeamColor;
ADDRGP4 uiInfo+108
ADDRGP4 UI_GetTeamColor
ASGNP4
line 6117
;6117:	uiInfo.uiDC.setCVar = trap_Cvar_Set;
ADDRGP4 uiInfo+120
ADDRGP4 trap_Cvar_Set
ASGNP4
line 6118
;6118:	uiInfo.uiDC.getCVarString = trap_Cvar_VariableStringBuffer;
ADDRGP4 uiInfo+112
ADDRGP4 trap_Cvar_VariableStringBuffer
ASGNP4
line 6119
;6119:	uiInfo.uiDC.getCVarValue = trap_Cvar_VariableValue;
ADDRGP4 uiInfo+116
ADDRGP4 trap_Cvar_VariableValue
ASGNP4
line 6120
;6120:	uiInfo.uiDC.drawTextWithCursor = &Text_PaintWithCursor;
ADDRGP4 uiInfo+124
ADDRGP4 Text_PaintWithCursor
ASGNP4
line 6121
;6121:	uiInfo.uiDC.setOverstrikeMode = &trap_Key_SetOverstrikeMode;
ADDRGP4 uiInfo+128
ADDRGP4 trap_Key_SetOverstrikeMode
ASGNP4
line 6122
;6122:	uiInfo.uiDC.getOverstrikeMode = &trap_Key_GetOverstrikeMode;
ADDRGP4 uiInfo+132
ADDRGP4 trap_Key_GetOverstrikeMode
ASGNP4
line 6123
;6123:	uiInfo.uiDC.startLocalSound = &trap_S_StartLocalSound;
ADDRGP4 uiInfo+136
ADDRGP4 trap_S_StartLocalSound
ASGNP4
line 6124
;6124:	uiInfo.uiDC.ownerDrawHandleKey = &UI_OwnerDrawHandleKey;
ADDRGP4 uiInfo+140
ADDRGP4 UI_OwnerDrawHandleKey
ASGNP4
line 6125
;6125:	uiInfo.uiDC.feederCount = &UI_FeederCount;
ADDRGP4 uiInfo+144
ADDRGP4 UI_FeederCount
ASGNP4
line 6126
;6126:	uiInfo.uiDC.feederItemImage = &UI_FeederItemImage;
ADDRGP4 uiInfo+152
ADDRGP4 UI_FeederItemImage
ASGNP4
line 6127
;6127:	uiInfo.uiDC.feederItemText = &UI_FeederItemText;
ADDRGP4 uiInfo+148
ADDRGP4 UI_FeederItemText
ASGNP4
line 6128
;6128:	uiInfo.uiDC.feederSelection = &UI_FeederSelection;
ADDRGP4 uiInfo+156
ADDRGP4 UI_FeederSelection
ASGNP4
line 6129
;6129:	uiInfo.uiDC.setBinding = &trap_Key_SetBinding;
ADDRGP4 uiInfo+168
ADDRGP4 trap_Key_SetBinding
ASGNP4
line 6130
;6130:	uiInfo.uiDC.getBindingBuf = &trap_Key_GetBindingBuf;
ADDRGP4 uiInfo+164
ADDRGP4 trap_Key_GetBindingBuf
ASGNP4
line 6131
;6131:	uiInfo.uiDC.keynumToStringBuf = &trap_Key_KeynumToStringBuf;
ADDRGP4 uiInfo+160
ADDRGP4 trap_Key_KeynumToStringBuf
ASGNP4
line 6132
;6132:	uiInfo.uiDC.executeText = &trap_Cmd_ExecuteText;
ADDRGP4 uiInfo+172
ADDRGP4 trap_Cmd_ExecuteText
ASGNP4
line 6133
;6133:	uiInfo.uiDC.Error = &Com_Error; 
ADDRGP4 uiInfo+176
ADDRGP4 Com_Error
ASGNP4
line 6134
;6134:	uiInfo.uiDC.Print = &Com_Printf; 
ADDRGP4 uiInfo+180
ADDRGP4 Com_Printf
ASGNP4
line 6135
;6135:	uiInfo.uiDC.Pause = &UI_Pause;
ADDRGP4 uiInfo+184
ADDRGP4 UI_Pause
ASGNP4
line 6136
;6136:	uiInfo.uiDC.ownerDrawWidth = &UI_OwnerDrawWidth;
ADDRGP4 uiInfo+188
ADDRGP4 UI_OwnerDrawWidth
ASGNP4
line 6137
;6137:	uiInfo.uiDC.registerSound = &trap_S_RegisterSound;
ADDRGP4 uiInfo+192
ADDRGP4 trap_S_RegisterSound
ASGNP4
line 6138
;6138:	uiInfo.uiDC.startBackgroundTrack = &trap_S_StartBackgroundTrack;
ADDRGP4 uiInfo+196
ADDRGP4 trap_S_StartBackgroundTrack
ASGNP4
line 6139
;6139:	uiInfo.uiDC.stopBackgroundTrack = &trap_S_StopBackgroundTrack;
ADDRGP4 uiInfo+200
ADDRGP4 trap_S_StopBackgroundTrack
ASGNP4
line 6140
;6140:	uiInfo.uiDC.playCinematic = &UI_PlayCinematic;
ADDRGP4 uiInfo+204
ADDRGP4 UI_PlayCinematic
ASGNP4
line 6141
;6141:	uiInfo.uiDC.stopCinematic = &UI_StopCinematic;
ADDRGP4 uiInfo+208
ADDRGP4 UI_StopCinematic
ASGNP4
line 6142
;6142:	uiInfo.uiDC.drawCinematic = &UI_DrawCinematic;
ADDRGP4 uiInfo+212
ADDRGP4 UI_DrawCinematic
ASGNP4
line 6143
;6143:	uiInfo.uiDC.runCinematicFrame = &UI_RunCinematicFrame;
ADDRGP4 uiInfo+216
ADDRGP4 UI_RunCinematicFrame
ASGNP4
line 6145
;6144:
;6145:	for (i=0; i<10; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $4378
line 6146
;6146:	{
line 6147
;6147:		if (!trap_SP_Register(va("menus%d",i)))	//, /*SP_REGISTER_REQUIRED|*/SP_REGISTER_MENU))
ADDRGP4 $4384
ARGP4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 trap_SP_Register
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $4382
line 6148
;6148:			break;
ADDRGP4 $4380
JUMPV
LABELV $4382
line 6149
;6149:	}
LABELV $4379
line 6145
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 10
LTI4 $4378
LABELV $4380
line 6152
;6150:
;6151:
;6152:	Init_Display(&uiInfo.uiDC);
ADDRGP4 uiInfo
ARGP4
ADDRGP4 Init_Display
CALLV
pop
line 6154
;6153:
;6154:	String_Init();
ADDRGP4 String_Init
CALLV
pop
line 6156
;6155:  
;6156:	uiInfo.uiDC.cursor	= trap_R_RegisterShaderNoMip( "menu/art/3_cursor2" );
ADDRGP4 $4386
ARGP4
ADDRLP4 12
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+11800
ADDRLP4 12
INDIRI4
ASGNI4
line 6157
;6157:	uiInfo.uiDC.whiteShader = trap_R_RegisterShaderNoMip( "white" );
ADDRGP4 $4388
ARGP4
ADDRLP4 16
ADDRGP4 trap_R_RegisterShaderNoMip
CALLI4
ASGNI4
ADDRGP4 uiInfo+11792
ADDRLP4 16
INDIRI4
ASGNI4
line 6159
;6158:
;6159:	AssetCache();
ADDRGP4 AssetCache
CALLV
pop
line 6161
;6160:
;6161:	start = trap_Milliseconds();
ADDRLP4 20
ADDRGP4 trap_Milliseconds
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 6163
;6162:
;6163:  uiInfo.teamCount = 0;
ADDRGP4 uiInfo+14148
CNSTI4 0
ASGNI4
line 6164
;6164:  uiInfo.characterCount = 0;
ADDRGP4 uiInfo+11832
CNSTI4 0
ASGNI4
line 6165
;6165:  uiInfo.aliasCount = 0;
ADDRGP4 uiInfo+13376
CNSTI4 0
ASGNI4
line 6173
;6166:
;6167:#ifdef PRE_RELEASE_TADEMO
;6168://	UI_ParseTeamInfo("demoteaminfo.txt");
;6169:	UI_ParseGameInfo("demogameinfo.txt");
;6170:#else
;6171://	UI_ParseTeamInfo("ui/jk2mp/teaminfo.txt");
;6172://	UI_LoadTeams();
;6173:	UI_ParseGameInfo("ui/jk2mp/gameinfo.txt");
ADDRGP4 $656
ARGP4
ADDRGP4 UI_ParseGameInfo
CALLV
pop
line 6177
;6174:#endif
;6175:
;6176:
;6177:	menuSet = UI_Cvar_VariableString("ui_menuFilesMP");
ADDRGP4 $652
ARGP4
ADDRLP4 24
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 24
INDIRP4
ASGNP4
line 6178
;6178:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4394
ADDRLP4 4
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4392
LABELV $4394
line 6179
;6179:		menuSet = "ui/jk2mpmenus.txt";
ADDRLP4 4
ADDRGP4 $619
ASGNP4
line 6180
;6180:	}
LABELV $4392
line 6183
;6181:
;6182:#if 1
;6183:	if (inGameLoad)
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $4395
line 6184
;6184:	{
line 6185
;6185:		UI_LoadMenus("ui/jk2mpingame.txt", qtrue);
ADDRGP4 $651
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 6186
;6186:	}
ADDRGP4 $4396
JUMPV
LABELV $4395
line 6188
;6187:	else
;6188:	{
line 6189
;6189:		UI_LoadMenus(menuSet, qtrue);
ADDRLP4 4
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 6190
;6190:	}
LABELV $4396
line 6196
;6191:#else //this was adding quite a giant amount of time to the load time
;6192:	UI_LoadMenus(menuSet, qtrue);
;6193:	UI_LoadMenus("ui/jk2mpingame.txt", qtrue);
;6194:#endif
;6195:	
;6196:	Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6198
;6197:
;6198:	trap_LAN_LoadCachedServers();
ADDRGP4 trap_LAN_LoadCachedServers
CALLV
pop
line 6199
;6199:	UI_LoadBestScores(uiInfo.mapList[ui_currentMap.integer].mapLoadName, uiInfo.gameTypes[ui_gameType.integer].gtEnum);
CNSTI4 100
ADDRGP4 ui_currentMap+12
INDIRI4
MULI4
ADDRGP4 uiInfo+20212+4
ADDP4
INDIRP4
ARGP4
ADDRGP4 ui_gameType+12
INDIRI4
CNSTI4 3
LSHI4
ADDRGP4 uiInfo+17740+4
ADDP4
INDIRI4
ARGI4
ADDRGP4 UI_LoadBestScores
CALLV
pop
line 6201
;6200:
;6201:	UI_BuildQ3Model_List();
ADDRGP4 UI_BuildQ3Model_List
CALLV
pop
line 6202
;6202:	UI_LoadBots();
ADDRGP4 UI_LoadBots
CALLV
pop
line 6204
;6203:
;6204:	UI_LoadForceConfig_List();
ADDRGP4 UI_LoadForceConfig_List
CALLV
pop
line 6206
;6205:
;6206:	UI_InitForceShaders();
ADDRGP4 UI_InitForceShaders
CALLV
pop
line 6209
;6207:
;6208:	// sets defaults for ui temp cvars
;6209:	uiInfo.effectsColor = /*gamecodetoui[*/(int)trap_Cvar_VariableValue("color1");//-1];
ADDRGP4 $1840
ARGP4
ADDRLP4 32
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+95060
ADDRLP4 32
INDIRF4
CVFI4 4
ASGNI4
line 6210
;6210:	uiInfo.currentCrosshair = (int)trap_Cvar_VariableValue("cg_drawCrosshair");
ADDRGP4 $2127
ARGP4
ADDRLP4 36
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 uiInfo+60720
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 6211
;6211:	trap_Cvar_Set("ui_mousePitch", (trap_Cvar_VariableValue("m_pitch") >= 0) ? "0" : "1");
ADDRGP4 $2460
ARGP4
ADDRLP4 44
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 0
LTF4 $4406
ADDRLP4 40
ADDRGP4 $333
ASGNP4
ADDRGP4 $4407
JUMPV
LABELV $4406
ADDRLP4 40
ADDRGP4 $336
ASGNP4
LABELV $4407
ADDRGP4 $2457
ARGP4
ADDRLP4 40
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6213
;6212:
;6213:	uiInfo.serverStatus.currentServerCinematic = -1;
ADDRGP4 uiInfo+40604+10432
CNSTI4 -1
ASGNI4
line 6214
;6214:	uiInfo.previewMovie = -1;
ADDRGP4 uiInfo+36244
CNSTI4 -1
ASGNI4
line 6216
;6215:
;6216:	trap_Cvar_Register(NULL, "debug_protocol", "", 0 );
CNSTP4 0
ARGP4
ADDRGP4 $4411
ARGP4
ADDRGP4 $170
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 6218
;6217:
;6218:	trap_Cvar_Set("ui_actualNetGameType", va("%d", ui_netGameType.integer));
ADDRGP4 $685
ARGP4
ADDRGP4 ui_netGameType+12
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $700
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6219
;6219:}
LABELV $4302
endproc _UI_Init 52 16
export _UI_KeyEvent
proc _UI_KeyEvent 16 12
line 6227
;6220:
;6221:
;6222:/*
;6223:=================
;6224:UI_KeyEvent
;6225:=================
;6226:*/
;6227:void _UI_KeyEvent( int key, qboolean down ) {
line 6229
;6228:
;6229:  if (Menu_Count() > 0) {
ADDRLP4 0
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4414
line 6230
;6230:    menuDef_t *menu = Menu_GetFocused();
ADDRLP4 8
ADDRGP4 Menu_GetFocused
CALLP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
ASGNP4
line 6231
;6231:		if (menu) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4416
line 6232
;6232:			if (key == K_ESCAPE && down && !Menus_AnyFullScreenVisible()) {
ADDRFP4 0
INDIRI4
CNSTI4 27
NEI4 $4418
ADDRFP4 4
INDIRI4
CNSTI4 0
EQI4 $4418
ADDRLP4 12
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $4418
line 6233
;6233:				Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6234
;6234:			} else {
ADDRGP4 $4417
JUMPV
LABELV $4418
line 6235
;6235:				Menu_HandleKey(menu, key, down );
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 Menu_HandleKey
CALLV
pop
line 6236
;6236:			}
line 6237
;6237:		} else {
ADDRGP4 $4417
JUMPV
LABELV $4416
line 6238
;6238:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 12
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6239
;6239:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 6240
;6240:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6241
;6241:		}
LABELV $4417
line 6242
;6242:  }
LABELV $4414
line 6247
;6243:
;6244:  //if ((s > 0) && (s != menu_null_sound)) {
;6245:	//  trap_S_StartLocalSound( s, CHAN_LOCAL_SOUND );
;6246:  //}
;6247:}
LABELV $4413
endproc _UI_KeyEvent 16 12
export _UI_MouseEvent
proc _UI_MouseEvent 12 12
line 6255
;6248:
;6249:/*
;6250:=================
;6251:UI_MouseEvent
;6252:=================
;6253:*/
;6254:void _UI_MouseEvent( int dx, int dy )
;6255:{
line 6257
;6256:	// update mouse screen position
;6257:	uiInfo.uiDC.cursorx += dx;
ADDRLP4 0
ADDRGP4 uiInfo+240
ASGNP4
ADDRLP4 0
INDIRP4
ADDRLP4 0
INDIRP4
INDIRI4
ADDRFP4 0
INDIRI4
ADDI4
ASGNI4
line 6258
;6258:	if (uiInfo.uiDC.cursorx < 0)
ADDRGP4 uiInfo+240
INDIRI4
CNSTI4 0
GEI4 $4422
line 6259
;6259:		uiInfo.uiDC.cursorx = 0;
ADDRGP4 uiInfo+240
CNSTI4 0
ASGNI4
ADDRGP4 $4423
JUMPV
LABELV $4422
line 6260
;6260:	else if (uiInfo.uiDC.cursorx > SCREEN_WIDTH)
ADDRGP4 uiInfo+240
INDIRI4
CNSTI4 640
LEI4 $4426
line 6261
;6261:		uiInfo.uiDC.cursorx = SCREEN_WIDTH;
ADDRGP4 uiInfo+240
CNSTI4 640
ASGNI4
LABELV $4426
LABELV $4423
line 6263
;6262:
;6263:	uiInfo.uiDC.cursory += dy;
ADDRLP4 4
ADDRGP4 uiInfo+244
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRFP4 4
INDIRI4
ADDI4
ASGNI4
line 6264
;6264:	if (uiInfo.uiDC.cursory < 0)
ADDRGP4 uiInfo+244
INDIRI4
CNSTI4 0
GEI4 $4431
line 6265
;6265:		uiInfo.uiDC.cursory = 0;
ADDRGP4 uiInfo+244
CNSTI4 0
ASGNI4
ADDRGP4 $4432
JUMPV
LABELV $4431
line 6266
;6266:	else if (uiInfo.uiDC.cursory > SCREEN_HEIGHT)
ADDRGP4 uiInfo+244
INDIRI4
CNSTI4 480
LEI4 $4435
line 6267
;6267:		uiInfo.uiDC.cursory = SCREEN_HEIGHT;
ADDRGP4 uiInfo+244
CNSTI4 480
ASGNI4
LABELV $4435
LABELV $4432
line 6269
;6268:
;6269:  if (Menu_Count() > 0) {
ADDRLP4 8
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
LEI4 $4439
line 6272
;6270:    //menuDef_t *menu = Menu_GetFocused();
;6271:    //Menu_HandleMouseMove(menu, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
;6272:		Display_MouseMove(NULL, uiInfo.uiDC.cursorx, uiInfo.uiDC.cursory);
CNSTP4 0
ARGP4
ADDRGP4 uiInfo+240
INDIRI4
ARGI4
ADDRGP4 uiInfo+244
INDIRI4
ARGI4
ADDRGP4 Display_MouseMove
CALLI4
pop
line 6273
;6273:  }
LABELV $4439
line 6275
;6274:
;6275:}
LABELV $4420
endproc _UI_MouseEvent 12 12
export UI_LoadNonIngame
proc UI_LoadNonIngame 12 8
line 6277
;6276:
;6277:void UI_LoadNonIngame() {
line 6278
;6278:	const char *menuSet = UI_Cvar_VariableString("ui_menuFilesMP");
ADDRGP4 $652
ARGP4
ADDRLP4 4
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
ASGNP4
line 6279
;6279:	if (menuSet == NULL || menuSet[0] == '\0') {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4446
ADDRLP4 0
INDIRP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $4444
LABELV $4446
line 6280
;6280:		menuSet = "ui/jk2mpmenus.txt";
ADDRLP4 0
ADDRGP4 $619
ASGNP4
line 6281
;6281:	}
LABELV $4444
line 6282
;6282:	UI_LoadMenus(menuSet, qfalse);
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 UI_LoadMenus
CALLV
pop
line 6283
;6283:	uiInfo.inGameLoad = qfalse;
ADDRGP4 uiInfo+95064
CNSTI4 0
ASGNI4
line 6284
;6284:}
LABELV $4443
endproc UI_LoadNonIngame 12 8
export _UI_SetActiveMenu
proc _UI_SetActiveMenu 304 12
line 6286
;6285:
;6286:void _UI_SetActiveMenu( uiMenuCommand_t menu ) {
line 6291
;6287:	char buf[256];
;6288:
;6289:	// this should be the ONLY way the menu system is brought up
;6290:	// enusure minumum menu data is cached
;6291:  if (Menu_Count() > 0) {
ADDRLP4 256
ADDRGP4 Menu_Count
CALLI4
ASGNI4
ADDRLP4 256
INDIRI4
CNSTI4 0
LEI4 $4449
line 6293
;6292:		vec3_t v;
;6293:		v[0] = v[1] = v[2] = 0;
ADDRLP4 272
CNSTF4 0
ASGNF4
ADDRLP4 260+8
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260+4
ADDRLP4 272
INDIRF4
ASGNF4
ADDRLP4 260
ADDRLP4 272
INDIRF4
ASGNF4
line 6294
;6294:	  switch ( menu ) {
ADDRLP4 276
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
LTI4 $4453
ADDRLP4 276
INDIRI4
CNSTI4 6
GTI4 $4453
ADDRLP4 276
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4485
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $4485
address $4456
address $4457
address $4481
address $4483
address $4474
address $4476
address $4484
code
LABELV $4456
line 6296
;6295:	  case UIMENU_NONE:
;6296:			trap_Key_SetCatcher( trap_Key_GetCatcher() & ~KEYCATCH_UI );
ADDRLP4 284
ADDRGP4 trap_Key_GetCatcher
CALLI4
ASGNI4
ADDRLP4 284
INDIRI4
CNSTI4 -3
BANDI4
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6297
;6297:			trap_Key_ClearStates();
ADDRGP4 trap_Key_ClearStates
CALLV
pop
line 6298
;6298:			trap_Cvar_Set( "cl_paused", "0" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6299
;6299:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6301
;6300:
;6301:		  return;
ADDRGP4 $4448
JUMPV
LABELV $4457
line 6303
;6302:	  case UIMENU_MAIN:
;6303:		{
line 6304
;6304:			qboolean active = qfalse;
ADDRLP4 288
CNSTI4 0
ASGNI4
line 6307
;6305:
;6306:			//trap_Cvar_Set( "sv_killserver", "1" );
;6307:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6310
;6308:			//trap_S_StartLocalSound( trap_S_RegisterSound("sound/misc/menu_background.wav", qfalse) , CHAN_LOCAL_SOUND );
;6309:			//trap_S_StartBackgroundTrack("sound/misc/menu_background.wav", NULL);
;6310:			if (uiInfo.inGameLoad) 
ADDRGP4 uiInfo+95064
INDIRI4
CNSTI4 0
EQI4 $4458
line 6311
;6311:			{
line 6313
;6312://				UI_LoadNonIngame();
;6313:			}
LABELV $4458
line 6315
;6314:			
;6315:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6316
;6316:			Menus_ActivateByName("main");
ADDRGP4 $2657
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6317
;6317:			trap_Cvar_VariableStringBuffer("com_errorMessage", buf, sizeof(buf));
ADDRGP4 $2579
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 6319
;6318:			
;6319:			if (strlen(buf)) 
ADDRLP4 0
ARGP4
ADDRLP4 292
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $4461
line 6320
;6320:			{
line 6321
;6321:				if (!ui_singlePlayerActive.integer) 
ADDRGP4 ui_singlePlayerActive+12
INDIRI4
CNSTI4 0
NEI4 $4463
line 6322
;6322:				{
line 6323
;6323:					Menus_ActivateByName("error_popmenu");
ADDRGP4 $4466
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6324
;6324:					active = qtrue;
ADDRLP4 288
CNSTI4 1
ASGNI4
line 6325
;6325:				} 
ADDRGP4 $4464
JUMPV
LABELV $4463
line 6327
;6326:				else 
;6327:				{
line 6328
;6328:					trap_Cvar_Set("com_errorMessage", "");
ADDRGP4 $2579
ARGP4
ADDRGP4 $170
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6329
;6329:				}
LABELV $4464
line 6330
;6330:			}
LABELV $4461
line 6332
;6331:
;6332:			if ( !active && (int)trap_Cvar_VariableValue ( "com_othertasks" ) )
ADDRLP4 288
INDIRI4
CNSTI4 0
NEI4 $4448
ADDRGP4 $4469
ARGP4
ADDRLP4 296
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 296
INDIRF4
CVFI4 4
CNSTI4 0
EQI4 $4448
line 6333
;6333:			{
line 6334
;6334:				trap_Cvar_Set("com_othertasks", "0");
ADDRGP4 $4469
ARGP4
ADDRGP4 $333
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6335
;6335:				if ( !(int)trap_Cvar_VariableValue ( "com_ignoreothertasks" ) )
ADDRGP4 $4472
ARGP4
ADDRLP4 300
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 300
INDIRF4
CVFI4 4
CNSTI4 0
NEI4 $4448
line 6336
;6336:				{
line 6337
;6337:					Menus_ActivateByName("backgroundtask_popmenu");
ADDRGP4 $4473
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6338
;6338:					active = qtrue;
ADDRLP4 288
CNSTI4 1
ASGNI4
line 6339
;6339:				}
line 6340
;6340:			}
line 6342
;6341:
;6342:			return;
ADDRGP4 $4448
JUMPV
LABELV $4474
line 6346
;6343:		}
;6344:
;6345:	  case UIMENU_TEAM:
;6346:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6347
;6347:      Menus_ActivateByName("team");
ADDRGP4 $4475
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6348
;6348:		  return;
ADDRGP4 $4448
JUMPV
LABELV $4476
line 6351
;6349:	  case UIMENU_POSTGAME:
;6350:			//trap_Cvar_Set( "sv_killserver", "1" );
;6351:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6352
;6352:			if (uiInfo.inGameLoad) {
ADDRGP4 uiInfo+95064
INDIRI4
CNSTI4 0
EQI4 $4477
line 6354
;6353://				UI_LoadNonIngame();
;6354:			}
LABELV $4477
line 6355
;6355:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6356
;6356:			Menus_ActivateByName("endofgame");
ADDRGP4 $4480
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6358
;6357:		  //UI_ConfirmMenu( "Bad CD Key", NULL, NeedCDKeyAction );
;6358:		  return;
ADDRGP4 $4448
JUMPV
LABELV $4481
line 6360
;6359:	  case UIMENU_INGAME:
;6360:		  trap_Cvar_Set( "cl_paused", "1" );
ADDRGP4 $2727
ARGP4
ADDRGP4 $336
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6361
;6361:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6362
;6362:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 6363
;6363:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6364
;6364:			Menus_ActivateByName("ingame");
ADDRGP4 $4482
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6365
;6365:		  return;
ADDRGP4 $4448
JUMPV
LABELV $4483
line 6368
;6366:	  case UIMENU_PLAYERCONFIG:
;6367:		 // trap_Cvar_Set( "cl_paused", "1" );
;6368:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6369
;6369:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 6370
;6370:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6371
;6371:			Menus_ActivateByName("ingame_player");
ADDRGP4 $992
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6372
;6372:			UpdateForceUsed();
ADDRGP4 UpdateForceUsed
CALLV
pop
line 6373
;6373:		  return;
ADDRGP4 $4448
JUMPV
LABELV $4484
line 6376
;6374:	  case UIMENU_PLAYERFORCE:
;6375:		 // trap_Cvar_Set( "cl_paused", "1" );
;6376:			trap_Key_SetCatcher( KEYCATCH_UI );
CNSTI4 2
ARGI4
ADDRGP4 trap_Key_SetCatcher
CALLV
pop
line 6377
;6377:			UI_BuildPlayerList();
ADDRGP4 UI_BuildPlayerList
CALLV
pop
line 6378
;6378:			Menus_CloseAll();
ADDRGP4 Menus_CloseAll
CALLV
pop
line 6379
;6379:			Menus_ActivateByName("ingame_playerforce");
ADDRGP4 $857
ARGP4
ADDRGP4 Menus_ActivateByName
CALLP4
pop
line 6380
;6380:			UpdateForceUsed();
ADDRGP4 UpdateForceUsed
CALLV
pop
line 6381
;6381:		  return;
LABELV $4453
line 6383
;6382:	  }
;6383:  }
LABELV $4449
line 6384
;6384:}
LABELV $4448
endproc _UI_SetActiveMenu 304 12
export _UI_IsFullscreen
proc _UI_IsFullscreen 4 0
line 6386
;6385:
;6386:qboolean _UI_IsFullscreen( void ) {
line 6387
;6387:	return Menus_AnyFullScreenVisible();
ADDRLP4 0
ADDRGP4 Menus_AnyFullScreenVisible
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
RETI4
LABELV $4486
endproc _UI_IsFullscreen 4 0
proc UI_ReadableSize 16 16
line 6396
;6388:}
;6389:
;6390:
;6391:
;6392:static connstate_t	lastConnState;
;6393:static char			lastLoadingText[MAX_INFO_VALUE];
;6394:
;6395:static void UI_ReadableSize ( char *buf, int bufsize, int value )
;6396:{
line 6397
;6397:	if (value > 1024*1024*1024 ) { // gigs
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
LEI4 $4488
line 6398
;6398:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $685
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1073741824
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6399
;6399:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d GB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $4490
ARGP4
ADDRLP4 12
CNSTI4 1073741824
ASGNI4
CNSTI4 100
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
MULI4
ADDRLP4 12
INDIRI4
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6401
;6400:			(value % (1024*1024*1024))*100 / (1024*1024*1024) );
;6401:	} else if (value > 1024*1024 ) { // megs
ADDRGP4 $4489
JUMPV
LABELV $4488
ADDRFP4 8
INDIRI4
CNSTI4 1048576
LEI4 $4491
line 6402
;6402:		Com_sprintf( buf, bufsize, "%d", value / (1024*1024) );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $685
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1048576
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6403
;6403:		Com_sprintf( buf+strlen(buf), bufsize-strlen(buf), ".%02d MB", 
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ARGI4
ADDRGP4 $4493
ARGP4
ADDRLP4 12
CNSTI4 1048576
ASGNI4
CNSTI4 100
ADDRFP4 8
INDIRI4
ADDRLP4 12
INDIRI4
MODI4
MULI4
ADDRLP4 12
INDIRI4
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6405
;6404:			(value % (1024*1024))*100 / (1024*1024) );
;6405:	} else if (value > 1024 ) { // kilos
ADDRGP4 $4492
JUMPV
LABELV $4491
ADDRFP4 8
INDIRI4
CNSTI4 1024
LEI4 $4494
line 6406
;6406:		Com_sprintf( buf, bufsize, "%d KB", value / 1024 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4496
ARGP4
ADDRFP4 8
INDIRI4
CNSTI4 1024
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6407
;6407:	} else { // bytes
ADDRGP4 $4495
JUMPV
LABELV $4494
line 6408
;6408:		Com_sprintf( buf, bufsize, "%d bytes", value );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4497
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6409
;6409:	}
LABELV $4495
LABELV $4492
LABELV $4489
line 6410
;6410:}
LABELV $4487
endproc UI_ReadableSize 16 16
proc UI_PrintTime 8 20
line 6413
;6411:
;6412:// Assumes time is in msec
;6413:static void UI_PrintTime ( char *buf, int bufsize, int time ) {
line 6414
;6414:	time /= 1000;  // change to seconds
ADDRFP4 8
ADDRFP4 8
INDIRI4
CNSTI4 1000
DIVI4
ASGNI4
line 6416
;6415:
;6416:	if (time > 3600) { // in the hours range
ADDRFP4 8
INDIRI4
CNSTI4 3600
LEI4 $4499
line 6417
;6417:		Com_sprintf( buf, bufsize, "%d hr %d min", time / 3600, (time % 3600) / 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4501
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 3600
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
CNSTI4 60
DIVI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6418
;6418:	} else if (time > 60) { // mins
ADDRGP4 $4500
JUMPV
LABELV $4499
ADDRFP4 8
INDIRI4
CNSTI4 60
LEI4 $4502
line 6419
;6419:		Com_sprintf( buf, bufsize, "%d min %d sec", time / 60, time % 60 );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4504
ARGP4
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 60
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
DIVI4
ARGI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
MODI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6420
;6420:	} else  { // secs
ADDRGP4 $4503
JUMPV
LABELV $4502
line 6421
;6421:		Com_sprintf( buf, bufsize, "%d sec", time );
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 $4505
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRGP4 Com_sprintf
CALLV
pop
line 6422
;6422:	}
LABELV $4503
LABELV $4500
line 6423
;6423:}
LABELV $4498
endproc UI_PrintTime 8 20
export Text_PaintCenter
proc Text_PaintCenter 8 36
line 6425
;6424:
;6425:void Text_PaintCenter(float x, float y, float scale, vec4_t color, const char *text, float adjust, int iMenuFont) {
line 6426
;6426:	int len = Text_Width(text, scale, iMenuFont);
ADDRFP4 16
INDIRP4
ARGP4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 24
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 Text_Width
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 6427
;6427:	Text_Paint(x - len / 2, y, scale, color, text, 0, 0, ITEM_TEXTSTYLE_SHADOWEDMORE, iMenuFont);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
DIVI4
CVIF4 4
SUBF4
ARGF4
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
ARGF4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 0
ARGI4
CNSTI4 6
ARGI4
ADDRFP4 24
INDIRI4
ARGI4
ADDRGP4 Text_Paint
CALLV
pop
line 6428
;6428:}
LABELV $4506
endproc Text_PaintCenter 8 36
data
align 1
LABELV $4508
char 1 68
char 1 111
char 1 119
char 1 110
char 1 108
char 1 111
char 1 97
char 1 100
char 1 105
char 1 110
char 1 103
char 1 58
char 1 0
align 1
LABELV $4509
char 1 69
char 1 115
char 1 116
char 1 105
char 1 109
char 1 97
char 1 116
char 1 101
char 1 100
char 1 32
char 1 116
char 1 105
char 1 109
char 1 101
char 1 32
char 1 108
char 1 101
char 1 102
char 1 116
char 1 58
char 1 0
align 1
LABELV $4510
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 102
char 1 101
char 1 114
char 1 32
char 1 114
char 1 97
char 1 116
char 1 101
char 1 58
char 1 0
code
proc UI_DisplayDownloadInfo 312 28
line 6431
;6429:
;6430:
;6431:static void UI_DisplayDownloadInfo( const char *downloadName, float centerPoint, float yStart, float scale, int iMenuFont) {
line 6442
;6432:	static char dlText[]	= "Downloading:";
;6433:	static char etaText[]	= "Estimated time left:";
;6434:	static char xferText[]	= "Transfer rate:";
;6435:
;6436:	int downloadSize, downloadCount, downloadTime;
;6437:	char dlSizeBuf[64], totalSizeBuf[64], xferRateBuf[64], dlTimeBuf[64];
;6438:	int xferRate;
;6439:	int leftWidth;
;6440:	const char *s;
;6441:
;6442:	downloadSize = trap_Cvar_VariableValue( "cl_downloadSize" );
ADDRGP4 $4511
ARGP4
ADDRLP4 280
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 0
ADDRLP4 280
INDIRF4
CVFI4 4
ASGNI4
line 6443
;6443:	downloadCount = trap_Cvar_VariableValue( "cl_downloadCount" );
ADDRGP4 $4512
ARGP4
ADDRLP4 284
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 284
INDIRF4
CVFI4 4
ASGNI4
line 6444
;6444:	downloadTime = trap_Cvar_VariableValue( "cl_downloadTime" );
ADDRGP4 $4513
ARGP4
ADDRLP4 288
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRLP4 140
ADDRLP4 288
INDIRF4
CVFI4 4
ASGNI4
line 6446
;6445:
;6446:	leftWidth = 320;
ADDRLP4 8
CNSTI4 320
ASGNI4
line 6448
;6447:
;6448:	UI_SetColor(colorWhite);
ADDRGP4 colorWhite
ARGP4
ADDRGP4 UI_SetColor
CALLV
pop
line 6449
;6449:	Text_PaintCenter(centerPoint, yStart + 112, scale, colorWhite, dlText, 0, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1121976320
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4508
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6450
;6450:	Text_PaintCenter(centerPoint, yStart + 192, scale, colorWhite, etaText, 0, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1128267776
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4509
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6451
;6451:	Text_PaintCenter(centerPoint, yStart + 248, scale, colorWhite, xferText, 0, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1131937792
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4510
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6453
;6452:
;6453:	if (downloadSize > 0) {
ADDRLP4 0
INDIRI4
CNSTI4 0
LEI4 $4514
line 6454
;6454:		s = va( "%s (%d%%)", downloadName, downloadCount * 100 / downloadSize );
ADDRGP4 $4516
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 100
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
DIVI4
ARGI4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 148
ADDRLP4 292
INDIRP4
ASGNP4
line 6455
;6455:	} else {
ADDRGP4 $4515
JUMPV
LABELV $4514
line 6456
;6456:		s = downloadName;
ADDRLP4 148
ADDRFP4 0
INDIRP4
ASGNP4
line 6457
;6457:	}
LABELV $4515
line 6459
;6458:
;6459:	Text_PaintCenter(centerPoint, yStart+136, scale, colorWhite, s, 0, iMenuFont);
ADDRFP4 4
INDIRF4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1124597760
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 148
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6461
;6460:
;6461:	UI_ReadableSize( dlSizeBuf,		sizeof dlSizeBuf,		downloadCount );
ADDRLP4 12
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 6462
;6462:	UI_ReadableSize( totalSizeBuf,	sizeof totalSizeBuf,	downloadSize );
ADDRLP4 76
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 6464
;6463:
;6464:	if (downloadCount < 4096 || !downloadTime) {
ADDRLP4 4
INDIRI4
CNSTI4 4096
LTI4 $4519
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $4517
LABELV $4519
line 6465
;6465:		Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, "estimating", 0, iMenuFont);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4520
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6466
;6466:		Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0, iMenuFont);
ADDRGP4 $4521
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 292
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 292
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6467
;6467:	} else {
ADDRGP4 $4518
JUMPV
LABELV $4517
line 6468
;6468:		if ((uiInfo.uiDC.realTime - downloadTime) / 1000) {
ADDRGP4 uiInfo+232
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
CNSTI4 0
EQI4 $4522
line 6469
;6469:			xferRate = downloadCount / ((uiInfo.uiDC.realTime - downloadTime) / 1000);
ADDRLP4 144
ADDRLP4 4
INDIRI4
ADDRGP4 uiInfo+232
INDIRI4
ADDRLP4 140
INDIRI4
SUBI4
CNSTI4 1000
DIVI4
DIVI4
ASGNI4
line 6470
;6470:		} else {
ADDRGP4 $4523
JUMPV
LABELV $4522
line 6471
;6471:			xferRate = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 6472
;6472:		}
LABELV $4523
line 6473
;6473:		UI_ReadableSize( xferRateBuf, sizeof xferRateBuf, xferRate );
ADDRLP4 152
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 144
INDIRI4
ARGI4
ADDRGP4 UI_ReadableSize
CALLV
pop
line 6476
;6474:
;6475:		// Extrapolate estimated completion time
;6476:		if (downloadSize && xferRate) {
ADDRLP4 292
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 292
INDIRI4
EQI4 $4526
ADDRLP4 144
INDIRI4
ADDRLP4 292
INDIRI4
EQI4 $4526
line 6477
;6477:			int n = downloadSize / xferRate; // estimated time for entire d/l in secs
ADDRLP4 296
ADDRLP4 0
INDIRI4
ADDRLP4 144
INDIRI4
DIVI4
ASGNI4
line 6480
;6478:
;6479:			// We do it in K (/1024) because we'd overflow around 4MB
;6480:			UI_PrintTime ( dlTimeBuf, sizeof dlTimeBuf, 
ADDRLP4 216
ARGP4
CNSTI4 64
ARGI4
ADDRLP4 300
ADDRLP4 296
INDIRI4
ASGNI4
ADDRLP4 304
CNSTI4 1024
ASGNI4
CNSTI4 1000
ADDRLP4 300
INDIRI4
ADDRLP4 4
INDIRI4
ADDRLP4 304
INDIRI4
DIVI4
ADDRLP4 300
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
ADDRLP4 304
INDIRI4
DIVI4
DIVI4
SUBI4
MULI4
ARGI4
ADDRGP4 UI_PrintTime
CALLV
pop
line 6483
;6481:				(n - (((downloadCount/1024) * n) / (downloadSize/1024))) * 1000);
;6482:
;6483:			Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, dlTimeBuf, 0, iMenuFont);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 216
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6484
;6484:			Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0, iMenuFont);
ADDRGP4 $4521
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 308
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 308
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6485
;6485:		} else {
ADDRGP4 $4527
JUMPV
LABELV $4526
line 6486
;6486:			Text_PaintCenter(leftWidth, yStart+216, scale, colorWhite, "estimating", 0, iMenuFont);
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1129840640
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRGP4 $4520
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6487
;6487:			if (downloadSize) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4528
line 6488
;6488:				Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s of %s copied)", dlSizeBuf, totalSizeBuf), 0, iMenuFont);
ADDRGP4 $4521
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 76
ARGP4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 296
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6489
;6489:			} else {
ADDRGP4 $4529
JUMPV
LABELV $4528
line 6490
;6490:				Text_PaintCenter(leftWidth, yStart+160, scale, colorWhite, va("(%s copied)", dlSizeBuf), 0, iMenuFont);
ADDRGP4 $4530
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1126170624
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 296
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6491
;6491:			}
LABELV $4529
line 6492
;6492:		}
LABELV $4527
line 6494
;6493:
;6494:		if (xferRate) {
ADDRLP4 144
INDIRI4
CNSTI4 0
EQI4 $4531
line 6495
;6495:			Text_PaintCenter(leftWidth, yStart+272, scale, colorWhite, va("%s/Sec", xferRateBuf), 0, iMenuFont);
ADDRGP4 $4533
ARGP4
ADDRLP4 152
ARGP4
ADDRLP4 296
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 8
INDIRI4
CVIF4 4
ARGF4
ADDRFP4 8
INDIRF4
CNSTF4 1132986368
ADDF4
ARGF4
ADDRFP4 12
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 296
INDIRP4
ARGP4
CNSTF4 0
ARGF4
ADDRFP4 16
INDIRI4
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6496
;6496:		}
LABELV $4531
line 6497
;6497:	}
LABELV $4518
line 6498
;6498:}
LABELV $4507
endproc UI_DisplayDownloadInfo 312 28
export UI_DrawConnectScreen
proc UI_DrawConnectScreen 5688 28
line 6508
;6499:
;6500:/*
;6501:========================
;6502:UI_DrawConnectScreen
;6503:
;6504:This will also be overlaid on the cgame info screen during loading
;6505:to prevent it from blinking away too rapidly on local or lan games.
;6506:========================
;6507:*/
;6508:void UI_DrawConnectScreen( qboolean overlay ) {
line 6517
;6509:	const char *s;
;6510:	uiClientState_t	cstate;
;6511:	char			info[MAX_INFO_VALUE];
;6512:	char text[256];
;6513:	float centerPoint, yStart, scale;
;6514:
;6515:	char sStripEdTemp[256];
;6516:
;6517:	menuDef_t *menu = Menus_FindByName("Connect");
ADDRGP4 $4535
ARGP4
ADDRLP4 4640
ADDRGP4 Menus_FindByName
CALLP4
ASGNP4
ADDRLP4 4376
ADDRLP4 4640
INDIRP4
ASGNP4
line 6520
;6518:
;6519:
;6520:	if ( !overlay && menu ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4536
ADDRLP4 4376
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $4536
line 6521
;6521:		Menu_Paint(menu, qtrue);
ADDRLP4 4376
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 Menu_Paint
CALLV
pop
line 6522
;6522:	}
LABELV $4536
line 6524
;6523:
;6524:	if (!overlay) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4538
line 6525
;6525:		centerPoint = 320;
ADDRLP4 3340
CNSTF4 1134559232
ASGNF4
line 6526
;6526:		yStart = 130;
ADDRLP4 3348
CNSTF4 1124204544
ASGNF4
line 6527
;6527:		scale = 1.0f;	// -ste
ADDRLP4 3344
CNSTF4 1065353216
ASGNF4
line 6528
;6528:	} else {
ADDRGP4 $4539
JUMPV
LABELV $4538
line 6529
;6529:		centerPoint = 320;
ADDRLP4 3340
CNSTF4 1134559232
ASGNF4
line 6530
;6530:		yStart = 32;
ADDRLP4 3348
CNSTF4 1107296256
ASGNF4
line 6531
;6531:		scale = 1.0f;	// -ste
ADDRLP4 3344
CNSTF4 1065353216
ASGNF4
line 6532
;6532:		return;
ADDRGP4 $4534
JUMPV
LABELV $4539
line 6536
;6533:	}
;6534:
;6535:	// see what information we should display
;6536:	trap_GetClientState( &cstate );
ADDRLP4 0
ARGP4
ADDRGP4 trap_GetClientState
CALLV
pop
line 6539
;6537:
;6538:
;6539:	info[0] = '\0';
ADDRLP4 3352
CNSTI1 0
ASGNI1
line 6540
;6540:	if( trap_GetConfigString( CS_SERVERINFO, info, sizeof(info) ) ) {
CNSTI4 0
ARGI4
ADDRLP4 3352
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 4644
ADDRGP4 trap_GetConfigString
CALLI4
ASGNI4
ADDRLP4 4644
INDIRI4
CNSTI4 0
EQI4 $4540
line 6541
;6541:		trap_SP_GetStringTextString("MENUS3_LOADING_MAPNAME", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4542
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6542
;6542:		Text_PaintCenter(centerPoint, yStart, scale, colorWhite, va( /*"Loading %s"*/sStripEdTemp, Info_ValueForKey( info, "mapname" )), 0, FONT_MEDIUM);
ADDRLP4 3352
ARGP4
ADDRGP4 $3281
ARGP4
ADDRLP4 4648
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3084
ARGP4
ADDRLP4 4648
INDIRP4
ARGP4
ADDRLP4 4652
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4652
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6543
;6543:	}
LABELV $4540
line 6545
;6544:
;6545:	if (!Q_stricmp(cstate.servername,"localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4546
ARGP4
ADDRLP4 4648
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4648
INDIRI4
CNSTI4 0
NEI4 $4543
line 6546
;6546:		trap_SP_GetStringTextString("MENUS3_STARTING_UP", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4547
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6547
;6547:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite, sStripEdTemp, ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM);
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 3084
ARGP4
CNSTF4 1086324736
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6548
;6548:	} else {
ADDRGP4 $4544
JUMPV
LABELV $4543
line 6549
;6549:		trap_SP_GetStringTextString("MENUS3_CONNECTING_TO", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4548
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6550
;6550:		strcpy(text, va(/*"Connecting to %s"*/sStripEdTemp, cstate.servername));
ADDRLP4 3084
ARGP4
ADDRLP4 0+12
ARGP4
ADDRLP4 4652
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4380
ARGP4
ADDRLP4 4652
INDIRP4
ARGP4
ADDRGP4 strcpy
CALLP4
pop
line 6551
;6551:		Text_PaintCenter(centerPoint, yStart + 48, scale, colorWhite,text , ITEM_TEXTSTYLE_SHADOWEDMORE, FONT_MEDIUM);
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
CNSTF4 1111490560
ADDF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4380
ARGP4
CNSTF4 1086324736
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6552
;6552:	}
LABELV $4544
line 6557
;6553:
;6554:	//UI_DrawProportionalString( 320, 96, "Press Esc to abort", UI_CENTER|UI_SMALLFONT|UI_DROPSHADOW, menu_text_color );
;6555:
;6556:	// display global MOTD at bottom
;6557:	Text_PaintCenter(centerPoint, 600, scale, colorWhite, Info_ValueForKey( cstate.updateInfoString, "motd" ), 0, FONT_MEDIUM);
ADDRLP4 0+1036
ARGP4
ADDRGP4 $4551
ARGP4
ADDRLP4 4652
ADDRGP4 Info_ValueForKey
CALLP4
ASGNP4
ADDRLP4 3340
INDIRF4
ARGF4
CNSTF4 1142292480
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4652
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6559
;6558:	// print any server info (server full, bad version, etc)
;6559:	if ( cstate.connState < CA_CONNECTED ) {
ADDRLP4 0
INDIRI4
CNSTI4 5
GEI4 $4552
line 6560
;6560:		Text_PaintCenter(centerPoint, yStart + 176, scale, colorWhite, cstate.messageString, 0, FONT_MEDIUM);
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
CNSTF4 1127219200
ADDF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 0+2060
ARGP4
CNSTF4 0
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6561
;6561:	}
LABELV $4552
line 6563
;6562:
;6563:	if ( lastConnState > cstate.connState ) {
ADDRGP4 lastConnState
INDIRI4
ADDRLP4 0
INDIRI4
LEI4 $4555
line 6564
;6564:		lastLoadingText[0] = '\0';
ADDRGP4 lastLoadingText
CNSTI1 0
ASGNI1
line 6565
;6565:	}
LABELV $4555
line 6566
;6566:	lastConnState = cstate.connState;
ADDRGP4 lastConnState
ADDRLP4 0
INDIRI4
ASGNI4
line 6568
;6567:
;6568:	switch ( cstate.connState ) {
ADDRLP4 4656
ADDRLP4 0
INDIRI4
ASGNI4
ADDRLP4 4656
INDIRI4
CNSTI4 3
LTI4 $4534
ADDRLP4 4656
INDIRI4
CNSTI4 7
GTI4 $4534
ADDRLP4 4656
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $4573-12
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $4573
address $4560
address $4563
address $4566
address $4534
address $4534
code
LABELV $4560
line 6570
;6569:	case CA_CONNECTING:
;6570:		{
line 6571
;6571:			trap_SP_GetStringTextString("MENUS3_AWAITING_CONNECTION", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4561
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6572
;6572:			s = va(/*"Awaiting connection...%i"*/sStripEdTemp, cstate.connectPacketCount);
ADDRLP4 3084
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4664
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4636
ADDRLP4 4664
INDIRP4
ASGNP4
line 6573
;6573:		}
line 6574
;6574:		break;
ADDRGP4 $4558
JUMPV
LABELV $4563
line 6576
;6575:	case CA_CHALLENGING:
;6576:		{
line 6577
;6577:			trap_SP_GetStringTextString("MENUS3_AWAITING_CHALLENGE", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4564
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6578
;6578:			s = va(/*"Awaiting challenge...%i"*/sStripEdTemp, cstate.connectPacketCount);
ADDRLP4 3084
ARGP4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 4664
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 4636
ADDRLP4 4664
INDIRP4
ASGNP4
line 6579
;6579:		}
line 6580
;6580:		break;
ADDRGP4 $4558
JUMPV
LABELV $4566
line 6581
;6581:	case CA_CONNECTED: {
line 6584
;6582:		char downloadName[MAX_INFO_VALUE];
;6583:
;6584:			trap_Cvar_VariableStringBuffer( "cl_downloadName", downloadName, sizeof(downloadName) );
ADDRGP4 $4567
ARGP4
ADDRLP4 4664
ARGP4
CNSTI4 1024
ARGI4
ADDRGP4 trap_Cvar_VariableStringBuffer
CALLV
pop
line 6585
;6585:			if (*downloadName) {
ADDRLP4 4664
INDIRI1
CVII4 1
CNSTI4 0
EQI4 $4568
line 6586
;6586:				UI_DisplayDownloadInfo( downloadName, centerPoint, yStart, scale, FONT_MEDIUM );
ADDRLP4 4664
ARGP4
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 UI_DisplayDownloadInfo
CALLV
pop
line 6587
;6587:				return;
ADDRGP4 $4534
JUMPV
LABELV $4568
line 6589
;6588:			}
;6589:		}
line 6590
;6590:		trap_SP_GetStringTextString("MENUS3_AWAITING_GAMESTATE", sStripEdTemp, sizeof(sStripEdTemp));
ADDRGP4 $4570
ARGP4
ADDRLP4 3084
ARGP4
CNSTI4 256
ARGI4
ADDRGP4 trap_SP_GetStringTextString
CALLI4
pop
line 6591
;6591:		s = /*"Awaiting gamestate..."*/sStripEdTemp;
ADDRLP4 4636
ADDRLP4 3084
ASGNP4
line 6592
;6592:		break;
line 6594
;6593:	case CA_LOADING:
;6594:		return;
line 6596
;6595:	case CA_PRIMED:
;6596:		return;
line 6598
;6597:	default:
;6598:		return;
LABELV $4558
line 6601
;6599:	}
;6600:
;6601:	if (Q_stricmp(cstate.servername,"localhost")) {
ADDRLP4 0+12
ARGP4
ADDRGP4 $4546
ARGP4
ADDRLP4 4664
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 4664
INDIRI4
CNSTI4 0
EQI4 $4575
line 6602
;6602:		Text_PaintCenter(centerPoint, yStart + 80, scale, colorWhite, s, 0, FONT_MEDIUM);
ADDRLP4 3340
INDIRF4
ARGF4
ADDRLP4 3348
INDIRF4
CNSTF4 1117782016
ADDF4
ARGF4
ADDRLP4 3344
INDIRF4
ARGF4
ADDRGP4 colorWhite
ARGP4
ADDRLP4 4636
INDIRP4
ARGP4
CNSTF4 0
ARGF4
CNSTI4 2
ARGI4
ADDRGP4 Text_PaintCenter
CALLV
pop
line 6603
;6603:	}
LABELV $4575
line 6606
;6604:
;6605:	// password required / connection rejected information goes here
;6606:}
LABELV $4534
endproc UI_DrawConnectScreen 5688 28
data
align 4
LABELV cvarTable
address ui_ffa_fraglimit
address $4579
address $673
byte 4 1
address ui_ffa_timelimit
address $4580
address $333
byte 4 1
address ui_tourney_fraglimit
address $4581
address $333
byte 4 1
address ui_tourney_timelimit
address $4582
address $674
byte 4 1
address ui_selectedModelIndex
address $3848
address $4583
byte 4 1
address ui_team_fraglimit
address $4584
address $333
byte 4 1
address ui_team_timelimit
address $4585
address $673
byte 4 1
address ui_team_friendly
address $4586
address $336
byte 4 1
address ui_ctf_capturelimit
address $4587
address $4588
byte 4 1
address ui_ctf_timelimit
address $4589
address $671
byte 4 1
address ui_ctf_friendly
address $4590
address $333
byte 4 1
address ui_arenasFile
address $4591
address $170
byte 4 80
address ui_botsFile
address $4592
address $170
byte 4 80
address ui_spScores1
address $4593
address $170
byte 4 65
address ui_spScores2
address $4594
address $170
byte 4 65
address ui_spScores3
address $4595
address $170
byte 4 65
address ui_spScores4
address $4596
address $170
byte 4 65
address ui_spScores5
address $4597
address $170
byte 4 65
address ui_spAwards
address $4598
address $170
byte 4 65
address ui_spVideos
address $4599
address $170
byte 4 65
address ui_spSkill
address $809
address $2412
byte 4 1
address ui_spSelection
address $4600
address $170
byte 4 64
address ui_browserMaster
address $4601
address $333
byte 4 1
address ui_browserGameType
address $4602
address $333
byte 4 1
address ui_browserSortKey
address $4603
address $2505
byte 4 1
address ui_browserShowFull
address $4604
address $336
byte 4 1
address ui_browserShowEmpty
address $4605
address $336
byte 4 1
address ui_drawCrosshair
address $2127
address $336
byte 4 1
address ui_drawCrosshairNames
address $4606
address $336
byte 4 1
address ui_marks
address $4607
address $336
byte 4 1
address ui_server1
address $4608
address $170
byte 4 1
address ui_server2
address $4609
address $170
byte 4 1
address ui_server3
address $4610
address $170
byte 4 1
address ui_server4
address $4611
address $170
byte 4 1
address ui_server5
address $4612
address $170
byte 4 1
address ui_server6
address $4613
address $170
byte 4 1
address ui_server7
address $4614
address $170
byte 4 1
address ui_server8
address $4615
address $170
byte 4 1
address ui_server9
address $4616
address $170
byte 4 1
address ui_server10
address $4617
address $170
byte 4 1
address ui_server11
address $4618
address $170
byte 4 1
address ui_server12
address $4619
address $170
byte 4 1
address ui_server13
address $4620
address $170
byte 4 1
address ui_server14
address $4621
address $170
byte 4 1
address ui_server15
address $4622
address $170
byte 4 1
address ui_server16
address $4623
address $170
byte 4 1
address ui_cdkeychecked
address $4624
address $333
byte 4 64
address ui_debug
address $4625
address $333
byte 4 256
address ui_initialized
address $4626
address $333
byte 4 256
address ui_teamName
address $680
address $4627
byte 4 1
address ui_opponentName
address $1143
address $4628
byte 4 1
address ui_rankChange
address $393
address $333
byte 4 1
address ui_freeSaber
address $4629
address $333
byte 4 1
address ui_forcePowerDisable
address $4630
address $333
byte 4 1
address ui_redteam
address $4631
address $4627
byte 4 1
address ui_blueteam
address $4632
address $4628
byte 4 1
address ui_dedicated
address $4633
address $333
byte 4 1
address ui_gameType
address $4634
address $333
byte 4 1
address ui_joinGameType
address $4635
address $333
byte 4 1
address ui_netGameType
address $4636
address $333
byte 4 1
address ui_actualNetGameType
address $4637
address $4638
byte 4 1
address ui_redteam1
address $4639
address $336
byte 4 1
address ui_redteam2
address $4640
address $336
byte 4 1
address ui_redteam3
address $4641
address $336
byte 4 1
address ui_redteam4
address $4642
address $336
byte 4 1
address ui_redteam5
address $4643
address $336
byte 4 1
address ui_redteam6
address $4644
address $336
byte 4 1
address ui_redteam7
address $4645
address $336
byte 4 1
address ui_redteam8
address $4646
address $336
byte 4 1
address ui_blueteam1
address $4647
address $336
byte 4 1
address ui_blueteam2
address $4648
address $336
byte 4 1
address ui_blueteam3
address $4649
address $336
byte 4 1
address ui_blueteam4
address $4650
address $336
byte 4 1
address ui_blueteam5
address $4651
address $336
byte 4 1
address ui_blueteam6
address $4652
address $336
byte 4 1
address ui_blueteam7
address $4653
address $336
byte 4 1
address ui_blueteam8
address $4654
address $336
byte 4 1
address ui_netSource
address $2042
address $333
byte 4 1
address ui_menuFiles
address $652
address $619
byte 4 1
address ui_currentTier
address $1075
address $333
byte 4 1
address ui_currentMap
address $922
address $333
byte 4 1
address ui_currentNetMap
address $920
address $333
byte 4 1
address ui_mapIndex
address $2275
address $333
byte 4 1
address ui_currentOpponent
address $4655
address $333
byte 4 1
address ui_selectedPlayer
address $1450
address $333
byte 4 1
address ui_selectedPlayerName
address $1458
address $170
byte 4 1
address ui_lastServerRefresh_0
address $4656
address $170
byte 4 1
address ui_lastServerRefresh_1
address $4657
address $170
byte 4 1
address ui_lastServerRefresh_2
address $4658
address $170
byte 4 1
address ui_lastServerRefresh_3
address $4659
address $170
byte 4 1
address ui_singlePlayerActive
address $2288
address $333
byte 4 0
address ui_scoreAccuracy
address $4660
address $333
byte 4 1
address ui_scoreImpressives
address $4661
address $333
byte 4 1
address ui_scoreExcellents
address $4662
address $333
byte 4 1
address ui_scoreCaptures
address $4663
address $333
byte 4 1
address ui_scoreDefends
address $4664
address $333
byte 4 1
address ui_scoreAssists
address $4665
address $333
byte 4 1
address ui_scoreGauntlets
address $4666
address $333
byte 4 1
address ui_scoreScore
address $4667
address $333
byte 4 1
address ui_scorePerfect
address $4668
address $333
byte 4 1
address ui_scoreTeam
address $4669
address $4670
byte 4 1
address ui_scoreBase
address $4671
address $333
byte 4 1
address ui_scoreTime
address $4672
address $4673
byte 4 1
address ui_scoreTimeBonus
address $4674
address $333
byte 4 1
address ui_scoreSkillBonus
address $4675
address $333
byte 4 1
address ui_scoreShutoutBonus
address $4676
address $333
byte 4 1
address ui_fragLimit
address $686
address $675
byte 4 0
address ui_captureLimit
address $684
address $676
byte 4 0
address ui_smallFont
address $4677
address $4678
byte 4 1
address ui_bigFont
address $4679
address $4680
byte 4 1
address ui_findPlayer
address $3369
address $1141
byte 4 1
address ui_Q3Model
address $4681
address $333
byte 4 1
address ui_recordSPDemo
address $2308
address $333
byte 4 1
address ui_realWarmUp
address $2300
address $673
byte 4 1
address ui_realCaptureLimit
address $687
address $4588
byte 4 1029
address ui_serverStatusTimeOut
address $4682
address $4683
byte 4 1
address s_language
address $4684
address $4685
byte 4 1025
address k_language
address $4686
address $4685
byte 4 1025
align 4
LABELV cvarTableSize
byte 4 118
export UI_RegisterCvars
code
proc UI_RegisterCvars 12 16
line 6889
;6607:
;6608:
;6609:/*
;6610:================
;6611:cvars
;6612:================
;6613:*/
;6614:
;6615:typedef struct {
;6616:	vmCvar_t	*vmCvar;
;6617:	char		*cvarName;
;6618:	char		*defaultString;
;6619:	int			cvarFlags;
;6620:} cvarTable_t;
;6621:
;6622:vmCvar_t	ui_ffa_fraglimit;
;6623:vmCvar_t	ui_ffa_timelimit;
;6624:
;6625:vmCvar_t	ui_tourney_fraglimit;
;6626:vmCvar_t	ui_tourney_timelimit;
;6627:
;6628:vmCvar_t	ui_selectedModelIndex;
;6629:
;6630:vmCvar_t	ui_team_fraglimit;
;6631:vmCvar_t	ui_team_timelimit;
;6632:vmCvar_t	ui_team_friendly;
;6633:
;6634:vmCvar_t	ui_ctf_capturelimit;
;6635:vmCvar_t	ui_ctf_timelimit;
;6636:vmCvar_t	ui_ctf_friendly;
;6637:
;6638:vmCvar_t	ui_arenasFile;
;6639:vmCvar_t	ui_botsFile;
;6640:vmCvar_t	ui_spScores1;
;6641:vmCvar_t	ui_spScores2;
;6642:vmCvar_t	ui_spScores3;
;6643:vmCvar_t	ui_spScores4;
;6644:vmCvar_t	ui_spScores5;
;6645:vmCvar_t	ui_spAwards;
;6646:vmCvar_t	ui_spVideos;
;6647:vmCvar_t	ui_spSkill;
;6648:
;6649:vmCvar_t	ui_spSelection;
;6650:
;6651:vmCvar_t	ui_browserMaster;
;6652:vmCvar_t	ui_browserGameType;
;6653:vmCvar_t	ui_browserSortKey;
;6654:vmCvar_t	ui_browserShowFull;
;6655:vmCvar_t	ui_browserShowEmpty;
;6656:
;6657:vmCvar_t	ui_drawCrosshair;
;6658:vmCvar_t	ui_drawCrosshairNames;
;6659:vmCvar_t	ui_marks;
;6660:
;6661:vmCvar_t	ui_server1;
;6662:vmCvar_t	ui_server2;
;6663:vmCvar_t	ui_server3;
;6664:vmCvar_t	ui_server4;
;6665:vmCvar_t	ui_server5;
;6666:vmCvar_t	ui_server6;
;6667:vmCvar_t	ui_server7;
;6668:vmCvar_t	ui_server8;
;6669:vmCvar_t	ui_server9;
;6670:vmCvar_t	ui_server10;
;6671:vmCvar_t	ui_server11;
;6672:vmCvar_t	ui_server12;
;6673:vmCvar_t	ui_server13;
;6674:vmCvar_t	ui_server14;
;6675:vmCvar_t	ui_server15;
;6676:vmCvar_t	ui_server16;
;6677:
;6678:vmCvar_t	ui_cdkeychecked;
;6679:
;6680:vmCvar_t	ui_redteam;
;6681:vmCvar_t	ui_redteam1;
;6682:vmCvar_t	ui_redteam2;
;6683:vmCvar_t	ui_redteam3;
;6684:vmCvar_t	ui_redteam4;
;6685:vmCvar_t	ui_redteam5;
;6686:vmCvar_t	ui_redteam6;
;6687:vmCvar_t	ui_redteam7;
;6688:vmCvar_t	ui_redteam8;
;6689:vmCvar_t	ui_blueteam;
;6690:vmCvar_t	ui_blueteam1;
;6691:vmCvar_t	ui_blueteam2;
;6692:vmCvar_t	ui_blueteam3;
;6693:vmCvar_t	ui_blueteam4;
;6694:vmCvar_t	ui_blueteam5;
;6695:vmCvar_t	ui_blueteam6;
;6696:vmCvar_t	ui_blueteam7;
;6697:vmCvar_t	ui_blueteam8;
;6698:vmCvar_t	ui_teamName;
;6699:vmCvar_t	ui_dedicated;
;6700:vmCvar_t	ui_gameType;
;6701:vmCvar_t	ui_netGameType;
;6702:vmCvar_t	ui_actualNetGameType;
;6703:vmCvar_t	ui_joinGameType;
;6704:vmCvar_t	ui_netSource;
;6705:vmCvar_t	ui_serverFilterType;
;6706:vmCvar_t	ui_opponentName;
;6707:vmCvar_t	ui_menuFiles;
;6708:vmCvar_t	ui_currentTier;
;6709:vmCvar_t	ui_currentMap;
;6710:vmCvar_t	ui_currentNetMap;
;6711:vmCvar_t	ui_mapIndex;
;6712:vmCvar_t	ui_currentOpponent;
;6713:vmCvar_t	ui_selectedPlayer;
;6714:vmCvar_t	ui_selectedPlayerName;
;6715:vmCvar_t	ui_lastServerRefresh_0;
;6716:vmCvar_t	ui_lastServerRefresh_1;
;6717:vmCvar_t	ui_lastServerRefresh_2;
;6718:vmCvar_t	ui_lastServerRefresh_3;
;6719:vmCvar_t	ui_singlePlayerActive;
;6720:vmCvar_t	ui_scoreAccuracy;
;6721:vmCvar_t	ui_scoreImpressives;
;6722:vmCvar_t	ui_scoreExcellents;
;6723:vmCvar_t	ui_scoreCaptures;
;6724:vmCvar_t	ui_scoreDefends;
;6725:vmCvar_t	ui_scoreAssists;
;6726:vmCvar_t	ui_scoreGauntlets;
;6727:vmCvar_t	ui_scoreScore;
;6728:vmCvar_t	ui_scorePerfect;
;6729:vmCvar_t	ui_scoreTeam;
;6730:vmCvar_t	ui_scoreBase;
;6731:vmCvar_t	ui_scoreTimeBonus;
;6732:vmCvar_t	ui_scoreSkillBonus;
;6733:vmCvar_t	ui_scoreShutoutBonus;
;6734:vmCvar_t	ui_scoreTime;
;6735:vmCvar_t	ui_captureLimit;
;6736:vmCvar_t	ui_fragLimit;
;6737:vmCvar_t	ui_smallFont;
;6738:vmCvar_t	ui_bigFont;
;6739:vmCvar_t	ui_findPlayer;
;6740:vmCvar_t	ui_Q3Model;
;6741:vmCvar_t	ui_hudFiles;
;6742:vmCvar_t	ui_recordSPDemo;
;6743:vmCvar_t	ui_realCaptureLimit;
;6744:vmCvar_t	ui_realWarmUp;
;6745:vmCvar_t	ui_serverStatusTimeOut;
;6746:vmCvar_t	s_language;
;6747:vmCvar_t	k_language;
;6748:
;6749:// bk001129 - made static to avoid aliasing
;6750:static cvarTable_t		cvarTable[] = {
;6751:	{ &ui_ffa_fraglimit, "ui_ffa_fraglimit", "20", CVAR_ARCHIVE },
;6752:	{ &ui_ffa_timelimit, "ui_ffa_timelimit", "0", CVAR_ARCHIVE },
;6753:
;6754:	{ &ui_tourney_fraglimit, "ui_tourney_fraglimit", "0", CVAR_ARCHIVE },
;6755:	{ &ui_tourney_timelimit, "ui_tourney_timelimit", "15", CVAR_ARCHIVE },
;6756:
;6757:	{ &ui_selectedModelIndex, "ui_selectedModelIndex", "16", CVAR_ARCHIVE },
;6758:
;6759:	{ &ui_team_fraglimit, "ui_team_fraglimit", "0", CVAR_ARCHIVE },
;6760:	{ &ui_team_timelimit, "ui_team_timelimit", "20", CVAR_ARCHIVE },
;6761:	{ &ui_team_friendly, "ui_team_friendly",  "1", CVAR_ARCHIVE },
;6762:
;6763:	{ &ui_ctf_capturelimit, "ui_ctf_capturelimit", "8", CVAR_ARCHIVE },
;6764:	{ &ui_ctf_timelimit, "ui_ctf_timelimit", "30", CVAR_ARCHIVE },
;6765:	{ &ui_ctf_friendly, "ui_ctf_friendly",  "0", CVAR_ARCHIVE },
;6766:
;6767:	{ &ui_arenasFile, "g_arenasFile", "", CVAR_INIT|CVAR_ROM },
;6768:	{ &ui_botsFile, "g_botsFile", "", CVAR_INIT|CVAR_ROM },
;6769:	{ &ui_spScores1, "g_spScores1", "", CVAR_ARCHIVE | CVAR_ROM },
;6770:	{ &ui_spScores2, "g_spScores2", "", CVAR_ARCHIVE | CVAR_ROM },
;6771:	{ &ui_spScores3, "g_spScores3", "", CVAR_ARCHIVE | CVAR_ROM },
;6772:	{ &ui_spScores4, "g_spScores4", "", CVAR_ARCHIVE | CVAR_ROM },
;6773:	{ &ui_spScores5, "g_spScores5", "", CVAR_ARCHIVE | CVAR_ROM },
;6774:	{ &ui_spAwards, "g_spAwards", "", CVAR_ARCHIVE | CVAR_ROM },
;6775:	{ &ui_spVideos, "g_spVideos", "", CVAR_ARCHIVE | CVAR_ROM },
;6776:	{ &ui_spSkill, "g_spSkill", "2", CVAR_ARCHIVE },
;6777:
;6778:	{ &ui_spSelection, "ui_spSelection", "", CVAR_ROM },
;6779:
;6780:	{ &ui_browserMaster, "ui_browserMaster", "0", CVAR_ARCHIVE },
;6781:	{ &ui_browserGameType, "ui_browserGameType", "0", CVAR_ARCHIVE },
;6782:	{ &ui_browserSortKey, "ui_browserSortKey", "4", CVAR_ARCHIVE },
;6783:	{ &ui_browserShowFull, "ui_browserShowFull", "1", CVAR_ARCHIVE },
;6784:	{ &ui_browserShowEmpty, "ui_browserShowEmpty", "1", CVAR_ARCHIVE },
;6785:
;6786:	{ &ui_drawCrosshair, "cg_drawCrosshair", "1", CVAR_ARCHIVE },
;6787:	{ &ui_drawCrosshairNames, "cg_drawCrosshairNames", "1", CVAR_ARCHIVE },
;6788:	{ &ui_marks, "cg_marks", "1", CVAR_ARCHIVE },
;6789:
;6790:	{ &ui_server1, "server1", "", CVAR_ARCHIVE },
;6791:	{ &ui_server2, "server2", "", CVAR_ARCHIVE },
;6792:	{ &ui_server3, "server3", "", CVAR_ARCHIVE },
;6793:	{ &ui_server4, "server4", "", CVAR_ARCHIVE },
;6794:	{ &ui_server5, "server5", "", CVAR_ARCHIVE },
;6795:	{ &ui_server6, "server6", "", CVAR_ARCHIVE },
;6796:	{ &ui_server7, "server7", "", CVAR_ARCHIVE },
;6797:	{ &ui_server8, "server8", "", CVAR_ARCHIVE },
;6798:	{ &ui_server9, "server9", "", CVAR_ARCHIVE },
;6799:	{ &ui_server10, "server10", "", CVAR_ARCHIVE },
;6800:	{ &ui_server11, "server11", "", CVAR_ARCHIVE },
;6801:	{ &ui_server12, "server12", "", CVAR_ARCHIVE },
;6802:	{ &ui_server13, "server13", "", CVAR_ARCHIVE },
;6803:	{ &ui_server14, "server14", "", CVAR_ARCHIVE },
;6804:	{ &ui_server15, "server15", "", CVAR_ARCHIVE },
;6805:	{ &ui_server16, "server16", "", CVAR_ARCHIVE },
;6806:	{ &ui_cdkeychecked, "ui_cdkeychecked", "0", CVAR_ROM },
;6807:	{ &ui_debug, "ui_debug", "0", CVAR_TEMP },
;6808:	{ &ui_initialized, "ui_initialized", "0", CVAR_TEMP },
;6809:	{ &ui_teamName, "ui_teamName", "Empire", CVAR_ARCHIVE },
;6810:	{ &ui_opponentName, "ui_opponentName", "Rebellion", CVAR_ARCHIVE },
;6811:	{ &ui_rankChange, "ui_rankChange", "0", CVAR_ARCHIVE },
;6812:	{ &ui_freeSaber, "ui_freeSaber", "0", CVAR_ARCHIVE },
;6813:	{ &ui_forcePowerDisable, "ui_forcePowerDisable", "0", CVAR_ARCHIVE },
;6814:	{ &ui_redteam, "ui_redteam", "Empire", CVAR_ARCHIVE },
;6815:	{ &ui_blueteam, "ui_blueteam", "Rebellion", CVAR_ARCHIVE },
;6816:	{ &ui_dedicated, "ui_dedicated", "0", CVAR_ARCHIVE },
;6817:	{ &ui_gameType, "ui_gametype", "0", CVAR_ARCHIVE },
;6818:	{ &ui_joinGameType, "ui_joinGametype", "0", CVAR_ARCHIVE },
;6819:	{ &ui_netGameType, "ui_netGametype", "0", CVAR_ARCHIVE },
;6820:	{ &ui_actualNetGameType, "ui_actualNetGametype", "3", CVAR_ARCHIVE },
;6821:	{ &ui_redteam1, "ui_redteam1", "1", CVAR_ARCHIVE }, //rww - these used to all default to 0 (closed).. I changed them to 1 (human)
;6822:	{ &ui_redteam2, "ui_redteam2", "1", CVAR_ARCHIVE },
;6823:	{ &ui_redteam3, "ui_redteam3", "1", CVAR_ARCHIVE },
;6824:	{ &ui_redteam4, "ui_redteam4", "1", CVAR_ARCHIVE },
;6825:	{ &ui_redteam5, "ui_redteam5", "1", CVAR_ARCHIVE },
;6826:	{ &ui_redteam6, "ui_redteam6", "1", CVAR_ARCHIVE },
;6827:	{ &ui_redteam7, "ui_redteam7", "1", CVAR_ARCHIVE },
;6828:	{ &ui_redteam8, "ui_redteam8", "1", CVAR_ARCHIVE },
;6829:	{ &ui_blueteam1, "ui_blueteam1", "1", CVAR_ARCHIVE },
;6830:	{ &ui_blueteam2, "ui_blueteam2", "1", CVAR_ARCHIVE },
;6831:	{ &ui_blueteam3, "ui_blueteam3", "1", CVAR_ARCHIVE },
;6832:	{ &ui_blueteam4, "ui_blueteam4", "1", CVAR_ARCHIVE },
;6833:	{ &ui_blueteam5, "ui_blueteam5", "1", CVAR_ARCHIVE },
;6834:	{ &ui_blueteam6, "ui_blueteam6", "1", CVAR_ARCHIVE },
;6835:	{ &ui_blueteam7, "ui_blueteam7", "1", CVAR_ARCHIVE },
;6836:	{ &ui_blueteam8, "ui_blueteam8", "1", CVAR_ARCHIVE },
;6837:	{ &ui_netSource, "ui_netSource", "0", CVAR_ARCHIVE },
;6838:	{ &ui_menuFiles, "ui_menuFilesMP", "ui/jk2mpmenus.txt", CVAR_ARCHIVE },
;6839:	{ &ui_currentTier, "ui_currentTier", "0", CVAR_ARCHIVE },
;6840:	{ &ui_currentMap, "ui_currentMap", "0", CVAR_ARCHIVE },
;6841:	{ &ui_currentNetMap, "ui_currentNetMap", "0", CVAR_ARCHIVE },
;6842:	{ &ui_mapIndex, "ui_mapIndex", "0", CVAR_ARCHIVE },
;6843:	{ &ui_currentOpponent, "ui_currentOpponent", "0", CVAR_ARCHIVE },
;6844:	{ &ui_selectedPlayer, "cg_selectedPlayer", "0", CVAR_ARCHIVE},
;6845:	{ &ui_selectedPlayerName, "cg_selectedPlayerName", "", CVAR_ARCHIVE},
;6846:	{ &ui_lastServerRefresh_0, "ui_lastServerRefresh_0", "", CVAR_ARCHIVE},
;6847:	{ &ui_lastServerRefresh_1, "ui_lastServerRefresh_1", "", CVAR_ARCHIVE},
;6848:	{ &ui_lastServerRefresh_2, "ui_lastServerRefresh_2", "", CVAR_ARCHIVE},
;6849:	{ &ui_lastServerRefresh_3, "ui_lastServerRefresh_3", "", CVAR_ARCHIVE},
;6850:	{ &ui_singlePlayerActive, "ui_singlePlayerActive", "0", 0},
;6851:	{ &ui_scoreAccuracy, "ui_scoreAccuracy", "0", CVAR_ARCHIVE},
;6852:	{ &ui_scoreImpressives, "ui_scoreImpressives", "0", CVAR_ARCHIVE},
;6853:	{ &ui_scoreExcellents, "ui_scoreExcellents", "0", CVAR_ARCHIVE},
;6854:	{ &ui_scoreCaptures, "ui_scoreCaptures", "0", CVAR_ARCHIVE},
;6855:	{ &ui_scoreDefends, "ui_scoreDefends", "0", CVAR_ARCHIVE},
;6856:	{ &ui_scoreAssists, "ui_scoreAssists", "0", CVAR_ARCHIVE},
;6857:	{ &ui_scoreGauntlets, "ui_scoreGauntlets", "0",CVAR_ARCHIVE},
;6858:	{ &ui_scoreScore, "ui_scoreScore", "0", CVAR_ARCHIVE},
;6859:	{ &ui_scorePerfect, "ui_scorePerfect", "0", CVAR_ARCHIVE},
;6860:	{ &ui_scoreTeam, "ui_scoreTeam", "0 to 0", CVAR_ARCHIVE},
;6861:	{ &ui_scoreBase, "ui_scoreBase", "0", CVAR_ARCHIVE},
;6862:	{ &ui_scoreTime, "ui_scoreTime", "00:00", CVAR_ARCHIVE},
;6863:	{ &ui_scoreTimeBonus, "ui_scoreTimeBonus", "0", CVAR_ARCHIVE},
;6864:	{ &ui_scoreSkillBonus, "ui_scoreSkillBonus", "0", CVAR_ARCHIVE},
;6865:	{ &ui_scoreShutoutBonus, "ui_scoreShutoutBonus", "0", CVAR_ARCHIVE},
;6866:	{ &ui_fragLimit, "ui_fragLimit", "10", 0},
;6867:	{ &ui_captureLimit, "ui_captureLimit", "5", 0},
;6868:	{ &ui_smallFont, "ui_smallFont", "0.25", CVAR_ARCHIVE},
;6869:	{ &ui_bigFont, "ui_bigFont", "0.4", CVAR_ARCHIVE},
;6870:	{ &ui_findPlayer, "ui_findPlayer", "Kyle", CVAR_ARCHIVE},
;6871:	{ &ui_Q3Model, "ui_q3model", "0", CVAR_ARCHIVE},
;6872:	{ &ui_recordSPDemo, "ui_recordSPDemo", "0", CVAR_ARCHIVE},
;6873:	{ &ui_realWarmUp, "g_warmup", "20", CVAR_ARCHIVE},
;6874:	{ &ui_realCaptureLimit, "capturelimit", "8", CVAR_SERVERINFO | CVAR_ARCHIVE | CVAR_NORESTART},
;6875:	{ &ui_serverStatusTimeOut, "ui_serverStatusTimeOut", "7000", CVAR_ARCHIVE},
;6876:	{ &s_language, "s_language", "english", CVAR_ARCHIVE | CVAR_NORESTART},
;6877:	{ &k_language, "k_language", "english", CVAR_ARCHIVE | CVAR_NORESTART},	// any default ("" or "american") is fine, only foreign strings ("deutsch" etc) make a different keyboard table get looked at
;6878:};
;6879:
;6880:// bk001129 - made static to avoid aliasing
;6881:static int		cvarTableSize = sizeof(cvarTable) / sizeof(cvarTable[0]);
;6882:
;6883:
;6884:/*
;6885:=================
;6886:UI_RegisterCvars
;6887:=================
;6888:*/
;6889:void UI_RegisterCvars( void ) {
line 6893
;6890:	int			i;
;6891:	cvarTable_t	*cv;
;6892:
;6893:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4691
JUMPV
LABELV $4688
line 6894
;6894:		trap_Cvar_Register( cv->vmCvar, cv->cvarName, cv->defaultString, cv->cvarFlags );
ADDRLP4 0
INDIRP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 6895
;6895:	}
LABELV $4689
line 6893
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4691
ADDRLP4 4
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4688
line 6896
;6896:}
LABELV $4687
endproc UI_RegisterCvars 12 16
export UI_UpdateCvars
proc UI_UpdateCvars 8 4
line 6903
;6897:
;6898:/*
;6899:=================
;6900:UI_UpdateCvars
;6901:=================
;6902:*/
;6903:void UI_UpdateCvars( void ) {
line 6907
;6904:	int			i;
;6905:	cvarTable_t	*cv;
;6906:
;6907:	for ( i = 0, cv = cvarTable ; i < cvarTableSize ; i++, cv++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRLP4 4
ADDRGP4 cvarTable
ASGNP4
ADDRGP4 $4696
JUMPV
LABELV $4693
line 6908
;6908:		trap_Cvar_Update( cv->vmCvar );
ADDRLP4 4
INDIRP4
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 6909
;6909:	}
LABELV $4694
line 6907
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
LABELV $4696
ADDRLP4 0
INDIRI4
ADDRGP4 cvarTableSize
INDIRI4
LTI4 $4693
line 6910
;6910:}
LABELV $4692
endproc UI_UpdateCvars 8 4
proc UI_StopServerRefresh 12 12
line 6919
;6911:
;6912:
;6913:/*
;6914:=================
;6915:ArenaServers_StopRefresh
;6916:=================
;6917:*/
;6918:static void UI_StopServerRefresh( void )
;6919:{
line 6922
;6920:	int count;
;6921:
;6922:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+40604+2212
INDIRI4
CNSTI4 0
NEI4 $4698
line 6924
;6923:		// not currently refreshing
;6924:		return;
ADDRGP4 $4697
JUMPV
LABELV $4698
line 6926
;6925:	}
;6926:	uiInfo.serverStatus.refreshActive = qfalse;
ADDRGP4 uiInfo+40604+2212
CNSTI4 0
ASGNI4
line 6927
;6927:	Com_Printf("%d servers listed in browser with %d players.\n",
ADDRGP4 $4704
ARGP4
ADDRGP4 uiInfo+40604+10412
INDIRI4
ARGI4
ADDRGP4 uiInfo+40604+10416
INDIRI4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6930
;6928:					uiInfo.serverStatus.numDisplayServers,
;6929:					uiInfo.serverStatus.numPlayersOnServers);
;6930:	count = trap_LAN_GetServerCount(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 6931
;6931:	if (count - uiInfo.serverStatus.numDisplayServers > 0) {
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
SUBI4
CNSTI4 0
LEI4 $4710
line 6932
;6932:		Com_Printf("%d servers not listed due to packet loss or pings higher than %d\n",
ADDRGP4 $4717
ARGP4
ADDRLP4 8
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4714
ARGP4
ADDRLP4 0
INDIRI4
ADDRGP4 uiInfo+40604+10412
INDIRI4
SUBI4
ARGI4
ADDRLP4 8
INDIRF4
CVFI4 4
ARGI4
ADDRGP4 Com_Printf
CALLV
pop
line 6935
;6933:						count - uiInfo.serverStatus.numDisplayServers,
;6934:						(int) trap_Cvar_VariableValue("cl_maxPing"));
;6935:	}
LABELV $4710
line 6937
;6936:
;6937:}
LABELV $4697
endproc UI_StopServerRefresh 12 12
proc UI_DoServerRefresh 8 4
line 6946
;6938:
;6939:
;6940:/*
;6941:=================
;6942:UI_DoServerRefresh
;6943:=================
;6944:*/
;6945:static void UI_DoServerRefresh( void )
;6946:{
line 6947
;6947:	qboolean wait = qfalse;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 6949
;6948:
;6949:	if (!uiInfo.serverStatus.refreshActive) {
ADDRGP4 uiInfo+40604+2212
INDIRI4
CNSTI4 0
NEI4 $4719
line 6950
;6950:		return;
ADDRGP4 $4718
JUMPV
LABELV $4719
line 6952
;6951:	}
;6952:	if (ui_netSource.integer != AS_FAVORITES) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 2
EQI4 $4723
line 6953
;6953:		if (ui_netSource.integer == AS_LOCAL) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4726
line 6954
;6954:			if (!trap_LAN_GetServerCount(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
NEI4 $4727
line 6955
;6955:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 6956
;6956:			}
line 6957
;6957:		} else {
ADDRGP4 $4727
JUMPV
LABELV $4726
line 6958
;6958:			if (trap_LAN_GetServerCount(ui_netSource.integer) < 0) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_GetServerCount
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
GEI4 $4732
line 6959
;6959:				wait = qtrue;
ADDRLP4 0
CNSTI4 1
ASGNI4
line 6960
;6960:			}
LABELV $4732
line 6961
;6961:		}
LABELV $4727
line 6962
;6962:	}
LABELV $4723
line 6964
;6963:
;6964:	if (uiInfo.uiDC.realTime < uiInfo.serverStatus.refreshtime) {
ADDRGP4 uiInfo+232
INDIRI4
ADDRGP4 uiInfo+40604+2192
INDIRI4
GEI4 $4735
line 6965
;6965:		if (wait) {
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $4740
line 6966
;6966:			return;
ADDRGP4 $4718
JUMPV
LABELV $4740
line 6968
;6967:		}
;6968:	}
LABELV $4735
line 6971
;6969:
;6970:	// if still trying to retrieve pings
;6971:	if (trap_LAN_UpdateVisiblePings(ui_netSource.integer)) {
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_LAN_UpdateVisiblePings
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $4742
line 6972
;6972:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+40604+2192
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 6973
;6973:	} else if (!wait) {
ADDRGP4 $4743
JUMPV
LABELV $4742
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $4748
line 6975
;6974:		// get the last servers in the list
;6975:		UI_BuildServerDisplayList(2);
CNSTI4 2
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 6977
;6976:		// stop the refresh
;6977:		UI_StopServerRefresh();
ADDRGP4 UI_StopServerRefresh
CALLV
pop
line 6978
;6978:	}
LABELV $4748
LABELV $4743
line 6980
;6979:	//
;6980:	UI_BuildServerDisplayList(qfalse);
CNSTI4 0
ARGI4
ADDRGP4 UI_BuildServerDisplayList
CALLV
pop
line 6981
;6981:}
LABELV $4718
endproc UI_DoServerRefresh 8 4
proc UI_StartServerRefresh 68 24
line 6989
;6982:
;6983:/*
;6984:=================
;6985:UI_StartServerRefresh
;6986:=================
;6987:*/
;6988:static void UI_StartServerRefresh(qboolean full)
;6989:{
line 6994
;6990:	int		i;
;6991:	char	*ptr;
;6992:
;6993:	qtime_t q;
;6994:	trap_RealTime(&q);
ADDRLP4 0
ARGP4
ADDRGP4 trap_RealTime
CALLI4
pop
line 6995
;6995: 	trap_Cvar_Set( va("ui_lastServerRefresh_%i", ui_netSource.integer), va("%s-%i, %i at %i:%i", MonthAbbrev[q.tm_mon],q.tm_mday, 1900+q.tm_year,q.tm_hour,q.tm_min));
ADDRGP4 $1380
ARGP4
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 va
CALLP4
ASGNP4
ADDRGP4 $4752
ARGP4
ADDRLP4 0+16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 MonthAbbrev
ADDP4
INDIRP4
ARGP4
ADDRLP4 0+12
INDIRI4
ARGI4
ADDRLP4 0+20
INDIRI4
CNSTI4 1900
ADDI4
ARGI4
ADDRLP4 0+8
INDIRI4
ARGI4
ADDRLP4 0+4
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 va
CALLP4
ASGNP4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
INDIRP4
ARGP4
ADDRGP4 trap_Cvar_Set
CALLV
pop
line 6997
;6996:
;6997:	if (!full) {
ADDRFP4 0
INDIRI4
CNSTI4 0
NEI4 $4758
line 6998
;6998:		UI_UpdatePendingPings();
ADDRGP4 UI_UpdatePendingPings
CALLV
pop
line 6999
;6999:		return;
ADDRGP4 $4750
JUMPV
LABELV $4758
line 7002
;7000:	}
;7001:
;7002:	uiInfo.serverStatus.refreshActive = qtrue;
ADDRGP4 uiInfo+40604+2212
CNSTI4 1
ASGNI4
line 7003
;7003:	uiInfo.serverStatus.nextDisplayRefresh = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+40604+10420
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 7005
;7004:	// clear number of displayed servers
;7005:	uiInfo.serverStatus.numDisplayServers = 0;
ADDRGP4 uiInfo+40604+10412
CNSTI4 0
ASGNI4
line 7006
;7006:	uiInfo.serverStatus.numPlayersOnServers = 0;
ADDRGP4 uiInfo+40604+10416
CNSTI4 0
ASGNI4
line 7008
;7007:	// mark all servers as visible so we store ping updates for them
;7008:	trap_LAN_MarkServerVisible(ui_netSource.integer, -1, qtrue);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_LAN_MarkServerVisible
CALLV
pop
line 7010
;7009:	// reset all the pings
;7010:	trap_LAN_ResetPings(ui_netSource.integer);
ADDRGP4 ui_netSource+12
INDIRI4
ARGI4
ADDRGP4 trap_LAN_ResetPings
CALLV
pop
line 7012
;7011:	//
;7012:	if( ui_netSource.integer == AS_LOCAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 0
NEI4 $4771
line 7013
;7013:		trap_Cmd_ExecuteText( EXEC_NOW, "localservers\n" );
CNSTI4 0
ARGI4
ADDRGP4 $4774
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 7014
;7014:		uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 1000;
ADDRGP4 uiInfo+40604+2192
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 7015
;7015:		return;
ADDRGP4 $4750
JUMPV
LABELV $4771
line 7018
;7016:	}
;7017:
;7018:	uiInfo.serverStatus.refreshtime = uiInfo.uiDC.realTime + 5000;
ADDRGP4 uiInfo+40604+2192
ADDRGP4 uiInfo+232
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 7019
;7019:	if( ui_netSource.integer == AS_GLOBAL || ui_netSource.integer == AS_MPLAYER ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
EQI4 $4785
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 3
NEI4 $4781
LABELV $4785
line 7020
;7020:		if( ui_netSource.integer == AS_GLOBAL ) {
ADDRGP4 ui_netSource+12
INDIRI4
CNSTI4 1
NEI4 $4786
line 7021
;7021:			i = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 7022
;7022:		}
ADDRGP4 $4787
JUMPV
LABELV $4786
line 7023
;7023:		else {
line 7024
;7024:			i = 1;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 7025
;7025:		}
LABELV $4787
line 7027
;7026:
;7027:		ptr = UI_Cvar_VariableString("debug_protocol");
ADDRGP4 $4411
ARGP4
ADDRLP4 52
ADDRGP4 UI_Cvar_VariableString
CALLP4
ASGNP4
ADDRLP4 36
ADDRLP4 52
INDIRP4
ASGNP4
line 7028
;7028:		if (strlen(ptr)) {
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 strlen
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $4789
line 7029
;7029:			trap_Cmd_ExecuteText( EXEC_NOW, va( "globalservers %d %s full empty\n", i, ptr));
ADDRGP4 $4791
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 60
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 7030
;7030:		}
ADDRGP4 $4790
JUMPV
LABELV $4789
line 7031
;7031:		else {
line 7032
;7032:			trap_Cmd_ExecuteText( EXEC_NOW, va( "globalservers %d %d full empty\n", i, (int)trap_Cvar_VariableValue( "protocol" ) ) );
ADDRGP4 $2242
ARGP4
ADDRLP4 60
ADDRGP4 trap_Cvar_VariableValue
CALLF4
ASGNF4
ADDRGP4 $4792
ARGP4
ADDRLP4 40
INDIRI4
ARGI4
ADDRLP4 60
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 64
ADDRGP4 va
CALLP4
ASGNP4
CNSTI4 0
ARGI4
ADDRLP4 64
INDIRP4
ARGP4
ADDRGP4 trap_Cmd_ExecuteText
CALLV
pop
line 7033
;7033:		}
LABELV $4790
line 7034
;7034:	}
LABELV $4781
line 7035
;7035:}
LABELV $4750
endproc UI_StartServerRefresh 68 24
bss
export k_language
align 4
LABELV k_language
skip 272
export s_language
align 4
LABELV s_language
skip 272
export ui_realWarmUp
align 4
LABELV ui_realWarmUp
skip 272
export ui_realCaptureLimit
align 4
LABELV ui_realCaptureLimit
skip 272
export ui_recordSPDemo
align 4
LABELV ui_recordSPDemo
skip 272
export ui_hudFiles
align 4
LABELV ui_hudFiles
skip 272
export ui_Q3Model
align 4
LABELV ui_Q3Model
skip 272
export ui_findPlayer
align 4
LABELV ui_findPlayer
skip 272
export ui_scoreCaptures
align 4
LABELV ui_scoreCaptures
skip 272
export ui_teamName
align 4
LABELV ui_teamName
skip 272
export ui_blueteam8
align 4
LABELV ui_blueteam8
skip 272
export ui_blueteam7
align 4
LABELV ui_blueteam7
skip 272
export ui_blueteam6
align 4
LABELV ui_blueteam6
skip 272
export ui_blueteam5
align 4
LABELV ui_blueteam5
skip 272
export ui_blueteam4
align 4
LABELV ui_blueteam4
skip 272
export ui_blueteam3
align 4
LABELV ui_blueteam3
skip 272
export ui_blueteam2
align 4
LABELV ui_blueteam2
skip 272
export ui_blueteam1
align 4
LABELV ui_blueteam1
skip 272
export ui_blueteam
align 4
LABELV ui_blueteam
skip 272
export ui_redteam8
align 4
LABELV ui_redteam8
skip 272
export ui_redteam7
align 4
LABELV ui_redteam7
skip 272
export ui_redteam6
align 4
LABELV ui_redteam6
skip 272
export ui_redteam5
align 4
LABELV ui_redteam5
skip 272
export ui_redteam4
align 4
LABELV ui_redteam4
skip 272
export ui_redteam3
align 4
LABELV ui_redteam3
skip 272
export ui_redteam2
align 4
LABELV ui_redteam2
skip 272
export ui_redteam1
align 4
LABELV ui_redteam1
skip 272
export ui_redteam
align 4
LABELV ui_redteam
skip 272
align 1
LABELV lastLoadingText
skip 1024
align 4
LABELV lastConnState
skip 4
import FPMessageTime
export parsedFPMessage
align 1
LABELV parsedFPMessage
skip 1024
export ui_rankChange
align 4
LABELV ui_rankChange
skip 272
export startTime
align 4
LABELV startTime
skip 4
export ui_initialized
align 4
LABELV ui_initialized
skip 272
export ui_debug
align 4
LABELV ui_debug
skip 272
import ProcessNewUI
import UpdateForceUsed
import Menu_ShowItemByName
import UI_ForceConfigHandle
import UI_ForcePowerRank_HandleKey
import UI_ForceMaxRank_HandleKey
import UI_ForceSide_HandleKey
import UI_SkinColor_HandleKey
import UI_UpdateForcePowers
import UI_SaveForceTemplate
import UI_UpdateClientForcePowers
import UI_DrawForceStars
import UI_DrawTotalForceStars
import UI_ReadLegalForce
import UI_InitForceShaders
import ui_forcePowerDisable
import ui_freeSaber
import uiSaberColorShaders
import uiForcePowerDarkLight
import uiForcePowersRank
import gTouchedForce
import uiForceAvailable
import uiForceUsed
import uiMaxRank
import uiForceRank
import uiForceSide
import UI_RankStatusMenu
import RankStatus_Cache
import UI_SignupMenu
import Signup_Cache
import UI_LoginMenu
import Login_Cache
import UI_InitGameinfo
import UI_SPUnlockMedals_f
import UI_SPUnlock_f
import UI_GetAwardLevel
import UI_LogAwardData
import UI_NewGame
import UI_GetCurrentGame
import UI_CanShowTierVideo
import UI_ShowTierVideo
import UI_TierCompleted
import UI_SetBestScore
import UI_GetBestScore
import UI_GetBotNameByNumber
import UI_LoadBots
import UI_GetNumBots
import UI_GetBotInfoByName
import UI_GetBotInfoByNumber
import UI_GetNumSPTiers
import UI_GetNumSPArenas
import UI_GetNumArenas
import UI_GetSpecialArenaInfo
import UI_GetArenaInfoByMap
import UI_GetArenaInfoByNumber
import UI_NetworkOptionsMenu
import UI_NetworkOptionsMenu_Cache
import UI_SoundOptionsMenu
import UI_SoundOptionsMenu_Cache
import UI_DisplayOptionsMenu
import UI_DisplayOptionsMenu_Cache
import UI_SaveConfigMenu
import UI_SaveConfigMenu_Cache
import UI_LoadConfigMenu
import UI_LoadConfig_Cache
import UI_TeamOrdersMenu_Cache
import UI_TeamOrdersMenu_f
import UI_TeamOrdersMenu
import UI_RemoveBotsMenu
import UI_RemoveBots_Cache
import UI_AddBotsMenu
import UI_AddBots_Cache
import trap_G2API_SetBoneAngles
import trap_R_RemapShader
import trap_RealTime
import trap_CIN_SetExtents
import trap_CIN_DrawCinematic
import trap_CIN_RunCinematic
import trap_CIN_StopCinematic
import trap_CIN_PlayCinematic
import trap_S_StartBackgroundTrack
import trap_S_StopBackgroundTrack
import trap_AnyLanguage_ReadCharFromString
import trap_R_Font_DrawString
import trap_R_Font_HeightPixels
import trap_R_Font_StrLenChars
import trap_R_Font_StrLenPixels
import trap_R_RegisterFont
import trap_MemoryRemaining
import trap_LAN_CompareServers
import trap_LAN_ServerStatus
import trap_LAN_ResetPings
import trap_LAN_RemoveServer
import trap_LAN_AddServer
import trap_LAN_UpdateVisiblePings
import trap_LAN_ServerIsVisible
import trap_LAN_MarkServerVisible
import trap_LAN_SaveCachedServers
import trap_LAN_LoadCachedServers
import trap_LAN_GetPingInfo
import trap_LAN_GetPing
import trap_LAN_ClearPing
import trap_LAN_GetPingQueueCount
import trap_LAN_GetServerPing
import trap_LAN_GetServerInfo
import trap_LAN_GetServerAddressString
import trap_LAN_GetServerCount
import trap_GetConfigString
import trap_GetGlconfig
import trap_GetClientState
import trap_GetClipboardData
import trap_Key_SetCatcher
import trap_Key_GetCatcher
import trap_Key_ClearStates
import trap_Key_SetOverstrikeMode
import trap_Key_GetOverstrikeMode
import trap_Key_IsDown
import trap_Key_SetBinding
import trap_Key_GetBindingBuf
import trap_Key_KeynumToStringBuf
import trap_S_RegisterSound
import trap_S_StartLocalSound
import trap_CM_LerpTag
import trap_UpdateScreen
import trap_R_ModelBounds
import trap_R_DrawStretchPic
import trap_R_SetColor
import trap_R_RenderScene
import trap_R_AddLightToScene
import trap_R_AddPolyToScene
import trap_R_AddRefEntityToScene
import trap_R_ClearScene
import trap_R_RegisterShaderNoMip
import trap_R_RegisterSkin
import trap_R_RegisterModel
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Cmd_ExecuteText
import trap_Argv
import trap_Argc
import trap_Cvar_InfoStringBuffer
import trap_Cvar_Create
import trap_Cvar_Reset
import trap_Cvar_SetValue
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_Milliseconds
import trap_Error
import trap_Print
import UI_SPSkillMenu_Cache
import UI_SPSkillMenu
import UI_SPPostgameMenu_f
import UI_SPPostgameMenu_Cache
import UI_SPArena_Start
import UI_SPLevelMenu_ReInit
import UI_SPLevelMenu_f
import UI_SPLevelMenu
import UI_SPLevelMenu_Cache
import uis
import UI_LoadBestScores
import m_entersound
import UI_StartDemoLoop
import UI_Cvar_VariableString
import UI_Argv
import UI_ForceMenuOff
import UI_PopMenu
import UI_PushMenu
import UI_SetActiveMenu
import UI_IsFullscreen
import UI_DrawTextBox
import UI_CursorInRect
import UI_DrawChar
import UI_DrawString
import UI_ProportionalStringWidth
import UI_DrawProportionalString
import UI_ProportionalSizeScale
import UI_DrawBannerString
import UI_LerpColor
import UI_SetColor
import UI_UpdateScreen
import UI_DrawSides
import UI_DrawTopBottom
import UI_DrawRect
import UI_FillRect
import UI_DrawHandlePic
import UI_DrawNamedPic
import UI_ClampCvar
import UI_ConsoleCommand
import UI_Refresh
import UI_MouseEvent
import UI_KeyEvent
import UI_Shutdown
import UI_Init
export uiInfo
align 4
LABELV uiInfo
skip 95068
import DriverInfo_Cache
import GraphicsOptions_Cache
import UI_GraphicsOptionsMenu
import ServerInfo_Cache
import UI_ServerInfoMenu
import UI_BotSelectMenu_Cache
import UI_BotSelectMenu
import ServerOptions_Cache
import StartServer_Cache
import UI_StartServerMenu
import ArenaServers_Cache
import UI_ArenaServersMenu
import SpecifyServer_Cache
import UI_SpecifyServerMenu
import SpecifyLeague_Cache
import UI_SpecifyLeagueMenu
import Preferences_Cache
import UI_PreferencesMenu
import PlayerSettings_Cache
import UI_PlayerSettingsMenu
import PlayerModel_Cache
import UI_PlayerModelMenu
import UI_CDKeyMenu_f
import UI_CDKeyMenu_Cache
import UI_CDKeyMenu
import UI_ModsMenu_Cache
import UI_ModsMenu
import UI_CinematicsMenu_Cache
import UI_CinematicsMenu_f
import UI_CinematicsMenu
import Demos_Cache
import UI_DemosMenu
import Controls_Cache
import UI_ControlsMenu
import TeamMain_Cache
import UI_TeamMainMenu
import UI_SetupMenu
import UI_SetupMenu_Cache
import UI_ConfirmMenu
import ConfirmMenu_Cache
import UI_InGameMenu
import InGame_Cache
import UI_CreditMenu
import UI_MainMenu
import MainMenu_Cache
import UI_LoadArenas
import UI_ClearScores
import UI_AdjustTimeByGame
import MenuField_Key
import MenuField_Draw
import MenuField_Init
import MField_Draw
import MField_CharEvent
import MField_KeyDownEvent
import MField_Clear
import ui_medalSounds
import ui_medalPicNames
import ui_medalNames
import text_color_highlight
import text_color_normal
import text_color_disabled
import listbar_color
import list_color
import name_color
import color_dim
import color_red
import color_orange
import color_blue
import color_yellow
import color_white
import color_black
import menu_dim_color
import menu_black_color
import menu_red_color
import menu_highlight_color
import menu_dark_color
import menu_grayed_color
import menu_text_color
import weaponChangeSound
import menu_null_sound
import menu_buzz_sound
import menu_out_sound
import menu_move_sound
import menu_in_sound
import ScrollList_Key
import ScrollList_Draw
import Bitmap_Draw
import Bitmap_Init
import Menu_DefaultKey
import Menu_SetCursorToItem
import Menu_SetCursor
import Menu_ActivateItem
import Menu_ItemAtCursor
import Menu_Draw
import Menu_AdjustCursor
import Menu_AddItem
import Menu_Focus
import Menu_Cache
export ui_serverStatusTimeOut
align 4
LABELV ui_serverStatusTimeOut
skip 272
export ui_bigFont
align 4
LABELV ui_bigFont
skip 272
export ui_smallFont
align 4
LABELV ui_smallFont
skip 272
export ui_scoreTime
align 4
LABELV ui_scoreTime
skip 272
export ui_scoreShutoutBonus
align 4
LABELV ui_scoreShutoutBonus
skip 272
export ui_scoreSkillBonus
align 4
LABELV ui_scoreSkillBonus
skip 272
export ui_scoreTimeBonus
align 4
LABELV ui_scoreTimeBonus
skip 272
export ui_scoreBase
align 4
LABELV ui_scoreBase
skip 272
export ui_scoreTeam
align 4
LABELV ui_scoreTeam
skip 272
export ui_scorePerfect
align 4
LABELV ui_scorePerfect
skip 272
export ui_scoreScore
align 4
LABELV ui_scoreScore
skip 272
export ui_scoreGauntlets
align 4
LABELV ui_scoreGauntlets
skip 272
export ui_scoreAssists
align 4
LABELV ui_scoreAssists
skip 272
export ui_scoreDefends
align 4
LABELV ui_scoreDefends
skip 272
export ui_scoreExcellents
align 4
LABELV ui_scoreExcellents
skip 272
export ui_scoreImpressives
align 4
LABELV ui_scoreImpressives
skip 272
export ui_scoreAccuracy
align 4
LABELV ui_scoreAccuracy
skip 272
export ui_singlePlayerActive
align 4
LABELV ui_singlePlayerActive
skip 272
export ui_lastServerRefresh_3
align 4
LABELV ui_lastServerRefresh_3
skip 272
export ui_lastServerRefresh_2
align 4
LABELV ui_lastServerRefresh_2
skip 272
export ui_lastServerRefresh_1
align 4
LABELV ui_lastServerRefresh_1
skip 272
export ui_lastServerRefresh_0
align 4
LABELV ui_lastServerRefresh_0
skip 272
export ui_selectedPlayerName
align 4
LABELV ui_selectedPlayerName
skip 272
export ui_selectedPlayer
align 4
LABELV ui_selectedPlayer
skip 272
export ui_currentOpponent
align 4
LABELV ui_currentOpponent
skip 272
export ui_mapIndex
align 4
LABELV ui_mapIndex
skip 272
export ui_currentNetMap
align 4
LABELV ui_currentNetMap
skip 272
export ui_currentMap
align 4
LABELV ui_currentMap
skip 272
export ui_currentTier
align 4
LABELV ui_currentTier
skip 272
export ui_menuFiles
align 4
LABELV ui_menuFiles
skip 272
export ui_opponentName
align 4
LABELV ui_opponentName
skip 272
export ui_dedicated
align 4
LABELV ui_dedicated
skip 272
export ui_serverFilterType
align 4
LABELV ui_serverFilterType
skip 272
export ui_netSource
align 4
LABELV ui_netSource
skip 272
export ui_joinGameType
align 4
LABELV ui_joinGameType
skip 272
export ui_actualNetGameType
align 4
LABELV ui_actualNetGameType
skip 272
export ui_netGameType
align 4
LABELV ui_netGameType
skip 272
export ui_gameType
align 4
LABELV ui_gameType
skip 272
export ui_fragLimit
align 4
LABELV ui_fragLimit
skip 272
export ui_captureLimit
align 4
LABELV ui_captureLimit
skip 272
export ui_cdkeychecked
align 4
LABELV ui_cdkeychecked
skip 272
import ui_cdkey
export ui_server16
align 4
LABELV ui_server16
skip 272
export ui_server15
align 4
LABELV ui_server15
skip 272
export ui_server14
align 4
LABELV ui_server14
skip 272
export ui_server13
align 4
LABELV ui_server13
skip 272
export ui_server12
align 4
LABELV ui_server12
skip 272
export ui_server11
align 4
LABELV ui_server11
skip 272
export ui_server10
align 4
LABELV ui_server10
skip 272
export ui_server9
align 4
LABELV ui_server9
skip 272
export ui_server8
align 4
LABELV ui_server8
skip 272
export ui_server7
align 4
LABELV ui_server7
skip 272
export ui_server6
align 4
LABELV ui_server6
skip 272
export ui_server5
align 4
LABELV ui_server5
skip 272
export ui_server4
align 4
LABELV ui_server4
skip 272
export ui_server3
align 4
LABELV ui_server3
skip 272
export ui_server2
align 4
LABELV ui_server2
skip 272
export ui_server1
align 4
LABELV ui_server1
skip 272
export ui_marks
align 4
LABELV ui_marks
skip 272
export ui_drawCrosshairNames
align 4
LABELV ui_drawCrosshairNames
skip 272
export ui_drawCrosshair
align 4
LABELV ui_drawCrosshair
skip 272
export ui_browserShowEmpty
align 4
LABELV ui_browserShowEmpty
skip 272
export ui_browserShowFull
align 4
LABELV ui_browserShowFull
skip 272
export ui_browserSortKey
align 4
LABELV ui_browserSortKey
skip 272
export ui_browserGameType
align 4
LABELV ui_browserGameType
skip 272
export ui_browserMaster
align 4
LABELV ui_browserMaster
skip 272
export ui_spSelection
align 4
LABELV ui_spSelection
skip 272
export ui_spSkill
align 4
LABELV ui_spSkill
skip 272
export ui_spVideos
align 4
LABELV ui_spVideos
skip 272
export ui_spAwards
align 4
LABELV ui_spAwards
skip 272
export ui_spScores5
align 4
LABELV ui_spScores5
skip 272
export ui_spScores4
align 4
LABELV ui_spScores4
skip 272
export ui_spScores3
align 4
LABELV ui_spScores3
skip 272
export ui_spScores2
align 4
LABELV ui_spScores2
skip 272
export ui_spScores1
align 4
LABELV ui_spScores1
skip 272
export ui_botsFile
align 4
LABELV ui_botsFile
skip 272
export ui_arenasFile
align 4
LABELV ui_arenasFile
skip 272
export ui_ctf_friendly
align 4
LABELV ui_ctf_friendly
skip 272
export ui_ctf_timelimit
align 4
LABELV ui_ctf_timelimit
skip 272
export ui_ctf_capturelimit
align 4
LABELV ui_ctf_capturelimit
skip 272
export ui_team_friendly
align 4
LABELV ui_team_friendly
skip 272
export ui_team_timelimit
align 4
LABELV ui_team_timelimit
skip 272
export ui_team_fraglimit
align 4
LABELV ui_team_fraglimit
skip 272
export ui_selectedModelIndex
align 4
LABELV ui_selectedModelIndex
skip 272
export ui_tourney_timelimit
align 4
LABELV ui_tourney_timelimit
skip 272
export ui_tourney_fraglimit
align 4
LABELV ui_tourney_fraglimit
skip 272
export ui_ffa_timelimit
align 4
LABELV ui_ffa_timelimit
skip 272
export ui_ffa_fraglimit
align 4
LABELV ui_ffa_fraglimit
skip 272
import trap_SP_GetStringTextString
import trap_SP_Register
import trap_SP_RegisterServer
import trap_PC_RemoveAllGlobalDefines
import trap_PC_LoadGlobalDefines
import trap_PC_SourceFileAndLine
import trap_PC_ReadToken
import trap_PC_FreeSource
import trap_PC_LoadSource
import trap_PC_AddGlobalDefine
import Controls_SetDefaults
import Controls_SetConfig
import Controls_GetConfig
import UI_OutOfMemory
import UI_InitMemory
import UI_Alloc
import Display_CacheAll
import Menu_SetFeederSelection
import Menu_Paint
import Menus_CloseAll
import LerpColor
import Display_HandleKey
import Menus_CloseByName
import Menus_ShowByName
import Menus_FindByName
import Menus_OpenByName
import Display_KeyBindPending
import Display_CursorType
import Display_MouseMove
import Display_CaptureItem
import Display_GetContext
import Menus_Activate
import Menus_AnyFullScreenVisible
import Menu_Reset
import Menus_ActivateByName
import Menu_PaintAll
import Menu_New
import Menu_Count
import PC_Script_Parse
import PC_String_Parse
import PC_Rect_Parse
import PC_Int_Parse
import PC_Color_Parse
import PC_Float_Parse
import Script_Parse
import String_Parse
import Rect_Parse
import Int_Parse
import Color_Parse
import Float_Parse
import Menu_ScrollFeeder
import Menu_HandleMouseMove
import Menu_HandleKey
import Menu_GetFocused
import Menu_PostParse
import Item_Init
import Menu_Init
import Display_ExpandMacros
import Init_Display
import String_Report
import String_Init
import String_Alloc
import forcePowerDarkLight
import WeaponAttackAnim
import WeaponReadyAnim
import BG_OutOfMemory
import BG_StringAlloc
import BG_TempFree
import BG_TempAlloc
import BG_AllocUnaligned
import BG_Alloc
import BG_CanUseFPNow
import BG_HasYsalamiri
import BG_GetItemIndexByTag
import BG_ParseAnimationFile
import BG_PlayerTouchesItem
import BG_G2PlayerAngles
import BG_PlayerStateToEntityStateExtraPolate
import BG_PlayerStateToEntityState
import BG_TouchJumpPad
import BG_AddPredictableEventToPlayerstate
import BG_EvaluateTrajectoryDelta
import BG_EvaluateTrajectory
import BG_ForcePowerDrain
import BG_SaberStartTransAnim
import BG_InDeathAnim
import BG_InRoll
import BG_SaberInSpecialAttack
import BG_SpinningSaberAnim
import BG_FlippingAnim
import BG_SaberInIdle
import BG_SaberInSpecial
import BG_SaberInAttack
import BG_DirectFlippingAnim
import BG_InSaberStandAnim
import BG_InSpecialJump
import BG_LegalizedForcePowers
import saberMoveData
import BG_CanItemBeGrabbed
import BG_FindItemForHoldable
import BG_FindItemForPowerup
import BG_FindItemForWeapon
import BG_FindItem
import vectoyaw
import bg_numItems
import bg_itemlist
import Pmove
import PM_UpdateViewAngles
import pm
import bgForcePowerCost
import forceMasteryPoints
import forceMasteryLevels
import bgGlobalAnimations
import BGPAFtextLoaded
import forcePowerSorted
import WP_MuzzlePoint
import ammoData
import weaponData
import GetStringForID
import GetIDForString
import Q_irand
import irand
import flrand
import Rand_Init
import Com_Printf
import Com_Error
import Info_NextPair
import Info_Validate
import Info_SetValueForKey_Big
import Info_SetValueForKey
import Info_RemoveKey_big
import Info_RemoveKey
import Info_ValueForKey
import va
import Q_CleanStr
import Q_PrintStrlen
import Q_strcat
import Q_strncpyz
import Q_strrchr
import Q_strupr
import Q_strlwr
import Q_stricmpn
import Q_strncmp
import Q_stricmp
import Q_isalpha
import Q_isupper
import Q_islower
import Q_isprint
import Com_sprintf
import Parse3DMatrix
import Parse2DMatrix
import Parse1DMatrix
import SkipRestOfLine
import SkipBracedSection
import COM_MatchToken
import COM_ParseWarning
import COM_ParseError
import COM_Compress
import COM_ParseExt
import COM_Parse
import SkipWhitespace
import COM_GetCurrentParseLine
import COM_BeginParseSession
import COM_DefaultExtension
import COM_StripExtension
import COM_SkipPath
import Com_Clamp
import PerpendicularVector
import AngleVectors
import MatrixMultiply
import MakeNormalVectors
import RotateAroundDirection
import RotatePointAroundVector
import ProjectPointOnPlane
import PlaneFromPoints
import AngleDelta
import AngleNormalize180
import AngleNormalize360
import AnglesSubtract
import AngleSubtract
import LerpAngle
import AngleMod
import BoxOnPlaneSide
import SetPlaneSignbits
import AxisCopy
import AxisClear
import AnglesToAxis
import vectoangles
import Q_crandom
import Q_random
import Q_rand
import Q_acos
import Q_log2
import VectorRotate
import Vector4Scale
import VectorNormalize2
import VectorNormalize
import CrossProduct
import VectorInverse
import VectorNormalizeFast
import DistanceSquared
import Distance
import VectorLengthSquared
import VectorLength
import VectorCompare
import AddPointToBounds
import ClearBounds
import RadiusFromBounds
import NormalizeColor
import ColorBytes4
import ColorBytes3
import _VectorMA
import _VectorScale
import _VectorCopy
import _VectorAdd
import _VectorSubtract
import _DotProduct
import ByteToDir
import DirToByte
import powf
import ClampShort
import ClampChar
import Q_rsqrt
import Q_fabs
import axisDefault
import vec3_origin
import g_color_table
import colorDkBlue
import colorLtBlue
import colorDkGrey
import colorMdGrey
import colorLtGrey
import colorWhite
import colorCyan
import colorMagenta
import colorYellow
import colorBlue
import colorGreen
import colorRed
import colorBlack
import colorTable
import bytedirs
import Com_Memcpy
import Com_Memset
import Hunk_Alloc
import forceSpeedLevels
import FloatSwap
import LongSwap
import ShortSwap
import acos
import fabs
import abs
import tan
import atan2
import cos
import sin
import sqrt
import floor
import ceil
import memcpy
import memset
import memmove
import sscanf
import vsprintf
import _atoi
import atoi
import _atof
import atof
import toupper
import tolower
import strncpy
import strstr
import strchr
import strcmp
import strcpy
import strcat
import strlen
import rand
import srand
import qsort
lit
align 1
LABELV $4792
char 1 103
char 1 108
char 1 111
char 1 98
char 1 97
char 1 108
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 32
char 1 37
char 1 100
char 1 32
char 1 37
char 1 100
char 1 32
char 1 102
char 1 117
char 1 108
char 1 108
char 1 32
char 1 101
char 1 109
char 1 112
char 1 116
char 1 121
char 1 10
char 1 0
align 1
LABELV $4791
char 1 103
char 1 108
char 1 111
char 1 98
char 1 97
char 1 108
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 32
char 1 37
char 1 100
char 1 32
char 1 37
char 1 115
char 1 32
char 1 102
char 1 117
char 1 108
char 1 108
char 1 32
char 1 101
char 1 109
char 1 112
char 1 116
char 1 121
char 1 10
char 1 0
align 1
LABELV $4774
char 1 108
char 1 111
char 1 99
char 1 97
char 1 108
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 10
char 1 0
align 1
LABELV $4752
char 1 37
char 1 115
char 1 45
char 1 37
char 1 105
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 97
char 1 116
char 1 32
char 1 37
char 1 105
char 1 58
char 1 37
char 1 105
char 1 0
align 1
LABELV $4717
char 1 99
char 1 108
char 1 95
char 1 109
char 1 97
char 1 120
char 1 80
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $4714
char 1 37
char 1 100
char 1 32
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 108
char 1 105
char 1 115
char 1 116
char 1 101
char 1 100
char 1 32
char 1 100
char 1 117
char 1 101
char 1 32
char 1 116
char 1 111
char 1 32
char 1 112
char 1 97
char 1 99
char 1 107
char 1 101
char 1 116
char 1 32
char 1 108
char 1 111
char 1 115
char 1 115
char 1 32
char 1 111
char 1 114
char 1 32
char 1 112
char 1 105
char 1 110
char 1 103
char 1 115
char 1 32
char 1 104
char 1 105
char 1 103
char 1 104
char 1 101
char 1 114
char 1 32
char 1 116
char 1 104
char 1 97
char 1 110
char 1 32
char 1 37
char 1 100
char 1 10
char 1 0
align 1
LABELV $4704
char 1 37
char 1 100
char 1 32
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 32
char 1 108
char 1 105
char 1 115
char 1 116
char 1 101
char 1 100
char 1 32
char 1 105
char 1 110
char 1 32
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 32
char 1 119
char 1 105
char 1 116
char 1 104
char 1 32
char 1 37
char 1 100
char 1 32
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 46
char 1 10
char 1 0
align 1
LABELV $4686
char 1 107
char 1 95
char 1 108
char 1 97
char 1 110
char 1 103
char 1 117
char 1 97
char 1 103
char 1 101
char 1 0
align 1
LABELV $4685
char 1 101
char 1 110
char 1 103
char 1 108
char 1 105
char 1 115
char 1 104
char 1 0
align 1
LABELV $4684
char 1 115
char 1 95
char 1 108
char 1 97
char 1 110
char 1 103
char 1 117
char 1 97
char 1 103
char 1 101
char 1 0
align 1
LABELV $4683
char 1 55
char 1 48
char 1 48
char 1 48
char 1 0
align 1
LABELV $4682
char 1 117
char 1 105
char 1 95
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 83
char 1 116
char 1 97
char 1 116
char 1 117
char 1 115
char 1 84
char 1 105
char 1 109
char 1 101
char 1 79
char 1 117
char 1 116
char 1 0
align 1
LABELV $4681
char 1 117
char 1 105
char 1 95
char 1 113
char 1 51
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $4680
char 1 48
char 1 46
char 1 52
char 1 0
align 1
LABELV $4679
char 1 117
char 1 105
char 1 95
char 1 98
char 1 105
char 1 103
char 1 70
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $4678
char 1 48
char 1 46
char 1 50
char 1 53
char 1 0
align 1
LABELV $4677
char 1 117
char 1 105
char 1 95
char 1 115
char 1 109
char 1 97
char 1 108
char 1 108
char 1 70
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $4676
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 83
char 1 104
char 1 117
char 1 116
char 1 111
char 1 117
char 1 116
char 1 66
char 1 111
char 1 110
char 1 117
char 1 115
char 1 0
align 1
LABELV $4675
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 83
char 1 107
char 1 105
char 1 108
char 1 108
char 1 66
char 1 111
char 1 110
char 1 117
char 1 115
char 1 0
align 1
LABELV $4674
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 84
char 1 105
char 1 109
char 1 101
char 1 66
char 1 111
char 1 110
char 1 117
char 1 115
char 1 0
align 1
LABELV $4673
char 1 48
char 1 48
char 1 58
char 1 48
char 1 48
char 1 0
align 1
LABELV $4672
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 84
char 1 105
char 1 109
char 1 101
char 1 0
align 1
LABELV $4671
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 66
char 1 97
char 1 115
char 1 101
char 1 0
align 1
LABELV $4670
char 1 48
char 1 32
char 1 116
char 1 111
char 1 32
char 1 48
char 1 0
align 1
LABELV $4669
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $4668
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 80
char 1 101
char 1 114
char 1 102
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $4667
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 0
align 1
LABELV $4666
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 71
char 1 97
char 1 117
char 1 110
char 1 116
char 1 108
char 1 101
char 1 116
char 1 115
char 1 0
align 1
LABELV $4665
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 65
char 1 115
char 1 115
char 1 105
char 1 115
char 1 116
char 1 115
char 1 0
align 1
LABELV $4664
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 68
char 1 101
char 1 102
char 1 101
char 1 110
char 1 100
char 1 115
char 1 0
align 1
LABELV $4663
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 67
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $4662
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 69
char 1 120
char 1 99
char 1 101
char 1 108
char 1 108
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $4661
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 73
char 1 109
char 1 112
char 1 114
char 1 101
char 1 115
char 1 115
char 1 105
char 1 118
char 1 101
char 1 115
char 1 0
align 1
LABELV $4660
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 65
char 1 99
char 1 99
char 1 117
char 1 114
char 1 97
char 1 99
char 1 121
char 1 0
align 1
LABELV $4659
char 1 117
char 1 105
char 1 95
char 1 108
char 1 97
char 1 115
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 95
char 1 51
char 1 0
align 1
LABELV $4658
char 1 117
char 1 105
char 1 95
char 1 108
char 1 97
char 1 115
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 95
char 1 50
char 1 0
align 1
LABELV $4657
char 1 117
char 1 105
char 1 95
char 1 108
char 1 97
char 1 115
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 95
char 1 49
char 1 0
align 1
LABELV $4656
char 1 117
char 1 105
char 1 95
char 1 108
char 1 97
char 1 115
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 95
char 1 48
char 1 0
align 1
LABELV $4655
char 1 117
char 1 105
char 1 95
char 1 99
char 1 117
char 1 114
char 1 114
char 1 101
char 1 110
char 1 116
char 1 79
char 1 112
char 1 112
char 1 111
char 1 110
char 1 101
char 1 110
char 1 116
char 1 0
align 1
LABELV $4654
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 56
char 1 0
align 1
LABELV $4653
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 55
char 1 0
align 1
LABELV $4652
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 54
char 1 0
align 1
LABELV $4651
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 53
char 1 0
align 1
LABELV $4650
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 52
char 1 0
align 1
LABELV $4649
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 51
char 1 0
align 1
LABELV $4648
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 50
char 1 0
align 1
LABELV $4647
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 49
char 1 0
align 1
LABELV $4646
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 56
char 1 0
align 1
LABELV $4645
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 55
char 1 0
align 1
LABELV $4644
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 54
char 1 0
align 1
LABELV $4643
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 53
char 1 0
align 1
LABELV $4642
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 52
char 1 0
align 1
LABELV $4641
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 51
char 1 0
align 1
LABELV $4640
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 50
char 1 0
align 1
LABELV $4639
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 49
char 1 0
align 1
LABELV $4638
char 1 51
char 1 0
align 1
LABELV $4637
char 1 117
char 1 105
char 1 95
char 1 97
char 1 99
char 1 116
char 1 117
char 1 97
char 1 108
char 1 78
char 1 101
char 1 116
char 1 71
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $4636
char 1 117
char 1 105
char 1 95
char 1 110
char 1 101
char 1 116
char 1 71
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $4635
char 1 117
char 1 105
char 1 95
char 1 106
char 1 111
char 1 105
char 1 110
char 1 71
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $4634
char 1 117
char 1 105
char 1 95
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $4633
char 1 117
char 1 105
char 1 95
char 1 100
char 1 101
char 1 100
char 1 105
char 1 99
char 1 97
char 1 116
char 1 101
char 1 100
char 1 0
align 1
LABELV $4632
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $4631
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $4630
char 1 117
char 1 105
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 80
char 1 111
char 1 119
char 1 101
char 1 114
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $4629
char 1 117
char 1 105
char 1 95
char 1 102
char 1 114
char 1 101
char 1 101
char 1 83
char 1 97
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $4628
char 1 82
char 1 101
char 1 98
char 1 101
char 1 108
char 1 108
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $4627
char 1 69
char 1 109
char 1 112
char 1 105
char 1 114
char 1 101
char 1 0
align 1
LABELV $4626
char 1 117
char 1 105
char 1 95
char 1 105
char 1 110
char 1 105
char 1 116
char 1 105
char 1 97
char 1 108
char 1 105
char 1 122
char 1 101
char 1 100
char 1 0
align 1
LABELV $4625
char 1 117
char 1 105
char 1 95
char 1 100
char 1 101
char 1 98
char 1 117
char 1 103
char 1 0
align 1
LABELV $4624
char 1 117
char 1 105
char 1 95
char 1 99
char 1 100
char 1 107
char 1 101
char 1 121
char 1 99
char 1 104
char 1 101
char 1 99
char 1 107
char 1 101
char 1 100
char 1 0
align 1
LABELV $4623
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 54
char 1 0
align 1
LABELV $4622
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 53
char 1 0
align 1
LABELV $4621
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 52
char 1 0
align 1
LABELV $4620
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 51
char 1 0
align 1
LABELV $4619
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 50
char 1 0
align 1
LABELV $4618
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 49
char 1 0
align 1
LABELV $4617
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 48
char 1 0
align 1
LABELV $4616
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 57
char 1 0
align 1
LABELV $4615
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 56
char 1 0
align 1
LABELV $4614
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 55
char 1 0
align 1
LABELV $4613
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 54
char 1 0
align 1
LABELV $4612
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 53
char 1 0
align 1
LABELV $4611
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 52
char 1 0
align 1
LABELV $4610
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 51
char 1 0
align 1
LABELV $4609
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 50
char 1 0
align 1
LABELV $4608
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 49
char 1 0
align 1
LABELV $4607
char 1 99
char 1 103
char 1 95
char 1 109
char 1 97
char 1 114
char 1 107
char 1 115
char 1 0
align 1
LABELV $4606
char 1 99
char 1 103
char 1 95
char 1 100
char 1 114
char 1 97
char 1 119
char 1 67
char 1 114
char 1 111
char 1 115
char 1 115
char 1 104
char 1 97
char 1 105
char 1 114
char 1 78
char 1 97
char 1 109
char 1 101
char 1 115
char 1 0
align 1
LABELV $4605
char 1 117
char 1 105
char 1 95
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 83
char 1 104
char 1 111
char 1 119
char 1 69
char 1 109
char 1 112
char 1 116
char 1 121
char 1 0
align 1
LABELV $4604
char 1 117
char 1 105
char 1 95
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 83
char 1 104
char 1 111
char 1 119
char 1 70
char 1 117
char 1 108
char 1 108
char 1 0
align 1
LABELV $4603
char 1 117
char 1 105
char 1 95
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 83
char 1 111
char 1 114
char 1 116
char 1 75
char 1 101
char 1 121
char 1 0
align 1
LABELV $4602
char 1 117
char 1 105
char 1 95
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 71
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $4601
char 1 117
char 1 105
char 1 95
char 1 98
char 1 114
char 1 111
char 1 119
char 1 115
char 1 101
char 1 114
char 1 77
char 1 97
char 1 115
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $4600
char 1 117
char 1 105
char 1 95
char 1 115
char 1 112
char 1 83
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $4599
char 1 103
char 1 95
char 1 115
char 1 112
char 1 86
char 1 105
char 1 100
char 1 101
char 1 111
char 1 115
char 1 0
align 1
LABELV $4598
char 1 103
char 1 95
char 1 115
char 1 112
char 1 65
char 1 119
char 1 97
char 1 114
char 1 100
char 1 115
char 1 0
align 1
LABELV $4597
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 53
char 1 0
align 1
LABELV $4596
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 52
char 1 0
align 1
LABELV $4595
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 51
char 1 0
align 1
LABELV $4594
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 50
char 1 0
align 1
LABELV $4593
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 49
char 1 0
align 1
LABELV $4592
char 1 103
char 1 95
char 1 98
char 1 111
char 1 116
char 1 115
char 1 70
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $4591
char 1 103
char 1 95
char 1 97
char 1 114
char 1 101
char 1 110
char 1 97
char 1 115
char 1 70
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $4590
char 1 117
char 1 105
char 1 95
char 1 99
char 1 116
char 1 102
char 1 95
char 1 102
char 1 114
char 1 105
char 1 101
char 1 110
char 1 100
char 1 108
char 1 121
char 1 0
align 1
LABELV $4589
char 1 117
char 1 105
char 1 95
char 1 99
char 1 116
char 1 102
char 1 95
char 1 116
char 1 105
char 1 109
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4588
char 1 56
char 1 0
align 1
LABELV $4587
char 1 117
char 1 105
char 1 95
char 1 99
char 1 116
char 1 102
char 1 95
char 1 99
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4586
char 1 117
char 1 105
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 102
char 1 114
char 1 105
char 1 101
char 1 110
char 1 100
char 1 108
char 1 121
char 1 0
align 1
LABELV $4585
char 1 117
char 1 105
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 116
char 1 105
char 1 109
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4584
char 1 117
char 1 105
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 102
char 1 114
char 1 97
char 1 103
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4583
char 1 49
char 1 54
char 1 0
align 1
LABELV $4582
char 1 117
char 1 105
char 1 95
char 1 116
char 1 111
char 1 117
char 1 114
char 1 110
char 1 101
char 1 121
char 1 95
char 1 116
char 1 105
char 1 109
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4581
char 1 117
char 1 105
char 1 95
char 1 116
char 1 111
char 1 117
char 1 114
char 1 110
char 1 101
char 1 121
char 1 95
char 1 102
char 1 114
char 1 97
char 1 103
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4580
char 1 117
char 1 105
char 1 95
char 1 102
char 1 102
char 1 97
char 1 95
char 1 116
char 1 105
char 1 109
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4579
char 1 117
char 1 105
char 1 95
char 1 102
char 1 102
char 1 97
char 1 95
char 1 102
char 1 114
char 1 97
char 1 103
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $4570
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 65
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 71
char 1 65
char 1 77
char 1 69
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 0
align 1
LABELV $4567
char 1 99
char 1 108
char 1 95
char 1 100
char 1 111
char 1 119
char 1 110
char 1 108
char 1 111
char 1 97
char 1 100
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $4564
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 65
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 67
char 1 72
char 1 65
char 1 76
char 1 76
char 1 69
char 1 78
char 1 71
char 1 69
char 1 0
align 1
LABELV $4561
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 65
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 67
char 1 79
char 1 78
char 1 78
char 1 69
char 1 67
char 1 84
char 1 73
char 1 79
char 1 78
char 1 0
align 1
LABELV $4551
char 1 109
char 1 111
char 1 116
char 1 100
char 1 0
align 1
LABELV $4548
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 67
char 1 79
char 1 78
char 1 78
char 1 69
char 1 67
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 84
char 1 79
char 1 0
align 1
LABELV $4547
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 83
char 1 84
char 1 65
char 1 82
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 85
char 1 80
char 1 0
align 1
LABELV $4546
char 1 108
char 1 111
char 1 99
char 1 97
char 1 108
char 1 104
char 1 111
char 1 115
char 1 116
char 1 0
align 1
LABELV $4542
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 76
char 1 79
char 1 65
char 1 68
char 1 73
char 1 78
char 1 71
char 1 95
char 1 77
char 1 65
char 1 80
char 1 78
char 1 65
char 1 77
char 1 69
char 1 0
align 1
LABELV $4535
char 1 67
char 1 111
char 1 110
char 1 110
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $4533
char 1 37
char 1 115
char 1 47
char 1 83
char 1 101
char 1 99
char 1 0
align 1
LABELV $4530
char 1 40
char 1 37
char 1 115
char 1 32
char 1 99
char 1 111
char 1 112
char 1 105
char 1 101
char 1 100
char 1 41
char 1 0
align 1
LABELV $4521
char 1 40
char 1 37
char 1 115
char 1 32
char 1 111
char 1 102
char 1 32
char 1 37
char 1 115
char 1 32
char 1 99
char 1 111
char 1 112
char 1 105
char 1 101
char 1 100
char 1 41
char 1 0
align 1
LABELV $4520
char 1 101
char 1 115
char 1 116
char 1 105
char 1 109
char 1 97
char 1 116
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $4516
char 1 37
char 1 115
char 1 32
char 1 40
char 1 37
char 1 100
char 1 37
char 1 37
char 1 41
char 1 0
align 1
LABELV $4513
char 1 99
char 1 108
char 1 95
char 1 100
char 1 111
char 1 119
char 1 110
char 1 108
char 1 111
char 1 97
char 1 100
char 1 84
char 1 105
char 1 109
char 1 101
char 1 0
align 1
LABELV $4512
char 1 99
char 1 108
char 1 95
char 1 100
char 1 111
char 1 119
char 1 110
char 1 108
char 1 111
char 1 97
char 1 100
char 1 67
char 1 111
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $4511
char 1 99
char 1 108
char 1 95
char 1 100
char 1 111
char 1 119
char 1 110
char 1 108
char 1 111
char 1 97
char 1 100
char 1 83
char 1 105
char 1 122
char 1 101
char 1 0
align 1
LABELV $4505
char 1 37
char 1 100
char 1 32
char 1 115
char 1 101
char 1 99
char 1 0
align 1
LABELV $4504
char 1 37
char 1 100
char 1 32
char 1 109
char 1 105
char 1 110
char 1 32
char 1 37
char 1 100
char 1 32
char 1 115
char 1 101
char 1 99
char 1 0
align 1
LABELV $4501
char 1 37
char 1 100
char 1 32
char 1 104
char 1 114
char 1 32
char 1 37
char 1 100
char 1 32
char 1 109
char 1 105
char 1 110
char 1 0
align 1
LABELV $4497
char 1 37
char 1 100
char 1 32
char 1 98
char 1 121
char 1 116
char 1 101
char 1 115
char 1 0
align 1
LABELV $4496
char 1 37
char 1 100
char 1 32
char 1 75
char 1 66
char 1 0
align 1
LABELV $4493
char 1 46
char 1 37
char 1 48
char 1 50
char 1 100
char 1 32
char 1 77
char 1 66
char 1 0
align 1
LABELV $4490
char 1 46
char 1 37
char 1 48
char 1 50
char 1 100
char 1 32
char 1 71
char 1 66
char 1 0
align 1
LABELV $4482
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $4480
char 1 101
char 1 110
char 1 100
char 1 111
char 1 102
char 1 103
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $4475
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $4473
char 1 98
char 1 97
char 1 99
char 1 107
char 1 103
char 1 114
char 1 111
char 1 117
char 1 110
char 1 100
char 1 116
char 1 97
char 1 115
char 1 107
char 1 95
char 1 112
char 1 111
char 1 112
char 1 109
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $4472
char 1 99
char 1 111
char 1 109
char 1 95
char 1 105
char 1 103
char 1 110
char 1 111
char 1 114
char 1 101
char 1 111
char 1 116
char 1 104
char 1 101
char 1 114
char 1 116
char 1 97
char 1 115
char 1 107
char 1 115
char 1 0
align 1
LABELV $4469
char 1 99
char 1 111
char 1 109
char 1 95
char 1 111
char 1 116
char 1 104
char 1 101
char 1 114
char 1 116
char 1 97
char 1 115
char 1 107
char 1 115
char 1 0
align 1
LABELV $4466
char 1 101
char 1 114
char 1 114
char 1 111
char 1 114
char 1 95
char 1 112
char 1 111
char 1 112
char 1 109
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $4411
char 1 100
char 1 101
char 1 98
char 1 117
char 1 103
char 1 95
char 1 112
char 1 114
char 1 111
char 1 116
char 1 111
char 1 99
char 1 111
char 1 108
char 1 0
align 1
LABELV $4388
char 1 119
char 1 104
char 1 105
char 1 116
char 1 101
char 1 0
align 1
LABELV $4386
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 51
char 1 95
char 1 99
char 1 117
char 1 114
char 1 115
char 1 111
char 1 114
char 1 50
char 1 0
align 1
LABELV $4384
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 37
char 1 100
char 1 0
align 1
LABELV $4287
char 1 37
char 1 115
char 1 37
char 1 115
char 1 0
align 1
LABELV $4276
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 105
char 1 99
char 1 111
char 1 110
char 1 37
char 1 115
char 1 46
char 1 106
char 1 112
char 1 103
char 1 0
align 1
LABELV $4260
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $4258
char 1 46
char 1 46
char 1 0
align 1
LABELV $4257
char 1 46
char 1 0
align 1
LABELV $4247
char 1 47
char 1 0
align 1
LABELV $4246
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $4222
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 99
char 1 102
char 1 103
char 1 47
char 1 100
char 1 97
char 1 114
char 1 107
char 1 0
align 1
LABELV $4219
char 1 102
char 1 99
char 1 102
char 1 0
align 1
LABELV $4218
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 99
char 1 102
char 1 103
char 1 47
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $4213
char 1 67
char 1 117
char 1 115
char 1 116
char 1 111
char 1 109
char 1 0
align 1
LABELV $4161
char 1 109
char 1 97
char 1 112
char 1 115
char 1 0
align 1
LABELV $4156
char 1 106
char 1 111
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 115
char 1 0
align 1
LABELV $4151
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 115
char 1 0
align 1
LABELV $4136
char 1 84
char 1 111
char 1 111
char 1 32
char 1 109
char 1 97
char 1 110
char 1 121
char 1 32
char 1 109
char 1 97
char 1 112
char 1 115
char 1 44
char 1 32
char 1 108
char 1 97
char 1 115
char 1 116
char 1 32
char 1 111
char 1 110
char 1 101
char 1 32
char 1 114
char 1 101
char 1 112
char 1 108
char 1 97
char 1 99
char 1 101
char 1 100
char 1 33
char 1 10
char 1 0
align 1
LABELV $4128
char 1 108
char 1 101
char 1 118
char 1 101
char 1 108
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 47
char 1 37
char 1 115
char 1 95
char 1 115
char 1 109
char 1 97
char 1 108
char 1 108
char 1 0
align 1
LABELV $4072
char 1 84
char 1 111
char 1 111
char 1 32
char 1 109
char 1 97
char 1 110
char 1 121
char 1 32
char 1 103
char 1 97
char 1 109
char 1 101
char 1 32
char 1 116
char 1 121
char 1 112
char 1 101
char 1 115
char 1 44
char 1 32
char 1 108
char 1 97
char 1 115
char 1 116
char 1 32
char 1 111
char 1 110
char 1 101
char 1 32
char 1 114
char 1 101
char 1 112
char 1 108
char 1 97
char 1 99
char 1 101
char 1 33
char 1 10
char 1 0
align 1
LABELV $4067
char 1 84
char 1 111
char 1 111
char 1 32
char 1 109
char 1 97
char 1 110
char 1 121
char 1 32
char 1 110
char 1 101
char 1 116
char 1 32
char 1 103
char 1 97
char 1 109
char 1 101
char 1 32
char 1 116
char 1 121
char 1 112
char 1 101
char 1 115
char 1 44
char 1 32
char 1 108
char 1 97
char 1 115
char 1 116
char 1 32
char 1 111
char 1 110
char 1 101
char 1 32
char 1 114
char 1 101
char 1 112
char 1 108
char 1 97
char 1 99
char 1 101
char 1 33
char 1 10
char 1 0
align 1
LABELV $3908
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $3899
char 1 116
char 1 101
char 1 97
char 1 109
char 1 95
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $3868
char 1 105
char 1 99
char 1 111
char 1 110
char 1 95
char 1 0
align 1
LABELV $3863
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 0
align 1
LABELV $3848
char 1 117
char 1 105
char 1 95
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 77
char 1 111
char 1 100
char 1 101
char 1 108
char 1 73
char 1 110
char 1 100
char 1 101
char 1 120
char 1 0
align 1
LABELV $3771
char 1 46
char 1 46
char 1 46
char 1 0
align 1
LABELV $3767
char 1 85
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 0
align 1
LABELV $3763
char 1 37
char 1 115
char 1 32
char 1 40
char 1 37
char 1 115
char 1 41
char 1 0
align 1
LABELV $3760
char 1 37
char 1 115
char 1 0
align 1
LABELV $3759
char 1 40
char 1 65
char 1 41
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $3758
char 1 115
char 1 118
char 1 95
char 1 97
char 1 108
char 1 108
char 1 111
char 1 119
char 1 65
char 1 110
char 1 111
char 1 110
char 1 121
char 1 109
char 1 111
char 1 117
char 1 115
char 1 0
align 1
LABELV $3755
char 1 110
char 1 101
char 1 116
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $3754
char 1 37
char 1 115
char 1 32
char 1 91
char 1 37
char 1 115
char 1 93
char 1 0
align 1
LABELV $3538
char 1 115
char 1 0
align 1
LABELV $3531
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 83
char 1 69
char 1 82
char 1 86
char 1 69
char 1 82
char 1 83
char 1 95
char 1 70
char 1 79
char 1 85
char 1 78
char 1 68
char 1 87
char 1 73
char 1 84
char 1 72
char 1 0
align 1
LABELV $3530
char 1 110
char 1 111
char 1 32
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $3446
char 1 115
char 1 101
char 1 97
char 1 114
char 1 99
char 1 104
char 1 105
char 1 110
char 1 103
char 1 32
char 1 37
char 1 100
char 1 47
char 1 37
char 1 100
char 1 46
char 1 46
char 1 46
char 1 0
align 1
LABELV $3388
char 1 115
char 1 101
char 1 97
char 1 114
char 1 99
char 1 104
char 1 105
char 1 110
char 1 103
char 1 32
char 1 37
char 1 100
char 1 46
char 1 46
char 1 46
char 1 0
align 1
LABELV $3380
char 1 99
char 1 108
char 1 95
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 83
char 1 116
char 1 97
char 1 116
char 1 117
char 1 115
char 1 82
char 1 101
char 1 115
char 1 101
char 1 110
char 1 100
char 1 84
char 1 105
char 1 109
char 1 101
char 1 0
align 1
LABELV $3369
char 1 117
char 1 105
char 1 95
char 1 102
char 1 105
char 1 110
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 0
align 1
LABELV $3324
char 1 112
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $3323
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 0
align 1
LABELV $3322
char 1 110
char 1 117
char 1 109
char 1 0
align 1
LABELV $3284
char 1 116
char 1 105
char 1 109
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $3283
char 1 118
char 1 101
char 1 114
char 1 115
char 1 105
char 1 111
char 1 110
char 1 0
align 1
LABELV $3282
char 1 77
char 1 97
char 1 112
char 1 0
align 1
LABELV $3281
char 1 109
char 1 97
char 1 112
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3280
char 1 71
char 1 97
char 1 109
char 1 101
char 1 32
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $3279
char 1 71
char 1 97
char 1 109
char 1 101
char 1 32
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3278
char 1 103
char 1 97
char 1 109
char 1 101
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3277
char 1 65
char 1 100
char 1 100
char 1 114
char 1 101
char 1 115
char 1 115
char 1 0
align 1
LABELV $3276
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3275
char 1 115
char 1 118
char 1 95
char 1 104
char 1 111
char 1 115
char 1 116
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3259
char 1 103
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $3247
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $3227
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $3184
char 1 87
char 1 101
char 1 108
char 1 99
char 1 111
char 1 109
char 1 101
char 1 32
char 1 116
char 1 111
char 1 32
char 1 74
char 1 75
char 1 50
char 1 77
char 1 80
char 1 33
char 1 0
align 1
LABELV $3173
char 1 99
char 1 108
char 1 95
char 1 109
char 1 111
char 1 116
char 1 100
char 1 83
char 1 116
char 1 114
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $3090
char 1 47
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $3089
char 1 47
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $3087
char 1 47
char 1 98
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $2999
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 99
char 1 104
char 1 97
char 1 114
char 1 97
char 1 99
char 1 116
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 108
char 1 111
char 1 119
char 1 101
char 1 114
char 1 95
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 46
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $2996
char 1 109
char 1 111
char 1 100
char 1 101
char 1 108
char 1 115
char 1 47
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 37
char 1 115
char 1 47
char 1 108
char 1 111
char 1 119
char 1 101
char 1 114
char 1 95
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 46
char 1 115
char 1 107
char 1 105
char 1 110
char 1 0
align 1
LABELV $2957
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 32
char 1 85
char 1 73
char 1 32
char 1 115
char 1 99
char 1 114
char 1 105
char 1 112
char 1 116
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2954
char 1 117
char 1 112
char 1 100
char 1 97
char 1 116
char 1 101
char 1 0
align 1
LABELV $2951
char 1 117
char 1 112
char 1 100
char 1 97
char 1 116
char 1 101
char 1 70
char 1 111
char 1 114
char 1 99
char 1 101
char 1 83
char 1 116
char 1 97
char 1 116
char 1 117
char 1 115
char 1 0
align 1
LABELV $2940
char 1 103
char 1 95
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2939
char 1 103
char 1 95
char 1 100
char 1 117
char 1 101
char 1 108
char 1 87
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2935
char 1 119
char 1 101
char 1 97
char 1 112
char 1 111
char 1 110
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2926
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 80
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $2923
char 1 103
char 1 108
char 1 67
char 1 117
char 1 115
char 1 116
char 1 111
char 1 109
char 1 0
align 1
LABELV $2920
char 1 114
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 70
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $2917
char 1 115
char 1 97
char 1 118
char 1 101
char 1 84
char 1 101
char 1 109
char 1 112
char 1 108
char 1 97
char 1 116
char 1 101
char 1 0
align 1
LABELV $2912
char 1 115
char 1 101
char 1 116
char 1 70
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $2903
char 1 118
char 1 111
char 1 105
char 1 99
char 1 101
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $2895
char 1 118
char 1 111
char 1 105
char 1 99
char 1 101
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 115
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $2883
char 1 10
char 1 0
align 1
LABELV $2876
char 1 111
char 1 114
char 1 100
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $2867
char 1 117
char 1 105
char 1 95
char 1 102
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 65
char 1 100
char 1 100
char 1 114
char 1 101
char 1 115
char 1 115
char 1 0
align 1
LABELV $2866
char 1 117
char 1 105
char 1 95
char 1 102
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2865
char 1 99
char 1 114
char 1 101
char 1 97
char 1 116
char 1 101
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 0
align 1
LABELV $2852
char 1 100
char 1 101
char 1 108
char 1 101
char 1 116
char 1 101
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 0
align 1
LABELV $2849
char 1 65
char 1 100
char 1 100
char 1 101
char 1 100
char 1 32
char 1 102
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 32
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2848
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 32
char 1 108
char 1 105
char 1 115
char 1 116
char 1 32
char 1 102
char 1 117
char 1 108
char 1 108
char 1 10
char 1 0
align 1
LABELV $2845
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 32
char 1 97
char 1 108
char 1 114
char 1 101
char 1 97
char 1 100
char 1 121
char 1 32
char 1 105
char 1 110
char 1 32
char 1 108
char 1 105
char 1 115
char 1 116
char 1 10
char 1 0
align 1
LABELV $2840
char 1 97
char 1 100
char 1 100
char 1 114
char 1 0
align 1
LABELV $2839
char 1 104
char 1 111
char 1 115
char 1 116
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2830
char 1 97
char 1 100
char 1 100
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 0
align 1
LABELV $2815
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2812
char 1 97
char 1 100
char 1 100
char 1 66
char 1 111
char 1 116
char 1 0
align 1
LABELV $2807
char 1 99
char 1 97
char 1 108
char 1 108
char 1 116
char 1 101
char 1 97
char 1 109
char 1 118
char 1 111
char 1 116
char 1 101
char 1 32
char 1 108
char 1 101
char 1 97
char 1 100
char 1 101
char 1 114
char 1 32
char 1 34
char 1 37
char 1 115
char 1 34
char 1 10
char 1 0
align 1
LABELV $2801
char 1 118
char 1 111
char 1 116
char 1 101
char 1 76
char 1 101
char 1 97
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $2795
char 1 99
char 1 97
char 1 108
char 1 108
char 1 118
char 1 111
char 1 116
char 1 101
char 1 32
char 1 103
char 1 95
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 32
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $2789
char 1 118
char 1 111
char 1 116
char 1 101
char 1 71
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2784
char 1 99
char 1 97
char 1 108
char 1 108
char 1 118
char 1 111
char 1 116
char 1 101
char 1 32
char 1 107
char 1 105
char 1 99
char 1 107
char 1 32
char 1 34
char 1 37
char 1 115
char 1 34
char 1 10
char 1 0
align 1
LABELV $2778
char 1 118
char 1 111
char 1 116
char 1 101
char 1 75
char 1 105
char 1 99
char 1 107
char 1 0
align 1
LABELV $2772
char 1 99
char 1 97
char 1 108
char 1 108
char 1 118
char 1 111
char 1 116
char 1 101
char 1 32
char 1 109
char 1 97
char 1 112
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2766
char 1 118
char 1 111
char 1 116
char 1 101
char 1 77
char 1 97
char 1 112
char 1 0
align 1
LABELV $2763
char 1 99
char 1 108
char 1 111
char 1 115
char 1 101
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2760
char 1 83
char 1 107
char 1 105
char 1 114
char 1 109
char 1 105
char 1 115
char 1 104
char 1 83
char 1 116
char 1 97
char 1 114
char 1 116
char 1 0
align 1
LABELV $2757
char 1 110
char 1 101
char 1 120
char 1 116
char 1 83
char 1 107
char 1 105
char 1 114
char 1 109
char 1 105
char 1 115
char 1 104
char 1 0
align 1
LABELV $2741
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 83
char 1 111
char 1 114
char 1 116
char 1 0
align 1
LABELV $2738
char 1 117
char 1 112
char 1 100
char 1 97
char 1 116
char 1 101
char 1 118
char 1 105
char 1 100
char 1 101
char 1 111
char 1 115
char 1 101
char 1 116
char 1 117
char 1 112
char 1 0
align 1
LABELV $2735
char 1 103
char 1 101
char 1 116
char 1 118
char 1 105
char 1 100
char 1 101
char 1 111
char 1 115
char 1 101
char 1 116
char 1 117
char 1 112
char 1 0
align 1
LABELV $2732
char 1 100
char 1 105
char 1 115
char 1 99
char 1 111
char 1 110
char 1 110
char 1 101
char 1 99
char 1 116
char 1 10
char 1 0
align 1
LABELV $2731
char 1 76
char 1 101
char 1 97
char 1 118
char 1 101
char 1 0
align 1
LABELV $2728
char 1 115
char 1 101
char 1 116
char 1 117
char 1 112
char 1 95
char 1 109
char 1 101
char 1 110
char 1 117
char 1 50
char 1 0
align 1
LABELV $2727
char 1 99
char 1 108
char 1 95
char 1 112
char 1 97
char 1 117
char 1 115
char 1 101
char 1 100
char 1 0
align 1
LABELV $2726
char 1 67
char 1 111
char 1 110
char 1 116
char 1 114
char 1 111
char 1 108
char 1 115
char 1 0
align 1
LABELV $2723
char 1 113
char 1 117
char 1 105
char 1 116
char 1 0
align 1
LABELV $2722
char 1 81
char 1 117
char 1 105
char 1 116
char 1 0
align 1
LABELV $2712
char 1 70
char 1 111
char 1 117
char 1 110
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 74
char 1 111
char 1 105
char 1 110
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $2709
char 1 99
char 1 111
char 1 110
char 1 110
char 1 101
char 1 99
char 1 116
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2695
char 1 74
char 1 111
char 1 105
char 1 110
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $2690
char 1 70
char 1 105
char 1 110
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 0
align 1
LABELV $2683
char 1 70
char 1 111
char 1 117
char 1 110
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 83
char 1 116
char 1 97
char 1 116
char 1 117
char 1 115
char 1 0
align 1
LABELV $2673
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 83
char 1 116
char 1 97
char 1 116
char 1 117
char 1 115
char 1 0
align 1
LABELV $2667
char 1 85
char 1 112
char 1 100
char 1 97
char 1 116
char 1 101
char 1 70
char 1 105
char 1 108
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $2660
char 1 83
char 1 116
char 1 111
char 1 112
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 0
align 1
LABELV $2657
char 1 109
char 1 97
char 1 105
char 1 110
char 1 0
align 1
LABELV $2656
char 1 106
char 1 111
char 1 105
char 1 110
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $2647
char 1 99
char 1 108
char 1 111
char 1 115
char 1 101
char 1 74
char 1 111
char 1 105
char 1 110
char 1 0
align 1
LABELV $2644
char 1 81
char 1 117
char 1 97
char 1 107
char 1 101
char 1 51
char 1 0
align 1
LABELV $2639
char 1 100
char 1 101
char 1 109
char 1 111
char 1 32
char 1 34
char 1 37
char 1 115
char 1 34
char 1 10
char 1 0
align 1
LABELV $2638
char 1 82
char 1 117
char 1 110
char 1 68
char 1 101
char 1 109
char 1 111
char 1 0
align 1
LABELV $2633
char 1 102
char 1 115
char 1 95
char 1 103
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2632
char 1 82
char 1 117
char 1 110
char 1 77
char 1 111
char 1 100
char 1 0
align 1
LABELV $2627
char 1 99
char 1 105
char 1 110
char 1 101
char 1 109
char 1 97
char 1 116
char 1 105
char 1 99
char 1 32
char 1 37
char 1 115
char 1 46
char 1 114
char 1 111
char 1 113
char 1 32
char 1 50
char 1 10
char 1 0
align 1
LABELV $2622
char 1 112
char 1 108
char 1 97
char 1 121
char 1 77
char 1 111
char 1 118
char 1 105
char 1 101
char 1 0
align 1
LABELV $2619
char 1 76
char 1 111
char 1 97
char 1 100
char 1 77
char 1 111
char 1 100
char 1 115
char 1 0
align 1
LABELV $2616
char 1 76
char 1 111
char 1 97
char 1 100
char 1 77
char 1 111
char 1 118
char 1 105
char 1 101
char 1 115
char 1 0
align 1
LABELV $2613
char 1 76
char 1 111
char 1 97
char 1 100
char 1 68
char 1 101
char 1 109
char 1 111
char 1 115
char 1 0
align 1
LABELV $2604
char 1 100
char 1 101
char 1 109
char 1 111
char 1 32
char 1 37
char 1 115
char 1 95
char 1 37
char 1 105
char 1 10
char 1 0
align 1
LABELV $2600
char 1 82
char 1 117
char 1 110
char 1 83
char 1 80
char 1 68
char 1 101
char 1 109
char 1 111
char 1 0
align 1
LABELV $2597
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 70
char 1 105
char 1 108
char 1 116
char 1 101
char 1 114
char 1 0
align 1
LABELV $2594
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $2591
char 1 114
char 1 101
char 1 115
char 1 101
char 1 116
char 1 83
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $2582
char 1 108
char 1 111
char 1 97
char 1 100
char 1 71
char 1 97
char 1 109
char 1 101
char 1 73
char 1 110
char 1 102
char 1 111
char 1 0
align 1
LABELV $2579
char 1 99
char 1 111
char 1 109
char 1 95
char 1 101
char 1 114
char 1 114
char 1 111
char 1 114
char 1 77
char 1 101
char 1 115
char 1 115
char 1 97
char 1 103
char 1 101
char 1 0
align 1
LABELV $2578
char 1 99
char 1 108
char 1 101
char 1 97
char 1 114
char 1 69
char 1 114
char 1 114
char 1 111
char 1 114
char 1 0
align 1
LABELV $2575
char 1 108
char 1 111
char 1 97
char 1 100
char 1 67
char 1 111
char 1 110
char 1 116
char 1 114
char 1 111
char 1 108
char 1 115
char 1 0
align 1
LABELV $2572
char 1 115
char 1 97
char 1 118
char 1 101
char 1 67
char 1 111
char 1 110
char 1 116
char 1 114
char 1 111
char 1 108
char 1 115
char 1 0
align 1
LABELV $2569
char 1 103
char 1 95
char 1 109
char 1 97
char 1 120
char 1 70
char 1 111
char 1 114
char 1 99
char 1 101
char 1 82
char 1 97
char 1 110
char 1 107
char 1 0
align 1
LABELV $2568
char 1 99
char 1 114
char 1 101
char 1 97
char 1 116
char 1 101
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $2567
char 1 108
char 1 111
char 1 97
char 1 100
char 1 65
char 1 114
char 1 101
char 1 110
char 1 97
char 1 115
char 1 0
align 1
LABELV $2564
char 1 118
char 1 105
char 1 100
char 1 95
char 1 114
char 1 101
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 10
char 1 0
align 1
LABELV $2563
char 1 99
char 1 111
char 1 109
char 1 95
char 1 105
char 1 110
char 1 116
char 1 114
char 1 111
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 100
char 1 0
align 1
LABELV $2562
char 1 99
char 1 118
char 1 97
char 1 114
char 1 95
char 1 114
char 1 101
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 10
char 1 0
align 1
LABELV $2561
char 1 101
char 1 120
char 1 101
char 1 99
char 1 32
char 1 109
char 1 112
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 46
char 1 99
char 1 102
char 1 103
char 1 10
char 1 0
align 1
LABELV $2560
char 1 114
char 1 101
char 1 115
char 1 101
char 1 116
char 1 68
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 115
char 1 0
align 1
LABELV $2553
char 1 117
char 1 112
char 1 100
char 1 97
char 1 116
char 1 101
char 1 83
char 1 80
char 1 77
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $2541
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 102
char 1 32
char 1 10
char 1 0
align 1
LABELV $2540
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 102
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2526
char 1 49
char 1 50
char 1 48
char 1 0
align 1
LABELV $2512
char 1 100
char 1 101
char 1 100
char 1 105
char 1 99
char 1 97
char 1 116
char 1 101
char 1 100
char 1 0
align 1
LABELV $2511
char 1 83
char 1 116
char 1 97
char 1 114
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $2505
char 1 52
char 1 0
align 1
LABELV $2503
char 1 118
char 1 105
char 1 100
char 1 95
char 1 114
char 1 101
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 59
char 1 0
align 1
LABELV $2502
char 1 117
char 1 105
char 1 95
char 1 99
char 1 103
char 1 95
char 1 115
char 1 104
char 1 97
char 1 100
char 1 111
char 1 119
char 1 115
char 1 0
align 1
LABELV $2501
char 1 99
char 1 103
char 1 95
char 1 115
char 1 104
char 1 97
char 1 100
char 1 111
char 1 119
char 1 115
char 1 0
align 1
LABELV $2500
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 97
char 1 108
char 1 108
char 1 111
char 1 119
char 1 69
char 1 120
char 1 116
char 1 101
char 1 110
char 1 115
char 1 105
char 1 111
char 1 110
char 1 115
char 1 0
align 1
LABELV $2499
char 1 114
char 1 95
char 1 97
char 1 108
char 1 108
char 1 111
char 1 119
char 1 69
char 1 120
char 1 116
char 1 101
char 1 110
char 1 115
char 1 105
char 1 111
char 1 110
char 1 115
char 1 0
align 1
LABELV $2498
char 1 114
char 1 95
char 1 105
char 1 110
char 1 71
char 1 97
char 1 109
char 1 101
char 1 86
char 1 105
char 1 100
char 1 101
char 1 111
char 1 0
align 1
LABELV $2497
char 1 114
char 1 95
char 1 102
char 1 97
char 1 115
char 1 116
char 1 83
char 1 107
char 1 121
char 1 0
align 1
LABELV $2496
char 1 114
char 1 95
char 1 115
char 1 117
char 1 98
char 1 100
char 1 105
char 1 118
char 1 105
char 1 115
char 1 105
char 1 111
char 1 110
char 1 115
char 1 0
align 1
LABELV $2495
char 1 114
char 1 95
char 1 100
char 1 101
char 1 112
char 1 116
char 1 104
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2494
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 101
char 1 120
char 1 116
char 1 95
char 1 99
char 1 111
char 1 109
char 1 112
char 1 114
char 1 101
char 1 115
char 1 115
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $2493
char 1 114
char 1 95
char 1 101
char 1 120
char 1 116
char 1 95
char 1 99
char 1 111
char 1 109
char 1 112
char 1 114
char 1 101
char 1 115
char 1 115
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $2492
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 100
char 1 101
char 1 116
char 1 97
char 1 105
char 1 108
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $2491
char 1 114
char 1 95
char 1 100
char 1 101
char 1 116
char 1 97
char 1 105
char 1 108
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $2490
char 1 114
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 0
align 1
LABELV $2489
char 1 114
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2488
char 1 114
char 1 95
char 1 112
char 1 105
char 1 99
char 1 109
char 1 105
char 1 112
char 1 0
align 1
LABELV $2487
char 1 114
char 1 95
char 1 108
char 1 111
char 1 100
char 1 98
char 1 105
char 1 97
char 1 115
char 1 0
align 1
LABELV $2486
char 1 114
char 1 95
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2485
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 102
char 1 117
char 1 108
char 1 108
char 1 115
char 1 99
char 1 114
char 1 101
char 1 101
char 1 110
char 1 0
align 1
LABELV $2484
char 1 114
char 1 95
char 1 102
char 1 117
char 1 108
char 1 108
char 1 115
char 1 99
char 1 114
char 1 101
char 1 101
char 1 110
char 1 0
align 1
LABELV $2483
char 1 114
char 1 95
char 1 109
char 1 111
char 1 100
char 1 101
char 1 0
align 1
LABELV $2478
char 1 117
char 1 105
char 1 95
char 1 114
char 1 117
char 1 108
char 1 101
char 1 115
char 1 95
char 1 98
char 1 97
char 1 99
char 1 107
char 1 111
char 1 117
char 1 116
char 1 0
align 1
LABELV $2477
char 1 82
char 1 117
char 1 108
char 1 101
char 1 115
char 1 66
char 1 97
char 1 99
char 1 107
char 1 111
char 1 117
char 1 116
char 1 0
align 1
LABELV $2469
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 109
char 1 111
char 1 100
char 1 105
char 1 102
char 1 105
char 1 101
char 1 100
char 1 0
align 1
LABELV $2466
char 1 86
char 1 105
char 1 100
char 1 101
char 1 111
char 1 83
char 1 101
char 1 116
char 1 117
char 1 112
char 1 0
align 1
LABELV $2460
char 1 109
char 1 95
char 1 112
char 1 105
char 1 116
char 1 99
char 1 104
char 1 0
align 1
LABELV $2457
char 1 117
char 1 105
char 1 95
char 1 109
char 1 111
char 1 117
char 1 115
char 1 101
char 1 80
char 1 105
char 1 116
char 1 99
char 1 104
char 1 0
align 1
LABELV $2452
char 1 71
char 1 76
char 1 95
char 1 76
char 1 73
char 1 78
char 1 69
char 1 65
char 1 82
char 1 95
char 1 77
char 1 73
char 1 80
char 1 77
char 1 65
char 1 80
char 1 95
char 1 78
char 1 69
char 1 65
char 1 82
char 1 69
char 1 83
char 1 84
char 1 0
align 1
LABELV $2449
char 1 71
char 1 76
char 1 95
char 1 76
char 1 73
char 1 78
char 1 69
char 1 65
char 1 82
char 1 95
char 1 77
char 1 73
char 1 80
char 1 77
char 1 65
char 1 80
char 1 95
char 1 76
char 1 73
char 1 78
char 1 69
char 1 65
char 1 82
char 1 0
align 1
LABELV $2448
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 109
char 1 111
char 1 100
char 1 101
char 1 0
align 1
LABELV $2447
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 105
char 1 110
char 1 71
char 1 97
char 1 109
char 1 101
char 1 86
char 1 105
char 1 100
char 1 101
char 1 111
char 1 0
align 1
LABELV $2446
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 102
char 1 97
char 1 115
char 1 116
char 1 83
char 1 107
char 1 121
char 1 0
align 1
LABELV $2445
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 116
char 1 101
char 1 120
char 1 116
char 1 117
char 1 114
char 1 101
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2444
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 109
char 1 111
char 1 100
char 1 101
char 1 0
align 1
LABELV $2443
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 112
char 1 105
char 1 99
char 1 109
char 1 105
char 1 112
char 1 0
align 1
LABELV $2442
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 102
char 1 117
char 1 108
char 1 108
char 1 83
char 1 99
char 1 114
char 1 101
char 1 101
char 1 110
char 1 0
align 1
LABELV $2438
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 103
char 1 108
char 1 67
char 1 117
char 1 115
char 1 116
char 1 111
char 1 109
char 1 0
align 1
LABELV $2433
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 115
char 1 117
char 1 98
char 1 100
char 1 105
char 1 118
char 1 105
char 1 115
char 1 105
char 1 111
char 1 110
char 1 115
char 1 0
align 1
LABELV $2429
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 108
char 1 111
char 1 100
char 1 98
char 1 105
char 1 97
char 1 115
char 1 0
align 1
LABELV $2422
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 100
char 1 101
char 1 112
char 1 116
char 1 104
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2418
char 1 117
char 1 105
char 1 95
char 1 114
char 1 95
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 98
char 1 105
char 1 116
char 1 115
char 1 0
align 1
LABELV $2415
char 1 117
char 1 105
char 1 95
char 1 71
char 1 101
char 1 116
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2412
char 1 50
char 1 0
align 1
LABELV $2409
char 1 99
char 1 108
char 1 95
char 1 112
char 1 97
char 1 99
char 1 107
char 1 101
char 1 116
char 1 100
char 1 117
char 1 112
char 1 0
align 1
LABELV $2408
char 1 99
char 1 108
char 1 95
char 1 109
char 1 97
char 1 120
char 1 112
char 1 97
char 1 99
char 1 107
char 1 101
char 1 116
char 1 115
char 1 0
align 1
LABELV $2405
char 1 114
char 1 97
char 1 116
char 1 101
char 1 0
align 1
LABELV $2404
char 1 117
char 1 105
char 1 95
char 1 115
char 1 101
char 1 116
char 1 82
char 1 97
char 1 116
char 1 101
char 1 0
align 1
LABELV $2401
char 1 117
char 1 105
char 1 95
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2400
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2399
char 1 117
char 1 105
char 1 95
char 1 83
char 1 101
char 1 116
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2396
char 1 115
char 1 110
char 1 100
char 1 95
char 1 114
char 1 101
char 1 115
char 1 116
char 1 97
char 1 114
char 1 116
char 1 10
char 1 0
align 1
LABELV $2395
char 1 115
char 1 95
char 1 107
char 1 104
char 1 122
char 1 0
align 1
LABELV $2391
char 1 119
char 1 97
char 1 105
char 1 116
char 1 32
char 1 53
char 1 59
char 1 32
char 1 116
char 1 101
char 1 97
char 1 109
char 1 32
char 1 82
char 1 101
char 1 100
char 1 10
char 1 0
align 1
LABELV $2336
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 102
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 105
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2319
char 1 119
char 1 97
char 1 105
char 1 116
char 1 32
char 1 59
char 1 32
char 1 97
char 1 100
char 1 100
char 1 98
char 1 111
char 1 116
char 1 32
char 1 37
char 1 115
char 1 32
char 1 37
char 1 102
char 1 32
char 1 44
char 1 32
char 1 37
char 1 105
char 1 32
char 1 10
char 1 0
align 1
LABELV $2313
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 99
char 1 111
char 1 114
char 1 100
char 1 83
char 1 80
char 1 68
char 1 101
char 1 109
char 1 111
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $2309
char 1 37
char 1 115
char 1 95
char 1 37
char 1 105
char 1 0
align 1
LABELV $2308
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 99
char 1 111
char 1 114
char 1 100
char 1 83
char 1 80
char 1 68
char 1 101
char 1 109
char 1 111
char 1 0
align 1
LABELV $2305
char 1 103
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $2304
char 1 103
char 1 95
char 1 114
char 1 101
char 1 100
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $2303
char 1 117
char 1 105
char 1 95
char 1 112
char 1 117
char 1 114
char 1 101
char 1 0
align 1
LABELV $2302
char 1 115
char 1 118
char 1 95
char 1 112
char 1 117
char 1 114
char 1 101
char 1 0
align 1
LABELV $2301
char 1 117
char 1 105
char 1 95
char 1 87
char 1 97
char 1 114
char 1 109
char 1 117
char 1 112
char 1 0
align 1
LABELV $2300
char 1 103
char 1 95
char 1 119
char 1 97
char 1 114
char 1 109
char 1 117
char 1 112
char 1 0
align 1
LABELV $2299
char 1 117
char 1 105
char 1 95
char 1 109
char 1 97
char 1 120
char 1 67
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $2298
char 1 117
char 1 105
char 1 95
char 1 102
char 1 114
char 1 105
char 1 101
char 1 110
char 1 100
char 1 108
char 1 121
char 1 70
char 1 105
char 1 114
char 1 101
char 1 0
align 1
LABELV $2297
char 1 103
char 1 95
char 1 102
char 1 114
char 1 105
char 1 101
char 1 110
char 1 100
char 1 108
char 1 121
char 1 70
char 1 105
char 1 114
char 1 101
char 1 0
align 1
LABELV $2296
char 1 117
char 1 105
char 1 95
char 1 100
char 1 111
char 1 87
char 1 97
char 1 114
char 1 109
char 1 117
char 1 112
char 1 0
align 1
LABELV $2295
char 1 103
char 1 95
char 1 100
char 1 111
char 1 87
char 1 97
char 1 114
char 1 109
char 1 117
char 1 112
char 1 0
align 1
LABELV $2294
char 1 117
char 1 105
char 1 95
char 1 100
char 1 114
char 1 97
char 1 119
char 1 84
char 1 105
char 1 109
char 1 101
char 1 114
char 1 0
align 1
LABELV $2293
char 1 99
char 1 103
char 1 95
char 1 100
char 1 114
char 1 97
char 1 119
char 1 84
char 1 105
char 1 109
char 1 101
char 1 114
char 1 0
align 1
LABELV $2292
char 1 117
char 1 105
char 1 95
char 1 115
char 1 97
char 1 118
char 1 101
char 1 68
char 1 117
char 1 101
char 1 108
char 1 76
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $2291
char 1 100
char 1 117
char 1 101
char 1 108
char 1 95
char 1 102
char 1 114
char 1 97
char 1 103
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $2290
char 1 117
char 1 105
char 1 95
char 1 115
char 1 97
char 1 118
char 1 101
char 1 70
char 1 114
char 1 97
char 1 103
char 1 76
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $2289
char 1 117
char 1 105
char 1 95
char 1 115
char 1 97
char 1 118
char 1 101
char 1 67
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 76
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $2288
char 1 117
char 1 105
char 1 95
char 1 115
char 1 105
char 1 110
char 1 103
char 1 108
char 1 101
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 65
char 1 99
char 1 116
char 1 105
char 1 118
char 1 101
char 1 0
align 1
LABELV $2285
char 1 117
char 1 105
char 1 95
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 77
char 1 97
char 1 112
char 1 0
align 1
LABELV $2281
char 1 119
char 1 97
char 1 105
char 1 116
char 1 32
char 1 59
char 1 32
char 1 119
char 1 97
char 1 105
char 1 116
char 1 32
char 1 59
char 1 32
char 1 109
char 1 97
char 1 112
char 1 32
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $2275
char 1 117
char 1 105
char 1 95
char 1 109
char 1 97
char 1 112
char 1 73
char 1 110
char 1 100
char 1 101
char 1 120
char 1 0
align 1
LABELV $2271
char 1 115
char 1 107
char 1 105
char 1 114
char 1 109
char 1 105
char 1 115
char 1 104
char 1 0
align 1
LABELV $2245
char 1 46
char 1 100
char 1 109
char 1 95
char 1 37
char 1 100
char 1 0
align 1
LABELV $2244
char 1 100
char 1 101
char 1 109
char 1 111
char 1 115
char 1 0
align 1
LABELV $2242
char 1 112
char 1 114
char 1 111
char 1 116
char 1 111
char 1 99
char 1 111
char 1 108
char 1 0
align 1
LABELV $2241
char 1 100
char 1 109
char 1 95
char 1 37
char 1 100
char 1 0
align 1
LABELV $2238
char 1 46
char 1 114
char 1 111
char 1 113
char 1 0
align 1
LABELV $2223
char 1 114
char 1 111
char 1 113
char 1 0
align 1
LABELV $2222
char 1 118
char 1 105
char 1 100
char 1 101
char 1 111
char 1 0
align 1
LABELV $2206
char 1 36
char 1 109
char 1 111
char 1 100
char 1 108
char 1 105
char 1 115
char 1 116
char 1 0
align 1
LABELV $2127
char 1 99
char 1 103
char 1 95
char 1 100
char 1 114
char 1 97
char 1 119
char 1 67
char 1 114
char 1 111
char 1 115
char 1 115
char 1 104
char 1 97
char 1 105
char 1 114
char 1 0
align 1
LABELV $2042
char 1 117
char 1 105
char 1 95
char 1 110
char 1 101
char 1 116
char 1 83
char 1 111
char 1 117
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $1930
char 1 117
char 1 105
char 1 95
char 1 97
char 1 99
char 1 116
char 1 117
char 1 97
char 1 108
char 1 110
char 1 101
char 1 116
char 1 71
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $1899
char 1 117
char 1 105
char 1 95
char 1 103
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $1898
char 1 117
char 1 105
char 1 95
char 1 81
char 1 51
char 1 77
char 1 111
char 1 100
char 1 101
char 1 108
char 1 0
align 1
LABELV $1840
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 49
char 1 0
align 1
LABELV $1633
char 1 74
char 1 75
char 1 50
char 1 77
char 1 80
char 1 58
char 1 32
char 1 118
char 1 49
char 1 46
char 1 48
char 1 50
char 1 0
align 1
LABELV $1601
char 1 71
char 1 76
char 1 95
char 1 80
char 1 73
char 1 88
char 1 69
char 1 76
char 1 70
char 1 79
char 1 82
char 1 77
char 1 65
char 1 84
char 1 58
char 1 32
char 1 99
char 1 111
char 1 108
char 1 111
char 1 114
char 1 40
char 1 37
char 1 100
char 1 45
char 1 98
char 1 105
char 1 116
char 1 115
char 1 41
char 1 32
char 1 90
char 1 40
char 1 37
char 1 100
char 1 45
char 1 98
char 1 105
char 1 116
char 1 115
char 1 41
char 1 32
char 1 115
char 1 116
char 1 101
char 1 110
char 1 99
char 1 105
char 1 108
char 1 40
char 1 37
char 1 100
char 1 45
char 1 98
char 1 105
char 1 116
char 1 115
char 1 41
char 1 0
align 1
LABELV $1597
char 1 71
char 1 76
char 1 95
char 1 86
char 1 69
char 1 82
char 1 83
char 1 73
char 1 79
char 1 78
char 1 58
char 1 32
char 1 37
char 1 115
char 1 58
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1594
char 1 71
char 1 76
char 1 95
char 1 86
char 1 69
char 1 78
char 1 68
char 1 79
char 1 82
char 1 58
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1486
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 83
char 1 69
char 1 82
char 1 86
char 1 69
char 1 82
char 1 95
char 1 82
char 1 69
char 1 70
char 1 82
char 1 69
char 1 83
char 1 72
char 1 84
char 1 73
char 1 77
char 1 69
char 1 0
align 1
LABELV $1483
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 95
char 1 71
char 1 69
char 1 84
char 1 84
char 1 73
char 1 78
char 1 71
char 1 73
char 1 78
char 1 70
char 1 79
char 1 70
char 1 79
char 1 82
char 1 83
char 1 69
char 1 82
char 1 86
char 1 69
char 1 82
char 1 83
char 1 0
align 1
LABELV $1460
char 1 69
char 1 118
char 1 101
char 1 114
char 1 121
char 1 111
char 1 110
char 1 101
char 1 0
align 1
LABELV $1458
char 1 99
char 1 103
char 1 95
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $1450
char 1 99
char 1 103
char 1 95
char 1 115
char 1 101
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 80
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 0
align 1
LABELV $1429
char 1 110
char 1 0
align 1
LABELV $1418
char 1 115
char 1 118
char 1 95
char 1 109
char 1 97
char 1 120
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $1417
char 1 116
char 1 0
align 1
LABELV $1416
char 1 116
char 1 108
char 1 0
align 1
LABELV $1380
char 1 117
char 1 105
char 1 95
char 1 108
char 1 97
char 1 115
char 1 116
char 1 83
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 82
char 1 101
char 1 102
char 1 114
char 1 101
char 1 115
char 1 104
char 1 95
char 1 37
char 1 105
char 1 0
align 1
LABELV $1378
char 1 87
char 1 65
char 1 73
char 1 84
char 1 73
char 1 78
char 1 71
char 1 95
char 1 70
char 1 79
char 1 82
char 1 95
char 1 78
char 1 69
char 1 87
char 1 95
char 1 75
char 1 69
char 1 89
char 1 0
align 1
LABELV $1343
char 1 37
char 1 105
char 1 46
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1314
char 1 37
char 1 105
char 1 0
align 1
LABELV $1305
char 1 68
char 1 97
char 1 114
char 1 107
char 1 0
align 1
LABELV $1304
char 1 76
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $1297
char 1 68
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 0
align 1
LABELV $1143
char 1 117
char 1 105
char 1 95
char 1 111
char 1 112
char 1 112
char 1 111
char 1 110
char 1 101
char 1 110
char 1 116
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $1141
char 1 75
char 1 121
char 1 108
char 1 101
char 1 0
align 1
LABELV $1093
char 1 108
char 1 101
char 1 118
char 1 101
char 1 108
char 1 115
char 1 104
char 1 111
char 1 116
char 1 115
char 1 47
char 1 37
char 1 115
char 1 0
align 1
LABELV $1080
char 1 84
char 1 105
char 1 101
char 1 114
char 1 58
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1075
char 1 117
char 1 105
char 1 95
char 1 99
char 1 117
char 1 114
char 1 114
char 1 101
char 1 110
char 1 116
char 1 84
char 1 105
char 1 101
char 1 114
char 1 0
align 1
LABELV $1072
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 71
char 1 65
char 1 77
char 1 69
char 1 0
align 1
LABELV $1038
char 1 37
char 1 115
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $1037
char 1 77
char 1 69
char 1 78
char 1 85
char 1 83
char 1 51
char 1 95
char 1 83
char 1 79
char 1 85
char 1 82
char 1 67
char 1 69
char 1 0
align 1
LABELV $1015
char 1 103
char 1 95
char 1 103
char 1 97
char 1 109
char 1 101
char 1 116
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $1012
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 115
char 1 112
char 1 101
char 1 99
char 1 116
char 1 97
char 1 116
char 1 101
char 1 0
align 1
LABELV $1011
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 98
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $1010
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $1009
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 106
char 1 111
char 1 105
char 1 110
char 1 0
align 1
LABELV $1008
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 97
char 1 112
char 1 112
char 1 108
char 1 121
char 1 0
align 1
LABELV $1005
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 110
char 1 111
char 1 110
char 1 101
char 1 99
char 1 111
char 1 110
char 1 102
char 1 105
char 1 103
char 1 109
char 1 101
char 1 0
align 1
LABELV $1004
char 1 121
char 1 101
char 1 115
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $1003
char 1 110
char 1 111
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $1002
char 1 103
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 80
char 1 111
char 1 119
char 1 101
char 1 114
char 1 68
char 1 105
char 1 115
char 1 97
char 1 98
char 1 108
char 1 101
char 1 0
align 1
LABELV $999
char 1 121
char 1 101
char 1 115
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $998
char 1 110
char 1 111
char 1 115
char 1 97
char 1 98
char 1 101
char 1 114
char 1 0
align 1
LABELV $992
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 95
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 0
align 1
LABELV $952
char 1 37
char 1 48
char 1 50
char 1 105
char 1 58
char 1 37
char 1 48
char 1 50
char 1 105
char 1 0
align 1
LABELV $937
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 117
char 1 110
char 1 107
char 1 110
char 1 111
char 1 119
char 1 110
char 1 109
char 1 97
char 1 112
char 1 0
align 1
LABELV $922
char 1 117
char 1 105
char 1 95
char 1 99
char 1 117
char 1 114
char 1 114
char 1 101
char 1 110
char 1 116
char 1 77
char 1 97
char 1 112
char 1 0
align 1
LABELV $920
char 1 117
char 1 105
char 1 95
char 1 99
char 1 117
char 1 114
char 1 114
char 1 101
char 1 110
char 1 116
char 1 78
char 1 101
char 1 116
char 1 77
char 1 97
char 1 112
char 1 0
align 1
LABELV $902
char 1 72
char 1 117
char 1 109
char 1 97
char 1 110
char 1 0
align 1
LABELV $901
char 1 67
char 1 108
char 1 111
char 1 115
char 1 101
char 1 100
char 1 0
align 1
LABELV $887
char 1 115
char 1 118
char 1 95
char 1 109
char 1 97
char 1 120
char 1 67
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $883
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 116
char 1 101
char 1 97
char 1 109
char 1 37
char 1 105
char 1 0
align 1
LABELV $882
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 116
char 1 101
char 1 97
char 1 109
char 1 37
char 1 105
char 1 0
align 1
LABELV $876
char 1 82
char 1 101
char 1 100
char 1 0
align 1
LABELV $875
char 1 66
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $874
char 1 37
char 1 115
char 1 58
char 1 32
char 1 37
char 1 115
char 1 0
align 1
LABELV $867
char 1 117
char 1 105
char 1 95
char 1 114
char 1 101
char 1 100
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $866
char 1 117
char 1 105
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 84
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $860
char 1 68
char 1 97
char 1 114
char 1 107
char 1 0
char 1 0
align 1
LABELV $857
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 95
char 1 112
char 1 108
char 1 97
char 1 121
char 1 101
char 1 114
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 0
align 1
LABELV $856
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $855
char 1 100
char 1 97
char 1 114
char 1 107
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $854
char 1 100
char 1 97
char 1 114
char 1 107
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $853
char 1 108
char 1 105
char 1 103
char 1 104
char 1 116
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $850
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 97
char 1 108
char 1 108
char 1 111
char 1 99
char 1 0
align 1
LABELV $849
char 1 76
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
char 1 0
align 1
LABELV $843
char 1 117
char 1 105
char 1 95
char 1 109
char 1 121
char 1 116
char 1 101
char 1 97
char 1 109
char 1 0
align 1
LABELV $840
char 1 103
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 66
char 1 97
char 1 115
char 1 101
char 1 100
char 1 84
char 1 101
char 1 97
char 1 109
char 1 115
char 1 0
align 1
LABELV $833
char 1 68
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 0
char 1 0
align 1
LABELV $832
char 1 66
char 1 108
char 1 117
char 1 101
char 1 0
char 1 0
align 1
LABELV $830
char 1 82
char 1 101
char 1 100
char 1 0
char 1 0
align 1
LABELV $818
char 1 37
char 1 105
char 1 0
char 1 0
align 1
LABELV $809
char 1 103
char 1 95
char 1 115
char 1 112
char 1 83
char 1 107
char 1 105
char 1 108
char 1 108
char 1 0
align 1
LABELV $775
char 1 37
char 1 115
char 1 46
char 1 114
char 1 111
char 1 113
char 1 0
align 1
LABELV $756
char 1 37
char 1 115
char 1 95
char 1 110
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $751
char 1 37
char 1 115
char 1 95
char 1 109
char 1 101
char 1 116
char 1 97
char 1 108
char 1 0
align 1
LABELV $723
char 1 117
char 1 105
char 1 95
char 1 106
char 1 111
char 1 105
char 1 110
char 1 71
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $713
char 1 65
char 1 85
char 1 84
char 1 79
char 1 83
char 1 87
char 1 73
char 1 84
char 1 67
char 1 72
char 1 48
char 1 0
align 1
LABELV $711
char 1 65
char 1 85
char 1 84
char 1 79
char 1 83
char 1 87
char 1 73
char 1 84
char 1 67
char 1 72
char 1 51
char 1 0
align 1
LABELV $709
char 1 65
char 1 85
char 1 84
char 1 79
char 1 83
char 1 87
char 1 73
char 1 84
char 1 67
char 1 72
char 1 50
char 1 0
align 1
LABELV $705
char 1 65
char 1 85
char 1 84
char 1 79
char 1 83
char 1 87
char 1 73
char 1 84
char 1 67
char 1 72
char 1 49
char 1 0
align 1
LABELV $704
char 1 99
char 1 103
char 1 95
char 1 97
char 1 117
char 1 116
char 1 111
char 1 115
char 1 119
char 1 105
char 1 116
char 1 99
char 1 104
char 1 0
align 1
LABELV $700
char 1 117
char 1 105
char 1 95
char 1 97
char 1 99
char 1 116
char 1 117
char 1 97
char 1 108
char 1 78
char 1 101
char 1 116
char 1 71
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $699
char 1 117
char 1 105
char 1 95
char 1 110
char 1 101
char 1 116
char 1 71
char 1 97
char 1 109
char 1 101
char 1 84
char 1 121
char 1 112
char 1 101
char 1 0
align 1
LABELV $688
char 1 102
char 1 114
char 1 97
char 1 103
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $687
char 1 99
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 108
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $686
char 1 117
char 1 105
char 1 95
char 1 102
char 1 114
char 1 97
char 1 103
char 1 76
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $685
char 1 37
char 1 100
char 1 0
align 1
LABELV $684
char 1 117
char 1 105
char 1 95
char 1 99
char 1 97
char 1 112
char 1 116
char 1 117
char 1 114
char 1 101
char 1 76
char 1 105
char 1 109
char 1 105
char 1 116
char 1 0
align 1
LABELV $680
char 1 117
char 1 105
char 1 95
char 1 116
char 1 101
char 1 97
char 1 109
char 1 78
char 1 97
char 1 109
char 1 101
char 1 0
align 1
LABELV $678
char 1 104
char 1 97
char 1 110
char 1 100
char 1 105
char 1 99
char 1 97
char 1 112
char 1 0
align 1
LABELV $676
char 1 53
char 1 0
align 1
LABELV $675
char 1 49
char 1 48
char 1 0
align 1
LABELV $674
char 1 49
char 1 53
char 1 0
align 1
LABELV $673
char 1 50
char 1 48
char 1 0
align 1
LABELV $672
char 1 50
char 1 53
char 1 0
align 1
LABELV $671
char 1 51
char 1 48
char 1 0
align 1
LABELV $670
char 1 51
char 1 53
char 1 0
align 1
LABELV $669
char 1 52
char 1 48
char 1 0
align 1
LABELV $668
char 1 52
char 1 53
char 1 0
align 1
LABELV $667
char 1 53
char 1 48
char 1 0
align 1
LABELV $666
char 1 53
char 1 53
char 1 0
align 1
LABELV $665
char 1 54
char 1 48
char 1 0
align 1
LABELV $664
char 1 54
char 1 53
char 1 0
align 1
LABELV $663
char 1 55
char 1 48
char 1 0
align 1
LABELV $662
char 1 55
char 1 53
char 1 0
align 1
LABELV $661
char 1 56
char 1 48
char 1 0
align 1
LABELV $660
char 1 56
char 1 53
char 1 0
align 1
LABELV $659
char 1 57
char 1 48
char 1 0
align 1
LABELV $658
char 1 57
char 1 53
char 1 0
align 1
LABELV $657
char 1 78
char 1 111
char 1 110
char 1 101
char 1 0
align 1
LABELV $656
char 1 117
char 1 105
char 1 47
char 1 106
char 1 107
char 1 50
char 1 109
char 1 112
char 1 47
char 1 103
char 1 97
char 1 109
char 1 101
char 1 105
char 1 110
char 1 102
char 1 111
char 1 46
char 1 116
char 1 120
char 1 116
char 1 0
align 1
LABELV $652
char 1 117
char 1 105
char 1 95
char 1 109
char 1 101
char 1 110
char 1 117
char 1 70
char 1 105
char 1 108
char 1 101
char 1 115
char 1 77
char 1 80
char 1 0
align 1
LABELV $651
char 1 117
char 1 105
char 1 47
char 1 106
char 1 107
char 1 50
char 1 109
char 1 112
char 1 105
char 1 110
char 1 103
char 1 97
char 1 109
char 1 101
char 1 46
char 1 116
char 1 120
char 1 116
char 1 0
align 1
LABELV $644
char 1 85
char 1 73
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 108
char 1 111
char 1 97
char 1 100
char 1 32
char 1 116
char 1 105
char 1 109
char 1 101
char 1 32
char 1 61
char 1 32
char 1 37
char 1 100
char 1 32
char 1 109
char 1 105
char 1 108
char 1 108
char 1 105
char 1 32
char 1 115
char 1 101
char 1 99
char 1 111
char 1 110
char 1 100
char 1 115
char 1 10
char 1 0
align 1
LABELV $641
char 1 108
char 1 111
char 1 97
char 1 100
char 1 109
char 1 101
char 1 110
char 1 117
char 1 0
align 1
LABELV $622
char 1 94
char 1 49
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 58
char 1 32
char 1 117
char 1 105
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 46
char 1 116
char 1 120
char 1 116
char 1 44
char 1 32
char 1 117
char 1 110
char 1 97
char 1 98
char 1 108
char 1 101
char 1 32
char 1 116
char 1 111
char 1 32
char 1 99
char 1 111
char 1 110
char 1 116
char 1 105
char 1 110
char 1 117
char 1 101
char 1 33
char 1 10
char 1 0
align 1
LABELV $619
char 1 117
char 1 105
char 1 47
char 1 106
char 1 107
char 1 50
char 1 109
char 1 112
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 46
char 1 116
char 1 120
char 1 116
char 1 0
align 1
LABELV $618
char 1 94
char 1 51
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 58
char 1 32
char 1 37
char 1 115
char 1 44
char 1 32
char 1 117
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 10
char 1 0
align 1
LABELV $615
char 1 117
char 1 105
char 1 47
char 1 106
char 1 107
char 1 50
char 1 109
char 1 112
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 100
char 1 101
char 1 102
char 1 46
char 1 104
char 1 0
align 1
LABELV $595
char 1 109
char 1 101
char 1 110
char 1 117
char 1 100
char 1 101
char 1 102
char 1 0
align 1
LABELV $589
char 1 97
char 1 115
char 1 115
char 1 101
char 1 116
char 1 71
char 1 108
char 1 111
char 1 98
char 1 97
char 1 108
char 1 68
char 1 101
char 1 102
char 1 0
align 1
LABELV $575
char 1 80
char 1 97
char 1 114
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 58
char 1 37
char 1 115
char 1 10
char 1 0
align 1
LABELV $563
char 1 115
char 1 104
char 1 97
char 1 100
char 1 111
char 1 119
char 1 67
char 1 111
char 1 108
char 1 111
char 1 114
char 1 0
align 1
LABELV $555
char 1 115
char 1 104
char 1 97
char 1 100
char 1 111
char 1 119
char 1 89
char 1 0
align 1
LABELV $547
char 1 115
char 1 104
char 1 97
char 1 100
char 1 111
char 1 119
char 1 88
char 1 0
align 1
LABELV $539
char 1 102
char 1 97
char 1 100
char 1 101
char 1 65
char 1 109
char 1 111
char 1 117
char 1 110
char 1 116
char 1 0
align 1
LABELV $531
char 1 102
char 1 97
char 1 100
char 1 101
char 1 67
char 1 121
char 1 99
char 1 108
char 1 101
char 1 0
align 1
LABELV $523
char 1 102
char 1 97
char 1 100
char 1 101
char 1 67
char 1 108
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $515
char 1 109
char 1 101
char 1 110
char 1 117
char 1 66
char 1 117
char 1 122
char 1 122
char 1 83
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $507
char 1 105
char 1 116
char 1 101
char 1 109
char 1 70
char 1 111
char 1 99
char 1 117
char 1 115
char 1 83
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $499
char 1 109
char 1 101
char 1 110
char 1 117
char 1 69
char 1 120
char 1 105
char 1 116
char 1 83
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $491
char 1 109
char 1 101
char 1 110
char 1 117
char 1 69
char 1 110
char 1 116
char 1 101
char 1 114
char 1 83
char 1 111
char 1 117
char 1 110
char 1 100
char 1 0
align 1
LABELV $483
char 1 103
char 1 114
char 1 97
char 1 100
char 1 105
char 1 101
char 1 110
char 1 116
char 1 98
char 1 97
char 1 114
char 1 0
align 1
LABELV $475
char 1 66
char 1 97
char 1 100
char 1 32
char 1 49
char 1 115
char 1 116
char 1 32
char 1 112
char 1 97
char 1 114
char 1 97
char 1 109
char 1 101
char 1 116
char 1 101
char 1 114
char 1 32
char 1 102
char 1 111
char 1 114
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 39
char 1 99
char 1 117
char 1 114
char 1 115
char 1 111
char 1 114
char 1 39
char 1 0
align 1
LABELV $470
char 1 99
char 1 117
char 1 114
char 1 115
char 1 111
char 1 114
char 1 0
align 1
LABELV $466
char 1 66
char 1 97
char 1 100
char 1 32
char 1 49
char 1 115
char 1 116
char 1 32
char 1 112
char 1 97
char 1 114
char 1 97
char 1 109
char 1 101
char 1 116
char 1 101
char 1 114
char 1 32
char 1 102
char 1 111
char 1 114
char 1 32
char 1 107
char 1 101
char 1 121
char 1 119
char 1 111
char 1 114
char 1 100
char 1 32
char 1 39
char 1 115
char 1 116
char 1 114
char 1 105
char 1 112
char 1 101
char 1 100
char 1 70
char 1 105
char 1 108
char 1 101
char 1 39
char 1 0
align 1
LABELV $465
char 1 94
char 1 51
char 1 0
align 1
LABELV $462
char 1 115
char 1 116
char 1 114
char 1 105
char 1 112
char 1 101
char 1 100
char 1 70
char 1 105
char 1 108
char 1 101
char 1 0
align 1
LABELV $453
char 1 98
char 1 105
char 1 103
char 1 70
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $444
char 1 115
char 1 109
char 1 97
char 1 108
char 1 108
char 1 70
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $433
char 1 102
char 1 111
char 1 110
char 1 116
char 1 0
align 1
LABELV $429
char 1 125
char 1 0
align 1
LABELV $420
char 1 123
char 1 0
align 1
LABELV $413
char 1 94
char 1 49
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 116
char 1 111
char 1 111
char 1 32
char 1 108
char 1 97
char 1 114
char 1 103
char 1 101
char 1 58
char 1 32
char 1 37
char 1 115
char 1 32
char 1 105
char 1 115
char 1 32
char 1 37
char 1 105
char 1 44
char 1 32
char 1 109
char 1 97
char 1 120
char 1 32
char 1 97
char 1 108
char 1 108
char 1 111
char 1 119
char 1 101
char 1 100
char 1 32
char 1 105
char 1 115
char 1 32
char 1 37
char 1 105
char 1 0
align 1
LABELV $410
char 1 94
char 1 49
char 1 109
char 1 101
char 1 110
char 1 117
char 1 32
char 1 102
char 1 105
char 1 108
char 1 101
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 102
char 1 111
char 1 117
char 1 110
char 1 100
char 1 58
char 1 32
char 1 37
char 1 115
char 1 44
char 1 32
char 1 117
char 1 115
char 1 105
char 1 110
char 1 103
char 1 32
char 1 100
char 1 101
char 1 102
char 1 97
char 1 117
char 1 108
char 1 116
char 1 10
char 1 0
align 1
LABELV $393
char 1 117
char 1 105
char 1 95
char 1 114
char 1 97
char 1 110
char 1 107
char 1 67
char 1 104
char 1 97
char 1 110
char 1 103
char 1 101
char 1 0
align 1
LABELV $375
char 1 83
char 1 69
char 1 84
char 1 95
char 1 78
char 1 69
char 1 87
char 1 95
char 1 82
char 1 65
char 1 78
char 1 75
char 1 0
align 1
LABELV $374
char 1 73
char 1 78
char 1 71
char 1 65
char 1 77
char 1 69
char 1 84
char 1 69
char 1 88
char 1 84
char 1 0
align 1
LABELV $341
char 1 37
char 1 115
char 1 95
char 1 37
char 1 115
char 1 0
align 1
LABELV $336
char 1 49
char 1 0
align 1
LABELV $335
char 1 115
char 1 118
char 1 95
char 1 107
char 1 105
char 1 108
char 1 108
char 1 115
char 1 101
char 1 114
char 1 118
char 1 101
char 1 114
char 1 0
align 1
LABELV $334
char 1 99
char 1 103
char 1 95
char 1 116
char 1 104
char 1 105
char 1 114
char 1 100
char 1 80
char 1 101
char 1 114
char 1 115
char 1 111
char 1 110
char 1 0
align 1
LABELV $333
char 1 48
char 1 0
align 1
LABELV $332
char 1 99
char 1 103
char 1 95
char 1 99
char 1 97
char 1 109
char 1 101
char 1 114
char 1 97
char 1 79
char 1 114
char 1 98
char 1 105
char 1 116
char 1 0
align 1
LABELV $318
char 1 37
char 1 99
char 1 0
align 1
LABELV $264
char 1 103
char 1 102
char 1 120
char 1 47
char 1 50
char 1 100
char 1 47
char 1 99
char 1 114
char 1 111
char 1 115
char 1 115
char 1 104
char 1 97
char 1 105
char 1 114
char 1 37
char 1 99
char 1 0
align 1
LABELV $257
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 110
char 1 101
char 1 119
char 1 47
char 1 115
char 1 108
char 1 105
char 1 100
char 1 101
char 1 114
char 1 116
char 1 104
char 1 117
char 1 109
char 1 98
char 1 0
align 1
LABELV $254
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 110
char 1 101
char 1 119
char 1 47
char 1 115
char 1 108
char 1 105
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $251
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 95
char 1 116
char 1 104
char 1 117
char 1 109
char 1 98
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $248
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 95
char 1 97
char 1 114
char 1 114
char 1 111
char 1 119
char 1 95
char 1 114
char 1 105
char 1 103
char 1 104
char 1 116
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $245
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 95
char 1 97
char 1 114
char 1 114
char 1 111
char 1 119
char 1 95
char 1 108
char 1 101
char 1 102
char 1 116
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $242
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 95
char 1 97
char 1 114
char 1 114
char 1 111
char 1 119
char 1 95
char 1 117
char 1 112
char 1 95
char 1 97
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $239
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 95
char 1 97
char 1 114
char 1 114
char 1 111
char 1 119
char 1 95
char 1 100
char 1 119
char 1 110
char 1 95
char 1 97
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $236
char 1 103
char 1 102
char 1 120
char 1 47
char 1 109
char 1 101
char 1 110
char 1 117
char 1 115
char 1 47
char 1 115
char 1 99
char 1 114
char 1 111
char 1 108
char 1 108
char 1 98
char 1 97
char 1 114
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $233
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 119
char 1 104
char 1 105
char 1 116
char 1 101
char 1 0
align 1
LABELV $229
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 112
char 1 117
char 1 114
char 1 112
char 1 108
char 1 101
char 1 0
align 1
LABELV $225
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 98
char 1 108
char 1 117
char 1 101
char 1 0
align 1
LABELV $221
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 103
char 1 114
char 1 110
char 1 0
align 1
LABELV $217
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 121
char 1 101
char 1 108
char 1 0
align 1
LABELV $213
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 111
char 1 114
char 1 97
char 1 110
char 1 103
char 1 101
char 1 0
align 1
LABELV $209
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $206
char 1 109
char 1 101
char 1 110
char 1 117
char 1 47
char 1 97
char 1 114
char 1 116
char 1 47
char 1 102
char 1 120
char 1 95
char 1 98
char 1 97
char 1 115
char 1 101
char 1 0
align 1
LABELV $203
char 1 117
char 1 105
char 1 47
char 1 97
char 1 115
char 1 115
char 1 101
char 1 116
char 1 115
char 1 47
char 1 103
char 1 114
char 1 97
char 1 100
char 1 105
char 1 101
char 1 110
char 1 116
char 1 98
char 1 97
char 1 114
char 1 50
char 1 46
char 1 116
char 1 103
char 1 97
char 1 0
align 1
LABELV $184
char 1 73
char 1 80
char 1 88
char 1 0
align 1
LABELV $183
char 1 85
char 1 68
char 1 80
char 1 0
align 1
LABELV $182
char 1 63
char 1 63
char 1 63
char 1 0
align 1
LABELV $181
char 1 84
char 1 69
char 1 65
char 1 77
char 1 84
char 1 79
char 1 85
char 1 82
char 1 78
char 1 65
char 1 77
char 1 69
char 1 78
char 1 84
char 1 0
align 1
LABELV $180
char 1 67
char 1 84
char 1 89
char 1 0
align 1
LABELV $179
char 1 67
char 1 84
char 1 70
char 1 0
align 1
LABELV $178
char 1 78
char 1 47
char 1 65
char 1 0
align 1
LABELV $177
char 1 84
char 1 69
char 1 65
char 1 77
char 1 32
char 1 70
char 1 70
char 1 65
char 1 0
align 1
LABELV $176
char 1 83
char 1 80
char 1 0
align 1
LABELV $175
char 1 68
char 1 85
char 1 69
char 1 76
char 1 0
align 1
LABELV $174
char 1 74
char 1 69
char 1 68
char 1 73
char 1 77
char 1 65
char 1 83
char 1 84
char 1 69
char 1 82
char 1 0
align 1
LABELV $173
char 1 72
char 1 79
char 1 76
char 1 79
char 1 67
char 1 82
char 1 79
char 1 78
char 1 0
align 1
LABELV $172
char 1 70
char 1 70
char 1 65
char 1 0
align 1
LABELV $171
char 1 74
char 1 101
char 1 100
char 1 105
char 1 32
char 1 75
char 1 110
char 1 105
char 1 103
char 1 104
char 1 116
char 1 32
char 1 50
char 1 0
align 1
LABELV $170
char 1 0
align 1
LABELV $169
char 1 65
char 1 108
char 1 108
char 1 0
align 1
LABELV $168
char 1 70
char 1 97
char 1 118
char 1 111
char 1 114
char 1 105
char 1 116
char 1 101
char 1 115
char 1 0
align 1
LABELV $167
char 1 73
char 1 110
char 1 116
char 1 101
char 1 114
char 1 110
char 1 101
char 1 116
char 1 0
align 1
LABELV $166
char 1 76
char 1 111
char 1 99
char 1 97
char 1 108
char 1 0
align 1
LABELV $165
char 1 83
char 1 75
char 1 73
char 1 76
char 1 76
char 1 53
char 1 0
align 1
LABELV $164
char 1 83
char 1 75
char 1 73
char 1 76
char 1 76
char 1 52
char 1 0
align 1
LABELV $163
char 1 83
char 1 75
char 1 73
char 1 76
char 1 76
char 1 51
char 1 0
align 1
LABELV $162
char 1 83
char 1 75
char 1 73
char 1 76
char 1 76
char 1 50
char 1 0
align 1
LABELV $161
char 1 83
char 1 75
char 1 73
char 1 76
char 1 76
char 1 49
char 1 0
align 1
LABELV $160
char 1 68
char 1 101
char 1 99
char 1 0
align 1
LABELV $159
char 1 78
char 1 111
char 1 118
char 1 0
align 1
LABELV $158
char 1 79
char 1 99
char 1 116
char 1 0
align 1
LABELV $157
char 1 83
char 1 101
char 1 112
char 1 0
align 1
LABELV $156
char 1 65
char 1 117
char 1 103
char 1 0
align 1
LABELV $155
char 1 74
char 1 117
char 1 108
char 1 0
align 1
LABELV $154
char 1 74
char 1 117
char 1 110
char 1 0
align 1
LABELV $153
char 1 77
char 1 97
char 1 121
char 1 0
align 1
LABELV $152
char 1 65
char 1 112
char 1 114
char 1 0
align 1
LABELV $151
char 1 77
char 1 97
char 1 114
char 1 0
align 1
LABELV $150
char 1 70
char 1 101
char 1 98
char 1 0
align 1
LABELV $149
char 1 74
char 1 97
char 1 110
char 1 0

data
export ctfStateNames
align 4
LABELV ctfStateNames
address $83
address $84
address $85
address $86
address $87
address $88
address $89
export ctfStateDescriptions
align 4
LABELV ctfStateDescriptions
address $90
address $91
address $92
address $93
address $94
address $95
export sagaStateDescriptions
align 4
LABELV sagaStateDescriptions
address $90
address $96
address $97
export teamplayStateDescriptions
align 4
LABELV teamplayStateDescriptions
address $90
address $98
address $99
address $100
export BotStraightTPOrderCheck
code
proc BotStraightTPOrderCheck 4 0
file "../ai_main.c"
line 122
;1:// Copyright (C) 1999-2000 Id Software, Inc.
;2://
;3:
;4:/*****************************************************************************
;5: * name:		ai_main.c
;6: *
;7: * desc:		Quake3 bot AI
;8: *
;9: * $Archive: /MissionPack/code/game/ai_main.c $
;10: * $Author: Mrelusive $ 
;11: * $Revision: 35 $
;12: * $Modtime: 6/06/01 1:11p $
;13: * $Date: 6/06/01 12:06p $
;14: *
;15: *****************************************************************************/
;16:
;17:
;18:#include "g_local.h"
;19:#include "q_shared.h"
;20:#include "botlib.h"		//bot lib interface
;21:#include "be_aas.h"
;22:#include "be_ea.h"
;23:#include "be_ai_char.h"
;24:#include "be_ai_chat.h"
;25:#include "be_ai_gen.h"
;26:#include "be_ai_goal.h"
;27:#include "be_ai_move.h"
;28:#include "be_ai_weap.h"
;29://
;30:#include "ai_main.h"
;31:#include "w_saber.h"
;32://
;33:#include "chars.h"
;34:#include "inv.h"
;35:#include "syn.h"
;36:
;37:/*
;38:#define BOT_CTF_DEBUG	1
;39:*/
;40:
;41:#define MAX_PATH		144
;42:
;43:#define BOT_THINK_TIME	0
;44:
;45://bot states
;46:bot_state_t	*botstates[MAX_CLIENTS];
;47://number of bots
;48:int numbots;
;49://floating point time
;50:float floattime;
;51://time to do a regular update
;52:float regularupdate_time;
;53://
;54:
;55://for saga:
;56:extern int rebel_attackers;
;57:extern int imperial_attackers;
;58:
;59:boteventtracker_t gBotEventTracker[MAX_CLIENTS];
;60:
;61://rww - new bot cvars..
;62:vmCvar_t bot_forcepowers;
;63:vmCvar_t bot_forgimmick;
;64:#ifdef _DEBUG
;65:vmCvar_t bot_nogoals;
;66:vmCvar_t bot_debugmessages;
;67:#endif
;68:
;69:vmCvar_t bot_attachments;
;70:vmCvar_t bot_camp;
;71:
;72:vmCvar_t bot_wp_info;
;73:vmCvar_t bot_wp_edit;
;74:vmCvar_t bot_wp_clearweight;
;75:vmCvar_t bot_wp_distconnect;
;76:vmCvar_t bot_wp_visconnect;
;77://end rww
;78:
;79:wpobject_t *flagRed;
;80:wpobject_t *oFlagRed;
;81:wpobject_t *flagBlue;
;82:wpobject_t *oFlagBlue;
;83:
;84:gentity_t *eFlagRed;
;85:gentity_t *droppedRedFlag;
;86:gentity_t *eFlagBlue;
;87:gentity_t *droppedBlueFlag;
;88:
;89:char *ctfStateNames[] = {
;90:	"CTFSTATE_NONE",
;91:	"CTFSTATE_ATTACKER",
;92:	"CTFSTATE_DEFENDER",
;93:	"CTFSTATE_RETRIEVAL",
;94:	"CTFSTATE_GUARDCARRIER",
;95:	"CTFSTATE_GETFLAGHOME",
;96:	"CTFSTATE_MAXCTFSTATES"
;97:};
;98:
;99:char *ctfStateDescriptions[] = {
;100:	"I'm not occupied",
;101:	"I'm attacking the enemy's base",
;102:	"I'm defending our base",
;103:	"I'm getting our flag back",
;104:	"I'm escorting our flag carrier",
;105:	"I've got the enemy's flag"
;106:};
;107:
;108:char *sagaStateDescriptions[] = {
;109:	"I'm not occupied",
;110:	"I'm attemtping to complete the current objective",
;111:	"I'm preventing the enemy from completing their objective"
;112:};
;113:
;114:char *teamplayStateDescriptions[] = {
;115:	"I'm not occupied",
;116:	"I'm following my squad commander",
;117:	"I'm assisting my commanding",
;118:	"I'm attempting to regroup and form a new squad"
;119:};
;120:
;121:void BotStraightTPOrderCheck(gentity_t *ent, int ordernum, bot_state_t *bs)
;122:{
line 123
;123:	switch (ordernum)
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
EQI4 $104
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $107
ADDRLP4 0
INDIRI4
CNSTI4 2
EQI4 $108
ADDRGP4 $102
JUMPV
line 124
;124:	{
LABELV $104
line 126
;125:	case 0:
;126:		if (bs->squadLeader == ent)
ADDRFP4 8
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 0
INDIRP4
CVPU4 4
NEU4 $103
line 127
;127:		{
line 128
;128:			bs->teamplayState = 0;
ADDRFP4 8
INDIRP4
CNSTI4 2684
ADDP4
CNSTI4 0
ASGNI4
line 129
;129:			bs->squadLeader = NULL;
ADDRFP4 8
INDIRP4
CNSTI4 1812
ADDP4
CNSTP4 0
ASGNP4
line 130
;130:		}
line 131
;131:		break;
ADDRGP4 $103
JUMPV
LABELV $107
line 133
;132:	case TEAMPLAYSTATE_FOLLOWING:
;133:		bs->teamplayState = ordernum;
ADDRFP4 8
INDIRP4
CNSTI4 2684
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 134
;134:		bs->isSquadLeader = 0;
ADDRFP4 8
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 0
ASGNI4
line 135
;135:		bs->squadLeader = ent;
ADDRFP4 8
INDIRP4
CNSTI4 1812
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 136
;136:		bs->wpDestSwitchTime = 0;
ADDRFP4 8
INDIRP4
CNSTI4 1968
ADDP4
CNSTF4 0
ASGNF4
line 137
;137:		break;
ADDRGP4 $103
JUMPV
LABELV $108
line 139
;138:	case TEAMPLAYSTATE_ASSISTING:
;139:		bs->teamplayState = ordernum;
ADDRFP4 8
INDIRP4
CNSTI4 2684
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 140
;140:		bs->isSquadLeader = 0;
ADDRFP4 8
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 0
ASGNI4
line 141
;141:		bs->squadLeader = ent;
ADDRFP4 8
INDIRP4
CNSTI4 1812
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 142
;142:		bs->wpDestSwitchTime = 0;
ADDRFP4 8
INDIRP4
CNSTI4 1968
ADDP4
CNSTF4 0
ASGNF4
line 143
;143:		break;
ADDRGP4 $103
JUMPV
LABELV $102
line 145
;144:	default:
;145:		bs->teamplayState = ordernum;
ADDRFP4 8
INDIRP4
CNSTI4 2684
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 146
;146:		break;
LABELV $103
line 148
;147:	}
;148:}
LABELV $101
endproc BotStraightTPOrderCheck 4 0
export BotSelectWeapon
proc BotSelectWeapon 0 8
line 151
;149:
;150:void BotSelectWeapon(int client, int weapon)
;151:{
line 152
;152:	if (weapon <= WP_NONE)
ADDRFP4 4
INDIRI4
CNSTI4 0
GTI4 $110
line 153
;153:	{
line 154
;154:		return;
ADDRGP4 $109
JUMPV
LABELV $110
line 156
;155:	}
;156:	trap_EA_SelectWeapon(client, weapon);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 trap_EA_SelectWeapon
CALLV
pop
line 157
;157:}
LABELV $109
endproc BotSelectWeapon 0 8
export BotReportStatus
proc BotReportStatus 4 8
line 160
;158:
;159:void BotReportStatus(bot_state_t *bs)
;160:{
line 161
;161:	if (g_gametype.integer == GT_TEAM)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $113
line 162
;162:	{
line 163
;163:		trap_EA_SayTeam(bs->client, teamplayStateDescriptions[bs->teamplayState]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 2684
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 teamplayStateDescriptions
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 164
;164:	}
ADDRGP4 $114
JUMPV
LABELV $113
line 165
;165:	else if (g_gametype.integer == GT_SAGA)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $116
line 166
;166:	{
line 167
;167:		trap_EA_SayTeam(bs->client, sagaStateDescriptions[bs->sagaState]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 sagaStateDescriptions
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 168
;168:	}
ADDRGP4 $117
JUMPV
LABELV $116
line 169
;169:	else if (g_gametype.integer == GT_CTF || g_gametype.integer == GT_CTY)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $123
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $119
LABELV $123
line 170
;170:	{
line 171
;171:		trap_EA_SayTeam(bs->client, ctfStateDescriptions[bs->ctfState]);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 ctfStateDescriptions
ADDP4
INDIRP4
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 172
;172:	}
LABELV $119
LABELV $117
LABELV $114
line 173
;173:}
LABELV $112
endproc BotReportStatus 4 8
export BotOrder
proc BotOrder 52 12
line 176
;174:
;175:void BotOrder(gentity_t *ent, int clientnum, int ordernum)
;176:{
line 177
;177:	int stateMin = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 178
;178:	int stateMax = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 179
;179:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 181
;180:
;181:	if (!ent || !ent->client || !ent->client->sess.teamLeader)
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $128
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $128
ADDRLP4 20
INDIRP4
CNSTI4 1560
ADDP4
INDIRI4
CNSTI4 0
NEI4 $125
LABELV $128
line 182
;182:	{
line 183
;183:		return;
ADDRGP4 $124
JUMPV
LABELV $125
line 186
;184:	}
;185:
;186:	if (clientnum != -1 && !botstates[clientnum])
ADDRLP4 24
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 -1
EQI4 $129
ADDRLP4 24
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $129
line 187
;187:	{
line 188
;188:		return;
ADDRGP4 $124
JUMPV
LABELV $129
line 191
;189:	}
;190:
;191:	if (clientnum != -1 && !OnSameTeam(ent, &g_entities[clientnum]))
ADDRLP4 28
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 -1
EQI4 $131
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 28
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $131
line 192
;192:	{
line 193
;193:		return;
ADDRGP4 $124
JUMPV
LABELV $131
line 196
;194:	}
;195:
;196:	if (g_gametype.integer != GT_CTF && g_gametype.integer != GT_CTY && g_gametype.integer != GT_SAGA &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $133
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $133
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
EQI4 $133
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
EQI4 $133
line 198
;197:		g_gametype.integer != GT_TEAM)
;198:	{
line 199
;199:		return;
ADDRGP4 $124
JUMPV
LABELV $133
line 202
;200:	}
;201:
;202:	if (g_gametype.integer == GT_CTF || g_gametype.integer == GT_CTY)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $143
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $139
LABELV $143
line 203
;203:	{
line 204
;204:		stateMin = CTFSTATE_NONE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 205
;205:		stateMax = CTFSTATE_MAXCTFSTATES;
ADDRLP4 8
CNSTI4 6
ASGNI4
line 206
;206:	}
ADDRGP4 $140
JUMPV
LABELV $139
line 207
;207:	else if (g_gametype.integer == GT_SAGA)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $144
line 208
;208:	{
line 209
;209:		stateMin = SAGASTATE_NONE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 210
;210:		stateMax = SAGASTATE_MAXSAGASTATES;
ADDRLP4 8
CNSTI4 3
ASGNI4
line 211
;211:	}
ADDRGP4 $145
JUMPV
LABELV $144
line 212
;212:	else if (g_gametype.integer == GT_TEAM)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $147
line 213
;213:	{
line 214
;214:		stateMin = TEAMPLAYSTATE_NONE;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 215
;215:		stateMax = TEAMPLAYSTATE_MAXTPSTATES;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 216
;216:	}
LABELV $147
LABELV $145
LABELV $140
line 218
;217:
;218:	if ((ordernum < stateMin && ordernum != -1) || ordernum >= stateMax)
ADDRLP4 36
ADDRFP4 8
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 4
INDIRI4
GEI4 $153
ADDRLP4 36
INDIRI4
CNSTI4 -1
NEI4 $152
LABELV $153
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $150
LABELV $152
line 219
;219:	{
line 220
;220:		return;
ADDRGP4 $124
JUMPV
LABELV $150
line 223
;221:	}
;222:
;223:	if (clientnum != -1)
ADDRFP4 4
INDIRI4
CNSTI4 -1
EQI4 $162
line 224
;224:	{
line 225
;225:		if (ordernum == -1)
ADDRFP4 8
INDIRI4
CNSTI4 -1
NEI4 $156
line 226
;226:		{
line 227
;227:			BotReportStatus(botstates[clientnum]);
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 228
;228:		}
ADDRGP4 $155
JUMPV
LABELV $156
line 230
;229:		else
;230:		{
line 231
;231:			BotStraightTPOrderCheck(ent, ordernum, botstates[clientnum]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotStraightTPOrderCheck
CALLV
pop
line 232
;232:			botstates[clientnum]->state_Forced = ordernum;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2692
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 233
;233:			botstates[clientnum]->chatObject = ent;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2232
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 234
;234:			botstates[clientnum]->chatAltObject = NULL;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 235
;235:			if (BotDoChat(botstates[clientnum], "OrderAccepted", 1))
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 $160
ARGP4
CNSTI4 1
ARGI4
ADDRLP4 40
ADDRGP4 BotDoChat
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $155
line 236
;236:			{
line 237
;237:				botstates[clientnum]->chatTeam = 1;
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2228
ADDP4
CNSTI4 1
ASGNI4
line 238
;238:			}
line 239
;239:		}
line 240
;240:	}
ADDRGP4 $155
JUMPV
line 242
;241:	else
;242:	{
LABELV $161
line 244
;243:		while (i < MAX_CLIENTS)
;244:		{
line 245
;245:			if (botstates[i] && OnSameTeam(ent, &g_entities[i]))
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $164
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 44
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $164
line 246
;246:			{
line 247
;247:				if (ordernum == -1)
ADDRFP4 8
INDIRI4
CNSTI4 -1
NEI4 $166
line 248
;248:				{
line 249
;249:					BotReportStatus(botstates[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotReportStatus
CALLV
pop
line 250
;250:				}
ADDRGP4 $167
JUMPV
LABELV $166
line 252
;251:				else
;252:				{
line 253
;253:					BotStraightTPOrderCheck(ent, ordernum, botstates[i]);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotStraightTPOrderCheck
CALLV
pop
line 254
;254:					botstates[i]->state_Forced = ordernum;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2692
ADDP4
ADDRFP4 8
INDIRI4
ASGNI4
line 255
;255:					botstates[i]->chatObject = ent;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2232
ADDP4
ADDRFP4 0
INDIRP4
ASGNP4
line 256
;256:					botstates[i]->chatAltObject = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 257
;257:					if (BotDoChat(botstates[i], "OrderAccepted", 0))
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 $160
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 48
ADDRGP4 BotDoChat
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $168
line 258
;258:					{
line 259
;259:						botstates[i]->chatTeam = 1;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2228
ADDP4
CNSTI4 1
ASGNI4
line 260
;260:					}
LABELV $168
line 261
;261:				}
LABELV $167
line 262
;262:			}
LABELV $164
line 264
;263:
;264:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 265
;265:		}
LABELV $162
line 243
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $161
line 266
;266:	}
LABELV $155
line 267
;267:}
LABELV $124
endproc BotOrder 52 12
export BotMindTricked
proc BotMindTricked 4 0
line 270
;268:
;269:int BotMindTricked(int botClient, int enemyClient)
;270:{
line 273
;271:	forcedata_t *fd;
;272:
;273:	if (!g_entities[enemyClient].client)
CNSTI4 828
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $171
line 274
;274:	{
line 275
;275:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $170
JUMPV
LABELV $171
line 278
;276:	}
;277:	
;278:	fd = &g_entities[enemyClient].client->ps.fd;
ADDRLP4 0
CNSTI4 828
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 760
ADDP4
ASGNP4
line 280
;279:
;280:	if (!fd)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $175
line 281
;281:	{
line 282
;282:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $170
JUMPV
LABELV $175
line 285
;283:	}
;284:
;285:	if (botClient > 47)
ADDRFP4 0
INDIRI4
CNSTI4 47
LEI4 $177
line 286
;286:	{
line 287
;287:		if (fd->forceMindtrickTargetIndex4 & (1 << (botClient-48)))
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
CNSTI4 48
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $178
line 288
;288:		{
line 289
;289:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
line 291
;290:		}
;291:	}
LABELV $177
line 292
;292:	else if (botClient > 31)
ADDRFP4 0
INDIRI4
CNSTI4 31
LEI4 $181
line 293
;293:	{
line 294
;294:		if (fd->forceMindtrickTargetIndex3 & (1 << (botClient-32)))
ADDRLP4 0
INDIRP4
CNSTI4 392
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
CNSTI4 32
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $182
line 295
;295:		{
line 296
;296:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
line 298
;297:		}
;298:	}
LABELV $181
line 299
;299:	else if (botClient > 15)
ADDRFP4 0
INDIRI4
CNSTI4 15
LEI4 $185
line 300
;300:	{
line 301
;301:		if (fd->forceMindtrickTargetIndex2 & (1 << (botClient-16)))
ADDRLP4 0
INDIRP4
CNSTI4 388
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
CNSTI4 16
SUBI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $186
line 302
;302:		{
line 303
;303:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
line 305
;304:		}
;305:	}
LABELV $185
line 307
;306:	else
;307:	{
line 308
;308:		if (fd->forceMindtrickTargetIndex & (1 << botClient))
ADDRLP4 0
INDIRP4
CNSTI4 384
ADDP4
INDIRI4
CNSTI4 1
ADDRFP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $189
line 309
;309:		{
line 310
;310:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $170
JUMPV
LABELV $189
line 312
;311:		}
;312:	}
LABELV $186
LABELV $182
LABELV $178
line 314
;313:
;314:	return 0;
CNSTI4 0
RETI4
LABELV $170
endproc BotMindTricked 4 0
export BotAI_Print
proc BotAI_Print 0 0
line 322
;315:}
;316:
;317:int BotGetWeaponRange(bot_state_t *bs);
;318:int PassLovedOneCheck(bot_state_t *bs, gentity_t *ent);
;319:
;320:void ExitLevel( void );
;321:
;322:void QDECL BotAI_Print(int type, char *fmt, ...) { return; }
LABELV $191
endproc BotAI_Print 0 0
export IsTeamplay
proc IsTeamplay 0 0
line 327
;323:
;324:qboolean WP_ForcePowerUsable( gentity_t *self, forcePowers_t forcePower );
;325:
;326:int IsTeamplay(void)
;327:{
line 328
;328:	if ( g_gametype.integer < GT_TEAM )
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
GEI4 $193
line 329
;329:	{
line 330
;330:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $192
JUMPV
LABELV $193
line 333
;331:	}
;332:
;333:	return 1;
CNSTI4 1
RETI4
LABELV $192
endproc IsTeamplay 0 0
export BotAI_GetClientState
proc BotAI_GetClientState 4 12
line 341
;334:}
;335:
;336:/*
;337:==================
;338:BotAI_GetClientState
;339:==================
;340:*/
;341:int BotAI_GetClientState( int clientNum, playerState_t *state ) {
line 344
;342:	gentity_t	*ent;
;343:
;344:	ent = &g_entities[clientNum];
ADDRLP4 0
CNSTI4 828
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 345
;345:	if ( !ent->inuse ) {
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
NEI4 $197
line 346
;346:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $196
JUMPV
LABELV $197
line 348
;347:	}
;348:	if ( !ent->client ) {
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $199
line 349
;349:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $196
JUMPV
LABELV $199
line 352
;350:	}
;351:
;352:	memcpy( state, &ent->client->ps, sizeof(playerState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ARGP4
CNSTI4 1368
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 353
;353:	return qtrue;
CNSTI4 1
RETI4
LABELV $196
endproc BotAI_GetClientState 4 12
export BotAI_GetEntityState
proc BotAI_GetEntityState 4 12
line 361
;354:}
;355:
;356:/*
;357:==================
;358:BotAI_GetEntityState
;359:==================
;360:*/
;361:int BotAI_GetEntityState( int entityNum, entityState_t *state ) {
line 364
;362:	gentity_t	*ent;
;363:
;364:	ent = &g_entities[entityNum];
ADDRLP4 0
CNSTI4 828
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 365
;365:	memset( state, 0, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 296
ARGI4
ADDRGP4 memset
CALLP4
pop
line 366
;366:	if (!ent->inuse) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
NEI4 $202
CNSTI4 0
RETI4
ADDRGP4 $201
JUMPV
LABELV $202
line 367
;367:	if (!ent->r.linked) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 296
ADDP4
INDIRI4
CNSTI4 0
NEI4 $204
CNSTI4 0
RETI4
ADDRGP4 $201
JUMPV
LABELV $204
line 368
;368:	if (ent->r.svFlags & SVF_NOCLIENT) return qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 304
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $206
CNSTI4 0
RETI4
ADDRGP4 $201
JUMPV
LABELV $206
line 369
;369:	memcpy( state, &ent->s, sizeof(entityState_t) );
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 296
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 370
;370:	return qtrue;
CNSTI4 1
RETI4
LABELV $201
endproc BotAI_GetEntityState 4 12
export BotAI_GetSnapshotEntity
proc BotAI_GetSnapshotEntity 8 12
line 378
;371:}
;372:
;373:/*
;374:==================
;375:BotAI_GetSnapshotEntity
;376:==================
;377:*/
;378:int BotAI_GetSnapshotEntity( int clientNum, int sequence, entityState_t *state ) {
line 381
;379:	int		entNum;
;380:
;381:	entNum = trap_BotGetSnapshotEntity( clientNum, sequence );
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 trap_BotGetSnapshotEntity
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 382
;382:	if ( entNum == -1 ) {
ADDRLP4 0
INDIRI4
CNSTI4 -1
NEI4 $209
line 383
;383:		memset(state, 0, sizeof(entityState_t));
ADDRFP4 8
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 296
ARGI4
ADDRGP4 memset
CALLP4
pop
line 384
;384:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $208
JUMPV
LABELV $209
line 387
;385:	}
;386:
;387:	BotAI_GetEntityState( entNum, state );
ADDRLP4 0
INDIRI4
ARGI4
ADDRFP4 8
INDIRP4
ARGP4
ADDRGP4 BotAI_GetEntityState
CALLI4
pop
line 389
;388:
;389:	return sequence + 1;
ADDRFP4 4
INDIRI4
CNSTI4 1
ADDI4
RETI4
LABELV $208
endproc BotAI_GetSnapshotEntity 8 12
export BotEntityInfo
proc BotEntityInfo 0 8
line 397
;390:}
;391:
;392:/*
;393:==============
;394:BotEntityInfo
;395:==============
;396:*/
;397:void BotEntityInfo(int entnum, aas_entityinfo_t *info) {
line 398
;398:	trap_AAS_EntityInfo(entnum, info);
ADDRFP4 0
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
ARGP4
ADDRGP4 trap_AAS_EntityInfo
CALLV
pop
line 399
;399:}
LABELV $211
endproc BotEntityInfo 0 8
export NumBots
proc NumBots 0 0
line 406
;400:
;401:/*
;402:==============
;403:NumBots
;404:==============
;405:*/
;406:int NumBots(void) {
line 407
;407:	return numbots;
ADDRGP4 numbots
INDIRI4
RETI4
LABELV $212
endproc NumBots 0 0
export AngleDifference
proc AngleDifference 4 0
line 415
;408:}
;409:
;410:/*
;411:==============
;412:AngleDifference
;413:==============
;414:*/
;415:float AngleDifference(float ang1, float ang2) {
line 418
;416:	float diff;
;417:
;418:	diff = ang1 - ang2;
ADDRLP4 0
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
SUBF4
ASGNF4
line 419
;419:	if (ang1 > ang2) {
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
LEF4 $214
line 420
;420:		if (diff > 180.0) diff -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $215
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 421
;421:	}
ADDRGP4 $215
JUMPV
LABELV $214
line 422
;422:	else {
line 423
;423:		if (diff < -180.0) diff += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $218
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $218
line 424
;424:	}
LABELV $215
line 425
;425:	return diff;
ADDRLP4 0
INDIRF4
RETF4
LABELV $213
endproc AngleDifference 4 0
export BotChangeViewAngle
proc BotChangeViewAngle 16 4
line 433
;426:}
;427:
;428:/*
;429:==============
;430:BotChangeViewAngle
;431:==============
;432:*/
;433:float BotChangeViewAngle(float angle, float ideal_angle, float speed) {
line 436
;434:	float move;
;435:
;436:	angle = AngleMod(angle);
ADDRFP4 0
INDIRF4
ARGF4
ADDRLP4 4
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 0
ADDRLP4 4
INDIRF4
ASGNF4
line 437
;437:	ideal_angle = AngleMod(ideal_angle);
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 8
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRFP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 438
;438:	if (angle == ideal_angle) return angle;
ADDRFP4 0
INDIRF4
ADDRFP4 4
INDIRF4
NEF4 $221
ADDRFP4 0
INDIRF4
RETF4
ADDRGP4 $220
JUMPV
LABELV $221
line 439
;439:	move = ideal_angle - angle;
ADDRLP4 0
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
SUBF4
ASGNF4
line 440
;440:	if (ideal_angle > angle) {
ADDRFP4 4
INDIRF4
ADDRFP4 0
INDIRF4
LEF4 $223
line 441
;441:		if (move > 180.0) move -= 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 1127481344
LEF4 $224
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 442
;442:	}
ADDRGP4 $224
JUMPV
LABELV $223
line 443
;443:	else {
line 444
;444:		if (move < -180.0) move += 360.0;
ADDRLP4 0
INDIRF4
CNSTF4 3274964992
GEF4 $227
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
LABELV $227
line 445
;445:	}
LABELV $224
line 446
;446:	if (move > 0) {
ADDRLP4 0
INDIRF4
CNSTF4 0
LEF4 $229
line 447
;447:		if (move > speed) move = speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
LEF4 $230
ADDRLP4 0
ADDRFP4 8
INDIRF4
ASGNF4
line 448
;448:	}
ADDRGP4 $230
JUMPV
LABELV $229
line 449
;449:	else {
line 450
;450:		if (move < -speed) move = -speed;
ADDRLP4 0
INDIRF4
ADDRFP4 8
INDIRF4
NEGF4
GEF4 $233
ADDRLP4 0
ADDRFP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $233
line 451
;451:	}
LABELV $230
line 452
;452:	return AngleMod(angle + move);
ADDRFP4 0
INDIRF4
ADDRLP4 0
INDIRF4
ADDF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 12
INDIRF4
RETF4
LABELV $220
endproc BotChangeViewAngle 16 4
export BotChangeViewAngles
proc BotChangeViewAngles 84 8
line 460
;453:}
;454:
;455:/*
;456:==============
;457:BotChangeViewAngles
;458:==============
;459:*/
;460:void BotChangeViewAngles(bot_state_t *bs, float thinktime) {
line 464
;461:	float diff, factor, maxchange, anglespeed, disired_speed;
;462:	int i;
;463:
;464:	if (bs->ideal_viewangles[PITCH] > 180) bs->ideal_viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 1780
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $236
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 1780
ADDP4
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $236
line 466
;465:	
;466:	if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $238
ADDRLP4 28
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $238
line 467
;467:	{
line 468
;468:		factor = bs->skills.turnspeed_combat*bs->settings.skill;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 32
INDIRP4
CNSTI4 2316
ADDP4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 1556
ADDP4
INDIRF4
MULF4
ASGNF4
line 469
;469:	}
ADDRGP4 $239
JUMPV
LABELV $238
line 471
;470:	else
;471:	{
line 472
;472:		factor = bs->skills.turnspeed;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 2312
ADDP4
INDIRF4
ASGNF4
line 473
;473:	}
LABELV $239
line 475
;474:
;475:	if (factor > 1)
ADDRLP4 12
INDIRF4
CNSTF4 1065353216
LEF4 $240
line 476
;476:	{
line 477
;477:		factor = 1;
ADDRLP4 12
CNSTF4 1065353216
ASGNF4
line 478
;478:	}
LABELV $240
line 479
;479:	if (factor < 0.001)
ADDRLP4 12
INDIRF4
CNSTF4 981668463
GEF4 $242
line 480
;480:	{
line 481
;481:		factor = 0.001f;
ADDRLP4 12
CNSTF4 981668463
ASGNF4
line 482
;482:	}
LABELV $242
line 484
;483:
;484:	maxchange = bs->skills.maxturn;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 2320
ADDP4
INDIRF4
ASGNF4
line 487
;485:
;486:	//if (maxchange < 240) maxchange = 240;
;487:	maxchange *= thinktime;
ADDRLP4 8
ADDRLP4 8
INDIRF4
ADDRFP4 4
INDIRF4
MULF4
ASGNF4
line 488
;488:	for (i = 0; i < 2; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $244
line 489
;489:		bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRF4
ARGF4
ADDRLP4 36
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 32
INDIRP4
ADDRLP4 36
INDIRF4
ASGNF4
line 490
;490:		bs->ideal_viewangles[i] = AngleMod(bs->ideal_viewangles[i]);
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1780
ADDP4
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
INDIRF4
ARGF4
ADDRLP4 44
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRF4
ASGNF4
line 491
;491:		diff = AngleDifference(bs->viewangles[i], bs->ideal_viewangles[i]);
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 1780
ADDP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 56
INDIRF4
ASGNF4
line 492
;492:		disired_speed = diff * factor;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
line 493
;493:		bs->viewanglespeed[i] += (bs->viewanglespeed[i] - disired_speed);
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
INDIRF4
ASGNF4
ADDRLP4 60
INDIRP4
ADDRLP4 64
INDIRF4
ADDRLP4 64
INDIRF4
ADDRLP4 20
INDIRF4
SUBF4
ADDF4
ASGNF4
line 494
;494:		if (bs->viewanglespeed[i] > 180) bs->viewanglespeed[i] = maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $248
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $248
line 495
;495:		if (bs->viewanglespeed[i] < -180) bs->viewanglespeed[i] = -maxchange;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
INDIRF4
CNSTF4 3274964992
GEF4 $250
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $250
line 496
;496:		anglespeed = bs->viewanglespeed[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
INDIRF4
ASGNF4
line 497
;497:		if (anglespeed > maxchange) anglespeed = maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $252
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
LABELV $252
line 498
;498:		if (anglespeed < -maxchange) anglespeed = -maxchange;
ADDRLP4 4
INDIRF4
ADDRLP4 8
INDIRF4
NEGF4
GEF4 $254
ADDRLP4 4
ADDRLP4 8
INDIRF4
NEGF4
ASGNF4
LABELV $254
line 499
;499:		bs->viewangles[i] += anglespeed;
ADDRLP4 68
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRF4
ADDRLP4 4
INDIRF4
ADDF4
ASGNF4
line 500
;500:		bs->viewangles[i] = AngleMod(bs->viewangles[i]);
ADDRLP4 72
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRF4
ARGF4
ADDRLP4 76
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 72
INDIRP4
ADDRLP4 76
INDIRF4
ASGNF4
line 501
;501:		bs->viewanglespeed[i] *= 0.45 * (1 - factor);
ADDRLP4 80
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1792
ADDP4
ADDP4
ASGNP4
ADDRLP4 80
INDIRP4
ADDRLP4 80
INDIRP4
INDIRF4
CNSTF4 1055286886
CNSTF4 1065353216
ADDRLP4 12
INDIRF4
SUBF4
MULF4
MULF4
ASGNF4
line 502
;502:	}
LABELV $245
line 488
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $244
line 503
;503:	if (bs->viewangles[PITCH] > 180) bs->viewangles[PITCH] -= 360;
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
INDIRF4
CNSTF4 1127481344
LEF4 $256
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
LABELV $256
line 504
;504:	trap_EA_View(bs->client, bs->viewangles);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
ADDRGP4 trap_EA_View
CALLV
pop
line 505
;505:}
LABELV $235
endproc BotChangeViewAngles 84 8
export BotInputToUserCommand
proc BotInputToUserCommand 120 16
line 512
;506:
;507:/*
;508:==============
;509:BotInputToUserCommand
;510:==============
;511:*/
;512:void BotInputToUserCommand(bot_input_t *bi, usercmd_t *ucmd, int delta_angles[3], int time, int useTime) {
line 518
;513:	vec3_t angles, forward, right;
;514:	short temp;
;515:	int j;
;516:
;517:	//clear the whole structure
;518:	memset(ucmd, 0, sizeof(usercmd_t));
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 28
ARGI4
ADDRGP4 memset
CALLP4
pop
line 522
;519:	//
;520:	//Com_Printf("dir = %f %f %f speed = %f\n", bi->dir[0], bi->dir[1], bi->dir[2], bi->speed);
;521:	//the duration for the user command in milli seconds
;522:	ucmd->serverTime = time;
ADDRFP4 4
INDIRP4
ADDRFP4 12
INDIRI4
ASGNI4
line 524
;523:	//
;524:	if (bi->actionflags & ACTION_DELAYEDJUMP) {
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
EQI4 $259
line 525
;525:		bi->actionflags |= ACTION_JUMP;
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 16
BORI4
ASGNI4
line 526
;526:		bi->actionflags &= ~ACTION_DELAYEDJUMP;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 -32769
BANDI4
ASGNI4
line 527
;527:	}
LABELV $259
line 529
;528:	//set the buttons
;529:	if (bi->actionflags & ACTION_RESPAWN) ucmd->buttons = BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $261
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
CNSTI4 1
ASGNI4
LABELV $261
line 530
;530:	if (bi->actionflags & ACTION_ATTACK) ucmd->buttons |= BUTTON_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $263
ADDRLP4 44
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRI4
CNSTI4 1
BORI4
ASGNI4
LABELV $263
line 531
;531:	if (bi->actionflags & ACTION_ALT_ATTACK) ucmd->buttons |= BUTTON_ALT_ATTACK;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $265
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 48
INDIRP4
ADDRLP4 48
INDIRP4
INDIRI4
CNSTI4 128
BORI4
ASGNI4
LABELV $265
line 533
;532://	if (bi->actionflags & ACTION_TALK) ucmd->buttons |= BUTTON_TALK;
;533:	if (bi->actionflags & ACTION_GESTURE) ucmd->buttons |= BUTTON_GESTURE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
CNSTI4 0
EQI4 $267
ADDRLP4 52
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
ADDRLP4 52
INDIRP4
INDIRI4
CNSTI4 8
BORI4
ASGNI4
LABELV $267
line 534
;534:	if (bi->actionflags & ACTION_USE) ucmd->buttons |= BUTTON_USE_HOLDABLE;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $269
ADDRLP4 56
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
ADDRLP4 56
INDIRP4
INDIRI4
CNSTI4 4
BORI4
ASGNI4
LABELV $269
line 535
;535:	if (bi->actionflags & ACTION_WALK) ucmd->buttons |= BUTTON_WALKING;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 524288
BANDI4
CNSTI4 0
EQI4 $271
ADDRLP4 60
CNSTI4 16
ASGNI4
ADDRLP4 64
ADDRFP4 4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
ADDRLP4 60
INDIRI4
BORI4
ASGNI4
LABELV $271
line 537
;536:
;537:	if (bi->actionflags & ACTION_FORCEPOWER) ucmd->buttons |= BUTTON_FORCEPOWER;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1048576
BANDI4
CNSTI4 0
EQI4 $273
ADDRLP4 68
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
CNSTI4 512
BORI4
ASGNI4
LABELV $273
line 539
;538:
;539:	if (useTime < level.time && Q_irand(1, 10) < 5)
ADDRFP4 16
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $275
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 72
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 5
GEI4 $275
line 540
;540:	{ //for now just hit use randomly in case there's something useable around
line 541
;541:		ucmd->buttons |= BUTTON_USE;
ADDRLP4 76
ADDRFP4 4
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
ADDRLP4 76
INDIRP4
INDIRI4
CNSTI4 32
BORI4
ASGNI4
line 542
;542:	}
LABELV $275
line 555
;543:#if 0
;544:// Here's an interesting bit.  The bots in TA used buttons to do additional gestures.
;545:// I ripped them out because I didn't want too many buttons given the fact that I was already adding some for JK2.
;546:// We can always add some back in if we want though.
;547:	if (bi->actionflags & ACTION_AFFIRMATIVE) ucmd->buttons |= BUTTON_AFFIRMATIVE;
;548:	if (bi->actionflags & ACTION_NEGATIVE) ucmd->buttons |= BUTTON_NEGATIVE;
;549:	if (bi->actionflags & ACTION_GETFLAG) ucmd->buttons |= BUTTON_GETFLAG;
;550:	if (bi->actionflags & ACTION_GUARDBASE) ucmd->buttons |= BUTTON_GUARDBASE;
;551:	if (bi->actionflags & ACTION_PATROL) ucmd->buttons |= BUTTON_PATROL;
;552:	if (bi->actionflags & ACTION_FOLLOWME) ucmd->buttons |= BUTTON_FOLLOWME;
;553:#endif //0
;554:
;555:	if (bi->weapon == WP_NONE)
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
NEI4 $278
line 556
;556:	{
line 560
;557:#ifdef _DEBUG
;558://		Com_Printf("WARNING: Bot tried to use WP_NONE!\n");
;559:#endif
;560:		bi->weapon = WP_BRYAR_PISTOL;
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
CNSTI4 3
ASGNI4
line 561
;561:	}
LABELV $278
line 564
;562:
;563:	//
;564:	ucmd->weapon = bi->weapon;
ADDRFP4 4
INDIRP4
CNSTI4 20
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CVIU4 4
CVUU1 4
ASGNU1
line 567
;565:	//set the view angles
;566:	//NOTE: the ucmd->angles are the angles WITHOUT the delta angles
;567:	ucmd->angles[PITCH] = ANGLE2SHORT(bi->viewangles[PITCH]);
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 568
;568:	ucmd->angles[YAW] = ANGLE2SHORT(bi->viewangles[YAW]);
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 569
;569:	ucmd->angles[ROLL] = ANGLE2SHORT(bi->viewangles[ROLL]);
ADDRFP4 4
INDIRP4
CNSTI4 12
ADDP4
CNSTF4 1199570944
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
MULF4
CNSTF4 1135869952
DIVF4
CVFI4 4
CNSTI4 65535
BANDI4
ASGNI4
line 571
;570:	//subtract the delta angles
;571:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $280
line 572
;572:		temp = ucmd->angles[j] - delta_angles[j];
ADDRLP4 76
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 4
ADDRLP4 76
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
INDIRI4
ADDRLP4 76
INDIRI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRI4
SUBI4
CVII2 4
ASGNI2
line 573
;573:		ucmd->angles[j] = temp;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
ADDP4
ADDRLP4 4
INDIRI2
CVII4 2
ASGNI4
line 574
;574:	}
LABELV $281
line 571
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $280
line 578
;575:	//NOTE: movement is relative to the REAL view angles
;576:	//get the horizontal forward and right vector
;577:	//get the pitch in the range [-180, 180]
;578:	if (bi->dir[2]) angles[PITCH] = bi->viewangles[PITCH];
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
CNSTF4 0
EQF4 $284
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ASGNF4
ADDRGP4 $285
JUMPV
LABELV $284
line 579
;579:	else angles[PITCH] = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
LABELV $285
line 580
;580:	angles[YAW] = bi->viewangles[YAW];
ADDRLP4 20+4
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ASGNF4
line 581
;581:	angles[ROLL] = 0;
ADDRLP4 20+8
CNSTF4 0
ASGNF4
line 582
;582:	AngleVectors(angles, forward, right, NULL);
ADDRLP4 20
ARGP4
ADDRLP4 8
ARGP4
ADDRLP4 32
ARGP4
CNSTP4 0
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 584
;583:	//bot input speed is in the range [0, 400]
;584:	bi->speed = bi->speed * 127 / 400;
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTF4 1123942400
ADDRLP4 76
INDIRP4
INDIRF4
MULF4
CNSTF4 1137180672
DIVF4
ASGNF4
line 586
;585:	//set the view independent movement
;586:	ucmd->forwardmove = DotProduct(forward, bi->dir) * bi->speed;
ADDRLP4 80
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ADDRLP4 8
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 8+4
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 8+8
INDIRF4
ADDRLP4 80
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 80
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 587
;587:	ucmd->rightmove = DotProduct(right, bi->dir) * bi->speed;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 25
ADDP4
ADDRLP4 32
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
MULF4
ADDRLP4 32+4
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 32+8
INDIRF4
ADDRLP4 84
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDF4
ADDRLP4 84
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 588
;588:	ucmd->upmove = abs(forward[2]) * bi->dir[2] * bi->speed;
ADDRLP4 8+8
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 88
ADDRGP4 abs
CALLI4
ASGNI4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRFP4 4
INDIRP4
CNSTI4 26
ADDP4
ADDRLP4 88
INDIRI4
CVIF4 4
ADDRLP4 92
INDIRP4
CNSTI4 12
ADDP4
INDIRF4
MULF4
ADDRLP4 92
INDIRP4
CNSTI4 16
ADDP4
INDIRF4
MULF4
CVFI4 4
CVII1 4
ASGNI1
line 590
;589:	//normal keyboard movement
;590:	if (bi->actionflags & ACTION_MOVEFORWARD) ucmd->forwardmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $293
ADDRLP4 96
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 96
INDIRP4
ADDRLP4 96
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $293
line 591
;591:	if (bi->actionflags & ACTION_MOVEBACK) ucmd->forwardmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $295
ADDRLP4 100
ADDRFP4 4
INDIRP4
CNSTI4 24
ADDP4
ASGNP4
ADDRLP4 100
INDIRP4
ADDRLP4 100
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $295
line 592
;592:	if (bi->actionflags & ACTION_MOVELEFT) ucmd->rightmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $297
ADDRLP4 104
ADDRFP4 4
INDIRP4
CNSTI4 25
ADDP4
ASGNP4
ADDRLP4 104
INDIRP4
ADDRLP4 104
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $297
line 593
;593:	if (bi->actionflags & ACTION_MOVERIGHT) ucmd->rightmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $299
ADDRLP4 108
ADDRFP4 4
INDIRP4
CNSTI4 25
ADDP4
ASGNP4
ADDRLP4 108
INDIRP4
ADDRLP4 108
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $299
line 595
;594:	//jump/moveup
;595:	if (bi->actionflags & ACTION_JUMP) ucmd->upmove += 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $301
ADDRLP4 112
ADDRFP4 4
INDIRP4
CNSTI4 26
ADDP4
ASGNP4
ADDRLP4 112
INDIRP4
ADDRLP4 112
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
ADDI4
CVII1 4
ASGNI1
LABELV $301
line 597
;596:	//crouch/movedown
;597:	if (bi->actionflags & ACTION_CROUCH) ucmd->upmove -= 127;
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $303
ADDRLP4 116
ADDRFP4 4
INDIRP4
CNSTI4 26
ADDP4
ASGNP4
ADDRLP4 116
INDIRP4
ADDRLP4 116
INDIRP4
INDIRI1
CVII4 1
CNSTI4 127
SUBI4
CVII1 4
ASGNI1
LABELV $303
line 601
;598:	//
;599:	//Com_Printf("forward = %d right = %d up = %d\n", ucmd.forwardmove, ucmd.rightmove, ucmd.upmove);
;600:	//Com_Printf("ucmd->serverTime = %d\n", ucmd->serverTime);
;601:}
LABELV $258
endproc BotInputToUserCommand 120 16
export BotUpdateInput
proc BotUpdateInput 64 20
line 608
;602:
;603:/*
;604:==============
;605:BotUpdateInput
;606:==============
;607:*/
;608:void BotUpdateInput(bot_state_t *bs, int time, int elapsed_time) {
line 613
;609:	bot_input_t bi;
;610:	int j;
;611:
;612:	//add the delta angles to the bot's current view angles
;613:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $306
line 614
;614:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 44
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 44
INDIRI4
ADDRLP4 48
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 56
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 52
INDIRP4
ADDRLP4 56
INDIRF4
ASGNF4
line 615
;615:	}
LABELV $307
line 613
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $306
line 617
;616:	//change the bot view angles
;617:	BotChangeViewAngles(bs, (float) elapsed_time / 1000);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotChangeViewAngles
CALLV
pop
line 619
;618:	//retrieve the bot input
;619:	trap_EA_GetInput(bs->client, (float) time / 1000, &bi);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRLP4 4
ARGP4
ADDRGP4 trap_EA_GetInput
CALLV
pop
line 621
;620:	//respawn hack
;621:	if (bi.actionflags & ACTION_RESPAWN) {
ADDRLP4 4+32
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $310
line 622
;622:		if (bs->lastucmd.buttons & BUTTON_ATTACK) bi.actionflags &= ~(ACTION_RESPAWN|ACTION_ATTACK);
ADDRFP4 0
INDIRP4
CNSTI4 1400
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $313
ADDRLP4 4+32
ADDRLP4 4+32
INDIRI4
CNSTI4 -10
BANDI4
ASGNI4
LABELV $313
line 623
;623:	}
LABELV $310
line 625
;624:	//convert the bot input to a usercmd
;625:	BotInputToUserCommand(&bi, &bs->lastucmd, bs->cur_ps.delta_angles, time, bs->noUseTime);
ADDRLP4 4
ARGP4
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 1384
ADDP4
ARGP4
ADDRLP4 44
INDIRP4
CNSTI4 84
ADDP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
CNSTI4 4788
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotInputToUserCommand
CALLV
pop
line 627
;626:	//subtract the delta angles
;627:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $316
line 628
;628:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 48
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 56
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 60
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 56
INDIRP4
ADDRLP4 60
INDIRF4
ASGNF4
line 629
;629:	}
LABELV $317
line 627
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $316
line 630
;630:}
LABELV $305
endproc BotUpdateInput 64 20
export BotAIRegularUpdate
proc BotAIRegularUpdate 0 0
line 637
;631:
;632:/*
;633:==============
;634:BotAIRegularUpdate
;635:==============
;636:*/
;637:void BotAIRegularUpdate(void) {
line 638
;638:	if (regularupdate_time < FloatTime()) {
ADDRGP4 regularupdate_time
INDIRF4
ADDRGP4 floattime
INDIRF4
GEF4 $321
line 639
;639:		trap_BotUpdateEntityItems();
ADDRGP4 trap_BotUpdateEntityItems
CALLV
pop
line 640
;640:		regularupdate_time = FloatTime() + 0.3;
ADDRGP4 regularupdate_time
ADDRGP4 floattime
INDIRF4
CNSTF4 1050253722
ADDF4
ASGNF4
line 641
;641:	}
LABELV $321
line 642
;642:}
LABELV $320
endproc BotAIRegularUpdate 0 0
export RemoveColorEscapeSequences
proc RemoveColorEscapeSequences 28 0
line 649
;643:
;644:/*
;645:==============
;646:RemoveColorEscapeSequences
;647:==============
;648:*/
;649:void RemoveColorEscapeSequences( char *text ) {
line 652
;650:	int i, l;
;651:
;652:	l = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 653
;653:	for ( i = 0; text[i]; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $327
JUMPV
LABELV $324
line 654
;654:		if (Q_IsColorString(&text[i])) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $328
ADDRLP4 12
CNSTI4 94
ASGNI4
ADDRLP4 8
INDIRP4
INDIRI1
CVII4 1
ADDRLP4 12
INDIRI4
NEI4 $328
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 1
ADDP4
INDIRI1
CVII4 1
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $328
ADDRLP4 16
INDIRI4
ADDRLP4 12
INDIRI4
EQI4 $328
line 655
;655:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 656
;656:			continue;
ADDRGP4 $325
JUMPV
LABELV $328
line 658
;657:		}
;658:		if (text[i] > 0x7E)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 126
LEI4 $330
line 659
;659:			continue;
ADDRGP4 $325
JUMPV
LABELV $330
line 660
;660:		text[l++] = text[i];
ADDRLP4 20
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 4
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRI4
ADDRLP4 24
INDIRP4
ADDP4
ADDRLP4 0
INDIRI4
ADDRLP4 24
INDIRP4
ADDP4
INDIRI1
ASGNI1
line 661
;661:	}
LABELV $325
line 653
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
LABELV $327
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
NEI4 $324
line 662
;662:	text[l] = '\0';
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
ADDP4
CNSTI1 0
ASGNI1
line 663
;663:}
LABELV $323
endproc RemoveColorEscapeSequences 28 0
export BotAI
proc BotAI 1080 12
line 671
;664:
;665:
;666:/*
;667:==============
;668:BotAI
;669:==============
;670:*/
;671:int BotAI(int client, float thinktime) {
line 680
;672:	bot_state_t *bs;
;673:	char buf[1024], *args;
;674:	int j;
;675:#ifdef _DEBUG
;676:	int start = 0;
;677:	int end = 0;
;678:#endif
;679:
;680:	trap_EA_ResetInput(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 trap_EA_ResetInput
CALLV
pop
line 682
;681:	//
;682:	bs = botstates[client];
ADDRLP4 4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 683
;683:	if (!bs || !bs->inuse) {
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $335
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $333
LABELV $335
line 684
;684:		BotAI_Print(PRT_FATAL, "BotAI: client %d is not setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $336
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 685
;685:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $332
JUMPV
LABELV $333
line 689
;686:	}
;687:
;688:	//retrieve the current client state
;689:	BotAI_GetClientState( client, &bs->cur_ps );
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRGP4 BotAI_GetClientState
CALLI4
pop
ADDRGP4 $338
JUMPV
LABELV $337
line 692
;690:
;691:	//retrieve any waiting server commands
;692:	while( trap_BotGetServerCommand(client, buf, sizeof(buf)) ) {
line 694
;693:		//have buf point to the command and args to the command arguments
;694:		args = strchr( buf, ' ');
ADDRLP4 8
ARGP4
CNSTI4 32
ARGI4
ADDRLP4 1040
ADDRGP4 strchr
CALLP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1040
INDIRP4
ASGNP4
line 695
;695:		if (!args) continue;
ADDRLP4 1032
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $340
ADDRGP4 $338
JUMPV
LABELV $340
line 696
;696:		*args++ = '\0';
ADDRLP4 1044
ADDRLP4 1032
INDIRP4
ASGNP4
ADDRLP4 1032
ADDRLP4 1044
INDIRP4
CNSTI4 1
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
CNSTI1 0
ASGNI1
line 699
;697:
;698:		//remove color espace sequences from the arguments
;699:		RemoveColorEscapeSequences( args );
ADDRLP4 1032
INDIRP4
ARGP4
ADDRGP4 RemoveColorEscapeSequences
CALLV
pop
line 701
;700:
;701:		if (!Q_stricmp(buf, "cp "))
ADDRLP4 8
ARGP4
ADDRGP4 $344
ARGP4
ADDRLP4 1048
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1048
INDIRI4
CNSTI4 0
NEI4 $342
line 702
;702:			{ /*CenterPrintf*/ }
ADDRGP4 $343
JUMPV
LABELV $342
line 703
;703:		else if (!Q_stricmp(buf, "cs"))
ADDRLP4 8
ARGP4
ADDRGP4 $347
ARGP4
ADDRLP4 1052
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1052
INDIRI4
CNSTI4 0
NEI4 $345
line 704
;704:			{ /*ConfigStringModified*/ }
ADDRGP4 $346
JUMPV
LABELV $345
line 705
;705:		else if (!Q_stricmp(buf, "scores"))
ADDRLP4 8
ARGP4
ADDRGP4 $350
ARGP4
ADDRLP4 1056
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1056
INDIRI4
CNSTI4 0
NEI4 $348
line 706
;706:			{ /*FIXME: parse scores?*/ }
ADDRGP4 $349
JUMPV
LABELV $348
line 707
;707:		else if (!Q_stricmp(buf, "clientLevelShot"))
ADDRLP4 8
ARGP4
ADDRGP4 $353
ARGP4
ADDRLP4 1060
ADDRGP4 Q_stricmp
CALLI4
ASGNI4
ADDRLP4 1060
INDIRI4
CNSTI4 0
NEI4 $351
line 708
;708:			{ /*ignore*/ }
LABELV $351
LABELV $349
LABELV $346
LABELV $343
line 709
;709:	}
LABELV $338
line 692
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 8
ARGP4
CNSTI4 1024
ARGI4
ADDRLP4 1040
ADDRGP4 trap_BotGetServerCommand
CALLI4
ASGNI4
ADDRLP4 1040
INDIRI4
CNSTI4 0
NEI4 $337
line 711
;710:	//add the delta angles to the bot's current view angles
;711:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $354
line 712
;712:		bs->viewangles[j] = AngleMod(bs->viewangles[j] + SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1044
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1052
ADDRLP4 1044
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 1052
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1044
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
ADDF4
ARGF4
ADDRLP4 1056
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1052
INDIRP4
ADDRLP4 1056
INDIRF4
ASGNF4
line 713
;713:	}
LABELV $355
line 711
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $354
line 715
;714:	//increase the local time of the bot
;715:	bs->ltime += thinktime;
ADDRLP4 1044
ADDRLP4 4
INDIRP4
CNSTI4 1748
ADDP4
ASGNP4
ADDRLP4 1044
INDIRP4
ADDRLP4 1044
INDIRP4
INDIRF4
ADDRFP4 4
INDIRF4
ADDF4
ASGNF4
line 717
;716:	//
;717:	bs->thinktime = thinktime;
ADDRLP4 4
INDIRP4
CNSTI4 1704
ADDP4
ADDRFP4 4
INDIRF4
ASGNF4
line 719
;718:	//origin of the bot
;719:	VectorCopy(bs->cur_ps.origin, bs->origin);
ADDRLP4 4
INDIRP4
CNSTI4 1708
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 721
;720:	//eye coordinates of the bot
;721:	VectorCopy(bs->cur_ps.origin, bs->eye);
ADDRLP4 4
INDIRP4
CNSTI4 1732
ADDP4
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRB
ASGNB 12
line 722
;722:	bs->eye[2] += bs->cur_ps.viewheight;
ADDRLP4 1060
ADDRLP4 4
INDIRP4
CNSTI4 1740
ADDP4
ASGNP4
ADDRLP4 1060
INDIRP4
ADDRLP4 1060
INDIRP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 184
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 728
;723:	//get the area the bot is in
;724:
;725:#ifdef _DEBUG
;726:	start = trap_Milliseconds();
;727:#endif
;728:	StandardBotAI(bs, thinktime);
ADDRLP4 4
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRGP4 StandardBotAI
CALLV
pop
line 741
;729:#ifdef _DEBUG
;730:	end = trap_Milliseconds();
;731:
;732:	trap_Cvar_Update(&bot_debugmessages);
;733:
;734:	if (bot_debugmessages.integer)
;735:	{
;736:		Com_Printf("Single AI frametime: %i\n", (end - start));
;737:	}
;738:#endif
;739:
;740:	//subtract the delta angles
;741:	for (j = 0; j < 3; j++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $358
line 742
;742:		bs->viewangles[j] = AngleMod(bs->viewangles[j] - SHORT2ANGLE(bs->cur_ps.delta_angles[j]));
ADDRLP4 1064
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 1072
ADDRLP4 1064
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 1768
ADDP4
ADDP4
ASGNP4
ADDRLP4 1072
INDIRP4
INDIRF4
CNSTF4 1001652224
ADDRLP4 1064
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 84
ADDP4
ADDP4
INDIRI4
CVIF4 4
MULF4
SUBF4
ARGF4
ADDRLP4 1076
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 1072
INDIRP4
ADDRLP4 1076
INDIRF4
ASGNF4
line 743
;743:	}
LABELV $359
line 741
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LTI4 $358
line 745
;744:	//everything was ok
;745:	return qtrue;
CNSTI4 1
RETI4
LABELV $332
endproc BotAI 1080 12
export BotScheduleBotThink
proc BotScheduleBotThink 12 0
line 753
;746:}
;747:
;748:/*
;749:==================
;750:BotScheduleBotThink
;751:==================
;752:*/
;753:void BotScheduleBotThink(void) {
line 756
;754:	int i, botnum;
;755:
;756:	botnum = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 758
;757:
;758:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $363
line 759
;759:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $369
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $367
LABELV $369
line 760
;760:			continue;
ADDRGP4 $364
JUMPV
LABELV $367
line 763
;761:		}
;762:		//initialize the bot think residual time
;763:		botstates[i]->botthink_residual = BOT_THINK_TIME * botnum / numbots;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
CNSTI4 0
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 numbots
INDIRI4
DIVI4
ASGNI4
line 764
;764:		botnum++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 765
;765:	}
LABELV $364
line 758
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $363
line 766
;766:}
LABELV $362
endproc BotScheduleBotThink 12 0
export PlayersInGame
proc PlayersInGame 24 0
line 769
;767:
;768:int PlayersInGame(void)
;769:{
line 770
;770:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 772
;771:	gentity_t *ent;
;772:	int pl = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $372
JUMPV
LABELV $371
line 775
;773:
;774:	while (i < MAX_CLIENTS)
;775:	{
line 776
;776:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 778
;777:
;778:		if (ent && ent->client && ent->client->pers.connected == CON_CONNECTED)
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $374
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $374
ADDRLP4 20
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
CNSTI4 2
NEI4 $374
line 779
;779:		{
line 780
;780:			pl++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 781
;781:		}
LABELV $374
line 783
;782:
;783:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 784
;784:	}
LABELV $372
line 774
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $371
line 786
;785:
;786:	return pl;
ADDRLP4 8
INDIRI4
RETI4
LABELV $370
endproc PlayersInGame 24 0
export BotAISetupClient
proc BotAISetupClient 32 12
line 794
;787:}
;788:
;789:/*
;790:==============
;791:BotAISetupClient
;792:==============
;793:*/
;794:int BotAISetupClient(int client, struct bot_settings_s *settings, qboolean restart) {
line 797
;795:	bot_state_t *bs;
;796:
;797:	if (!botstates[client]) botstates[client] = B_Alloc(sizeof(bot_state_t)); //G_Alloc(sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $377
CNSTI4 4796
ARGI4
ADDRLP4 4
ADDRGP4 B_Alloc
CALLP4
ASGNP4
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
LABELV $377
line 800
;798:																			  //rww - G_Alloc bad! B_Alloc good.
;799:
;800:	memset(botstates[client], 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4796
ARGI4
ADDRGP4 memset
CALLP4
pop
line 802
;801:
;802:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 804
;803:
;804:	if (bs && bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $379
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $379
line 805
;805:		BotAI_Print(PRT_FATAL, "BotAISetupClient: client %d already setup\n", client);
CNSTI4 4
ARGI4
ADDRGP4 $381
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAI_Print
CALLV
pop
line 806
;806:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $376
JUMPV
LABELV $379
line 809
;807:	}
;808:
;809:	memcpy(&bs->settings, settings, sizeof(bot_settings_t));
ADDRLP4 0
INDIRP4
CNSTI4 1412
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 811
;810:
;811:	bs->client = client; //need to know the client number before doing personality stuff
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 814
;812:
;813:	//initialize weapon weight defaults..
;814:	bs->botWeaponWeights[WP_NONE] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 2612
ADDP4
CNSTF4 0
ASGNF4
line 815
;815:	bs->botWeaponWeights[WP_STUN_BATON] = 1;
ADDRLP4 0
INDIRP4
CNSTI4 2616
ADDP4
CNSTF4 1065353216
ASGNF4
line 816
;816:	bs->botWeaponWeights[WP_SABER] = 10;
ADDRLP4 0
INDIRP4
CNSTI4 2620
ADDP4
CNSTF4 1092616192
ASGNF4
line 817
;817:	bs->botWeaponWeights[WP_BRYAR_PISTOL] = 11;
ADDRLP4 0
INDIRP4
CNSTI4 2624
ADDP4
CNSTF4 1093664768
ASGNF4
line 818
;818:	bs->botWeaponWeights[WP_BLASTER] = 12;
ADDRLP4 0
INDIRP4
CNSTI4 2628
ADDP4
CNSTF4 1094713344
ASGNF4
line 819
;819:	bs->botWeaponWeights[WP_DISRUPTOR] = 13;
ADDRLP4 0
INDIRP4
CNSTI4 2632
ADDP4
CNSTF4 1095761920
ASGNF4
line 820
;820:	bs->botWeaponWeights[WP_BOWCASTER] = 14;
ADDRLP4 0
INDIRP4
CNSTI4 2636
ADDP4
CNSTF4 1096810496
ASGNF4
line 821
;821:	bs->botWeaponWeights[WP_REPEATER] = 15;
ADDRLP4 0
INDIRP4
CNSTI4 2640
ADDP4
CNSTF4 1097859072
ASGNF4
line 822
;822:	bs->botWeaponWeights[WP_DEMP2] = 16;
ADDRLP4 0
INDIRP4
CNSTI4 2644
ADDP4
CNSTF4 1098907648
ASGNF4
line 823
;823:	bs->botWeaponWeights[WP_FLECHETTE] = 17;
ADDRLP4 0
INDIRP4
CNSTI4 2648
ADDP4
CNSTF4 1099431936
ASGNF4
line 824
;824:	bs->botWeaponWeights[WP_ROCKET_LAUNCHER] = 18;
ADDRLP4 0
INDIRP4
CNSTI4 2652
ADDP4
CNSTF4 1099956224
ASGNF4
line 825
;825:	bs->botWeaponWeights[WP_THERMAL] = 14;
ADDRLP4 0
INDIRP4
CNSTI4 2656
ADDP4
CNSTF4 1096810496
ASGNF4
line 826
;826:	bs->botWeaponWeights[WP_TRIP_MINE] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 2660
ADDP4
CNSTF4 0
ASGNF4
line 827
;827:	bs->botWeaponWeights[WP_DET_PACK] = 0;
ADDRLP4 0
INDIRP4
CNSTI4 2664
ADDP4
CNSTF4 0
ASGNF4
line 829
;828:
;829:	BotUtilizePersonality(bs);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BotUtilizePersonality
CALLV
pop
line 831
;830:
;831:	if (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $382
line 832
;832:	{
line 833
;833:		bs->botWeaponWeights[WP_SABER] = 13;
ADDRLP4 0
INDIRP4
CNSTI4 2620
ADDP4
CNSTF4 1095761920
ASGNF4
line 834
;834:	}
LABELV $382
line 837
;835:
;836:	//allocate a goal state
;837:	bs->gs = trap_BotAllocGoalState(client);
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 trap_BotAllocGoalState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1760
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 840
;838:
;839:	//allocate a weapon state
;840:	bs->ws = trap_BotAllocWeaponState();
ADDRLP4 16
ADDRGP4 trap_BotAllocWeaponState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1764
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 842
;841:
;842:	bs->inuse = qtrue;
ADDRLP4 0
INDIRP4
CNSTI4 1
ASGNI4
line 843
;843:	bs->entitynum = client;
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRFP4 0
INDIRI4
ASGNI4
line 844
;844:	bs->setupcount = 4;
ADDRLP4 0
INDIRP4
CNSTI4 1744
ADDP4
CNSTI4 4
ASGNI4
line 845
;845:	bs->entergame_time = FloatTime();
ADDRLP4 0
INDIRP4
CNSTI4 1752
ADDP4
ADDRGP4 floattime
INDIRF4
ASGNF4
line 846
;846:	bs->ms = trap_BotAllocMoveState();
ADDRLP4 20
ADDRGP4 trap_BotAllocMoveState
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1756
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 847
;847:	numbots++;
ADDRLP4 24
ADDRGP4 numbots
ASGNP4
ADDRLP4 24
INDIRP4
ADDRLP4 24
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 850
;848:
;849:	//NOTE: reschedule the bot thinking
;850:	BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 852
;851:
;852:	if (PlayersInGame())
ADDRLP4 28
ADDRGP4 PlayersInGame
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $385
line 853
;853:	{ //don't talk to yourself
line 854
;854:		BotDoChat(bs, "GeneralGreetings", 0);
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 $387
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 855
;855:	}
LABELV $385
line 857
;856:
;857:	return qtrue;
CNSTI4 1
RETI4
LABELV $376
endproc BotAISetupClient 32 12
export BotAIShutdownClient
proc BotAIShutdownClient 12 12
line 865
;858:}
;859:
;860:/*
;861:==============
;862:BotAIShutdownClient
;863:==============
;864:*/
;865:int BotAIShutdownClient(int client, qboolean restart) {
line 868
;866:	bot_state_t *bs;
;867:
;868:	bs = botstates[client];
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 869
;869:	if (!bs || !bs->inuse) {
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $391
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $389
LABELV $391
line 871
;870:		//BotAI_Print(PRT_ERROR, "BotAIShutdownClient: client %d already shutdown\n", client);
;871:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $388
JUMPV
LABELV $389
line 874
;872:	}
;873:
;874:	trap_BotFreeMoveState(bs->ms);
ADDRLP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeMoveState
CALLV
pop
line 876
;875:	//free the goal state`			
;876:	trap_BotFreeGoalState(bs->gs);
ADDRLP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeGoalState
CALLV
pop
line 878
;877:	//free the weapon weights
;878:	trap_BotFreeWeaponState(bs->ws);
ADDRLP4 0
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotFreeWeaponState
CALLV
pop
line 881
;879:	//
;880:	//clear the bot state
;881:	memset(bs, 0, sizeof(bot_state_t));
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4796
ARGI4
ADDRGP4 memset
CALLP4
pop
line 883
;882:	//set the inuse flag to qfalse
;883:	bs->inuse = qfalse;
ADDRLP4 0
INDIRP4
CNSTI4 0
ASGNI4
line 885
;884:	//there's one bot less
;885:	numbots--;
ADDRLP4 8
ADDRGP4 numbots
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 887
;886:	//everything went ok
;887:	return qtrue;
CNSTI4 1
RETI4
LABELV $388
endproc BotAIShutdownClient 12 12
export BotResetState
proc BotResetState 1688 12
line 898
;888:}
;889:
;890:/*
;891:==============
;892:BotResetState
;893:
;894:called when a bot enters the intermission or observer mode and
;895:when the level is changed
;896:==============
;897:*/
;898:void BotResetState(bot_state_t *bs) {
line 906
;899:	int client, entitynum, inuse;
;900:	int movestate, goalstate, weaponstate;
;901:	bot_settings_t settings;
;902:	playerState_t ps;							//current player state
;903:	float entergame_time;
;904:
;905:	//save some things that should not be reset here
;906:	memcpy(&settings, &bs->settings, sizeof(bot_settings_t));
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 907
;907:	memcpy(&ps, &bs->cur_ps, sizeof(playerState_t));
ADDRLP4 316
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
CNSTI4 1368
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 908
;908:	inuse = bs->inuse;
ADDRLP4 8
ADDRFP4 0
INDIRP4
INDIRI4
ASGNI4
line 909
;909:	client = bs->client;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
line 910
;910:	entitynum = bs->entitynum;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ASGNI4
line 911
;911:	movestate = bs->ms;
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
ASGNI4
line 912
;912:	goalstate = bs->gs;
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
ASGNI4
line 913
;913:	weaponstate = bs->ws;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
ASGNI4
line 914
;914:	entergame_time = bs->entergame_time;
ADDRLP4 1684
ADDRFP4 0
INDIRP4
CNSTI4 1752
ADDP4
INDIRF4
ASGNF4
line 916
;915:	//reset the whole state
;916:	memset(bs, 0, sizeof(bot_state_t));
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
CNSTI4 4796
ARGI4
ADDRGP4 memset
CALLP4
pop
line 918
;917:	//copy back some state stuff that should not be reset
;918:	bs->ms = movestate;
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
ADDRLP4 12
INDIRI4
ASGNI4
line 919
;919:	bs->gs = goalstate;
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
ADDRLP4 16
INDIRI4
ASGNI4
line 920
;920:	bs->ws = weaponstate;
ADDRFP4 0
INDIRP4
CNSTI4 1764
ADDP4
ADDRLP4 20
INDIRI4
ASGNI4
line 921
;921:	memcpy(&bs->cur_ps, &ps, sizeof(playerState_t));
ADDRFP4 0
INDIRP4
CNSTI4 16
ADDP4
ARGP4
ADDRLP4 316
ARGP4
CNSTI4 1368
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 922
;922:	memcpy(&bs->settings, &settings, sizeof(bot_settings_t));
ADDRFP4 0
INDIRP4
CNSTI4 1412
ADDP4
ARGP4
ADDRLP4 24
ARGP4
CNSTI4 292
ARGI4
ADDRGP4 memcpy
CALLP4
pop
line 923
;923:	bs->inuse = inuse;
ADDRFP4 0
INDIRP4
ADDRLP4 8
INDIRI4
ASGNI4
line 924
;924:	bs->client = client;
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 925
;925:	bs->entitynum = entitynum;
ADDRFP4 0
INDIRP4
CNSTI4 12
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 926
;926:	bs->entergame_time = entergame_time;
ADDRFP4 0
INDIRP4
CNSTI4 1752
ADDP4
ADDRLP4 1684
INDIRF4
ASGNF4
line 928
;927:	//reset several states
;928:	if (bs->ms) trap_BotResetMoveState(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
CNSTI4 0
EQI4 $393
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetMoveState
CALLV
pop
LABELV $393
line 929
;929:	if (bs->gs) trap_BotResetGoalState(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $395
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetGoalState
CALLV
pop
LABELV $395
line 930
;930:	if (bs->ws) trap_BotResetWeaponState(bs->ws);
ADDRFP4 0
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
CNSTI4 0
EQI4 $397
ADDRFP4 0
INDIRP4
CNSTI4 1764
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetWeaponState
CALLV
pop
LABELV $397
line 931
;931:	if (bs->gs) trap_BotResetAvoidGoals(bs->gs);
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
CNSTI4 0
EQI4 $399
ADDRFP4 0
INDIRP4
CNSTI4 1760
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidGoals
CALLV
pop
LABELV $399
line 932
;932:	if (bs->ms) trap_BotResetAvoidReach(bs->ms);
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
CNSTI4 0
EQI4 $401
ADDRFP4 0
INDIRP4
CNSTI4 1756
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_BotResetAvoidReach
CALLV
pop
LABELV $401
line 933
;933:}
LABELV $392
endproc BotResetState 1688 12
export BotAILoadMap
proc BotAILoadMap 8 4
line 940
;934:
;935:/*
;936:==============
;937:BotAILoadMap
;938:==============
;939:*/
;940:int BotAILoadMap( int restart ) {
line 943
;941:	int			i;
;942:
;943:	for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $404
line 944
;944:		if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $408
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $408
line 945
;945:			BotResetState( botstates[i] );
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 BotResetState
CALLV
pop
line 946
;946:			botstates[i]->setupcount = 4;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 1744
ADDP4
CNSTI4 4
ASGNI4
line 947
;947:		}
LABELV $408
line 948
;948:	}
LABELV $405
line 943
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $404
line 950
;949:
;950:	return qtrue;
CNSTI4 1
RETI4
LABELV $403
endproc BotAILoadMap 8 4
export OrgVisible
proc OrgVisible 1084 28
line 955
;951:}
;952:
;953://rww - bot ai
;954:int OrgVisible(vec3_t org1, vec3_t org2, int ignore)
;955:{
line 958
;956:	trace_t tr;
;957:
;958:	trap_Trace(&tr, org1, NULL, NULL, org2, ignore, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1080
CNSTP4 0
ASGNP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 960
;959:
;960:	if (tr.fraction == 1)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $411
line 961
;961:	{
line 962
;962:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $410
JUMPV
LABELV $411
line 965
;963:	}
;964:
;965:	return 0;
CNSTI4 0
RETI4
LABELV $410
endproc OrgVisible 1084 28
export WPOrgVisible
proc WPOrgVisible 1104 28
line 969
;966:}
;967:
;968:int WPOrgVisible(gentity_t *bot, vec3_t org1, vec3_t org2, int ignore)
;969:{
line 973
;970:	trace_t tr;
;971:	gentity_t *ownent;
;972:
;973:	trap_Trace(&tr, org1, NULL, NULL, org2, ignore, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1084
CNSTP4 0
ASGNP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRLP4 1084
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 975
;974:
;975:	if (tr.fraction == 1)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $415
line 976
;976:	{
line 977
;977:		trap_Trace(&tr, org1, NULL, NULL, org2, ignore, MASK_PLAYERSOLID);
ADDRLP4 0
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 1088
CNSTP4 0
ASGNP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRLP4 1088
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 979
;978:
;979:		if (tr.fraction != 1 && tr.entityNum != ENTITYNUM_NONE && g_entities[tr.entityNum].s.eType == ET_SPECIAL)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $418
ADDRLP4 0+52
INDIRI4
CNSTI4 1023
EQI4 $418
CNSTI4 828
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities+4
ADDP4
INDIRI4
CNSTI4 4
NEI4 $418
line 980
;980:		{
line 981
;981:			if (g_entities[tr.entityNum].parent && g_entities[tr.entityNum].parent->client)
ADDRLP4 1092
CNSTI4 828
ASGNI4
ADDRLP4 1096
CNSTU4 0
ASGNU4
ADDRLP4 1092
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1096
INDIRU4
EQU4 $424
ADDRLP4 1092
INDIRI4
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1096
INDIRU4
EQU4 $424
line 982
;982:			{
line 983
;983:				ownent = g_entities[tr.entityNum].parent;
ADDRLP4 1080
CNSTI4 828
ADDRLP4 0+52
INDIRI4
MULI4
ADDRGP4 g_entities+536
ADDP4
INDIRP4
ASGNP4
line 985
;984:
;985:				if (OnSameTeam(bot, ownent) || bot->s.number == ownent->s.number)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1080
INDIRP4
ARGP4
ADDRLP4 1100
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 1100
INDIRI4
CNSTI4 0
NEI4 $434
ADDRFP4 0
INDIRP4
INDIRI4
ADDRLP4 1080
INDIRP4
INDIRI4
NEI4 $432
LABELV $434
line 986
;986:				{
line 987
;987:					return 1;
CNSTI4 1
RETI4
ADDRGP4 $414
JUMPV
LABELV $432
line 989
;988:				}
;989:			}
LABELV $424
line 990
;990:			return 2;
CNSTI4 2
RETI4
ADDRGP4 $414
JUMPV
LABELV $418
line 993
;991:		}
;992:
;993:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $414
JUMPV
LABELV $415
line 996
;994:	}
;995:
;996:	return 0;
CNSTI4 0
RETI4
LABELV $414
endproc WPOrgVisible 1104 28
export OrgVisibleBox
proc OrgVisibleBox 1084 28
line 1000
;997:}
;998:
;999:int OrgVisibleBox(vec3_t org1, vec3_t mins, vec3_t maxs, vec3_t org2, int ignore)
;1000:{
line 1003
;1001:	trace_t tr;
;1002:
;1003:	trap_Trace(&tr, org1, mins, maxs, org2, ignore, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1005
;1004:
;1005:	if (tr.fraction == 1 && !tr.startsolid && !tr.allsolid)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $436
ADDRLP4 1080
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 1080
INDIRI4
NEI4 $436
ADDRLP4 0
INDIRI4
ADDRLP4 1080
INDIRI4
NEI4 $436
line 1006
;1006:	{
line 1007
;1007:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $435
JUMPV
LABELV $436
line 1010
;1008:	}
;1009:
;1010:	return 0;
CNSTI4 0
RETI4
LABELV $435
endproc OrgVisibleBox 1084 28
export CheckForFunc
proc CheckForFunc 1104 28
line 1014
;1011:}
;1012:
;1013:int CheckForFunc(vec3_t org, int ignore)
;1014:{
line 1019
;1015:	gentity_t *fent;
;1016:	vec3_t under;
;1017:	trace_t tr;
;1018:
;1019:	VectorCopy(org, under);
ADDRLP4 4
ADDRFP4 0
INDIRP4
INDIRB
ASGNB 12
line 1021
;1020:
;1021:	under[2] -= 64;
ADDRLP4 4+8
ADDRLP4 4+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 1023
;1022:
;1023:	trap_Trace(&tr, org, NULL, NULL, under, ignore, MASK_SOLID);
ADDRLP4 16
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1096
CNSTP4 0
ASGNP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 1096
INDIRP4
ARGP4
ADDRLP4 4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1025
;1024:
;1025:	if (tr.fraction == 1)
ADDRLP4 16+8
INDIRF4
CNSTF4 1065353216
NEF4 $442
line 1026
;1026:	{
line 1027
;1027:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $440
JUMPV
LABELV $442
line 1030
;1028:	}
;1029:
;1030:	fent = &g_entities[tr.entityNum];
ADDRLP4 0
CNSTI4 828
ADDRLP4 16+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1032
;1031:
;1032:	if (!fent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $446
line 1033
;1033:	{
line 1034
;1034:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $440
JUMPV
LABELV $446
line 1037
;1035:	}
;1036:
;1037:	if (strstr(fent->classname, "func_"))
ADDRLP4 0
INDIRP4
CNSTI4 416
ADDP4
INDIRP4
ARGP4
ADDRGP4 $450
ARGP4
ADDRLP4 1100
ADDRGP4 strstr
CALLP4
ASGNP4
ADDRLP4 1100
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $448
line 1038
;1038:	{
line 1039
;1039:		return 1; //there's a func brush here
CNSTI4 1
RETI4
ADDRGP4 $440
JUMPV
LABELV $448
line 1042
;1040:	}
;1041:
;1042:	return 0;
CNSTI4 0
RETI4
LABELV $440
endproc CheckForFunc 1104 28
export GetNearestVisibleWP
proc GetNearestVisibleWP 84 20
line 1046
;1043:}
;1044:
;1045:int GetNearestVisibleWP(vec3_t org, int ignore)
;1046:{
line 1053
;1047:	int i;
;1048:	float bestdist;
;1049:	float flLen;
;1050:	int bestindex;
;1051:	vec3_t a, mins, maxs;
;1052:
;1053:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1054
;1054:	bestdist = 800;//99999;
ADDRLP4 20
CNSTF4 1145569280
ASGNF4
line 1056
;1055:			   //don't trace over 800 units away to avoid GIANT HORRIBLE SPEED HITS ^_^
;1056:	bestindex = -1;
ADDRLP4 48
CNSTI4 -1
ASGNI4
line 1058
;1057:
;1058:	mins[0] = -15;
ADDRLP4 24
CNSTF4 3245342720
ASGNF4
line 1059
;1059:	mins[1] = -15;
ADDRLP4 24+4
CNSTF4 3245342720
ASGNF4
line 1060
;1060:	mins[2] = -1;
ADDRLP4 24+8
CNSTF4 3212836864
ASGNF4
line 1061
;1061:	maxs[0] = 15;
ADDRLP4 36
CNSTF4 1097859072
ASGNF4
line 1062
;1062:	maxs[1] = 15;
ADDRLP4 36+4
CNSTF4 1097859072
ASGNF4
line 1063
;1063:	maxs[2] = 1;
ADDRLP4 36+8
CNSTF4 1065353216
ASGNF4
ADDRGP4 $457
JUMPV
LABELV $456
line 1066
;1064:
;1065:	while (i < gWPNum)
;1066:	{
line 1067
;1067:		if (gWPArray[i] && gWPArray[i]->inuse)
ADDRLP4 52
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $459
ADDRLP4 52
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $459
line 1068
;1068:		{
line 1069
;1069:			VectorSubtract(org, gWPArray[i]->origin, a);
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 56
INDIRP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 4
ASGNI4
ADDRLP4 4+4
ADDRLP4 56
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 68
CNSTI4 8
ASGNI4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ADDRLP4 68
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1070
;1070:			flLen = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 72
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 72
INDIRF4
ASGNF4
line 1072
;1071:
;1072:			if (flLen < bestdist && trap_InPVS(org, gWPArray[i]->origin) && OrgVisibleBox(org, mins, maxs, gWPArray[i]->origin, ignore))
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
GEF4 $463
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $463
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ARGP4
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 OrgVisibleBox
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $463
line 1073
;1073:			{
line 1074
;1074:				bestdist = flLen;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 1075
;1075:				bestindex = i;
ADDRLP4 48
ADDRLP4 0
INDIRI4
ASGNI4
line 1076
;1076:			}
LABELV $463
line 1077
;1077:		}
LABELV $459
line 1079
;1078:
;1079:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1080
;1080:	}
LABELV $457
line 1065
ADDRLP4 0
INDIRI4
ADDRGP4 gWPNum
INDIRI4
LTI4 $456
line 1082
;1081:
;1082:	return bestindex;
ADDRLP4 48
INDIRI4
RETI4
LABELV $451
endproc GetNearestVisibleWP 84 20
export PassWayCheck
proc PassWayCheck 32 0
line 1090
;1083:}
;1084:
;1085://wpDirection
;1086://0 == FORWARD
;1087://1 == BACKWARD
;1088:
;1089:int PassWayCheck(bot_state_t *bs, int windex)
;1090:{
line 1091
;1091:	if (!gWPArray[windex] || !gWPArray[windex]->inuse)
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $468
ADDRLP4 0
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $466
LABELV $468
line 1092
;1092:	{
line 1093
;1093:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $466
line 1096
;1094:	}
;1095:
;1096:	if (bs->wpDirection && (gWPArray[windex]->flags & WPFLAG_ONEWAY_FWD))
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $469
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $469
line 1097
;1097:	{
line 1098
;1098:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $469
line 1100
;1099:	}
;1100:	else if (!bs->wpDirection && (gWPArray[windex]->flags & WPFLAG_ONEWAY_BACK))
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $471
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $471
line 1101
;1101:	{
line 1102
;1102:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $471
line 1105
;1103:	}
;1104:
;1105:	if (bs->wpCurrent && gWPArray[windex]->forceJumpTo &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $473
ADDRLP4 20
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $473
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 20
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
ADDRLP4 16
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
CNSTF4 1115684864
ADDF4
LEF4 $473
ADDRLP4 12
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
GEI4 $473
line 1108
;1106:		gWPArray[windex]->origin[2] > (bs->wpCurrent->origin[2]+64) &&
;1107:		bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION] < gWPArray[windex]->forceJumpTo)
;1108:	{
line 1109
;1109:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $465
JUMPV
LABELV $473
line 1112
;1110:	}
;1111:
;1112:	return 1;
CNSTI4 1
RETI4
LABELV $465
endproc PassWayCheck 32 0
export TotalTrailDistance
proc TotalTrailDistance 40 0
line 1116
;1113:}
;1114:
;1115:float TotalTrailDistance(int start, int end, bot_state_t *bs)
;1116:{
line 1120
;1117:	int beginat;
;1118:	int endat;
;1119:	float distancetotal;
;1120:	float gdif = 0;
ADDRLP4 12
CNSTF4 0
ASGNF4
line 1122
;1121:
;1122:	distancetotal = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 1124
;1123:
;1124:	if (start > end)
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LEI4 $476
line 1125
;1125:	{
line 1126
;1126:		beginat = end;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 1127
;1127:		endat = start;
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
line 1128
;1128:	}
ADDRGP4 $479
JUMPV
LABELV $476
line 1130
;1129:	else
;1130:	{
line 1131
;1131:		beginat = start;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 1132
;1132:		endat = end;
ADDRLP4 8
ADDRFP4 4
INDIRI4
ASGNI4
line 1133
;1133:	}
ADDRGP4 $479
JUMPV
LABELV $478
line 1136
;1134:
;1135:	while (beginat < endat)
;1136:	{
line 1137
;1137:		if (beginat >= gWPNum || !gWPArray[beginat] || !gWPArray[beginat]->inuse)
ADDRLP4 0
INDIRI4
ADDRGP4 gWPNum
INDIRI4
GEI4 $484
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $484
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
NEI4 $481
LABELV $484
line 1138
;1138:		{
line 1139
;1139:			return -1; //error
CNSTF4 3212836864
RETF4
ADDRGP4 $475
JUMPV
LABELV $481
line 1142
;1140:		}
;1141:
;1142:		if ((end > start && gWPArray[beginat]->flags & WPFLAG_ONEWAY_BACK) ||
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRI4
LEI4 $488
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 32768
BANDI4
CNSTI4 0
NEI4 $487
LABELV $488
ADDRFP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LEI4 $485
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $485
LABELV $487
line 1144
;1143:			(start > end && gWPArray[beginat]->flags & WPFLAG_ONEWAY_FWD))
;1144:		{
line 1145
;1145:			return -1;
CNSTF4 3212836864
RETF4
ADDRGP4 $475
JUMPV
LABELV $485
line 1148
;1146:		}
;1147:	
;1148:		if (gWPArray[beginat]->forceJumpTo)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
EQI4 $489
line 1149
;1149:		{
line 1150
;1150:			if (gWPArray[beginat-1] && gWPArray[beginat-1]->origin[2]+64 < gWPArray[beginat]->origin[2])
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $491
ADDRLP4 28
CNSTI4 8
ASGNI4
ADDRLP4 24
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
CNSTF4 1115684864
ADDF4
ADDRLP4 24
INDIRI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ADDRLP4 28
INDIRI4
ADDP4
INDIRF4
GEF4 $491
line 1151
;1151:			{
line 1152
;1152:				gdif = gWPArray[beginat]->origin[2] - gWPArray[beginat-1]->origin[2];
ADDRLP4 32
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 36
CNSTI4 8
ASGNI4
ADDRLP4 12
ADDRLP4 32
INDIRI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
ADDRLP4 32
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
ADDRLP4 36
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1153
;1153:			}
LABELV $491
line 1155
;1154:
;1155:			if (gdif)
ADDRLP4 12
INDIRF4
CNSTF4 0
EQF4 $496
line 1156
;1156:			{
line 1161
;1157:			//	if (bs && bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION] < gWPArray[beginat]->forceJumpTo)
;1158:			//	{
;1159:			//		return -1;
;1160:			//	}
;1161:			}
LABELV $496
line 1162
;1162:		}
LABELV $489
line 1171
;1163:		
;1164:	/*	if (bs->wpCurrent && gWPArray[windex]->forceJumpTo &&
;1165:			gWPArray[windex]->origin[2] > (bs->wpCurrent->origin[2]+64) &&
;1166:			bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION] < gWPArray[windex]->forceJumpTo)
;1167:		{
;1168:			return -1;
;1169:		}*/
;1170:
;1171:		distancetotal += gWPArray[beginat]->disttonext;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDF4
ASGNF4
line 1173
;1172:
;1173:		beginat++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1174
;1174:	}
LABELV $479
line 1135
ADDRLP4 0
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $478
line 1176
;1175:
;1176:	return distancetotal;
ADDRLP4 4
INDIRF4
RETF4
LABELV $475
endproc TotalTrailDistance 40 0
export CheckForShorterRoutes
proc CheckForShorterRoutes 40 12
line 1180
;1177:}
;1178:
;1179:void CheckForShorterRoutes(bot_state_t *bs, int newwpindex)
;1180:{
line 1187
;1181:	float bestlen;
;1182:	float checklen;
;1183:	int bestindex;
;1184:	int i;
;1185:	int fj;
;1186:
;1187:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1188
;1188:	fj = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1190
;1189:
;1190:	if (!bs->wpDestination)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $499
line 1191
;1191:	{
line 1192
;1192:		return;
ADDRGP4 $498
JUMPV
LABELV $499
line 1195
;1193:	}
;1194:
;1195:	if (newwpindex < bs->wpDestination->index)
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
GEI4 $501
line 1196
;1196:	{
line 1197
;1197:		bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 1198
;1198:	}
ADDRGP4 $502
JUMPV
LABELV $501
line 1199
;1199:	else if (newwpindex > bs->wpDestination->index)
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
LEI4 $503
line 1200
;1200:	{
line 1201
;1201:		bs->wpDirection = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 1
ASGNI4
line 1202
;1202:	}
LABELV $503
LABELV $502
line 1204
;1203:
;1204:	if (bs->wpSwitchTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1972
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $505
line 1205
;1205:	{
line 1206
;1206:		return;
ADDRGP4 $498
JUMPV
LABELV $505
line 1209
;1207:	}
;1208:
;1209:	if (!gWPArray[newwpindex]->neighbornum)
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 0
NEI4 $508
line 1210
;1210:	{
line 1211
;1211:		return;
ADDRGP4 $498
JUMPV
LABELV $508
line 1214
;1212:	}
;1213:
;1214:	bestindex = newwpindex;
ADDRLP4 12
ADDRFP4 4
INDIRI4
ASGNI4
line 1215
;1215:	bestlen = TotalTrailDistance(newwpindex, bs->wpDestination->index, bs);
ADDRFP4 4
INDIRI4
ARGI4
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 4
ADDRLP4 24
INDIRF4
ASGNF4
ADDRGP4 $511
JUMPV
LABELV $510
line 1218
;1216:
;1217:	while (i < gWPArray[newwpindex]->neighbornum)
;1218:	{
line 1219
;1219:		checklen = TotalTrailDistance(gWPArray[newwpindex]->neighbors[i].num, bs->wpDestination->index, bs);
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 32
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 32
INDIRF4
ASGNF4
line 1221
;1220:
;1221:		if (checklen < bestlen-64 || bestlen == -1)
ADDRLP4 8
INDIRF4
ADDRLP4 4
INDIRF4
CNSTF4 1115684864
SUBF4
LTF4 $515
ADDRLP4 4
INDIRF4
CNSTF4 3212836864
NEF4 $513
LABELV $515
line 1222
;1222:		{
line 1223
;1223:			if (bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION] >= gWPArray[newwpindex]->neighbors[i].forceJumpTo)
ADDRFP4 0
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
LTI4 $516
line 1224
;1224:			{
line 1225
;1225:				bestlen = checklen;
ADDRLP4 4
ADDRLP4 8
INDIRF4
ASGNF4
line 1226
;1226:				bestindex = gWPArray[newwpindex]->neighbors[i].num;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDP4
INDIRI4
ASGNI4
line 1228
;1227:
;1228:				if (gWPArray[newwpindex]->neighbors[i].forceJumpTo)
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $518
line 1229
;1229:				{
line 1230
;1230:					fj = gWPArray[newwpindex]->neighbors[i].forceJumpTo;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 3
LSHI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 44
ADDP4
ADDP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
line 1231
;1231:				}
ADDRGP4 $519
JUMPV
LABELV $518
line 1233
;1232:				else
;1233:				{
line 1234
;1234:					fj = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 1235
;1235:				}
LABELV $519
line 1236
;1236:			}
LABELV $516
line 1237
;1237:		}
LABELV $513
line 1239
;1238:
;1239:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1240
;1240:	}
LABELV $511
line 1217
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LTI4 $510
line 1242
;1241:
;1242:	if (bestindex != newwpindex && bestindex != -1)
ADDRLP4 12
INDIRI4
ADDRFP4 4
INDIRI4
EQI4 $520
ADDRLP4 12
INDIRI4
CNSTI4 -1
EQI4 $520
line 1243
;1243:	{
line 1244
;1244:		bs->wpCurrent = gWPArray[bestindex];
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 1245
;1245:		bs->wpSwitchTime = level.time + 3000;
ADDRFP4 0
INDIRP4
CNSTI4 1972
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3000
ADDI4
CVIF4 4
ASGNF4
line 1247
;1246:
;1247:		if (fj)
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $523
line 1248
;1248:		{
line 1250
;1249:#ifndef FORCEJUMP_INSTANTMETHOD
;1250:			bs->forceJumpChargeTime = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1251
;1251:			bs->beStill = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ASGNF4
line 1252
;1252:			bs->forceJumping = bs->forceJumpChargeTime;
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 2012
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 1259
;1253:#else
;1254:			bs->beStill = level.time + 500;
;1255:			bs->jumpTime = level.time + fj*1200;
;1256:			bs->jDelay = level.time + 200;
;1257:			bs->forceJumping = bs->jumpTime;
;1258:#endif
;1259:		}
LABELV $523
line 1260
;1260:	}
LABELV $520
line 1261
;1261:}
LABELV $498
endproc CheckForShorterRoutes 40 12
export WPConstantRoutine
proc WPConstantRoutine 24 0
line 1264
;1262:
;1263:void WPConstantRoutine(bot_state_t *bs)
;1264:{
line 1265
;1265:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $528
line 1266
;1266:	{
line 1267
;1267:		return;
ADDRGP4 $527
JUMPV
LABELV $528
line 1270
;1268:	}
;1269:
;1270:	if (bs->wpCurrent->flags & WPFLAG_DUCK)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $530
line 1271
;1271:	{
line 1272
;1272:		bs->duckTime = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 1996
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 1273
;1273:	}
LABELV $530
line 1276
;1274:
;1275:#ifndef FORCEJUMP_INSTANTMETHOD
;1276:	if (bs->wpCurrent->flags & WPFLAG_JUMP)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $533
line 1277
;1277:	{
line 1278
;1278:		float heightDif = (bs->wpCurrent->origin[2] - bs->origin[2]+16);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1280
;1279:
;1280:		if (bs->origin[2]+16 >= bs->wpCurrent->origin[2])
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ADDRLP4 8
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LTF4 $535
line 1281
;1281:		{ //then why exactly would we be force jumping?
line 1282
;1282:			heightDif = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1283
;1283:		}
LABELV $535
line 1285
;1284:
;1285:		if (heightDif > 40 && (bs->cur_ps.fd.forcePowersKnown & (1 << FP_LEVITATION)) && (bs->cur_ps.fd.forceJumpCharge < (forceJumpStrength[bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION]]-100) || bs->cur_ps.groundEntityNum == ENTITYNUM_NONE))
ADDRLP4 0
INDIRF4
CNSTF4 1109393408
LEF4 $537
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 2
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
BANDI4
CNSTI4 0
EQI4 $537
ADDRLP4 12
INDIRP4
CNSTI4 1100
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
LSHI4
ADDRGP4 forceJumpStrength
ADDP4
INDIRF4
CNSTF4 1120403456
SUBF4
LTF4 $539
ADDRLP4 12
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $537
LABELV $539
line 1286
;1286:		{
line 1287
;1287:			bs->forceJumpChargeTime = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 1288
;1288:			if (bs->cur_ps.groundEntityNum != ENTITYNUM_NONE && bs->jumpPrep < (level.time-300))
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $541
ADDRLP4 20
INDIRP4
CNSTI4 2008
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CNSTI4 300
SUBI4
CVIF4 4
GEF4 $541
line 1289
;1289:			{
line 1290
;1290:				bs->jumpPrep = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 2008
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
CVIF4 4
ASGNF4
line 1291
;1291:			}
LABELV $541
line 1292
;1292:			bs->beStill = level.time + 300;
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 300
ADDI4
CVIF4 4
ASGNF4
line 1293
;1293:			bs->jumpTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
CNSTF4 0
ASGNF4
line 1295
;1294:
;1295:			if (bs->wpSeenTime < (level.time + 600))
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CNSTI4 600
ADDI4
CVIF4 4
GEF4 $538
line 1296
;1296:			{
line 1297
;1297:				bs->wpSeenTime = level.time + 600;
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 600
ADDI4
CVIF4 4
ASGNF4
line 1298
;1298:			}
line 1299
;1299:		}
ADDRGP4 $538
JUMPV
LABELV $537
line 1300
;1300:		else if (heightDif > 64 && !(bs->cur_ps.fd.forcePowersKnown & (1 << FP_LEVITATION)))
ADDRLP4 0
INDIRF4
CNSTF4 1115684864
LEF4 $550
ADDRFP4 0
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $550
line 1301
;1301:		{ //this point needs force jump to reach and we don't have it
line 1303
;1302:			//Kill the current point and turn around
;1303:			bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 1304
;1304:			if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $552
line 1305
;1305:			{
line 1306
;1306:				bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 1307
;1307:			}
ADDRGP4 $527
JUMPV
LABELV $552
line 1309
;1308:			else
;1309:			{
line 1310
;1310:				bs->wpDirection = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 1
ASGNI4
line 1311
;1311:			}
line 1313
;1312:
;1313:			return;
ADDRGP4 $527
JUMPV
LABELV $550
LABELV $538
line 1315
;1314:		}
;1315:	}
LABELV $533
line 1318
;1316:#endif
;1317:
;1318:	if (bs->wpCurrent->forceJumpTo)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 0
EQI4 $554
line 1319
;1319:	{
line 1326
;1320:#ifdef FORCEJUMP_INSTANTMETHOD
;1321:		if (bs->origin[2]+16 < bs->wpCurrent->origin[2])
;1322:		{
;1323:			bs->jumpTime = level.time + 100;
;1324:		}
;1325:#else
;1326:		float heightDif = (bs->wpCurrent->origin[2] - bs->origin[2]+16);
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 4
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
CNSTF4 1098907648
ADDF4
ASGNF4
line 1328
;1327:
;1328:		if (bs->origin[2]+16 >= bs->wpCurrent->origin[2])
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1098907648
ADDF4
ADDRLP4 8
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
LTF4 $556
line 1329
;1329:		{ //then why exactly would we be force jumping?
line 1330
;1330:			heightDif = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 1331
;1331:		}
LABELV $556
line 1333
;1332:
;1333:		if (bs->cur_ps.fd.forceJumpCharge < (forceJumpStrength[bs->cur_ps.fd.forcePowerLevel[FP_LEVITATION]]-100))
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1100
ADDP4
INDIRF4
ADDRLP4 12
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 forceJumpStrength
ADDP4
INDIRF4
CNSTF4 1120403456
SUBF4
GEF4 $558
line 1334
;1334:		{
line 1335
;1335:			bs->forceJumpChargeTime = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
ASGNI4
line 1336
;1336:		}
LABELV $558
line 1338
;1337:#endif
;1338:	}
LABELV $554
line 1339
;1339:}
LABELV $527
endproc WPConstantRoutine 24 0
export BotCTFGuardDuty
proc BotCTFGuardDuty 0 0
line 1342
;1340:
;1341:qboolean BotCTFGuardDuty(bot_state_t *bs)
;1342:{
line 1343
;1343:	if (g_gametype.integer != GT_CTF &&
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $562
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $562
line 1345
;1344:		g_gametype.integer != GT_CTY)
;1345:	{
line 1346
;1346:		return qfalse;
CNSTI4 0
RETI4
ADDRGP4 $561
JUMPV
LABELV $562
line 1349
;1347:	}
;1348:
;1349:	if (bs->ctfState == CTFSTATE_DEFENDER)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 2
NEI4 $566
line 1350
;1350:	{
line 1351
;1351:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $561
JUMPV
LABELV $566
line 1354
;1352:	}
;1353:
;1354:	return qfalse;
CNSTI4 0
RETI4
LABELV $561
endproc BotCTFGuardDuty 0 0
export WPTouchRoutine
proc WPTouchRoutine 56 8
line 1358
;1355:}
;1356:
;1357:void WPTouchRoutine(bot_state_t *bs)
;1358:{
line 1361
;1359:	int lastNum;
;1360:
;1361:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $569
line 1362
;1362:	{
line 1363
;1363:		return;
ADDRGP4 $568
JUMPV
LABELV $569
line 1366
;1364:	}
;1365:
;1366:	bs->wpTravelTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 1964
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 1368
;1367:
;1368:	if (bs->wpCurrent->flags & WPFLAG_NOMOVEFUNC)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $572
line 1369
;1369:	{
line 1370
;1370:		bs->noUseTime = level.time + 4000;
ADDRFP4 0
INDIRP4
CNSTI4 4788
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 4000
ADDI4
ASGNI4
line 1371
;1371:	}
LABELV $572
line 1380
;1372:
;1373:#ifdef FORCEJUMP_INSTANTMETHOD
;1374:	if ((bs->wpCurrent->flags & WPFLAG_JUMP) && bs->wpCurrent->forceJumpTo)
;1375:	{ //jump if we're flagged to but not if this indicates a force jump point. Force jumping is
;1376:	  //handled elsewhere.
;1377:		bs->jumpTime = level.time + 100;
;1378:	}
;1379:#else
;1380:	if ((bs->wpCurrent->flags & WPFLAG_JUMP) && !bs->wpCurrent->forceJumpTo)
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 16
BANDI4
ADDRLP4 8
INDIRI4
EQI4 $575
ADDRLP4 4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
NEI4 $575
line 1381
;1381:	{ //jump if we're flagged to but not if this indicates a force jump point. Force jumping is
line 1383
;1382:	  //handled elsewhere.
;1383:		bs->jumpTime = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 1384
;1384:	}
LABELV $575
line 1387
;1385:#endif
;1386:
;1387:	trap_Cvar_Update(&bot_camp);
ADDRGP4 bot_camp
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1389
;1388:
;1389:	if (bs->isCamper && bot_camp.integer && (BotIsAChickenWuss(bs) || BotCTFGuardDuty(bs) || bs->isCamper == 2) && ((bs->wpCurrent->flags & WPFLAG_SNIPEORCAMP) || (bs->wpCurrent->flags & WPFLAG_SNIPEORCAMPSTAND)) &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 2048
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $578
ADDRGP4 bot_camp+12
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $578
ADDRLP4 12
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 BotIsAChickenWuss
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $582
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 BotCTFGuardDuty
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $582
ADDRFP4 0
INDIRP4
CNSTI4 2048
ADDP4
INDIRI4
CNSTI4 2
NEI4 $578
LABELV $582
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ASGNI4
ADDRLP4 32
CNSTI4 0
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 8192
BANDI4
ADDRLP4 32
INDIRI4
NEI4 $583
ADDRLP4 28
INDIRI4
CNSTI4 2048
BANDI4
ADDRLP4 32
INDIRI4
EQI4 $578
LABELV $583
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 2
EQI4 $578
ADDRLP4 36
INDIRI4
CNSTI4 1
EQI4 $578
line 1391
;1390:		bs->cur_ps.weapon != WP_SABER && bs->cur_ps.weapon != WP_STUN_BATON)
;1391:	{ //if we're a camper and a chicken then camp
line 1392
;1392:		if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $584
line 1393
;1393:		{
line 1394
;1394:			lastNum = bs->wpCurrent->index+1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1395
;1395:		}
ADDRGP4 $585
JUMPV
LABELV $584
line 1397
;1396:		else
;1397:		{
line 1398
;1398:			lastNum = bs->wpCurrent->index-1;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 1399
;1399:		}
LABELV $585
line 1401
;1400:
;1401:		if (gWPArray[lastNum] && gWPArray[lastNum]->inuse && gWPArray[lastNum]->index && bs->isCamping < level.time)
ADDRLP4 40
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $579
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRLP4 40
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $579
ADDRLP4 40
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ADDRLP4 44
INDIRI4
EQI4 $579
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $579
line 1402
;1402:		{
line 1403
;1403:			bs->isCamping = level.time + rand()%15000 + 30000;
ADDRLP4 48
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 48
INDIRI4
CNSTI4 15000
MODI4
ADDI4
CNSTI4 30000
ADDI4
CVIF4 4
ASGNF4
line 1404
;1404:			bs->wpCamping = bs->wpCurrent;
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 2056
ADDP4
ADDRLP4 52
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ASGNP4
line 1405
;1405:			bs->wpCampingTo = gWPArray[lastNum];
ADDRFP4 0
INDIRP4
CNSTI4 2060
ADDP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 1407
;1406:
;1407:			if (bs->wpCurrent->flags & WPFLAG_SNIPEORCAMPSTAND)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2048
BANDI4
CNSTI4 0
EQI4 $590
line 1408
;1408:			{
line 1409
;1409:				bs->campStanding = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 2064
ADDP4
CNSTI4 1
ASGNI4
line 1410
;1410:			}
ADDRGP4 $579
JUMPV
LABELV $590
line 1412
;1411:			else
;1412:			{
line 1413
;1413:				bs->campStanding = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 2064
ADDP4
CNSTI4 0
ASGNI4
line 1414
;1414:			}
line 1415
;1415:		}
line 1417
;1416:
;1417:	}
ADDRGP4 $579
JUMPV
LABELV $578
line 1418
;1418:	else if ((bs->cur_ps.weapon == WP_SABER || bs->cur_ps.weapon == WP_STUN_BATON) &&
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $595
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $592
LABELV $595
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $592
line 1420
;1419:		bs->isCamping > level.time)
;1420:	{
line 1421
;1421:		bs->isCamping = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
CNSTF4 0
ASGNF4
line 1422
;1422:		bs->wpCampingTo = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2060
ADDP4
CNSTP4 0
ASGNP4
line 1423
;1423:		bs->wpCamping = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
CNSTP4 0
ASGNP4
line 1424
;1424:	}
LABELV $592
LABELV $579
line 1426
;1425:
;1426:	if (bs->wpDestination)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $596
line 1427
;1427:	{
line 1428
;1428:		if (bs->wpCurrent->index == bs->wpDestination->index)
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
CNSTI4 16
ASGNI4
ADDRLP4 44
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
NEI4 $598
line 1429
;1429:		{
line 1430
;1430:			bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 1432
;1431:
;1432:			if (bs->runningLikeASissy)
ADDRFP4 0
INDIRP4
CNSTI4 2296
ADDP4
INDIRI4
CNSTI4 0
EQI4 $600
line 1433
;1433:			{ //this obviously means we're scared and running, so we'll want to keep our navigational priorities less delayed
line 1434
;1434:				bs->destinationGrabTime = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 1435
;1435:			}
ADDRGP4 $599
JUMPV
LABELV $600
line 1437
;1436:			else
;1437:			{
line 1438
;1438:				bs->destinationGrabTime = level.time + 3500;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 3500
ADDI4
CVIF4 4
ASGNF4
line 1439
;1439:			}
line 1440
;1440:		}
ADDRGP4 $599
JUMPV
LABELV $598
line 1442
;1441:		else
;1442:		{
line 1443
;1443:			CheckForShorterRoutes(bs, bs->wpCurrent->index);
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRGP4 CheckForShorterRoutes
CALLV
pop
line 1444
;1444:		}
LABELV $599
line 1445
;1445:	}
LABELV $596
line 1446
;1446:}
LABELV $568
endproc WPTouchRoutine 56 8
export MoveTowardIdealAngles
proc MoveTowardIdealAngles 4 0
line 1449
;1447:
;1448:void MoveTowardIdealAngles(bot_state_t *bs)
;1449:{
line 1450
;1450:	VectorCopy(bs->goalAngles, bs->ideal_viewangles);
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1780
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 1884
ADDP4
INDIRB
ASGNB 12
line 1451
;1451:}
LABELV $604
endproc MoveTowardIdealAngles 4 0
lit
align 4
LABELV $606
byte 4 3245342720
byte 4 3245342720
byte 4 3238002688
align 4
LABELV $607
byte 4 1097859072
byte 4 1097859072
byte 4 1109393408
export BotTrace_Strafe
code
proc BotTrace_Strafe 1200 28
line 1460
;1452:
;1453:#define BOT_STRAFE_AVOIDANCE
;1454:
;1455:#ifdef BOT_STRAFE_AVOIDANCE
;1456:#define STRAFEAROUND_RIGHT			1
;1457:#define STRAFEAROUND_LEFT			2
;1458:
;1459:int BotTrace_Strafe(bot_state_t *bs, vec3_t traceto)
;1460:{
line 1461
;1461:	vec3_t playerMins = {-15, -15, /*DEFAULT_MINS_2*/-8};
ADDRLP4 1140
ADDRGP4 $606
INDIRB
ASGNB 12
line 1462
;1462:	vec3_t playerMaxs = {15, 15, DEFAULT_MAXS_2};
ADDRLP4 1152
ADDRGP4 $607
INDIRB
ASGNB 12
line 1468
;1463:	vec3_t from, to;
;1464:	vec3_t dirAng, dirDif;
;1465:	vec3_t forward, right;
;1466:	trace_t tr;
;1467:
;1468:	if (bs->cur_ps.groundEntityNum == ENTITYNUM_NONE)
ADDRFP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $608
line 1469
;1469:	{ //don't do this in the air, it can be.. dangerous.
line 1470
;1470:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $608
line 1473
;1471:	}
;1472:
;1473:	VectorSubtract(traceto, bs->origin, dirAng);
ADDRLP4 1176
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 1176
INDIRP4
INDIRF4
ADDRLP4 1180
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 1176
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1180
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1474
;1474:	VectorNormalize(dirAng);
ADDRLP4 36
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1475
;1475:	vectoangles(dirAng, dirAng);
ADDRLP4 36
ARGP4
ADDRLP4 36
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1477
;1476:
;1477:	if (AngleDifference(bs->viewangles[YAW], dirAng[YAW]) > 60 ||
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRF4
ARGF4
ADDRLP4 36+4
INDIRF4
ARGF4
ADDRLP4 1184
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 1184
INDIRF4
CNSTF4 1114636288
GTF4 $616
ADDRFP4 0
INDIRP4
CNSTI4 1772
ADDP4
INDIRF4
ARGF4
ADDRLP4 36+4
INDIRF4
ARGF4
ADDRLP4 1188
ADDRGP4 AngleDifference
CALLF4
ASGNF4
ADDRLP4 1188
INDIRF4
CNSTF4 3262119936
GEF4 $612
LABELV $616
line 1479
;1478:		AngleDifference(bs->viewangles[YAW], dirAng[YAW]) < -60)
;1479:	{ //If we aren't facing the direction we're going here, then we've got enough excuse to be too stupid to strafe around anyway
line 1480
;1480:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $612
line 1483
;1481:	}
;1482:
;1483:	VectorCopy(bs->origin, from);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 1484
;1484:	VectorCopy(traceto, to);
ADDRLP4 12
ADDRFP4 4
INDIRP4
INDIRB
ASGNB 12
line 1486
;1485:
;1486:	VectorSubtract(to, from, dirDif);
ADDRLP4 48
ADDRLP4 12
INDIRF4
ADDRLP4 0
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 0+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 48+8
ADDRLP4 12+8
INDIRF4
ADDRLP4 0+8
INDIRF4
SUBF4
ASGNF4
line 1487
;1487:	VectorNormalize(dirDif);
ADDRLP4 48
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 1488
;1488:	vectoangles(dirDif, dirDif);
ADDRLP4 48
ARGP4
ADDRLP4 48
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1490
;1489:
;1490:	AngleVectors(dirDif, forward, 0, 0);
ADDRLP4 48
ARGP4
ADDRLP4 1164
ARGP4
ADDRLP4 1192
CNSTP4 0
ASGNP4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRLP4 1192
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1492
;1491:
;1492:	to[0] = from[0] + forward[0]*32;
ADDRLP4 12
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
ADDRLP4 1164
INDIRF4
MULF4
ADDF4
ASGNF4
line 1493
;1493:	to[1] = from[1] + forward[1]*32;
ADDRLP4 12+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
ADDRLP4 1164+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1494
;1494:	to[2] = from[2] + forward[2]*32;
ADDRLP4 12+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1107296256
ADDRLP4 1164+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1496
;1495:
;1496:	trap_Trace(&tr, from, playerMins, playerMaxs, to, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 1152
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1498
;1497:
;1498:	if (tr.fraction == 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
NEF4 $629
line 1499
;1499:	{
line 1500
;1500:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $605
JUMPV
LABELV $629
line 1503
;1501:	}
;1502:
;1503:	AngleVectors(dirAng, 0, right, 0);
ADDRLP4 36
ARGP4
ADDRLP4 1196
CNSTP4 0
ASGNP4
ADDRLP4 1196
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1196
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1505
;1504:
;1505:	from[0] += right[0]*32;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1107296256
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 1506
;1506:	from[1] += right[1]*32;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1107296256
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1507
;1507:	from[2] += right[2]*16;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1098907648
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1509
;1508:
;1509:	to[0] += right[0]*32;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1107296256
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 1510
;1510:	to[1] += right[1]*32;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1107296256
ADDRLP4 24+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1511
;1511:	to[2] += right[2]*32;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1107296256
ADDRLP4 24+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1513
;1512:
;1513:	trap_Trace(&tr, from, playerMins, playerMaxs, to, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 1152
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1515
;1514:
;1515:	if (tr.fraction == 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
NEF4 $640
line 1516
;1516:	{
line 1517
;1517:		return STRAFEAROUND_RIGHT;
CNSTI4 1
RETI4
ADDRGP4 $605
JUMPV
LABELV $640
line 1520
;1518:	}
;1519:
;1520:	from[0] -= right[0]*64;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1115684864
ADDRLP4 24
INDIRF4
MULF4
SUBF4
ASGNF4
line 1521
;1521:	from[1] -= right[1]*64;
ADDRLP4 0+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1115684864
ADDRLP4 24+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 1522
;1522:	from[2] -= right[2]*64;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1115684864
ADDRLP4 24+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 1524
;1523:
;1524:	to[0] -= right[0]*64;
ADDRLP4 12
ADDRLP4 12
INDIRF4
CNSTF4 1115684864
ADDRLP4 24
INDIRF4
MULF4
SUBF4
ASGNF4
line 1525
;1525:	to[1] -= right[1]*64;
ADDRLP4 12+4
ADDRLP4 12+4
INDIRF4
CNSTF4 1115684864
ADDRLP4 24+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 1526
;1526:	to[2] -= right[2]*64;
ADDRLP4 12+8
ADDRLP4 12+8
INDIRF4
CNSTF4 1115684864
ADDRLP4 24+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 1528
;1527:
;1528:	trap_Trace(&tr, from, playerMins, playerMaxs, to, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 1152
ARGP4
ADDRLP4 12
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1530
;1529:
;1530:	if (tr.fraction == 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
NEF4 $651
line 1531
;1531:	{
line 1532
;1532:		return STRAFEAROUND_LEFT;
CNSTI4 2
RETI4
ADDRGP4 $605
JUMPV
LABELV $651
line 1535
;1533:	}
;1534:
;1535:	return 0;
CNSTI4 0
RETI4
LABELV $605
endproc BotTrace_Strafe 1200 28
export BotTrace_Jump
proc BotTrace_Jump 1196 28
line 1540
;1536:}
;1537:#endif
;1538:
;1539:int BotTrace_Jump(bot_state_t *bs, vec3_t traceto)
;1540:{
line 1545
;1541:	vec3_t mins, maxs, a, fwd, traceto_mod, tracefrom_mod;
;1542:	trace_t tr;
;1543:	int orTr;
;1544:
;1545:	VectorSubtract(traceto, bs->origin, a);
ADDRLP4 1156
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 1156
INDIRP4
INDIRF4
ADDRLP4 1160
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 1156
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1160
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1546
;1546:	vectoangles(a, a);
ADDRLP4 24
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1548
;1547:
;1548:	AngleVectors(a, fwd, NULL, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1164
CNSTP4 0
ASGNP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1550
;1549:
;1550:	traceto_mod[0] = bs->origin[0] + fwd[0]*4;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 1128
INDIRF4
MULF4
ADDF4
ASGNF4
line 1551
;1551:	traceto_mod[1] = bs->origin[1] + fwd[1]*4;
ADDRLP4 36+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 1128+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1552
;1552:	traceto_mod[2] = bs->origin[2] + fwd[2]*4;
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 1128+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1554
;1553:
;1554:	mins[0] = -15;
ADDRLP4 0
CNSTF4 3245342720
ASGNF4
line 1555
;1555:	mins[1] = -15;
ADDRLP4 0+4
CNSTF4 3245342720
ASGNF4
line 1556
;1556:	mins[2] = -18;
ADDRLP4 0+8
CNSTF4 3247439872
ASGNF4
line 1557
;1557:	maxs[0] = 15;
ADDRLP4 12
CNSTF4 1097859072
ASGNF4
line 1558
;1558:	maxs[1] = 15;
ADDRLP4 12+4
CNSTF4 1097859072
ASGNF4
line 1559
;1559:	maxs[2] = 32;
ADDRLP4 12+8
CNSTF4 1107296256
ASGNF4
line 1561
;1560:
;1561:	trap_Trace(&tr, bs->origin, mins, maxs, traceto_mod, bs->client, MASK_PLAYERSOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1168
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 1168
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1563
;1562:
;1563:	if (tr.fraction == 1)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
NEF4 $665
line 1564
;1564:	{
line 1565
;1565:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $654
JUMPV
LABELV $665
line 1568
;1566:	}
;1567:
;1568:	orTr = tr.entityNum;
ADDRLP4 1140
ADDRLP4 48+52
INDIRI4
ASGNI4
line 1570
;1569:
;1570:	VectorCopy(bs->origin, tracefrom_mod);
ADDRLP4 1144
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 1572
;1571:
;1572:	tracefrom_mod[2] += 41;
ADDRLP4 1144+8
ADDRLP4 1144+8
INDIRF4
CNSTF4 1109655552
ADDF4
ASGNF4
line 1573
;1573:	traceto_mod[2] += 41;
ADDRLP4 36+8
ADDRLP4 36+8
INDIRF4
CNSTF4 1109655552
ADDF4
ASGNF4
line 1575
;1574:
;1575:	mins[0] = -15;
ADDRLP4 0
CNSTF4 3245342720
ASGNF4
line 1576
;1576:	mins[1] = -15;
ADDRLP4 0+4
CNSTF4 3245342720
ASGNF4
line 1577
;1577:	mins[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1578
;1578:	maxs[0] = 15;
ADDRLP4 12
CNSTF4 1097859072
ASGNF4
line 1579
;1579:	maxs[1] = 15;
ADDRLP4 12+4
CNSTF4 1097859072
ASGNF4
line 1580
;1580:	maxs[2] = 8;
ADDRLP4 12+8
CNSTF4 1090519040
ASGNF4
line 1582
;1581:
;1582:	trap_Trace(&tr, tracefrom_mod, mins, maxs, traceto_mod, bs->client, MASK_PLAYERSOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1144
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1584
;1583:
;1584:	if (tr.fraction == 1)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
NEF4 $675
line 1585
;1585:	{
line 1586
;1586:		if (orTr >= 0 && orTr < MAX_CLIENTS && botstates[orTr] && botstates[orTr]->jumpTime > level.time)
ADDRLP4 1140
INDIRI4
CNSTI4 0
LTI4 $678
ADDRLP4 1140
INDIRI4
CNSTI4 32
GEI4 $678
ADDRLP4 1176
ADDRLP4 1140
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1176
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $678
ADDRLP4 1176
INDIRP4
CNSTI4 2000
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $678
line 1587
;1587:		{
line 1588
;1588:			return 0; //so bots don't try to jump over each other at the same time
CNSTI4 0
RETI4
ADDRGP4 $654
JUMPV
LABELV $678
line 1591
;1589:		}
;1590:
;1591:		if (bs->currentEnemy && bs->currentEnemy->s.number == orTr && (BotGetWeaponRange(bs) == BWEAPONRANGE_SABER || BotGetWeaponRange(bs) == BWEAPONRANGE_MELEE))
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1184
ADDRLP4 1180
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1184
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $681
ADDRLP4 1184
INDIRP4
INDIRI4
ADDRLP4 1140
INDIRI4
NEI4 $681
ADDRLP4 1180
INDIRP4
ARGP4
ADDRLP4 1188
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 1188
INDIRI4
CNSTI4 4
EQI4 $683
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1192
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 1192
INDIRI4
CNSTI4 1
NEI4 $681
LABELV $683
line 1592
;1592:		{
line 1593
;1593:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $654
JUMPV
LABELV $681
line 1596
;1594:		}
;1595:
;1596:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $654
JUMPV
LABELV $675
line 1599
;1597:	}
;1598:
;1599:	return 0;
CNSTI4 0
RETI4
LABELV $654
endproc BotTrace_Jump 1196 28
export BotTrace_Duck
proc BotTrace_Duck 1168 28
line 1603
;1600:}
;1601:
;1602:int BotTrace_Duck(bot_state_t *bs, vec3_t traceto)
;1603:{
line 1607
;1604:	vec3_t mins, maxs, a, fwd, traceto_mod, tracefrom_mod;
;1605:	trace_t tr;
;1606:
;1607:	VectorSubtract(traceto, bs->origin, a);
ADDRLP4 1152
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 1152
INDIRP4
INDIRF4
ADDRLP4 1156
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 1152
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1156
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1608
;1608:	vectoangles(a, a);
ADDRLP4 24
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 1610
;1609:
;1610:	AngleVectors(a, fwd, NULL, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 1160
CNSTP4 0
ASGNP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1612
;1611:
;1612:	traceto_mod[0] = bs->origin[0] + fwd[0]*4;
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 48
INDIRF4
MULF4
ADDF4
ASGNF4
line 1613
;1613:	traceto_mod[1] = bs->origin[1] + fwd[1]*4;
ADDRLP4 36+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 48+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1614
;1614:	traceto_mod[2] = bs->origin[2] + fwd[2]*4;
ADDRLP4 36+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1082130432
ADDRLP4 48+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1616
;1615:
;1616:	mins[0] = -15;
ADDRLP4 0
CNSTF4 3245342720
ASGNF4
line 1617
;1617:	mins[1] = -15;
ADDRLP4 0+4
CNSTF4 3245342720
ASGNF4
line 1618
;1618:	mins[2] = -23;
ADDRLP4 0+8
CNSTF4 3250061312
ASGNF4
line 1619
;1619:	maxs[0] = 15;
ADDRLP4 12
CNSTF4 1097859072
ASGNF4
line 1620
;1620:	maxs[1] = 15;
ADDRLP4 12+4
CNSTF4 1097859072
ASGNF4
line 1621
;1621:	maxs[2] = 8;
ADDRLP4 12+8
CNSTF4 1090519040
ASGNF4
line 1623
;1622:
;1623:	trap_Trace(&tr, bs->origin, mins, maxs, traceto_mod, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 1164
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 1164
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1625
;1624:
;1625:	if (tr.fraction != 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
EQF4 $695
line 1626
;1626:	{
line 1627
;1627:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $684
JUMPV
LABELV $695
line 1630
;1628:	}
;1629:
;1630:	VectorCopy(bs->origin, tracefrom_mod);
ADDRLP4 1140
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 1632
;1631:
;1632:	tracefrom_mod[2] += 31;//33;
ADDRLP4 1140+8
ADDRLP4 1140+8
INDIRF4
CNSTF4 1106771968
ADDF4
ASGNF4
line 1633
;1633:	traceto_mod[2] += 31;//33;
ADDRLP4 36+8
ADDRLP4 36+8
INDIRF4
CNSTF4 1106771968
ADDF4
ASGNF4
line 1635
;1634:
;1635:	mins[0] = -15;
ADDRLP4 0
CNSTF4 3245342720
ASGNF4
line 1636
;1636:	mins[1] = -15;
ADDRLP4 0+4
CNSTF4 3245342720
ASGNF4
line 1637
;1637:	mins[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 1638
;1638:	maxs[0] = 15;
ADDRLP4 12
CNSTF4 1097859072
ASGNF4
line 1639
;1639:	maxs[1] = 15;
ADDRLP4 12+4
CNSTF4 1097859072
ASGNF4
line 1640
;1640:	maxs[2] = 32;
ADDRLP4 12+8
CNSTF4 1107296256
ASGNF4
line 1642
;1641:
;1642:	trap_Trace(&tr, tracefrom_mod, mins, maxs, traceto_mod, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 1644
;1643:
;1644:	if (tr.fraction != 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
EQF4 $704
line 1645
;1645:	{
line 1646
;1646:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $684
JUMPV
LABELV $704
line 1649
;1647:	}
;1648:
;1649:	return 0;
CNSTI4 0
RETI4
LABELV $684
endproc BotTrace_Duck 1168 28
export PassStandardEnemyChecks
proc PassStandardEnemyChecks 56 8
line 1653
;1650:}
;1651:
;1652:int PassStandardEnemyChecks(bot_state_t *bs, gentity_t *en)
;1653:{
line 1654
;1654:	if (!bs || !en)
ADDRLP4 0
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
EQU4 $710
ADDRFP4 4
INDIRP4
CVPU4 4
ADDRLP4 0
INDIRU4
NEU4 $708
LABELV $710
line 1655
;1655:	{
line 1656
;1656:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $708
line 1659
;1657:	}
;1658:
;1659:	if (!en->client)
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $711
line 1660
;1660:	{
line 1661
;1661:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $711
line 1664
;1662:	}
;1663:
;1664:	if (en->health < 1)
ADDRFP4 4
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 1
GEI4 $713
line 1665
;1665:	{
line 1666
;1666:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $713
line 1669
;1667:	}
;1668:
;1669:	if (!en->takedamage)
ADDRFP4 4
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
CNSTI4 0
NEI4 $715
line 1670
;1670:	{
line 1671
;1671:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $715
line 1674
;1672:	}
;1673:
;1674:	if (bs->doingFallback &&
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 4792
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $717
ADDRGP4 gLevelFlags
INDIRI4
CNSTI4 2
BANDI4
ADDRLP4 4
INDIRI4
EQI4 $717
line 1676
;1675:		(gLevelFlags & LEVELFLAG_IGNOREINFALLBACK))
;1676:	{
line 1677
;1677:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $717
line 1680
;1678:	}
;1679:
;1680:	if (en->client)
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $719
line 1681
;1681:	{
line 1682
;1682:		if (en->client->ps.pm_type == PM_INTERMISSION ||
ADDRLP4 8
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 6
EQI4 $723
ADDRLP4 8
INDIRI4
CNSTI4 3
NEI4 $721
LABELV $723
line 1684
;1683:			en->client->ps.pm_type == PM_SPECTATOR)
;1684:		{
line 1685
;1685:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $721
line 1688
;1686:		}
;1687:
;1688:		if (en->client->sess.sessionTeam == TEAM_SPECTATOR)
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 3
NEI4 $724
line 1689
;1689:		{
line 1690
;1690:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $724
line 1693
;1691:		}
;1692:
;1693:		if (!en->client->pers.connected)
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
CNSTI4 0
NEI4 $726
line 1694
;1694:		{
line 1695
;1695:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $726
line 1697
;1696:		}
;1697:	}
LABELV $719
line 1699
;1698:
;1699:	if (!en->s.solid)
ADDRFP4 4
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 0
NEI4 $728
line 1700
;1700:	{
line 1701
;1701:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $728
line 1704
;1702:	}
;1703:
;1704:	if (bs->client == en->s.number)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
NEI4 $730
line 1705
;1705:	{
line 1706
;1706:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $730
line 1709
;1707:	}
;1708:
;1709:	if (OnSameTeam(&g_entities[bs->client], en))
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 8
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $732
line 1710
;1710:	{
line 1711
;1711:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $732
line 1714
;1712:	}
;1713:
;1714:	if (BotMindTricked(bs->client, en->s.number))
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 12
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $734
line 1715
;1715:	{
line 1716
;1716:		if (bs->currentEnemy && bs->currentEnemy->s.number == en->s.number)
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $736
ADDRLP4 16
INDIRP4
INDIRI4
ADDRFP4 4
INDIRP4
INDIRI4
NEI4 $736
line 1717
;1717:		{
line 1719
;1718:			vec3_t vs;
;1719:			float vLen = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 1721
;1720:
;1721:			VectorSubtract(bs->origin, en->client->ps.origin, vs);
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
ASGNP4
ADDRLP4 24
ADDRLP4 36
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 36
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 40
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1722
;1722:			vLen = VectorLength(vs);
ADDRLP4 24
ARGP4
ADDRLP4 44
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 44
INDIRF4
ASGNF4
line 1724
;1723:
;1724:			if (vLen > 256 && (level.time - en->client->dangerTime) > 150)
ADDRLP4 20
INDIRF4
CNSTF4 1132462080
LEF4 $740
ADDRGP4 level+32
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 1748
ADDP4
INDIRI4
SUBI4
CNSTI4 150
LEI4 $740
line 1725
;1725:			{
line 1726
;1726:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $740
line 1728
;1727:			}
;1728:		}
LABELV $736
line 1729
;1729:	}
LABELV $734
line 1731
;1730:
;1731:	if (en->client->ps.duelInProgress && en->client->ps.duelIndex != bs->client)
ADDRLP4 16
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 1292
ADDP4
INDIRI4
CNSTI4 0
EQI4 $743
ADDRLP4 16
INDIRP4
CNSTI4 1284
ADDP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $743
line 1732
;1732:	{
line 1733
;1733:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $743
line 1736
;1734:	}
;1735:
;1736:	if (bs->cur_ps.duelInProgress && en->s.number != bs->cur_ps.duelIndex)
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 1308
ADDP4
INDIRI4
CNSTI4 0
EQI4 $745
ADDRFP4 4
INDIRP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 1300
ADDP4
INDIRI4
EQI4 $745
line 1737
;1737:	{
line 1738
;1738:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $745
line 1741
;1739:	}
;1740:
;1741:	if (g_gametype.integer == GT_JEDIMASTER && !en->client->ps.isJediMaster && !bs->cur_ps.isJediMaster)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $747
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $747
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
NEI4 $747
line 1742
;1742:	{ //rules for attacking non-JM in JM mode
line 1744
;1743:		vec3_t vs;
;1744:		float vLen = 0;
ADDRLP4 40
CNSTF4 0
ASGNF4
line 1746
;1745:
;1746:		if (!g_friendlyFire.integer)
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $750
line 1747
;1747:		{ //can't harm non-JM in JM mode if FF is off
line 1748
;1748:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $750
line 1751
;1749:		}
;1750:
;1751:		VectorSubtract(bs->origin, en->client->ps.origin, vs);
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
ASGNP4
ADDRLP4 28
ADDRLP4 44
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+4
ADDRLP4 44
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 48
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 28+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
line 1752
;1752:		vLen = VectorLength(vs);
ADDRLP4 28
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 40
ADDRLP4 52
INDIRF4
ASGNF4
line 1754
;1753:
;1754:		if (vLen > 350)
ADDRLP4 40
INDIRF4
CNSTF4 1135542272
LEF4 $755
line 1755
;1755:		{
line 1756
;1756:			return 0;
CNSTI4 0
RETI4
ADDRGP4 $707
JUMPV
LABELV $755
line 1758
;1757:		}
;1758:	}
LABELV $747
line 1767
;1759:
;1760:	/*
;1761:	if (en->client && en->client->pers.connected != CON_CONNECTED)
;1762:	{
;1763:		return 0;
;1764:	}
;1765:	*/
;1766:
;1767:	return 1;
CNSTI4 1
RETI4
LABELV $707
endproc PassStandardEnemyChecks 56 8
export BotDamageNotification
proc BotDamageNotification 28 8
line 1771
;1768:}
;1769:
;1770:void BotDamageNotification(gclient_t *bot, gentity_t *attacker)
;1771:{
line 1776
;1772:	bot_state_t *bs;
;1773:	bot_state_t *bs_a;
;1774:	int i;
;1775:
;1776:	if (!bot || !attacker || !attacker->client)
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $761
ADDRLP4 16
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $761
ADDRLP4 16
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
NEU4 $758
LABELV $761
line 1777
;1777:	{
line 1778
;1778:		return;
ADDRGP4 $757
JUMPV
LABELV $758
line 1781
;1779:	}
;1780:
;1781:	bs_a = botstates[attacker->s.number];
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1783
;1782:
;1783:	if (bs_a)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $762
line 1784
;1784:	{
line 1785
;1785:		bs_a->lastAttacked = &g_entities[bot->ps.clientNum];
ADDRLP4 4
INDIRP4
CNSTI4 1820
ADDP4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 1786
;1786:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $765
JUMPV
LABELV $764
line 1789
;1787:
;1788:		while (i < MAX_CLIENTS)
;1789:		{
line 1790
;1790:			if (botstates[i] &&
ADDRLP4 24
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $767
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $767
ADDRLP4 24
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CVPU4 4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
NEU4 $767
line 1793
;1791:				i != bs_a->client &&
;1792:				botstates[i]->lastAttacked == &g_entities[bot->ps.clientNum])
;1793:			{
line 1794
;1794:				botstates[i]->lastAttacked = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 1820
ADDP4
CNSTP4 0
ASGNP4
line 1795
;1795:			}
LABELV $767
line 1797
;1796:
;1797:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1798
;1798:		}
LABELV $765
line 1788
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $764
line 1799
;1799:	}
ADDRGP4 $763
JUMPV
LABELV $762
line 1801
;1800:	else //got attacked by a real client, so no one gets rights to lastAttacked
;1801:	{
line 1802
;1802:		i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $770
JUMPV
LABELV $769
line 1805
;1803:
;1804:		while (i < MAX_CLIENTS)
;1805:		{
line 1806
;1806:			if (botstates[i] &&
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $772
ADDRLP4 20
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CVPU4 4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
NEU4 $772
line 1808
;1807:				botstates[i]->lastAttacked == &g_entities[bot->ps.clientNum])
;1808:			{
line 1809
;1809:				botstates[i]->lastAttacked = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 1820
ADDP4
CNSTP4 0
ASGNP4
line 1810
;1810:			}
LABELV $772
line 1812
;1811:
;1812:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1813
;1813:		}
LABELV $770
line 1804
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $769
line 1814
;1814:	}
LABELV $763
line 1816
;1815:
;1816:	bs = botstates[bot->ps.clientNum];
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 1818
;1817:
;1818:	if (!bs)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $774
line 1819
;1819:	{
line 1820
;1820:		return;
ADDRGP4 $757
JUMPV
LABELV $774
line 1823
;1821:	}
;1822:
;1823:	bs->lastHurt = attacker;
ADDRLP4 8
INDIRP4
CNSTI4 1816
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1825
;1824:
;1825:	if (bs->currentEnemy)
ADDRLP4 8
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $776
line 1826
;1826:	{
line 1827
;1827:		return;
ADDRGP4 $757
JUMPV
LABELV $776
line 1830
;1828:	}
;1829:
;1830:	if (!PassStandardEnemyChecks(bs, attacker))
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 20
ADDRGP4 PassStandardEnemyChecks
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $778
line 1831
;1831:	{
line 1832
;1832:		return;
ADDRGP4 $757
JUMPV
LABELV $778
line 1835
;1833:	}
;1834:
;1835:	if (PassLovedOneCheck(bs, attacker))
ADDRLP4 8
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $780
line 1836
;1836:	{
line 1837
;1837:		bs->currentEnemy = attacker;
ADDRLP4 8
INDIRP4
CNSTI4 1804
ADDP4
ADDRFP4 4
INDIRP4
ASGNP4
line 1838
;1838:		bs->enemySeenTime = level.time + ENEMY_FORGET_MS;
ADDRLP4 8
INDIRP4
CNSTI4 1984
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 1839
;1839:	}
LABELV $780
line 1840
;1840:}
LABELV $757
endproc BotDamageNotification 28 8
export BotCanHear
proc BotCanHear 64 8
line 1843
;1841:
;1842:int BotCanHear(bot_state_t *bs, gentity_t *en, float endist)
;1843:{
line 1846
;1844:	float minlen;
;1845:
;1846:	if (!en || !en->client)
ADDRLP4 4
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $786
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $784
LABELV $786
line 1847
;1847:	{
line 1848
;1848:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $783
JUMPV
LABELV $784
line 1851
;1849:	}
;1850:
;1851:	if (en && en->client && en->client->ps.otherSoundTime > level.time)
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $787
ADDRLP4 20
ADDRLP4 12
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $787
ADDRLP4 20
INDIRP4
CNSTI4 1264
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $787
line 1852
;1852:	{
line 1853
;1853:		minlen = en->client->ps.otherSoundLen;
ADDRLP4 0
ADDRFP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 1268
ADDP4
INDIRF4
ASGNF4
line 1854
;1854:		goto checkStep;
ADDRGP4 $790
JUMPV
LABELV $787
line 1857
;1855:	}
;1856:
;1857:	if (en && en->client && en->client->ps.footstepTime > level.time)
ADDRLP4 24
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $791
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $791
ADDRLP4 32
INDIRP4
CNSTI4 1260
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $791
line 1858
;1858:	{
line 1859
;1859:		minlen = 256;
ADDRLP4 0
CNSTF4 1132462080
ASGNF4
line 1860
;1860:		goto checkStep;
ADDRGP4 $790
JUMPV
LABELV $791
line 1863
;1861:	}
;1862:
;1863:	if (gBotEventTracker[en->s.number].eventTime < level.time)
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker+12
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $794
line 1864
;1864:	{
line 1865
;1865:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $783
JUMPV
LABELV $794
line 1868
;1866:	}
;1867:
;1868:	switch(gBotEventTracker[en->s.number].events[gBotEventTracker[en->s.number].eventSequence & (MAX_PS_EVENTS-1)])
ADDRLP4 40
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 4
LSHI4
ASGNI4
ADDRLP4 36
ADDRLP4 40
INDIRI4
ADDRGP4 gBotEventTracker
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRI4
ADDRGP4 gBotEventTracker+4
ADDP4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 24
EQI4 $803
ADDRLP4 36
INDIRI4
CNSTI4 25
EQI4 $803
ADDRLP4 48
CNSTI4 26
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 48
INDIRI4
EQI4 $803
ADDRLP4 36
INDIRI4
ADDRLP4 48
INDIRI4
GTI4 $807
LABELV $806
ADDRLP4 56
CNSTI4 2
ASGNI4
ADDRLP4 36
INDIRI4
ADDRLP4 56
INDIRI4
LTI4 $798
ADDRLP4 36
INDIRI4
CNSTI4 15
GTI4 $798
ADDRLP4 36
INDIRI4
ADDRLP4 56
INDIRI4
LSHI4
ADDRGP4 $808-8
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $808
address $804
address $804
address $798
address $804
address $798
address $804
address $804
address $804
address $804
address $798
address $798
address $798
address $805
address $805
code
LABELV $807
ADDRLP4 36
INDIRI4
CNSTI4 67
EQI4 $802
ADDRGP4 $798
JUMPV
line 1869
;1869:	{
LABELV $802
line 1871
;1870:	case EV_GLOBAL_SOUND:
;1871:		minlen = 256;
ADDRLP4 0
CNSTF4 1132462080
ASGNF4
line 1872
;1872:		break;
ADDRGP4 $799
JUMPV
LABELV $803
line 1876
;1873:	case EV_FIRE_WEAPON:
;1874:	case EV_ALT_FIRE:
;1875:	case EV_SABER_ATTACK:
;1876:		minlen = 512;
ADDRLP4 0
CNSTF4 1140850688
ASGNF4
line 1877
;1877:		break;
ADDRGP4 $799
JUMPV
LABELV $804
line 1885
;1878:	case EV_STEP_4:
;1879:	case EV_STEP_8:
;1880:	case EV_STEP_12:
;1881:	case EV_STEP_16:
;1882:	case EV_FOOTSTEP:
;1883:	case EV_FOOTSTEP_METAL:
;1884:	case EV_FOOTWADE:
;1885:		minlen = 256;
ADDRLP4 0
CNSTF4 1132462080
ASGNF4
line 1886
;1886:		break;
ADDRGP4 $799
JUMPV
LABELV $805
line 1889
;1887:	case EV_JUMP:
;1888:	case EV_ROLL:
;1889:		minlen = 256;
ADDRLP4 0
CNSTF4 1132462080
ASGNF4
line 1890
;1890:		break;
ADDRGP4 $799
JUMPV
LABELV $798
line 1892
;1891:	default:
;1892:		minlen = 999999;
ADDRLP4 0
CNSTF4 1232348144
ASGNF4
line 1893
;1893:		break;
LABELV $799
LABELV $790
line 1896
;1894:	}
;1895:checkStep:
;1896:	if (BotMindTricked(bs->client, en->s.number))
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $810
line 1897
;1897:	{ //if mindtricked by this person, cut down on the minlen
line 1898
;1898:		minlen /= 4;
ADDRLP4 0
ADDRLP4 0
INDIRF4
CNSTF4 1082130432
DIVF4
ASGNF4
line 1899
;1899:	}
LABELV $810
line 1901
;1900:
;1901:	if (endist <= minlen)
ADDRFP4 8
INDIRF4
ADDRLP4 0
INDIRF4
GTF4 $812
line 1902
;1902:	{
line 1903
;1903:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $783
JUMPV
LABELV $812
line 1906
;1904:	}
;1905:
;1906:	return 0;
CNSTI4 0
RETI4
LABELV $783
endproc BotCanHear 64 8
export UpdateEventTracker
proc UpdateEventTracker 20 0
line 1910
;1907:}
;1908:
;1909:void UpdateEventTracker(void)
;1910:{
line 1913
;1911:	int i;
;1912:
;1913:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $816
JUMPV
LABELV $815
line 1916
;1914:
;1915:	while (i < MAX_CLIENTS)
;1916:	{
line 1917
;1917:		if (gBotEventTracker[i].eventSequence != level.clients[i].ps.eventSequence)
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker
ADDP4
INDIRI4
CNSTI4 1756
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 112
ADDP4
INDIRI4
EQI4 $818
line 1918
;1918:		{ //updated event
line 1919
;1919:			gBotEventTracker[i].eventSequence = level.clients[i].ps.eventSequence;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker
ADDP4
CNSTI4 1756
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 112
ADDP4
INDIRI4
ASGNI4
line 1920
;1920:			gBotEventTracker[i].events[0] = level.clients[i].ps.events[0];
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker+4
ADDP4
CNSTI4 1756
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 116
ADDP4
INDIRI4
ASGNI4
line 1921
;1921:			gBotEventTracker[i].events[1] = level.clients[i].ps.events[1];
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker+4+4
ADDP4
CNSTI4 1756
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 120
ADDP4
INDIRI4
ASGNI4
line 1922
;1922:			gBotEventTracker[i].eventTime = level.time + 0.5;
ADDRLP4 0
INDIRI4
CNSTI4 4
LSHI4
ADDRGP4 gBotEventTracker+12
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
CNSTF4 1056964608
ADDF4
ASGNF4
line 1923
;1923:		}
LABELV $818
line 1925
;1924:
;1925:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1926
;1926:	}
LABELV $816
line 1915
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $815
line 1927
;1927:}
LABELV $814
endproc UpdateEventTracker 20 0
export InFieldOfVision
proc InFieldOfVision 24 4
line 1930
;1928:
;1929:int InFieldOfVision(vec3_t viewangles, float fov, vec3_t angles)
;1930:{
line 1934
;1931:	int i;
;1932:	float diff, angle;
;1933:
;1934:	for (i = 0; i < 2; i++)
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $826
line 1935
;1935:	{
line 1936
;1936:		angle = AngleMod(viewangles[i]);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
ADDP4
INDIRF4
ARGF4
ADDRLP4 12
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 12
INDIRF4
ASGNF4
line 1937
;1937:		angles[i] = AngleMod(angles[i]);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
INDIRF4
ARGF4
ADDRLP4 20
ADDRGP4 AngleMod
CALLF4
ASGNF4
ADDRLP4 16
INDIRP4
ADDRLP4 20
INDIRF4
ASGNF4
line 1938
;1938:		diff = angles[i] - angle;
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
SUBF4
ASGNF4
line 1939
;1939:		if (angles[i] > angle)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 8
INDIRP4
ADDP4
INDIRF4
ADDRLP4 8
INDIRF4
LEF4 $830
line 1940
;1940:		{
line 1941
;1941:			if (diff > 180.0)
ADDRLP4 4
INDIRF4
CNSTF4 1127481344
LEF4 $831
line 1942
;1942:			{
line 1943
;1943:				diff -= 360.0;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 1944
;1944:			}
line 1945
;1945:		}
ADDRGP4 $831
JUMPV
LABELV $830
line 1947
;1946:		else
;1947:		{
line 1948
;1948:			if (diff < -180.0)
ADDRLP4 4
INDIRF4
CNSTF4 3274964992
GEF4 $834
line 1949
;1949:			{
line 1950
;1950:				diff += 360.0;
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 1951
;1951:			}
LABELV $834
line 1952
;1952:		}
LABELV $831
line 1953
;1953:		if (diff > 0)
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $836
line 1954
;1954:		{
line 1955
;1955:			if (diff > fov * 0.5)
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
MULF4
LEF4 $837
line 1956
;1956:			{
line 1957
;1957:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $825
JUMPV
line 1959
;1958:			}
;1959:		}
LABELV $836
line 1961
;1960:		else
;1961:		{
line 1962
;1962:			if (diff < -fov * 0.5)
ADDRLP4 4
INDIRF4
CNSTF4 1056964608
ADDRFP4 4
INDIRF4
NEGF4
MULF4
GEF4 $840
line 1963
;1963:			{
line 1964
;1964:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $825
JUMPV
LABELV $840
line 1966
;1965:			}
;1966:		}
LABELV $837
line 1967
;1967:	}
LABELV $827
line 1934
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LTI4 $826
line 1968
;1968:	return 1;
CNSTI4 1
RETI4
LABELV $825
endproc InFieldOfVision 24 4
export PassLovedOneCheck
proc PassLovedOneCheck 36 8
line 1972
;1969:}
;1970:
;1971:int PassLovedOneCheck(bot_state_t *bs, gentity_t *ent)
;1972:{
line 1976
;1973:	int i;
;1974:	bot_state_t *loved;
;1975:
;1976:	if (!bs->lovednum)
ADDRFP4 0
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
CNSTI4 0
NEI4 $843
line 1977
;1977:	{
line 1978
;1978:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $843
line 1981
;1979:	}
;1980:
;1981:	if (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $845
line 1982
;1982:	{ //There is no love in 1-on-1
line 1983
;1983:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $845
line 1986
;1984:	}
;1985:
;1986:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 1988
;1987:
;1988:	if (!botstates[ent->s.number])
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $848
line 1989
;1989:	{ //not a bot
line 1990
;1990:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $848
line 1993
;1991:	}
;1992:
;1993:	trap_Cvar_Update(&bot_attachments);
ADDRGP4 bot_attachments
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 1995
;1994:
;1995:	if (!bot_attachments.integer)
ADDRGP4 bot_attachments+12
INDIRI4
CNSTI4 0
NEI4 $850
line 1996
;1996:	{
line 1997
;1997:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $850
line 2000
;1998:	}
;1999:
;2000:	loved = botstates[ent->s.number];
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRGP4 $854
JUMPV
LABELV $853
line 2003
;2001:
;2002:	while (i < bs->lovednum)
;2003:	{
line 2004
;2004:		if (strcmp(level.clients[loved->client].pers.netname, bs->loved[i].name) == 0)
CNSTI4 1756
ADDRLP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1416
ADDP4
ARGP4
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 8
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
NEI4 $856
line 2005
;2005:		{
line 2006
;2006:			if (!IsTeamplay() && bs->loved[i].level < 2)
ADDRLP4 12
ADDRGP4 IsTeamplay
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $858
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
INDIRI4
CNSTI4 2
GEI4 $858
line 2007
;2007:			{ //if FFA and level of love is not greater than 1, just don't care
line 2008
;2008:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $858
line 2010
;2009:			}
;2010:			else if (IsTeamplay() && !OnSameTeam(&g_entities[bs->client], &g_entities[loved->client]) && bs->loved[i].level < 2)
ADDRLP4 16
ADDRGP4 IsTeamplay
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $860
ADDRLP4 20
CNSTI4 828
ASGNI4
ADDRLP4 24
CNSTI4 8
ASGNI4
ADDRLP4 28
ADDRGP4 g_entities
ASGNP4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRLP4 28
INDIRP4
ADDP4
ARGP4
ADDRLP4 20
INDIRI4
ADDRLP4 4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRLP4 28
INDIRP4
ADDP4
ARGP4
ADDRLP4 32
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $860
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
INDIRI4
CNSTI4 2
GEI4 $860
line 2011
;2011:			{ //is teamplay, but not on same team and level < 2
line 2012
;2012:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $842
JUMPV
LABELV $860
line 2015
;2013:			}
;2014:			else
;2015:			{
line 2016
;2016:				return 0;
CNSTI4 0
RETI4
ADDRGP4 $842
JUMPV
LABELV $856
line 2020
;2017:			}
;2018:		}
;2019:
;2020:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2021
;2021:	}
LABELV $854
line 2002
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
LTI4 $853
line 2023
;2022:
;2023:	return 1;
CNSTI4 1
RETI4
LABELV $842
endproc PassLovedOneCheck 36 8
export ScanForEnemies
proc ScanForEnemies 124 12
line 2029
;2024:}
;2025:
;2026:qboolean G_ThereIsAMaster(void);
;2027:
;2028:int ScanForEnemies(bot_state_t *bs)
;2029:{
line 2035
;2030:	vec3_t a;
;2031:	float distcheck;
;2032:	float closest;
;2033:	int bestindex;
;2034:	int i;
;2035:	float hasEnemyDist = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 2036
;2036:	qboolean noAttackNonJM = qfalse;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 2038
;2037:
;2038:	closest = 999999;
ADDRLP4 20
CNSTF4 1232348144
ASGNF4
line 2039
;2039:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2040
;2040:	bestindex = -1;
ADDRLP4 28
CNSTI4 -1
ASGNI4
line 2042
;2041:
;2042:	if (bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $863
line 2043
;2043:	{
line 2044
;2044:		hasEnemyDist = bs->frame_Enemy_Len;
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ASGNF4
line 2045
;2045:	}
LABELV $863
line 2047
;2046:
;2047:	if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $865
ADDRLP4 44
ADDRLP4 36
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $865
ADDRLP4 44
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 0
EQI4 $865
line 2049
;2048:		bs->currentEnemy->client->ps.isJediMaster)
;2049:	{ //The Jedi Master must die.
line 2050
;2050:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $862
JUMPV
LABELV $865
line 2053
;2051:	}
;2052:
;2053:	if (g_gametype.integer == GT_JEDIMASTER)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $876
line 2054
;2054:	{
line 2055
;2055:		if (G_ThereIsAMaster() && !bs->cur_ps.isJediMaster)
ADDRLP4 48
ADDRGP4 G_ThereIsAMaster
CALLI4
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRLP4 48
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $876
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
NEI4 $876
line 2056
;2056:		{
line 2057
;2057:			if (!g_friendlyFire.integer)
ADDRGP4 g_friendlyFire+12
INDIRI4
CNSTI4 0
NEI4 $872
line 2058
;2058:			{
line 2059
;2059:				noAttackNonJM = qtrue;
ADDRLP4 32
CNSTI4 1
ASGNI4
line 2060
;2060:			}
ADDRGP4 $876
JUMPV
LABELV $872
line 2062
;2061:			else
;2062:			{
line 2063
;2063:				closest = 128; //only get mad at people if they get close enough to you to anger you, or hurt you
ADDRLP4 20
CNSTF4 1124073472
ASGNF4
line 2064
;2064:			}
line 2065
;2065:		}
line 2066
;2066:	}
ADDRGP4 $876
JUMPV
LABELV $875
line 2069
;2067:
;2068:	while (i <= MAX_CLIENTS)
;2069:	{
line 2070
;2070:		if (i != bs->client && g_entities[i].client && !OnSameTeam(&g_entities[bs->client], &g_entities[i]) && PassStandardEnemyChecks(bs, &g_entities[i]) && trap_InPVS(g_entities[i].client->ps.origin, bs->eye) && PassLovedOneCheck(bs, &g_entities[i]))
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 52
INDIRI4
EQI4 $878
ADDRLP4 56
CNSTI4 828
ASGNI4
ADDRLP4 60
ADDRLP4 56
INDIRI4
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 60
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $878
ADDRLP4 64
ADDRGP4 g_entities
ASGNP4
ADDRLP4 56
INDIRI4
ADDRLP4 52
INDIRI4
MULI4
ADDRLP4 64
INDIRP4
ADDP4
ARGP4
ADDRLP4 60
INDIRI4
ADDRLP4 64
INDIRP4
ADDP4
ARGP4
ADDRLP4 68
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $878
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 72
ADDRGP4 PassStandardEnemyChecks
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $878
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1732
ADDP4
ARGP4
ADDRLP4 76
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $878
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 80
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $878
line 2071
;2071:		{
line 2072
;2072:			VectorSubtract(g_entities[i].client->ps.origin, bs->eye, a);
ADDRLP4 84
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 88
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 84
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2073
;2073:			distcheck = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 92
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 92
INDIRF4
ASGNF4
line 2074
;2074:			vectoangles(a, a);
ADDRLP4 4
ARGP4
ADDRLP4 4
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 2076
;2075:
;2076:			if (g_entities[i].client->ps.isJediMaster)
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 0
EQI4 $887
line 2077
;2077:			{ //make us think the Jedi Master is close so we'll attack him above all
line 2078
;2078:				distcheck = 1;
ADDRLP4 16
CNSTF4 1065353216
ASGNF4
line 2079
;2079:			}
LABELV $887
line 2081
;2080:
;2081:			if (distcheck < closest && ((InFieldOfVision(bs->viewangles, 90, a) && !BotMindTricked(bs->client, i)) || BotCanHear(bs, &g_entities[i], distcheck)) && OrgVisible(bs->eye, g_entities[i].client->ps.origin, -1))
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
GEF4 $890
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1119092736
ARGF4
ADDRLP4 4
ARGP4
ADDRLP4 96
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 0
EQI4 $894
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $893
LABELV $894
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 16
INDIRF4
ARGF4
ADDRLP4 104
ADDRGP4 BotCanHear
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $890
LABELV $893
ADDRFP4 0
INDIRP4
CNSTI4 1732
ADDP4
ARGP4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 108
ADDRGP4 OrgVisible
CALLI4
ASGNI4
ADDRLP4 108
INDIRI4
CNSTI4 0
EQI4 $890
line 2082
;2082:			{
line 2083
;2083:				if (BotMindTricked(bs->client, i))
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 112
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
EQI4 $895
line 2084
;2084:				{
line 2085
;2085:					if (distcheck < 256 || (level.time - g_entities[i].client->dangerTime) < 100)
ADDRLP4 16
INDIRF4
CNSTF4 1132462080
LTF4 $901
ADDRGP4 level+32
INDIRI4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1748
ADDP4
INDIRI4
SUBI4
CNSTI4 100
GEI4 $896
LABELV $901
line 2086
;2086:					{
line 2087
;2087:						if (!hasEnemyDist || distcheck < (hasEnemyDist - 128))
ADDRLP4 24
INDIRF4
CNSTF4 0
EQF4 $904
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1124073472
SUBF4
GEF4 $896
LABELV $904
line 2088
;2088:						{ //if we have an enemy, only switch to closer if he is 128+ closer to avoid flipping out
line 2089
;2089:							if (!noAttackNonJM || g_entities[i].client->ps.isJediMaster)
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $908
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $896
LABELV $908
line 2090
;2090:							{
line 2091
;2091:								closest = distcheck;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 2092
;2092:								bestindex = i;
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
line 2093
;2093:							}
line 2094
;2094:						}
line 2095
;2095:					}
line 2096
;2096:				}
ADDRGP4 $896
JUMPV
LABELV $895
line 2098
;2097:				else
;2098:				{
line 2099
;2099:					if (!hasEnemyDist || distcheck < (hasEnemyDist - 128))
ADDRLP4 24
INDIRF4
CNSTF4 0
EQF4 $911
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
CNSTF4 1124073472
SUBF4
GEF4 $909
LABELV $911
line 2100
;2100:					{ //if we have an enemy, only switch to closer if he is 128+ closer to avoid flipping out
line 2101
;2101:						if (!noAttackNonJM || g_entities[i].client->ps.isJediMaster)
ADDRLP4 120
CNSTI4 0
ASGNI4
ADDRLP4 32
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $915
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRLP4 120
INDIRI4
EQI4 $912
LABELV $915
line 2102
;2102:						{
line 2103
;2103:							closest = distcheck;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 2104
;2104:							bestindex = i;
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
line 2105
;2105:						}
LABELV $912
line 2106
;2106:					}
LABELV $909
line 2107
;2107:				}
LABELV $896
line 2108
;2108:			}
LABELV $890
line 2109
;2109:		}
LABELV $878
line 2110
;2110:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2111
;2111:	}
LABELV $876
line 2068
ADDRLP4 0
INDIRI4
CNSTI4 32
LEI4 $875
line 2113
;2112:	
;2113:	return bestindex;
ADDRLP4 28
INDIRI4
RETI4
LABELV $862
endproc ScanForEnemies 124 12
export WaitingForNow
proc WaitingForNow 72 8
line 2117
;2114:}
;2115:
;2116:int WaitingForNow(bot_state_t *bs, vec3_t goalpos)
;2117:{ //checks if the bot is doing something along the lines of waiting for an elevator to raise up
line 2120
;2118:	vec3_t xybot, xywp, a;
;2119:
;2120:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $917
line 2121
;2121:	{
line 2122
;2122:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $917
line 2125
;2123:	}
;2124:
;2125:	if ((int)goalpos[0] != (int)bs->wpCurrent->origin[0] ||
ADDRLP4 36
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 40
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
INDIRF4
CVFI4 4
ADDRLP4 40
INDIRP4
INDIRF4
CVFI4 4
NEI4 $922
ADDRLP4 44
CNSTI4 4
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
CVFI4 4
ADDRLP4 40
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
CVFI4 4
NEI4 $922
ADDRLP4 48
CNSTI4 8
ASGNI4
ADDRLP4 36
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
CVFI4 4
ADDRLP4 40
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRF4
CVFI4 4
EQI4 $919
LABELV $922
line 2128
;2126:		(int)goalpos[1] != (int)bs->wpCurrent->origin[1] ||
;2127:		(int)goalpos[2] != (int)bs->wpCurrent->origin[2])
;2128:	{
line 2129
;2129:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $916
JUMPV
LABELV $919
line 2132
;2130:	}
;2131:
;2132:	VectorCopy(bs->origin, xybot);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 2133
;2133:	VectorCopy(bs->wpCurrent->origin, xywp);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
INDIRB
ASGNB 12
line 2135
;2134:
;2135:	xybot[2] = 0;
ADDRLP4 0+8
CNSTF4 0
ASGNF4
line 2136
;2136:	xywp[2] = 0;
ADDRLP4 12+8
CNSTF4 0
ASGNF4
line 2138
;2137:
;2138:	VectorSubtract(xybot, xywp, a);
ADDRLP4 24
ADDRLP4 0
INDIRF4
ADDRLP4 12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
ADDRLP4 12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
ADDRLP4 12+8
INDIRF4
SUBF4
ASGNF4
line 2140
;2139:
;2140:	if (VectorLength(a) < 16 && bs->frame_Waypoint_Len > 100)
ADDRLP4 24
ARGP4
ADDRLP4 52
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 52
INDIRF4
CNSTF4 1098907648
GEF4 $931
ADDRFP4 0
INDIRP4
CNSTI4 2032
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $931
line 2141
;2141:	{
line 2142
;2142:		if (CheckForFunc(bs->origin, bs->client))
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 56
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 60
ADDRGP4 CheckForFunc
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $932
line 2143
;2143:		{
line 2144
;2144:			return 1; //we're probably standing on an elevator and riding up/down. Or at least we hope so.
CNSTI4 1
RETI4
ADDRGP4 $916
JUMPV
line 2146
;2145:		}
;2146:	}
LABELV $931
line 2147
;2147:	else if (VectorLength(a) < 64 && bs->frame_Waypoint_Len > 64 &&
ADDRLP4 24
ARGP4
ADDRLP4 56
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 60
CNSTF4 1115684864
ASGNF4
ADDRLP4 56
INDIRF4
ADDRLP4 60
INDIRF4
GEF4 $935
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 2032
ADDP4
INDIRF4
ADDRLP4 60
INDIRF4
LEF4 $935
ADDRLP4 64
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 64
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 68
ADDRGP4 CheckForFunc
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $935
line 2149
;2148:		CheckForFunc(bs->origin, bs->client))
;2149:	{
line 2150
;2150:		bs->noUseTime = level.time + 2000;
ADDRFP4 0
INDIRP4
CNSTI4 4788
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 2000
ADDI4
ASGNI4
line 2151
;2151:	}
LABELV $935
LABELV $932
line 2153
;2152:
;2153:	return 0;
CNSTI4 0
RETI4
LABELV $916
endproc WaitingForNow 72 8
export BotGetWeaponRange
proc BotGetWeaponRange 8 0
line 2157
;2154:}
;2155:
;2156:int BotGetWeaponRange(bot_state_t *bs)
;2157:{
line 2158
;2158:	switch (bs->cur_ps.weapon)
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $939
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $939
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $955-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $955
address $942
address $943
address $944
address $945
address $946
address $947
address $948
address $949
address $950
address $951
address $952
address $953
address $954
code
line 2159
;2159:	{
LABELV $942
line 2161
;2160:	case WP_STUN_BATON:
;2161:		return BWEAPONRANGE_MELEE;
CNSTI4 1
RETI4
ADDRGP4 $938
JUMPV
LABELV $943
line 2163
;2162:	case WP_SABER:
;2163:		return BWEAPONRANGE_SABER;
CNSTI4 4
RETI4
ADDRGP4 $938
JUMPV
LABELV $944
line 2165
;2164:	case WP_BRYAR_PISTOL:
;2165:		return BWEAPONRANGE_MID;
CNSTI4 2
RETI4
ADDRGP4 $938
JUMPV
LABELV $945
line 2167
;2166:	case WP_BLASTER:
;2167:		return BWEAPONRANGE_MID;
CNSTI4 2
RETI4
ADDRGP4 $938
JUMPV
LABELV $946
line 2169
;2168:	case WP_DISRUPTOR:
;2169:		return BWEAPONRANGE_MID;
CNSTI4 2
RETI4
ADDRGP4 $938
JUMPV
LABELV $947
line 2171
;2170:	case WP_BOWCASTER:
;2171:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $948
line 2173
;2172:	case WP_REPEATER:
;2173:		return BWEAPONRANGE_MID;
CNSTI4 2
RETI4
ADDRGP4 $938
JUMPV
LABELV $949
line 2175
;2174:	case WP_DEMP2:
;2175:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $950
line 2177
;2176:	case WP_FLECHETTE:
;2177:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $951
line 2179
;2178:	case WP_ROCKET_LAUNCHER:
;2179:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $952
line 2181
;2180:	case WP_THERMAL:
;2181:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $953
line 2183
;2182:	case WP_TRIP_MINE:
;2183:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $954
line 2185
;2184:	case WP_DET_PACK:
;2185:		return BWEAPONRANGE_LONG;
CNSTI4 3
RETI4
ADDRGP4 $938
JUMPV
LABELV $939
line 2187
;2186:	default:
;2187:		return BWEAPONRANGE_MID;
CNSTI4 2
RETI4
LABELV $938
endproc BotGetWeaponRange 8 0
export BotIsAChickenWuss
proc BotIsAChickenWuss 32 4
line 2192
;2188:	}
;2189:}
;2190:
;2191:int BotIsAChickenWuss(bot_state_t *bs)
;2192:{
line 2195
;2193:	int bWRange;
;2194:
;2195:	if (gLevelFlags & LEVELFLAG_IMUSTNTRUNAWAY)
ADDRGP4 gLevelFlags
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $958
line 2196
;2196:	{
line 2197
;2197:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $957
JUMPV
LABELV $958
line 2200
;2198:	}
;2199:
;2200:	if (g_gametype.integer == GT_JEDIMASTER && !bs->cur_ps.isJediMaster)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $960
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
NEI4 $960
line 2201
;2201:	{ //Then you may know no fear.
line 2203
;2202:		//Well, unless he's strong.
;2203:		if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 4
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $963
ADDRLP4 16
ADDRLP4 8
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $963
ADDRLP4 16
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
CNSTI4 0
EQI4 $963
ADDRLP4 8
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 40
LEI4 $963
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 10
GEI4 $963
line 2207
;2204:			bs->currentEnemy->client->ps.isJediMaster &&
;2205:			bs->currentEnemy->health > 40 &&
;2206:			bs->cur_ps.weapon < WP_ROCKET_LAUNCHER)
;2207:		{ //explosive weapons are most effective against the Jedi Master
line 2208
;2208:			goto jmPass;
ADDRGP4 $965
JUMPV
LABELV $963
line 2210
;2209:		}
;2210:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $957
JUMPV
LABELV $960
LABELV $965
line 2213
;2211:	}
;2212:jmPass:
;2213:	if (bs->chickenWussCalculationTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1988
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $966
line 2214
;2214:	{
line 2215
;2215:		return 2; //don't want to keep going between two points...
CNSTI4 2
RETI4
ADDRGP4 $957
JUMPV
LABELV $966
line 2218
;2216:	}
;2217:
;2218:	if (g_gametype.integer == GT_JEDIMASTER && !bs->cur_ps.isJediMaster)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $969
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
NEI4 $969
line 2219
;2219:	{
line 2220
;2220:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $969
line 2223
;2221:	}
;2222:
;2223:	bs->chickenWussCalculationTime = level.time + MAX_CHICKENWUSS_TIME;
ADDRFP4 0
INDIRP4
CNSTI4 1988
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 2225
;2224:
;2225:	if (g_entities[bs->client].health < BOT_RUN_HEALTH)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 40
GEI4 $973
line 2226
;2226:	{
line 2227
;2227:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $973
line 2230
;2228:	}
;2229:
;2230:	bWRange = BotGetWeaponRange(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 4
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
ASGNI4
line 2232
;2231:
;2232:	if (bWRange == BWEAPONRANGE_MELEE || bWRange == BWEAPONRANGE_SABER)
ADDRLP4 0
INDIRI4
CNSTI4 1
EQI4 $978
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $976
LABELV $978
line 2233
;2233:	{
line 2234
;2234:		if (bWRange != BWEAPONRANGE_SABER || !bs->saberSpecialist)
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $981
ADDRFP4 0
INDIRP4
CNSTI4 2076
ADDP4
INDIRI4
CNSTI4 0
NEI4 $979
LABELV $981
line 2235
;2235:		{
line 2236
;2236:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $979
line 2238
;2237:		}
;2238:	}
LABELV $976
line 2240
;2239:
;2240:	if (bs->cur_ps.weapon == WP_BRYAR_PISTOL)
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
NEI4 $982
line 2241
;2241:	{ //the bryar is a weak weapon, so just try to find a new one if it's what you're having to use
line 2242
;2242:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $982
line 2245
;2243:	}
;2244:
;2245:	if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 16
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $984
ADDRLP4 24
ADDRLP4 16
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $984
ADDRLP4 28
CNSTI4 2
ASGNI4
ADDRLP4 24
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
NEI4 $984
ADDRLP4 12
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1140850688
GEF4 $984
ADDRLP4 12
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 28
INDIRI4
EQI4 $984
line 2248
;2246:		bs->currentEnemy->client->ps.weapon == WP_SABER &&
;2247:		bs->frame_Enemy_Len < 512 && bs->cur_ps.weapon != WP_SABER)
;2248:	{ //if close to an enemy with a saber and not using a saber, then try to back off
line 2249
;2249:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $957
JUMPV
LABELV $984
line 2253
;2250:	}
;2251:
;2252:	//didn't run, reset the timer
;2253:	bs->chickenWussCalculationTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1988
ADDP4
CNSTF4 0
ASGNF4
line 2255
;2254:
;2255:	return 0;
CNSTI4 0
RETI4
LABELV $957
endproc BotIsAChickenWuss 32 4
export GetNearestBadThing
proc GetNearestBadThing 1224 28
line 2259
;2256:}
;2257:
;2258:gentity_t *GetNearestBadThing(bot_state_t *bs)
;2259:{
line 2260
;2260:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2263
;2261:	float glen;
;2262:	vec3_t hold;
;2263:	int bestindex = 0;
ADDRLP4 1116
CNSTI4 0
ASGNI4
line 2264
;2264:	float bestdist = 800; //if not within a radius of 800, it's no threat anyway
ADDRLP4 1108
CNSTF4 1145569280
ASGNF4
line 2265
;2265:	int foundindex = 0;
ADDRLP4 1112
CNSTI4 0
ASGNI4
line 2266
;2266:	float factor = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRGP4 $988
JUMPV
LABELV $987
line 2271
;2267:	gentity_t *ent;
;2268:	trace_t tr;
;2269:
;2270:	while (i < MAX_GENTITIES)
;2271:	{
line 2272
;2272:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2274
;2273:
;2274:		if ( (ent &&
ADDRLP4 1124
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1124
INDIRU4
EQU4 $998
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1124
INDIRU4
NEU4 $998
ADDRLP4 1128
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 1128
INDIRI4
EQI4 $998
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ADDRLP4 1128
INDIRI4
EQI4 $998
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 1128
INDIRI4
EQI4 $998
ADDRLP4 0
INDIRP4
CNSTI4 696
ADDP4
INDIRI4
ADDRLP4 1128
INDIRI4
NEI4 $993
LABELV $998
ADDRLP4 1136
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1136
INDIRU4
EQU4 $990
ADDRLP4 0
INDIRP4
CNSTI4 784
ADDP4
INDIRI4
CNSTI4 1000
NEI4 $990
ADDRLP4 1140
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 1140
INDIRI4
EQI4 $990
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ADDRLP4 1140
INDIRI4
LEI4 $990
ADDRLP4 1144
ADDRLP4 0
INDIRP4
CNSTI4 776
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1148
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1144
INDIRI4
ADDRLP4 1148
INDIRI4
EQI4 $990
ADDRLP4 1152
CNSTI4 828
ASGNI4
ADDRLP4 1156
ADDRLP4 1152
INDIRI4
ADDRLP4 1144
INDIRI4
MULI4
ASGNI4
ADDRLP4 1156
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1136
INDIRU4
EQU4 $990
ADDRLP4 1160
ADDRGP4 g_entities
ASGNP4
ADDRLP4 1152
INDIRI4
ADDRLP4 1148
INDIRI4
MULI4
ADDRLP4 1160
INDIRP4
ADDP4
ARGP4
ADDRLP4 1156
INDIRI4
ADDRLP4 1160
INDIRP4
ADDP4
ARGP4
ADDRLP4 1164
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
NEI4 $990
LABELV $993
line 2287
;2275:			!ent->client &&
;2276:			ent->inuse &&
;2277:			ent->damage &&
;2278:			/*(ent->s.weapon == WP_THERMAL || ent->s.weapon == WP_FLECHETTE)*/
;2279:			ent->s.weapon &&
;2280:			ent->splashDamage) ||
;2281:			(ent &&
;2282:			ent->bolt_Head == 1000 &&
;2283:			ent->inuse &&
;2284:			ent->health > 0 &&
;2285:			ent->boltpoint3 != bs->client &&
;2286:			g_entities[ent->boltpoint3].client && !OnSameTeam(&g_entities[bs->client], &g_entities[ent->boltpoint3])) )
;2287:		{ //try to escape from anything with a non-0 s.weapon and non-0 damage. This hopefully only means dangerous projectiles.
line 2289
;2288:		  //Or a sentry gun if bolt_Head == 1000. This is a terrible hack, yes.
;2289:			VectorSubtract(bs->origin, ent->r.currentOrigin, hold);
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1168
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 1168
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2290
;2290:			glen = VectorLength(hold);
ADDRLP4 8
ARGP4
ADDRLP4 1176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 1176
INDIRF4
ASGNF4
line 2292
;2291:
;2292:			if (ent->s.weapon != WP_THERMAL && ent->s.weapon != WP_FLECHETTE &&
ADDRLP4 1180
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 11
EQI4 $1001
ADDRLP4 1180
INDIRI4
CNSTI4 9
EQI4 $1001
ADDRLP4 1180
INDIRI4
CNSTI4 13
EQI4 $1001
ADDRLP4 1180
INDIRI4
CNSTI4 12
EQI4 $1001
line 2294
;2293:				ent->s.weapon != WP_DET_PACK && ent->s.weapon != WP_TRIP_MINE)
;2294:			{
line 2295
;2295:				factor = 0.5;
ADDRLP4 24
CNSTF4 1056964608
ASGNF4
line 2297
;2296:
;2297:				if (ent->s.weapon && glen <= 256 && bs->settings.skill > 2)
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1002
ADDRLP4 20
INDIRF4
CNSTF4 1132462080
GTF4 $1002
ADDRFP4 0
INDIRP4
CNSTI4 1556
ADDP4
INDIRF4
CNSTF4 1073741824
LEF4 $1002
line 2298
;2298:				{ //it's a projectile so push it away
line 2299
;2299:					bs->doForcePush = level.time + 700;
ADDRFP4 0
INDIRP4
CNSTI4 4784
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 700
ADDI4
ASGNI4
line 2301
;2300:					//G_Printf("PUSH PROJECTILE\n");
;2301:				}
line 2302
;2302:			}
ADDRGP4 $1002
JUMPV
LABELV $1001
line 2304
;2303:			else
;2304:			{
line 2305
;2305:				factor = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 2306
;2306:			}
LABELV $1002
line 2308
;2307:
;2308:			if (ent->s.weapon == WP_ROCKET_LAUNCHER &&
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
CNSTI4 10
NEI4 $1006
ADDRLP4 1188
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1192
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1188
INDIRI4
ADDRLP4 1192
INDIRI4
EQI4 $1009
ADDRLP4 1188
INDIRI4
CNSTI4 0
LEI4 $1006
ADDRLP4 1188
INDIRI4
CNSTI4 32
GEI4 $1006
ADDRLP4 1196
CNSTI4 828
ASGNI4
ADDRLP4 1200
ADDRLP4 1196
INDIRI4
ADDRLP4 1188
INDIRI4
MULI4
ASGNI4
ADDRLP4 1200
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1006
ADDRLP4 1204
ADDRGP4 g_entities
ASGNP4
ADDRLP4 1196
INDIRI4
ADDRLP4 1192
INDIRI4
MULI4
ADDRLP4 1204
INDIRP4
ADDP4
ARGP4
ADDRLP4 1200
INDIRI4
ADDRLP4 1204
INDIRP4
ADDP4
ARGP4
ADDRLP4 1208
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 1208
INDIRI4
CNSTI4 0
EQI4 $1006
LABELV $1009
line 2312
;2309:				(ent->r.ownerNum == bs->client ||
;2310:				(ent->r.ownerNum > 0 && ent->r.ownerNum < MAX_CLIENTS &&
;2311:				g_entities[ent->r.ownerNum].client && OnSameTeam(&g_entities[bs->client], &g_entities[ent->r.ownerNum]))) )
;2312:			{ //don't be afraid of your own rockets or your teammates' rockets
line 2313
;2313:				factor = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 2314
;2314:			}
LABELV $1006
line 2316
;2315:
;2316:			if (glen < bestdist*factor && trap_InPVS(bs->origin, ent->s.pos.trBase))
ADDRLP4 20
INDIRF4
ADDRLP4 1108
INDIRF4
ADDRLP4 24
INDIRF4
MULF4
GEF4 $1010
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 1212
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 1212
INDIRI4
CNSTI4 0
EQI4 $1010
line 2317
;2317:			{
line 2318
;2318:				trap_Trace(&tr, bs->origin, NULL, NULL, ent->s.pos.trBase, bs->client, MASK_SOLID);
ADDRLP4 28
ARGP4
ADDRLP4 1216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1216
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1220
CNSTP4 0
ASGNP4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRLP4 1220
INDIRP4
ARGP4
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 1216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2320
;2319:
;2320:				if (tr.fraction == 1 || tr.entityNum == ent->s.number)
ADDRLP4 28+8
INDIRF4
CNSTF4 1065353216
EQF4 $1016
ADDRLP4 28+52
INDIRI4
ADDRLP4 0
INDIRP4
INDIRI4
NEI4 $1012
LABELV $1016
line 2321
;2321:				{
line 2322
;2322:					bestindex = i;
ADDRLP4 1116
ADDRLP4 4
INDIRI4
ASGNI4
line 2323
;2323:					bestdist = glen;
ADDRLP4 1108
ADDRLP4 20
INDIRF4
ASGNF4
line 2324
;2324:					foundindex = 1;
ADDRLP4 1112
CNSTI4 1
ASGNI4
line 2325
;2325:				}
LABELV $1012
line 2326
;2326:			}
LABELV $1010
line 2327
;2327:		}
LABELV $990
line 2329
;2328:
;2329:		if (ent && !ent->client && ent->inuse && ent->damage && ent->s.weapon && ent->r.ownerNum < MAX_CLIENTS && ent->r.ownerNum >= 0)
ADDRLP4 1172
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 1172
INDIRU4
EQU4 $1017
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1172
INDIRU4
NEU4 $1017
ADDRLP4 1176
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 1176
INDIRI4
EQI4 $1017
ADDRLP4 0
INDIRP4
CNSTI4 688
ADDP4
INDIRI4
ADDRLP4 1176
INDIRI4
EQI4 $1017
ADDRLP4 0
INDIRP4
CNSTI4 276
ADDP4
INDIRI4
ADDRLP4 1176
INDIRI4
EQI4 $1017
ADDRLP4 1180
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
ASGNI4
ADDRLP4 1180
INDIRI4
CNSTI4 32
GEI4 $1017
ADDRLP4 1180
INDIRI4
ADDRLP4 1176
INDIRI4
LTI4 $1017
line 2330
;2330:		{ //if we're in danger of a projectile belonging to someone and don't have an enemy, set the enemy to them
line 2331
;2331:			gentity_t *projOwner = &g_entities[ent->r.ownerNum];
ADDRLP4 1184
CNSTI4 828
ADDRLP4 0
INDIRP4
CNSTI4 396
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2333
;2332:
;2333:			if (projOwner && projOwner->inuse && projOwner->client)
ADDRLP4 1192
CNSTU4 0
ASGNU4
ADDRLP4 1184
INDIRP4
CVPU4 4
ADDRLP4 1192
INDIRU4
EQU4 $1019
ADDRLP4 1184
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1019
ADDRLP4 1184
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1192
INDIRU4
EQU4 $1019
line 2334
;2334:			{
line 2335
;2335:				if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1021
line 2336
;2336:				{
line 2337
;2337:					if (PassStandardEnemyChecks(bs, projOwner))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRLP4 1196
ADDRGP4 PassStandardEnemyChecks
CALLI4
ASGNI4
ADDRLP4 1196
INDIRI4
CNSTI4 0
EQI4 $1023
line 2338
;2338:					{
line 2339
;2339:						if (PassLovedOneCheck(bs, projOwner))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRLP4 1200
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 1200
INDIRI4
CNSTI4 0
EQI4 $1025
line 2340
;2340:						{
line 2341
;2341:							VectorSubtract(bs->origin, ent->r.currentOrigin, hold);
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 1204
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 1204
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2342
;2342:							glen = VectorLength(hold);
ADDRLP4 8
ARGP4
ADDRLP4 1212
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 1212
INDIRF4
ASGNF4
line 2344
;2343:
;2344:							if (glen < 512)
ADDRLP4 20
INDIRF4
CNSTF4 1140850688
GEF4 $1029
line 2345
;2345:							{
line 2346
;2346:								bs->currentEnemy = projOwner;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
ADDRLP4 1184
INDIRP4
ASGNP4
line 2347
;2347:								bs->enemySeenTime = level.time + ENEMY_FORGET_MS;
ADDRFP4 0
INDIRP4
CNSTI4 1984
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 2348
;2348:							}
LABELV $1029
line 2349
;2349:						}
LABELV $1025
line 2350
;2350:					}
LABELV $1023
line 2351
;2351:				}
LABELV $1021
line 2352
;2352:			}
LABELV $1019
line 2353
;2353:		}
LABELV $1017
line 2355
;2354:
;2355:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2356
;2356:	}
LABELV $988
line 2270
ADDRLP4 4
INDIRI4
CNSTI4 1024
LTI4 $987
line 2358
;2357:
;2358:	if (foundindex)
ADDRLP4 1112
INDIRI4
CNSTI4 0
EQI4 $1032
line 2359
;2359:	{
line 2360
;2360:		bs->dontGoBack = level.time + 1500;
ADDRFP4 0
INDIRP4
CNSTI4 2260
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
CVIF4 4
ASGNF4
line 2361
;2361:		return &g_entities[bestindex];
CNSTI4 828
ADDRLP4 1116
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
RETP4
ADDRGP4 $986
JUMPV
LABELV $1032
line 2364
;2362:	}
;2363:	else
;2364:	{
line 2365
;2365:		return NULL;
CNSTP4 0
RETP4
LABELV $986
endproc GetNearestBadThing 1224 28
export BotDefendFlag
proc BotDefendFlag 28 4
line 2370
;2366:	}
;2367:}
;2368:
;2369:int BotDefendFlag(bot_state_t *bs)
;2370:{
line 2374
;2371:	wpobject_t *flagPoint;
;2372:	vec3_t a;
;2373:
;2374:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1036
line 2375
;2375:	{
line 2376
;2376:		flagPoint = flagRed;
ADDRLP4 0
ADDRGP4 flagRed
INDIRP4
ASGNP4
line 2377
;2377:	}
ADDRGP4 $1037
JUMPV
LABELV $1036
line 2378
;2378:	else if (level.clients[bs->client].sess.sessionTeam == TEAM_BLUE)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1038
line 2379
;2379:	{
line 2380
;2380:		flagPoint = flagBlue;
ADDRLP4 0
ADDRGP4 flagBlue
INDIRP4
ASGNP4
line 2381
;2381:	}
ADDRGP4 $1039
JUMPV
LABELV $1038
line 2383
;2382:	else
;2383:	{
line 2384
;2384:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1035
JUMPV
LABELV $1039
LABELV $1037
line 2387
;2385:	}
;2386:
;2387:	if (!flagPoint)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1040
line 2388
;2388:	{
line 2389
;2389:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1035
JUMPV
LABELV $1040
line 2392
;2390:	}
;2391:
;2392:	VectorSubtract(bs->origin, flagPoint->origin, a);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2394
;2393:
;2394:	if (VectorLength(a) > BASE_GUARD_DISTANCE)
ADDRLP4 4
ARGP4
ADDRLP4 24
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1132462080
LEF4 $1044
line 2395
;2395:	{
line 2396
;2396:		bs->wpDestination = flagPoint;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2397
;2397:	}
LABELV $1044
line 2399
;2398:
;2399:	return 1;
CNSTI4 1
RETI4
LABELV $1035
endproc BotDefendFlag 28 4
export BotGetEnemyFlag
proc BotGetEnemyFlag 28 4
line 2403
;2400:}
;2401:
;2402:int BotGetEnemyFlag(bot_state_t *bs)
;2403:{
line 2407
;2404:	wpobject_t *flagPoint;
;2405:	vec3_t a;
;2406:
;2407:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1047
line 2408
;2408:	{
line 2409
;2409:		flagPoint = flagBlue;
ADDRLP4 0
ADDRGP4 flagBlue
INDIRP4
ASGNP4
line 2410
;2410:	}
ADDRGP4 $1048
JUMPV
LABELV $1047
line 2411
;2411:	else if (level.clients[bs->client].sess.sessionTeam == TEAM_BLUE)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1049
line 2412
;2412:	{
line 2413
;2413:		flagPoint = flagRed;
ADDRLP4 0
ADDRGP4 flagRed
INDIRP4
ASGNP4
line 2414
;2414:	}
ADDRGP4 $1050
JUMPV
LABELV $1049
line 2416
;2415:	else
;2416:	{
line 2417
;2417:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1046
JUMPV
LABELV $1050
LABELV $1048
line 2420
;2418:	}
;2419:
;2420:	if (!flagPoint)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1051
line 2421
;2421:	{
line 2422
;2422:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1046
JUMPV
LABELV $1051
line 2425
;2423:	}
;2424:
;2425:	VectorSubtract(bs->origin, flagPoint->origin, a);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2427
;2426:
;2427:	if (VectorLength(a) > BASE_GETENEMYFLAG_DISTANCE)
ADDRLP4 4
ARGP4
ADDRLP4 24
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1132462080
LEF4 $1055
line 2428
;2428:	{
line 2429
;2429:		bs->wpDestination = flagPoint;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2430
;2430:	}
LABELV $1055
line 2432
;2431:
;2432:	return 1;
CNSTI4 1
RETI4
LABELV $1046
endproc BotGetEnemyFlag 28 4
export BotGetFlagBack
proc BotGetFlagBack 52 12
line 2436
;2433:}
;2434:
;2435:int BotGetFlagBack(bot_state_t *bs)
;2436:{
line 2437
;2437:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2438
;2438:	int myFlag = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2439
;2439:	int foundCarrier = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2440
;2440:	int tempInt = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2441
;2441:	gentity_t *ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 2444
;2442:	vec3_t usethisvec;
;2443:
;2444:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1058
line 2445
;2445:	{
line 2446
;2446:		myFlag = PW_REDFLAG;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 2447
;2447:	}
ADDRGP4 $1061
JUMPV
LABELV $1058
line 2449
;2448:	else
;2449:	{
line 2450
;2450:		myFlag = PW_BLUEFLAG;
ADDRLP4 8
CNSTI4 5
ASGNI4
line 2451
;2451:	}
ADDRGP4 $1061
JUMPV
LABELV $1060
line 2454
;2452:
;2453:	while (i < MAX_CLIENTS)
;2454:	{
line 2455
;2455:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2457
;2456:
;2457:		if (ent && ent->client && ent->client->ps.powerups[myFlag] && !OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 36
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $1063
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $1063
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1063
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $1063
line 2458
;2458:		{
line 2459
;2459:			foundCarrier = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2460
;2460:			break;
ADDRGP4 $1062
JUMPV
LABELV $1063
line 2463
;2461:		}
;2462:
;2463:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2464
;2464:	}
LABELV $1061
line 2453
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1060
LABELV $1062
line 2466
;2465:
;2466:	if (!foundCarrier)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1065
line 2467
;2467:	{
line 2468
;2468:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1057
JUMPV
LABELV $1065
line 2471
;2469:	}
;2470:
;2471:	if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1067
line 2472
;2472:	{
line 2473
;2473:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1057
JUMPV
LABELV $1067
line 2476
;2474:	}
;2475:
;2476:	if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1069
line 2477
;2477:	{
line 2478
;2478:		if (ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1072
line 2479
;2479:		{
line 2480
;2480:			VectorCopy(ent->client->ps.origin, usethisvec);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2481
;2481:		}
ADDRGP4 $1073
JUMPV
LABELV $1072
line 2483
;2482:		else
;2483:		{
line 2484
;2484:			VectorCopy(ent->s.origin, usethisvec);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 2485
;2485:		}
LABELV $1073
line 2487
;2486:
;2487:		tempInt = GetNearestVisibleWP(usethisvec, 0);
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 2489
;2488:
;2489:		if (tempInt != -1 && TotalTrailDistance(bs->wpCurrent->index, tempInt, bs) != -1)
ADDRLP4 36
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 -1
EQI4 $1074
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 3212836864
EQF4 $1074
line 2490
;2490:		{
line 2491
;2491:			bs->wpDestination = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2492
;2492:			bs->wpDestSwitchTime = level.time + Q_irand(1000, 5000);
CNSTI4 1000
ARGI4
CNSTI4 5000
ARGI4
ADDRLP4 48
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 48
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 2493
;2493:		}
LABELV $1074
line 2494
;2494:	}
LABELV $1069
line 2496
;2495:
;2496:	return 1;
CNSTI4 1
RETI4
LABELV $1057
endproc BotGetFlagBack 52 12
export BotGuardFlagCarrier
proc BotGuardFlagCarrier 52 12
line 2500
;2497:}
;2498:
;2499:int BotGuardFlagCarrier(bot_state_t *bs)
;2500:{
line 2501
;2501:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2502
;2502:	int enemyFlag = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2503
;2503:	int foundCarrier = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2504
;2504:	int tempInt = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2505
;2505:	gentity_t *ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 2508
;2506:	vec3_t usethisvec;
;2507:
;2508:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1078
line 2509
;2509:	{
line 2510
;2510:		enemyFlag = PW_BLUEFLAG;
ADDRLP4 8
CNSTI4 5
ASGNI4
line 2511
;2511:	}
ADDRGP4 $1081
JUMPV
LABELV $1078
line 2513
;2512:	else
;2513:	{
line 2514
;2514:		enemyFlag = PW_REDFLAG;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 2515
;2515:	}
ADDRGP4 $1081
JUMPV
LABELV $1080
line 2518
;2516:
;2517:	while (i < MAX_CLIENTS)
;2518:	{
line 2519
;2519:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2521
;2520:
;2521:		if (ent && ent->client && ent->client->ps.powerups[enemyFlag] && OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 36
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $1083
ADDRLP4 40
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CVPU4 4
ADDRLP4 36
INDIRU4
EQU4 $1083
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 40
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1083
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $1083
line 2522
;2522:		{
line 2523
;2523:			foundCarrier = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 2524
;2524:			break;
ADDRGP4 $1082
JUMPV
LABELV $1083
line 2527
;2525:		}
;2526:
;2527:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2528
;2528:	}
LABELV $1081
line 2517
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1080
LABELV $1082
line 2530
;2529:
;2530:	if (!foundCarrier)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1085
line 2531
;2531:	{
line 2532
;2532:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1077
JUMPV
LABELV $1085
line 2535
;2533:	}
;2534:
;2535:	if (!ent)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1087
line 2536
;2536:	{
line 2537
;2537:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1077
JUMPV
LABELV $1087
line 2540
;2538:	}
;2539:
;2540:	if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1089
line 2541
;2541:	{
line 2542
;2542:		if (ent->client)
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1092
line 2543
;2543:		{
line 2544
;2544:			VectorCopy(ent->client->ps.origin, usethisvec);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 2545
;2545:		}
ADDRGP4 $1093
JUMPV
LABELV $1092
line 2547
;2546:		else
;2547:		{
line 2548
;2548:			VectorCopy(ent->s.origin, usethisvec);
ADDRLP4 20
ADDRLP4 0
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 2549
;2549:		}
LABELV $1093
line 2551
;2550:
;2551:		tempInt = GetNearestVisibleWP(usethisvec, 0);
ADDRLP4 20
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 32
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 32
INDIRI4
ASGNI4
line 2553
;2552:
;2553:		if (tempInt != -1 && TotalTrailDistance(bs->wpCurrent->index, tempInt, bs) != -1)
ADDRLP4 36
ADDRLP4 16
INDIRI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 -1
EQI4 $1094
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 36
INDIRI4
ARGI4
ADDRLP4 40
INDIRP4
ARGP4
ADDRLP4 44
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 44
INDIRF4
CNSTF4 3212836864
EQF4 $1094
line 2554
;2554:		{
line 2555
;2555:			bs->wpDestination = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2556
;2556:			bs->wpDestSwitchTime = level.time + Q_irand(1000, 5000);
CNSTI4 1000
ARGI4
CNSTI4 5000
ARGI4
ADDRLP4 48
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 48
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 2557
;2557:		}
LABELV $1094
line 2558
;2558:	}
LABELV $1089
line 2560
;2559:
;2560:	return 1;
CNSTI4 1
RETI4
LABELV $1077
endproc BotGuardFlagCarrier 52 12
export BotGetFlagHome
proc BotGetFlagHome 28 4
line 2564
;2561:}
;2562:
;2563:int BotGetFlagHome(bot_state_t *bs)
;2564:{
line 2568
;2565:	wpobject_t *flagPoint;
;2566:	vec3_t a;
;2567:
;2568:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1098
line 2569
;2569:	{
line 2570
;2570:		flagPoint = flagRed;
ADDRLP4 0
ADDRGP4 flagRed
INDIRP4
ASGNP4
line 2571
;2571:	}
ADDRGP4 $1099
JUMPV
LABELV $1098
line 2572
;2572:	else if (level.clients[bs->client].sess.sessionTeam == TEAM_BLUE)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1100
line 2573
;2573:	{
line 2574
;2574:		flagPoint = flagBlue;
ADDRLP4 0
ADDRGP4 flagBlue
INDIRP4
ASGNP4
line 2575
;2575:	}
ADDRGP4 $1101
JUMPV
LABELV $1100
line 2577
;2576:	else
;2577:	{
line 2578
;2578:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1097
JUMPV
LABELV $1101
LABELV $1099
line 2581
;2579:	}
;2580:
;2581:	if (!flagPoint)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1102
line 2582
;2582:	{
line 2583
;2583:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1097
JUMPV
LABELV $1102
line 2586
;2584:	}
;2585:
;2586:	VectorSubtract(bs->origin, flagPoint->origin, a);
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 16
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 16
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2588
;2587:
;2588:	if (VectorLength(a) > BASE_FLAGWAIT_DISTANCE)
ADDRLP4 4
ARGP4
ADDRLP4 24
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1132462080
LEF4 $1106
line 2589
;2589:	{
line 2590
;2590:		bs->wpDestination = flagPoint;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 2591
;2591:	}
LABELV $1106
line 2593
;2592:
;2593:	return 1;
CNSTI4 1
RETI4
LABELV $1097
endproc BotGetFlagHome 28 4
export GetNewFlagPoint
proc GetNewFlagPoint 1164 28
line 2597
;2594:}
;2595:
;2596:void GetNewFlagPoint(wpobject_t *wp, gentity_t *flagEnt, int team)
;2597:{ //get the nearest possible waypoint to the flag since it's not in its original position
line 2598
;2598:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2602
;2599:	vec3_t a, mins, maxs;
;2600:	float bestdist;
;2601:	float testdist;
;2602:	int bestindex = 0;
ADDRLP4 1132
CNSTI4 0
ASGNI4
line 2603
;2603:	int foundindex = 0;
ADDRLP4 1128
CNSTI4 0
ASGNI4
line 2606
;2604:	trace_t tr;
;2605:
;2606:	mins[0] = -15;
ADDRLP4 1104
CNSTF4 3245342720
ASGNF4
line 2607
;2607:	mins[1] = -15;
ADDRLP4 1104+4
CNSTF4 3245342720
ASGNF4
line 2608
;2608:	mins[2] = -5;
ADDRLP4 1104+8
CNSTF4 3231711232
ASGNF4
line 2609
;2609:	maxs[0] = 15;
ADDRLP4 1116
CNSTF4 1097859072
ASGNF4
line 2610
;2610:	maxs[1] = 15;
ADDRLP4 1116+4
CNSTF4 1097859072
ASGNF4
line 2611
;2611:	maxs[2] = 5;
ADDRLP4 1116+8
CNSTF4 1084227584
ASGNF4
line 2613
;2612:
;2613:	VectorSubtract(wp->origin, flagEnt->s.pos.trBase, a);
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 1136
INDIRP4
INDIRF4
ADDRLP4 1140
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 1136
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1140
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2615
;2614:
;2615:	bestdist = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 1144
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 1144
INDIRF4
ASGNF4
line 2617
;2616:
;2617:	if (bestdist <= WP_KEEP_FLAG_DIST)
ADDRLP4 20
INDIRF4
CNSTF4 1124073472
GTF4 $1121
line 2618
;2618:	{
line 2619
;2619:		trap_Trace(&tr, wp->origin, mins, maxs, flagEnt->s.pos.trBase, flagEnt->s.number, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1148
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 1148
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2621
;2620:
;2621:		if (tr.fraction == 1)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $1121
line 2622
;2622:		{ //this point is good
line 2623
;2623:			return;
ADDRGP4 $1108
JUMPV
line 2625
;2624:		}
;2625:	}
LABELV $1120
line 2628
;2626:
;2627:	while (i < gWPNum)
;2628:	{
line 2629
;2629:		VectorSubtract(gWPArray[i]->origin, flagEnt->s.pos.trBase, a);
ADDRLP4 1148
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
ASGNP4
ADDRLP4 1152
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 1148
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 1152
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 1148
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 1152
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2630
;2630:		testdist = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 1156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 1156
INDIRF4
ASGNF4
line 2632
;2631:
;2632:		if (testdist < bestdist)
ADDRLP4 16
INDIRF4
ADDRLP4 20
INDIRF4
GEF4 $1125
line 2633
;2633:		{
line 2634
;2634:			trap_Trace(&tr, gWPArray[i]->origin, mins, maxs, flagEnt->s.pos.trBase, flagEnt->s.number, MASK_SOLID);
ADDRLP4 24
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ARGP4
ADDRLP4 1104
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1160
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 1160
INDIRP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2636
;2635:
;2636:			if (tr.fraction == 1)
ADDRLP4 24+8
INDIRF4
CNSTF4 1065353216
NEF4 $1127
line 2637
;2637:			{
line 2638
;2638:				foundindex = 1;
ADDRLP4 1128
CNSTI4 1
ASGNI4
line 2639
;2639:				bestindex = i;
ADDRLP4 1132
ADDRLP4 0
INDIRI4
ASGNI4
line 2640
;2640:				bestdist = testdist;
ADDRLP4 20
ADDRLP4 16
INDIRF4
ASGNF4
line 2641
;2641:			}
LABELV $1127
line 2642
;2642:		}
LABELV $1125
line 2644
;2643:
;2644:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2645
;2645:	}
LABELV $1121
line 2627
ADDRLP4 0
INDIRI4
ADDRGP4 gWPNum
INDIRI4
LTI4 $1120
line 2647
;2646:
;2647:	if (foundindex)
ADDRLP4 1128
INDIRI4
CNSTI4 0
EQI4 $1130
line 2648
;2648:	{
line 2649
;2649:		if (team == TEAM_RED)
ADDRFP4 8
INDIRI4
CNSTI4 1
NEI4 $1132
line 2650
;2650:		{
line 2651
;2651:			flagRed = gWPArray[bestindex];
ADDRGP4 flagRed
ADDRLP4 1132
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2652
;2652:		}
ADDRGP4 $1133
JUMPV
LABELV $1132
line 2654
;2653:		else
;2654:		{
line 2655
;2655:			flagBlue = gWPArray[bestindex];
ADDRGP4 flagBlue
ADDRLP4 1132
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2656
;2656:		}
LABELV $1133
line 2657
;2657:	}
LABELV $1130
line 2658
;2658:}
LABELV $1108
endproc GetNewFlagPoint 1164 28
export CTFTakesPriority
proc CTFTakesPriority 124 12
line 2661
;2659:
;2660:int CTFTakesPriority(bot_state_t *bs)
;2661:{
line 2662
;2662:	gentity_t *ent = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 2663
;2663:	int enemyFlag = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 2664
;2664:	int myFlag = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 2665
;2665:	int enemyHasOurFlag = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 2666
;2666:	int weHaveEnemyFlag = 0;
ADDRLP4 24
CNSTI4 0
ASGNI4
line 2667
;2667:	int numOnMyTeam = 0;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 2668
;2668:	int numOnEnemyTeam = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 2669
;2669:	int numAttackers = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 2670
;2670:	int numDefenders = 0;
ADDRLP4 36
CNSTI4 0
ASGNI4
line 2671
;2671:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 2673
;2672:	int idleWP;
;2673:	int dosw = 0;
ADDRLP4 40
CNSTI4 0
ASGNI4
line 2674
;2674:	wpobject_t *dest_sw = NULL;
ADDRLP4 48
CNSTP4 0
ASGNP4
line 2681
;2675:#ifdef BOT_CTF_DEBUG
;2676:	vec3_t t;
;2677:
;2678:	G_Printf("CTFSTATE: %s\n", ctfStateNames[bs->ctfState]);
;2679:#endif
;2680:
;2681:	if (g_gametype.integer != GT_CTF && g_gametype.integer != GT_CTY)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $1135
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
EQI4 $1135
line 2682
;2682:	{
line 2683
;2683:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1134
JUMPV
LABELV $1135
line 2686
;2684:	}
;2685:
;2686:	if (bs->cur_ps.weapon == WP_BRYAR_PISTOL &&
ADDRLP4 52
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1139
ADDRGP4 level+32
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 1868
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
GEI4 $1139
line 2688
;2687:		(level.time - bs->lastDeadTime) < BOT_MAX_WEAPON_GATHER_TIME)
;2688:	{ //get the nearest weapon laying around base before heading off for battle
line 2689
;2689:		idleWP = GetBestIdleGoal(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 GetBestIdleGoal
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 56
INDIRI4
ASGNI4
line 2691
;2690:
;2691:		if (idleWP != -1 && gWPArray[idleWP] && gWPArray[idleWP]->inuse)
ADDRLP4 60
ADDRLP4 44
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 -1
EQI4 $1140
ADDRLP4 64
ADDRLP4 60
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1140
ADDRLP4 64
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1140
line 2692
;2692:		{
line 2693
;2693:			if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1144
line 2694
;2694:			{
line 2695
;2695:				bs->wpDestination = gWPArray[idleWP];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 44
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2696
;2696:			}
LABELV $1144
line 2697
;2697:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1134
JUMPV
line 2699
;2698:		}
;2699:	}
LABELV $1139
line 2700
;2700:	else if (bs->cur_ps.weapon == WP_BRYAR_PISTOL &&
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 56
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1147
ADDRGP4 level+32
INDIRI4
ADDRLP4 56
INDIRP4
CNSTI4 1868
ADDP4
INDIRI4
SUBI4
CNSTI4 5000
GEI4 $1147
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
ADDRLP4 60
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1147
ADDRLP4 60
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1147
line 2703
;2701:		(level.time - bs->lastDeadTime) < BOT_MAX_WEAPON_CHASE_CTF &&
;2702:		bs->wpDestination && bs->wpDestination->weight)
;2703:	{
line 2704
;2704:		dest_sw = bs->wpDestination;
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
line 2705
;2705:		dosw = 1;
ADDRLP4 40
CNSTI4 1
ASGNI4
line 2706
;2706:	}
LABELV $1147
LABELV $1140
line 2708
;2707:
;2708:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1150
line 2709
;2709:	{
line 2710
;2710:		myFlag = PW_REDFLAG;
ADDRLP4 16
CNSTI4 4
ASGNI4
line 2711
;2711:	}
ADDRGP4 $1151
JUMPV
LABELV $1150
line 2713
;2712:	else
;2713:	{
line 2714
;2714:		myFlag = PW_BLUEFLAG;
ADDRLP4 16
CNSTI4 5
ASGNI4
line 2715
;2715:	}
LABELV $1151
line 2717
;2716:
;2717:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1152
line 2718
;2718:	{
line 2719
;2719:		enemyFlag = PW_BLUEFLAG;
ADDRLP4 8
CNSTI4 5
ASGNI4
line 2720
;2720:	}
ADDRGP4 $1153
JUMPV
LABELV $1152
line 2722
;2721:	else
;2722:	{
line 2723
;2723:		enemyFlag = PW_REDFLAG;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 2724
;2724:	}
LABELV $1153
line 2726
;2725:
;2726:	if (!flagRed || !flagBlue ||
ADDRLP4 64
ADDRGP4 flagRed
INDIRP4
ASGNP4
ADDRLP4 68
CNSTU4 0
ASGNU4
ADDRLP4 64
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
EQU4 $1160
ADDRLP4 72
ADDRGP4 flagBlue
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
EQU4 $1160
ADDRLP4 76
CNSTI4 12
ASGNI4
ADDRLP4 80
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $1160
ADDRLP4 72
INDIRP4
ADDRLP4 76
INDIRI4
ADDP4
INDIRI4
ADDRLP4 80
INDIRI4
EQI4 $1160
ADDRGP4 eFlagRed
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
EQU4 $1160
ADDRGP4 eFlagBlue
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
NEU4 $1154
LABELV $1160
line 2729
;2727:		!flagRed->inuse || !flagBlue->inuse ||
;2728:		!eFlagRed || !eFlagBlue)
;2729:	{
line 2730
;2730:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1134
JUMPV
LABELV $1154
line 2743
;2731:	}
;2732:
;2733:#ifdef BOT_CTF_DEBUG
;2734:	VectorCopy(flagRed->origin, t);
;2735:	t[2] += 128;
;2736:	G_TestLine(flagRed->origin, t, 0x0000ff, 500);
;2737:
;2738:	VectorCopy(flagBlue->origin, t);
;2739:	t[2] += 128;
;2740:	G_TestLine(flagBlue->origin, t, 0x0000ff, 500);
;2741:#endif
;2742:
;2743:	if (droppedRedFlag && (droppedRedFlag->flags & FL_DROPPED_ITEM))
ADDRLP4 84
ADDRGP4 droppedRedFlag
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1161
ADDRLP4 84
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1161
line 2744
;2744:	{
line 2745
;2745:		GetNewFlagPoint(flagRed, droppedRedFlag, TEAM_RED);
ADDRGP4 flagRed
INDIRP4
ARGP4
ADDRGP4 droppedRedFlag
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 GetNewFlagPoint
CALLV
pop
line 2746
;2746:	}
ADDRGP4 $1162
JUMPV
LABELV $1161
line 2748
;2747:	else
;2748:	{
line 2749
;2749:		flagRed = oFlagRed;
ADDRGP4 flagRed
ADDRGP4 oFlagRed
INDIRP4
ASGNP4
line 2750
;2750:	}
LABELV $1162
line 2752
;2751:
;2752:	if (droppedBlueFlag && (droppedBlueFlag->flags & FL_DROPPED_ITEM))
ADDRLP4 88
ADDRGP4 droppedBlueFlag
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1163
ADDRLP4 88
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $1163
line 2753
;2753:	{
line 2754
;2754:		GetNewFlagPoint(flagBlue, droppedBlueFlag, TEAM_BLUE);
ADDRGP4 flagBlue
INDIRP4
ARGP4
ADDRGP4 droppedBlueFlag
INDIRP4
ARGP4
CNSTI4 2
ARGI4
ADDRGP4 GetNewFlagPoint
CALLV
pop
line 2755
;2755:	}
ADDRGP4 $1164
JUMPV
LABELV $1163
line 2757
;2756:	else
;2757:	{
line 2758
;2758:		flagBlue = oFlagBlue;
ADDRGP4 flagBlue
ADDRGP4 oFlagBlue
INDIRP4
ASGNP4
line 2759
;2759:	}
LABELV $1164
line 2761
;2760:
;2761:	if (!bs->ctfState)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1165
line 2762
;2762:	{
line 2763
;2763:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1134
JUMPV
LABELV $1165
line 2766
;2764:	}
;2765:
;2766:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1168
JUMPV
LABELV $1167
line 2769
;2767:
;2768:	while (i < MAX_CLIENTS)
;2769:	{
line 2770
;2770:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2772
;2771:
;2772:		if (ent && ent->client)
ADDRLP4 96
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 96
INDIRU4
EQU4 $1170
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 96
INDIRU4
EQU4 $1170
line 2773
;2773:		{
line 2774
;2774:			if (ent->client->ps.powerups[enemyFlag] && OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1172
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 104
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $1172
line 2775
;2775:			{
line 2776
;2776:				weHaveEnemyFlag = 1;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 2777
;2777:			}
ADDRGP4 $1173
JUMPV
LABELV $1172
line 2778
;2778:			else if (ent->client->ps.powerups[myFlag] && !OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1174
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 112
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 112
INDIRI4
CNSTI4 0
NEI4 $1174
line 2779
;2779:			{
line 2780
;2780:				enemyHasOurFlag = 1;
ADDRLP4 32
CNSTI4 1
ASGNI4
line 2781
;2781:			}
LABELV $1174
LABELV $1173
line 2783
;2782:
;2783:			if (OnSameTeam(&g_entities[bs->client], ent))
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 0
EQI4 $1176
line 2784
;2784:			{
line 2785
;2785:				numOnMyTeam++;
ADDRLP4 20
ADDRLP4 20
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2786
;2786:			}
ADDRGP4 $1177
JUMPV
LABELV $1176
line 2788
;2787:			else
;2788:			{
line 2789
;2789:				numOnEnemyTeam++;
ADDRLP4 28
ADDRLP4 28
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2790
;2790:			}
LABELV $1177
line 2792
;2791:
;2792:			if (botstates[ent->s.number])
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1178
line 2793
;2793:			{
line 2794
;2794:				if (botstates[ent->s.number]->ctfState == CTFSTATE_ATTACKER ||
ADDRLP4 120
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 1
EQI4 $1182
ADDRLP4 120
INDIRI4
CNSTI4 3
NEI4 $1180
LABELV $1182
line 2796
;2795:					botstates[ent->s.number]->ctfState == CTFSTATE_RETRIEVAL)
;2796:				{
line 2797
;2797:					numAttackers++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2798
;2798:				}
ADDRGP4 $1179
JUMPV
LABELV $1180
line 2800
;2799:				else
;2800:				{
line 2801
;2801:					numDefenders++;
ADDRLP4 36
ADDRLP4 36
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2802
;2802:				}
line 2803
;2803:			}
ADDRGP4 $1179
JUMPV
LABELV $1178
line 2805
;2804:			else
;2805:			{ //assume real players to be attackers in our logic
line 2806
;2806:				numAttackers++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2807
;2807:			}
LABELV $1179
line 2808
;2808:		}
LABELV $1170
line 2809
;2809:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2810
;2810:	}
LABELV $1168
line 2768
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1167
line 2812
;2811:
;2812:	if (bs->cur_ps.powerups[enemyFlag])
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 360
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1183
line 2813
;2813:	{
line 2814
;2814:		if ((numOnMyTeam < 2 || !numAttackers) && enemyHasOurFlag)
ADDRLP4 20
INDIRI4
CNSTI4 2
LTI4 $1187
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $1185
LABELV $1187
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $1185
line 2815
;2815:		{
line 2816
;2816:			bs->ctfState = CTFSTATE_RETRIEVAL;
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 3
ASGNI4
line 2817
;2817:		}
ADDRGP4 $1184
JUMPV
LABELV $1185
line 2819
;2818:		else
;2819:		{
line 2820
;2820:			bs->ctfState = CTFSTATE_GETFLAGHOME;
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 5
ASGNI4
line 2821
;2821:		}
line 2822
;2822:	}
ADDRGP4 $1184
JUMPV
LABELV $1183
line 2823
;2823:	else if (bs->ctfState == CTFSTATE_GETFLAGHOME)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1188
line 2824
;2824:	{
line 2825
;2825:		bs->ctfState = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 0
ASGNI4
line 2826
;2826:	}
LABELV $1188
LABELV $1184
line 2828
;2827:
;2828:	if (bs->state_Forced)
ADDRFP4 0
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1190
line 2829
;2829:	{
line 2830
;2830:		bs->ctfState = bs->state_Forced;
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 2676
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
ASGNI4
line 2831
;2831:	}
LABELV $1190
line 2833
;2832:
;2833:	if (bs->ctfState == CTFSTATE_DEFENDER)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1192
line 2834
;2834:	{
line 2835
;2835:		if (BotDefendFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotDefendFlag
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $1194
line 2836
;2836:		{
line 2837
;2837:			goto success;
ADDRGP4 $1196
JUMPV
LABELV $1194
line 2839
;2838:		}
;2839:	}
LABELV $1192
line 2841
;2840:
;2841:	if (bs->ctfState == CTFSTATE_ATTACKER)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1197
line 2842
;2842:	{
line 2843
;2843:		if (BotGetEnemyFlag(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotGetEnemyFlag
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $1199
line 2844
;2844:		{
line 2845
;2845:			goto success;
ADDRGP4 $1196
JUMPV
LABELV $1199
line 2847
;2846:		}
;2847:	}
LABELV $1197
line 2849
;2848:
;2849:	if (bs->ctfState == CTFSTATE_RETRIEVAL)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1201
line 2850
;2850:	{
line 2851
;2851:		if (BotGetFlagBack(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotGetFlagBack
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $1203
line 2852
;2852:		{
line 2853
;2853:			goto success;
ADDRGP4 $1196
JUMPV
LABELV $1203
line 2856
;2854:		}
;2855:		else
;2856:		{ //can't find anyone on another team being a carrier, so ignore this priority
line 2857
;2857:			bs->ctfState = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 0
ASGNI4
line 2858
;2858:		}
line 2859
;2859:	}
LABELV $1201
line 2861
;2860:
;2861:	if (bs->ctfState == CTFSTATE_GUARDCARRIER)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1205
line 2862
;2862:	{
line 2863
;2863:		if (BotGuardFlagCarrier(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotGuardFlagCarrier
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $1207
line 2864
;2864:		{
line 2865
;2865:			goto success;
ADDRGP4 $1196
JUMPV
LABELV $1207
line 2868
;2866:		}
;2867:		else
;2868:		{ //can't find anyone on our team being a carrier, so ignore this priority
line 2869
;2869:			bs->ctfState = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 0
ASGNI4
line 2870
;2870:		}
line 2871
;2871:	}
LABELV $1205
line 2873
;2872:
;2873:	if (bs->ctfState == CTFSTATE_GETFLAGHOME)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1209
line 2874
;2874:	{
line 2875
;2875:		if (BotGetFlagHome(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 92
ADDRGP4 BotGetFlagHome
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $1211
line 2876
;2876:		{
line 2877
;2877:			goto success;
ADDRGP4 $1196
JUMPV
LABELV $1211
line 2879
;2878:		}
;2879:	}
LABELV $1209
line 2881
;2880:
;2881:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $1134
JUMPV
LABELV $1196
line 2884
;2882:
;2883:success:
;2884:	if (dosw)
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $1213
line 2885
;2885:	{ //allow ctf code to run, but if after a particular item then keep going after it
line 2886
;2886:		bs->wpDestination = dest_sw;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 48
INDIRP4
ASGNP4
line 2887
;2887:	}
LABELV $1213
line 2889
;2888:
;2889:	return 1;
CNSTI4 1
RETI4
LABELV $1134
endproc CTFTakesPriority 124 12
export EntityVisibleBox
proc EntityVisibleBox 1084 28
line 2893
;2890:}
;2891:
;2892:int EntityVisibleBox(vec3_t org1, vec3_t mins, vec3_t maxs, vec3_t org2, int ignore, int ignore2)
;2893:{
line 2896
;2894:	trace_t tr;
;2895:
;2896:	trap_Trace(&tr, org1, mins, maxs, org2, ignore, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
ARGP4
ADDRFP4 8
INDIRP4
ARGP4
ADDRFP4 12
INDIRP4
ARGP4
ADDRFP4 16
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 2898
;2897:
;2898:	if (tr.fraction == 1 && !tr.startsolid && !tr.allsolid)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $1216
ADDRLP4 1080
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 1080
INDIRI4
NEI4 $1216
ADDRLP4 0
INDIRI4
ADDRLP4 1080
INDIRI4
NEI4 $1216
line 2899
;2899:	{
line 2900
;2900:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1215
JUMPV
LABELV $1216
line 2902
;2901:	}
;2902:	else if (tr.entityNum != ENTITYNUM_NONE && tr.entityNum == ignore2)
ADDRLP4 0+52
INDIRI4
CNSTI4 1023
EQI4 $1220
ADDRLP4 0+52
INDIRI4
ADDRFP4 20
INDIRI4
NEI4 $1220
line 2903
;2903:	{
line 2904
;2904:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1215
JUMPV
LABELV $1220
line 2907
;2905:	}
;2906:
;2907:	return 0;
CNSTI4 0
RETI4
LABELV $1215
endproc EntityVisibleBox 1084 28
export Saga_TargetClosestObjective
proc Saga_TargetClosestObjective 132 24
line 2911
;2908:}
;2909:
;2910:int Saga_TargetClosestObjective(bot_state_t *bs, int flag)
;2911:{
line 2912
;2912:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 2913
;2913:	int bestindex = -1;
ADDRLP4 28
CNSTI4 -1
ASGNI4
line 2914
;2914:	float testdistance = 0;
ADDRLP4 16
CNSTF4 0
ASGNF4
line 2915
;2915:	float bestdistance = 999999999;
ADDRLP4 24
CNSTF4 1315859240
ASGNF4
line 2920
;2916:	gentity_t *goalent;
;2917:	vec3_t a, dif;
;2918:	vec3_t mins, maxs;
;2919:
;2920:	mins[0] = -1;
ADDRLP4 44
CNSTF4 3212836864
ASGNF4
line 2921
;2921:	mins[1] = -1;
ADDRLP4 44+4
CNSTF4 3212836864
ASGNF4
line 2922
;2922:	mins[2] = -1;
ADDRLP4 44+8
CNSTF4 3212836864
ASGNF4
line 2924
;2923:
;2924:	maxs[0] = 1;
ADDRLP4 56
CNSTF4 1065353216
ASGNF4
line 2925
;2925:	maxs[1] = 1;
ADDRLP4 56+4
CNSTF4 1065353216
ASGNF4
line 2926
;2926:	maxs[2] = 1;
ADDRLP4 56+8
CNSTF4 1065353216
ASGNF4
line 2928
;2927:
;2928:	if ( bs->wpDestination && (bs->wpDestination->flags & flag) && bs->wpDestination->associated_entity != ENTITYNUM_NONE &&
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
ADDRLP4 72
CNSTU4 0
ASGNU4
ADDRLP4 68
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $1234
ADDRLP4 68
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
CNSTI4 0
EQI4 $1234
ADDRLP4 76
ADDRLP4 68
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 1023
EQI4 $1234
ADDRLP4 80
CNSTI4 828
ADDRLP4 76
INDIRI4
MULI4
ASGNI4
ADDRLP4 80
INDIRI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $1234
ADDRLP4 80
INDIRI4
ADDRGP4 g_entities+652
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 72
INDIRU4
EQU4 $1234
line 2930
;2929:		 &g_entities[bs->wpDestination->associated_entity] && g_entities[bs->wpDestination->associated_entity].use )
;2930:	{
line 2931
;2931:		goto hasPoint;
ADDRGP4 $1232
JUMPV
LABELV $1233
line 2935
;2932:	}
;2933:
;2934:	while (i < gWPNum)
;2935:	{
line 2936
;2936:		if ( gWPArray[i] && gWPArray[i]->inuse && (gWPArray[i]->flags & flag) && gWPArray[i]->associated_entity != ENTITYNUM_NONE &&
ADDRLP4 84
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 88
CNSTU4 0
ASGNU4
ADDRLP4 84
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $1236
ADDRLP4 92
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 92
INDIRI4
EQI4 $1236
ADDRLP4 84
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
ADDRFP4 4
INDIRI4
BANDI4
ADDRLP4 92
INDIRI4
EQI4 $1236
ADDRLP4 96
ADDRLP4 84
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
ASGNI4
ADDRLP4 96
INDIRI4
CNSTI4 1023
EQI4 $1236
ADDRLP4 100
CNSTI4 828
ADDRLP4 96
INDIRI4
MULI4
ASGNI4
ADDRLP4 100
INDIRI4
ADDRGP4 g_entities
ADDP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $1236
ADDRLP4 100
INDIRI4
ADDRGP4 g_entities+652
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 88
INDIRU4
EQU4 $1236
line 2938
;2937:			 &g_entities[gWPArray[i]->associated_entity] && g_entities[gWPArray[i]->associated_entity].use )
;2938:		{
line 2939
;2939:			VectorSubtract(gWPArray[i]->origin, bs->origin, a);
ADDRLP4 104
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
ASGNP4
ADDRLP4 108
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 104
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 108
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2940
;2940:			testdistance = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 112
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 112
INDIRF4
ASGNF4
line 2942
;2941:
;2942:			if (testdistance < bestdistance)
ADDRLP4 16
INDIRF4
ADDRLP4 24
INDIRF4
GEF4 $1241
line 2943
;2943:			{
line 2944
;2944:				bestdistance = testdistance;
ADDRLP4 24
ADDRLP4 16
INDIRF4
ASGNF4
line 2945
;2945:				bestindex = i;
ADDRLP4 28
ADDRLP4 0
INDIRI4
ASGNI4
line 2946
;2946:			}
LABELV $1241
line 2947
;2947:		}
LABELV $1236
line 2949
;2948:
;2949:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 2950
;2950:	}
LABELV $1234
line 2934
ADDRLP4 0
INDIRI4
ADDRGP4 gWPNum
INDIRI4
LTI4 $1233
line 2952
;2951:
;2952:	if (bestindex != -1)
ADDRLP4 28
INDIRI4
CNSTI4 -1
EQI4 $1243
line 2953
;2953:	{
line 2954
;2954:		bs->wpDestination = gWPArray[bestindex];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 2955
;2955:	}
ADDRGP4 $1244
JUMPV
LABELV $1243
line 2957
;2956:	else
;2957:	{
line 2958
;2958:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1224
JUMPV
LABELV $1244
LABELV $1232
line 2961
;2959:	}
;2960:hasPoint:
;2961:	goalent = &g_entities[bs->wpDestination->associated_entity];
ADDRLP4 20
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 2963
;2962:
;2963:	if (!goalent)
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1245
line 2964
;2964:	{
line 2965
;2965:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1224
JUMPV
LABELV $1245
line 2968
;2966:	}
;2967:
;2968:	VectorSubtract(bs->origin, bs->wpDestination->origin, a);
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 88
ADDRLP4 84
INDIRP4
CNSTI4 1876
ADDP4
ASGNP4
ADDRLP4 4
ADDRLP4 84
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 4+4
ADDRLP4 84
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 88
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 92
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4+8
ADDRLP4 92
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 2970
;2969:
;2970:	testdistance = VectorLength(a);
ADDRLP4 4
ARGP4
ADDRLP4 96
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 16
ADDRLP4 96
INDIRF4
ASGNF4
line 2972
;2971:
;2972:	dif[0] = (goalent->r.absmax[0]+goalent->r.absmin[0])/2;
ADDRLP4 32
ADDRLP4 20
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2973
;2973:	dif[1] = (goalent->r.absmax[1]+goalent->r.absmin[1])/2;
ADDRLP4 32+4
ADDRLP4 20
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2974
;2974:	dif[2] = (goalent->r.absmax[2]+goalent->r.absmin[2])/2;
ADDRLP4 32+8
ADDRLP4 20
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 20
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 2977
;2975:	//brush models can have tricky origins, so this is our hacky method of getting the center point
;2976:
;2977:	if (goalent->takedamage && testdistance < BOT_MIN_SAGA_GOAL_SHOOT &&
ADDRLP4 20
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1251
ADDRLP4 16
INDIRF4
CNSTF4 1149239296
GEF4 $1251
ADDRLP4 116
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 116
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 44
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 32
ARGP4
ADDRLP4 116
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 20
INDIRP4
INDIRI4
ARGI4
ADDRLP4 120
ADDRGP4 EntityVisibleBox
CALLI4
ASGNI4
ADDRLP4 120
INDIRI4
CNSTI4 0
EQI4 $1251
line 2979
;2978:		EntityVisibleBox(bs->origin, mins, maxs, dif, bs->client, goalent->s.number))
;2979:	{
line 2980
;2980:		bs->shootGoal = goalent;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 2981
;2981:		bs->touchGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1828
ADDP4
CNSTP4 0
ASGNP4
line 2982
;2982:	}
ADDRGP4 $1252
JUMPV
LABELV $1251
line 2983
;2983:	else if (goalent->use && testdistance < BOT_MIN_SAGA_GOAL_TRAVEL)
ADDRLP4 20
INDIRP4
CNSTI4 652
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1253
ADDRLP4 16
INDIRF4
CNSTF4 1124073472
GEF4 $1253
line 2984
;2984:	{
line 2985
;2985:		bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 2986
;2986:		bs->touchGoal = goalent;
ADDRFP4 0
INDIRP4
CNSTI4 1828
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 2987
;2987:	}
ADDRGP4 $1254
JUMPV
LABELV $1253
line 2989
;2988:	else
;2989:	{ //don't know how to handle this goal object!
line 2990
;2990:		bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 2991
;2991:		bs->touchGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1828
ADDP4
CNSTP4 0
ASGNP4
line 2992
;2992:	}
LABELV $1254
LABELV $1252
line 2994
;2993:
;2994:	if (BotGetWeaponRange(bs) == BWEAPONRANGE_MELEE ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 1
EQI4 $1257
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 4
NEI4 $1255
LABELV $1257
line 2996
;2995:		BotGetWeaponRange(bs) == BWEAPONRANGE_SABER)
;2996:	{
line 2997
;2997:		bs->shootGoal = NULL; //too risky
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 2998
;2998:	}
LABELV $1255
line 3000
;2999:
;3000:	if (bs->touchGoal)
ADDRFP4 0
INDIRP4
CNSTI4 1828
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1258
line 3001
;3001:	{
line 3003
;3002:		//G_Printf("Please, master, let me touch it!\n");
;3003:		VectorCopy(dif, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 32
INDIRB
ASGNB 12
line 3004
;3004:	}
LABELV $1258
line 3006
;3005:
;3006:	return 1;
CNSTI4 1
RETI4
LABELV $1224
endproc Saga_TargetClosestObjective 132 24
export Saga_DefendFromAttackers
proc Saga_DefendFromAttackers 68 8
line 3010
;3007:}
;3008:
;3009:void Saga_DefendFromAttackers(bot_state_t *bs)
;3010:{ //this may be a little cheap, but the best way to find our defending point is probably
line 3013
;3011:  //to just find the nearest person on the opposing team since they'll most likely
;3012:  //be on offense in this situation
;3013:	int wpClose = -1;
ADDRLP4 28
CNSTI4 -1
ASGNI4
line 3014
;3014:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3015
;3015:	float testdist = 999999;
ADDRLP4 20
CNSTF4 1232348144
ASGNF4
line 3016
;3016:	int bestindex = -1;
ADDRLP4 32
CNSTI4 -1
ASGNI4
line 3017
;3017:	float bestdist = 999999;
ADDRLP4 24
CNSTF4 1232348144
ASGNF4
ADDRGP4 $1262
JUMPV
LABELV $1261
line 3022
;3018:	gentity_t *ent;
;3019:	vec3_t a;
;3020:
;3021:	while (i < MAX_CLIENTS)
;3022:	{
line 3023
;3023:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3025
;3024:
;3025:		if (ent && ent->client && ent->client->sess.sessionTeam != g_entities[bs->client].client->sess.sessionTeam &&
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1264
ADDRLP4 44
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $1264
ADDRLP4 48
CNSTI4 1520
ASGNI4
ADDRLP4 52
ADDRLP4 44
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRI4
EQI4 $1264
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1264
ADDRLP4 52
INDIRI4
CNSTI4 3
EQI4 $1264
line 3027
;3026:			ent->health > 0 && ent->client->sess.sessionTeam != TEAM_SPECTATOR)
;3027:		{
line 3028
;3028:			VectorSubtract(ent->client->ps.origin, bs->origin, a);
ADDRLP4 56
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
ASGNP4
ADDRLP4 60
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 56
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 56
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 60
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3030
;3029:
;3030:			testdist = VectorLength(a);
ADDRLP4 8
ARGP4
ADDRLP4 64
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 64
INDIRF4
ASGNF4
line 3032
;3031:
;3032:			if (testdist < bestdist)
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
GEF4 $1269
line 3033
;3033:			{
line 3034
;3034:				bestindex = i;
ADDRLP4 32
ADDRLP4 4
INDIRI4
ASGNI4
line 3035
;3035:				bestdist = testdist;
ADDRLP4 24
ADDRLP4 20
INDIRF4
ASGNF4
line 3036
;3036:			}
LABELV $1269
line 3037
;3037:		}
LABELV $1264
line 3039
;3038:
;3039:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3040
;3040:	}
LABELV $1262
line 3021
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1261
line 3042
;3041:
;3042:	if (bestindex == -1)
ADDRLP4 32
INDIRI4
CNSTI4 -1
NEI4 $1271
line 3043
;3043:	{
line 3044
;3044:		return;
ADDRGP4 $1260
JUMPV
LABELV $1271
line 3047
;3045:	}
;3046:
;3047:	wpClose = GetNearestVisibleWP(g_entities[bestindex].client->ps.origin, -1);	
CNSTI4 828
ADDRLP4 32
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 36
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 36
INDIRI4
ASGNI4
line 3049
;3048:
;3049:	if (wpClose != -1 && gWPArray[wpClose] && gWPArray[wpClose]->inuse)
ADDRLP4 28
INDIRI4
CNSTI4 -1
EQI4 $1274
ADDRLP4 44
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1274
ADDRLP4 44
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1274
line 3050
;3050:	{
line 3051
;3051:		bs->wpDestination = gWPArray[wpClose];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 28
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3052
;3052:		bs->destinationGrabTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 3053
;3053:	}
LABELV $1274
line 3054
;3054:}
LABELV $1260
endproc Saga_DefendFromAttackers 68 8
export Saga_CountDefenders
proc Saga_CountDefenders 28 0
line 3057
;3055:
;3056:int Saga_CountDefenders(bot_state_t *bs)
;3057:{
line 3058
;3058:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3059
;3059:	int num = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
ADDRGP4 $1279
JUMPV
LABELV $1278
line 3064
;3060:	gentity_t *ent;
;3061:	bot_state_t *bot;
;3062:
;3063:	while (i < MAX_CLIENTS)
;3064:	{
line 3065
;3065:		ent = &g_entities[i];
ADDRLP4 4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3066
;3066:		bot = botstates[i];
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 3068
;3067:
;3068:		if (ent && ent->client && bot)
ADDRLP4 20
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $1281
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $1281
ADDRLP4 8
INDIRP4
CVPU4 4
ADDRLP4 20
INDIRU4
EQU4 $1281
line 3069
;3069:		{
line 3070
;3070:			if (bot->sagaState == SAGASTATE_DEFENDER &&
ADDRLP4 8
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1283
ADDRLP4 24
CNSTI4 1520
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
INDIRI4
NEI4 $1283
line 3072
;3071:				ent->client->sess.sessionTeam == g_entities[bs->client].client->sess.sessionTeam)
;3072:			{
line 3073
;3073:				num++;
ADDRLP4 12
ADDRLP4 12
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3074
;3074:			}
LABELV $1283
line 3075
;3075:		}
LABELV $1281
line 3077
;3076:
;3077:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3078
;3078:	}
LABELV $1279
line 3063
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $1278
line 3080
;3079:
;3080:	return num;
ADDRLP4 12
INDIRI4
RETI4
LABELV $1277
endproc Saga_CountDefenders 28 0
export Saga_CountTeammates
proc Saga_CountTeammates 24 0
line 3084
;3081:}
;3082:
;3083:int Saga_CountTeammates(bot_state_t *bs)
;3084:{
line 3085
;3085:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3086
;3086:	int num = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1288
JUMPV
LABELV $1287
line 3090
;3087:	gentity_t *ent;
;3088:
;3089:	while (i < MAX_CLIENTS)
;3090:	{
line 3091
;3091:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3093
;3092:
;3093:		if (ent && ent->client)
ADDRLP4 16
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1290
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 16
INDIRU4
EQU4 $1290
line 3094
;3094:		{
line 3095
;3095:			if (ent->client->sess.sessionTeam == g_entities[bs->client].client->sess.sessionTeam)
ADDRLP4 20
CNSTI4 1520
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
ADDRLP4 20
INDIRI4
ADDP4
INDIRI4
NEI4 $1292
line 3096
;3096:			{
line 3097
;3097:				num++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3098
;3098:			}
LABELV $1292
line 3099
;3099:		}
LABELV $1290
line 3101
;3100:
;3101:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3102
;3102:	}
LABELV $1288
line 3089
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1287
line 3104
;3103:
;3104:	return num;
ADDRLP4 8
INDIRI4
RETI4
LABELV $1286
endproc Saga_CountTeammates 24 0
export SagaTakesPriority
proc SagaTakesPriority 1168 28
line 3108
;3105:}
;3106:
;3107:int SagaTakesPriority(bot_state_t *bs)
;3108:{
line 3114
;3109:	int attacker;
;3110:	int flagForDefendableObjective;
;3111:	int flagForAttackableObjective;
;3112:	int defenders, teammates;
;3113:	int idleWP;
;3114:	wpobject_t *dest_sw = NULL;
ADDRLP4 20
CNSTP4 0
ASGNP4
line 3115
;3115:	int dosw = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3120
;3116:	gclient_t *bcl;
;3117:	vec3_t dif;
;3118:	trace_t tr;
;3119:
;3120:	if (g_gametype.integer != GT_SAGA)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
EQI4 $1296
line 3121
;3121:	{
line 3122
;3122:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1295
JUMPV
LABELV $1296
line 3125
;3123:	}
;3124:
;3125:	bcl = g_entities[bs->client].client;
ADDRLP4 0
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
ASGNP4
line 3127
;3126:
;3127:	if (!bcl)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1300
line 3128
;3128:	{
line 3129
;3129:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1295
JUMPV
LABELV $1300
line 3132
;3130:	}
;3131:
;3132:	if (bs->cur_ps.weapon == WP_BRYAR_PISTOL &&
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1302
ADDRGP4 level+32
INDIRI4
ADDRLP4 1128
INDIRP4
CNSTI4 1868
ADDP4
INDIRI4
SUBI4
CNSTI4 1000
GEI4 $1302
line 3134
;3133:		(level.time - bs->lastDeadTime) < BOT_MAX_WEAPON_GATHER_TIME)
;3134:	{ //get the nearest weapon laying around base before heading off for battle
line 3135
;3135:		idleWP = GetBestIdleGoal(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1132
ADDRGP4 GetBestIdleGoal
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 1132
INDIRI4
ASGNI4
line 3137
;3136:
;3137:		if (idleWP != -1 && gWPArray[idleWP] && gWPArray[idleWP]->inuse)
ADDRLP4 1136
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 1136
INDIRI4
CNSTI4 -1
EQI4 $1303
ADDRLP4 1140
ADDRLP4 1136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1303
ADDRLP4 1140
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1303
line 3138
;3138:		{
line 3139
;3139:			if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1307
line 3140
;3140:			{
line 3141
;3141:				bs->wpDestination = gWPArray[idleWP];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3142
;3142:			}
LABELV $1307
line 3143
;3143:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1295
JUMPV
line 3145
;3144:		}
;3145:	}
LABELV $1302
line 3146
;3146:	else if (bs->cur_ps.weapon == WP_BRYAR_PISTOL &&
ADDRLP4 1132
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1310
ADDRGP4 level+32
INDIRI4
ADDRLP4 1132
INDIRP4
CNSTI4 1868
ADDP4
INDIRI4
SUBI4
CNSTI4 15000
GEI4 $1310
ADDRLP4 1136
ADDRLP4 1132
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1310
ADDRLP4 1136
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1310
line 3149
;3147:		(level.time - bs->lastDeadTime) < BOT_MAX_WEAPON_CHASE_TIME &&
;3148:		bs->wpDestination && bs->wpDestination->weight)
;3149:	{
line 3150
;3150:		dest_sw = bs->wpDestination;
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
line 3151
;3151:		dosw = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 3152
;3152:	}
LABELV $1310
LABELV $1303
line 3154
;3153:
;3154:	if (bcl->sess.sessionTeam == SAGATEAM_IMPERIAL)
ADDRLP4 0
INDIRP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1313
line 3155
;3155:	{
line 3156
;3156:		attacker = imperial_attackers;
ADDRLP4 12
ADDRGP4 imperial_attackers
INDIRI4
ASGNI4
line 3157
;3157:		flagForDefendableObjective = WPFLAG_SAGA_REBELOBJ;
ADDRLP4 40
CNSTI4 524288
ASGNI4
line 3158
;3158:		flagForAttackableObjective = WPFLAG_SAGA_IMPERIALOBJ;
ADDRLP4 16
CNSTI4 1048576
ASGNI4
line 3159
;3159:	}
ADDRGP4 $1314
JUMPV
LABELV $1313
line 3161
;3160:	else
;3161:	{
line 3162
;3162:		attacker = rebel_attackers;
ADDRLP4 12
ADDRGP4 rebel_attackers
INDIRI4
ASGNI4
line 3163
;3163:		flagForDefendableObjective = WPFLAG_SAGA_IMPERIALOBJ;
ADDRLP4 40
CNSTI4 1048576
ASGNI4
line 3164
;3164:		flagForAttackableObjective = WPFLAG_SAGA_REBELOBJ;
ADDRLP4 16
CNSTI4 524288
ASGNI4
line 3165
;3165:	}
LABELV $1314
line 3167
;3166:
;3167:	if (attacker)
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $1315
line 3168
;3168:	{
line 3169
;3169:		bs->sagaState = SAGASTATE_ATTACKER;
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
CNSTI4 1
ASGNI4
line 3170
;3170:	}
ADDRGP4 $1316
JUMPV
LABELV $1315
line 3172
;3171:	else
;3172:	{
line 3173
;3173:		bs->sagaState = SAGASTATE_DEFENDER;
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
CNSTI4 2
ASGNI4
line 3174
;3174:		defenders = Saga_CountDefenders(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1140
ADDRGP4 Saga_CountDefenders
CALLI4
ASGNI4
ADDRLP4 44
ADDRLP4 1140
INDIRI4
ASGNI4
line 3175
;3175:		teammates = Saga_CountTeammates(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1144
ADDRGP4 Saga_CountTeammates
CALLI4
ASGNI4
ADDRLP4 36
ADDRLP4 1144
INDIRI4
ASGNI4
line 3177
;3176:
;3177:		if (defenders > teammates/3 && teammates > 1)
ADDRLP4 1148
ADDRLP4 36
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
ADDRLP4 1148
INDIRI4
CNSTI4 3
DIVI4
LEI4 $1317
ADDRLP4 1148
INDIRI4
CNSTI4 1
LEI4 $1317
line 3178
;3178:		{ //devote around 1/4 of our team to completing our own side goals even if we're a defender.
line 3180
;3179:		  //If we have no side goals we will realize that later on and join the defenders
;3180:			bs->sagaState = SAGASTATE_ATTACKER;
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
CNSTI4 1
ASGNI4
line 3181
;3181:		}
LABELV $1317
line 3182
;3182:	}
LABELV $1316
line 3184
;3183:
;3184:	if (bs->state_Forced)
ADDRFP4 0
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1319
line 3185
;3185:	{
line 3186
;3186:		bs->sagaState = bs->state_Forced;
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 2680
ADDP4
ADDRLP4 1140
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
ASGNI4
line 3187
;3187:	}
LABELV $1319
line 3189
;3188:
;3189:	if (bs->sagaState == SAGASTATE_ATTACKER)
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1321
line 3190
;3190:	{
line 3191
;3191:		if (!Saga_TargetClosestObjective(bs, flagForAttackableObjective))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRLP4 1140
ADDRGP4 Saga_TargetClosestObjective
CALLI4
ASGNI4
ADDRLP4 1140
INDIRI4
CNSTI4 0
NEI4 $1322
line 3192
;3192:		{ //looks like we have no goals other than to keep the other team from completing objectives
line 3193
;3193:			Saga_DefendFromAttackers(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Saga_DefendFromAttackers
CALLV
pop
line 3194
;3194:			if (bs->shootGoal)
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1322
line 3195
;3195:			{
line 3196
;3196:				dif[0] = (bs->shootGoal->r.absmax[0]+bs->shootGoal->r.absmin[0])/2;
ADDRLP4 1144
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 1144
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 1144
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3197
;3197:				dif[1] = (bs->shootGoal->r.absmax[1]+bs->shootGoal->r.absmin[1])/2;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 1148
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 1148
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3198
;3198:				dif[2] = (bs->shootGoal->r.absmax[2]+bs->shootGoal->r.absmin[2])/2;
ADDRLP4 1152
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 1152
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 1152
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3200
;3199:				
;3200:				if (!trap_InPVS(bs->origin, dif))
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1156
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
NEI4 $1329
line 3201
;3201:				{
line 3202
;3202:					bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3203
;3203:				}
ADDRGP4 $1322
JUMPV
LABELV $1329
line 3205
;3204:				else
;3205:				{
line 3206
;3206:					trap_Trace(&tr, bs->origin, NULL, NULL, dif, bs->client, MASK_SOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1160
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1164
CNSTP4 0
ASGNP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1160
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3208
;3207:
;3208:					if (tr.fraction != 1 && tr.entityNum != bs->shootGoal->s.number)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
EQF4 $1322
ADDRLP4 48+52
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
INDIRI4
EQI4 $1322
line 3209
;3209:					{
line 3210
;3210:						bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3211
;3211:					}
line 3212
;3212:				}
line 3213
;3213:			}
line 3214
;3214:		}
line 3215
;3215:	}
ADDRGP4 $1322
JUMPV
LABELV $1321
line 3216
;3216:	else if (bs->sagaState == SAGASTATE_DEFENDER)
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1335
line 3217
;3217:	{
line 3218
;3218:		Saga_DefendFromAttackers(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 Saga_DefendFromAttackers
CALLV
pop
line 3219
;3219:		if (bs->shootGoal)
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1336
line 3220
;3220:		{
line 3221
;3221:			dif[0] = (bs->shootGoal->r.absmax[0]+bs->shootGoal->r.absmin[0])/2;
ADDRLP4 1140
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 1140
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 1140
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3222
;3222:			dif[1] = (bs->shootGoal->r.absmax[1]+bs->shootGoal->r.absmin[1])/2;
ADDRLP4 1144
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 1144
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 1144
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3223
;3223:			dif[2] = (bs->shootGoal->r.absmax[2]+bs->shootGoal->r.absmin[2])/2;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 1148
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 1148
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3225
;3224:				
;3225:			if (!trap_InPVS(bs->origin, dif))
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1152
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $1341
line 3226
;3226:			{
line 3227
;3227:				bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3228
;3228:			}
ADDRGP4 $1336
JUMPV
LABELV $1341
line 3230
;3229:			else
;3230:			{
line 3231
;3231:				trap_Trace(&tr, bs->origin, NULL, NULL, dif, bs->client, MASK_SOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1160
CNSTP4 0
ASGNP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1156
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3233
;3232:
;3233:				if (tr.fraction != 1 && tr.entityNum != bs->shootGoal->s.number)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
EQF4 $1336
ADDRLP4 48+52
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
INDIRI4
EQI4 $1336
line 3234
;3234:				{
line 3235
;3235:					bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3236
;3236:				}
line 3237
;3237:			}
line 3238
;3238:		}
line 3239
;3239:	}
ADDRGP4 $1336
JUMPV
LABELV $1335
line 3241
;3240:	else
;3241:	{ //get busy!
line 3242
;3242:		Saga_TargetClosestObjective(bs, flagForAttackableObjective);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 16
INDIRI4
ARGI4
ADDRGP4 Saga_TargetClosestObjective
CALLI4
pop
line 3243
;3243:		if (bs->shootGoal)
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1347
line 3244
;3244:		{
line 3245
;3245:			dif[0] = (bs->shootGoal->r.absmax[0]+bs->shootGoal->r.absmin[0])/2;
ADDRLP4 1140
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 1140
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 1140
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3246
;3246:			dif[1] = (bs->shootGoal->r.absmax[1]+bs->shootGoal->r.absmin[1])/2;
ADDRLP4 1144
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+4
ADDRLP4 1144
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 1144
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3247
;3247:			dif[2] = (bs->shootGoal->r.absmax[2]+bs->shootGoal->r.absmin[2])/2;
ADDRLP4 1148
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 24+8
ADDRLP4 1148
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 1148
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 3249
;3248:				
;3249:			if (!trap_InPVS(bs->origin, dif))
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1152
ADDRGP4 trap_InPVS
CALLI4
ASGNI4
ADDRLP4 1152
INDIRI4
CNSTI4 0
NEI4 $1351
line 3250
;3250:			{
line 3251
;3251:				bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3252
;3252:			}
ADDRGP4 $1352
JUMPV
LABELV $1351
line 3254
;3253:			else
;3254:			{
line 3255
;3255:				trap_Trace(&tr, bs->origin, NULL, NULL, dif, bs->client, MASK_SOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1156
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1156
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1160
CNSTP4 0
ASGNP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 1160
INDIRP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 1156
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 3257
;3256:
;3257:				if (tr.fraction != 1 && tr.entityNum != bs->shootGoal->s.number)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
EQF4 $1353
ADDRLP4 48+52
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
INDIRI4
EQI4 $1353
line 3258
;3258:				{
line 3259
;3259:					bs->shootGoal = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
CNSTP4 0
ASGNP4
line 3260
;3260:				}
LABELV $1353
line 3261
;3261:			}
LABELV $1352
line 3262
;3262:		}
LABELV $1347
line 3263
;3263:	}
LABELV $1336
LABELV $1322
line 3265
;3264:
;3265:	if (dosw)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $1357
line 3266
;3266:	{ //allow saga objective code to run, but if after a particular item then keep going after it
line 3267
;3267:		bs->wpDestination = dest_sw;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 20
INDIRP4
ASGNP4
line 3268
;3268:	}
LABELV $1357
line 3270
;3269:
;3270:	return 1;
CNSTI4 1
RETI4
LABELV $1295
endproc SagaTakesPriority 1168 28
export JMTakesPriority
proc JMTakesPriority 24 8
line 3274
;3271:}
;3272:
;3273:int JMTakesPriority(bot_state_t *bs)
;3274:{
line 3275
;3275:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3276
;3276:	int wpClose = -1;
ADDRLP4 8
CNSTI4 -1
ASGNI4
line 3277
;3277:	gentity_t *theImportantEntity = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 3279
;3278:
;3279:	if (g_gametype.integer != GT_JEDIMASTER)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
EQI4 $1360
line 3280
;3280:	{
line 3281
;3281:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1359
JUMPV
LABELV $1360
line 3284
;3282:	}
;3283:
;3284:	if (bs->cur_ps.isJediMaster)
ADDRFP4 0
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1363
line 3285
;3285:	{
line 3286
;3286:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1359
JUMPV
LABELV $1363
line 3291
;3287:	}
;3288:
;3289:	//jmState becomes the index for the one who carries the saber. If jmState is -1 then the saber is currently
;3290:	//without an owner
;3291:	bs->jmState = -1;
ADDRFP4 0
INDIRP4
CNSTI4 2688
ADDP4
CNSTI4 -1
ASGNI4
ADDRGP4 $1366
JUMPV
LABELV $1365
line 3294
;3292:
;3293:	while (i < MAX_CLIENTS)
;3294:	{
line 3295
;3295:		if (g_entities[i].client && g_entities[i].inuse &&
ADDRLP4 12
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1368
ADDRLP4 16
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 g_entities+412
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1368
ADDRLP4 12
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 604
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $1368
line 3297
;3296:			g_entities[i].client->ps.isJediMaster)
;3297:		{
line 3298
;3298:			bs->jmState = i;
ADDRFP4 0
INDIRP4
CNSTI4 2688
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 3299
;3299:			break;
ADDRGP4 $1367
JUMPV
LABELV $1368
line 3302
;3300:		}
;3301:
;3302:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3303
;3303:	}
LABELV $1366
line 3293
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $1365
LABELV $1367
line 3305
;3304:
;3305:	if (bs->jmState != -1)
ADDRFP4 0
INDIRP4
CNSTI4 2688
ADDP4
INDIRI4
CNSTI4 -1
EQI4 $1373
line 3306
;3306:	{
line 3307
;3307:		theImportantEntity = &g_entities[bs->jmState];
ADDRLP4 4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 2688
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3308
;3308:	}
ADDRGP4 $1374
JUMPV
LABELV $1373
line 3310
;3309:	else
;3310:	{
line 3311
;3311:		theImportantEntity = gJMSaberEnt;
ADDRLP4 4
ADDRGP4 gJMSaberEnt
INDIRP4
ASGNP4
line 3312
;3312:	}
LABELV $1374
line 3314
;3313:
;3314:	if (theImportantEntity && theImportantEntity->inuse && bs->destinationGrabTime < level.time)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1375
ADDRLP4 4
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1375
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1375
line 3315
;3315:	{
line 3316
;3316:		if (theImportantEntity->client)
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1378
line 3317
;3317:		{
line 3318
;3318:			wpClose = GetNearestVisibleWP(theImportantEntity->client->ps.origin, theImportantEntity->s.number);	
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3319
;3319:		}
ADDRGP4 $1379
JUMPV
LABELV $1378
line 3321
;3320:		else
;3321:		{
line 3322
;3322:			wpClose = GetNearestVisibleWP(theImportantEntity->r.currentOrigin, theImportantEntity->s.number);	
ADDRLP4 4
INDIRP4
CNSTI4 368
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 20
INDIRI4
ASGNI4
line 3323
;3323:		}
LABELV $1379
line 3325
;3324:
;3325:		if (wpClose != -1 && gWPArray[wpClose] && gWPArray[wpClose]->inuse)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1380
ADDRLP4 20
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1380
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1380
line 3326
;3326:		{
line 3339
;3327:			/*
;3328:			Com_Printf("BOT GRABBED IDEAL JM LOCATION\n");
;3329:			if (bs->wpDestination != gWPArray[wpClose])
;3330:			{
;3331:				Com_Printf("IDEAL WAS NOT ALREADY IDEAL\n");
;3332:
;3333:				if (!bs->wpDestination)
;3334:				{
;3335:					Com_Printf("IDEAL WAS NULL\n");
;3336:				}
;3337:			}
;3338:			*/
;3339:			bs->wpDestination = gWPArray[wpClose];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3340
;3340:			bs->destinationGrabTime = level.time + 4000;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 4000
ADDI4
CVIF4 4
ASGNF4
line 3341
;3341:		}
LABELV $1380
line 3342
;3342:	}
LABELV $1375
line 3344
;3343:
;3344:	return 1;
CNSTI4 1
RETI4
LABELV $1359
endproc JMTakesPriority 24 8
export BotHasAssociated
proc BotHasAssociated 12 0
line 3348
;3345:}
;3346:
;3347:int BotHasAssociated(bot_state_t *bs, wpobject_t *wp)
;3348:{
line 3351
;3349:	gentity_t *as;
;3350:
;3351:	if (wp->associated_entity == ENTITYNUM_NONE)
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $1384
line 3352
;3352:	{ //make it think this is an item we have so we don't go after nothing
line 3353
;3353:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1384
line 3356
;3354:	}
;3355:
;3356:	as = &g_entities[wp->associated_entity];
ADDRLP4 0
CNSTI4 828
ADDRFP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3358
;3357:
;3358:	if (!as || !as->item)
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $1388
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $1386
LABELV $1388
line 3359
;3359:	{
line 3360
;3360:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1386
line 3363
;3361:	}
;3362:
;3363:	if (as->item->giType == IT_WEAPON)
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1389
line 3364
;3364:	{
line 3365
;3365:		if (bs->cur_ps.stats[STAT_WEAPONS] & (1 << as->item->giTag))
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1391
line 3366
;3366:		{
line 3367
;3367:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1391
line 3370
;3368:		}
;3369:
;3370:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1389
line 3372
;3371:	}
;3372:	else if (as->item->giType == IT_HOLDABLE)
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 6
NEI4 $1393
line 3373
;3373:	{
line 3374
;3374:		if (bs->cur_ps.stats[STAT_HOLDABLE_ITEMS] & (1 << as->item->giTag))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $1395
line 3375
;3375:		{
line 3376
;3376:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1395
line 3379
;3377:		}
;3378:
;3379:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1393
line 3381
;3380:	}
;3381:	else if (as->item->giType == IT_POWERUP)
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1397
line 3382
;3382:	{
line 3383
;3383:		if (bs->cur_ps.powerups[as->item->giTag])
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 360
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1399
line 3384
;3384:		{
line 3385
;3385:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1399
line 3388
;3386:		}
;3387:
;3388:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1397
line 3390
;3389:	}
;3390:	else if (as->item->giType == IT_AMMO)
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1401
line 3391
;3391:	{
line 3392
;3392:		if (bs->cur_ps.ammo[as->item->giTag] > 10) //hack
ADDRLP4 0
INDIRP4
CNSTI4 824
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
CNSTI4 10
LEI4 $1403
line 3393
;3393:		{
line 3394
;3394:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1403
line 3397
;3395:		}
;3396:
;3397:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1383
JUMPV
LABELV $1401
line 3400
;3398:	}
;3399:
;3400:	return 0;
CNSTI4 0
RETI4
LABELV $1383
endproc BotHasAssociated 12 0
export GetBestIdleGoal
proc GetBestIdleGoal 40 12
line 3404
;3401:}
;3402:
;3403:int GetBestIdleGoal(bot_state_t *bs)
;3404:{
line 3405
;3405:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3406
;3406:	int highestweight = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3407
;3407:	int desiredindex = -1;
ADDRLP4 16
CNSTI4 -1
ASGNI4
line 3408
;3408:	int dist_to_weight = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 3411
;3409:	int traildist;
;3410:
;3411:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1406
line 3412
;3412:	{
line 3413
;3413:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $1405
JUMPV
LABELV $1406
line 3416
;3414:	}
;3415:
;3416:	if (bs->isCamper != 2)
ADDRFP4 0
INDIRP4
CNSTI4 2048
ADDP4
INDIRI4
CNSTI4 2
EQI4 $1408
line 3417
;3417:	{
line 3418
;3418:		if (bs->randomNavTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2068
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1410
line 3419
;3419:		{
line 3420
;3420:			if (Q_irand(1, 10) < 5)
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 20
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 5
GEI4 $1413
line 3421
;3421:			{
line 3422
;3422:				bs->randomNav = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2072
ADDP4
CNSTI4 1
ASGNI4
line 3423
;3423:			}
ADDRGP4 $1414
JUMPV
LABELV $1413
line 3425
;3424:			else
;3425:			{
line 3426
;3426:				bs->randomNav = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2072
ADDP4
CNSTI4 0
ASGNI4
line 3427
;3427:			}
LABELV $1414
line 3429
;3428:			
;3429:			bs->randomNavTime = level.time + Q_irand(5000, 15000);
CNSTI4 5000
ARGI4
CNSTI4 15000
ARGI4
ADDRLP4 24
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2068
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 24
INDIRI4
ADDI4
ASGNI4
line 3430
;3430:		}
LABELV $1410
line 3431
;3431:	}
LABELV $1408
line 3433
;3432:
;3433:	if (bs->randomNav)
ADDRFP4 0
INDIRP4
CNSTI4 2072
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1419
line 3434
;3434:	{ //stop looking for items and/or camping on them
line 3435
;3435:		return -1;
CNSTI4 -1
RETI4
ADDRGP4 $1405
JUMPV
LABELV $1418
line 3439
;3436:	}
;3437:
;3438:	while (i < gWPNum)
;3439:	{
line 3440
;3440:		if (gWPArray[i] &&
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1421
ADDRLP4 24
CNSTI4 0
ASGNI4
ADDRLP4 20
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 24
INDIRI4
EQI4 $1421
ADDRLP4 20
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 65536
BANDI4
ADDRLP4 24
INDIRI4
EQI4 $1421
ADDRLP4 20
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
LEF4 $1421
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 20
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 BotHasAssociated
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1421
line 3445
;3441:			gWPArray[i]->inuse &&
;3442:			(gWPArray[i]->flags & WPFLAG_GOALPOINT) &&
;3443:			gWPArray[i]->weight > highestweight &&
;3444:			!BotHasAssociated(bs, gWPArray[i]))
;3445:		{
line 3446
;3446:			traildist = TotalTrailDistance(bs->wpCurrent->index, i, bs);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 8
ADDRLP4 36
INDIRF4
CVFI4 4
ASGNI4
line 3448
;3447:
;3448:			if (traildist != -1)
ADDRLP4 8
INDIRI4
CNSTI4 -1
EQI4 $1423
line 3449
;3449:			{
line 3450
;3450:				dist_to_weight = (int)traildist/10000;
ADDRLP4 12
ADDRLP4 8
INDIRI4
CNSTI4 10000
DIVI4
ASGNI4
line 3451
;3451:				dist_to_weight = (gWPArray[i]->weight)-dist_to_weight;
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12
INDIRI4
CVIF4 4
SUBF4
CVFI4 4
ASGNI4
line 3453
;3452:
;3453:				if (dist_to_weight > highestweight)
ADDRLP4 12
INDIRI4
ADDRLP4 4
INDIRI4
LEI4 $1425
line 3454
;3454:				{
line 3455
;3455:					highestweight = dist_to_weight;
ADDRLP4 4
ADDRLP4 12
INDIRI4
ASGNI4
line 3456
;3456:					desiredindex = i;
ADDRLP4 16
ADDRLP4 0
INDIRI4
ASGNI4
line 3457
;3457:				}
LABELV $1425
line 3458
;3458:			}
LABELV $1423
line 3459
;3459:		}
LABELV $1421
line 3461
;3460:
;3461:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3462
;3462:	}
LABELV $1419
line 3438
ADDRLP4 0
INDIRI4
ADDRGP4 gWPNum
INDIRI4
LTI4 $1418
line 3464
;3463:
;3464:	return desiredindex;
ADDRLP4 16
INDIRI4
RETI4
LABELV $1405
endproc GetBestIdleGoal 40 12
export GetIdealDestination
proc GetIdealDestination 160 12
line 3468
;3465:}
;3466:
;3467:void GetIdealDestination(bot_state_t *bs)
;3468:{
line 3483
;3469:	int tempInt, cWPIndex, bChicken, idleWP;
;3470:	float distChange, plusLen, minusLen;
;3471:	vec3_t usethisvec, a;
;3472:	gentity_t *badthing;
;3473:
;3474:#ifdef _DEBUG
;3475:	trap_Cvar_Update(&bot_nogoals);
;3476:
;3477:	if (bot_nogoals.integer)
;3478:	{
;3479:		return;
;3480:	}
;3481:#endif
;3482:
;3483:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1428
line 3484
;3484:	{
line 3485
;3485:		return;
ADDRGP4 $1427
JUMPV
LABELV $1428
line 3488
;3486:	}
;3487:
;3488:	if ((level.time - bs->escapeDirTime) > 4000)
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRFP4 0
INDIRP4
CNSTI4 2256
ADDP4
INDIRF4
SUBF4
CNSTF4 1165623296
LEF4 $1430
line 3489
;3489:	{
line 3490
;3490:		badthing = GetNearestBadThing(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 GetNearestBadThing
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRP4
ASGNP4
line 3491
;3491:	}
ADDRGP4 $1431
JUMPV
LABELV $1430
line 3493
;3492:	else
;3493:	{
line 3494
;3494:		badthing = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 3495
;3495:	}
LABELV $1431
line 3497
;3496:
;3497:	if (badthing && badthing->inuse &&
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1433
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1433
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
LEI4 $1433
ADDRLP4 0
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
ADDRLP4 60
INDIRI4
EQI4 $1433
line 3499
;3498:		badthing->health > 0 && badthing->takedamage)
;3499:	{
line 3500
;3500:		bs->dangerousObject = badthing;
ADDRFP4 0
INDIRP4
CNSTI4 1836
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3501
;3501:	}
ADDRGP4 $1434
JUMPV
LABELV $1433
line 3503
;3502:	else
;3503:	{
line 3504
;3504:		bs->dangerousObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1836
ADDP4
CNSTP4 0
ASGNP4
line 3505
;3505:	}
LABELV $1434
line 3507
;3506:
;3507:	if (!badthing && bs->wpDestIgnoreTime > level.time)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1435
ADDRFP4 0
INDIRP4
CNSTI4 1976
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $1435
line 3508
;3508:	{
line 3509
;3509:		return;
ADDRGP4 $1427
JUMPV
LABELV $1435
line 3512
;3510:	}
;3511:
;3512:	if (!badthing && bs->dontGoBack > level.time)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1438
ADDRFP4 0
INDIRP4
CNSTI4 2260
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $1438
line 3513
;3513:	{
line 3514
;3514:		if (bs->wpDestination)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1441
line 3515
;3515:		{
line 3516
;3516:			bs->wpStoreDest = bs->wpDestination;
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 1880
ADDP4
ADDRLP4 64
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
line 3517
;3517:		}
LABELV $1441
line 3518
;3518:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 3519
;3519:		return;
ADDRGP4 $1427
JUMPV
LABELV $1438
line 3521
;3520:	}
;3521:	else if (!badthing && bs->wpStoreDest)
ADDRLP4 64
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 64
INDIRU4
NEU4 $1443
ADDRFP4 0
INDIRP4
CNSTI4 1880
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 64
INDIRU4
EQU4 $1443
line 3522
;3522:	{ //after we finish running away, switch back to our original destination
line 3523
;3523:		bs->wpDestination = bs->wpStoreDest;
ADDRLP4 68
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 68
INDIRP4
CNSTI4 1880
ADDP4
INDIRP4
ASGNP4
line 3524
;3524:		bs->wpStoreDest = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1880
ADDP4
CNSTP4 0
ASGNP4
line 3525
;3525:	}
LABELV $1443
line 3527
;3526:
;3527:	if (badthing && bs->wpCamping)
ADDRLP4 68
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
EQU4 $1445
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 68
INDIRU4
EQU4 $1445
line 3528
;3528:	{
line 3529
;3529:		bs->wpCamping = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
CNSTP4 0
ASGNP4
line 3530
;3530:	}
LABELV $1445
line 3532
;3531:
;3532:	if (bs->wpCamping)
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1447
line 3533
;3533:	{
line 3534
;3534:		bs->wpDestination = bs->wpCamping;
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
ASGNP4
line 3535
;3535:		return;
ADDRGP4 $1427
JUMPV
LABELV $1447
line 3538
;3536:	}
;3537:
;3538:	if (!badthing && CTFTakesPriority(bs))
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1449
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 72
ADDRGP4 CTFTakesPriority
CALLI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
EQI4 $1449
line 3539
;3539:	{
line 3540
;3540:		if (bs->ctfState)
ADDRFP4 0
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1427
line 3541
;3541:		{
line 3542
;3542:			bs->runningToEscapeThreat = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2300
ADDP4
CNSTI4 1
ASGNI4
line 3543
;3543:		}
line 3544
;3544:		return;
ADDRGP4 $1427
JUMPV
LABELV $1449
line 3546
;3545:	}
;3546:	else if (!badthing && SagaTakesPriority(bs))
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1453
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 76
ADDRGP4 SagaTakesPriority
CALLI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $1453
line 3547
;3547:	{
line 3548
;3548:		if (bs->sagaState)
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1427
line 3549
;3549:		{
line 3550
;3550:			bs->runningToEscapeThreat = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2300
ADDP4
CNSTI4 1
ASGNI4
line 3551
;3551:		}
line 3552
;3552:		return;
ADDRGP4 $1427
JUMPV
LABELV $1453
line 3554
;3553:	}
;3554:	else if (!badthing && JMTakesPriority(bs))
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1457
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 80
ADDRGP4 JMTakesPriority
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $1457
line 3555
;3555:	{
line 3556
;3556:		bs->runningToEscapeThreat = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2300
ADDP4
CNSTI4 1
ASGNI4
line 3557
;3557:	}
LABELV $1457
line 3559
;3558:
;3559:	if (badthing)
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1459
line 3560
;3560:	{
line 3561
;3561:		bs->runningLikeASissy = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 2296
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 3563
;3562:
;3563:		if (bs->wpDestination)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1462
line 3564
;3564:		{
line 3565
;3565:			bs->wpStoreDest = bs->wpDestination;
ADDRLP4 84
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 1880
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ASGNP4
line 3566
;3566:		}
LABELV $1462
line 3567
;3567:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 3569
;3568:
;3569:		if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1464
line 3570
;3570:		{
line 3571
;3571:			tempInt = bs->wpCurrent->index+1;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3572
;3572:		}
ADDRGP4 $1465
JUMPV
LABELV $1464
line 3574
;3573:		else
;3574:		{
line 3575
;3575:			tempInt = bs->wpCurrent->index-1;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 3576
;3576:		}
LABELV $1465
line 3578
;3577:
;3578:		if (gWPArray[tempInt] && gWPArray[tempInt]->inuse && bs->escapeDirTime < level.time)
ADDRLP4 84
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1427
ADDRLP4 84
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1427
ADDRFP4 0
INDIRP4
CNSTI4 2256
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1427
line 3579
;3579:		{
line 3580
;3580:			VectorSubtract(badthing->s.pos.trBase, bs->wpCurrent->origin, a);
ADDRLP4 92
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 92
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3581
;3581:			plusLen = VectorLength(a);
ADDRLP4 12
ARGP4
ADDRLP4 96
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 96
INDIRF4
ASGNF4
line 3582
;3582:			VectorSubtract(badthing->s.pos.trBase, gWPArray[tempInt]->origin, a);
ADDRLP4 104
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
ASGNP4
ADDRLP4 12
ADDRLP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 104
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 0
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 3583
;3583:			minusLen = VectorLength(a);
ADDRLP4 12
ARGP4
ADDRLP4 108
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 108
INDIRF4
ASGNF4
line 3585
;3584:
;3585:			if (plusLen < minusLen)
ADDRLP4 44
INDIRF4
ADDRLP4 48
INDIRF4
GEF4 $1427
line 3586
;3586:			{
line 3587
;3587:				if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1475
line 3588
;3588:				{
line 3589
;3589:					bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 3590
;3590:				}
ADDRGP4 $1476
JUMPV
LABELV $1475
line 3592
;3591:				else
;3592:				{
line 3593
;3593:					bs->wpDirection = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 1
ASGNI4
line 3594
;3594:				}
LABELV $1476
line 3596
;3595:
;3596:				bs->wpCurrent = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3598
;3597:
;3598:				bs->escapeDirTime = level.time + Q_irand(500, 1000);//Q_irand(1000, 1400);
CNSTI4 500
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 112
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2256
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 112
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 3601
;3599:
;3600:				//G_Printf("Escaping from scary bad thing [%s]\n", badthing->classname);
;3601:			}
line 3602
;3602:		}
line 3604
;3603:		//G_Printf("Run away run away run away!\n");
;3604:		return;
ADDRGP4 $1427
JUMPV
LABELV $1459
line 3607
;3605:	}
;3606:
;3607:	distChange = 0; //keep the compiler from complaining
ADDRLP4 24
CNSTF4 0
ASGNF4
line 3609
;3608:
;3609:	tempInt = BotGetWeaponRange(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 84
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 84
INDIRI4
ASGNI4
line 3611
;3610:
;3611:	if (tempInt == BWEAPONRANGE_MELEE)
ADDRLP4 4
INDIRI4
CNSTI4 1
NEI4 $1478
line 3612
;3612:	{
line 3613
;3613:		distChange = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 3614
;3614:	}
ADDRGP4 $1479
JUMPV
LABELV $1478
line 3615
;3615:	else if (tempInt == BWEAPONRANGE_SABER)
ADDRLP4 4
INDIRI4
CNSTI4 4
NEI4 $1480
line 3616
;3616:	{
line 3617
;3617:		distChange = 1;
ADDRLP4 24
CNSTF4 1065353216
ASGNF4
line 3618
;3618:	}
ADDRGP4 $1481
JUMPV
LABELV $1480
line 3619
;3619:	else if (tempInt == BWEAPONRANGE_MID)
ADDRLP4 4
INDIRI4
CNSTI4 2
NEI4 $1482
line 3620
;3620:	{
line 3621
;3621:		distChange = 128;
ADDRLP4 24
CNSTF4 1124073472
ASGNF4
line 3622
;3622:	}
ADDRGP4 $1483
JUMPV
LABELV $1482
line 3623
;3623:	else if (tempInt == BWEAPONRANGE_LONG)
ADDRLP4 4
INDIRI4
CNSTI4 3
NEI4 $1484
line 3624
;3624:	{
line 3625
;3625:		distChange = 300;
ADDRLP4 24
CNSTF4 1133903872
ASGNF4
line 3626
;3626:	}
LABELV $1484
LABELV $1483
LABELV $1481
LABELV $1479
line 3628
;3627:
;3628:	if (bs->revengeEnemy && bs->revengeEnemy->health > 0 &&
ADDRLP4 88
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
ASGNP4
ADDRLP4 92
CNSTU4 0
ASGNU4
ADDRLP4 88
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $1486
ADDRLP4 88
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1486
ADDRLP4 96
ADDRLP4 88
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 96
INDIRP4
CVPU4 4
ADDRLP4 92
INDIRU4
EQU4 $1486
ADDRLP4 100
ADDRLP4 96
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
ASGNI4
ADDRLP4 100
INDIRI4
CNSTI4 8
EQI4 $1488
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $1486
LABELV $1488
line 3630
;3629:		bs->revengeEnemy->client && (bs->revengeEnemy->client->pers.connected == CA_ACTIVE || bs->revengeEnemy->client->pers.connected == CA_AUTHORIZING))
;3630:	{ //if we hate someone, always try to get to them
line 3631
;3631:		if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1487
line 3632
;3632:		{
line 3633
;3633:			if (bs->revengeEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1492
line 3634
;3634:			{
line 3635
;3635:				VectorCopy(bs->revengeEnemy->client->ps.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3636
;3636:			}
ADDRGP4 $1493
JUMPV
LABELV $1492
line 3638
;3637:			else
;3638:			{
line 3639
;3639:				VectorCopy(bs->revengeEnemy->s.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 3640
;3640:			}
LABELV $1493
line 3642
;3641:
;3642:			tempInt = GetNearestVisibleWP(usethisvec, 0);
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 104
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 104
INDIRI4
ASGNI4
line 3644
;3643:
;3644:			if (tempInt != -1 && TotalTrailDistance(bs->wpCurrent->index, tempInt, bs) != -1)
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1487
ADDRLP4 112
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 112
INDIRP4
ARGP4
ADDRLP4 116
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 116
INDIRF4
CNSTF4 3212836864
EQF4 $1487
line 3645
;3645:			{
line 3646
;3646:				bs->wpDestination = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3647
;3647:				bs->wpDestSwitchTime = level.time + Q_irand(5000, 10000);
CNSTI4 5000
ARGI4
CNSTI4 10000
ARGI4
ADDRLP4 120
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 120
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 3648
;3648:			}
line 3649
;3649:		}
line 3650
;3650:	}
ADDRGP4 $1487
JUMPV
LABELV $1486
line 3651
;3651:	else if (bs->squadLeader && bs->squadLeader->health > 0 &&
ADDRLP4 104
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 108
CNSTU4 0
ASGNU4
ADDRLP4 104
INDIRP4
CVPU4 4
ADDRLP4 108
INDIRU4
EQU4 $1497
ADDRLP4 104
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 0
LEI4 $1497
ADDRLP4 112
ADDRLP4 104
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 112
INDIRP4
CVPU4 4
ADDRLP4 108
INDIRU4
EQU4 $1497
ADDRLP4 116
ADDRLP4 112
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
ASGNI4
ADDRLP4 116
INDIRI4
CNSTI4 8
EQI4 $1499
ADDRLP4 116
INDIRI4
CNSTI4 2
NEI4 $1497
LABELV $1499
line 3653
;3652:		bs->squadLeader->client && (bs->squadLeader->client->pers.connected == CA_ACTIVE || bs->squadLeader->client->pers.connected == CA_AUTHORIZING))
;3653:	{
line 3654
;3654:		if (bs->wpDestSwitchTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1498
line 3655
;3655:		{
line 3656
;3656:			if (bs->squadLeader->client)
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1503
line 3657
;3657:			{
line 3658
;3658:				VectorCopy(bs->squadLeader->client->ps.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3659
;3659:			}
ADDRGP4 $1504
JUMPV
LABELV $1503
line 3661
;3660:			else
;3661:			{
line 3662
;3662:				VectorCopy(bs->squadLeader->s.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 3663
;3663:			}
LABELV $1504
line 3665
;3664:
;3665:			tempInt = GetNearestVisibleWP(usethisvec, 0);
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 120
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 120
INDIRI4
ASGNI4
line 3667
;3666:
;3667:			if (tempInt != -1 && TotalTrailDistance(bs->wpCurrent->index, tempInt, bs) != -1)
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1498
ADDRLP4 128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 128
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 128
INDIRP4
ARGP4
ADDRLP4 132
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 132
INDIRF4
CNSTF4 3212836864
EQF4 $1498
line 3668
;3668:			{
line 3669
;3669:				bs->wpDestination = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3670
;3670:				bs->wpDestSwitchTime = level.time + Q_irand(5000, 10000);
CNSTI4 5000
ARGI4
CNSTI4 10000
ARGI4
ADDRLP4 136
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 136
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 3671
;3671:			}
line 3672
;3672:		}
line 3673
;3673:	}
ADDRGP4 $1498
JUMPV
LABELV $1497
line 3674
;3674:	else if (bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1508
line 3675
;3675:	{
line 3676
;3676:		if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1510
line 3677
;3677:		{
line 3678
;3678:			VectorCopy(bs->currentEnemy->client->ps.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 3679
;3679:		}
ADDRGP4 $1511
JUMPV
LABELV $1510
line 3681
;3680:		else
;3681:		{
line 3682
;3682:			VectorCopy(bs->currentEnemy->s.origin, usethisvec);
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 3683
;3683:		}
LABELV $1511
line 3685
;3684:
;3685:		bChicken = BotIsAChickenWuss(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 120
ADDRGP4 BotIsAChickenWuss
CALLI4
ASGNI4
ADDRLP4 40
ADDRLP4 120
INDIRI4
ASGNI4
line 3686
;3686:		bs->runningToEscapeThreat = bChicken;
ADDRFP4 0
INDIRP4
CNSTI4 2300
ADDP4
ADDRLP4 40
INDIRI4
ASGNI4
line 3688
;3687:
;3688:		if (bs->frame_Enemy_Len < distChange || (bChicken && bChicken != 2))
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ADDRLP4 24
INDIRF4
LTF4 $1514
ADDRLP4 124
ADDRLP4 40
INDIRI4
ASGNI4
ADDRLP4 124
INDIRI4
CNSTI4 0
EQI4 $1512
ADDRLP4 124
INDIRI4
CNSTI4 2
EQI4 $1512
LABELV $1514
line 3689
;3689:		{
line 3690
;3690:			cWPIndex = bs->wpCurrent->index;
ADDRLP4 52
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ASGNI4
line 3692
;3691:
;3692:			if (bs->frame_Enemy_Len > 400)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1137180672
LEF4 $1515
line 3693
;3693:			{ //good distance away, start running toward a good place for an item or powerup or whatever
line 3694
;3694:				idleWP = GetBestIdleGoal(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 128
ADDRGP4 GetBestIdleGoal
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 128
INDIRI4
ASGNI4
line 3696
;3695:
;3696:				if (idleWP != -1 && gWPArray[idleWP] && gWPArray[idleWP]->inuse)
ADDRLP4 132
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 132
INDIRI4
CNSTI4 -1
EQI4 $1513
ADDRLP4 136
ADDRLP4 132
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1513
ADDRLP4 136
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1513
line 3697
;3697:				{
line 3698
;3698:					bs->wpDestination = gWPArray[idleWP];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3699
;3699:				}
line 3700
;3700:			}
ADDRGP4 $1513
JUMPV
LABELV $1515
line 3701
;3701:			else if (gWPArray[cWPIndex-1] && gWPArray[cWPIndex-1]->inuse &&
ADDRLP4 128
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 132
CNSTU4 0
ASGNU4
ADDRLP4 128
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 132
INDIRU4
EQU4 $1513
ADDRLP4 136
CNSTI4 12
ASGNI4
ADDRLP4 140
CNSTI4 0
ASGNI4
ADDRLP4 128
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
EQI4 $1513
ADDRLP4 128
INDIRI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 132
INDIRU4
EQU4 $1513
ADDRLP4 128
INDIRI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
ADDRLP4 136
INDIRI4
ADDP4
INDIRI4
ADDRLP4 140
INDIRI4
EQI4 $1513
line 3703
;3702:				gWPArray[cWPIndex+1] && gWPArray[cWPIndex+1]->inuse)
;3703:			{
line 3704
;3704:				VectorSubtract(gWPArray[cWPIndex+1]->origin, usethisvec, a);
ADDRLP4 144
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRLP4 144
INDIRI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 144
INDIRI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 3705
;3705:				plusLen = VectorLength(a);
ADDRLP4 12
ARGP4
ADDRLP4 148
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 44
ADDRLP4 148
INDIRF4
ASGNF4
line 3706
;3706:				VectorSubtract(gWPArray[cWPIndex-1]->origin, usethisvec, a);
ADDRLP4 152
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 12
ADDRLP4 152
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
INDIRF4
ADDRLP4 28
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+4
ADDRLP4 152
INDIRI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 28+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 12+8
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 28+8
INDIRF4
SUBF4
ASGNF4
line 3707
;3707:				minusLen = VectorLength(a);
ADDRLP4 12
ARGP4
ADDRLP4 156
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 48
ADDRLP4 156
INDIRF4
ASGNF4
line 3709
;3708:
;3709:				if (minusLen > plusLen)
ADDRLP4 48
INDIRF4
ADDRLP4 44
INDIRF4
LEF4 $1539
line 3710
;3710:				{
line 3711
;3711:					bs->wpDestination = gWPArray[cWPIndex-1];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray-4
ADDP4
INDIRP4
ASGNP4
line 3712
;3712:				}
ADDRGP4 $1513
JUMPV
LABELV $1539
line 3714
;3713:				else
;3714:				{
line 3715
;3715:					bs->wpDestination = gWPArray[cWPIndex+1];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 52
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray+4
ADDP4
INDIRP4
ASGNP4
line 3716
;3716:				}
line 3717
;3717:			}
line 3718
;3718:		}
ADDRGP4 $1513
JUMPV
LABELV $1512
line 3719
;3719:		else if (bChicken != 2 && bs->wpDestSwitchTime < level.time)
ADDRLP4 40
INDIRI4
CNSTI4 2
EQI4 $1543
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1543
line 3720
;3720:		{
line 3721
;3721:			tempInt = GetNearestVisibleWP(usethisvec, 0);
ADDRLP4 28
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 128
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 4
ADDRLP4 128
INDIRI4
ASGNI4
line 3723
;3722:
;3723:			if (tempInt != -1 && TotalTrailDistance(bs->wpCurrent->index, tempInt, bs) != -1)
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $1546
ADDRLP4 136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 136
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 136
INDIRP4
ARGP4
ADDRLP4 140
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 140
INDIRF4
CNSTF4 3212836864
EQF4 $1546
line 3724
;3724:			{
line 3725
;3725:				bs->wpDestination = gWPArray[tempInt];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3726
;3726:				bs->wpDestSwitchTime = level.time + Q_irand(1000, 5000);
CNSTI4 1000
ARGI4
CNSTI4 5000
ARGI4
ADDRLP4 144
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 144
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 3727
;3727:			}
LABELV $1546
line 3728
;3728:		}
LABELV $1543
LABELV $1513
line 3729
;3729:	}
LABELV $1508
LABELV $1498
LABELV $1487
line 3731
;3730:
;3731:	if (!bs->wpDestination && bs->wpDestSwitchTime < level.time)
ADDRLP4 120
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 120
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1549
ADDRLP4 120
INDIRP4
CNSTI4 1968
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1549
line 3732
;3732:	{
line 3734
;3733:		//G_Printf("I need something to do\n");
;3734:		idleWP = GetBestIdleGoal(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 124
ADDRGP4 GetBestIdleGoal
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 124
INDIRI4
ASGNI4
line 3736
;3735:
;3736:		if (idleWP != -1 && gWPArray[idleWP] && gWPArray[idleWP]->inuse)
ADDRLP4 128
ADDRLP4 8
INDIRI4
ASGNI4
ADDRLP4 128
INDIRI4
CNSTI4 -1
EQI4 $1552
ADDRLP4 132
ADDRLP4 128
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 132
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1552
ADDRLP4 132
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1552
line 3737
;3737:		{
line 3738
;3738:			bs->wpDestination = gWPArray[idleWP];
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 3739
;3739:		}
LABELV $1552
line 3740
;3740:	}
LABELV $1549
line 3741
;3741:}
LABELV $1427
endproc GetIdealDestination 160 12
export CommanderBotCTFAI
proc CommanderBotCTFAI 216 8
line 3744
;3742:
;3743:void CommanderBotCTFAI(bot_state_t *bs)
;3744:{
line 3745
;3745:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3747
;3746:	gentity_t *ent;
;3747:	int squadmates = 0;
ADDRLP4 136
CNSTI4 0
ASGNI4
line 3749
;3748:	gentity_t *squad[MAX_CLIENTS];
;3749:	int defendAttackPriority = 0; //0 == attack, 1 == defend
ADDRLP4 152
CNSTI4 0
ASGNI4
line 3750
;3750:	int guardDefendPriority = 0; //0 == defend, 1 == guard
ADDRLP4 176
CNSTI4 0
ASGNI4
line 3751
;3751:	int attackRetrievePriority = 0; //0 == retrieve, 1 == attack
ADDRLP4 172
CNSTI4 0
ASGNI4
line 3752
;3752:	int myFlag = 0;
ADDRLP4 164
CNSTI4 0
ASGNI4
line 3753
;3753:	int enemyFlag = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3754
;3754:	int enemyHasOurFlag = 0;
ADDRLP4 148
CNSTI4 0
ASGNI4
line 3755
;3755:	int weHaveEnemyFlag = 0;
ADDRLP4 160
CNSTI4 0
ASGNI4
line 3756
;3756:	int numOnMyTeam = 0;
ADDRLP4 156
CNSTI4 0
ASGNI4
line 3757
;3757:	int numOnEnemyTeam = 0;
ADDRLP4 168
CNSTI4 0
ASGNI4
line 3758
;3758:	int numAttackers = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 3759
;3759:	int numDefenders = 0;
ADDRLP4 180
CNSTI4 0
ASGNI4
line 3761
;3760:
;3761:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1555
line 3762
;3762:	{
line 3763
;3763:		myFlag = PW_REDFLAG;
ADDRLP4 164
CNSTI4 4
ASGNI4
line 3764
;3764:	}
ADDRGP4 $1556
JUMPV
LABELV $1555
line 3766
;3765:	else
;3766:	{
line 3767
;3767:		myFlag = PW_BLUEFLAG;
ADDRLP4 164
CNSTI4 5
ASGNI4
line 3768
;3768:	}
LABELV $1556
line 3770
;3769:
;3770:	if (level.clients[bs->client].sess.sessionTeam == TEAM_RED)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1557
line 3771
;3771:	{
line 3772
;3772:		enemyFlag = PW_BLUEFLAG;
ADDRLP4 144
CNSTI4 5
ASGNI4
line 3773
;3773:	}
ADDRGP4 $1560
JUMPV
LABELV $1557
line 3775
;3774:	else
;3775:	{
line 3776
;3776:		enemyFlag = PW_REDFLAG;
ADDRLP4 144
CNSTI4 4
ASGNI4
line 3777
;3777:	}
ADDRGP4 $1560
JUMPV
LABELV $1559
line 3780
;3778:
;3779:	while (i < MAX_CLIENTS)
;3780:	{
line 3781
;3781:		ent = &g_entities[i];
ADDRLP4 4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3783
;3782:
;3783:		if (ent && ent->client)
ADDRLP4 188
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1562
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1562
line 3784
;3784:		{
line 3785
;3785:			if (ent->client->ps.powerups[enemyFlag] && OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1564
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
EQI4 $1564
line 3786
;3786:			{
line 3787
;3787:				weHaveEnemyFlag = 1;
ADDRLP4 160
CNSTI4 1
ASGNI4
line 3788
;3788:			}
ADDRGP4 $1565
JUMPV
LABELV $1564
line 3789
;3789:			else if (ent->client->ps.powerups[myFlag] && !OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 164
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 344
ADDP4
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1566
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 204
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 204
INDIRI4
CNSTI4 0
NEI4 $1566
line 3790
;3790:			{
line 3791
;3791:				enemyHasOurFlag = 1;
ADDRLP4 148
CNSTI4 1
ASGNI4
line 3792
;3792:			}
LABELV $1566
LABELV $1565
line 3794
;3793:
;3794:			if (OnSameTeam(&g_entities[bs->client], ent))
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 208
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $1568
line 3795
;3795:			{
line 3796
;3796:				numOnMyTeam++;
ADDRLP4 156
ADDRLP4 156
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3797
;3797:			}
ADDRGP4 $1569
JUMPV
LABELV $1568
line 3799
;3798:			else
;3799:			{
line 3800
;3800:				numOnEnemyTeam++;
ADDRLP4 168
ADDRLP4 168
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3801
;3801:			}
LABELV $1569
line 3803
;3802:
;3803:			if (botstates[ent->s.number])
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1570
line 3804
;3804:			{
line 3805
;3805:				if (botstates[ent->s.number]->ctfState == CTFSTATE_ATTACKER ||
ADDRLP4 212
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
ASGNI4
ADDRLP4 212
INDIRI4
CNSTI4 1
EQI4 $1574
ADDRLP4 212
INDIRI4
CNSTI4 3
NEI4 $1572
LABELV $1574
line 3807
;3806:					botstates[ent->s.number]->ctfState == CTFSTATE_RETRIEVAL)
;3807:				{
line 3808
;3808:					numAttackers++;
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3809
;3809:				}
ADDRGP4 $1571
JUMPV
LABELV $1572
line 3811
;3810:				else
;3811:				{
line 3812
;3812:					numDefenders++;
ADDRLP4 180
ADDRLP4 180
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3813
;3813:				}
line 3814
;3814:			}
ADDRGP4 $1571
JUMPV
LABELV $1570
line 3816
;3815:			else
;3816:			{ //assume real players to be attackers in our logic
line 3817
;3817:				numAttackers++;
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3818
;3818:			}
LABELV $1571
line 3819
;3819:		}
LABELV $1562
line 3820
;3820:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3821
;3821:	}
LABELV $1560
line 3779
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $1559
line 3823
;3822:
;3823:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $1576
JUMPV
LABELV $1575
line 3826
;3824:
;3825:	while (i < MAX_CLIENTS)
;3826:	{
line 3827
;3827:		ent = &g_entities[i];
ADDRLP4 4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3829
;3828:
;3829:		if (ent && ent->client && botstates[i] && botstates[i]->squadLeader && botstates[i]->squadLeader->s.number == bs->client && i != bs->client)
ADDRLP4 188
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1578
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1578
ADDRLP4 196
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1578
ADDRLP4 200
ADDRLP4 196
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
ASGNP4
ADDRLP4 200
INDIRP4
CVPU4 4
ADDRLP4 188
INDIRU4
EQU4 $1578
ADDRLP4 204
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
ADDRLP4 200
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
NEI4 $1578
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
EQI4 $1578
line 3830
;3830:		{
line 3831
;3831:			squad[squadmates] = ent;
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 3832
;3832:			squadmates++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3833
;3833:		}
LABELV $1578
line 3835
;3834:
;3835:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3836
;3836:	}
LABELV $1576
line 3825
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $1575
line 3838
;3837:
;3838:	squad[squadmates] = &g_entities[bs->client];
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
ADDP4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3839
;3839:	squadmates++;
ADDRLP4 136
ADDRLP4 136
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3841
;3840:
;3841:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 3843
;3842:
;3843:	if (enemyHasOurFlag && !weHaveEnemyFlag)
ADDRLP4 184
CNSTI4 0
ASGNI4
ADDRLP4 148
INDIRI4
ADDRLP4 184
INDIRI4
EQI4 $1583
ADDRLP4 160
INDIRI4
ADDRLP4 184
INDIRI4
NEI4 $1583
line 3844
;3844:	{ //start off with an attacker instead of a retriever if we don't have the enemy flag yet so that they can't capture it first.
line 3846
;3845:	  //after that we focus on getting our flag back.
;3846:		attackRetrievePriority = 1;
ADDRLP4 172
CNSTI4 1
ASGNI4
line 3847
;3847:	}
ADDRGP4 $1583
JUMPV
LABELV $1582
line 3850
;3848:
;3849:	while (i < squadmates)
;3850:	{
line 3851
;3851:		if (squad[i] && squad[i]->client && botstates[squad[i]->s.number])
ADDRLP4 188
CNSTI4 2
ASGNI4
ADDRLP4 192
ADDRLP4 0
INDIRI4
ADDRLP4 188
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
ASGNP4
ADDRLP4 196
CNSTU4 0
ASGNU4
ADDRLP4 192
INDIRP4
CVPU4 4
ADDRLP4 196
INDIRU4
EQU4 $1585
ADDRLP4 192
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 196
INDIRU4
EQU4 $1585
ADDRLP4 192
INDIRP4
INDIRI4
ADDRLP4 188
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 196
INDIRU4
EQU4 $1585
line 3852
;3852:		{
line 3853
;3853:			if (botstates[squad[i]->s.number]->ctfState != CTFSTATE_GETFLAGHOME)
ADDRLP4 200
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 200
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 200
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
INDIRI4
CNSTI4 5
EQI4 $1587
line 3854
;3854:			{ //never tell a bot to stop trying to bring the flag to the base
line 3855
;3855:				if (defendAttackPriority)
ADDRLP4 152
INDIRI4
CNSTI4 0
EQI4 $1589
line 3856
;3856:				{
line 3857
;3857:					if (weHaveEnemyFlag)
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $1591
line 3858
;3858:					{
line 3859
;3859:						if (guardDefendPriority)
ADDRLP4 176
INDIRI4
CNSTI4 0
EQI4 $1593
line 3860
;3860:						{
line 3861
;3861:							botstates[squad[i]->s.number]->ctfState = CTFSTATE_GUARDCARRIER;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 4
ASGNI4
line 3862
;3862:							guardDefendPriority = 0;
ADDRLP4 176
CNSTI4 0
ASGNI4
line 3863
;3863:						}
ADDRGP4 $1592
JUMPV
LABELV $1593
line 3865
;3864:						else
;3865:						{
line 3866
;3866:							botstates[squad[i]->s.number]->ctfState = CTFSTATE_DEFENDER;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 3867
;3867:							guardDefendPriority = 1;
ADDRLP4 176
CNSTI4 1
ASGNI4
line 3868
;3868:						}
line 3869
;3869:					}
ADDRGP4 $1592
JUMPV
LABELV $1591
line 3871
;3870:					else
;3871:					{
line 3872
;3872:						botstates[squad[i]->s.number]->ctfState = CTFSTATE_DEFENDER;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
ADDRLP4 204
INDIRI4
ASGNI4
line 3873
;3873:					}
LABELV $1592
line 3874
;3874:					defendAttackPriority = 0;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 3875
;3875:				}
ADDRGP4 $1588
JUMPV
LABELV $1589
line 3877
;3876:				else
;3877:				{
line 3878
;3878:					if (enemyHasOurFlag)
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1595
line 3879
;3879:					{
line 3880
;3880:						if (attackRetrievePriority)
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1597
line 3881
;3881:						{
line 3882
;3882:							botstates[squad[i]->s.number]->ctfState = CTFSTATE_ATTACKER;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 1
ASGNI4
line 3883
;3883:							attackRetrievePriority = 0;
ADDRLP4 172
CNSTI4 0
ASGNI4
line 3884
;3884:						}
ADDRGP4 $1596
JUMPV
LABELV $1597
line 3886
;3885:						else
;3886:						{
line 3887
;3887:							botstates[squad[i]->s.number]->ctfState = CTFSTATE_RETRIEVAL;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 3
ASGNI4
line 3888
;3888:							attackRetrievePriority = 1;
ADDRLP4 172
CNSTI4 1
ASGNI4
line 3889
;3889:						}
line 3890
;3890:					}
ADDRGP4 $1596
JUMPV
LABELV $1595
line 3892
;3891:					else
;3892:					{
line 3893
;3893:						botstates[squad[i]->s.number]->ctfState = CTFSTATE_ATTACKER;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 1
ASGNI4
line 3894
;3894:					}
LABELV $1596
line 3895
;3895:					defendAttackPriority = 1;
ADDRLP4 152
CNSTI4 1
ASGNI4
line 3896
;3896:				}
line 3897
;3897:			}
ADDRGP4 $1588
JUMPV
LABELV $1587
line 3898
;3898:			else if ((numOnMyTeam < 2 || !numAttackers) && enemyHasOurFlag)
ADDRLP4 156
INDIRI4
CNSTI4 2
LTI4 $1601
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1599
LABELV $1601
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1599
line 3899
;3899:			{ //I'm the only one on my team who will attack and the enemy has my flag, I have to go after him
line 3900
;3900:				botstates[squad[i]->s.number]->ctfState = CTFSTATE_RETRIEVAL;
ADDRLP4 204
CNSTI4 2
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRLP4 8
ADDP4
INDIRP4
INDIRI4
ADDRLP4 204
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2676
ADDP4
CNSTI4 3
ASGNI4
line 3901
;3901:			}
LABELV $1599
LABELV $1588
line 3902
;3902:		}
LABELV $1585
line 3904
;3903:
;3904:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3905
;3905:	}
LABELV $1583
line 3849
ADDRLP4 0
INDIRI4
ADDRLP4 136
INDIRI4
LTI4 $1582
line 3906
;3906:}
LABELV $1554
endproc CommanderBotCTFAI 216 8
export CommanderBotSagaAI
proc CommanderBotSagaAI 180 8
line 3909
;3907:
;3908:void CommanderBotSagaAI(bot_state_t *bs)
;3909:{
line 3910
;3910:	int i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 3911
;3911:	int squadmates = 0;
ADDRLP4 144
CNSTI4 0
ASGNI4
line 3912
;3912:	int commanded = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 3913
;3913:	int teammates = 0;
ADDRLP4 148
CNSTI4 0
ASGNI4
ADDRGP4 $1604
JUMPV
LABELV $1603
line 3919
;3914:	gentity_t *squad[MAX_CLIENTS];
;3915:	gentity_t *ent;
;3916:	bot_state_t *bst;
;3917:
;3918:	while (i < MAX_CLIENTS)
;3919:	{
line 3920
;3920:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 3922
;3921:
;3922:		if (ent && ent->client && OnSameTeam(&g_entities[bs->client], ent) && botstates[ent->s.number])
ADDRLP4 156
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 156
INDIRU4
EQU4 $1606
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 156
INDIRU4
EQU4 $1606
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 160
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 160
INDIRI4
CNSTI4 0
EQI4 $1606
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1606
line 3923
;3923:		{
line 3924
;3924:			bst = botstates[ent->s.number];
ADDRLP4 8
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 3926
;3925:
;3926:			if (bst && !bst->isSquadLeader && !bst->state_Forced)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1608
ADDRLP4 168
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
NEI4 $1608
ADDRLP4 8
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
ADDRLP4 168
INDIRI4
NEI4 $1608
line 3927
;3927:			{
line 3928
;3928:				squad[squadmates] = ent;
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 3929
;3929:				squadmates++;
ADDRLP4 144
ADDRLP4 144
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3930
;3930:			}
ADDRGP4 $1609
JUMPV
LABELV $1608
line 3931
;3931:			else if (bst && !bst->isSquadLeader && bst->state_Forced)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1610
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 8
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
ADDRLP4 176
INDIRI4
NEI4 $1610
ADDRLP4 8
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
ADDRLP4 176
INDIRI4
EQI4 $1610
line 3932
;3932:			{ //count them as commanded
line 3933
;3933:				commanded++;
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3934
;3934:			}
LABELV $1610
LABELV $1609
line 3935
;3935:		}
LABELV $1606
line 3937
;3936:
;3937:		if (ent && ent->client && OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 168
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $1612
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $1612
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1612
line 3938
;3938:		{
line 3939
;3939:			teammates++;
ADDRLP4 148
ADDRLP4 148
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3940
;3940:		}
LABELV $1612
line 3942
;3941:
;3942:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3943
;3943:	}
LABELV $1604
line 3918
ADDRLP4 4
INDIRI4
CNSTI4 32
LTI4 $1603
line 3945
;3944:	
;3945:	if (!squadmates)
ADDRLP4 144
INDIRI4
CNSTI4 0
NEI4 $1614
line 3946
;3946:	{
line 3947
;3947:		return;
ADDRGP4 $1602
JUMPV
LABELV $1614
line 3951
;3948:	}
;3949:
;3950:	//tell squad mates to do what I'm doing, up to half of team, let the other half make their own decisions
;3951:	i = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $1617
JUMPV
LABELV $1616
line 3954
;3952:
;3953:	while (i < squadmates && squad[i])
;3954:	{
line 3955
;3955:		bst = botstates[squad[i]->s.number];
ADDRLP4 152
CNSTI4 2
ASGNI4
ADDRLP4 8
ADDRLP4 4
INDIRI4
ADDRLP4 152
INDIRI4
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
INDIRI4
ADDRLP4 152
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 3957
;3956:
;3957:		if (commanded > teammates/2)
ADDRLP4 140
INDIRI4
ADDRLP4 148
INDIRI4
CNSTI4 2
DIVI4
LEI4 $1619
line 3958
;3958:		{
line 3959
;3959:			break;
ADDRGP4 $1618
JUMPV
LABELV $1619
line 3962
;3960:		}
;3961:
;3962:		if (bst)
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1621
line 3963
;3963:		{
line 3964
;3964:			bst->state_Forced = bs->sagaState;
ADDRLP4 8
INDIRP4
CNSTI4 2692
ADDP4
ADDRFP4 0
INDIRP4
CNSTI4 2680
ADDP4
INDIRI4
ASGNI4
line 3965
;3965:			bst->sagaState = bs->sagaState;
ADDRLP4 156
CNSTI4 2680
ASGNI4
ADDRLP4 8
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
ADDRFP4 0
INDIRP4
ADDRLP4 156
INDIRI4
ADDP4
INDIRI4
ASGNI4
line 3966
;3966:			commanded++;
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3967
;3967:		}
LABELV $1621
line 3969
;3968:
;3969:		i++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 3970
;3970:	}
LABELV $1617
line 3953
ADDRLP4 4
INDIRI4
ADDRLP4 144
INDIRI4
GEI4 $1623
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1616
LABELV $1623
LABELV $1618
line 3971
;3971:}
LABELV $1602
endproc CommanderBotSagaAI 180 8
export BotDoTeamplayAI
proc BotDoTeamplayAI 4 0
line 3974
;3972:
;3973:void BotDoTeamplayAI(bot_state_t *bs)
;3974:{
line 3975
;3975:	if (bs->state_Forced)
ADDRFP4 0
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1625
line 3976
;3976:	{
line 3977
;3977:		bs->teamplayState = bs->state_Forced;
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 2684
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
ASGNI4
line 3978
;3978:	}
LABELV $1625
line 3980
;3979:
;3980:	if (bs->teamplayState == TEAMPLAYSTATE_REGROUP)
ADDRFP4 0
INDIRP4
CNSTI4 2684
ADDP4
INDIRI4
CNSTI4 3
NEI4 $1627
line 3981
;3981:	{ //force to find a new leader
line 3982
;3982:		bs->squadLeader = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
CNSTP4 0
ASGNP4
line 3983
;3983:		bs->isSquadLeader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 0
ASGNI4
line 3984
;3984:	}
LABELV $1627
line 3985
;3985:}
LABELV $1624
endproc BotDoTeamplayAI 4 0
export CommanderBotTeamplayAI
proc CommanderBotTeamplayAI 188 8
line 3988
;3986:
;3987:void CommanderBotTeamplayAI(bot_state_t *bs)
;3988:{
line 3989
;3989:	int i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 3990
;3990:	int squadmates = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 3991
;3991:	int teammates = 0;
ADDRLP4 160
CNSTI4 0
ASGNI4
line 3992
;3992:	int teammate_indanger = -1;
ADDRLP4 144
CNSTI4 -1
ASGNI4
line 3993
;3993:	int teammate_helped = 0;
ADDRLP4 148
CNSTI4 0
ASGNI4
line 3994
;3994:	int foundsquadleader = 0;
ADDRLP4 156
CNSTI4 0
ASGNI4
line 3995
;3995:	int worsthealth = 50;
ADDRLP4 152
CNSTI4 50
ASGNI4
ADDRGP4 $1631
JUMPV
LABELV $1630
line 4001
;3996:	gentity_t *squad[MAX_CLIENTS];
;3997:	gentity_t *ent;
;3998:	bot_state_t *bst;
;3999:
;4000:	while (i < MAX_CLIENTS)
;4001:	{
line 4002
;4002:		ent = &g_entities[i];
ADDRLP4 0
CNSTI4 828
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4004
;4003:
;4004:		if (ent && ent->client && OnSameTeam(&g_entities[bs->client], ent) && botstates[ent->s.number])
ADDRLP4 168
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $1633
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 168
INDIRU4
EQU4 $1633
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 172
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 172
INDIRI4
CNSTI4 0
EQI4 $1633
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1633
line 4005
;4005:		{
line 4006
;4006:			bst = botstates[ent->s.number];
ADDRLP4 4
ADDRLP4 0
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 4008
;4007:
;4008:			if (foundsquadleader && bst && bst->isSquadLeader)
ADDRLP4 176
CNSTI4 0
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 176
INDIRI4
EQI4 $1635
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1635
ADDRLP4 4
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
ADDRLP4 176
INDIRI4
EQI4 $1635
line 4009
;4009:			{ //never more than one squad leader
line 4010
;4010:				bst->isSquadLeader = 0;
ADDRLP4 4
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 0
ASGNI4
line 4011
;4011:			}
LABELV $1635
line 4013
;4012:
;4013:			if (bst && !bst->isSquadLeader)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1637
ADDRLP4 4
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1637
line 4014
;4014:			{
line 4015
;4015:				squad[squadmates] = ent;
ADDRLP4 140
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
ADDRLP4 0
INDIRP4
ASGNP4
line 4016
;4016:				squadmates++;
ADDRLP4 140
ADDRLP4 140
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4017
;4017:			}
ADDRGP4 $1638
JUMPV
LABELV $1637
line 4018
;4018:			else if (bst)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1639
line 4019
;4019:			{
line 4020
;4020:				foundsquadleader = 1;
ADDRLP4 156
CNSTI4 1
ASGNI4
line 4021
;4021:			}
LABELV $1639
LABELV $1638
line 4022
;4022:		}
LABELV $1633
line 4024
;4023:
;4024:		if (ent && ent->client && OnSameTeam(&g_entities[bs->client], ent))
ADDRLP4 180
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 180
INDIRU4
EQU4 $1641
ADDRLP4 0
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 180
INDIRU4
EQU4 $1641
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 184
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 0
EQI4 $1641
line 4025
;4025:		{
line 4026
;4026:			teammates++;
ADDRLP4 160
ADDRLP4 160
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4028
;4027:
;4028:			if (ent->health < worsthealth)
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ADDRLP4 152
INDIRI4
GEI4 $1643
line 4029
;4029:			{
line 4030
;4030:				teammate_indanger = ent->s.number;
ADDRLP4 144
ADDRLP4 0
INDIRP4
INDIRI4
ASGNI4
line 4031
;4031:				worsthealth = ent->health;
ADDRLP4 152
ADDRLP4 0
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ASGNI4
line 4032
;4032:			}
LABELV $1643
line 4033
;4033:		}
LABELV $1641
line 4035
;4034:
;4035:		i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4036
;4036:	}
LABELV $1631
line 4000
ADDRLP4 8
INDIRI4
CNSTI4 32
LTI4 $1630
line 4038
;4037:	
;4038:	if (!squadmates)
ADDRLP4 140
INDIRI4
CNSTI4 0
NEI4 $1645
line 4039
;4039:	{
line 4040
;4040:		return;
ADDRGP4 $1629
JUMPV
LABELV $1645
line 4043
;4041:	}
;4042:
;4043:	i = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRGP4 $1648
JUMPV
LABELV $1647
line 4046
;4044:
;4045:	while (i < squadmates && squad[i])
;4046:	{
line 4047
;4047:		bst = botstates[squad[i]->s.number];
ADDRLP4 164
CNSTI4 2
ASGNI4
ADDRLP4 4
ADDRLP4 8
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
INDIRI4
ADDRLP4 164
INDIRI4
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
line 4049
;4048:
;4049:		if (bst && !bst->state_Forced)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1650
ADDRLP4 4
INDIRP4
CNSTI4 2692
ADDP4
INDIRI4
CNSTI4 0
NEI4 $1650
line 4050
;4050:		{ //only order if this guy is not being ordered directly by the real player team leader
line 4051
;4051:			if (teammate_indanger >= 0 && !teammate_helped)
ADDRLP4 172
CNSTI4 0
ASGNI4
ADDRLP4 144
INDIRI4
ADDRLP4 172
INDIRI4
LTI4 $1652
ADDRLP4 148
INDIRI4
ADDRLP4 172
INDIRI4
NEI4 $1652
line 4052
;4052:			{ //send someone out to help whoever needs help most at the moment
line 4053
;4053:				bst->teamplayState = TEAMPLAYSTATE_ASSISTING;
ADDRLP4 4
INDIRP4
CNSTI4 2684
ADDP4
CNSTI4 2
ASGNI4
line 4054
;4054:				bst->squadLeader = &g_entities[teammate_indanger];
ADDRLP4 4
INDIRP4
CNSTI4 1812
ADDP4
CNSTI4 828
ADDRLP4 144
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4055
;4055:				teammate_helped = 1;
ADDRLP4 148
CNSTI4 1
ASGNI4
line 4056
;4056:			}
ADDRGP4 $1653
JUMPV
LABELV $1652
line 4057
;4057:			else if ((teammate_indanger == -1 || teammate_helped) && bst->teamplayState == TEAMPLAYSTATE_ASSISTING)
ADDRLP4 144
INDIRI4
CNSTI4 -1
EQI4 $1656
ADDRLP4 148
INDIRI4
CNSTI4 0
EQI4 $1654
LABELV $1656
ADDRLP4 4
INDIRP4
CNSTI4 2684
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1654
line 4058
;4058:			{ //no teammates need help badly, but this guy is trying to help them anyway, so stop
line 4059
;4059:				bst->teamplayState = TEAMPLAYSTATE_FOLLOWING;
ADDRLP4 4
INDIRP4
CNSTI4 2684
ADDP4
CNSTI4 1
ASGNI4
line 4060
;4060:				bst->squadLeader = &g_entities[bs->client];
ADDRLP4 4
INDIRP4
CNSTI4 1812
ADDP4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 4061
;4061:			}
LABELV $1654
LABELV $1653
line 4063
;4062:
;4063:			if (bs->squadRegroupInterval < level.time && Q_irand(1, 10) < 5)
ADDRFP4 0
INDIRP4
CNSTI4 1860
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1657
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 176
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 176
INDIRI4
CNSTI4 5
GEI4 $1657
line 4064
;4064:			{ //every so often tell the squad to regroup for the sake of variation
line 4065
;4065:				if (bst->teamplayState == TEAMPLAYSTATE_FOLLOWING)
ADDRLP4 4
INDIRP4
CNSTI4 2684
ADDP4
INDIRI4
CNSTI4 1
NEI4 $1660
line 4066
;4066:				{
line 4067
;4067:					bst->teamplayState = TEAMPLAYSTATE_REGROUP;
ADDRLP4 4
INDIRP4
CNSTI4 2684
ADDP4
CNSTI4 3
ASGNI4
line 4068
;4068:				}
LABELV $1660
line 4070
;4069:
;4070:				bs->isSquadLeader = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 0
ASGNI4
line 4071
;4071:				bs->squadCannotLead = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 1864
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 4072
;4072:				bs->squadRegroupInterval = level.time + Q_irand(45000, 65000);
CNSTI4 45000
ARGI4
CNSTI4 65000
ARGI4
ADDRLP4 180
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1860
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 180
INDIRI4
ADDI4
ASGNI4
line 4073
;4073:			}
LABELV $1657
line 4074
;4074:		}
LABELV $1650
line 4076
;4075:
;4076:		i++;
ADDRLP4 8
ADDRLP4 8
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4077
;4077:	}	
LABELV $1648
line 4045
ADDRLP4 8
INDIRI4
ADDRLP4 140
INDIRI4
GEI4 $1664
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1647
LABELV $1664
line 4078
;4078:}
LABELV $1629
endproc CommanderBotTeamplayAI 188 8
export CommanderBotAI
proc CommanderBotAI 0 4
line 4081
;4079:
;4080:void CommanderBotAI(bot_state_t *bs)
;4081:{
line 4082
;4082:	if (g_gametype.integer == GT_CTF || g_gametype.integer == GT_CTY)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 7
EQI4 $1670
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 8
NEI4 $1666
LABELV $1670
line 4083
;4083:	{
line 4084
;4084:		CommanderBotCTFAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CommanderBotCTFAI
CALLV
pop
line 4085
;4085:	}
ADDRGP4 $1667
JUMPV
LABELV $1666
line 4086
;4086:	else if (g_gametype.integer == GT_SAGA)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 6
NEI4 $1671
line 4087
;4087:	{
line 4088
;4088:		CommanderBotSagaAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CommanderBotSagaAI
CALLV
pop
line 4089
;4089:	}
ADDRGP4 $1672
JUMPV
LABELV $1671
line 4090
;4090:	else if (g_gametype.integer == GT_TEAM)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
NEI4 $1674
line 4091
;4091:	{
line 4092
;4092:		CommanderBotTeamplayAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CommanderBotTeamplayAI
CALLV
pop
line 4093
;4093:	}
LABELV $1674
LABELV $1672
LABELV $1667
line 4094
;4094:}
LABELV $1665
endproc CommanderBotAI 0 4
export MeleeCombatHandling
proc MeleeCombatHandling 1200 28
line 4097
;4095:
;4096:void MeleeCombatHandling(bot_state_t *bs)
;4097:{
line 4109
;4098:	vec3_t usethisvec;
;4099:	vec3_t downvec;
;4100:	vec3_t midorg;
;4101:	vec3_t a;
;4102:	vec3_t fwd;
;4103:	vec3_t mins, maxs;
;4104:	trace_t tr;
;4105:	int en_down;
;4106:	int me_down;
;4107:	int mid_down;
;4108:
;4109:	if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1678
line 4110
;4110:	{
line 4111
;4111:		return;
ADDRGP4 $1677
JUMPV
LABELV $1678
line 4114
;4112:	}
;4113:
;4114:	if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1680
line 4115
;4115:	{
line 4116
;4116:		VectorCopy(bs->currentEnemy->client->ps.origin, usethisvec);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4117
;4117:	}
ADDRGP4 $1681
JUMPV
LABELV $1680
line 4119
;4118:	else
;4119:	{
line 4120
;4120:		VectorCopy(bs->currentEnemy->s.origin, usethisvec);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4121
;4121:	}
LABELV $1681
line 4123
;4122:
;4123:	if (bs->meleeStrafeTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2240
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1682
line 4124
;4124:	{
line 4125
;4125:		if (bs->meleeStrafeDir)
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1685
line 4126
;4126:		{
line 4127
;4127:			bs->meleeStrafeDir = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
CNSTI4 0
ASGNI4
line 4128
;4128:		}
ADDRGP4 $1686
JUMPV
LABELV $1685
line 4130
;4129:		else
;4130:		{
line 4131
;4131:			bs->meleeStrafeDir = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
CNSTI4 1
ASGNI4
line 4132
;4132:		}
LABELV $1686
line 4134
;4133:
;4134:		bs->meleeStrafeTime = level.time + Q_irand(500, 1800);
CNSTI4 500
ARGI4
CNSTI4 1800
ARGI4
ADDRLP4 1176
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2240
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1176
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 4135
;4135:	}
LABELV $1682
line 4137
;4136:
;4137:	mins[0] = -15;
ADDRLP4 36
CNSTF4 3245342720
ASGNF4
line 4138
;4138:	mins[1] = -15;
ADDRLP4 36+4
CNSTF4 3245342720
ASGNF4
line 4139
;4139:	mins[2] = -24;
ADDRLP4 36+8
CNSTF4 3250585600
ASGNF4
line 4140
;4140:	maxs[0] = 15;
ADDRLP4 48
CNSTF4 1097859072
ASGNF4
line 4141
;4141:	maxs[1] = 15;
ADDRLP4 48+4
CNSTF4 1097859072
ASGNF4
line 4142
;4142:	maxs[2] = 32;
ADDRLP4 48+8
CNSTF4 1107296256
ASGNF4
line 4144
;4143:
;4144:	VectorCopy(usethisvec, downvec);
ADDRLP4 0
ADDRLP4 12
INDIRB
ASGNB 12
line 4145
;4145:	downvec[2] -= 4096;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4147
;4146:
;4147:	trap_Trace(&tr, usethisvec, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4149
;4148:
;4149:	en_down = (int)tr.endpos[2];
ADDRLP4 1164
ADDRLP4 60+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4151
;4150:
;4151:	VectorCopy(bs->origin, downvec);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 4152
;4152:	downvec[2] -= 4096;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4154
;4153:
;4154:	trap_Trace(&tr, bs->origin, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4156
;4155:
;4156:	me_down = (int)tr.endpos[2];
ADDRLP4 1168
ADDRLP4 60+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4158
;4157:
;4158:	VectorSubtract(usethisvec, bs->origin, a);
ADDRLP4 1176
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 12
INDIRF4
ADDRLP4 1176
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 1176
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 24+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4159
;4159:	vectoangles(a, a);
ADDRLP4 24
ARGP4
ADDRLP4 24
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4160
;4160:	AngleVectors(a, fwd, NULL, NULL);
ADDRLP4 24
ARGP4
ADDRLP4 1152
ARGP4
ADDRLP4 1180
CNSTP4 0
ASGNP4
ADDRLP4 1180
INDIRP4
ARGP4
ADDRLP4 1180
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4162
;4161:
;4162:	midorg[0] = bs->origin[0] + fwd[0]*bs->frame_Enemy_Len/2;
ADDRLP4 1184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
ADDRLP4 1184
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 1152
INDIRF4
ADDRLP4 1184
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4163
;4163:	midorg[1] = bs->origin[1] + fwd[1]*bs->frame_Enemy_Len/2;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140+4
ADDRLP4 1188
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 1152+4
INDIRF4
ADDRLP4 1188
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4164
;4164:	midorg[2] = bs->origin[2] + fwd[2]*bs->frame_Enemy_Len/2;
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140+8
ADDRLP4 1192
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 1152+8
INDIRF4
ADDRLP4 1192
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4166
;4165:
;4166:	VectorCopy(midorg, downvec);
ADDRLP4 0
ADDRLP4 1140
INDIRB
ASGNB 12
line 4167
;4167:	downvec[2] -= 4096;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4169
;4168:
;4169:	trap_Trace(&tr, midorg, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4171
;4170:
;4171:	mid_down = (int)tr.endpos[2];
ADDRLP4 1172
ADDRLP4 60+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4173
;4172:
;4173:	if (me_down == en_down &&
ADDRLP4 1168
INDIRI4
ADDRLP4 1164
INDIRI4
NEI4 $1709
ADDRLP4 1164
INDIRI4
ADDRLP4 1172
INDIRI4
NEI4 $1709
line 4175
;4174:		en_down == mid_down)
;4175:	{
line 4176
;4176:		VectorCopy(usethisvec, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 12
INDIRB
ASGNB 12
line 4177
;4177:	}
LABELV $1709
line 4178
;4178:}
LABELV $1677
endproc MeleeCombatHandling 1200 28
export SaberCombatHandling
proc SaberCombatHandling 1272 28
line 4181
;4179:
;4180:void SaberCombatHandling(bot_state_t *bs)
;4181:{
line 4193
;4182:	vec3_t usethisvec;
;4183:	vec3_t downvec;
;4184:	vec3_t midorg;
;4185:	vec3_t a;
;4186:	vec3_t fwd;
;4187:	vec3_t mins, maxs;
;4188:	trace_t tr;
;4189:	int en_down;
;4190:	int me_down;
;4191:	int mid_down;
;4192:
;4193:	if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1712
line 4194
;4194:	{
line 4195
;4195:		return;
ADDRGP4 $1711
JUMPV
LABELV $1712
line 4198
;4196:	}
;4197:
;4198:	if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1714
line 4199
;4199:	{
line 4200
;4200:		VectorCopy(bs->currentEnemy->client->ps.origin, usethisvec);
ADDRLP4 1092
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4201
;4201:	}
ADDRGP4 $1715
JUMPV
LABELV $1714
line 4203
;4202:	else
;4203:	{
line 4204
;4204:		VectorCopy(bs->currentEnemy->s.origin, usethisvec);
ADDRLP4 1092
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4205
;4205:	}
LABELV $1715
line 4207
;4206:
;4207:	if (bs->meleeStrafeTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2240
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1716
line 4208
;4208:	{
line 4209
;4209:		if (bs->meleeStrafeDir)
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1719
line 4210
;4210:		{
line 4211
;4211:			bs->meleeStrafeDir = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
CNSTI4 0
ASGNI4
line 4212
;4212:		}
ADDRGP4 $1720
JUMPV
LABELV $1719
line 4214
;4213:		else
;4214:		{
line 4215
;4215:			bs->meleeStrafeDir = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
CNSTI4 1
ASGNI4
line 4216
;4216:		}
LABELV $1720
line 4218
;4217:
;4218:		bs->meleeStrafeTime = level.time + Q_irand(500, 1800);
CNSTI4 500
ARGI4
CNSTI4 1800
ARGI4
ADDRLP4 1176
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2240
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1176
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 4219
;4219:	}
LABELV $1716
line 4221
;4220:
;4221:	mins[0] = -15;
ADDRLP4 1116
CNSTF4 3245342720
ASGNF4
line 4222
;4222:	mins[1] = -15;
ADDRLP4 1116+4
CNSTF4 3245342720
ASGNF4
line 4223
;4223:	mins[2] = -24;
ADDRLP4 1116+8
CNSTF4 3250585600
ASGNF4
line 4224
;4224:	maxs[0] = 15;
ADDRLP4 1128
CNSTF4 1097859072
ASGNF4
line 4225
;4225:	maxs[1] = 15;
ADDRLP4 1128+4
CNSTF4 1097859072
ASGNF4
line 4226
;4226:	maxs[2] = 32;
ADDRLP4 1128+8
CNSTF4 1107296256
ASGNF4
line 4228
;4227:
;4228:	VectorCopy(usethisvec, downvec);
ADDRLP4 1080
ADDRLP4 1092
INDIRB
ASGNB 12
line 4229
;4229:	downvec[2] -= 4096;
ADDRLP4 1080+8
ADDRLP4 1080+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4231
;4230:
;4231:	trap_Trace(&tr, usethisvec, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRLP4 1092
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4233
;4232:
;4233:	en_down = (int)tr.endpos[2];
ADDRLP4 1164
ADDRLP4 0+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4235
;4234:
;4235:	if (tr.startsolid || tr.allsolid)
ADDRLP4 1176
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 1176
INDIRI4
NEI4 $1732
ADDRLP4 0
INDIRI4
ADDRLP4 1176
INDIRI4
EQI4 $1729
LABELV $1732
line 4236
;4236:	{
line 4237
;4237:		en_down = 1;
ADDRLP4 1164
CNSTI4 1
ASGNI4
line 4238
;4238:		me_down = 2;
ADDRLP4 1168
CNSTI4 2
ASGNI4
line 4239
;4239:	}
ADDRGP4 $1730
JUMPV
LABELV $1729
line 4241
;4240:	else
;4241:	{
line 4242
;4242:		VectorCopy(bs->origin, downvec);
ADDRLP4 1080
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 4243
;4243:		downvec[2] -= 4096;
ADDRLP4 1080+8
ADDRLP4 1080+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4245
;4244:
;4245:		trap_Trace(&tr, bs->origin, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4247
;4246:
;4247:		me_down = (int)tr.endpos[2];
ADDRLP4 1168
ADDRLP4 0+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4249
;4248:
;4249:		if (tr.startsolid || tr.allsolid)
ADDRLP4 1180
CNSTI4 0
ASGNI4
ADDRLP4 0+4
INDIRI4
ADDRLP4 1180
INDIRI4
NEI4 $1739
ADDRLP4 0
INDIRI4
ADDRLP4 1180
INDIRI4
EQI4 $1736
LABELV $1739
line 4250
;4250:		{
line 4251
;4251:			en_down = 1;
ADDRLP4 1164
CNSTI4 1
ASGNI4
line 4252
;4252:			me_down = 2;
ADDRLP4 1168
CNSTI4 2
ASGNI4
line 4253
;4253:		}
LABELV $1736
line 4254
;4254:	}
LABELV $1730
line 4256
;4255:
;4256:	VectorSubtract(usethisvec, bs->origin, a);
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1104
ADDRLP4 1092
INDIRF4
ADDRLP4 1180
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1104+4
ADDRLP4 1092+4
INDIRF4
ADDRLP4 1180
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1104+8
ADDRLP4 1092+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4257
;4257:	vectoangles(a, a);
ADDRLP4 1104
ARGP4
ADDRLP4 1104
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4258
;4258:	AngleVectors(a, fwd, NULL, NULL);
ADDRLP4 1104
ARGP4
ADDRLP4 1152
ARGP4
ADDRLP4 1184
CNSTP4 0
ASGNP4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRLP4 1184
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4260
;4259:
;4260:	midorg[0] = bs->origin[0] + fwd[0]*bs->frame_Enemy_Len/2;
ADDRLP4 1188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
ADDRLP4 1188
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 1152
INDIRF4
ADDRLP4 1188
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4261
;4261:	midorg[1] = bs->origin[1] + fwd[1]*bs->frame_Enemy_Len/2;
ADDRLP4 1192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140+4
ADDRLP4 1192
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 1152+4
INDIRF4
ADDRLP4 1192
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4262
;4262:	midorg[2] = bs->origin[2] + fwd[2]*bs->frame_Enemy_Len/2;
ADDRLP4 1196
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140+8
ADDRLP4 1196
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 1152+8
INDIRF4
ADDRLP4 1196
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
CNSTF4 1073741824
DIVF4
ADDF4
ASGNF4
line 4264
;4263:
;4264:	VectorCopy(midorg, downvec);
ADDRLP4 1080
ADDRLP4 1140
INDIRB
ASGNB 12
line 4265
;4265:	downvec[2] -= 4096;
ADDRLP4 1080+8
ADDRLP4 1080+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 4267
;4266:
;4267:	trap_Trace(&tr, midorg, mins, maxs, downvec, -1, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRLP4 1140
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1080
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4269
;4268:
;4269:	mid_down = (int)tr.endpos[2];
ADDRLP4 1172
ADDRLP4 0+12+8
INDIRF4
CVFI4 4
ASGNI4
line 4271
;4270:
;4271:	if (me_down == en_down &&
ADDRLP4 1168
INDIRI4
ADDRLP4 1164
INDIRI4
NEI4 $1751
ADDRLP4 1164
INDIRI4
ADDRLP4 1172
INDIRI4
NEI4 $1751
line 4273
;4272:		en_down == mid_down)
;4273:	{
line 4274
;4274:		if (usethisvec[2] > (bs->origin[2]+32) &&
ADDRLP4 1204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1092+8
INDIRF4
ADDRLP4 1204
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1107296256
ADDF4
LEF4 $1753
ADDRLP4 1208
ADDRLP4 1204
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1208
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1753
ADDRLP4 1208
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $1753
line 4277
;4275:			bs->currentEnemy->client &&
;4276:			bs->currentEnemy->client->ps.groundEntityNum == ENTITYNUM_NONE)
;4277:		{
line 4278
;4278:			bs->jumpTime = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 4279
;4279:		}
LABELV $1753
line 4281
;4280:
;4281:		if (bs->frame_Enemy_Len > 128)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1124073472
LEF4 $1757
line 4282
;4282:		{ //be ready to attack
line 4283
;4283:			bs->saberDefending = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2696
ADDP4
CNSTI4 0
ASGNI4
line 4284
;4284:			bs->saberDefendDecideTime = level.time + Q_irand(1000, 2000);
CNSTI4 1000
ARGI4
CNSTI4 2000
ARGI4
ADDRLP4 1212
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2700
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1212
INDIRI4
ADDI4
ASGNI4
line 4285
;4285:		}
ADDRGP4 $1758
JUMPV
LABELV $1757
line 4287
;4286:		else
;4287:		{
line 4288
;4288:			if (bs->saberDefendDecideTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2700
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1760
line 4289
;4289:			{
line 4290
;4290:				if (bs->saberDefending)
ADDRFP4 0
INDIRP4
CNSTI4 2696
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1763
line 4291
;4291:				{
line 4292
;4292:					bs->saberDefending = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2696
ADDP4
CNSTI4 0
ASGNI4
line 4293
;4293:				}
ADDRGP4 $1764
JUMPV
LABELV $1763
line 4295
;4294:				else
;4295:				{
line 4296
;4296:					bs->saberDefending = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2696
ADDP4
CNSTI4 1
ASGNI4
line 4297
;4297:				}
LABELV $1764
line 4299
;4298:
;4299:				bs->saberDefendDecideTime = level.time + Q_irand(500, 2000);
CNSTI4 500
ARGI4
CNSTI4 2000
ARGI4
ADDRLP4 1212
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2700
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1212
INDIRI4
ADDI4
ASGNI4
line 4300
;4300:			}
LABELV $1760
line 4301
;4301:		}
LABELV $1758
line 4303
;4302:
;4303:		if (bs->frame_Enemy_Len < 54)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1113063424
GEF4 $1766
line 4304
;4304:		{
line 4305
;4305:			VectorCopy(bs->origin, bs->goalPosition);
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 1212
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 4306
;4306:			bs->saberBFTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2704
ADDP4
CNSTI4 0
ASGNI4
line 4307
;4307:		}
ADDRGP4 $1767
JUMPV
LABELV $1766
line 4309
;4308:		else
;4309:		{
line 4310
;4310:			VectorCopy(usethisvec, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 1092
INDIRB
ASGNB 12
line 4311
;4311:		}
LABELV $1767
line 4313
;4312:
;4313:		if (bs->frame_Enemy_Len > 90 && bs->saberBFTime > level.time && bs->saberBTime > level.time && bs->beStill < level.time && bs->saberSTime < level.time)
ADDRLP4 1212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1212
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1119092736
LEF4 $1768
ADDRLP4 1212
INDIRP4
CNSTI4 2704
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1768
ADDRLP4 1212
INDIRP4
CNSTI4 2708
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1768
ADDRLP4 1212
INDIRP4
CNSTI4 1992
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $1768
ADDRLP4 1212
INDIRP4
CNSTI4 2712
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1768
line 4314
;4314:		{
line 4315
;4315:			bs->beStill = level.time + Q_irand(500, 1000);
CNSTI4 500
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 1216
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1216
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 4316
;4316:			bs->saberSTime = level.time + Q_irand(1200, 1800);
CNSTI4 1200
ARGI4
CNSTI4 1800
ARGI4
ADDRLP4 1220
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2712
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1220
INDIRI4
ADDI4
ASGNI4
line 4317
;4317:		}
ADDRGP4 $1752
JUMPV
LABELV $1768
line 4318
;4318:		else if (bs->currentEnemy->client->ps.weapon == WP_SABER && bs->frame_Enemy_Len < 80 && (Q_irand(1, 10) < 8 && bs->saberBFTime < level.time) || bs->saberBTime > level.time)
ADDRLP4 1216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1216
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1783
ADDRLP4 1216
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1117782016
GEF4 $1783
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 1220
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 1220
INDIRI4
CNSTI4 8
GEI4 $1783
ADDRFP4 0
INDIRP4
CNSTI4 2704
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LTI4 $1780
LABELV $1783
ADDRFP4 0
INDIRP4
CNSTI4 2708
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $1776
LABELV $1780
line 4319
;4319:		{
line 4323
;4320:			vec3_t vs;
;4321:			vec3_t groundcheck;
;4322:
;4323:			VectorSubtract(bs->origin, usethisvec, vs);
ADDRLP4 1248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1224
ADDRLP4 1248
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 1092
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1224+4
ADDRLP4 1248
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 1092+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1224+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 1092+8
INDIRF4
SUBF4
ASGNF4
line 4324
;4324:			VectorNormalize(vs);
ADDRLP4 1224
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4326
;4325:
;4326:			bs->goalPosition[0] = bs->origin[0] + vs[0]*64;
ADDRLP4 1252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1252
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 1252
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 1224
INDIRF4
MULF4
ADDF4
ASGNF4
line 4327
;4327:			bs->goalPosition[1] = bs->origin[1] + vs[1]*64;
ADDRLP4 1256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1256
INDIRP4
CNSTI4 1912
ADDP4
ADDRLP4 1256
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 1224+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 4328
;4328:			bs->goalPosition[2] = bs->origin[2] + vs[2]*64;
ADDRLP4 1260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1260
INDIRP4
CNSTI4 1916
ADDP4
ADDRLP4 1260
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 1224+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4330
;4329:
;4330:			if (bs->saberBTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2708
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $1790
line 4331
;4331:			{
line 4332
;4332:				bs->saberBFTime = level.time + Q_irand(900, 1300);
CNSTI4 900
ARGI4
CNSTI4 1300
ARGI4
ADDRLP4 1264
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2704
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1264
INDIRI4
ADDI4
ASGNI4
line 4333
;4333:				bs->saberBTime = level.time + Q_irand(300, 700);
CNSTI4 300
ARGI4
CNSTI4 700
ARGI4
ADDRLP4 1268
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2708
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1268
INDIRI4
ADDI4
ASGNI4
line 4334
;4334:			}
LABELV $1790
line 4336
;4335:
;4336:			VectorCopy(bs->goalPosition, groundcheck);
ADDRLP4 1236
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
INDIRB
ASGNB 12
line 4338
;4337:
;4338:			groundcheck[2] -= 64;
ADDRLP4 1236+8
ADDRLP4 1236+8
INDIRF4
CNSTF4 1115684864
SUBF4
ASGNF4
line 4340
;4339:
;4340:			trap_Trace(&tr, bs->goalPosition, NULL, NULL, groundcheck, bs->client, MASK_SOLID);
ADDRLP4 0
ARGP4
ADDRLP4 1264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1264
INDIRP4
CNSTI4 1908
ADDP4
ARGP4
ADDRLP4 1268
CNSTP4 0
ASGNP4
ADDRLP4 1268
INDIRP4
ARGP4
ADDRLP4 1268
INDIRP4
ARGP4
ADDRLP4 1236
ARGP4
ADDRLP4 1264
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4342
;4341:			
;4342:			if (tr.fraction == 1.0)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
NEF4 $1752
line 4343
;4343:			{ //don't back off of a ledge
line 4344
;4344:				VectorCopy(usethisvec, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 1092
INDIRB
ASGNB 12
line 4345
;4345:			}
line 4346
;4346:		}
ADDRGP4 $1752
JUMPV
LABELV $1776
line 4347
;4347:		else if (bs->currentEnemy->client->ps.weapon == WP_SABER && bs->frame_Enemy_Len >= 75)
ADDRLP4 1224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1224
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
CNSTI4 2
NEI4 $1752
ADDRLP4 1224
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1117126656
LTF4 $1752
line 4348
;4348:		{
line 4349
;4349:			bs->saberBFTime = level.time + Q_irand(700, 1300);
CNSTI4 700
ARGI4
CNSTI4 1300
ARGI4
ADDRLP4 1228
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2704
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1228
INDIRI4
ADDI4
ASGNI4
line 4350
;4350:			bs->saberBTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2708
ADDP4
CNSTI4 0
ASGNI4
line 4351
;4351:		}
line 4367
;4352:
;4353:		/*AngleVectors(bs->viewangles, NULL, fwd, NULL);
;4354:
;4355:		if (bs->meleeStrafeDir)
;4356:		{
;4357:			bs->goalPosition[0] += fwd[0]*16;
;4358:			bs->goalPosition[1] += fwd[1]*16;
;4359:			bs->goalPosition[2] += fwd[2]*16;
;4360:		}
;4361:		else
;4362:		{
;4363:			bs->goalPosition[0] -= fwd[0]*16;
;4364:			bs->goalPosition[1] -= fwd[1]*16;
;4365:			bs->goalPosition[2] -= fwd[2]*16;
;4366:		}*/
;4367:	}
ADDRGP4 $1752
JUMPV
LABELV $1751
line 4368
;4368:	else if (bs->frame_Enemy_Len <= 56)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1113587712
GTF4 $1802
line 4369
;4369:	{
line 4370
;4370:		bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4371
;4371:		bs->saberDefending = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2696
ADDP4
CNSTI4 0
ASGNI4
line 4372
;4372:	}
LABELV $1802
LABELV $1752
line 4373
;4373:}
LABELV $1711
endproc SaberCombatHandling 1272 28
export BotWeaponCanLead
proc BotWeaponCanLead 4 0
line 4376
;4374:
;4375:float BotWeaponCanLead(bot_state_t *bs)
;4376:{
line 4377
;4377:	int weap = bs->cur_ps.weapon;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 4379
;4378:
;4379:	if (weap == WP_BRYAR_PISTOL)
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $1805
line 4380
;4380:	{
line 4381
;4381:		return 0.5;
CNSTF4 1056964608
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1805
line 4383
;4382:	}
;4383:	if (weap == WP_BLASTER)
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1807
line 4384
;4384:	{
line 4385
;4385:		return 0.35;
CNSTF4 1051931443
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1807
line 4387
;4386:	}
;4387:	if (weap == WP_BOWCASTER)
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $1809
line 4388
;4388:	{
line 4389
;4389:		return 0.5;
CNSTF4 1056964608
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1809
line 4391
;4390:	}
;4391:	if (weap == WP_REPEATER)
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $1811
line 4392
;4392:	{
line 4393
;4393:		return 0.45;
CNSTF4 1055286886
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1811
line 4395
;4394:	}
;4395:	if (weap == WP_THERMAL)
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $1813
line 4396
;4396:	{
line 4397
;4397:		return 0.5;
CNSTF4 1056964608
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1813
line 4399
;4398:	}
;4399:	if (weap == WP_DEMP2)
ADDRLP4 0
INDIRI4
CNSTI4 8
NEI4 $1815
line 4400
;4400:	{
line 4401
;4401:		return 0.35;
CNSTF4 1051931443
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1815
line 4403
;4402:	}
;4403:	if (weap == WP_ROCKET_LAUNCHER)
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $1817
line 4404
;4404:	{
line 4405
;4405:		return 0.7;
CNSTF4 1060320051
RETF4
ADDRGP4 $1804
JUMPV
LABELV $1817
line 4408
;4406:	}
;4407:	
;4408:	return 0;
CNSTF4 0
RETF4
LABELV $1804
endproc BotWeaponCanLead 4 0
export BotAimLeading
proc BotAimLeading 68 8
line 4412
;4409:}
;4410:
;4411:void BotAimLeading(bot_state_t *bs, vec3_t headlevel, float leadAmount)
;4412:{
line 4419
;4413:	int x;
;4414:	vec3_t predictedSpot;
;4415:	vec3_t movementVector;
;4416:	vec3_t a, ang;
;4417:	float vtotal;
;4418:
;4419:	if (!bs->currentEnemy ||
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 60
CNSTU4 0
ASGNU4
ADDRLP4 56
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRU4
EQU4 $1822
ADDRLP4 56
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 60
INDIRU4
NEU4 $1820
LABELV $1822
line 4421
;4420:		!bs->currentEnemy->client)
;4421:	{
line 4422
;4422:		return;
ADDRGP4 $1819
JUMPV
LABELV $1820
line 4425
;4423:	}
;4424:
;4425:	if (!bs->frame_Enemy_Len)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 0
NEF4 $1823
line 4426
;4426:	{
line 4427
;4427:		return;
ADDRGP4 $1819
JUMPV
LABELV $1823
line 4430
;4428:	}
;4429:
;4430:	vtotal = 0;
ADDRLP4 0
CNSTF4 0
ASGNF4
line 4432
;4431:
;4432:	if (bs->currentEnemy->client->ps.velocity[0] < 0)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1825
line 4433
;4433:	{
line 4434
;4434:		vtotal += -bs->currentEnemy->client->ps.velocity[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
NEGF4
ADDF4
ASGNF4
line 4435
;4435:	}
ADDRGP4 $1826
JUMPV
LABELV $1825
line 4437
;4436:	else
;4437:	{
line 4438
;4438:		vtotal += bs->currentEnemy->client->ps.velocity[0];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4439
;4439:	}
LABELV $1826
line 4441
;4440:
;4441:	if (bs->currentEnemy->client->ps.velocity[1] < 0)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1827
line 4442
;4442:	{
line 4443
;4443:		vtotal += -bs->currentEnemy->client->ps.velocity[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
NEGF4
ADDF4
ASGNF4
line 4444
;4444:	}
ADDRGP4 $1828
JUMPV
LABELV $1827
line 4446
;4445:	else
;4446:	{
line 4447
;4447:		vtotal += bs->currentEnemy->client->ps.velocity[1];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4448
;4448:	}
LABELV $1828
line 4450
;4449:
;4450:	if (bs->currentEnemy->client->ps.velocity[2] < 0)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1829
line 4451
;4451:	{
line 4452
;4452:		vtotal += -bs->currentEnemy->client->ps.velocity[2];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
NEGF4
ADDF4
ASGNF4
line 4453
;4453:	}
ADDRGP4 $1830
JUMPV
LABELV $1829
line 4455
;4454:	else
;4455:	{
line 4456
;4456:		vtotal += bs->currentEnemy->client->ps.velocity[2];
ADDRLP4 0
ADDRLP4 0
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4457
;4457:	}
LABELV $1830
line 4461
;4458:
;4459:	//G_Printf("Leadin target with a velocity total of %f\n", vtotal);
;4460:
;4461:	VectorCopy(bs->currentEnemy->client->ps.velocity, movementVector);
ADDRLP4 20
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRB
ASGNB 12
line 4463
;4462:
;4463:	VectorNormalize(movementVector);
ADDRLP4 20
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 4465
;4464:
;4465:	x = bs->frame_Enemy_Len*leadAmount; //hardly calculated with an exact science, but it works
ADDRLP4 16
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ADDRFP4 8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4467
;4466:
;4467:	if (vtotal > 400)
ADDRLP4 0
INDIRF4
CNSTF4 1137180672
LEF4 $1831
line 4468
;4468:	{
line 4469
;4469:		vtotal = 400;
ADDRLP4 0
CNSTF4 1137180672
ASGNF4
line 4470
;4470:	}
LABELV $1831
line 4472
;4471:
;4472:	if (vtotal)
ADDRLP4 0
INDIRF4
CNSTF4 0
EQF4 $1833
line 4473
;4473:	{
line 4474
;4474:		x = (bs->frame_Enemy_Len*0.9)*leadAmount*(vtotal*0.0012); //hardly calculated with an exact science, but it works
ADDRLP4 16
CNSTF4 1063675494
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
ADDRFP4 8
INDIRF4
MULF4
CNSTF4 983386450
ADDRLP4 0
INDIRF4
MULF4
MULF4
CVFI4 4
ASGNI4
line 4475
;4475:	}
ADDRGP4 $1834
JUMPV
LABELV $1833
line 4477
;4476:	else
;4477:	{
line 4478
;4478:		x = (bs->frame_Enemy_Len*0.9)*leadAmount; //hardly calculated with an exact science, but it works
ADDRLP4 16
CNSTF4 1063675494
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
MULF4
ADDRFP4 8
INDIRF4
MULF4
CVFI4 4
ASGNI4
line 4479
;4479:	}
LABELV $1834
line 4481
;4480:
;4481:	predictedSpot[0] = headlevel[0] + (movementVector[0]*x);
ADDRLP4 4
ADDRFP4 4
INDIRP4
INDIRF4
ADDRLP4 20
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4482
;4482:	predictedSpot[1] = headlevel[1] + (movementVector[1]*x);
ADDRLP4 4+4
ADDRFP4 4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 20+4
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4483
;4483:	predictedSpot[2] = headlevel[2] + (movementVector[2]*x);
ADDRLP4 4+8
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 20+8
INDIRF4
ADDRLP4 16
INDIRI4
CVIF4 4
MULF4
ADDF4
ASGNF4
line 4485
;4484:
;4485:	VectorSubtract(predictedSpot, bs->eye, a);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 4+4
INDIRF4
ADDRLP4 64
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+8
ADDRLP4 4+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4486
;4486:	vectoangles(a, ang);
ADDRLP4 32
ARGP4
ADDRLP4 44
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4487
;4487:	VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 44
INDIRB
ASGNB 12
line 4488
;4488:}
LABELV $1819
endproc BotAimLeading 68 8
export BotAimOffsetGoalAngles
proc BotAimOffsetGoalAngles 56 8
line 4491
;4489:
;4490:void BotAimOffsetGoalAngles(bot_state_t *bs)
;4491:{
line 4494
;4492:	int i;
;4493:	float accVal;
;4494:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 4496
;4495:
;4496:	if (bs->skills.perfectaim)
ADDRFP4 0
INDIRP4
CNSTI4 2324
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1844
line 4497
;4497:	{
line 4498
;4498:		return;
ADDRGP4 $1843
JUMPV
LABELV $1844
line 4501
;4499:	}
;4500:
;4501:	if (bs->aimOffsetTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2020
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $1846
line 4502
;4502:	{
line 4503
;4503:		if (bs->aimOffsetAmtYaw)
ADDRFP4 0
INDIRP4
CNSTI4 2024
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1849
line 4504
;4504:		{
line 4505
;4505:			bs->goalAngles[YAW] += bs->aimOffsetAmtYaw;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 1888
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 2024
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4506
;4506:		}
LABELV $1849
line 4508
;4507:
;4508:		if (bs->aimOffsetAmtPitch)
ADDRFP4 0
INDIRP4
CNSTI4 2028
ADDP4
INDIRF4
CNSTF4 0
EQF4 $1854
line 4509
;4509:		{
line 4510
;4510:			bs->goalAngles[PITCH] += bs->aimOffsetAmtPitch;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
ADDRLP4 8
INDIRP4
CNSTI4 1884
ADDP4
ASGNP4
ADDRLP4 12
INDIRP4
ADDRLP4 12
INDIRP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 2028
ADDP4
INDIRF4
ADDF4
ASGNF4
line 4511
;4511:		}
ADDRGP4 $1854
JUMPV
LABELV $1853
line 4514
;4512:		
;4513:		while (i <= 2)
;4514:		{
line 4515
;4515:			if (bs->goalAngles[i] > 360)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDP4
INDIRF4
CNSTF4 1135869952
LEF4 $1856
line 4516
;4516:			{
line 4517
;4517:				bs->goalAngles[i] -= 360;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1135869952
SUBF4
ASGNF4
line 4518
;4518:			}
LABELV $1856
line 4520
;4519:
;4520:			if (bs->goalAngles[i] < 0)
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDP4
INDIRF4
CNSTF4 0
GEF4 $1858
line 4521
;4521:			{
line 4522
;4522:				bs->goalAngles[i] += 360;
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRF4
CNSTF4 1135869952
ADDF4
ASGNF4
line 4523
;4523:			}
LABELV $1858
line 4525
;4524:
;4525:			i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4526
;4526:		}
LABELV $1854
line 4513
ADDRLP4 0
INDIRI4
CNSTI4 2
LEI4 $1853
line 4527
;4527:		return;
ADDRGP4 $1843
JUMPV
LABELV $1846
line 4530
;4528:	}
;4529:
;4530:	accVal = bs->skills.accuracy/bs->settings.skill;
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 8
INDIRP4
CNSTI4 2308
ADDP4
INDIRF4
ADDRLP4 8
INDIRP4
CNSTI4 1556
ADDP4
INDIRF4
DIVF4
ASGNF4
line 4532
;4531:
;4532:	if (bs->currentEnemy && BotMindTricked(bs->client, bs->currentEnemy->s.number))
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRLP4 12
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1860
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
INDIRI4
ARGI4
ADDRLP4 20
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
EQI4 $1860
line 4533
;4533:	{ //having to judge where they are by hearing them, so we should be quite inaccurate here
line 4534
;4534:		accVal *= 7;
ADDRLP4 4
CNSTF4 1088421888
ADDRLP4 4
INDIRF4
MULF4
ASGNF4
line 4536
;4535:
;4536:		if (accVal < 30)
ADDRLP4 4
INDIRF4
CNSTF4 1106247680
GEF4 $1862
line 4537
;4537:		{
line 4538
;4538:			accVal = 30;
ADDRLP4 4
CNSTF4 1106247680
ASGNF4
line 4539
;4539:		}
LABELV $1862
line 4540
;4540:	}
LABELV $1860
line 4542
;4541:
;4542:	if (bs->revengeEnemy && bs->revengeHateLevel &&
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
ADDRLP4 24
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 28
INDIRU4
CNSTU4 0
EQU4 $1864
ADDRLP4 24
INDIRP4
CNSTI4 1852
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1864
ADDRLP4 24
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
NEU4 $1864
line 4544
;4543:		bs->currentEnemy == bs->revengeEnemy)
;4544:	{ //bot becomes more skilled as anger level raises
line 4545
;4545:		accVal = accVal/bs->revengeHateLevel;
ADDRLP4 4
ADDRLP4 4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1852
ADDP4
INDIRI4
CVIF4 4
DIVF4
ASGNF4
line 4546
;4546:	}
LABELV $1864
line 4548
;4547:
;4548:	if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1866
ADDRLP4 32
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1866
line 4549
;4549:	{ //assume our goal is aiming at the enemy, seeing as he's visible and all
line 4550
;4550:		if (!bs->currentEnemy->s.pos.trDelta[0] &&
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTF4 0
ASGNF4
ADDRLP4 36
INDIRP4
CNSTI4 36
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
NEF4 $1868
ADDRLP4 36
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
NEF4 $1868
ADDRLP4 36
INDIRP4
CNSTI4 44
ADDP4
INDIRF4
ADDRLP4 40
INDIRF4
NEF4 $1868
line 4553
;4551:			!bs->currentEnemy->s.pos.trDelta[1] &&
;4552:			!bs->currentEnemy->s.pos.trDelta[2])
;4553:		{
line 4554
;4554:			accVal = 0; //he's not even moving, so he shouldn't really be hard to hit.
ADDRLP4 4
CNSTF4 0
ASGNF4
line 4555
;4555:		}
ADDRGP4 $1869
JUMPV
LABELV $1868
line 4557
;4556:		else
;4557:		{
line 4558
;4558:			accVal += accVal*0.25; //if he's moving he's this much harder to hit
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1048576000
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 4559
;4559:		}
LABELV $1869
line 4561
;4560:
;4561:		if (g_entities[bs->client].s.pos.trDelta[0] ||
ADDRLP4 44
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 48
CNSTF4 0
ASGNF4
ADDRLP4 44
INDIRI4
ADDRGP4 g_entities+12+24
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
NEF4 $1881
ADDRLP4 44
INDIRI4
ADDRGP4 g_entities+12+24+4
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
NEF4 $1881
ADDRLP4 44
INDIRI4
ADDRGP4 g_entities+12+24+8
ADDP4
INDIRF4
ADDRLP4 48
INDIRF4
EQF4 $1870
LABELV $1881
line 4564
;4562:			g_entities[bs->client].s.pos.trDelta[1] ||
;4563:			g_entities[bs->client].s.pos.trDelta[2])
;4564:		{
line 4565
;4565:			accVal += accVal*0.15; //make it somewhat harder to aim if we're moving also
ADDRLP4 4
ADDRLP4 4
INDIRF4
CNSTF4 1041865114
ADDRLP4 4
INDIRF4
MULF4
ADDF4
ASGNF4
line 4566
;4566:		}
LABELV $1870
line 4567
;4567:	}
LABELV $1866
line 4569
;4568:
;4569:	if (accVal > 90)
ADDRLP4 4
INDIRF4
CNSTF4 1119092736
LEF4 $1882
line 4570
;4570:	{
line 4571
;4571:		accVal = 90;
ADDRLP4 4
CNSTF4 1119092736
ASGNF4
line 4572
;4572:	}
LABELV $1882
line 4573
;4573:	if (accVal < 1)
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
GEF4 $1884
line 4574
;4574:	{
line 4575
;4575:		accVal = 0;
ADDRLP4 4
CNSTF4 0
ASGNF4
line 4576
;4576:	}
LABELV $1884
line 4578
;4577:
;4578:	if (!accVal)
ADDRLP4 4
INDIRF4
CNSTF4 0
NEF4 $1886
line 4579
;4579:	{
line 4580
;4580:		bs->aimOffsetAmtYaw = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2024
ADDP4
CNSTF4 0
ASGNF4
line 4581
;4581:		bs->aimOffsetAmtPitch = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2028
ADDP4
CNSTF4 0
ASGNF4
line 4582
;4582:		return;
ADDRGP4 $1843
JUMPV
LABELV $1886
line 4585
;4583:	}
;4584:
;4585:	if (rand()%10 <= 5)
ADDRLP4 36
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 10
MODI4
CNSTI4 5
GTI4 $1888
line 4586
;4586:	{
line 4587
;4587:		bs->aimOffsetAmtYaw = rand()%(int)accVal;
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2024
ADDP4
ADDRLP4 40
INDIRI4
ADDRLP4 4
INDIRF4
CVFI4 4
MODI4
CVIF4 4
ASGNF4
line 4588
;4588:	}
ADDRGP4 $1889
JUMPV
LABELV $1888
line 4590
;4589:	else
;4590:	{
line 4591
;4591:		bs->aimOffsetAmtYaw = -(rand()%(int)accVal);
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2024
ADDP4
ADDRLP4 40
INDIRI4
ADDRLP4 4
INDIRF4
CVFI4 4
MODI4
NEGI4
CVIF4 4
ASGNF4
line 4592
;4592:	}
LABELV $1889
line 4594
;4593:
;4594:	if (rand()%10 <= 5)
ADDRLP4 40
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 10
MODI4
CNSTI4 5
GTI4 $1890
line 4595
;4595:	{
line 4596
;4596:		bs->aimOffsetAmtPitch = rand()%(int)accVal;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2028
ADDP4
ADDRLP4 44
INDIRI4
ADDRLP4 4
INDIRF4
CVFI4 4
MODI4
CVIF4 4
ASGNF4
line 4597
;4597:	}
ADDRGP4 $1891
JUMPV
LABELV $1890
line 4599
;4598:	else
;4599:	{
line 4600
;4600:		bs->aimOffsetAmtPitch = -(rand()%(int)accVal);
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2028
ADDP4
ADDRLP4 44
INDIRI4
ADDRLP4 4
INDIRF4
CVFI4 4
MODI4
NEGI4
CVIF4 4
ASGNF4
line 4601
;4601:	}
LABELV $1891
line 4603
;4602:
;4603:	bs->aimOffsetTime = level.time + rand()%500 + 200;
ADDRLP4 44
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2020
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 44
INDIRI4
CNSTI4 500
MODI4
ADDI4
CNSTI4 200
ADDI4
CVIF4 4
ASGNF4
line 4604
;4604:}
LABELV $1843
endproc BotAimOffsetGoalAngles 56 8
export ShouldSecondaryFire
proc ShouldSecondaryFire 28 0
line 4607
;4605:
;4606:int ShouldSecondaryFire(bot_state_t *bs)
;4607:{
line 4612
;4608:	int weap;
;4609:	int dif;
;4610:	float rTime;
;4611:
;4612:	weap = bs->cur_ps.weapon;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
line 4614
;4613:
;4614:	if (bs->cur_ps.ammo[weaponData[weap].ammoIndex] < weaponData[weap].altEnergyPerShot)
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDRGP4 weaponData+20
ADDP4
INDIRI4
GEI4 $1894
line 4615
;4615:	{
line 4616
;4616:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1894
line 4619
;4617:	}
;4618:
;4619:	if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT && bs->cur_ps.weapon == WP_ROCKET_LAUNCHER)
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1897
ADDRLP4 16
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 10
NEI4 $1897
line 4620
;4620:	{
line 4621
;4621:		float heldTime = (level.time - bs->cur_ps.weaponChargeTime);
ADDRLP4 20
ADDRGP4 level+32
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
SUBI4
CVIF4 4
ASGNF4
line 4623
;4622:
;4623:		rTime = bs->cur_ps.rocketLockTime;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 604
ADDP4
INDIRF4
ASGNF4
line 4625
;4624:
;4625:		if (rTime < 1)
ADDRLP4 4
INDIRF4
CNSTF4 1065353216
GEF4 $1900
line 4626
;4626:		{
line 4627
;4627:			rTime = bs->cur_ps.rocketLastValidTime;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 600
ADDP4
INDIRF4
ASGNF4
line 4628
;4628:		}
LABELV $1900
line 4630
;4629:
;4630:		if (heldTime > 5000)
ADDRLP4 20
INDIRF4
CNSTF4 1167867904
LEF4 $1902
line 4631
;4631:		{ //just give up and release it if we can't manage a lock in 5 seconds
line 4632
;4632:			return 2;
CNSTI4 2
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1902
line 4635
;4633:		}
;4634:
;4635:		if (rTime > 0)
ADDRLP4 4
INDIRF4
CNSTF4 0
LEF4 $1904
line 4636
;4636:		{
line 4637
;4637:			dif = ( level.time - rTime ) / ( 1200.0f / 16.0f );
ADDRLP4 8
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 4
INDIRF4
SUBF4
CNSTF4 1117126656
DIVF4
CVFI4 4
ASGNI4
line 4639
;4638:			
;4639:			if (dif >= 10)
ADDRLP4 8
INDIRI4
CNSTI4 10
LTI4 $1907
line 4640
;4640:			{
line 4641
;4641:				return 2;
CNSTI4 2
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1907
line 4643
;4642:			}
;4643:			else if (bs->frame_Enemy_Len > 250)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132068864
LEF4 $1898
line 4644
;4644:			{
line 4645
;4645:				return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
line 4647
;4646:			}
;4647:		}
LABELV $1904
line 4648
;4648:		else if (bs->frame_Enemy_Len > 250)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132068864
LEF4 $1898
line 4649
;4649:		{
line 4650
;4650:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
line 4652
;4651:		}
;4652:	}
LABELV $1897
line 4653
;4653:	else if ((bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT) && (level.time - bs->cur_ps.weaponChargeTime) > bs->altChargeTime)
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1913
ADDRGP4 level+32
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
SUBI4
ADDRLP4 20
INDIRP4
CNSTI4 2252
ADDP4
INDIRI4
LEI4 $1913
line 4654
;4654:	{
line 4655
;4655:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1913
line 4657
;4656:	}
;4657:	else if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT)
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1916
line 4658
;4658:	{
line 4659
;4659:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1916
LABELV $1898
line 4662
;4660:	}
;4661:
;4662:	if (weap == WP_BRYAR_PISTOL && bs->frame_Enemy_Len < 300)
ADDRLP4 0
INDIRI4
CNSTI4 3
NEI4 $1918
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
GEF4 $1918
line 4663
;4663:	{
line 4664
;4664:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1918
line 4666
;4665:	}
;4666:	else if (weap == WP_BOWCASTER && bs->frame_Enemy_Len > 300)
ADDRLP4 0
INDIRI4
CNSTI4 6
NEI4 $1920
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
LEF4 $1920
line 4667
;4667:	{
line 4668
;4668:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1920
line 4670
;4669:	}
;4670:	else if (weap == WP_REPEATER && bs->frame_Enemy_Len < 600 && bs->frame_Enemy_Len > 250)
ADDRLP4 0
INDIRI4
CNSTI4 7
NEI4 $1922
ADDRLP4 24
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ASGNF4
ADDRLP4 24
INDIRF4
CNSTF4 1142292480
GEF4 $1922
ADDRLP4 24
INDIRF4
CNSTF4 1132068864
LEF4 $1922
line 4671
;4671:	{
line 4672
;4672:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1922
line 4674
;4673:	}
;4674:	else if (weap == WP_BLASTER && bs->frame_Enemy_Len < 300)
ADDRLP4 0
INDIRI4
CNSTI4 4
NEI4 $1924
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
GEF4 $1924
line 4675
;4675:	{
line 4676
;4676:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1924
line 4678
;4677:	}
;4678:	else if (weap == WP_ROCKET_LAUNCHER && bs->frame_Enemy_Len > 250)
ADDRLP4 0
INDIRI4
CNSTI4 10
NEI4 $1926
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132068864
LEF4 $1926
line 4679
;4679:	{
line 4680
;4680:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $1893
JUMPV
LABELV $1926
line 4683
;4681:	}
;4682:
;4683:	return 0;
CNSTI4 0
RETI4
LABELV $1893
endproc ShouldSecondaryFire 28 0
export CombatBotAI
proc CombatBotAI 80 12
line 4687
;4684:}
;4685:
;4686:int CombatBotAI(bot_state_t *bs, float thinktime)
;4687:{
line 4692
;4688:	vec3_t eorg, a;
;4689:	int secFire;
;4690:	float fovcheck;
;4691:
;4692:	if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $1929
line 4693
;4693:	{
line 4694
;4694:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $1928
JUMPV
LABELV $1929
line 4697
;4695:	}
;4696:
;4697:	if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1931
line 4698
;4698:	{
line 4699
;4699:		VectorCopy(bs->currentEnemy->client->ps.origin, eorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 4700
;4700:	}
ADDRGP4 $1932
JUMPV
LABELV $1931
line 4702
;4701:	else
;4702:	{
line 4703
;4703:		VectorCopy(bs->currentEnemy->s.origin, eorg);
ADDRLP4 12
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 4704
;4704:	}
LABELV $1932
line 4706
;4705:
;4706:	VectorSubtract(eorg, bs->eye, a);
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 12
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 12+4
INDIRF4
ADDRLP4 32
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 12+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 4707
;4707:	vectoangles(a, a);
ADDRLP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 4709
;4708:
;4709:	if (BotGetWeaponRange(bs) == BWEAPONRANGE_SABER)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 36
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 4
NEI4 $1937
line 4710
;4710:	{
line 4711
;4711:		if (bs->frame_Enemy_Len <= SABER_ATTACK_RANGE)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1124073472
GTF4 $1938
line 4712
;4712:		{
line 4713
;4713:			bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4714
;4714:		}
line 4715
;4715:	}
ADDRGP4 $1938
JUMPV
LABELV $1937
line 4716
;4716:	else if (BotGetWeaponRange(bs) == BWEAPONRANGE_MELEE)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 40
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 1
NEI4 $1941
line 4717
;4717:	{
line 4718
;4718:		if (bs->frame_Enemy_Len <= MELEE_ATTACK_RANGE)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132462080
GTF4 $1942
line 4719
;4719:		{
line 4720
;4720:			bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4721
;4721:		}
line 4722
;4722:	}
ADDRGP4 $1942
JUMPV
LABELV $1941
line 4724
;4723:	else
;4724:	{
line 4725
;4725:		if (bs->cur_ps.weapon == WP_THERMAL || bs->cur_ps.weapon == WP_ROCKET_LAUNCHER)
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 11
EQI4 $1947
ADDRLP4 44
INDIRI4
CNSTI4 10
NEI4 $1945
LABELV $1947
line 4726
;4726:		{ //be careful with the hurty weapons
line 4727
;4727:			fovcheck = 40;
ADDRLP4 24
CNSTF4 1109393408
ASGNF4
line 4729
;4728:
;4729:			if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT &&
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1946
ADDRLP4 48
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 10
NEI4 $1946
line 4731
;4730:				bs->cur_ps.weapon == WP_ROCKET_LAUNCHER)
;4731:			{ //if we're charging the weapon up then we can hold fire down within a normal fov
line 4732
;4732:				fovcheck = 60;
ADDRLP4 24
CNSTF4 1114636288
ASGNF4
line 4733
;4733:			}
line 4734
;4734:		}
ADDRGP4 $1946
JUMPV
LABELV $1945
line 4736
;4735:		else
;4736:		{
line 4737
;4737:			fovcheck = 60;
ADDRLP4 24
CNSTF4 1114636288
ASGNF4
line 4738
;4738:		}
LABELV $1946
line 4740
;4739:
;4740:		if (bs->cur_ps.weaponstate == WEAPON_CHARGING ||
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 4
EQI4 $1952
ADDRLP4 48
INDIRI4
CNSTI4 5
NEI4 $1950
LABELV $1952
line 4742
;4741:			bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT)
;4742:		{
line 4743
;4743:			fovcheck = 160;
ADDRLP4 24
CNSTF4 1126170624
ASGNF4
line 4744
;4744:		}
LABELV $1950
line 4746
;4745:
;4746:		if (bs->frame_Enemy_Len < 128)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1124073472
GEF4 $1953
line 4747
;4747:		{
line 4748
;4748:			fovcheck *= 2;
ADDRLP4 24
CNSTF4 1073741824
ADDRLP4 24
INDIRF4
MULF4
ASGNF4
line 4749
;4749:		}
LABELV $1953
line 4751
;4750:
;4751:		if (InFieldOfVision(bs->viewangles, fovcheck, a))
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
ADDRLP4 24
INDIRF4
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 52
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $1955
line 4752
;4752:		{
line 4753
;4753:			if (bs->cur_ps.weapon == WP_THERMAL)
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 11
NEI4 $1957
line 4754
;4754:			{
line 4755
;4755:				if (((level.time - bs->cur_ps.weaponChargeTime) < (bs->frame_Enemy_Len*2) &&
ADDRLP4 56
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 60
ADDRLP4 56
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
ASGNI4
ADDRLP4 64
ADDRLP4 56
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ASGNF4
ADDRGP4 level+32
INDIRI4
ADDRLP4 60
INDIRI4
SUBI4
CVIF4 4
CNSTF4 1073741824
ADDRLP4 64
INDIRF4
MULF4
GEF4 $1965
ADDRGP4 level+32
INDIRI4
ADDRLP4 60
INDIRI4
SUBI4
CNSTI4 4000
GEI4 $1965
ADDRLP4 64
INDIRF4
CNSTF4 1115684864
GTF4 $1963
LABELV $1965
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 4
EQI4 $1958
ADDRLP4 68
INDIRI4
CNSTI4 5
EQI4 $1958
LABELV $1963
line 4760
;4756:					(level.time - bs->cur_ps.weaponChargeTime) < 4000 &&
;4757:					bs->frame_Enemy_Len > 64) ||
;4758:					(bs->cur_ps.weaponstate != WEAPON_CHARGING &&
;4759:					bs->cur_ps.weaponstate != WEAPON_CHARGING_ALT))
;4760:				{
line 4761
;4761:					if (bs->cur_ps.weaponstate != WEAPON_CHARGING && bs->cur_ps.weaponstate != WEAPON_CHARGING_ALT)
ADDRLP4 72
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 4
EQI4 $1966
ADDRLP4 72
INDIRI4
CNSTI4 5
EQI4 $1966
line 4762
;4762:					{
line 4763
;4763:						if (bs->frame_Enemy_Len > 512 && bs->frame_Enemy_Len < 800)
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ASGNF4
ADDRLP4 76
INDIRF4
CNSTF4 1140850688
LEF4 $1968
ADDRLP4 76
INDIRF4
CNSTF4 1145569280
GEF4 $1968
line 4764
;4764:						{
line 4765
;4765:							bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 4767
;4766:							//bs->doAttack = 1;
;4767:						}
ADDRGP4 $1969
JUMPV
LABELV $1968
line 4769
;4768:						else
;4769:						{
line 4770
;4770:							bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4772
;4771:							//bs->doAltAttack = 1;
;4772:						}
LABELV $1969
line 4773
;4773:					}
LABELV $1966
line 4775
;4774:
;4775:					if (bs->cur_ps.weaponstate == WEAPON_CHARGING)
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1970
line 4776
;4776:					{
line 4777
;4777:						bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4778
;4778:					}
ADDRGP4 $1958
JUMPV
LABELV $1970
line 4779
;4779:					else if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT)
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $1958
line 4780
;4780:					{
line 4781
;4781:						bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 4782
;4782:					}
line 4783
;4783:				}
line 4784
;4784:			}
ADDRGP4 $1958
JUMPV
LABELV $1957
line 4786
;4785:			else
;4786:			{
line 4787
;4787:				secFire = ShouldSecondaryFire(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 56
ADDRGP4 ShouldSecondaryFire
CALLI4
ASGNI4
ADDRLP4 28
ADDRLP4 56
INDIRI4
ASGNI4
line 4789
;4788:
;4789:				if (bs->cur_ps.weaponstate != WEAPON_CHARGING_ALT &&
ADDRLP4 60
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 5
EQI4 $1974
ADDRLP4 60
INDIRI4
CNSTI4 4
EQI4 $1974
line 4791
;4790:					bs->cur_ps.weaponstate != WEAPON_CHARGING)
;4791:				{
line 4792
;4792:					bs->altChargeTime = Q_irand(500, 1000);
CNSTI4 500
ARGI4
CNSTI4 1000
ARGI4
ADDRLP4 64
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2252
ADDP4
ADDRLP4 64
INDIRI4
ASGNI4
line 4793
;4793:				}
LABELV $1974
line 4795
;4794:
;4795:				if (secFire == 1)
ADDRLP4 28
INDIRI4
CNSTI4 1
NEI4 $1976
line 4796
;4796:				{
line 4797
;4797:					bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 4798
;4798:				}
ADDRGP4 $1977
JUMPV
LABELV $1976
line 4799
;4799:				else if (!secFire)
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $1978
line 4800
;4800:				{
line 4801
;4801:					if (bs->cur_ps.weapon != WP_THERMAL)
ADDRFP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 11
EQI4 $1980
line 4802
;4802:					{
line 4803
;4803:						if (bs->cur_ps.weaponstate != WEAPON_CHARGING ||
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
NEI4 $1985
ADDRLP4 64
INDIRP4
CNSTI4 2252
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 64
ADDP4
INDIRI4
SUBI4
LEI4 $1981
LABELV $1985
line 4805
;4804:							bs->altChargeTime > (level.time - bs->cur_ps.weaponChargeTime))
;4805:						{
line 4806
;4806:							bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4807
;4807:						}
line 4808
;4808:					}
ADDRGP4 $1981
JUMPV
LABELV $1980
line 4810
;4809:					else
;4810:					{
line 4811
;4811:						bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 4812
;4812:					}
LABELV $1981
line 4813
;4813:				}
LABELV $1978
LABELV $1977
line 4815
;4814:
;4815:				if (secFire == 2)
ADDRLP4 28
INDIRI4
CNSTI4 2
NEI4 $1986
line 4816
;4816:				{ //released a charge
line 4817
;4817:					return 1;
CNSTI4 1
RETI4
ADDRGP4 $1928
JUMPV
LABELV $1986
line 4819
;4818:				}
;4819:			}
LABELV $1958
line 4820
;4820:		}
LABELV $1955
line 4821
;4821:	}
LABELV $1942
LABELV $1938
line 4823
;4822:
;4823:	return 0;
CNSTI4 0
RETI4
LABELV $1928
endproc CombatBotAI 80 12
export BotFallbackNavigation
proc BotFallbackNavigation 1152 28
line 4827
;4824:}
;4825:
;4826:int BotFallbackNavigation(bot_state_t *bs)
;4827:{
line 4831
;4828:	vec3_t b_angle, fwd, trto, mins, maxs;
;4829:	trace_t tr;
;4830:
;4831:	if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 1140
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $1989
ADDRLP4 1140
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $1989
line 4832
;4832:	{
line 4833
;4833:		return 2; //we're busy
CNSTI4 2
RETI4
ADDRGP4 $1988
JUMPV
LABELV $1989
line 4836
;4834:	}
;4835:
;4836:	mins[0] = -15;
ADDRLP4 24
CNSTF4 3245342720
ASGNF4
line 4837
;4837:	mins[1] = -15;
ADDRLP4 24+4
CNSTF4 3245342720
ASGNF4
line 4838
;4838:	mins[2] = 0;
ADDRLP4 24+8
CNSTF4 0
ASGNF4
line 4839
;4839:	maxs[0] = 15;
ADDRLP4 36
CNSTF4 1097859072
ASGNF4
line 4840
;4840:	maxs[1] = 15;
ADDRLP4 36+4
CNSTF4 1097859072
ASGNF4
line 4841
;4841:	maxs[2] = 32;
ADDRLP4 36+8
CNSTF4 1107296256
ASGNF4
line 4843
;4842:
;4843:	bs->goalAngles[PITCH] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
CNSTF4 0
ASGNF4
line 4844
;4844:	bs->goalAngles[ROLL] = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1892
ADDP4
CNSTF4 0
ASGNF4
line 4846
;4845:
;4846:	VectorCopy(bs->goalAngles, b_angle);
ADDRLP4 48
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
INDIRB
ASGNB 12
line 4848
;4847:
;4848:	AngleVectors(b_angle, fwd, NULL, NULL);
ADDRLP4 48
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 1144
CNSTP4 0
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 4850
;4849:
;4850:	trto[0] = bs->origin[0] + fwd[0]*16;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1098907648
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 4851
;4851:	trto[1] = bs->origin[1] + fwd[1]*16;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1098907648
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 4852
;4852:	trto[2] = bs->origin[2] + fwd[2]*16;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1098907648
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 4854
;4853:
;4854:	trap_Trace(&tr, bs->origin, mins, maxs, trto, -1, MASK_SOLID);
ADDRLP4 60
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 0
ARGP4
CNSTI4 -1
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 4856
;4855:
;4856:	if (tr.fraction == 1)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
NEF4 $1999
line 4857
;4857:	{
line 4858
;4858:		VectorCopy(trto, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 4859
;4859:		return 1; //success!
CNSTI4 1
RETI4
ADDRGP4 $1988
JUMPV
LABELV $1999
line 4862
;4860:	}
;4861:	else
;4862:	{
line 4863
;4863:		bs->goalAngles[YAW] = rand()%360;
ADDRLP4 1148
ADDRGP4 rand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 1888
ADDP4
ADDRLP4 1148
INDIRI4
CNSTI4 360
MODI4
CVIF4 4
ASGNF4
line 4864
;4864:	}
line 4866
;4865:
;4866:	return 0;
CNSTI4 0
RETI4
LABELV $1988
endproc BotFallbackNavigation 1152 28
export BotTryAnotherWeapon
proc BotTryAnotherWeapon 16 8
line 4870
;4867:}
;4868:
;4869:int BotTryAnotherWeapon(bot_state_t *bs)
;4870:{ //out of ammo, resort to the first weapon we come across that has ammo
line 4873
;4871:	int i;
;4872:
;4873:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2004
JUMPV
LABELV $2003
line 4876
;4874:
;4875:	while (i < WP_NUM_WEAPONS)
;4876:	{
line 4877
;4877:		if (bs->cur_ps.ammo[weaponData[i].ammoIndex] > weaponData[i].energyPerShot &&
ADDRLP4 8
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 12
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
LEI4 $2006
ADDRLP4 12
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2006
line 4879
;4878:			(bs->cur_ps.stats[STAT_WEAPONS] & (1 << i)))
;4879:		{
line 4880
;4880:			bs->virtualWeapon = i;
ADDRFP4 0
INDIRP4
CNSTI4 2276
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 4881
;4881:			BotSelectWeapon(bs->client, i);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRGP4 BotSelectWeapon
CALLV
pop
line 4884
;4882:			//bs->cur_ps.weapon = i;
;4883:			//level.clients[bs->client].ps.weapon = i;
;4884:			return 1;
CNSTI4 1
RETI4
ADDRGP4 $2002
JUMPV
LABELV $2006
line 4887
;4885:		}
;4886:
;4887:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4888
;4888:	}
LABELV $2004
line 4875
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $2003
line 4890
;4889:
;4890:	if (bs->cur_ps.weapon != 1 && bs->virtualWeapon != 1)
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
CNSTI4 1
ASGNI4
ADDRLP4 4
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2009
ADDRLP4 4
INDIRP4
CNSTI4 2276
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2009
line 4891
;4891:	{ //should always have this.. shouldn't we?
line 4892
;4892:		bs->virtualWeapon = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2276
ADDP4
CNSTI4 1
ASGNI4
line 4893
;4893:		BotSelectWeapon(bs->client, 1);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotSelectWeapon
CALLV
pop
line 4896
;4894:		//bs->cur_ps.weapon = 1;
;4895:		//level.clients[bs->client].ps.weapon = 1;
;4896:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2002
JUMPV
LABELV $2009
line 4899
;4897:	}
;4898:
;4899:	return 0;
CNSTI4 0
RETI4
LABELV $2002
endproc BotTryAnotherWeapon 16 8
export BotWeaponSelectable
proc BotWeaponSelectable 12 0
line 4903
;4900:}
;4901:
;4902:qboolean BotWeaponSelectable(bot_state_t *bs, int weapon)
;4903:{
line 4904
;4904:	if (bs->cur_ps.ammo[weaponData[weapon].ammoIndex] >= weaponData[weapon].energyPerShot &&
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 8
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
LTI4 $2012
ADDRLP4 8
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2012
line 4906
;4905:		(bs->cur_ps.stats[STAT_WEAPONS] & (1 << weapon)))
;4906:	{
line 4907
;4907:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2011
JUMPV
LABELV $2012
line 4910
;4908:	}
;4909:	
;4910:	return qfalse;
CNSTI4 0
RETI4
LABELV $2011
endproc BotWeaponSelectable 12 0
export BotSelectIdealWeapon
proc BotSelectIdealWeapon 64 8
line 4914
;4911:}
;4912:
;4913:int BotSelectIdealWeapon(bot_state_t *bs)
;4914:{
line 4916
;4915:	int i;
;4916:	int bestweight = -1;
ADDRLP4 4
CNSTI4 -1
ASGNI4
line 4917
;4917:	int bestweapon = 0;
ADDRLP4 8
CNSTI4 0
ASGNI4
line 4919
;4918:
;4919:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2017
JUMPV
LABELV $2016
line 4922
;4920:
;4921:	while (i < WP_NUM_WEAPONS)
;4922:	{
line 4923
;4923:		if (bs->cur_ps.ammo[weaponData[i].ammoIndex] >= weaponData[i].energyPerShot &&
ADDRLP4 16
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 20
CNSTI4 2
ASGNI4
ADDRLP4 24
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
ADDRLP4 20
INDIRI4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
LTI4 $2019
ADDRLP4 0
INDIRI4
ADDRLP4 20
INDIRI4
LSHI4
ADDRLP4 24
INDIRP4
CNSTI4 2612
ADDP4
ADDP4
INDIRF4
ADDRLP4 4
INDIRI4
CVIF4 4
LEF4 $2019
ADDRLP4 24
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2019
line 4926
;4924:			bs->botWeaponWeights[i] > bestweight &&
;4925:			(bs->cur_ps.stats[STAT_WEAPONS] & (1 << i)))
;4926:		{
line 4927
;4927:			if (i == WP_THERMAL)
ADDRLP4 0
INDIRI4
CNSTI4 11
NEI4 $2022
line 4928
;4928:			{ //special case..
line 4929
;4929:				if (bs->currentEnemy && bs->frame_Enemy_Len < 700)
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2023
ADDRLP4 28
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1143930880
GEF4 $2023
line 4930
;4930:				{
line 4931
;4931:					bestweight = bs->botWeaponWeights[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 2612
ADDP4
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 4932
;4932:					bestweapon = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4933
;4933:				}
line 4934
;4934:			}
ADDRGP4 $2023
JUMPV
LABELV $2022
line 4936
;4935:			else
;4936:			{
line 4937
;4937:				bestweight = bs->botWeaponWeights[i];
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRFP4 0
INDIRP4
CNSTI4 2612
ADDP4
ADDP4
INDIRF4
CVFI4 4
ASGNI4
line 4938
;4938:				bestweapon = i;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 4939
;4939:			}
LABELV $2023
line 4940
;4940:		}
LABELV $2019
line 4942
;4941:
;4942:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 4943
;4943:	}
LABELV $2017
line 4921
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $2016
line 4945
;4944:
;4945:	if ( bs->currentEnemy && bs->frame_Enemy_Len < 300 &&
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2026
ADDRLP4 12
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
GEF4 $2026
ADDRLP4 8
INDIRI4
CNSTI4 3
EQI4 $2029
ADDRLP4 8
INDIRI4
CNSTI4 4
EQI4 $2029
ADDRLP4 8
INDIRI4
CNSTI4 6
NEI4 $2026
LABELV $2029
ADDRFP4 0
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2026
line 4948
;4946:		(bestweapon == WP_BRYAR_PISTOL || bestweapon == WP_BLASTER || bestweapon == WP_BOWCASTER) &&
;4947:		(bs->cur_ps.stats[STAT_WEAPONS] & (1 << WP_SABER)) )
;4948:	{
line 4949
;4949:		bestweapon = WP_SABER;
ADDRLP4 8
CNSTI4 2
ASGNI4
line 4950
;4950:		bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4951
;4951:	}
LABELV $2026
line 4953
;4952:
;4953:	if ( bs->currentEnemy && bs->frame_Enemy_Len > 300 &&
ADDRLP4 20
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 24
ADDRLP4 20
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 28
CNSTU4 0
ASGNU4
ADDRLP4 24
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $2030
ADDRLP4 20
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
LEF4 $2030
ADDRLP4 32
ADDRLP4 24
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CVPU4 4
ADDRLP4 28
INDIRU4
EQU4 $2030
ADDRLP4 36
CNSTI4 2
ASGNI4
ADDRLP4 32
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 36
INDIRI4
EQI4 $2030
ADDRLP4 8
INDIRI4
ADDRLP4 36
INDIRI4
NEI4 $2030
line 4956
;4954:		bs->currentEnemy->client && bs->currentEnemy->client->ps.weapon != WP_SABER &&
;4955:		(bestweapon == WP_SABER) )
;4956:	{ //if the enemy is far away, and we have our saber selected, see if we have any good distance weapons instead
line 4957
;4957:		if (BotWeaponSelectable(bs, WP_DISRUPTOR))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 5
ARGI4
ADDRLP4 40
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $2032
line 4958
;4958:		{
line 4959
;4959:			bestweapon = WP_DISRUPTOR;
ADDRLP4 8
CNSTI4 5
ASGNI4
line 4960
;4960:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4961
;4961:		}
ADDRGP4 $2033
JUMPV
LABELV $2032
line 4962
;4962:		else if (BotWeaponSelectable(bs, WP_ROCKET_LAUNCHER))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 10
ARGI4
ADDRLP4 44
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $2034
line 4963
;4963:		{
line 4964
;4964:			bestweapon = WP_ROCKET_LAUNCHER;
ADDRLP4 8
CNSTI4 10
ASGNI4
line 4965
;4965:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4966
;4966:		}
ADDRGP4 $2035
JUMPV
LABELV $2034
line 4967
;4967:		else if (BotWeaponSelectable(bs, WP_BOWCASTER))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 6
ARGI4
ADDRLP4 48
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $2036
line 4968
;4968:		{
line 4969
;4969:			bestweapon = WP_BOWCASTER;
ADDRLP4 8
CNSTI4 6
ASGNI4
line 4970
;4970:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4971
;4971:		}
ADDRGP4 $2037
JUMPV
LABELV $2036
line 4972
;4972:		else if (BotWeaponSelectable(bs, WP_BLASTER))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 4
ARGI4
ADDRLP4 52
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $2038
line 4973
;4973:		{
line 4974
;4974:			bestweapon = WP_BLASTER;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 4975
;4975:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4976
;4976:		}
ADDRGP4 $2039
JUMPV
LABELV $2038
line 4977
;4977:		else if (BotWeaponSelectable(bs, WP_REPEATER))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 7
ARGI4
ADDRLP4 56
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $2040
line 4978
;4978:		{
line 4979
;4979:			bestweapon = WP_REPEATER;
ADDRLP4 8
CNSTI4 7
ASGNI4
line 4980
;4980:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4981
;4981:		}
ADDRGP4 $2041
JUMPV
LABELV $2040
line 4982
;4982:		else if (BotWeaponSelectable(bs, WP_DEMP2))
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 8
ARGI4
ADDRLP4 60
ADDRGP4 BotWeaponSelectable
CALLI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $2042
line 4983
;4983:		{
line 4984
;4984:			bestweapon = WP_DEMP2;
ADDRLP4 8
CNSTI4 8
ASGNI4
line 4985
;4985:			bestweight = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 4986
;4986:		}
LABELV $2042
LABELV $2041
LABELV $2039
LABELV $2037
LABELV $2035
LABELV $2033
line 4987
;4987:	}
LABELV $2030
line 4989
;4988:
;4989:	if (bestweight != -1 && bs->cur_ps.weapon != bestweapon && bs->virtualWeapon != bestweapon)
ADDRLP4 4
INDIRI4
CNSTI4 -1
EQI4 $2044
ADDRLP4 40
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2044
ADDRLP4 40
INDIRP4
CNSTI4 2276
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2044
line 4990
;4990:	{
line 4991
;4991:		bs->virtualWeapon = bestweapon;
ADDRFP4 0
INDIRP4
CNSTI4 2276
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 4992
;4992:		BotSelectWeapon(bs->client, bestweapon);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRGP4 BotSelectWeapon
CALLV
pop
line 4995
;4993:		//bs->cur_ps.weapon = bestweapon;
;4994:		//level.clients[bs->client].ps.weapon = bestweapon;
;4995:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2015
JUMPV
LABELV $2044
line 4998
;4996:	}
;4997:
;4998:	return 0;
CNSTI4 0
RETI4
LABELV $2015
endproc BotSelectIdealWeapon 64 8
export BotSelectChoiceWeapon
proc BotSelectChoiceWeapon 20 8
line 5002
;4999:}
;5000:
;5001:int BotSelectChoiceWeapon(bot_state_t *bs, int weapon, int doselection)
;5002:{ //if !doselection then bot will only check if he has the specified weapon and return 1 (yes) or 0 (no)
line 5004
;5003:	int i;
;5004:	int hasit = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 5006
;5005:
;5006:	i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
ADDRGP4 $2048
JUMPV
LABELV $2047
line 5009
;5007:
;5008:	while (i < WP_NUM_WEAPONS)
;5009:	{
line 5010
;5010:		if (bs->cur_ps.ammo[weaponData[i].ammoIndex] > weaponData[i].energyPerShot &&
ADDRLP4 12
CNSTI4 56
ADDRLP4 0
INDIRI4
MULI4
ASGNI4
ADDRLP4 16
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 12
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 16
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 12
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
LEI4 $2050
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
NEI4 $2050
ADDRLP4 16
INDIRP4
CNSTI4 248
ADDP4
INDIRI4
CNSTI4 1
ADDRLP4 0
INDIRI4
LSHI4
BANDI4
CNSTI4 0
EQI4 $2050
line 5013
;5011:			i == weapon &&
;5012:			(bs->cur_ps.stats[STAT_WEAPONS] & (1 << i)))
;5013:		{
line 5014
;5014:			hasit = 1;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 5015
;5015:			break;
ADDRGP4 $2049
JUMPV
LABELV $2050
line 5018
;5016:		}
;5017:
;5018:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5019
;5019:	}
LABELV $2048
line 5008
ADDRLP4 0
INDIRI4
CNSTI4 16
LTI4 $2047
LABELV $2049
line 5021
;5020:
;5021:	if (hasit && bs->cur_ps.weapon != weapon && doselection && bs->virtualWeapon != weapon)
ADDRLP4 8
CNSTI4 0
ASGNI4
ADDRLP4 4
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2053
ADDRLP4 12
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 16
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 12
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $2053
ADDRFP4 8
INDIRI4
ADDRLP4 8
INDIRI4
EQI4 $2053
ADDRLP4 12
INDIRP4
CNSTI4 2276
ADDP4
INDIRI4
ADDRLP4 16
INDIRI4
EQI4 $2053
line 5022
;5022:	{
line 5023
;5023:		bs->virtualWeapon = weapon;
ADDRFP4 0
INDIRP4
CNSTI4 2276
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 5024
;5024:		BotSelectWeapon(bs->client, weapon);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 4
INDIRI4
ARGI4
ADDRGP4 BotSelectWeapon
CALLV
pop
line 5027
;5025:		//bs->cur_ps.weapon = weapon;
;5026:		//level.clients[bs->client].ps.weapon = weapon;
;5027:		return 2;
CNSTI4 2
RETI4
ADDRGP4 $2046
JUMPV
LABELV $2053
line 5030
;5028:	}
;5029:
;5030:	if (hasit)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $2055
line 5031
;5031:	{
line 5032
;5032:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2046
JUMPV
LABELV $2055
line 5035
;5033:	}
;5034:
;5035:	return 0;
CNSTI4 0
RETI4
LABELV $2046
endproc BotSelectChoiceWeapon 20 8
export BotSelectMelee
proc BotSelectMelee 8 8
line 5039
;5036:}
;5037:
;5038:int BotSelectMelee(bot_state_t *bs)
;5039:{
line 5040
;5040:	if (bs->cur_ps.weapon != 1 && bs->virtualWeapon != 1)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2058
ADDRLP4 0
INDIRP4
CNSTI4 2276
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2058
line 5041
;5041:	{
line 5042
;5042:		bs->virtualWeapon = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2276
ADDP4
CNSTI4 1
ASGNI4
line 5043
;5043:		BotSelectWeapon(bs->client, 1);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 BotSelectWeapon
CALLV
pop
line 5046
;5044:		//bs->cur_ps.weapon = 1;
;5045:		//level.clients[bs->client].ps.weapon = 1;
;5046:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2057
JUMPV
LABELV $2058
line 5049
;5047:	}
;5048:
;5049:	return 0;
CNSTI4 0
RETI4
LABELV $2057
endproc BotSelectMelee 8 8
export GetLoveLevel
proc GetLoveLevel 20 8
line 5053
;5050:}
;5051:
;5052:int GetLoveLevel(bot_state_t *bs, bot_state_t *love)
;5053:{
line 5054
;5054:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5055
;5055:	const char *lname = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
line 5057
;5056:
;5057:	if (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $2061
line 5058
;5058:	{ //There is no love in 1-on-1
line 5059
;5059:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2061
line 5062
;5060:	}
;5061:
;5062:	if (!bs || !love || !g_entities[love->client].client)
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRFP4 0
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $2068
ADDRLP4 12
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $2068
CNSTI4 828
ADDRLP4 12
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
NEU4 $2064
LABELV $2068
line 5063
;5063:	{
line 5064
;5064:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2064
line 5067
;5065:	}
;5066:
;5067:	if (!bs->lovednum)
ADDRFP4 0
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2069
line 5068
;5068:	{
line 5069
;5069:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2069
line 5072
;5070:	}
;5071:
;5072:	trap_Cvar_Update(&bot_attachments);
ADDRGP4 bot_attachments
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5074
;5073:
;5074:	if (!bot_attachments.integer)
ADDRGP4 bot_attachments+12
INDIRI4
CNSTI4 0
NEI4 $2071
line 5075
;5075:	{
line 5076
;5076:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2071
line 5079
;5077:	}
;5078:
;5079:	lname = g_entities[love->client].client->pers.netname;
ADDRLP4 4
CNSTI4 828
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1416
ADDP4
ASGNP4
line 5081
;5080:
;5081:	if (!lname)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2078
line 5082
;5082:	{
line 5083
;5083:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2077
line 5087
;5084:	}
;5085:
;5086:	while (i < bs->lovednum)
;5087:	{
line 5088
;5088:		if (strcmp(bs->loved[i].name, lname) == 0)
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $2080
line 5089
;5089:		{
line 5090
;5090:			return bs->loved[i].level;
CNSTI4 68
ADDRLP4 0
INDIRI4
MULI4
ADDRFP4 0
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
INDIRI4
RETI4
ADDRGP4 $2060
JUMPV
LABELV $2080
line 5093
;5091:		}
;5092:
;5093:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5094
;5094:	}
LABELV $2078
line 5086
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
LTI4 $2077
line 5096
;5095:
;5096:	return 0;
CNSTI4 0
RETI4
LABELV $2060
endproc GetLoveLevel 20 8
export BotLovedOneDied
proc BotLovedOneDied 40 12
line 5100
;5097:}
;5098:
;5099:void BotLovedOneDied(bot_state_t *bs, bot_state_t *loved, int lovelevel)
;5100:{
line 5101
;5101:	if (!loved->lastHurt || !loved->lastHurt->client ||
ADDRLP4 0
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 0
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $2086
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 8
INDIRU4
EQU4 $2086
ADDRLP4 4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2083
LABELV $2086
line 5103
;5102:		loved->lastHurt->s.number == loved->client)
;5103:	{
line 5104
;5104:		return;
ADDRGP4 $2082
JUMPV
LABELV $2083
line 5107
;5105:	}
;5106:
;5107:	if (g_gametype.integer == GT_TOURNAMENT)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 3
NEI4 $2087
line 5108
;5108:	{ //There is no love in 1-on-1
line 5109
;5109:		return;
ADDRGP4 $2082
JUMPV
LABELV $2087
line 5112
;5110:	}
;5111:
;5112:	if (!IsTeamplay())
ADDRLP4 12
ADDRGP4 IsTeamplay
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2090
line 5113
;5113:	{
line 5114
;5114:		if (lovelevel < 2)
ADDRFP4 8
INDIRI4
CNSTI4 2
GEI4 $2091
line 5115
;5115:		{
line 5116
;5116:			return;
ADDRGP4 $2082
JUMPV
line 5118
;5117:		}
;5118:	}
LABELV $2090
line 5119
;5119:	else if (OnSameTeam(&g_entities[bs->client], loved->lastHurt))
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ARGP4
ADDRLP4 16
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2094
line 5120
;5120:	{ //don't hate teammates no matter what
line 5121
;5121:		return;
ADDRGP4 $2082
JUMPV
LABELV $2094
LABELV $2091
line 5124
;5122:	}
;5123:
;5124:	if (loved->client == loved->lastHurt->s.number)
ADDRLP4 20
ADDRFP4 4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 20
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
INDIRI4
NEI4 $2096
line 5125
;5125:	{
line 5126
;5126:		return;
ADDRGP4 $2082
JUMPV
LABELV $2096
line 5129
;5127:	}
;5128:
;5129:	if (bs->client == loved->lastHurt->s.number)
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
INDIRI4
NEI4 $2098
line 5130
;5130:	{ //oops!
line 5131
;5131:		return;
ADDRGP4 $2082
JUMPV
LABELV $2098
line 5134
;5132:	}
;5133:	
;5134:	trap_Cvar_Update(&bot_attachments);
ADDRGP4 bot_attachments
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5136
;5135:
;5136:	if (!bot_attachments.integer)
ADDRGP4 bot_attachments+12
INDIRI4
CNSTI4 0
NEI4 $2100
line 5137
;5137:	{
line 5138
;5138:		return;
ADDRGP4 $2082
JUMPV
LABELV $2100
line 5141
;5139:	}
;5140:
;5141:	if (!PassLovedOneCheck(bs, loved->lastHurt))
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $2103
line 5142
;5142:	{ //a loved one killed a loved one.. you cannot hate them
line 5143
;5143:		bs->chatObject = loved->lastHurt;
ADDRFP4 0
INDIRP4
CNSTI4 2232
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5144
;5144:		bs->chatAltObject = &g_entities[loved->client];
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTI4 828
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5145
;5145:		BotDoChat(bs, "LovedOneKilledLovedOne", 0);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2105
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 5146
;5146:		return;
ADDRGP4 $2082
JUMPV
LABELV $2103
line 5149
;5147:	}
;5148:
;5149:	if (bs->revengeEnemy == loved->lastHurt)
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CVPU4 4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
CVPU4 4
NEU4 $2106
line 5150
;5150:	{
line 5151
;5151:		if (bs->revengeHateLevel < bs->loved_death_thresh)
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1852
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 2604
ADDP4
INDIRI4
GEI4 $2107
line 5152
;5152:		{
line 5153
;5153:			bs->revengeHateLevel++;
ADDRLP4 32
ADDRFP4 0
INDIRP4
CNSTI4 1852
ADDP4
ASGNP4
ADDRLP4 32
INDIRP4
ADDRLP4 32
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5155
;5154:
;5155:			if (bs->revengeHateLevel == bs->loved_death_thresh)
ADDRLP4 36
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CNSTI4 1852
ADDP4
INDIRI4
ADDRLP4 36
INDIRP4
CNSTI4 2604
ADDP4
INDIRI4
NEI4 $2107
line 5156
;5156:			{
line 5159
;5157:				//broke into the highest anger level
;5158:				//CHAT: Hatred section
;5159:				bs->chatObject = loved->lastHurt;
ADDRFP4 0
INDIRP4
CNSTI4 2232
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5160
;5160:				bs->chatAltObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 5161
;5161:				BotDoChat(bs, "Hatred", 1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2112
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 5162
;5162:			}
line 5163
;5163:		}
line 5164
;5164:	}
ADDRGP4 $2107
JUMPV
LABELV $2106
line 5165
;5165:	else if (bs->revengeHateLevel < bs->loved_death_thresh-1)
ADDRLP4 28
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CNSTI4 1852
ADDP4
INDIRI4
ADDRLP4 28
INDIRP4
CNSTI4 2604
ADDP4
INDIRI4
CNSTI4 1
SUBI4
GEI4 $2113
line 5166
;5166:	{ //only switch hatred if we don't hate the existing revenge-enemy too much
line 5168
;5167:		//CHAT: BelovedKilled section
;5168:		bs->chatObject = &g_entities[loved->client];
ADDRFP4 0
INDIRP4
CNSTI4 2232
ADDP4
CNSTI4 828
ADDRFP4 4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5169
;5169:		bs->chatAltObject = loved->lastHurt;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5170
;5170:		BotDoChat(bs, "BelovedKilled", 0);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2115
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 5171
;5171:		bs->revengeHateLevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1852
ADDP4
CNSTI4 0
ASGNI4
line 5172
;5172:		bs->revengeEnemy = loved->lastHurt;
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
ADDRFP4 4
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5173
;5173:	}
LABELV $2113
LABELV $2107
line 5174
;5174:}
LABELV $2082
endproc BotLovedOneDied 40 12
export BotDeathNotify
proc BotDeathNotify 20 12
line 5177
;5175:
;5176:void BotDeathNotify(bot_state_t *bs)
;5177:{ //in case someone has an emotional attachment to us, we'll notify them
line 5178
;5178:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5179
;5179:	int ltest = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2118
JUMPV
LABELV $2117
line 5182
;5180:
;5181:	while (i < MAX_CLIENTS)
;5182:	{
line 5183
;5183:		if (botstates[i] && botstates[i]->lovednum)
ADDRLP4 8
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2120
ADDRLP4 8
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2120
line 5184
;5184:		{
line 5185
;5185:			ltest = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2123
JUMPV
LABELV $2122
line 5187
;5186:			while (ltest < botstates[i]->lovednum)
;5187:			{
line 5188
;5188:				if (strcmp(level.clients[bs->client].pers.netname, botstates[i]->loved[ltest].name) == 0)
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1416
ADDP4
ARGP4
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 12
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2125
line 5189
;5189:				{
line 5190
;5190:					BotLovedOneDied(botstates[i], bs, botstates[i]->loved[ltest].level);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
ARGP4
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 68
ADDRLP4 4
INDIRI4
MULI4
ADDRLP4 16
INDIRP4
CNSTI4 2328
ADDP4
ADDP4
INDIRI4
ARGI4
ADDRGP4 BotLovedOneDied
CALLV
pop
line 5191
;5191:					break;
ADDRGP4 $2124
JUMPV
LABELV $2125
line 5194
;5192:				}
;5193:
;5194:				ltest++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5195
;5195:			}
LABELV $2123
line 5186
ADDRLP4 4
INDIRI4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2600
ADDP4
INDIRI4
LTI4 $2122
LABELV $2124
line 5196
;5196:		}
LABELV $2120
line 5198
;5197:
;5198:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5199
;5199:	}
LABELV $2118
line 5181
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2117
line 5200
;5200:}
LABELV $2116
endproc BotDeathNotify 20 12
export StrafeTracing
proc StrafeTracing 1156 28
line 5203
;5201:
;5202:void StrafeTracing(bot_state_t *bs)
;5203:{
line 5208
;5204:	vec3_t mins, maxs;
;5205:	vec3_t right, rorg, drorg;
;5206:	trace_t tr;
;5207:
;5208:	mins[0] = -15;
ADDRLP4 12
CNSTF4 3245342720
ASGNF4
line 5209
;5209:	mins[1] = -15;
ADDRLP4 12+4
CNSTF4 3245342720
ASGNF4
line 5211
;5210:	//mins[2] = -24;
;5211:	mins[2] = -22;
ADDRLP4 12+8
CNSTF4 3249537024
ASGNF4
line 5212
;5212:	maxs[0] = 15;
ADDRLP4 24
CNSTF4 1097859072
ASGNF4
line 5213
;5213:	maxs[1] = 15;
ADDRLP4 24+4
CNSTF4 1097859072
ASGNF4
line 5214
;5214:	maxs[2] = 32;
ADDRLP4 24+8
CNSTF4 1107296256
ASGNF4
line 5216
;5215:
;5216:	AngleVectors(bs->viewangles, NULL, right, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
ADDRLP4 1140
CNSTP4 0
ASGNP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 5218
;5217:
;5218:	if (bs->meleeStrafeDir)
ADDRFP4 0
INDIRP4
CNSTI4 2244
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2132
line 5219
;5219:	{
line 5220
;5220:		rorg[0] = bs->origin[0] - right[0]*32;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36
INDIRF4
MULF4
SUBF4
ASGNF4
line 5221
;5221:		rorg[1] = bs->origin[1] - right[1]*32;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 5222
;5222:		rorg[2] = bs->origin[2] - right[2]*32;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 5223
;5223:	}
ADDRGP4 $2133
JUMPV
LABELV $2132
line 5225
;5224:	else
;5225:	{
line 5226
;5226:		rorg[0] = bs->origin[0] + right[0]*32;
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36
INDIRF4
MULF4
ADDF4
ASGNF4
line 5227
;5227:		rorg[1] = bs->origin[1] + right[1]*32;
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 5228
;5228:		rorg[2] = bs->origin[2] + right[2]*32;
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1107296256
ADDRLP4 36+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 5229
;5229:	}
LABELV $2133
line 5231
;5230:
;5231:	trap_Trace(&tr, bs->origin, mins, maxs, rorg, bs->client, MASK_SOLID);
ADDRLP4 48
ARGP4
ADDRLP4 1144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1144
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1144
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5233
;5232:
;5233:	if (tr.fraction != 1)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
EQF4 $2142
line 5234
;5234:	{
line 5235
;5235:		bs->meleeStrafeDisable = level.time + Q_irand(500, 1500);
CNSTI4 500
ARGI4
CNSTI4 1500
ARGI4
ADDRLP4 1148
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2248
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1148
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 5236
;5236:	}
LABELV $2142
line 5238
;5237:
;5238:	VectorCopy(rorg, drorg);
ADDRLP4 1128
ADDRLP4 0
INDIRB
ASGNB 12
line 5240
;5239:
;5240:	drorg[2] -= 32;
ADDRLP4 1128+8
ADDRLP4 1128+8
INDIRF4
CNSTF4 1107296256
SUBF4
ASGNF4
line 5242
;5241:
;5242:	trap_Trace(&tr, rorg, NULL, NULL, drorg, bs->client, MASK_SOLID);
ADDRLP4 48
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1148
CNSTP4 0
ASGNP4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRLP4 1148
INDIRP4
ARGP4
ADDRLP4 1128
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5244
;5243:
;5244:	if (tr.fraction == 1)
ADDRLP4 48+8
INDIRF4
CNSTF4 1065353216
NEF4 $2147
line 5245
;5245:	{ //this may be a dangerous ledge, so don't strafe over it just in case
line 5246
;5246:		bs->meleeStrafeDisable = level.time + Q_irand(500, 1500);
CNSTI4 500
ARGI4
CNSTI4 1500
ARGI4
ADDRLP4 1152
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2248
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 1152
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 5247
;5247:	}
LABELV $2147
line 5248
;5248:}
LABELV $2127
endproc StrafeTracing 1156 28
export PrimFiring
proc PrimFiring 8 0
line 5251
;5249:
;5250:int PrimFiring(bot_state_t *bs)
;5251:{
line 5252
;5252:	if (bs->cur_ps.weaponstate != WEAPON_CHARGING &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2152
ADDRLP4 0
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2152
line 5254
;5253:		bs->doAttack)
;5254:	{
line 5255
;5255:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2151
JUMPV
LABELV $2152
line 5258
;5256:	}
;5257:
;5258:	if (bs->cur_ps.weaponstate == WEAPON_CHARGING &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2154
ADDRLP4 4
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2154
line 5260
;5259:		!bs->doAttack)
;5260:	{
line 5261
;5261:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2151
JUMPV
LABELV $2154
line 5264
;5262:	}
;5263:
;5264:	return 0;
CNSTI4 0
RETI4
LABELV $2151
endproc PrimFiring 8 0
export KeepPrimFromFiring
proc KeepPrimFromFiring 8 0
line 5268
;5265:}
;5266:
;5267:int KeepPrimFromFiring(bot_state_t *bs)
;5268:{
line 5269
;5269:	if (bs->cur_ps.weaponstate != WEAPON_CHARGING &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
EQI4 $2157
ADDRLP4 0
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2157
line 5271
;5270:		bs->doAttack)
;5271:	{
line 5272
;5272:		bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 5273
;5273:	}
LABELV $2157
line 5275
;5274:
;5275:	if (bs->cur_ps.weaponstate == WEAPON_CHARGING &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2159
ADDRLP4 4
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2159
line 5277
;5276:		!bs->doAttack)
;5277:	{
line 5278
;5278:		bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 5279
;5279:	}
LABELV $2159
line 5281
;5280:
;5281:	return 0;
CNSTI4 0
RETI4
LABELV $2156
endproc KeepPrimFromFiring 8 0
export AltFiring
proc AltFiring 8 0
line 5285
;5282:}
;5283:
;5284:int AltFiring(bot_state_t *bs)
;5285:{
line 5286
;5286:	if (bs->cur_ps.weaponstate != WEAPON_CHARGING_ALT &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
EQI4 $2162
ADDRLP4 0
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2162
line 5288
;5287:		bs->doAltAttack)
;5288:	{
line 5289
;5289:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2161
JUMPV
LABELV $2162
line 5292
;5290:	}
;5291:
;5292:	if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2164
ADDRLP4 4
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2164
line 5294
;5293:		!bs->doAltAttack)
;5294:	{
line 5295
;5295:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2161
JUMPV
LABELV $2164
line 5298
;5296:	}
;5297:
;5298:	return 0;
CNSTI4 0
RETI4
LABELV $2161
endproc AltFiring 8 0
export KeepAltFromFiring
proc KeepAltFromFiring 8 0
line 5302
;5299:}
;5300:
;5301:int KeepAltFromFiring(bot_state_t *bs)
;5302:{
line 5303
;5303:	if (bs->cur_ps.weaponstate != WEAPON_CHARGING_ALT &&
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
EQI4 $2167
ADDRLP4 0
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2167
line 5305
;5304:		bs->doAltAttack)
;5305:	{
line 5306
;5306:		bs->doAltAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 0
ASGNI4
line 5307
;5307:	}
LABELV $2167
line 5309
;5308:
;5309:	if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT &&
ADDRLP4 4
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2169
ADDRLP4 4
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2169
line 5311
;5310:		!bs->doAltAttack)
;5311:	{
line 5312
;5312:		bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 5313
;5313:	}
LABELV $2169
line 5315
;5314:
;5315:	return 0;
CNSTI4 0
RETI4
LABELV $2166
endproc KeepAltFromFiring 8 0
export CheckForFriendInLOF
proc CheckForFriendInLOF 1172 28
line 5319
;5316:}
;5317:
;5318:gentity_t *CheckForFriendInLOF(bot_state_t *bs)
;5319:{
line 5326
;5320:	vec3_t fwd;
;5321:	vec3_t trfrom, trto;
;5322:	vec3_t mins, maxs;
;5323:	gentity_t *trent;
;5324:	trace_t tr;
;5325:
;5326:	mins[0] = -3;
ADDRLP4 36
CNSTF4 3225419776
ASGNF4
line 5327
;5327:	mins[1] = -3;
ADDRLP4 36+4
CNSTF4 3225419776
ASGNF4
line 5328
;5328:	mins[2] = -3;
ADDRLP4 36+8
CNSTF4 3225419776
ASGNF4
line 5330
;5329:
;5330:	maxs[0] = 3;
ADDRLP4 48
CNSTF4 1077936128
ASGNF4
line 5331
;5331:	maxs[1] = 3;
ADDRLP4 48+4
CNSTF4 1077936128
ASGNF4
line 5332
;5332:	maxs[2] = 3;
ADDRLP4 48+8
CNSTF4 1077936128
ASGNF4
line 5334
;5333:
;5334:	AngleVectors(bs->viewangles, fwd, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 1144
CNSTP4 0
ASGNP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 5336
;5335:
;5336:	VectorCopy(bs->eye, trfrom);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1732
ADDP4
INDIRB
ASGNB 12
line 5338
;5337:
;5338:	trto[0] = trfrom[0] + fwd[0]*2048;
ADDRLP4 24
ADDRLP4 0
INDIRF4
CNSTF4 1157627904
ADDRLP4 12
INDIRF4
MULF4
ADDF4
ASGNF4
line 5339
;5339:	trto[1] = trfrom[1] + fwd[1]*2048;
ADDRLP4 24+4
ADDRLP4 0+4
INDIRF4
CNSTF4 1157627904
ADDRLP4 12+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 5340
;5340:	trto[2] = trfrom[2] + fwd[2]*2048;
ADDRLP4 24+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1157627904
ADDRLP4 12+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 5342
;5341:
;5342:	trap_Trace(&tr, trfrom, mins, maxs, trto, bs->client, MASK_PLAYERSOLID);
ADDRLP4 60
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 24
ARGP4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5344
;5343:
;5344:	if (tr.fraction != 1 && tr.entityNum <= MAX_CLIENTS)
ADDRLP4 60+8
INDIRF4
CNSTF4 1065353216
EQF4 $2182
ADDRLP4 60+52
INDIRI4
CNSTI4 32
GTI4 $2182
line 5345
;5345:	{
line 5346
;5346:		trent = &g_entities[tr.entityNum];
ADDRLP4 1140
CNSTI4 828
ADDRLP4 60+52
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5348
;5347:
;5348:		if (trent && trent->client)
ADDRLP4 1148
ADDRLP4 1140
INDIRP4
ASGNP4
ADDRLP4 1152
CNSTU4 0
ASGNU4
ADDRLP4 1148
INDIRP4
CVPU4 4
ADDRLP4 1152
INDIRU4
EQU4 $2187
ADDRLP4 1148
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 1152
INDIRU4
EQU4 $2187
line 5349
;5349:		{
line 5350
;5350:			if (IsTeamplay() && OnSameTeam(&g_entities[bs->client], trent))
ADDRLP4 1156
ADDRGP4 IsTeamplay
CALLI4
ASGNI4
ADDRLP4 1156
INDIRI4
CNSTI4 0
EQI4 $2189
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 1160
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 1160
INDIRI4
CNSTI4 0
EQI4 $2189
line 5351
;5351:			{
line 5352
;5352:				return trent;
ADDRLP4 1140
INDIRP4
RETP4
ADDRGP4 $2171
JUMPV
LABELV $2189
line 5355
;5353:			}
;5354:
;5355:			if (botstates[trent->s.number] && GetLoveLevel(bs, botstates[trent->s.number]) > 1)
ADDRLP4 1164
ADDRLP4 1140
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1164
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2191
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 1164
INDIRP4
ARGP4
ADDRLP4 1168
ADDRGP4 GetLoveLevel
CALLI4
ASGNI4
ADDRLP4 1168
INDIRI4
CNSTI4 1
LEI4 $2191
line 5356
;5356:			{
line 5357
;5357:				return trent;
ADDRLP4 1140
INDIRP4
RETP4
ADDRGP4 $2171
JUMPV
LABELV $2191
line 5359
;5358:			}
;5359:		}
LABELV $2187
line 5360
;5360:	}
LABELV $2182
line 5362
;5361:
;5362:	return NULL;
CNSTP4 0
RETP4
LABELV $2171
endproc CheckForFriendInLOF 1172 28
export BotScanForLeader
proc BotScanForLeader 36 8
line 5366
;5363:}
;5364:
;5365:void BotScanForLeader(bot_state_t *bs)
;5366:{ //bots will only automatically obtain a leader if it's another bot using this method.
line 5367
;5367:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5370
;5368:	gentity_t *ent;
;5369:
;5370:	if (bs->isSquadLeader)
ADDRFP4 0
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2197
line 5371
;5371:	{
line 5372
;5372:		return;
ADDRGP4 $2193
JUMPV
LABELV $2196
line 5376
;5373:	}
;5374:
;5375:	while (i < MAX_CLIENTS)
;5376:	{
line 5377
;5377:		ent = &g_entities[i];
ADDRLP4 4
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5379
;5378:
;5379:		if (ent && ent->client && botstates[i] && botstates[i]->isSquadLeader && bs->client != i)
ADDRLP4 12
CNSTU4 0
ASGNU4
ADDRLP4 4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $2199
ADDRLP4 4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $2199
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 20
INDIRP4
CVPU4 4
ADDRLP4 12
INDIRU4
EQU4 $2199
ADDRLP4 20
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2199
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
EQI4 $2199
line 5380
;5380:		{
line 5381
;5381:			if (OnSameTeam(&g_entities[bs->client], ent))
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
ARGP4
ADDRLP4 24
ADDRGP4 OnSameTeam
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
EQI4 $2201
line 5382
;5382:			{
line 5383
;5383:				bs->squadLeader = ent;
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5384
;5384:				break;
ADDRGP4 $2198
JUMPV
LABELV $2201
line 5386
;5385:			}
;5386:			if (GetLoveLevel(bs, botstates[i]) > 1 && !IsTeamplay())
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRLP4 28
ADDRGP4 GetLoveLevel
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 1
LEI4 $2203
ADDRLP4 32
ADDRGP4 IsTeamplay
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $2203
line 5387
;5387:			{ //ignore love status regarding squad leaders if we're in teamplay
line 5388
;5388:				bs->squadLeader = ent;
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
ADDRLP4 4
INDIRP4
ASGNP4
line 5389
;5389:				break;
ADDRGP4 $2198
JUMPV
LABELV $2203
line 5391
;5390:			}
;5391:		}
LABELV $2199
line 5393
;5392:
;5393:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5394
;5394:	}
LABELV $2197
line 5375
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2196
LABELV $2198
line 5395
;5395:}
LABELV $2193
endproc BotScanForLeader 36 8
export BotReplyGreetings
proc BotReplyGreetings 20 12
line 5398
;5396:
;5397:void BotReplyGreetings(bot_state_t *bs)
;5398:{
line 5399
;5399:	int i = 0;
ADDRLP4 0
CNSTI4 0
ASGNI4
line 5400
;5400:	int numhello = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRGP4 $2207
JUMPV
LABELV $2206
line 5403
;5401:
;5402:	while (i < MAX_CLIENTS)
;5403:	{
line 5404
;5404:		if (botstates[i] &&
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2209
ADDRLP4 12
INDIRP4
CNSTI4 2080
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2209
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $2209
line 5407
;5405:			botstates[i]->canChat &&
;5406:			i != bs->client)
;5407:		{
line 5408
;5408:			botstates[i]->chatObject = &g_entities[bs->client];
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2232
ADDP4
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 5409
;5409:			botstates[i]->chatAltObject = NULL;
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 5410
;5410:			if (BotDoChat(botstates[i], "ResponseGreetings", 0))
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRGP4 $2213
ARGP4
CNSTI4 0
ARGI4
ADDRLP4 16
ADDRGP4 BotDoChat
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
EQI4 $2211
line 5411
;5411:			{
line 5412
;5412:				numhello++;
ADDRLP4 4
ADDRLP4 4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5413
;5413:			}
LABELV $2211
line 5414
;5414:		}
LABELV $2209
line 5416
;5415:
;5416:		if (numhello > 3)
ADDRLP4 4
INDIRI4
CNSTI4 3
LEI4 $2214
line 5417
;5417:		{ //don't let more than 4 bots say hello at once
line 5418
;5418:			return;
ADDRGP4 $2205
JUMPV
LABELV $2214
line 5421
;5419:		}
;5420:
;5421:		i++;
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 5422
;5422:	}
LABELV $2207
line 5402
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2206
line 5423
;5423:}
LABELV $2205
endproc BotReplyGreetings 20 12
export CTFFlagMovement
proc CTFFlagMovement 1184 28
line 5426
;5424:
;5425:void CTFFlagMovement(bot_state_t *bs)
;5426:{
line 5427
;5427:	int diddrop = 0;
ADDRLP4 28
CNSTI4 0
ASGNI4
line 5428
;5428:	gentity_t *desiredDrop = NULL;
ADDRLP4 24
CNSTP4 0
ASGNP4
line 5432
;5429:	vec3_t a, mins, maxs;
;5430:	trace_t tr;
;5431:
;5432:	mins[0] = -15;
ADDRLP4 0
CNSTF4 3245342720
ASGNF4
line 5433
;5433:	mins[1] = -15;
ADDRLP4 0+4
CNSTF4 3245342720
ASGNF4
line 5434
;5434:	mins[2] = -7;
ADDRLP4 0+8
CNSTF4 3235905536
ASGNF4
line 5435
;5435:	maxs[0] = 15;
ADDRLP4 12
CNSTF4 1097859072
ASGNF4
line 5436
;5436:	maxs[1] = 15;
ADDRLP4 12+4
CNSTF4 1097859072
ASGNF4
line 5437
;5437:	maxs[2] = 7;
ADDRLP4 12+8
CNSTF4 1088421888
ASGNF4
line 5439
;5438:
;5439:	if (bs->wantFlag && (bs->wantFlag->flags & FL_DROPPED_ITEM))
ADDRLP4 1124
ADDRFP4 0
INDIRP4
CNSTI4 1824
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1124
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2221
ADDRLP4 1124
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $2221
line 5440
;5440:	{
line 5441
;5441:		if (bs->staticFlagSpot[0] == bs->wantFlag->s.pos.trBase[0] &&
ADDRLP4 1128
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1132
ADDRLP4 1128
INDIRP4
CNSTI4 1824
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1128
INDIRP4
CNSTI4 1840
ADDP4
INDIRF4
ADDRLP4 1132
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
NEF4 $2223
ADDRLP4 1128
INDIRP4
CNSTI4 1844
ADDP4
INDIRF4
ADDRLP4 1132
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
NEF4 $2223
ADDRLP4 1128
INDIRP4
CNSTI4 1848
ADDP4
INDIRF4
ADDRLP4 1132
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
NEF4 $2223
line 5444
;5442:			bs->staticFlagSpot[1] == bs->wantFlag->s.pos.trBase[1] &&
;5443:			bs->staticFlagSpot[2] == bs->wantFlag->s.pos.trBase[2])
;5444:		{
line 5445
;5445:			VectorSubtract(bs->origin, bs->wantFlag->s.pos.trBase, a);
ADDRLP4 1136
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1140
ADDRLP4 1136
INDIRP4
CNSTI4 1824
ADDP4
ASGNP4
ADDRLP4 32
ADDRLP4 1136
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 1140
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 1136
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 1140
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 1144
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32+8
ADDRLP4 1144
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 1144
INDIRP4
CNSTI4 1824
ADDP4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5447
;5446:
;5447:			if (VectorLength(a) <= BOT_FLAG_GET_DISTANCE)
ADDRLP4 32
ARGP4
ADDRLP4 1148
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1148
INDIRF4
CNSTF4 1132462080
GTF4 $2227
line 5448
;5448:			{
line 5449
;5449:				VectorCopy(bs->wantFlag->s.pos.trBase, bs->goalPosition);
ADDRLP4 1152
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1152
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 1152
INDIRP4
CNSTI4 1824
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5450
;5450:				return;
ADDRGP4 $2216
JUMPV
LABELV $2227
line 5453
;5451:			}
;5452:			else
;5453:			{
line 5454
;5454:				bs->wantFlag = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1824
ADDP4
CNSTP4 0
ASGNP4
line 5455
;5455:			}
line 5456
;5456:		}
ADDRGP4 $2222
JUMPV
LABELV $2223
line 5458
;5457:		else
;5458:		{
line 5459
;5459:			bs->wantFlag = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1824
ADDP4
CNSTP4 0
ASGNP4
line 5460
;5460:		}
line 5461
;5461:	}
ADDRGP4 $2222
JUMPV
LABELV $2221
line 5462
;5462:	else if (bs->wantFlag)
ADDRFP4 0
INDIRP4
CNSTI4 1824
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2229
line 5463
;5463:	{
line 5464
;5464:		bs->wantFlag = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1824
ADDP4
CNSTP4 0
ASGNP4
line 5465
;5465:	}
LABELV $2229
LABELV $2222
line 5467
;5466:
;5467:	if (flagRed && flagBlue)
ADDRLP4 1128
CNSTU4 0
ASGNU4
ADDRGP4 flagRed
INDIRP4
CVPU4 4
ADDRLP4 1128
INDIRU4
EQU4 $2231
ADDRGP4 flagBlue
INDIRP4
CVPU4 4
ADDRLP4 1128
INDIRU4
EQU4 $2231
line 5468
;5468:	{
line 5469
;5469:		if (bs->wpDestination == flagRed ||
ADDRLP4 1132
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 1132
INDIRU4
ADDRGP4 flagRed
INDIRP4
CVPU4 4
EQU4 $2235
ADDRLP4 1132
INDIRU4
ADDRGP4 flagBlue
INDIRP4
CVPU4 4
NEU4 $2233
LABELV $2235
line 5471
;5470:			bs->wpDestination == flagBlue)
;5471:		{
line 5472
;5472:			if (bs->wpDestination == flagRed && droppedRedFlag && (droppedRedFlag->flags & FL_DROPPED_ITEM) && droppedRedFlag->classname && strcmp(droppedRedFlag->classname, "freed") != 0)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 flagRed
INDIRP4
CVPU4 4
NEU4 $2236
ADDRLP4 1136
ADDRGP4 droppedRedFlag
INDIRP4
ASGNP4
ADDRLP4 1140
CNSTU4 0
ASGNU4
ADDRLP4 1136
INDIRP4
CVPU4 4
ADDRLP4 1140
INDIRU4
EQU4 $2236
ADDRLP4 1136
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $2236
ADDRLP4 1144
ADDRLP4 1136
INDIRP4
CNSTI4 416
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1144
INDIRP4
CVPU4 4
ADDRLP4 1140
INDIRU4
EQU4 $2236
ADDRLP4 1144
INDIRP4
ARGP4
ADDRGP4 $2238
ARGP4
ADDRLP4 1148
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1148
INDIRI4
CNSTI4 0
EQI4 $2236
line 5473
;5473:			{
line 5474
;5474:				desiredDrop = droppedRedFlag;
ADDRLP4 24
ADDRGP4 droppedRedFlag
INDIRP4
ASGNP4
line 5475
;5475:				diddrop = 1;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 5476
;5476:			}
LABELV $2236
line 5477
;5477:			if (bs->wpDestination == flagBlue && droppedBlueFlag && (droppedBlueFlag->flags & FL_DROPPED_ITEM) && droppedBlueFlag->classname && strcmp(droppedBlueFlag->classname, "freed") != 0)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
ADDRGP4 flagBlue
INDIRP4
CVPU4 4
NEU4 $2239
ADDRLP4 1152
ADDRGP4 droppedBlueFlag
INDIRP4
ASGNP4
ADDRLP4 1156
CNSTU4 0
ASGNU4
ADDRLP4 1152
INDIRP4
CVPU4 4
ADDRLP4 1156
INDIRU4
EQU4 $2239
ADDRLP4 1152
INDIRP4
CNSTI4 472
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $2239
ADDRLP4 1160
ADDRLP4 1152
INDIRP4
CNSTI4 416
ADDP4
INDIRP4
ASGNP4
ADDRLP4 1160
INDIRP4
CVPU4 4
ADDRLP4 1156
INDIRU4
EQU4 $2239
ADDRLP4 1160
INDIRP4
ARGP4
ADDRGP4 $2238
ARGP4
ADDRLP4 1164
ADDRGP4 strcmp
CALLI4
ASGNI4
ADDRLP4 1164
INDIRI4
CNSTI4 0
EQI4 $2239
line 5478
;5478:			{
line 5479
;5479:				desiredDrop = droppedBlueFlag;
ADDRLP4 24
ADDRGP4 droppedBlueFlag
INDIRP4
ASGNP4
line 5480
;5480:				diddrop = 1;
ADDRLP4 28
CNSTI4 1
ASGNI4
line 5481
;5481:			}
LABELV $2239
line 5483
;5482:
;5483:			if (diddrop && desiredDrop)
ADDRLP4 28
INDIRI4
CNSTI4 0
EQI4 $2241
ADDRLP4 24
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2241
line 5484
;5484:			{
line 5485
;5485:				VectorSubtract(bs->origin, desiredDrop->s.pos.trBase, a);
ADDRLP4 1168
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1172
ADDRLP4 24
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 1168
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 1172
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+4
ADDRLP4 1168
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 1172
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 32+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 24
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5487
;5486:
;5487:				if (VectorLength(a) <= BOT_FLAG_GET_DISTANCE)
ADDRLP4 32
ARGP4
ADDRLP4 1176
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1176
INDIRF4
CNSTF4 1132462080
GTF4 $2245
line 5488
;5488:				{
line 5489
;5489:					trap_Trace(&tr, bs->origin, mins, maxs, desiredDrop->s.pos.trBase, bs->client, MASK_SOLID);
ADDRLP4 44
ARGP4
ADDRLP4 1180
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1180
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 1180
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5491
;5490:
;5491:					if (tr.fraction == 1 || tr.entityNum == desiredDrop->s.number)
ADDRLP4 44+8
INDIRF4
CNSTF4 1065353216
EQF4 $2251
ADDRLP4 44+52
INDIRI4
ADDRLP4 24
INDIRP4
INDIRI4
NEI4 $2247
LABELV $2251
line 5492
;5492:					{
line 5493
;5493:						VectorCopy(desiredDrop->s.pos.trBase, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5494
;5494:						VectorCopy(desiredDrop->s.pos.trBase, bs->staticFlagSpot);
ADDRFP4 0
INDIRP4
CNSTI4 1840
ADDP4
ADDRLP4 24
INDIRP4
CNSTI4 24
ADDP4
INDIRB
ASGNB 12
line 5495
;5495:						return;
LABELV $2247
line 5497
;5496:					}
;5497:				}
LABELV $2245
line 5498
;5498:			}
LABELV $2241
line 5499
;5499:		}
LABELV $2233
line 5500
;5500:	}
LABELV $2231
line 5501
;5501:}
LABELV $2216
endproc CTFFlagMovement 1184 28
export BotCheckDetPacks
proc BotCheckDetPacks 84 12
line 5504
;5502:
;5503:void BotCheckDetPacks(bot_state_t *bs)
;5504:{
line 5505
;5505:	gentity_t *dp = NULL;
ADDRLP4 0
CNSTP4 0
ASGNP4
line 5506
;5506:	gentity_t *myDet = NULL;
ADDRLP4 4
CNSTP4 0
ASGNP4
ADDRGP4 $2254
JUMPV
LABELV $2253
line 5512
;5507:	vec3_t a;
;5508:	float enLen;
;5509:	float myLen;
;5510:
;5511:	while ( (dp = G_Find( dp, FOFS(classname), "detpack") ) != NULL )
;5512:	{
line 5513
;5513:		if (dp && dp->parent && dp->parent->s.number == bs->client)
ADDRLP4 32
CNSTU4 0
ASGNU4
ADDRLP4 0
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $2257
ADDRLP4 36
ADDRLP4 0
INDIRP4
CNSTI4 536
ADDP4
INDIRP4
ASGNP4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 32
INDIRU4
EQU4 $2257
ADDRLP4 36
INDIRP4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
NEI4 $2257
line 5514
;5514:		{
line 5515
;5515:			myDet = dp;
ADDRLP4 4
ADDRLP4 0
INDIRP4
ASGNP4
line 5516
;5516:			break;
ADDRGP4 $2255
JUMPV
LABELV $2257
line 5518
;5517:		}
;5518:	}
LABELV $2254
line 5511
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 416
ARGI4
ADDRGP4 $2256
ARGP4
ADDRLP4 28
ADDRGP4 G_Find
CALLP4
ASGNP4
ADDRLP4 0
ADDRLP4 28
INDIRP4
ASGNP4
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2253
LABELV $2255
line 5520
;5519:
;5520:	if (!myDet)
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2259
line 5521
;5521:	{
line 5522
;5522:		return;
ADDRGP4 $2252
JUMPV
LABELV $2259
line 5525
;5523:	}
;5524:
;5525:	if (!bs->currentEnemy || !bs->currentEnemy->client || !bs->frame_Enemy_Vis)
ADDRLP4 32
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 36
ADDRLP4 32
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTU4 0
ASGNU4
ADDRLP4 36
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $2264
ADDRLP4 36
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 40
INDIRU4
EQU4 $2264
ADDRLP4 32
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2261
LABELV $2264
line 5526
;5526:	{ //require the enemy to be visilbe just to be fair..
line 5529
;5527:
;5528:		//unless..
;5529:		if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 44
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 44
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 52
CNSTU4 0
ASGNU4
ADDRLP4 48
INDIRP4
CVPU4 4
ADDRLP4 52
INDIRU4
EQU4 $2252
ADDRLP4 48
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 52
INDIRU4
EQU4 $2252
ADDRGP4 level+32
INDIRI4
ADDRLP4 44
INDIRP4
CNSTI4 2288
ADDP4
INDIRI4
SUBI4
CNSTI4 5000
GEI4 $2252
line 5531
;5530:			(level.time - bs->plantContinue) < 5000)
;5531:		{ //it's a fresh plant (within 5 seconds) so we should be able to guess
line 5532
;5532:			goto stillmadeit;
line 5534
;5533:		}
;5534:		return;
LABELV $2261
LABELV $2268
line 5539
;5535:	}
;5536:
;5537:stillmadeit:
;5538:
;5539:	VectorSubtract(bs->currentEnemy->client->ps.origin, myDet->s.pos.trBase, a);
ADDRLP4 44
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
ASGNP4
ADDRLP4 48
CNSTI4 408
ASGNI4
ADDRLP4 56
CNSTI4 24
ASGNI4
ADDRLP4 8
ADDRLP4 44
INDIRP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 44
INDIRP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
INDIRP4
ADDRLP4 56
INDIRI4
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5540
;5540:	enLen = VectorLength(a);
ADDRLP4 8
ARGP4
ADDRLP4 60
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 60
INDIRF4
ASGNF4
line 5542
;5541:
;5542:	VectorSubtract(bs->origin, myDet->s.pos.trBase, a);
ADDRLP4 64
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 8
ADDRLP4 64
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+4
ADDRLP4 64
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 8+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 4
INDIRP4
CNSTI4 32
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5543
;5543:	myLen = VectorLength(a);
ADDRLP4 8
ARGP4
ADDRLP4 72
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 24
ADDRLP4 72
INDIRF4
ASGNF4
line 5545
;5544:
;5545:	if (enLen > myLen)
ADDRLP4 20
INDIRF4
ADDRLP4 24
INDIRF4
LEF4 $2273
line 5546
;5546:	{
line 5547
;5547:		return;
ADDRGP4 $2252
JUMPV
LABELV $2273
line 5550
;5548:	}
;5549:
;5550:	if (enLen < BOT_PLANT_BLOW_DISTANCE && OrgVisible(bs->currentEnemy->client->ps.origin, myDet->s.pos.trBase, bs->currentEnemy->s.number))
ADDRLP4 20
INDIRF4
CNSTF4 1132462080
GEF4 $2275
ADDRLP4 76
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 76
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 4
INDIRP4
CNSTI4 24
ADDP4
ARGP4
ADDRLP4 76
INDIRP4
INDIRI4
ARGI4
ADDRLP4 80
ADDRGP4 OrgVisible
CALLI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $2275
line 5551
;5551:	{ //we could just call the "blow all my detpacks" function here, but I guess that's cheating.
line 5552
;5552:		bs->plantKillEmAll = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 2292
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 5553
;5553:	}
LABELV $2275
line 5554
;5554:}
LABELV $2252
endproc BotCheckDetPacks 84 12
export BotUseInventoryItem
proc BotUseInventoryItem 12 8
line 5557
;5555:
;5556:int BotUseInventoryItem(bot_state_t *bs)
;5557:{
line 5558
;5558:	if (bs->cur_ps.stats[STAT_HOLDABLE_ITEMS] & (1 << HI_MEDPAC))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 8
BANDI4
CNSTI4 0
EQI4 $2279
line 5559
;5559:	{
line 5560
;5560:		if (g_entities[bs->client].health <= 50)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 50
GTI4 $2281
line 5561
;5561:		{
line 5562
;5562:			bs->cur_ps.stats[STAT_HOLDABLE_ITEM] = BG_GetItemIndexByTag(HI_MEDPAC, IT_HOLDABLE);
CNSTI4 3
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 0
ADDRGP4 BG_GetItemIndexByTag
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 5563
;5563:			goto wantuseitem;
ADDRGP4 $2284
JUMPV
LABELV $2281
line 5565
;5564:		}
;5565:	}
LABELV $2279
line 5566
;5566:	if (bs->cur_ps.stats[STAT_HOLDABLE_ITEMS] & (1 << HI_SEEKER))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
EQI4 $2285
line 5567
;5567:	{
line 5568
;5568:		if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2287
ADDRLP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2287
line 5569
;5569:		{
line 5570
;5570:			bs->cur_ps.stats[STAT_HOLDABLE_ITEM] = BG_GetItemIndexByTag(HI_SEEKER, IT_HOLDABLE);
CNSTI4 1
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 4
ADDRGP4 BG_GetItemIndexByTag
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 4
INDIRI4
ASGNI4
line 5571
;5571:			goto wantuseitem;
ADDRGP4 $2284
JUMPV
LABELV $2287
line 5573
;5572:		}
;5573:	}
LABELV $2285
line 5574
;5574:	if (bs->cur_ps.stats[STAT_HOLDABLE_ITEMS] & (1 << HI_SENTRY_GUN))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $2289
line 5575
;5575:	{
line 5576
;5576:		if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2291
ADDRLP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2291
line 5577
;5577:		{
line 5578
;5578:			bs->cur_ps.stats[STAT_HOLDABLE_ITEM] = BG_GetItemIndexByTag(HI_SENTRY_GUN, IT_HOLDABLE);
ADDRLP4 4
CNSTI4 6
ASGNI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
ADDRGP4 BG_GetItemIndexByTag
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5579
;5579:			goto wantuseitem;
ADDRGP4 $2284
JUMPV
LABELV $2291
line 5581
;5580:		}
;5581:	}
LABELV $2289
line 5582
;5582:	if (bs->cur_ps.stats[STAT_HOLDABLE_ITEMS] & (1 << HI_SHIELD))
ADDRFP4 0
INDIRP4
CNSTI4 240
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2293
line 5583
;5583:	{
line 5584
;5584:		if (bs->currentEnemy && bs->frame_Enemy_Vis && bs->runningToEscapeThreat)
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2295
ADDRLP4 4
CNSTI4 0
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2295
ADDRLP4 0
INDIRP4
CNSTI4 2300
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $2295
line 5585
;5585:		{ //this will (hopefully) result in the bot placing the shield down while facing
line 5587
;5586:		  //the enemy and running away
;5587:			bs->cur_ps.stats[STAT_HOLDABLE_ITEM] = BG_GetItemIndexByTag(HI_SHIELD, IT_HOLDABLE);
CNSTI4 2
ARGI4
CNSTI4 6
ARGI4
ADDRLP4 8
ADDRGP4 BG_GetItemIndexByTag
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 236
ADDP4
ADDRLP4 8
INDIRI4
ASGNI4
line 5588
;5588:			goto wantuseitem;
ADDRGP4 $2284
JUMPV
LABELV $2295
line 5590
;5589:		}
;5590:	}
LABELV $2293
line 5592
;5591:
;5592:	return 0;
CNSTI4 0
RETI4
ADDRGP4 $2278
JUMPV
LABELV $2284
line 5595
;5593:
;5594:wantuseitem:
;5595:	level.clients[bs->client].ps.stats[STAT_HOLDABLE_ITEM] = bs->cur_ps.stats[STAT_HOLDABLE_ITEM];
ADDRLP4 0
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 1756
ADDRLP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 220
ADDP4
ADDRLP4 0
INDIRP4
CNSTI4 236
ADDP4
INDIRI4
ASGNI4
line 5597
;5596:
;5597:	return 1;
CNSTI4 1
RETI4
LABELV $2278
endproc BotUseInventoryItem 12 8
export BotSurfaceNear
proc BotSurfaceNear 1104 28
line 5601
;5598:}
;5599:
;5600:int BotSurfaceNear(bot_state_t *bs)
;5601:{
line 5605
;5602:	trace_t tr;
;5603:	vec3_t fwd;
;5604:
;5605:	AngleVectors(bs->viewangles, fwd, NULL, NULL);
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1092
CNSTP4 0
ASGNP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRLP4 1092
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 5607
;5606:
;5607:	fwd[0] = bs->origin[0]+(fwd[0]*64);
ADDRLP4 0
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 5608
;5608:	fwd[1] = bs->origin[1]+(fwd[1]*64);
ADDRLP4 0+4
ADDRFP4 0
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 5609
;5609:	fwd[2] = bs->origin[2]+(fwd[2]*64);
ADDRLP4 0+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
CNSTF4 1115684864
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 5611
;5610:
;5611:	trap_Trace(&tr, bs->origin, NULL, NULL, fwd, bs->client, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRLP4 1096
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 1100
CNSTP4 0
ASGNP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 1100
INDIRP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1096
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRGP4 trap_Trace
CALLV
pop
line 5613
;5612:
;5613:	if (tr.fraction != 1)
ADDRLP4 12+8
INDIRF4
CNSTF4 1065353216
EQF4 $2302
line 5614
;5614:	{
line 5615
;5615:		return 1;
CNSTI4 1
RETI4
ADDRGP4 $2297
JUMPV
LABELV $2302
line 5618
;5616:	}
;5617:
;5618:	return 0;
CNSTI4 0
RETI4
LABELV $2297
endproc BotSurfaceNear 1104 28
export BotWeaponBlockable
proc BotWeaponBlockable 4 0
line 5622
;5619:}
;5620:
;5621:int BotWeaponBlockable(int weapon)
;5622:{
line 5623
;5623:	switch (weapon)
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 1
LTI4 $2306
ADDRLP4 0
INDIRI4
CNSTI4 13
GTI4 $2306
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $2315-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $2315
address $2308
address $2306
address $2306
address $2306
address $2309
address $2306
address $2306
address $2310
address $2306
address $2311
address $2312
address $2313
address $2314
code
line 5624
;5624:	{
LABELV $2308
line 5626
;5625:	case WP_STUN_BATON:
;5626:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2309
line 5628
;5627:	case WP_DISRUPTOR:
;5628:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2310
line 5630
;5629:	case WP_DEMP2:
;5630:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2311
line 5632
;5631:	case WP_ROCKET_LAUNCHER:
;5632:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2312
line 5634
;5633:	case WP_THERMAL:
;5634:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2313
line 5636
;5635:	case WP_TRIP_MINE:
;5636:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2314
line 5638
;5637:	case WP_DET_PACK:
;5638:		return 0;
CNSTI4 0
RETI4
ADDRGP4 $2305
JUMPV
LABELV $2306
line 5640
;5639:	default:
;5640:		return 1;
CNSTI4 1
RETI4
LABELV $2305
endproc BotWeaponBlockable 4 0
export StandardBotAI
proc StandardBotAI 420 24
line 5648
;5641:	}
;5642:}
;5643:
;5644:void Cmd_EngageDuel_f(gentity_t *ent);
;5645:void Cmd_ToggleSaber_f(gentity_t *ent);
;5646:
;5647:void StandardBotAI(bot_state_t *bs, float thinktime)
;5648:{
line 5652
;5649:	int wp, enemy;
;5650:	int desiredIndex;
;5651:	int goalWPIndex;
;5652:	int doingFallback = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 5657
;5653:	int fjHalt;
;5654:	vec3_t a, ang, headlevel, eorg, noz_x, noz_y, dif, a_fo;
;5655:	float reaction;
;5656:	float bLeadAmount;
;5657:	int meleestrafe = 0;
ADDRLP4 92
CNSTI4 0
ASGNI4
line 5658
;5658:	int useTheForce = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 5659
;5659:	int forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5660
;5660:	int cBAI = 0;
ADDRLP4 152
CNSTI4 0
ASGNI4
line 5661
;5661:	gentity_t *friendInLOF = 0;
ADDRLP4 52
CNSTP4 0
ASGNP4
line 5663
;5662:	float mLen;
;5663:	int visResult = 0;
ADDRLP4 100
CNSTI4 0
ASGNI4
line 5664
;5664:	int selResult = 0;
ADDRLP4 104
CNSTI4 0
ASGNI4
line 5665
;5665:	int mineSelect = 0;
ADDRLP4 156
CNSTI4 0
ASGNI4
line 5666
;5666:	int detSelect = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 5668
;5667:
;5668:	if (gDeactivated)
ADDRGP4 gDeactivated
INDIRF4
CNSTF4 0
EQF4 $2318
line 5669
;5669:	{
line 5670
;5670:		bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 5671
;5671:		bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 5672
;5672:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 5673
;5673:		bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 5674
;5674:		return;
ADDRGP4 $2317
JUMPV
LABELV $2318
line 5677
;5675:	}
;5676:
;5677:	if (g_entities[bs->client].inuse &&
ADDRLP4 168
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 168
INDIRI4
ADDRGP4 g_entities+412
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2320
ADDRLP4 168
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2320
ADDRLP4 168
INDIRI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1520
ADDP4
INDIRI4
CNSTI4 3
NEI4 $2320
line 5680
;5678:		g_entities[bs->client].client &&
;5679:		g_entities[bs->client].client->sess.sessionTeam == TEAM_SPECTATOR)
;5680:	{
line 5681
;5681:		bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 5682
;5682:		bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 5683
;5683:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 5684
;5684:		bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 5685
;5685:		return;
ADDRGP4 $2317
JUMPV
LABELV $2320
line 5688
;5686:	}
;5687:
;5688:	trap_Cvar_Update(&bot_forgimmick);
ADDRGP4 bot_forgimmick
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 5690
;5689:
;5690:	if (bot_forgimmick.integer)
ADDRGP4 bot_forgimmick+12
INDIRI4
CNSTI4 0
EQI4 $2325
line 5691
;5691:	{
line 5692
;5692:		bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 5693
;5693:		bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 5694
;5694:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 5695
;5695:		bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 5696
;5696:		return;
ADDRGP4 $2317
JUMPV
LABELV $2325
line 5699
;5697:	}
;5698:
;5699:	if (!bs->lastDeadTime)
ADDRFP4 0
INDIRP4
CNSTI4 1868
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2328
line 5700
;5700:	{ //just spawned in?
line 5701
;5701:		bs->lastDeadTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 1868
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5702
;5702:	}
LABELV $2328
line 5704
;5703:
;5704:	if (g_entities[bs->client].health < 1)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 1
GEI4 $2331
line 5705
;5705:	{
line 5706
;5706:		bs->lastDeadTime = level.time;
ADDRFP4 0
INDIRP4
CNSTI4 1868
ADDP4
ADDRGP4 level+32
INDIRI4
ASGNI4
line 5708
;5707:
;5708:		if (!bs->deathActivitiesDone && bs->lastHurt && bs->lastHurt->client && bs->lastHurt->s.number != bs->client)
ADDRLP4 172
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 172
INDIRP4
CNSTI4 2608
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2335
ADDRLP4 176
ADDRLP4 172
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
ADDRLP4 180
CNSTU4 0
ASGNU4
ADDRLP4 176
INDIRP4
CVPU4 4
ADDRLP4 180
INDIRU4
EQU4 $2335
ADDRLP4 176
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 180
INDIRU4
EQU4 $2335
ADDRLP4 176
INDIRP4
INDIRI4
ADDRLP4 172
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
EQI4 $2335
line 5709
;5709:		{
line 5710
;5710:			BotDeathNotify(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDeathNotify
CALLV
pop
line 5711
;5711:			if (PassLovedOneCheck(bs, bs->lastHurt))
ADDRLP4 184
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 184
INDIRP4
ARGP4
ADDRLP4 184
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ARGP4
ADDRLP4 188
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 188
INDIRI4
CNSTI4 0
EQI4 $2337
line 5712
;5712:			{
line 5714
;5713:				//CHAT: Died
;5714:				bs->chatObject = bs->lastHurt;
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
CNSTI4 2232
ADDP4
ADDRLP4 192
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5715
;5715:				bs->chatAltObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 5716
;5716:				BotDoChat(bs, "Died", 0);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2339
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 5717
;5717:			}
ADDRGP4 $2338
JUMPV
LABELV $2337
line 5718
;5718:			else if (!PassLovedOneCheck(bs, bs->lastHurt) &&
ADDRLP4 192
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 192
INDIRP4
ARGP4
ADDRLP4 192
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ARGP4
ADDRLP4 196
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 196
INDIRI4
CNSTI4 0
NEI4 $2340
ADDRLP4 200
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 204
ADDRLP4 200
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 204
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2340
ADDRLP4 204
INDIRP4
ARGP4
CNSTI4 828
ADDRLP4 200
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 208
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 208
INDIRI4
CNSTI4 0
EQI4 $2340
line 5721
;5719:				botstates[bs->lastHurt->s.number] &&
;5720:				PassLovedOneCheck(botstates[bs->lastHurt->s.number], &g_entities[bs->client]))
;5721:			{ //killed by a bot that I love, but that does not love me
line 5722
;5722:				bs->chatObject = bs->lastHurt;
ADDRLP4 212
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 212
INDIRP4
CNSTI4 2232
ADDP4
ADDRLP4 212
INDIRP4
CNSTI4 1816
ADDP4
INDIRP4
ASGNP4
line 5723
;5723:				bs->chatAltObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 5724
;5724:				BotDoChat(bs, "KilledOnPurposeByLove", 0);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2342
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 5725
;5725:			}
LABELV $2340
LABELV $2338
line 5727
;5726:
;5727:			bs->deathActivitiesDone = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2608
ADDP4
CNSTI4 1
ASGNI4
line 5728
;5728:		}
LABELV $2335
line 5730
;5729:		
;5730:		bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 5731
;5731:		bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 5732
;5732:		bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 5733
;5733:		bs->wpCamping = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
CNSTP4 0
ASGNP4
line 5734
;5734:		bs->wpCampingTo = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2060
ADDP4
CNSTP4 0
ASGNP4
line 5735
;5735:		bs->wpStoreDest = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1880
ADDP4
CNSTP4 0
ASGNP4
line 5736
;5736:		bs->wpDestIgnoreTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1976
ADDP4
CNSTF4 0
ASGNF4
line 5737
;5737:		bs->wpDestSwitchTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1968
ADDP4
CNSTF4 0
ASGNF4
line 5738
;5738:		bs->wpSeenTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
CNSTF4 0
ASGNF4
line 5739
;5739:		bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 5741
;5740:
;5741:		if (rand()%10 < 5 &&
ADDRLP4 184
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 10
MODI4
CNSTI4 5
GEI4 $2317
ADDRLP4 188
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 188
INDIRP4
CNSTI4 2224
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2346
ADDRLP4 188
INDIRP4
CNSTI4 2216
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2317
LABELV $2346
line 5743
;5742:			(!bs->doChat || bs->chatTime < level.time))
;5743:		{
line 5744
;5744:			trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 5745
;5745:		}
line 5747
;5746:
;5747:		return;
ADDRGP4 $2317
JUMPV
LABELV $2331
line 5750
;5748:	}
;5749:
;5750:	bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 5751
;5751:	bs->doAltAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 0
ASGNI4
line 5754
;5752:	//reset the attack states
;5753:
;5754:	if (bs->isSquadLeader)
ADDRFP4 0
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2347
line 5755
;5755:	{
line 5756
;5756:		CommanderBotAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CommanderBotAI
CALLV
pop
line 5757
;5757:	}
ADDRGP4 $2348
JUMPV
LABELV $2347
line 5759
;5758:	else
;5759:	{
line 5760
;5760:		BotDoTeamplayAI(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotDoTeamplayAI
CALLV
pop
line 5761
;5761:	}
LABELV $2348
line 5763
;5762:
;5763:	if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2349
line 5764
;5764:	{
line 5765
;5765:		bs->frame_Enemy_Vis = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
CNSTI4 0
ASGNI4
line 5766
;5766:	}
LABELV $2349
line 5768
;5767:
;5768:	if (bs->revengeEnemy && bs->revengeEnemy->client &&
ADDRLP4 172
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
ASGNP4
ADDRLP4 176
CNSTU4 0
ASGNU4
ADDRLP4 172
INDIRP4
CVPU4 4
ADDRLP4 176
INDIRU4
EQU4 $2351
ADDRLP4 180
ADDRLP4 172
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 180
INDIRP4
CVPU4 4
ADDRLP4 176
INDIRU4
EQU4 $2351
ADDRLP4 184
ADDRLP4 180
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
ASGNI4
ADDRLP4 184
INDIRI4
CNSTI4 8
EQI4 $2351
ADDRLP4 184
INDIRI4
CNSTI4 2
EQI4 $2351
line 5770
;5769:		bs->revengeEnemy->client->pers.connected != CA_ACTIVE && bs->revengeEnemy->client->pers.connected != CA_AUTHORIZING)
;5770:	{
line 5771
;5771:		bs->revengeEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
CNSTP4 0
ASGNP4
line 5772
;5772:		bs->revengeHateLevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1852
ADDP4
CNSTI4 0
ASGNI4
line 5773
;5773:	}
LABELV $2351
line 5775
;5774:
;5775:	if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 188
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 192
CNSTU4 0
ASGNU4
ADDRLP4 188
INDIRP4
CVPU4 4
ADDRLP4 192
INDIRU4
EQU4 $2353
ADDRLP4 196
ADDRLP4 188
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 196
INDIRP4
CVPU4 4
ADDRLP4 192
INDIRU4
EQU4 $2353
ADDRLP4 200
ADDRLP4 196
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
ASGNI4
ADDRLP4 200
INDIRI4
CNSTI4 8
EQI4 $2353
ADDRLP4 200
INDIRI4
CNSTI4 2
EQI4 $2353
line 5777
;5776:		bs->currentEnemy->client->pers.connected != CA_ACTIVE && bs->currentEnemy->client->pers.connected != CA_AUTHORIZING)
;5777:	{
line 5778
;5778:		bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 5779
;5779:	}
LABELV $2353
line 5781
;5780:
;5781:	fjHalt = 0;
ADDRLP4 96
CNSTI4 0
ASGNI4
line 5784
;5782:
;5783:#ifndef FORCEJUMP_INSTANTMETHOD
;5784:	if (bs->forceJumpChargeTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2355
line 5785
;5785:	{
line 5786
;5786:		useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5787
;5787:		forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5788
;5788:	}
LABELV $2355
line 5790
;5789:
;5790:	if (bs->currentEnemy && bs->currentEnemy->client && bs->frame_Enemy_Vis && bs->forceJumpChargeTime < level.time)
ADDRLP4 204
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 208
ADDRLP4 204
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 212
CNSTU4 0
ASGNU4
ADDRLP4 208
INDIRP4
CVPU4 4
ADDRLP4 212
INDIRU4
EQU4 $2358
ADDRLP4 208
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 212
INDIRU4
EQU4 $2358
ADDRLP4 204
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2358
ADDRLP4 204
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2358
line 5794
;5791:#else
;5792:	if (bs->currentEnemy && bs->currentEnemy->client && bs->frame_Enemy_Vis)
;5793:#endif
;5794:	{
line 5795
;5795:		VectorSubtract(bs->currentEnemy->client->ps.origin, bs->eye, a_fo);
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
ADDRLP4 216
INDIRP4
CNSTI4 1804
ADDP4
ASGNP4
ADDRLP4 224
CNSTI4 408
ASGNI4
ADDRLP4 20
ADDRLP4 220
INDIRP4
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 220
INDIRP4
INDIRP4
ADDRLP4 224
INDIRI4
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 216
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 228
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20+8
ADDRLP4 228
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 228
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 5796
;5796:		vectoangles(a_fo, a_fo);
ADDRLP4 20
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 5799
;5797:
;5798:		//do this above all things
;5799:		if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_PUSH)) && bs->doForcePush > level.time && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_PUSH]][FP_PUSH] && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
CNSTI4 8
ASGNI4
ADDRLP4 232
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 236
INDIRI4
BANDI4
CNSTI4 0
EQI4 $2363
ADDRLP4 232
INDIRP4
CNSTI4 4784
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2363
ADDRLP4 240
CNSTI4 1756
ADDRLP4 232
INDIRP4
ADDRLP4 236
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 240
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+12
ADDP4
INDIRI4
LEI4 $2363
ADDRLP4 232
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 244
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 244
INDIRI4
CNSTI4 0
EQI4 $2363
line 5800
;5800:		{
line 5801
;5801:			level.clients[bs->client].ps.fd.forcePowerSelected = FP_PUSH;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 3
ASGNI4
line 5802
;5802:			useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5803
;5803:			forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5804
;5804:		}
ADDRGP4 $2364
JUMPV
LABELV $2363
line 5805
;5805:		else if (bs->cur_ps.fd.forceSide == FORCE_DARKSIDE)
ADDRFP4 0
INDIRP4
CNSTI4 1192
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2367
line 5806
;5806:		{ //try dark side powers
line 5808
;5807:		  //in order of priority top to bottom
;5808:			if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_GRIP)) && (bs->cur_ps.fd.forcePowersActive & (1 << FP_GRIP)) && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
CNSTI4 64
ASGNI4
ADDRLP4 256
CNSTI4 0
ASGNI4
ADDRLP4 248
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 252
INDIRI4
BANDI4
ADDRLP4 256
INDIRI4
EQI4 $2369
ADDRLP4 248
INDIRP4
CNSTI4 852
ADDP4
INDIRI4
ADDRLP4 252
INDIRI4
BANDI4
ADDRLP4 256
INDIRI4
EQI4 $2369
ADDRLP4 248
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 260
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $2369
line 5809
;5809:			{ //already gripping someone, so hold it
line 5810
;5810:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_GRIP;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 6
ASGNI4
line 5811
;5811:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5812
;5812:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5813
;5813:			}
ADDRGP4 $2368
JUMPV
LABELV $2369
line 5814
;5814:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_LIGHTNING)) && bs->frame_Enemy_Len < FORCE_LIGHTNING_RADIUS && level.clients[bs->client].ps.fd.forcePower > 50 && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 128
BANDI4
CNSTI4 0
EQI4 $2371
ADDRLP4 264
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1133903872
GEF4 $2371
CNSTI4 1756
ADDRLP4 264
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 50
LEI4 $2371
ADDRLP4 264
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 268
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $2371
line 5815
;5815:			{
line 5816
;5816:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_LIGHTNING;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 7
ASGNI4
line 5817
;5817:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5818
;5818:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5819
;5819:			}
ADDRGP4 $2368
JUMPV
LABELV $2371
line 5820
;5820:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_GRIP)) && bs->frame_Enemy_Len < MAX_GRIP_DISTANCE && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_GRIP]][FP_GRIP] && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 64
BANDI4
CNSTI4 0
EQI4 $2373
ADDRLP4 272
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132462080
GEF4 $2373
ADDRLP4 276
CNSTI4 1756
ADDRLP4 272
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 276
INDIRP4
CNSTI4 956
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+24
ADDP4
INDIRI4
LEI4 $2373
ADDRLP4 272
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 280
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $2373
line 5821
;5821:			{
line 5822
;5822:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_GRIP;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 6
ASGNI4
line 5823
;5823:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5824
;5824:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5825
;5825:			}
ADDRGP4 $2368
JUMPV
LABELV $2373
line 5826
;5826:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_RAGE)) && g_entities[bs->client].health < 25 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_RAGE]][FP_RAGE])
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 256
BANDI4
CNSTI4 0
EQI4 $2376
ADDRLP4 288
ADDRLP4 284
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 288
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 25
GEI4 $2376
ADDRLP4 292
CNSTI4 1756
ADDRLP4 288
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 292
INDIRP4
CNSTI4 964
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+32
ADDP4
INDIRI4
LEI4 $2376
line 5827
;5827:			{
line 5828
;5828:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_RAGE;
ADDRLP4 296
CNSTI4 8
ASGNI4
CNSTI4 1756
ADDRFP4 0
INDIRP4
ADDRLP4 296
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
ADDRLP4 296
INDIRI4
ASGNI4
line 5829
;5829:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5830
;5830:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5831
;5831:			}
ADDRGP4 $2368
JUMPV
LABELV $2376
line 5832
;5832:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_DRAIN)) && bs->frame_Enemy_Len < MAX_DRAIN_DISTANCE && level.clients[bs->client].ps.fd.forcePower > 50 && InFieldOfVision(bs->viewangles, 50, a_fo) && bs->currentEnemy->client->ps.fd.forcePower > 10 && bs->currentEnemy->client->ps.fd.forceSide == FORCE_LIGHTSIDE)
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 8192
BANDI4
CNSTI4 0
EQI4 $2368
ADDRLP4 296
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1140850688
GEF4 $2368
CNSTI4 1756
ADDRLP4 296
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 50
LEI4 $2368
ADDRLP4 296
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 300
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 300
INDIRI4
CNSTI4 0
EQI4 $2368
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 10
LEI4 $2368
ADDRLP4 304
INDIRP4
CNSTI4 1176
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2368
line 5833
;5833:			{
line 5834
;5834:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_DRAIN;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 13
ASGNI4
line 5835
;5835:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5836
;5836:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5837
;5837:			}
line 5838
;5838:		}
ADDRGP4 $2368
JUMPV
LABELV $2367
line 5839
;5839:		else if (bs->cur_ps.fd.forceSide == FORCE_LIGHTSIDE)
ADDRFP4 0
INDIRP4
CNSTI4 1192
ADDP4
INDIRI4
CNSTI4 1
NEI4 $2382
line 5840
;5840:		{ //try light side powers
line 5841
;5841:			if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_TELEPATHY)) && bs->frame_Enemy_Len < MAX_TRICK_DISTANCE && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_TELEPATHY]][FP_TELEPATHY] && InFieldOfVision(bs->viewangles, 50, a_fo) && !(bs->currentEnemy->client->ps.fd.forcePowersActive & (1 << FP_SEE)))
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 32
BANDI4
CNSTI4 0
EQI4 $2384
ADDRLP4 248
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1140850688
GEF4 $2384
ADDRLP4 252
CNSTI4 1756
ADDRLP4 248
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 252
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 252
INDIRP4
CNSTI4 952
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+20
ADDP4
INDIRI4
LEI4 $2384
ADDRLP4 248
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 256
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
CNSTI4 0
ASGNI4
ADDRLP4 256
INDIRI4
ADDRLP4 260
INDIRI4
EQI4 $2384
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 836
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
ADDRLP4 260
INDIRI4
NEI4 $2384
line 5842
;5842:			{
line 5843
;5843:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_TELEPATHY;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 5
ASGNI4
line 5844
;5844:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5845
;5845:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5846
;5846:			}
ADDRGP4 $2385
JUMPV
LABELV $2384
line 5847
;5847:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_ABSORB)) && g_entities[bs->client].health < 75 && bs->currentEnemy->client->ps.fd.forceSide == FORCE_DARKSIDE && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_ABSORB]][FP_ABSORB])
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
CNSTI4 0
EQI4 $2387
ADDRLP4 268
ADDRLP4 264
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 268
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 75
GEI4 $2387
ADDRLP4 264
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 1176
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2387
ADDRLP4 272
CNSTI4 1756
ADDRLP4 268
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 272
INDIRP4
CNSTI4 972
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+40
ADDP4
INDIRI4
LEI4 $2387
line 5848
;5848:			{
line 5849
;5849:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_ABSORB;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 10
ASGNI4
line 5850
;5850:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5851
;5851:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5852
;5852:			}
ADDRGP4 $2388
JUMPV
LABELV $2387
line 5853
;5853:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_PROTECT)) && g_entities[bs->client].health < 35 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_PROTECT]][FP_PROTECT])
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $2391
ADDRLP4 280
ADDRLP4 276
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 280
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 35
GEI4 $2391
ADDRLP4 284
CNSTI4 1756
ADDRLP4 280
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 284
INDIRP4
CNSTI4 968
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+36
ADDP4
INDIRI4
LEI4 $2391
line 5854
;5854:			{
line 5855
;5855:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_PROTECT;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 9
ASGNI4
line 5856
;5856:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5857
;5857:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5858
;5858:			}
LABELV $2391
LABELV $2388
LABELV $2385
line 5859
;5859:		}
LABELV $2382
LABELV $2368
LABELV $2364
line 5861
;5860:
;5861:		if (!useTheForce)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2395
line 5862
;5862:		{ //try neutral powers
line 5863
;5863:			if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_PUSH)) && bs->cur_ps.fd.forceGripBeingGripped > level.time && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_PUSH]][FP_PUSH] && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 248
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
CNSTI4 8
ASGNI4
ADDRLP4 248
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 252
INDIRI4
BANDI4
CNSTI4 0
EQI4 $2397
ADDRLP4 248
INDIRP4
CNSTI4 1120
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2397
ADDRLP4 256
CNSTI4 1756
ADDRLP4 248
INDIRP4
ADDRLP4 252
INDIRI4
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 256
INDIRP4
CNSTI4 944
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+12
ADDP4
INDIRI4
LEI4 $2397
ADDRLP4 248
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 260
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 260
INDIRI4
CNSTI4 0
EQI4 $2397
line 5864
;5864:			{
line 5865
;5865:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_PUSH;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 3
ASGNI4
line 5866
;5866:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5867
;5867:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5868
;5868:			}
ADDRGP4 $2398
JUMPV
LABELV $2397
line 5869
;5869:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_SPEED)) && g_entities[bs->client].health < 25 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_SPEED]][FP_SPEED])
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 4
BANDI4
CNSTI4 0
EQI4 $2401
ADDRLP4 268
ADDRLP4 264
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 268
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 25
GEI4 $2401
ADDRLP4 272
CNSTI4 1756
ADDRLP4 268
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 272
INDIRP4
CNSTI4 940
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+8
ADDP4
INDIRI4
LEI4 $2401
line 5870
;5870:			{
line 5871
;5871:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_SPEED;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 2
ASGNI4
line 5872
;5872:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5873
;5873:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5874
;5874:			}
ADDRGP4 $2402
JUMPV
LABELV $2401
line 5875
;5875:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_SEE)) && BotMindTricked(bs->client, bs->currentEnemy->s.number) && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_SEE]][FP_SEE])
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 16384
BANDI4
CNSTI4 0
EQI4 $2405
ADDRLP4 276
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 276
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 280
ADDRGP4 BotMindTricked
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $2405
ADDRLP4 284
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 284
INDIRP4
CNSTI4 988
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+56
ADDP4
INDIRI4
LEI4 $2405
line 5876
;5876:			{
line 5877
;5877:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_SEE;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 14
ASGNI4
line 5878
;5878:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5879
;5879:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5880
;5880:			}
ADDRGP4 $2406
JUMPV
LABELV $2405
line 5881
;5881:			else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_PULL)) && bs->frame_Enemy_Len < 256 && level.clients[bs->client].ps.fd.forcePower > 75 && InFieldOfVision(bs->viewangles, 50, a_fo))
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 16
BANDI4
CNSTI4 0
EQI4 $2408
ADDRLP4 288
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132462080
GEF4 $2408
CNSTI4 1756
ADDRLP4 288
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 75
LEI4 $2408
ADDRLP4 288
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1112014848
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 292
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 0
EQI4 $2408
line 5882
;5882:			{
line 5883
;5883:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_PULL;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 4
ASGNI4
line 5884
;5884:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5885
;5885:				forceHostile = 1;
ADDRLP4 16
CNSTI4 1
ASGNI4
line 5886
;5886:			}
LABELV $2408
LABELV $2406
LABELV $2402
LABELV $2398
line 5887
;5887:		}
LABELV $2395
line 5888
;5888:	}
LABELV $2358
line 5890
;5889:
;5890:	if (!useTheForce)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2410
line 5891
;5891:	{ //try powers that we don't care if we have an enemy for
line 5892
;5892:		if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_HEAL)) && g_entities[bs->client].health < 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_HEAL]][FP_HEAL] && bs->cur_ps.fd.forcePowerLevel[FP_HEAL] > FORCE_LEVEL_1)
ADDRLP4 216
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 220
CNSTI4 1
ASGNI4
ADDRLP4 216
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
ADDRLP4 220
INDIRI4
BANDI4
CNSTI4 0
EQI4 $2412
ADDRLP4 224
ADDRLP4 216
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 224
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 50
GEI4 $2412
ADDRLP4 228
CNSTI4 1756
ADDRLP4 224
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 228
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 228
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded
ADDP4
INDIRI4
LEI4 $2412
ADDRLP4 216
INDIRP4
CNSTI4 948
ADDP4
INDIRI4
ADDRLP4 220
INDIRI4
LEI4 $2412
line 5893
;5893:		{
line 5894
;5894:			level.clients[bs->client].ps.fd.forcePowerSelected = FP_HEAL;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 0
ASGNI4
line 5895
;5895:			useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5896
;5896:			forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5897
;5897:		}
ADDRGP4 $2413
JUMPV
LABELV $2412
line 5898
;5898:		else if ((bs->cur_ps.fd.forcePowersKnown & (1 << FP_HEAL)) && g_entities[bs->client].health < 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_HEAL]][FP_HEAL] && !bs->currentEnemy && bs->isCamping > level.time)
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 232
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $2415
ADDRLP4 236
ADDRLP4 232
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 236
INDIRI4
MULI4
ADDRGP4 g_entities+676
ADDP4
INDIRI4
CNSTI4 50
GEI4 $2415
ADDRLP4 240
CNSTI4 1756
ADDRLP4 236
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 240
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 240
INDIRP4
CNSTI4 932
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded
ADDP4
INDIRI4
LEI4 $2415
ADDRLP4 232
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2415
ADDRLP4 232
INDIRP4
CNSTI4 2052
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2415
line 5899
;5899:		{ //only meditate and heal if we're camping
line 5900
;5900:			level.clients[bs->client].ps.fd.forcePowerSelected = FP_HEAL;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 0
ASGNI4
line 5901
;5901:			useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 5902
;5902:			forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5903
;5903:		}
LABELV $2415
LABELV $2413
line 5904
;5904:	}
LABELV $2410
line 5906
;5905:
;5906:	if (useTheForce && forceHostile)
ADDRLP4 216
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 216
INDIRI4
EQI4 $2419
ADDRLP4 16
INDIRI4
ADDRLP4 216
INDIRI4
EQI4 $2419
line 5907
;5907:	{
line 5908
;5908:		if (bs->currentEnemy && bs->currentEnemy->client &&
ADDRLP4 220
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 224
ADDRLP4 220
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 228
CNSTU4 0
ASGNU4
ADDRLP4 224
INDIRP4
CVPU4 4
ADDRLP4 228
INDIRU4
EQU4 $2421
ADDRLP4 224
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 228
INDIRU4
EQU4 $2421
ADDRLP4 232
ADDRLP4 220
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 232
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 224
INDIRP4
ARGP4
CNSTI4 1756
ADDRLP4 232
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
INDIRI4
ARGI4
ADDRLP4 236
ADDRGP4 ForcePowerUsableOn
CALLI4
ASGNI4
ADDRLP4 236
INDIRI4
CNSTI4 0
NEI4 $2421
line 5910
;5909:			!ForcePowerUsableOn(&g_entities[bs->client], bs->currentEnemy, level.clients[bs->client].ps.fd.forcePowerSelected))
;5910:		{
line 5911
;5911:			useTheForce = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 5912
;5912:			forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 5913
;5913:		}
LABELV $2421
line 5914
;5914:	}
LABELV $2419
line 5916
;5915:
;5916:	doingFallback = 0;
ADDRLP4 32
CNSTI4 0
ASGNI4
line 5918
;5917:
;5918:	bs->deathActivitiesDone = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2608
ADDP4
CNSTI4 0
ASGNI4
line 5920
;5919:
;5920:	if (BotUseInventoryItem(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 220
ADDRGP4 BotUseInventoryItem
CALLI4
ASGNI4
ADDRLP4 220
INDIRI4
CNSTI4 0
EQI4 $2423
line 5921
;5921:	{
line 5922
;5922:		if (rand()%10 < 5)
ADDRLP4 224
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 224
INDIRI4
CNSTI4 10
MODI4
CNSTI4 5
GEI4 $2425
line 5923
;5923:		{
line 5924
;5924:			trap_EA_Use(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Use
CALLV
pop
line 5925
;5925:		}
LABELV $2425
line 5926
;5926:	}
LABELV $2423
line 5928
;5927:
;5928:	if (bs->cur_ps.ammo[weaponData[bs->cur_ps.weapon].ammoIndex] < weaponData[bs->cur_ps.weapon].energyPerShot)
ADDRLP4 224
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 228
CNSTI4 56
ADDRLP4 224
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 228
INDIRI4
ADDRGP4 weaponData
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 224
INDIRP4
CNSTI4 424
ADDP4
ADDP4
INDIRI4
ADDRLP4 228
INDIRI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
GEI4 $2427
line 5929
;5929:	{
line 5930
;5930:		if (BotTryAnotherWeapon(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 232
ADDRGP4 BotTryAnotherWeapon
CALLI4
ASGNI4
ADDRLP4 232
INDIRI4
CNSTI4 0
EQI4 $2428
line 5931
;5931:		{
line 5932
;5932:			return;
ADDRGP4 $2317
JUMPV
line 5934
;5933:		}
;5934:	}
LABELV $2427
line 5936
;5935:	else
;5936:	{
line 5937
;5937:		if (bs->currentEnemy && bs->lastVisibleEnemyIndex == bs->currentEnemy->s.number &&
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
ADDRLP4 232
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 236
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2432
ADDRLP4 232
INDIRP4
CNSTI4 1944
ADDP4
INDIRI4
ADDRLP4 236
INDIRP4
INDIRI4
NEI4 $2432
ADDRLP4 240
CNSTI4 0
ASGNI4
ADDRLP4 232
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 240
INDIRI4
EQI4 $2432
ADDRLP4 232
INDIRP4
CNSTI4 2272
ADDP4
INDIRI4
ADDRLP4 240
INDIRI4
EQI4 $2432
line 5939
;5938:			bs->frame_Enemy_Vis && bs->forceWeaponSelect /*&& bs->plantContinue < level.time*/)
;5939:		{
line 5940
;5940:			bs->forceWeaponSelect = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
CNSTI4 0
ASGNI4
line 5941
;5941:		}
LABELV $2432
line 5943
;5942:
;5943:		if (bs->plantContinue > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2288
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2434
line 5944
;5944:		{
line 5945
;5945:			bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 5946
;5946:			bs->destinationGrabTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
CNSTF4 0
ASGNF4
line 5947
;5947:		}
LABELV $2434
line 5949
;5948:
;5949:		if (!bs->forceWeaponSelect && bs->cur_ps.hasDetPackPlanted && bs->plantKillEmAll > level.time)
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 248
CNSTI4 0
ASGNI4
ADDRLP4 244
INDIRP4
CNSTI4 2272
ADDP4
INDIRI4
ADDRLP4 248
INDIRI4
NEI4 $2437
ADDRLP4 244
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRLP4 248
INDIRI4
EQI4 $2437
ADDRLP4 244
INDIRP4
CNSTI4 2292
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2437
line 5950
;5950:		{
line 5951
;5951:			bs->forceWeaponSelect = WP_DET_PACK;
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
CNSTI4 13
ASGNI4
line 5952
;5952:		}
LABELV $2437
line 5954
;5953:
;5954:		if (bs->forceWeaponSelect)
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2440
line 5955
;5955:		{
line 5956
;5956:			selResult = BotSelectChoiceWeapon(bs, bs->forceWeaponSelect, 1);
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 252
INDIRP4
ARGP4
ADDRLP4 252
INDIRP4
CNSTI4 2272
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 256
ADDRGP4 BotSelectChoiceWeapon
CALLI4
ASGNI4
ADDRLP4 104
ADDRLP4 256
INDIRI4
ASGNI4
line 5957
;5957:		}
LABELV $2440
line 5959
;5958:
;5959:		if (selResult)
ADDRLP4 104
INDIRI4
CNSTI4 0
EQI4 $2442
line 5960
;5960:		{
line 5961
;5961:			if (selResult == 2)
ADDRLP4 104
INDIRI4
CNSTI4 2
NEI4 $2443
line 5962
;5962:			{ //newly selected
line 5963
;5963:				return;
ADDRGP4 $2317
JUMPV
line 5965
;5964:			}
;5965:		}
LABELV $2442
line 5966
;5966:		else if (BotSelectIdealWeapon(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 252
ADDRGP4 BotSelectIdealWeapon
CALLI4
ASGNI4
ADDRLP4 252
INDIRI4
CNSTI4 0
EQI4 $2446
line 5967
;5967:		{
line 5968
;5968:			return;
ADDRGP4 $2317
JUMPV
LABELV $2446
LABELV $2443
line 5970
;5969:		}
;5970:	}
LABELV $2428
line 5976
;5971:	/*if (BotSelectMelee(bs))
;5972:	{
;5973:		return;
;5974:	}*/
;5975:
;5976:	reaction = bs->skills.reflex/bs->settings.skill;
ADDRLP4 232
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 232
INDIRP4
CNSTI4 2304
ADDP4
INDIRI4
CVIF4 4
ADDRLP4 232
INDIRP4
CNSTI4 1556
ADDP4
INDIRF4
DIVF4
ASGNF4
line 5978
;5977:
;5978:	if (reaction < 0)
ADDRLP4 48
INDIRF4
CNSTF4 0
GEF4 $2448
line 5979
;5979:	{
line 5980
;5980:		reaction = 0;
ADDRLP4 48
CNSTF4 0
ASGNF4
line 5981
;5981:	}
LABELV $2448
line 5982
;5982:	if (reaction > 2000)
ADDRLP4 48
INDIRF4
CNSTF4 1157234688
LEF4 $2450
line 5983
;5983:	{
line 5984
;5984:		reaction = 2000;
ADDRLP4 48
CNSTF4 1157234688
ASGNF4
line 5985
;5985:	}
LABELV $2450
line 5987
;5986:
;5987:	if (!bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2452
line 5988
;5988:	{
line 5989
;5989:		bs->timeToReact = level.time + reaction;
ADDRFP4 0
INDIRP4
CNSTI4 1980
ADDP4
ADDRGP4 level+32
INDIRI4
CVIF4 4
ADDRLP4 48
INDIRF4
ADDF4
ASGNF4
line 5990
;5990:	}
LABELV $2452
line 5992
;5991:
;5992:	if (bs->cur_ps.weapon == WP_DET_PACK && bs->cur_ps.hasDetPackPlanted && bs->plantKillEmAll > level.time)
ADDRLP4 236
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 236
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 13
NEI4 $2455
ADDRLP4 236
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2455
ADDRLP4 236
INDIRP4
CNSTI4 2292
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2455
line 5993
;5993:	{
line 5994
;5994:		bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 5995
;5995:	}
LABELV $2455
line 5997
;5996:
;5997:	if (bs->wpCamping)
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2458
line 5998
;5998:	{
line 5999
;5999:		if (bs->isCamping < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2460
line 6000
;6000:		{
line 6001
;6001:			bs->wpCamping = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
CNSTP4 0
ASGNP4
line 6002
;6002:			bs->isCamping = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
CNSTF4 0
ASGNF4
line 6003
;6003:		}
LABELV $2460
line 6005
;6004:
;6005:		if (bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 240
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2463
ADDRLP4 240
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2463
line 6006
;6006:		{
line 6007
;6007:			bs->wpCamping = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
CNSTP4 0
ASGNP4
line 6008
;6008:			bs->isCamping = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2052
ADDP4
CNSTF4 0
ASGNF4
line 6009
;6009:		}
LABELV $2463
line 6010
;6010:	}
LABELV $2458
line 6012
;6011:
;6012:	if (bs->wpCurrent &&
ADDRLP4 240
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 240
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2465
ADDRLP4 240
INDIRP4
CNSTI4 1960
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LTF4 $2469
ADDRLP4 240
INDIRP4
CNSTI4 1964
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2465
LABELV $2469
line 6014
;6013:		(bs->wpSeenTime < level.time || bs->wpTravelTime < level.time))
;6014:	{
line 6015
;6015:		bs->wpCurrent = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
CNSTP4 0
ASGNP4
line 6016
;6016:	}
LABELV $2465
line 6018
;6017:
;6018:	if (bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2470
line 6019
;6019:	{
line 6020
;6020:		if (bs->enemySeenTime < level.time ||
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 1984
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LTF4 $2475
ADDRLP4 244
INDIRP4
ARGP4
ADDRLP4 244
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ARGP4
ADDRLP4 248
ADDRGP4 PassStandardEnemyChecks
CALLI4
ASGNI4
ADDRLP4 248
INDIRI4
CNSTI4 0
NEI4 $2472
LABELV $2475
line 6022
;6021:			!PassStandardEnemyChecks(bs, bs->currentEnemy))
;6022:		{
line 6023
;6023:			if (bs->revengeEnemy == bs->currentEnemy &&
ADDRLP4 252
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
ADDRLP4 252
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 260
ADDRLP4 256
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 252
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 260
INDIRU4
NEU4 $2476
ADDRLP4 256
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 1
GEI4 $2476
ADDRLP4 264
ADDRLP4 252
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 264
INDIRU4
CNSTU4 0
EQU4 $2476
ADDRLP4 264
INDIRU4
ADDRLP4 260
INDIRU4
NEU4 $2476
line 6026
;6024:				bs->currentEnemy->health < 1 &&
;6025:				bs->lastAttacked && bs->lastAttacked == bs->currentEnemy)
;6026:			{
line 6028
;6027:				//CHAT: Destroyed hated one [KilledHatedOne section]
;6028:				bs->chatObject = bs->revengeEnemy;
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 2232
ADDP4
ADDRLP4 268
INDIRP4
CNSTI4 1808
ADDP4
INDIRP4
ASGNP4
line 6029
;6029:				bs->chatAltObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 6030
;6030:				BotDoChat(bs, "KilledHatedOne", 1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2478
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 6031
;6031:				bs->revengeEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1808
ADDP4
CNSTP4 0
ASGNP4
line 6032
;6032:				bs->revengeHateLevel = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1852
ADDP4
CNSTI4 0
ASGNI4
line 6033
;6033:			}
ADDRGP4 $2477
JUMPV
LABELV $2476
line 6034
;6034:			else if (bs->currentEnemy->health < 1 && PassLovedOneCheck(bs, bs->currentEnemy) &&
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
ADDRLP4 268
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 1
GEI4 $2479
ADDRLP4 268
INDIRP4
ARGP4
ADDRLP4 272
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 PassLovedOneCheck
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
EQI4 $2479
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
ADDRLP4 280
INDIRP4
CNSTI4 1820
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 284
INDIRU4
CNSTU4 0
EQU4 $2479
ADDRLP4 284
INDIRU4
ADDRLP4 280
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
NEU4 $2479
line 6036
;6035:				bs->lastAttacked && bs->lastAttacked == bs->currentEnemy)
;6036:			{
line 6038
;6037:				//CHAT: Killed
;6038:				bs->chatObject = bs->currentEnemy;
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 2232
ADDP4
ADDRLP4 288
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
line 6039
;6039:				bs->chatAltObject = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 2236
ADDP4
CNSTP4 0
ASGNP4
line 6040
;6040:				BotDoChat(bs, "Killed", 0);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 $2481
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 BotDoChat
CALLI4
pop
line 6041
;6041:			}
LABELV $2479
LABELV $2477
line 6043
;6042:
;6043:			bs->currentEnemy = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTP4 0
ASGNP4
line 6044
;6044:		}
LABELV $2472
line 6045
;6045:	}
LABELV $2470
line 6086
;6046:
;6047:	/*
;6048:	if (bs->currentEnemy && bs->currentEnemy->client &&
;6049:		bs->cur_ps.weapon == WP_SABER &&
;6050:		g_privateDuel.integer &&
;6051:		bs->frame_Enemy_Vis &&
;6052:		bs->frame_Enemy_Len < 400 &&
;6053:		bs->currentEnemy->client->ps.weapon == WP_SABER &&
;6054:		bs->currentEnemy->client->ps.saberHolstered)
;6055:	{
;6056:		vec3_t e_ang_vec;
;6057:
;6058:		VectorSubtract(bs->currentEnemy->client->ps.origin, bs->eye, e_ang_vec);
;6059:
;6060:		if (InFieldOfVision(bs->viewangles, 100, e_ang_vec))
;6061:		{ //Our enemy has his saber holstered and has challenged us to a duel, so challenge him back
;6062:			if (!bs->cur_ps.saberHolstered)
;6063:			{
;6064:				Cmd_ToggleSaber_f(&g_entities[bs->client]);
;6065:			}
;6066:			else
;6067:			{
;6068:				if (bs->currentEnemy->client->ps.duelIndex == bs->client &&
;6069:					bs->currentEnemy->client->ps.duelTime > level.time &&
;6070:					!bs->cur_ps.duelInProgress)
;6071:				{
;6072:					Cmd_EngageDuel_f(&g_entities[bs->client]);
;6073:				}
;6074:			}
;6075:
;6076:			bs->doAttack = 0;
;6077:			bs->doAltAttack = 0;
;6078:			bs->botChallengingTime = level.time + 100;
;6079:			bs->beStill = level.time + 100;
;6080:		}
;6081:	}
;6082:	*/
;6083:	//Apparently this "allows you to cheese" when fighting against bots. I'm not sure why you'd want to con bots
;6084:	//into an easy kill, since they're bots and all. But whatever.
;6085:
;6086:	if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2482
line 6087
;6087:	{
line 6088
;6088:		wp = GetNearestVisibleWP(bs->origin, bs->client);
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 244
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 248
ADDRGP4 GetNearestVisibleWP
CALLI4
ASGNI4
ADDRLP4 144
ADDRLP4 248
INDIRI4
ASGNI4
line 6090
;6089:
;6090:		if (wp != -1)
ADDRLP4 144
INDIRI4
CNSTI4 -1
EQI4 $2484
line 6091
;6091:		{
line 6092
;6092:			bs->wpCurrent = gWPArray[wp];
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
ADDRLP4 144
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 6093
;6093:			bs->wpSeenTime = level.time + 1500;
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
CVIF4 4
ASGNF4
line 6094
;6094:			bs->wpTravelTime = level.time + 10000; //never take more than 10 seconds to travel to a waypoint
ADDRFP4 0
INDIRP4
CNSTI4 1964
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 6095
;6095:		}
LABELV $2484
line 6096
;6096:	}
LABELV $2482
line 6098
;6097:
;6098:	if (bs->enemySeenTime < level.time || !bs->frame_Enemy_Vis || !bs->currentEnemy ||
ADDRLP4 244
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 244
INDIRP4
CNSTI4 1984
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LTF4 $2493
ADDRLP4 244
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2493
ADDRLP4 248
ADDRLP4 244
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
ASGNU4
ADDRLP4 252
CNSTU4 0
ASGNU4
ADDRLP4 248
INDIRU4
ADDRLP4 252
INDIRU4
EQU4 $2493
ADDRLP4 248
INDIRU4
ADDRLP4 252
INDIRU4
EQU4 $2488
LABELV $2493
line 6100
;6099:		(bs->currentEnemy /*&& bs->cur_ps.weapon == WP_SABER && bs->frame_Enemy_Len > 300*/))
;6100:	{
line 6101
;6101:		enemy = ScanForEnemies(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 256
ADDRGP4 ScanForEnemies
CALLI4
ASGNI4
ADDRLP4 148
ADDRLP4 256
INDIRI4
ASGNI4
line 6103
;6102:
;6103:		if (enemy != -1)
ADDRLP4 148
INDIRI4
CNSTI4 -1
EQI4 $2494
line 6104
;6104:		{
line 6105
;6105:			bs->currentEnemy = &g_entities[enemy];
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
CNSTI4 828
ADDRLP4 148
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ASGNP4
line 6106
;6106:			bs->enemySeenTime = level.time + ENEMY_FORGET_MS;
ADDRFP4 0
INDIRP4
CNSTI4 1984
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 6107
;6107:		}
LABELV $2494
line 6108
;6108:	}
LABELV $2488
line 6110
;6109:
;6110:	if (!bs->squadLeader && !bs->isSquadLeader)
ADDRLP4 256
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 256
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2497
ADDRLP4 256
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2497
line 6111
;6111:	{
line 6112
;6112:		BotScanForLeader(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotScanForLeader
CALLV
pop
line 6113
;6113:	}
LABELV $2497
line 6115
;6114:
;6115:	if (!bs->squadLeader && bs->squadCannotLead < level.time)
ADDRLP4 260
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 260
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2499
ADDRLP4 260
INDIRP4
CNSTI4 1864
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2499
line 6116
;6116:	{ //if still no leader after scanning, then become a squad leader
line 6117
;6117:		bs->isSquadLeader = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1856
ADDP4
CNSTI4 1
ASGNI4
line 6118
;6118:	}
LABELV $2499
line 6120
;6119:
;6120:	if (bs->isSquadLeader && bs->squadLeader)
ADDRLP4 264
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 264
INDIRP4
CNSTI4 1856
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2502
ADDRLP4 264
INDIRP4
CNSTI4 1812
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2502
line 6121
;6121:	{ //we don't follow anyone if we are a leader
line 6122
;6122:		bs->squadLeader = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1812
ADDP4
CNSTP4 0
ASGNP4
line 6123
;6123:	}
LABELV $2502
line 6126
;6124:
;6125:	//ESTABLISH VISIBILITIES AND DISTANCES FOR THE WHOLE FRAME HERE
;6126:	if (bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2504
line 6127
;6127:	{
line 6128
;6128:		VectorSubtract(bs->wpCurrent->origin, bs->origin, a);
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
ADDRLP4 268
INDIRP4
CNSTI4 1872
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 272
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 268
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 272
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 268
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 276
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6129
;6129:		bs->frame_Waypoint_Len = VectorLength(a);
ADDRLP4 0
ARGP4
ADDRLP4 280
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 2032
ADDP4
ADDRLP4 280
INDIRF4
ASGNF4
line 6131
;6130:
;6131:		visResult = WPOrgVisible(&g_entities[bs->client], bs->origin, bs->wpCurrent->origin, bs->client);
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
ADDRLP4 284
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ASGNI4
CNSTI4 828
ADDRLP4 288
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRLP4 284
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 284
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ARGP4
ADDRLP4 288
INDIRI4
ARGI4
ADDRLP4 292
ADDRGP4 WPOrgVisible
CALLI4
ASGNI4
ADDRLP4 100
ADDRLP4 292
INDIRI4
ASGNI4
line 6133
;6132:
;6133:		if (visResult == 2)
ADDRLP4 100
INDIRI4
CNSTI4 2
NEI4 $2508
line 6134
;6134:		{
line 6135
;6135:			bs->frame_Waypoint_Vis = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2036
ADDP4
CNSTI4 0
ASGNI4
line 6136
;6136:			bs->wpSeenTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
CNSTF4 0
ASGNF4
line 6137
;6137:			bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 6138
;6138:			bs->wpDestIgnoreTime = level.time + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 1976
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 5000
ADDI4
CVIF4 4
ASGNF4
line 6140
;6139:
;6140:			if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2511
line 6141
;6141:			{
line 6142
;6142:				bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 6143
;6143:			}
ADDRGP4 $2509
JUMPV
LABELV $2511
line 6145
;6144:			else
;6145:			{
line 6146
;6146:				bs->wpDirection = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 1
ASGNI4
line 6147
;6147:			}
line 6148
;6148:		}
ADDRGP4 $2509
JUMPV
LABELV $2508
line 6149
;6149:		else if (visResult)
ADDRLP4 100
INDIRI4
CNSTI4 0
EQI4 $2513
line 6150
;6150:		{
line 6151
;6151:			bs->frame_Waypoint_Vis = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2036
ADDP4
CNSTI4 1
ASGNI4
line 6152
;6152:		}
ADDRGP4 $2514
JUMPV
LABELV $2513
line 6154
;6153:		else
;6154:		{
line 6155
;6155:			bs->frame_Waypoint_Vis = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2036
ADDP4
CNSTI4 0
ASGNI4
line 6156
;6156:		}
LABELV $2514
LABELV $2509
line 6157
;6157:	}
LABELV $2504
line 6159
;6158:
;6159:	if (bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2515
line 6160
;6160:	{
line 6161
;6161:		if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2517
line 6162
;6162:		{
line 6163
;6163:			VectorCopy(bs->currentEnemy->client->ps.origin, eorg);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 6164
;6164:			eorg[2] += bs->currentEnemy->client->ps.viewheight;
ADDRLP4 56+8
ADDRLP4 56+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 6165
;6165:		}
ADDRGP4 $2518
JUMPV
LABELV $2517
line 6167
;6166:		else
;6167:		{
line 6168
;6168:			VectorCopy(bs->currentEnemy->s.origin, eorg);
ADDRLP4 56
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 92
ADDP4
INDIRB
ASGNB 12
line 6169
;6169:		}
LABELV $2518
line 6171
;6170:
;6171:		VectorSubtract(eorg, bs->eye, a);
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 56
INDIRF4
ADDRLP4 268
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 56+4
INDIRF4
ADDRLP4 268
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 56+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6172
;6172:		bs->frame_Enemy_Len = VectorLength(a);
ADDRLP4 0
ARGP4
ADDRLP4 272
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
ADDRLP4 272
INDIRF4
ASGNF4
line 6174
;6173:
;6174:		if (OrgVisible(bs->eye, eorg, bs->client))
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 1732
ADDP4
ARGP4
ADDRLP4 56
ARGP4
ADDRLP4 276
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 280
ADDRGP4 OrgVisible
CALLI4
ASGNI4
ADDRLP4 280
INDIRI4
CNSTI4 0
EQI4 $2524
line 6175
;6175:		{
line 6176
;6176:			bs->frame_Enemy_Vis = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
CNSTI4 1
ASGNI4
line 6177
;6177:			VectorCopy(eorg, bs->lastEnemySpotted);
ADDRFP4 0
INDIRP4
CNSTI4 1920
ADDP4
ADDRLP4 56
INDIRB
ASGNB 12
line 6178
;6178:			VectorCopy(bs->origin, bs->hereWhenSpotted);
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 1932
ADDP4
ADDRLP4 284
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 6179
;6179:			bs->lastVisibleEnemyIndex = bs->currentEnemy->s.number;
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 1944
ADDP4
ADDRLP4 288
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
INDIRI4
ASGNI4
line 6181
;6180:			//VectorCopy(bs->eye, bs->lastEnemySpotted);
;6181:			bs->hitSpotted = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1948
ADDP4
CNSTI4 0
ASGNI4
line 6182
;6182:		}
ADDRGP4 $2516
JUMPV
LABELV $2524
line 6184
;6183:		else
;6184:		{
line 6185
;6185:			bs->frame_Enemy_Vis = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
CNSTI4 0
ASGNI4
line 6186
;6186:		}
line 6187
;6187:	}
ADDRGP4 $2516
JUMPV
LABELV $2515
line 6189
;6188:	else
;6189:	{
line 6190
;6190:		bs->lastVisibleEnemyIndex = ENTITYNUM_NONE;
ADDRFP4 0
INDIRP4
CNSTI4 1944
ADDP4
CNSTI4 1023
ASGNI4
line 6191
;6191:	}
LABELV $2516
line 6194
;6192:	//END
;6193:
;6194:	if (bs->frame_Enemy_Vis)
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2526
line 6195
;6195:	{
line 6196
;6196:		bs->enemySeenTime = level.time + ENEMY_FORGET_MS;
ADDRFP4 0
INDIRP4
CNSTI4 1984
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 6197
;6197:	}
LABELV $2526
line 6199
;6198:
;6199:	if (bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2529
line 6200
;6200:	{
line 6201
;6201:		WPConstantRoutine(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 WPConstantRoutine
CALLV
pop
line 6203
;6202:
;6203:		if (!bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2531
line 6204
;6204:		{ //WPConstantRoutine has the ability to nullify the waypoint if it fails certain checks, so..
line 6205
;6205:			return;
ADDRGP4 $2317
JUMPV
LABELV $2531
line 6208
;6206:		}
;6207:
;6208:		if (bs->wpCurrent->flags & WPFLAG_WAITFORFUNC)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 4096
BANDI4
CNSTI4 0
EQI4 $2533
line 6209
;6209:		{
line 6210
;6210:			if (!CheckForFunc(bs->wpCurrent->origin, -1))
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 268
ADDRGP4 CheckForFunc
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
NEI4 $2535
line 6211
;6211:			{
line 6212
;6212:				bs->beStill = level.time + 500; //no func brush under.. wait
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 6213
;6213:			}
LABELV $2535
line 6214
;6214:		}
LABELV $2533
line 6215
;6215:		if (bs->wpCurrent->flags & WPFLAG_NOMOVEFUNC)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2097152
BANDI4
CNSTI4 0
EQI4 $2538
line 6216
;6216:		{
line 6217
;6217:			if (CheckForFunc(bs->wpCurrent->origin, -1))
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 268
ADDRGP4 CheckForFunc
CALLI4
ASGNI4
ADDRLP4 268
INDIRI4
CNSTI4 0
EQI4 $2540
line 6218
;6218:			{
line 6219
;6219:				bs->beStill = level.time + 500; //func brush under.. wait
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 6220
;6220:			}
LABELV $2540
line 6221
;6221:		}
LABELV $2538
line 6223
;6222:
;6223:		if (bs->frame_Waypoint_Vis || (bs->wpCurrent->flags & WPFLAG_NOVIS))
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
CNSTI4 0
ASGNI4
ADDRLP4 268
INDIRP4
CNSTI4 2036
ADDP4
INDIRI4
ADDRLP4 272
INDIRI4
NEI4 $2545
ADDRLP4 268
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 1024
BANDI4
ADDRLP4 272
INDIRI4
EQI4 $2543
LABELV $2545
line 6224
;6224:		{
line 6225
;6225:			bs->wpSeenTime = level.time + 1500; //if we lose sight of the point, we have 1.5 seconds to regain it before we drop it
ADDRFP4 0
INDIRP4
CNSTI4 1960
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
CVIF4 4
ASGNF4
line 6226
;6226:		}
LABELV $2543
line 6227
;6227:		VectorCopy(bs->wpCurrent->origin, bs->goalPosition);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 276
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
INDIRB
ASGNB 12
line 6228
;6228:		if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2547
line 6229
;6229:		{
line 6230
;6230:			goalWPIndex = bs->wpCurrent->index-1;
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6231
;6231:		}
ADDRGP4 $2548
JUMPV
LABELV $2547
line 6233
;6232:		else
;6233:		{
line 6234
;6234:			goalWPIndex = bs->wpCurrent->index+1;
ADDRLP4 136
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6235
;6235:		}
LABELV $2548
line 6237
;6236:
;6237:		if (bs->wpCamping)
ADDRFP4 0
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2549
line 6238
;6238:		{
line 6239
;6239:			VectorSubtract(bs->wpCampingTo->origin, bs->origin, a);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
ADDRLP4 280
INDIRP4
CNSTI4 2060
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 284
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 284
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 288
INDIRP4
CNSTI4 2060
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 288
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6240
;6240:			vectoangles(a, ang);
ADDRLP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6241
;6241:			VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6243
;6242:
;6243:			VectorSubtract(bs->origin, bs->wpCamping->origin, a);
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
ADDRLP4 292
INDIRP4
CNSTI4 2056
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 292
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 296
INDIRP4
INDIRP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 292
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 296
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 300
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 300
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6244
;6244:			if (VectorLength(a) < 64)
ADDRLP4 0
ARGP4
ADDRLP4 304
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 304
INDIRF4
CNSTF4 1115684864
GEF4 $2550
line 6245
;6245:			{
line 6246
;6246:				VectorCopy(bs->wpCamping->origin, bs->goalPosition);
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 308
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 308
INDIRP4
CNSTI4 2056
ADDP4
INDIRP4
INDIRB
ASGNB 12
line 6247
;6247:				bs->beStill = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ASGNF4
line 6249
;6248:
;6249:				if (!bs->campStanding)
ADDRFP4 0
INDIRP4
CNSTI4 2064
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2550
line 6250
;6250:				{
line 6251
;6251:					bs->duckTime = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 1996
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
CVIF4 4
ASGNF4
line 6252
;6252:				}
line 6253
;6253:			}
line 6254
;6254:		}
ADDRGP4 $2550
JUMPV
LABELV $2549
line 6255
;6255:		else if (gWPArray[goalWPIndex] && gWPArray[goalWPIndex]->inuse &&
ADDRLP4 280
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 280
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2561
ADDRLP4 284
CNSTI4 0
ASGNI4
ADDRLP4 280
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 284
INDIRI4
EQI4 $2561
ADDRGP4 gLevelFlags
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 284
INDIRI4
NEI4 $2561
line 6257
;6256:			!(gLevelFlags & LEVELFLAG_NOPOINTPREDICTION))
;6257:		{
line 6258
;6258:			VectorSubtract(gWPArray[goalWPIndex]->origin, bs->origin, a);
ADDRLP4 288
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
ASGNP4
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 288
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 288
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 292
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 136
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6259
;6259:			vectoangles(a, ang);
ADDRLP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6260
;6260:			VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6261
;6261:		}
ADDRGP4 $2562
JUMPV
LABELV $2561
line 6263
;6262:		else
;6263:		{
line 6264
;6264:			VectorSubtract(bs->wpCurrent->origin, bs->origin, a);
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
ADDRLP4 288
INDIRP4
CNSTI4 1872
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 292
INDIRP4
INDIRP4
INDIRF4
ADDRLP4 288
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 292
INDIRP4
INDIRP4
CNSTI4 4
ADDP4
INDIRF4
ADDRLP4 288
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 296
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 296
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6265
;6265:			vectoangles(a, ang);
ADDRLP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6266
;6266:			VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6267
;6267:		}
LABELV $2562
LABELV $2550
line 6269
;6268:
;6269:		if (bs->destinationGrabTime < level.time /*&& (!bs->wpDestination || (bs->currentEnemy && bs->frame_Enemy_Vis))*/)
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2567
line 6270
;6270:		{
line 6271
;6271:			GetIdealDestination(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 GetIdealDestination
CALLV
pop
line 6272
;6272:		}
LABELV $2567
line 6274
;6273:		
;6274:		if (bs->wpCurrent && bs->wpDestination)
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
CNSTU4 0
ASGNU4
ADDRLP4 288
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 292
INDIRU4
EQU4 $2570
ADDRLP4 288
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 292
INDIRU4
EQU4 $2570
line 6275
;6275:		{
line 6276
;6276:			if (TotalTrailDistance(bs->wpCurrent->index, bs->wpDestination->index, bs) == -1)
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
CNSTI4 16
ASGNI4
ADDRLP4 296
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
ADDRLP4 300
INDIRI4
ADDP4
INDIRI4
ARGI4
ADDRLP4 296
INDIRP4
ARGP4
ADDRLP4 304
ADDRGP4 TotalTrailDistance
CALLF4
ASGNF4
ADDRLP4 304
INDIRF4
CNSTF4 3212836864
NEF4 $2572
line 6277
;6277:			{
line 6278
;6278:				bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 6279
;6279:				bs->destinationGrabTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 6280
;6280:			}
LABELV $2572
line 6281
;6281:		}
LABELV $2570
line 6283
;6282:
;6283:		if (bs->frame_Waypoint_Len < BOT_WPTOUCH_DISTANCE)
ADDRFP4 0
INDIRP4
CNSTI4 2032
ADDP4
INDIRF4
CNSTF4 1107296256
GEF4 $2530
line 6284
;6284:		{
line 6285
;6285:			WPTouchRoutine(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 WPTouchRoutine
CALLV
pop
line 6287
;6286:
;6287:			if (!bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2577
line 6288
;6288:			{
line 6289
;6289:				desiredIndex = bs->wpCurrent->index+1;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 6290
;6290:			}
ADDRGP4 $2578
JUMPV
LABELV $2577
line 6292
;6291:			else
;6292:			{
line 6293
;6293:				desiredIndex = bs->wpCurrent->index-1;
ADDRLP4 120
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 16
ADDP4
INDIRI4
CNSTI4 1
SUBI4
ASGNI4
line 6294
;6294:			}
LABELV $2578
line 6296
;6295:
;6296:			if (gWPArray[desiredIndex] &&
ADDRLP4 296
ADDRLP4 120
INDIRI4
ASGNI4
ADDRLP4 300
ADDRLP4 296
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
ADDRLP4 300
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2579
ADDRLP4 304
CNSTI4 0
ASGNI4
ADDRLP4 300
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
ADDRLP4 304
INDIRI4
EQI4 $2579
ADDRLP4 296
INDIRI4
ADDRGP4 gWPNum
INDIRI4
GEI4 $2579
ADDRLP4 296
INDIRI4
ADDRLP4 304
INDIRI4
LTI4 $2579
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 296
INDIRI4
ARGI4
ADDRLP4 308
ADDRGP4 PassWayCheck
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $2579
line 6301
;6297:				gWPArray[desiredIndex]->inuse &&
;6298:				desiredIndex < gWPNum &&
;6299:				desiredIndex >= 0 &&
;6300:				PassWayCheck(bs, desiredIndex))
;6301:			{
line 6302
;6302:				bs->wpCurrent = gWPArray[desiredIndex];
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
ADDRLP4 120
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 gWPArray
ADDP4
INDIRP4
ASGNP4
line 6303
;6303:			}
ADDRGP4 $2530
JUMPV
LABELV $2579
line 6305
;6304:			else
;6305:			{
line 6306
;6306:				if (bs->wpDestination)
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2581
line 6307
;6307:				{
line 6308
;6308:					bs->wpDestination = NULL;
ADDRFP4 0
INDIRP4
CNSTI4 1876
ADDP4
CNSTP4 0
ASGNP4
line 6309
;6309:					bs->destinationGrabTime = level.time + 10000;
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 10000
ADDI4
CVIF4 4
ASGNF4
line 6310
;6310:				}
LABELV $2581
line 6312
;6311:
;6312:				if (bs->wpDirection)
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2584
line 6313
;6313:				{
line 6314
;6314:					bs->wpDirection = 0;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 0
ASGNI4
line 6315
;6315:				}
ADDRGP4 $2530
JUMPV
LABELV $2584
line 6317
;6316:				else
;6317:				{
line 6318
;6318:					bs->wpDirection = 1;
ADDRFP4 0
INDIRP4
CNSTI4 1952
ADDP4
CNSTI4 1
ASGNI4
line 6319
;6319:				}
line 6320
;6320:			}
line 6321
;6321:		}
line 6322
;6322:	}
ADDRGP4 $2530
JUMPV
LABELV $2529
line 6324
;6323:	else //We can't find a waypoint, going to need a fallback routine.
;6324:	{
line 6326
;6325:		/*if (g_gametype.integer == GT_TOURNAMENT)*/
;6326:		{ //helps them get out of messy situations
line 6333
;6327:			/*if ((level.time - bs->forceJumpChargeTime) > 3500)
;6328:			{
;6329:				bs->forceJumpChargeTime = level.time + 2000;
;6330:				trap_EA_MoveForward(bs->client);
;6331:			}
;6332:			*/
;6333:			bs->jumpTime = level.time + 1500;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
CVIF4 4
ASGNF4
line 6334
;6334:			bs->jumpHoldTime = level.time + 1500;
ADDRFP4 0
INDIRP4
CNSTI4 2004
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1500
ADDI4
CVIF4 4
ASGNF4
line 6335
;6335:			bs->jDelay = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2016
ADDP4
CNSTF4 0
ASGNF4
line 6336
;6336:		}
line 6337
;6337:		doingFallback = BotFallbackNavigation(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 268
ADDRGP4 BotFallbackNavigation
CALLI4
ASGNI4
ADDRLP4 32
ADDRLP4 268
INDIRI4
ASGNI4
line 6338
;6338:	}
LABELV $2530
line 6340
;6339:
;6340:	if (doingFallback)
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2588
line 6341
;6341:	{
line 6342
;6342:		bs->doingFallback = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 4792
ADDP4
CNSTI4 1
ASGNI4
line 6343
;6343:	}
ADDRGP4 $2589
JUMPV
LABELV $2588
line 6345
;6344:	else
;6345:	{
line 6346
;6346:		bs->doingFallback = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 4792
ADDP4
CNSTI4 0
ASGNI4
line 6347
;6347:	}
LABELV $2589
line 6349
;6348:
;6349:	if (bs->timeToReact < level.time && bs->currentEnemy && bs->enemySeenTime > level.time + (ENEMY_FORGET_MS - (ENEMY_FORGET_MS*0.2)))
ADDRLP4 268
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 268
INDIRP4
CNSTI4 1980
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2590
ADDRLP4 268
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2590
ADDRLP4 268
INDIRP4
CNSTI4 1984
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
CNSTF4 1174011904
ADDF4
LEF4 $2590
line 6350
;6350:	{
line 6351
;6351:		if (bs->frame_Enemy_Vis)
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2594
line 6352
;6352:		{
line 6353
;6353:			cBAI = CombatBotAI(bs, thinktime);
ADDRFP4 0
INDIRP4
ARGP4
ADDRFP4 4
INDIRF4
ARGF4
ADDRLP4 272
ADDRGP4 CombatBotAI
CALLI4
ASGNI4
ADDRLP4 152
ADDRLP4 272
INDIRI4
ASGNI4
line 6354
;6354:		}
ADDRGP4 $2595
JUMPV
LABELV $2594
line 6355
;6355:		else if (bs->cur_ps.weaponstate == WEAPON_CHARGING_ALT)
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 5
NEI4 $2596
line 6356
;6356:		{ //keep charging in case we see him again before we lose track of him
line 6357
;6357:			bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 6358
;6358:		}
ADDRGP4 $2597
JUMPV
LABELV $2596
line 6359
;6359:		else if (bs->cur_ps.weaponstate == WEAPON_CHARGING)
ADDRFP4 0
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 4
NEI4 $2598
line 6360
;6360:		{ //keep charging in case we see him again before we lose track of him
line 6361
;6361:			bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 6362
;6362:		}
LABELV $2598
LABELV $2597
LABELV $2595
line 6364
;6363:
;6364:		if (bs->destinationGrabTime > level.time + 100)
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
LEF4 $2600
line 6365
;6365:		{
line 6366
;6366:			bs->destinationGrabTime = level.time + 100; //assures that we will continue staying within a general area of where we want to be in a combat situation
ADDRFP4 0
INDIRP4
CNSTI4 1956
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 6367
;6367:		}
LABELV $2600
line 6369
;6368:
;6369:		if (bs->currentEnemy->client)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2604
line 6370
;6370:		{
line 6371
;6371:			VectorCopy(bs->currentEnemy->client->ps.origin, headlevel);
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 6372
;6372:			headlevel[2] += bs->currentEnemy->client->ps.viewheight;
ADDRLP4 108+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 6373
;6373:		}
ADDRGP4 $2605
JUMPV
LABELV $2604
line 6375
;6374:		else
;6375:		{
line 6376
;6376:			VectorCopy(bs->currentEnemy->client->ps.origin, headlevel);
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 6377
;6377:		}
LABELV $2605
line 6379
;6378:
;6379:		if (!bs->frame_Enemy_Vis)
ADDRFP4 0
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2607
line 6380
;6380:		{
line 6382
;6381:			//if (!bs->hitSpotted && VectorLength(a) > 256)
;6382:			if (OrgVisible(bs->eye, bs->lastEnemySpotted, -1))
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 1732
ADDP4
ARGP4
ADDRLP4 272
INDIRP4
CNSTI4 1920
ADDP4
ARGP4
CNSTI4 -1
ARGI4
ADDRLP4 276
ADDRGP4 OrgVisible
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 0
EQI4 $2608
line 6383
;6383:			{
line 6384
;6384:				VectorCopy(bs->lastEnemySpotted, headlevel);
ADDRLP4 108
ADDRFP4 0
INDIRP4
CNSTI4 1920
ADDP4
INDIRB
ASGNB 12
line 6385
;6385:				VectorSubtract(headlevel, bs->eye, a);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6386
;6386:				vectoangles(a, ang);
ADDRLP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6387
;6387:				VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6389
;6388:
;6389:				if (bs->cur_ps.weapon == WP_FLECHETTE &&
ADDRLP4 284
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 9
NEI4 $2608
ADDRLP4 284
INDIRP4
CNSTI4 168
ADDP4
INDIRI4
CNSTI4 0
NEI4 $2608
ADDRLP4 288
ADDRLP4 284
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 292
CNSTU4 0
ASGNU4
ADDRLP4 288
INDIRP4
CVPU4 4
ADDRLP4 292
INDIRU4
EQU4 $2608
ADDRLP4 288
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 292
INDIRU4
EQU4 $2608
line 6392
;6390:					bs->cur_ps.weaponstate == WEAPON_READY &&
;6391:					bs->currentEnemy && bs->currentEnemy->client)
;6392:				{
line 6393
;6393:					mLen = VectorLength(a) > 128;
ADDRLP4 0
ARGP4
ADDRLP4 300
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 300
INDIRF4
CNSTF4 1124073472
LEF4 $2618
ADDRLP4 296
CNSTI4 1
ASGNI4
ADDRGP4 $2619
JUMPV
LABELV $2618
ADDRLP4 296
CNSTI4 0
ASGNI4
LABELV $2619
ADDRLP4 164
ADDRLP4 296
INDIRI4
CVIF4 4
ASGNF4
line 6394
;6394:					if (mLen > 128 && mLen < 1024)
ADDRLP4 304
ADDRLP4 164
INDIRF4
ASGNF4
ADDRLP4 304
INDIRF4
CNSTF4 1124073472
LEF4 $2608
ADDRLP4 304
INDIRF4
CNSTF4 1149239296
GEF4 $2608
line 6395
;6395:					{
line 6396
;6396:						VectorSubtract(bs->currentEnemy->client->ps.origin, bs->lastEnemySpotted, a);
ADDRLP4 308
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
ADDRLP4 308
INDIRP4
CNSTI4 1804
ADDP4
ASGNP4
ADDRLP4 316
CNSTI4 408
ASGNI4
ADDRLP4 0
ADDRLP4 312
INDIRP4
INDIRP4
ADDRLP4 316
INDIRI4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 308
INDIRP4
CNSTI4 1920
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 312
INDIRP4
INDIRP4
ADDRLP4 316
INDIRI4
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 308
INDIRP4
CNSTI4 1924
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 320
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 320
INDIRP4
CNSTI4 1928
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6398
;6397:
;6398:						if (VectorLength(a) < 300)
ADDRLP4 0
ARGP4
ADDRLP4 324
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 324
INDIRF4
CNSTF4 1133903872
GEF4 $2608
line 6399
;6399:						{
line 6400
;6400:							bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 6401
;6401:						}
line 6402
;6402:					}
line 6403
;6403:				}
line 6404
;6404:			}
line 6405
;6405:		}
ADDRGP4 $2608
JUMPV
LABELV $2607
line 6407
;6406:		else
;6407:		{
line 6408
;6408:			bLeadAmount = BotWeaponCanLead(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotWeaponCanLead
CALLF4
ASGNF4
ADDRLP4 160
ADDRLP4 272
INDIRF4
ASGNF4
line 6409
;6409:			if ((bs->skills.accuracy/bs->settings.skill) <= 8 &&
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
INDIRP4
CNSTI4 2308
ADDP4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 1556
ADDP4
INDIRF4
DIVF4
CNSTF4 1090519040
GTF4 $2626
ADDRLP4 160
INDIRF4
CNSTF4 0
EQF4 $2626
line 6411
;6410:				bLeadAmount)
;6411:			{
line 6412
;6412:				BotAimLeading(bs, headlevel, bLeadAmount);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 108
ARGP4
ADDRLP4 160
INDIRF4
ARGF4
ADDRGP4 BotAimLeading
CALLV
pop
line 6413
;6413:			}
ADDRGP4 $2627
JUMPV
LABELV $2626
line 6415
;6414:			else
;6415:			{
line 6416
;6416:				VectorSubtract(headlevel, bs->eye, a);
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 108
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 108+4
INDIRF4
ADDRLP4 280
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 108+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6417
;6417:				vectoangles(a, ang);
ADDRLP4 0
ARGP4
ADDRLP4 124
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6418
;6418:				VectorCopy(ang, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 124
INDIRB
ASGNB 12
line 6419
;6419:			}
LABELV $2627
line 6421
;6420:
;6421:			BotAimOffsetGoalAngles(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotAimOffsetGoalAngles
CALLV
pop
line 6422
;6422:		}
LABELV $2608
line 6423
;6423:	}
LABELV $2590
line 6425
;6424:
;6425:	if (bs->cur_ps.saberInFlight)
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2632
line 6426
;6426:	{
line 6427
;6427:		bs->saberThrowTime = level.time + Q_irand(4000, 10000);
CNSTI4 4000
ARGI4
CNSTI4 10000
ARGI4
ADDRLP4 272
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2716
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 272
INDIRI4
ADDI4
ASGNI4
line 6428
;6428:	}
LABELV $2632
line 6430
;6429:
;6430:	if (bs->currentEnemy)
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2635
line 6431
;6431:	{
line 6432
;6432:		if (BotGetWeaponRange(bs) == BWEAPONRANGE_SABER)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 272
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 272
INDIRI4
CNSTI4 4
NEI4 $2637
line 6433
;6433:		{
line 6434
;6434:			VectorSubtract(bs->currentEnemy->client->ps.origin, bs->eye, a_fo);
ADDRLP4 276
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 280
ADDRLP4 276
INDIRP4
CNSTI4 1804
ADDP4
ASGNP4
ADDRLP4 284
CNSTI4 408
ASGNI4
ADDRLP4 20
ADDRLP4 280
INDIRP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 20+4
ADDRLP4 280
INDIRP4
INDIRP4
ADDRLP4 284
INDIRI4
ADDP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 276
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 20+8
ADDRLP4 288
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 288
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6435
;6435:			vectoangles(a_fo, a_fo);
ADDRLP4 20
ARGP4
ADDRLP4 20
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6437
;6436:
;6437:			if (bs->saberPowerTime < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2724
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2641
line 6438
;6438:			{ //Don't just use strong attacks constantly, switch around a bit
line 6439
;6439:				if (Q_irand(1, 10) <= 5)
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 292
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 292
INDIRI4
CNSTI4 5
GTI4 $2644
line 6440
;6440:				{
line 6441
;6441:					bs->saberPower = qtrue;
ADDRFP4 0
INDIRP4
CNSTI4 2720
ADDP4
CNSTI4 1
ASGNI4
line 6442
;6442:				}
ADDRGP4 $2645
JUMPV
LABELV $2644
line 6444
;6443:				else
;6444:				{
line 6445
;6445:					bs->saberPower = qfalse;
ADDRFP4 0
INDIRP4
CNSTI4 2720
ADDP4
CNSTI4 0
ASGNI4
line 6446
;6446:				}
LABELV $2645
line 6448
;6447:
;6448:				bs->saberPowerTime = level.time + Q_irand(3000, 15000);
CNSTI4 3000
ARGI4
CNSTI4 15000
ARGI4
ADDRLP4 296
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRFP4 0
INDIRP4
CNSTI4 2724
ADDP4
ADDRGP4 level+32
INDIRI4
ADDRLP4 296
INDIRI4
ADDI4
ASGNI4
line 6449
;6449:			}
LABELV $2641
line 6451
;6450:
;6451:			if (bs->currentEnemy->health > 75 && g_entities[bs->client].client->ps.fd.forcePowerLevel[FP_SABERATTACK] > 2)
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 75
LEI4 $2647
CNSTI4 828
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 2
LEI4 $2647
line 6452
;6452:			{
line 6453
;6453:				if (g_entities[bs->client].client->ps.fd.saberAnimLevel != FORCE_LEVEL_3 && bs->saberPower)
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
CNSTI4 828
ADDRLP4 296
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 3
EQI4 $2648
ADDRLP4 296
INDIRP4
CNSTI4 2720
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2648
line 6454
;6454:				{ //if we are up against someone with a lot of health and we have a strong attack available, then h4q them
line 6455
;6455:					Cmd_SaberAttackCycle_f(&g_entities[bs->client]);
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_SaberAttackCycle_f
CALLV
pop
line 6456
;6456:				}
line 6457
;6457:			}
ADDRGP4 $2648
JUMPV
LABELV $2647
line 6458
;6458:			else if (bs->currentEnemy->health > 40 && g_entities[bs->client].client->ps.fd.forcePowerLevel[FP_SABERATTACK] > 1)
ADDRLP4 296
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 296
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 40
LEI4 $2653
CNSTI4 828
ADDRLP4 296
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 1
LEI4 $2653
line 6459
;6459:			{
line 6460
;6460:				if (g_entities[bs->client].client->ps.fd.saberAnimLevel != FORCE_LEVEL_2)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2654
line 6461
;6461:				{ //they're down on health a little, use level 2 if we can
line 6462
;6462:					Cmd_SaberAttackCycle_f(&g_entities[bs->client]);
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_SaberAttackCycle_f
CALLV
pop
line 6463
;6463:				}
line 6464
;6464:			}
ADDRGP4 $2654
JUMPV
LABELV $2653
line 6466
;6465:			else
;6466:			{
line 6467
;6467:				if (g_entities[bs->client].client->ps.fd.saberAnimLevel != FORCE_LEVEL_1)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 1
EQI4 $2659
line 6468
;6468:				{ //they've gone below 40 health, go at them with quick attacks
line 6469
;6469:					Cmd_SaberAttackCycle_f(&g_entities[bs->client]);
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities
ADDP4
ARGP4
ADDRGP4 Cmd_SaberAttackCycle_f
CALLV
pop
line 6470
;6470:				}
LABELV $2659
line 6471
;6471:			}
LABELV $2654
LABELV $2648
line 6473
;6472:
;6473:			if (bs->frame_Enemy_Len <= SABER_ATTACK_RANGE)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1124073472
GTF4 $2662
line 6474
;6474:			{
line 6475
;6475:				SaberCombatHandling(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 SaberCombatHandling
CALLV
pop
line 6477
;6476:
;6477:				if (bs->frame_Enemy_Len < 80)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1117782016
GEF4 $2638
line 6478
;6478:				{
line 6479
;6479:					meleestrafe = 1;
ADDRLP4 92
CNSTI4 1
ASGNI4
line 6480
;6480:				}
line 6481
;6481:			}
ADDRGP4 $2638
JUMPV
LABELV $2662
line 6482
;6482:			else if (bs->saberThrowTime < level.time && !bs->cur_ps.saberInFlight &&
ADDRLP4 300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 300
INDIRP4
CNSTI4 2716
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2666
ADDRLP4 304
CNSTI4 0
ASGNI4
ADDRLP4 300
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 304
INDIRI4
NEI4 $2666
ADDRLP4 300
INDIRP4
CNSTI4 848
ADDP4
INDIRI4
CNSTI4 131072
BANDI4
ADDRLP4 304
INDIRI4
EQI4 $2666
ADDRLP4 300
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1106247680
ARGF4
ADDRLP4 20
ARGP4
ADDRLP4 308
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 308
INDIRI4
CNSTI4 0
EQI4 $2666
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1145569280
GEF4 $2666
line 6486
;6483:				(bs->cur_ps.fd.forcePowersKnown & (1 << FP_SABERTHROW)) &&
;6484:				InFieldOfVision(bs->viewangles, 30, a_fo) &&
;6485:				bs->frame_Enemy_Len < BOT_SABER_THROW_RANGE)
;6486:			{
line 6487
;6487:				bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 6488
;6488:				bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6489
;6489:			}
ADDRGP4 $2638
JUMPV
LABELV $2666
line 6490
;6490:			else if (bs->cur_ps.saberInFlight && bs->frame_Enemy_Len > 300 && bs->frame_Enemy_Len < BOT_SABER_THROW_RANGE)
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2638
ADDRLP4 316
ADDRLP4 312
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
ASGNF4
ADDRLP4 316
INDIRF4
CNSTF4 1133903872
LEF4 $2638
ADDRLP4 316
INDIRF4
CNSTF4 1145569280
GEF4 $2638
line 6491
;6491:			{
line 6492
;6492:				bs->doAltAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 1
ASGNI4
line 6493
;6493:				bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6494
;6494:			}
line 6495
;6495:		}
ADDRGP4 $2638
JUMPV
LABELV $2637
line 6496
;6496:		else if (BotGetWeaponRange(bs) == BWEAPONRANGE_MELEE)
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 276
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 276
INDIRI4
CNSTI4 1
NEI4 $2671
line 6497
;6497:		{
line 6498
;6498:			if (bs->frame_Enemy_Len <= MELEE_ATTACK_RANGE)
ADDRFP4 0
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132462080
GTF4 $2673
line 6499
;6499:			{
line 6500
;6500:				MeleeCombatHandling(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MeleeCombatHandling
CALLV
pop
line 6501
;6501:				meleestrafe = 1;
ADDRLP4 92
CNSTI4 1
ASGNI4
line 6502
;6502:			}
LABELV $2673
line 6503
;6503:		}
LABELV $2671
LABELV $2638
line 6504
;6504:	}
LABELV $2635
line 6506
;6505:
;6506:	if (doingFallback && bs->currentEnemy) //just stand and fire if we have no idea where we are
ADDRLP4 32
INDIRI4
CNSTI4 0
EQI4 $2675
ADDRFP4 0
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2675
line 6507
;6507:	{
line 6508
;6508:		VectorCopy(bs->origin, bs->goalPosition);
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 272
INDIRP4
CNSTI4 1908
ADDP4
ADDRLP4 272
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 6509
;6509:	}
LABELV $2675
line 6511
;6510:
;6511:	if (bs->forceJumping > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2012
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2677
line 6512
;6512:	{
line 6513
;6513:		VectorCopy(bs->origin, noz_x);
ADDRLP4 36
ADDRFP4 0
INDIRP4
CNSTI4 1708
ADDP4
INDIRB
ASGNB 12
line 6514
;6514:		VectorCopy(bs->goalPosition, noz_y);
ADDRLP4 68
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
INDIRB
ASGNB 12
line 6516
;6515:
;6516:		noz_x[2] = noz_y[2];
ADDRLP4 36+8
ADDRLP4 68+8
INDIRF4
ASGNF4
line 6518
;6517:
;6518:		VectorSubtract(noz_x, noz_y, noz_x);
ADDRLP4 36
ADDRLP4 36
INDIRF4
ADDRLP4 68
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+4
ADDRLP4 36+4
INDIRF4
ADDRLP4 68+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 36+8
ADDRLP4 36+8
INDIRF4
ADDRLP4 68+8
INDIRF4
SUBF4
ASGNF4
line 6520
;6519:
;6520:		if (VectorLength(noz_x) < 32)
ADDRLP4 36
ARGP4
ADDRLP4 272
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 272
INDIRF4
CNSTF4 1107296256
GEF4 $2688
line 6521
;6521:		{
line 6522
;6522:			fjHalt = 1;
ADDRLP4 96
CNSTI4 1
ASGNI4
line 6523
;6523:		}
LABELV $2688
line 6524
;6524:	}
LABELV $2677
line 6526
;6525:
;6526:	if (bs->doChat && bs->chatTime > level.time && (!bs->currentEnemy || !bs->frame_Enemy_Vis))
ADDRLP4 272
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 276
CNSTI4 0
ASGNI4
ADDRLP4 272
INDIRP4
CNSTI4 2224
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
EQI4 $2690
ADDRLP4 272
INDIRP4
CNSTI4 2216
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2690
ADDRLP4 272
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2693
ADDRLP4 272
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 276
INDIRI4
NEI4 $2690
LABELV $2693
line 6527
;6527:	{
line 6528
;6528:		return;
ADDRGP4 $2317
JUMPV
LABELV $2690
line 6530
;6529:	}
;6530:	else if (bs->doChat && bs->currentEnemy && bs->frame_Enemy_Vis)
ADDRLP4 280
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 284
CNSTI4 0
ASGNI4
ADDRLP4 280
INDIRP4
CNSTI4 2224
ADDP4
INDIRI4
ADDRLP4 284
INDIRI4
EQI4 $2694
ADDRLP4 280
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2694
ADDRLP4 280
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 284
INDIRI4
EQI4 $2694
line 6531
;6531:	{
line 6533
;6532:		//bs->chatTime = level.time + bs->chatTime_stored;
;6533:		bs->doChat = 0; //do we want to keep the bot waiting to chat until after the enemy is gone?
ADDRFP4 0
INDIRP4
CNSTI4 2224
ADDP4
CNSTI4 0
ASGNI4
line 6534
;6534:		bs->chatTeam = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2228
ADDP4
CNSTI4 0
ASGNI4
line 6535
;6535:	}
ADDRGP4 $2695
JUMPV
LABELV $2694
line 6536
;6536:	else if (bs->doChat && bs->chatTime <= level.time)
ADDRLP4 288
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 288
INDIRP4
CNSTI4 2224
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2696
ADDRLP4 288
INDIRP4
CNSTI4 2216
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GTF4 $2696
line 6537
;6537:	{
line 6538
;6538:		if (bs->chatTeam)
ADDRFP4 0
INDIRP4
CNSTI4 2228
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2699
line 6539
;6539:		{
line 6540
;6540:			trap_EA_SayTeam(bs->client, bs->currentChat);
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
INDIRP4
CNSTI4 2088
ADDP4
ARGP4
ADDRGP4 trap_EA_SayTeam
CALLV
pop
line 6541
;6541:			bs->chatTeam = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2228
ADDP4
CNSTI4 0
ASGNI4
line 6542
;6542:		}
ADDRGP4 $2700
JUMPV
LABELV $2699
line 6544
;6543:		else
;6544:		{
line 6545
;6545:			trap_EA_Say(bs->client, bs->currentChat);
ADDRLP4 292
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 292
INDIRP4
CNSTI4 2088
ADDP4
ARGP4
ADDRGP4 trap_EA_Say
CALLV
pop
line 6546
;6546:		}
LABELV $2700
line 6547
;6547:		if (bs->doChat == 2)
ADDRFP4 0
INDIRP4
CNSTI4 2224
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2701
line 6548
;6548:		{
line 6549
;6549:			BotReplyGreetings(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotReplyGreetings
CALLV
pop
line 6550
;6550:		}
LABELV $2701
line 6551
;6551:		bs->doChat = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2224
ADDP4
CNSTI4 0
ASGNI4
line 6552
;6552:	}
LABELV $2696
LABELV $2695
line 6554
;6553:
;6554:	CTFFlagMovement(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 CTFFlagMovement
CALLV
pop
line 6556
;6555:
;6556:	if (/*bs->wpDestination &&*/ bs->shootGoal &&
ADDRLP4 292
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 292
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2703
ADDRLP4 296
CNSTI4 0
ASGNI4
ADDRLP4 292
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
LEI4 $2703
ADDRLP4 292
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
ADDRLP4 296
INDIRI4
EQI4 $2703
line 6559
;6557:		/*bs->wpDestination->associated_entity == bs->shootGoal->s.number &&*/
;6558:		bs->shootGoal->health > 0 && bs->shootGoal->takedamage)
;6559:	{
line 6560
;6560:		dif[0] = (bs->shootGoal->r.absmax[0]+bs->shootGoal->r.absmin[0])/2;
ADDRLP4 300
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 80
ADDRLP4 300
INDIRP4
CNSTI4 356
ADDP4
INDIRF4
ADDRLP4 300
INDIRP4
CNSTI4 344
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 6561
;6561:		dif[1] = (bs->shootGoal->r.absmax[1]+bs->shootGoal->r.absmin[1])/2;
ADDRLP4 304
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 80+4
ADDRLP4 304
INDIRP4
CNSTI4 360
ADDP4
INDIRF4
ADDRLP4 304
INDIRP4
CNSTI4 348
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 6562
;6562:		dif[2] = (bs->shootGoal->r.absmax[2]+bs->shootGoal->r.absmin[2])/2;
ADDRLP4 308
ADDRFP4 0
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
ASGNP4
ADDRLP4 80+8
ADDRLP4 308
INDIRP4
CNSTI4 364
ADDP4
INDIRF4
ADDRLP4 308
INDIRP4
CNSTI4 352
ADDP4
INDIRF4
ADDF4
CNSTF4 1073741824
DIVF4
ASGNF4
line 6564
;6563:
;6564:		if (!bs->currentEnemy || bs->frame_Enemy_Len > 256)
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 312
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2709
ADDRLP4 312
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1132462080
LEF4 $2707
LABELV $2709
line 6565
;6565:		{ //if someone is close then don't stop shooting them for this
line 6566
;6566:			VectorSubtract(dif, bs->eye, a);
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 80
INDIRF4
ADDRLP4 316
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 80+4
INDIRF4
ADDRLP4 316
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRLP4 80+8
INDIRF4
ADDRFP4 0
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6567
;6567:			vectoangles(a, a);
ADDRLP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6568
;6568:			VectorCopy(a, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 6570
;6569:
;6570:			if (InFieldOfVision(bs->viewangles, 30, a) &&
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1106247680
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 320
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 320
INDIRI4
CNSTI4 0
EQI4 $2714
ADDRLP4 324
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 324
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 328
CNSTP4 0
ASGNP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 328
INDIRP4
ARGP4
ADDRLP4 80
ARGP4
ADDRLP4 324
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 324
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
INDIRI4
ARGI4
ADDRLP4 332
ADDRGP4 EntityVisibleBox
CALLI4
ASGNI4
ADDRLP4 332
INDIRI4
CNSTI4 0
EQI4 $2714
line 6572
;6571:				EntityVisibleBox(bs->origin, NULL, NULL, dif, bs->client, bs->shootGoal->s.number))
;6572:			{
line 6573
;6573:				bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 6574
;6574:			}
LABELV $2714
line 6575
;6575:		}
LABELV $2707
line 6576
;6576:	}
LABELV $2703
line 6578
;6577:
;6578:	if (bs->cur_ps.hasDetPackPlanted)
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2716
line 6579
;6579:	{ //check if our enemy gets near it and detonate if he does
line 6580
;6580:		BotCheckDetPacks(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BotCheckDetPacks
CALLV
pop
line 6581
;6581:	}
ADDRGP4 $2717
JUMPV
LABELV $2716
line 6582
;6582:	else if (bs->currentEnemy && bs->lastVisibleEnemyIndex == bs->currentEnemy->s.number && !bs->frame_Enemy_Vis && bs->plantTime < level.time &&
ADDRLP4 300
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 304
ADDRLP4 300
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 304
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2718
ADDRLP4 300
INDIRP4
CNSTI4 1944
ADDP4
INDIRI4
ADDRLP4 304
INDIRP4
INDIRI4
NEI4 $2718
ADDRLP4 308
CNSTI4 0
ASGNI4
ADDRLP4 300
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 308
INDIRI4
NEI4 $2718
ADDRLP4 300
INDIRP4
CNSTI4 2280
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2718
ADDRLP4 300
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
ADDRLP4 308
INDIRI4
NEI4 $2718
ADDRLP4 300
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
ADDRLP4 308
INDIRI4
NEI4 $2718
line 6584
;6583:		!bs->doAttack && !bs->doAltAttack)
;6584:	{
line 6585
;6585:		VectorSubtract(bs->origin, bs->hereWhenSpotted, a);
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 312
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 312
INDIRP4
CNSTI4 1932
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 312
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 312
INDIRP4
CNSTI4 1936
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 316
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 316
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRLP4 316
INDIRP4
CNSTI4 1940
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6587
;6586:
;6587:		if (bs->plantDecided > level.time || (bs->frame_Enemy_Len < BOT_PLANT_DISTANCE*2 && VectorLength(a) < BOT_PLANT_DISTANCE))
ADDRLP4 320
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 320
INDIRP4
CNSTI4 2284
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GTI4 $2726
ADDRLP4 320
INDIRP4
CNSTI4 2040
ADDP4
INDIRF4
CNSTF4 1140850688
GEF4 $2719
ADDRLP4 0
ARGP4
ADDRLP4 324
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 324
INDIRF4
CNSTF4 1132462080
GEF4 $2719
LABELV $2726
line 6588
;6588:		{
line 6589
;6589:			mineSelect = BotSelectChoiceWeapon(bs, WP_TRIP_MINE, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 12
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 328
ADDRGP4 BotSelectChoiceWeapon
CALLI4
ASGNI4
ADDRLP4 156
ADDRLP4 328
INDIRI4
ASGNI4
line 6590
;6590:			detSelect = BotSelectChoiceWeapon(bs, WP_DET_PACK, 0);
ADDRFP4 0
INDIRP4
ARGP4
CNSTI4 13
ARGI4
CNSTI4 0
ARGI4
ADDRLP4 332
ADDRGP4 BotSelectChoiceWeapon
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 332
INDIRI4
ASGNI4
line 6591
;6591:			if (bs->cur_ps.hasDetPackPlanted)
ADDRFP4 0
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2727
line 6592
;6592:			{
line 6593
;6593:				detSelect = 0;
ADDRLP4 140
CNSTI4 0
ASGNI4
line 6594
;6594:			}
LABELV $2727
line 6596
;6595:
;6596:			if (bs->plantDecided > level.time && bs->forceWeaponSelect &&
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 2284
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2729
ADDRLP4 340
ADDRLP4 336
INDIRP4
CNSTI4 2272
ADDP4
INDIRI4
ASGNI4
ADDRLP4 340
INDIRI4
CNSTI4 0
EQI4 $2729
ADDRLP4 336
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ADDRLP4 340
INDIRI4
NEI4 $2729
line 6598
;6597:				bs->cur_ps.weapon == bs->forceWeaponSelect)
;6598:			{
line 6599
;6599:				bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 6600
;6600:				bs->plantDecided = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2284
ADDP4
CNSTI4 0
ASGNI4
line 6601
;6601:				bs->plantTime = level.time + BOT_PLANT_INTERVAL;
ADDRFP4 0
INDIRP4
CNSTI4 2280
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 15000
ADDI4
ASGNI4
line 6602
;6602:				bs->plantContinue = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 2288
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
ASGNI4
line 6603
;6603:				bs->beStill = level.time + 500;
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 500
ADDI4
CVIF4 4
ASGNF4
line 6604
;6604:			}
ADDRGP4 $2719
JUMPV
LABELV $2729
line 6605
;6605:			else if (mineSelect || detSelect)
ADDRLP4 344
CNSTI4 0
ASGNI4
ADDRLP4 156
INDIRI4
ADDRLP4 344
INDIRI4
NEI4 $2737
ADDRLP4 140
INDIRI4
ADDRLP4 344
INDIRI4
EQI4 $2719
LABELV $2737
line 6606
;6606:			{
line 6607
;6607:				if (BotSurfaceNear(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 348
ADDRGP4 BotSurfaceNear
CALLI4
ASGNI4
ADDRLP4 348
INDIRI4
CNSTI4 0
EQI4 $2719
line 6608
;6608:				{
line 6609
;6609:					if (!mineSelect)
ADDRLP4 156
INDIRI4
CNSTI4 0
NEI4 $2740
line 6610
;6610:					{ //if no mines use detpacks, otherwise use mines
line 6611
;6611:						mineSelect = WP_DET_PACK;
ADDRLP4 156
CNSTI4 13
ASGNI4
line 6612
;6612:					}
ADDRGP4 $2741
JUMPV
LABELV $2740
line 6614
;6613:					else
;6614:					{
line 6615
;6615:						mineSelect = WP_TRIP_MINE;
ADDRLP4 156
CNSTI4 12
ASGNI4
line 6616
;6616:					}
LABELV $2741
line 6618
;6617:
;6618:					detSelect = BotSelectChoiceWeapon(bs, mineSelect, 1);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 156
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 352
ADDRGP4 BotSelectChoiceWeapon
CALLI4
ASGNI4
ADDRLP4 140
ADDRLP4 352
INDIRI4
ASGNI4
line 6620
;6619:
;6620:					if (detSelect && detSelect != 2)
ADDRLP4 356
ADDRLP4 140
INDIRI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $2742
ADDRLP4 356
INDIRI4
CNSTI4 2
EQI4 $2742
line 6621
;6621:					{ //We have it and it is now our weapon
line 6622
;6622:						bs->plantDecided = level.time + 1000;
ADDRFP4 0
INDIRP4
CNSTI4 2284
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 1000
ADDI4
ASGNI4
line 6623
;6623:						bs->forceWeaponSelect = mineSelect;
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 6624
;6624:						return;
ADDRGP4 $2317
JUMPV
LABELV $2742
line 6626
;6625:					}
;6626:					else if (detSelect == 2)
ADDRLP4 140
INDIRI4
CNSTI4 2
NEI4 $2719
line 6627
;6627:					{
line 6628
;6628:						bs->forceWeaponSelect = mineSelect;
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
ADDRLP4 156
INDIRI4
ASGNI4
line 6629
;6629:						return;
ADDRGP4 $2317
JUMPV
line 6631
;6630:					}
;6631:				}
line 6632
;6632:			}
line 6633
;6633:		}
line 6634
;6634:	}
LABELV $2718
line 6635
;6635:	else if (bs->plantContinue < level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2288
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
GEI4 $2747
line 6636
;6636:	{
line 6637
;6637:		bs->forceWeaponSelect = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2272
ADDP4
CNSTI4 0
ASGNI4
line 6638
;6638:	}
LABELV $2747
LABELV $2719
LABELV $2717
line 6640
;6639:
;6640:	if (g_gametype.integer == GT_JEDIMASTER && !bs->cur_ps.isJediMaster && bs->jmState == -1 && gJMSaberEnt && gJMSaberEnt->inuse)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 2
NEI4 $2750
ADDRLP4 312
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 316
CNSTI4 0
ASGNI4
ADDRLP4 312
INDIRP4
CNSTI4 620
ADDP4
INDIRI4
ADDRLP4 316
INDIRI4
NEI4 $2750
ADDRLP4 312
INDIRP4
CNSTI4 2688
ADDP4
INDIRI4
CNSTI4 -1
NEI4 $2750
ADDRLP4 320
ADDRGP4 gJMSaberEnt
INDIRP4
ASGNP4
ADDRLP4 320
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2750
ADDRLP4 320
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 316
INDIRI4
EQI4 $2750
line 6641
;6641:	{
line 6643
;6642:		vec3_t saberLen;
;6643:		float fSaberLen = 0;
ADDRLP4 336
CNSTF4 0
ASGNF4
line 6645
;6644:
;6645:		VectorSubtract(bs->origin, gJMSaberEnt->r.currentOrigin, saberLen);
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
ADDRGP4 gJMSaberEnt
INDIRP4
ASGNP4
ADDRLP4 324
ADDRLP4 340
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 324+4
ADDRLP4 340
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 324+8
ADDRFP4 0
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
ADDRGP4 gJMSaberEnt
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6646
;6646:		fSaberLen = VectorLength(saberLen);
ADDRLP4 324
ARGP4
ADDRLP4 348
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 336
ADDRLP4 348
INDIRF4
ASGNF4
line 6648
;6647:
;6648:		if (fSaberLen < 256)
ADDRLP4 336
INDIRF4
CNSTF4 1132462080
GEF4 $2755
line 6649
;6649:		{
line 6650
;6650:			if (OrgVisible(bs->origin, gJMSaberEnt->r.currentOrigin, bs->client))
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRGP4 gJMSaberEnt
INDIRP4
CNSTI4 368
ADDP4
ARGP4
ADDRLP4 352
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 356
ADDRGP4 OrgVisible
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 0
EQI4 $2757
line 6651
;6651:			{
line 6652
;6652:				VectorCopy(gJMSaberEnt->r.currentOrigin, bs->goalPosition);
ADDRFP4 0
INDIRP4
CNSTI4 1908
ADDP4
ADDRGP4 gJMSaberEnt
INDIRP4
CNSTI4 368
ADDP4
INDIRB
ASGNB 12
line 6653
;6653:			}
LABELV $2757
line 6654
;6654:		}
LABELV $2755
line 6655
;6655:	}
LABELV $2750
line 6657
;6656:
;6657:	if (bs->beStill < level.time && !WaitingForNow(bs, bs->goalPosition) && !fjHalt)
ADDRLP4 324
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 324
INDIRP4
CNSTI4 1992
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2759
ADDRLP4 324
INDIRP4
ARGP4
ADDRLP4 324
INDIRP4
CNSTI4 1908
ADDP4
ARGP4
ADDRLP4 328
ADDRGP4 WaitingForNow
CALLI4
ASGNI4
ADDRLP4 332
CNSTI4 0
ASGNI4
ADDRLP4 328
INDIRI4
ADDRLP4 332
INDIRI4
NEI4 $2759
ADDRLP4 96
INDIRI4
ADDRLP4 332
INDIRI4
NEI4 $2759
line 6658
;6658:	{
line 6659
;6659:		VectorSubtract(bs->goalPosition, bs->origin, bs->goalMovedir);
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 1896
ADDP4
ADDRLP4 336
INDIRP4
CNSTI4 1908
ADDP4
INDIRF4
ADDRLP4 336
INDIRP4
CNSTI4 1708
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 1900
ADDP4
ADDRLP4 340
INDIRP4
CNSTI4 1912
ADDP4
INDIRF4
ADDRLP4 340
INDIRP4
CNSTI4 1712
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 344
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
INDIRP4
CNSTI4 1904
ADDP4
ADDRLP4 344
INDIRP4
CNSTI4 1916
ADDP4
INDIRF4
ADDRLP4 344
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6660
;6660:		VectorNormalize(bs->goalMovedir);
ADDRFP4 0
INDIRP4
CNSTI4 1896
ADDP4
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 6662
;6661:
;6662:		if (bs->jumpTime > level.time && bs->jDelay < level.time &&
ADDRLP4 348
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 348
INDIRP4
CNSTI4 2000
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2762
ADDRLP4 348
INDIRP4
CNSTI4 2016
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2762
CNSTI4 1756
ADDRLP4 348
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 1398
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $2762
line 6664
;6663:			level.clients[bs->client].pers.cmd.upmove > 0)
;6664:		{
line 6666
;6665:		//	trap_EA_Move(bs->client, bs->origin, 5000);
;6666:			bs->beStill = level.time + 200;
ADDRFP4 0
INDIRP4
CNSTI4 1992
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 200
ADDI4
CVIF4 4
ASGNF4
line 6667
;6667:		}
ADDRGP4 $2763
JUMPV
LABELV $2762
line 6669
;6668:		else
;6669:		{
line 6670
;6670:			trap_EA_Move(bs->client, bs->goalMovedir, 5000);
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 352
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 352
INDIRP4
CNSTI4 1896
ADDP4
ARGP4
CNSTF4 1167867904
ARGF4
ADDRGP4 trap_EA_Move
CALLV
pop
line 6671
;6671:		}
LABELV $2763
line 6673
;6672:
;6673:		if (meleestrafe)
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $2767
line 6674
;6674:		{
line 6675
;6675:			StrafeTracing(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 StrafeTracing
CALLV
pop
line 6676
;6676:		}
LABELV $2767
line 6678
;6677:
;6678:		if (bs->meleeStrafeDir && meleestrafe && bs->meleeStrafeDisable < level.time)
ADDRLP4 352
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 356
CNSTI4 0
ASGNI4
ADDRLP4 352
INDIRP4
CNSTI4 2244
ADDP4
INDIRI4
ADDRLP4 356
INDIRI4
EQI4 $2769
ADDRLP4 92
INDIRI4
ADDRLP4 356
INDIRI4
EQI4 $2769
ADDRLP4 352
INDIRP4
CNSTI4 2248
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2769
line 6679
;6679:		{
line 6680
;6680:			trap_EA_MoveRight(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveRight
CALLV
pop
line 6681
;6681:		}
ADDRGP4 $2770
JUMPV
LABELV $2769
line 6682
;6682:		else if (meleestrafe && bs->meleeStrafeDisable < level.time)
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $2772
ADDRFP4 0
INDIRP4
CNSTI4 2248
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2772
line 6683
;6683:		{
line 6684
;6684:			trap_EA_MoveLeft(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveLeft
CALLV
pop
line 6685
;6685:		}
LABELV $2772
LABELV $2770
line 6687
;6686:
;6687:		if (BotTrace_Jump(bs, bs->goalPosition))
ADDRLP4 360
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 360
INDIRP4
ARGP4
ADDRLP4 360
INDIRP4
CNSTI4 1908
ADDP4
ARGP4
ADDRLP4 364
ADDRGP4 BotTrace_Jump
CALLI4
ASGNI4
ADDRLP4 364
INDIRI4
CNSTI4 0
EQI4 $2775
line 6688
;6688:		{
line 6689
;6689:			bs->jumpTime = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 6690
;6690:		}
ADDRGP4 $2776
JUMPV
LABELV $2775
line 6691
;6691:		else if (BotTrace_Duck(bs, bs->goalPosition))
ADDRLP4 368
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 368
INDIRP4
ARGP4
ADDRLP4 368
INDIRP4
CNSTI4 1908
ADDP4
ARGP4
ADDRLP4 372
ADDRGP4 BotTrace_Duck
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
EQI4 $2778
line 6692
;6692:		{
line 6693
;6693:			bs->duckTime = level.time + 100;
ADDRFP4 0
INDIRP4
CNSTI4 1996
ADDP4
ADDRGP4 level+32
INDIRI4
CNSTI4 100
ADDI4
CVIF4 4
ASGNF4
line 6694
;6694:		}
ADDRGP4 $2779
JUMPV
LABELV $2778
line 6697
;6695:#ifdef BOT_STRAFE_AVOIDANCE
;6696:		else
;6697:		{
line 6698
;6698:			int strafeAround = BotTrace_Strafe(bs, bs->goalPosition);
ADDRLP4 380
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 380
INDIRP4
ARGP4
ADDRLP4 380
INDIRP4
CNSTI4 1908
ADDP4
ARGP4
ADDRLP4 384
ADDRGP4 BotTrace_Strafe
CALLI4
ASGNI4
ADDRLP4 376
ADDRLP4 384
INDIRI4
ASGNI4
line 6700
;6699:
;6700:			if (strafeAround == STRAFEAROUND_RIGHT)
ADDRLP4 376
INDIRI4
CNSTI4 1
NEI4 $2781
line 6701
;6701:			{
line 6702
;6702:				trap_EA_MoveRight(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveRight
CALLV
pop
line 6703
;6703:			}
ADDRGP4 $2782
JUMPV
LABELV $2781
line 6704
;6704:			else if (strafeAround == STRAFEAROUND_LEFT)
ADDRLP4 376
INDIRI4
CNSTI4 2
NEI4 $2783
line 6705
;6705:			{
line 6706
;6706:				trap_EA_MoveLeft(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveLeft
CALLV
pop
line 6707
;6707:			}
LABELV $2783
LABELV $2782
line 6708
;6708:		}
LABELV $2779
LABELV $2776
line 6710
;6709:#endif
;6710:	}
LABELV $2759
line 6713
;6711:
;6712:#ifndef FORCEJUMP_INSTANTMETHOD
;6713:	if (bs->forceJumpChargeTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2785
line 6714
;6714:	{
line 6715
;6715:		bs->jumpTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2000
ADDP4
CNSTF4 0
ASGNF4
line 6716
;6716:	}
LABELV $2785
line 6719
;6717:#endif
;6718:
;6719:	if (bs->jumpPrep > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2008
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2788
line 6720
;6720:	{
line 6721
;6721:		bs->forceJumpChargeTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
CNSTI4 0
ASGNI4
line 6722
;6722:	}
LABELV $2788
line 6724
;6723:
;6724:	if (bs->forceJumpChargeTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2791
line 6725
;6725:	{
line 6726
;6726:		bs->jumpHoldTime = ((bs->forceJumpChargeTime - level.time)/2) + level.time;
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 2004
ADDP4
ADDRLP4 336
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
SUBI4
CNSTI4 2
DIVI4
ADDRGP4 level+32
INDIRI4
ADDI4
CVIF4 4
ASGNF4
line 6727
;6727:		bs->forceJumpChargeTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
CNSTI4 0
ASGNI4
line 6728
;6728:	}
LABELV $2791
line 6730
;6729:
;6730:	if (bs->jumpHoldTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2004
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2796
line 6731
;6731:	{
line 6732
;6732:		bs->jumpTime = bs->jumpHoldTime;
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 2000
ADDP4
ADDRLP4 336
INDIRP4
CNSTI4 2004
ADDP4
INDIRF4
ASGNF4
line 6733
;6733:	}
LABELV $2796
line 6735
;6734:
;6735:	if (bs->jumpTime > level.time && bs->jDelay < level.time)
ADDRLP4 336
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 336
INDIRP4
CNSTI4 2000
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2799
ADDRLP4 336
INDIRP4
CNSTI4 2016
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
GEF4 $2799
line 6736
;6736:	{
line 6737
;6737:		if (bs->jumpHoldTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2004
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2803
line 6738
;6738:		{
line 6739
;6739:			trap_EA_Jump(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Jump
CALLV
pop
line 6740
;6740:			if (bs->wpCurrent)
ADDRFP4 0
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2806
line 6741
;6741:			{
line 6742
;6742:				if ((bs->wpCurrent->origin[2] - bs->origin[2]) < 64)
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 340
INDIRP4
CNSTI4 1872
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
ADDRLP4 340
INDIRP4
CNSTI4 1716
ADDP4
INDIRF4
SUBF4
CNSTF4 1115684864
GEF4 $2807
line 6743
;6743:				{
line 6744
;6744:					trap_EA_MoveForward(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveForward
CALLV
pop
line 6745
;6745:				}
line 6746
;6746:			}
ADDRGP4 $2807
JUMPV
LABELV $2806
line 6748
;6747:			else
;6748:			{
line 6749
;6749:				trap_EA_MoveForward(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_MoveForward
CALLV
pop
line 6750
;6750:			}
LABELV $2807
line 6751
;6751:			if (g_entities[bs->client].client->ps.groundEntityNum == ENTITYNUM_NONE)
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
NEI4 $2804
line 6752
;6752:			{
line 6753
;6753:				g_entities[bs->client].client->ps.pm_flags |= PMF_JUMP_HELD;
ADDRLP4 340
CNSTI4 828
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 12
ADDP4
ASGNP4
ADDRLP4 340
INDIRP4
ADDRLP4 340
INDIRP4
INDIRI4
CNSTI4 2
BORI4
ASGNI4
line 6754
;6754:			}
line 6755
;6755:		}
ADDRGP4 $2804
JUMPV
LABELV $2803
line 6756
;6756:		else if (!(bs->cur_ps.pm_flags & PMF_JUMP_HELD))
ADDRFP4 0
INDIRP4
CNSTI4 28
ADDP4
INDIRI4
CNSTI4 2
BANDI4
CNSTI4 0
NEI4 $2814
line 6757
;6757:		{
line 6758
;6758:			trap_EA_Jump(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Jump
CALLV
pop
line 6759
;6759:		}
LABELV $2814
LABELV $2804
line 6760
;6760:	}
LABELV $2799
line 6762
;6761:
;6762:	if (bs->duckTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 1996
ADDP4
INDIRF4
ADDRGP4 level+32
INDIRI4
CVIF4 4
LEF4 $2816
line 6763
;6763:	{
line 6764
;6764:		trap_EA_Crouch(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Crouch
CALLV
pop
line 6765
;6765:	}
LABELV $2816
line 6767
;6766:
;6767:	if ( bs->dangerousObject && bs->dangerousObject->inuse && bs->dangerousObject->health > 0 &&
ADDRLP4 340
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 344
ADDRLP4 340
INDIRP4
CNSTI4 1836
ADDP4
INDIRP4
ASGNP4
ADDRLP4 348
CNSTU4 0
ASGNU4
ADDRLP4 344
INDIRP4
CVPU4 4
ADDRLP4 348
INDIRU4
EQU4 $2819
ADDRLP4 352
CNSTI4 0
ASGNI4
ADDRLP4 344
INDIRP4
CNSTI4 412
ADDP4
INDIRI4
ADDRLP4 352
INDIRI4
EQI4 $2819
ADDRLP4 344
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
ADDRLP4 352
INDIRI4
LEI4 $2819
ADDRLP4 344
INDIRP4
CNSTI4 680
ADDP4
INDIRI4
ADDRLP4 352
INDIRI4
EQI4 $2819
ADDRLP4 340
INDIRP4
CNSTI4 2044
ADDP4
INDIRI4
ADDRLP4 352
INDIRI4
EQI4 $2821
ADDRLP4 340
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
CVPU4 4
ADDRLP4 348
INDIRU4
NEU4 $2819
LABELV $2821
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 356
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 356
INDIRI4
CNSTI4 2
EQI4 $2822
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 360
ADDRGP4 BotGetWeaponRange
CALLI4
ASGNI4
ADDRLP4 360
INDIRI4
CNSTI4 3
NEI4 $2819
LABELV $2822
ADDRLP4 364
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 368
ADDRLP4 364
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
ASGNI4
ADDRLP4 368
INDIRI4
CNSTI4 13
EQI4 $2819
ADDRLP4 368
INDIRI4
CNSTI4 12
EQI4 $2819
ADDRLP4 364
INDIRP4
CNSTI4 1832
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $2819
line 6772
;6768:		bs->dangerousObject->takedamage && (!bs->frame_Enemy_Vis || !bs->currentEnemy) &&
;6769:		(BotGetWeaponRange(bs) == BWEAPONRANGE_MID || BotGetWeaponRange(bs) == BWEAPONRANGE_LONG) &&
;6770:		bs->cur_ps.weapon != WP_DET_PACK && bs->cur_ps.weapon != WP_TRIP_MINE &&
;6771:		!bs->shootGoal )
;6772:	{
line 6775
;6773:		float danLen;
;6774:
;6775:		VectorSubtract(bs->dangerousObject->r.currentOrigin, bs->eye, a);
ADDRLP4 376
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 380
ADDRLP4 376
INDIRP4
CNSTI4 1836
ADDP4
ASGNP4
ADDRLP4 0
ADDRLP4 380
INDIRP4
INDIRP4
CNSTI4 368
ADDP4
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 1732
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 380
INDIRP4
INDIRP4
CNSTI4 372
ADDP4
INDIRF4
ADDRLP4 376
INDIRP4
CNSTI4 1736
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 384
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 0+8
ADDRLP4 384
INDIRP4
CNSTI4 1836
ADDP4
INDIRP4
CNSTI4 376
ADDP4
INDIRF4
ADDRLP4 384
INDIRP4
CNSTI4 1740
ADDP4
INDIRF4
SUBF4
ASGNF4
line 6777
;6776:
;6777:		danLen = VectorLength(a);
ADDRLP4 0
ARGP4
ADDRLP4 388
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 372
ADDRLP4 388
INDIRF4
ASGNF4
line 6779
;6778:
;6779:		if (danLen > 256)
ADDRLP4 372
INDIRF4
CNSTF4 1132462080
LEF4 $2825
line 6780
;6780:		{
line 6781
;6781:			vectoangles(a, a);
ADDRLP4 0
ARGP4
ADDRLP4 0
ARGP4
ADDRGP4 vectoangles
CALLV
pop
line 6782
;6782:			VectorCopy(a, bs->goalAngles);
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ADDRLP4 0
INDIRB
ASGNB 12
line 6784
;6783:
;6784:			if (Q_irand(1, 10) < 5)
CNSTI4 1
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 392
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 392
INDIRI4
CNSTI4 5
GEI4 $2827
line 6785
;6785:			{
line 6786
;6786:				bs->goalAngles[YAW] += Q_irand(0, 3);
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 396
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 400
ADDRFP4 0
INDIRP4
CNSTI4 1888
ADDP4
ASGNP4
ADDRLP4 400
INDIRP4
ADDRLP4 400
INDIRP4
INDIRF4
ADDRLP4 396
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 6787
;6787:				bs->goalAngles[PITCH] += Q_irand(0, 3);
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 404
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 408
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ASGNP4
ADDRLP4 408
INDIRP4
ADDRLP4 408
INDIRP4
INDIRF4
ADDRLP4 404
INDIRI4
CVIF4 4
ADDF4
ASGNF4
line 6788
;6788:			}
ADDRGP4 $2828
JUMPV
LABELV $2827
line 6790
;6789:			else
;6790:			{
line 6791
;6791:				bs->goalAngles[YAW] -= Q_irand(0, 3);
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 396
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 400
ADDRFP4 0
INDIRP4
CNSTI4 1888
ADDP4
ASGNP4
ADDRLP4 400
INDIRP4
ADDRLP4 400
INDIRP4
INDIRF4
ADDRLP4 396
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 6792
;6792:				bs->goalAngles[PITCH] -= Q_irand(0, 3);
CNSTI4 0
ARGI4
CNSTI4 3
ARGI4
ADDRLP4 404
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 408
ADDRFP4 0
INDIRP4
CNSTI4 1884
ADDP4
ASGNP4
ADDRLP4 408
INDIRP4
ADDRLP4 408
INDIRP4
INDIRF4
ADDRLP4 404
INDIRI4
CVIF4 4
SUBF4
ASGNF4
line 6793
;6793:			}
LABELV $2828
line 6795
;6794:
;6795:			if (InFieldOfVision(bs->viewangles, 30, a) &&
ADDRFP4 0
INDIRP4
CNSTI4 1768
ADDP4
ARGP4
CNSTF4 1106247680
ARGF4
ADDRLP4 0
ARGP4
ADDRLP4 396
ADDRGP4 InFieldOfVision
CALLI4
ASGNI4
ADDRLP4 396
INDIRI4
CNSTI4 0
EQI4 $2829
ADDRLP4 400
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 400
INDIRP4
CNSTI4 1708
ADDP4
ARGP4
ADDRLP4 404
CNSTP4 0
ASGNP4
ADDRLP4 404
INDIRP4
ARGP4
ADDRLP4 404
INDIRP4
ARGP4
ADDRLP4 408
ADDRLP4 400
INDIRP4
CNSTI4 1836
ADDP4
INDIRP4
ASGNP4
ADDRLP4 408
INDIRP4
CNSTI4 368
ADDP4
ARGP4
ADDRLP4 400
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 408
INDIRP4
INDIRI4
ARGI4
ADDRLP4 412
ADDRGP4 EntityVisibleBox
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 0
EQI4 $2829
line 6797
;6796:				EntityVisibleBox(bs->origin, NULL, NULL, bs->dangerousObject->r.currentOrigin, bs->client, bs->dangerousObject->s.number))
;6797:			{
line 6798
;6798:				bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 6799
;6799:			}			
LABELV $2829
line 6800
;6800:		}
LABELV $2825
line 6801
;6801:	}
LABELV $2819
line 6803
;6802:
;6803:	if (PrimFiring(bs) ||
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 372
ADDRGP4 PrimFiring
CALLI4
ASGNI4
ADDRLP4 372
INDIRI4
CNSTI4 0
NEI4 $2833
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 376
ADDRGP4 AltFiring
CALLI4
ASGNI4
ADDRLP4 376
INDIRI4
CNSTI4 0
EQI4 $2831
LABELV $2833
line 6805
;6804:		AltFiring(bs))
;6805:	{
line 6806
;6806:		friendInLOF = CheckForFriendInLOF(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 380
ADDRGP4 CheckForFriendInLOF
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 380
INDIRP4
ASGNP4
line 6808
;6807:
;6808:		if (friendInLOF)
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2832
line 6809
;6809:		{
line 6810
;6810:			if (PrimFiring(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 384
ADDRGP4 PrimFiring
CALLI4
ASGNI4
ADDRLP4 384
INDIRI4
CNSTI4 0
EQI4 $2836
line 6811
;6811:			{
line 6812
;6812:				KeepPrimFromFiring(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 KeepPrimFromFiring
CALLI4
pop
line 6813
;6813:			}
LABELV $2836
line 6814
;6814:			if (AltFiring(bs))
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 388
ADDRGP4 AltFiring
CALLI4
ASGNI4
ADDRLP4 388
INDIRI4
CNSTI4 0
EQI4 $2838
line 6815
;6815:			{
line 6816
;6816:				KeepAltFromFiring(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 KeepAltFromFiring
CALLI4
pop
line 6817
;6817:			}
LABELV $2838
line 6818
;6818:			if (useTheForce && forceHostile)
ADDRLP4 392
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 392
INDIRI4
EQI4 $2840
ADDRLP4 16
INDIRI4
ADDRLP4 392
INDIRI4
EQI4 $2840
line 6819
;6819:			{
line 6820
;6820:				useTheForce = 0;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 6821
;6821:			}
LABELV $2840
line 6823
;6822:
;6823:			if (!useTheForce && friendInLOF->client)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2832
ADDRLP4 52
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2832
line 6824
;6824:			{ //we have a friend here and are not currently using force powers, see if we can help them out
line 6825
;6825:				if (friendInLOF->health <= 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_TEAM_HEAL]][FP_TEAM_HEAL])
ADDRLP4 52
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 50
GTI4 $2844
ADDRLP4 396
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 396
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 396
INDIRP4
CNSTI4 976
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+44
ADDP4
INDIRI4
LEI4 $2844
line 6826
;6826:				{
line 6827
;6827:					level.clients[bs->client].ps.fd.forcePowerSelected = FP_TEAM_HEAL;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 11
ASGNI4
line 6828
;6828:					useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 6829
;6829:					forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 6830
;6830:				}
ADDRGP4 $2832
JUMPV
LABELV $2844
line 6831
;6831:				else if (friendInLOF->client->ps.fd.forcePower <= 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_TEAM_FORCE]][FP_TEAM_FORCE])
ADDRLP4 400
CNSTI4 920
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ADDRLP4 400
INDIRI4
ADDP4
INDIRI4
CNSTI4 50
GTI4 $2832
ADDRLP4 404
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 404
INDIRP4
ADDRLP4 400
INDIRI4
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 404
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+48
ADDP4
INDIRI4
LEI4 $2832
line 6832
;6832:				{
line 6833
;6833:					level.clients[bs->client].ps.fd.forcePowerSelected = FP_TEAM_FORCE;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 12
ASGNI4
line 6834
;6834:					useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 6835
;6835:					forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 6836
;6836:				}
line 6837
;6837:			}
line 6838
;6838:		}
line 6839
;6839:	}
ADDRGP4 $2832
JUMPV
LABELV $2831
line 6840
;6840:	else if (g_gametype.integer >= GT_TEAM)
ADDRGP4 g_gametype+12
INDIRI4
CNSTI4 5
LTI4 $2850
line 6841
;6841:	{ //still check for anyone to help..
line 6842
;6842:		friendInLOF = CheckForFriendInLOF(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 380
ADDRGP4 CheckForFriendInLOF
CALLP4
ASGNP4
ADDRLP4 52
ADDRLP4 380
INDIRP4
ASGNP4
line 6844
;6843:
;6844:		if (!useTheForce && friendInLOF)
ADDRLP4 12
INDIRI4
CNSTI4 0
NEI4 $2853
ADDRLP4 52
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2853
line 6845
;6845:		{
line 6846
;6846:			if (friendInLOF->health <= 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_TEAM_HEAL]][FP_TEAM_HEAL])
ADDRLP4 52
INDIRP4
CNSTI4 676
ADDP4
INDIRI4
CNSTI4 50
GTI4 $2855
ADDRLP4 384
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 384
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 384
INDIRP4
CNSTI4 976
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+44
ADDP4
INDIRI4
LEI4 $2855
line 6847
;6847:			{
line 6848
;6848:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_TEAM_HEAL;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 11
ASGNI4
line 6849
;6849:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 6850
;6850:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 6851
;6851:			}
ADDRGP4 $2856
JUMPV
LABELV $2855
line 6852
;6852:			else if (friendInLOF->client->ps.fd.forcePower <= 50 && level.clients[bs->client].ps.fd.forcePower > forcePowerNeeded[level.clients[bs->client].ps.fd.forcePowerLevel[FP_TEAM_FORCE]][FP_TEAM_FORCE])
ADDRLP4 388
CNSTI4 920
ASGNI4
ADDRLP4 52
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ADDRLP4 388
INDIRI4
ADDP4
INDIRI4
CNSTI4 50
GTI4 $2858
ADDRLP4 392
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
ASGNP4
ADDRLP4 392
INDIRP4
ADDRLP4 388
INDIRI4
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 392
INDIRP4
CNSTI4 980
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+48
ADDP4
INDIRI4
LEI4 $2858
line 6853
;6853:			{
line 6854
;6854:				level.clients[bs->client].ps.fd.forcePowerSelected = FP_TEAM_FORCE;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 12
ASGNI4
line 6855
;6855:				useTheForce = 1;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 6856
;6856:				forceHostile = 0;
ADDRLP4 16
CNSTI4 0
ASGNI4
line 6857
;6857:			}
LABELV $2858
LABELV $2856
line 6858
;6858:		}
LABELV $2853
line 6859
;6859:	}
LABELV $2850
LABELV $2832
line 6861
;6860:
;6861:	if (bs->doAttack && bs->cur_ps.weapon == WP_DET_PACK &&
ADDRLP4 380
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 384
CNSTI4 0
ASGNI4
ADDRLP4 380
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
ADDRLP4 384
INDIRI4
EQI4 $2861
ADDRLP4 380
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 13
NEI4 $2861
ADDRLP4 380
INDIRP4
CNSTI4 644
ADDP4
INDIRI4
ADDRLP4 384
INDIRI4
EQI4 $2861
line 6863
;6862:		bs->cur_ps.hasDetPackPlanted)
;6863:	{ //maybe a bit hackish, but bots only want to plant one of these at any given time to avoid complications
line 6864
;6864:		bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6865
;6865:	}
LABELV $2861
line 6867
;6866:
;6867:	if (bs->doAttack && bs->cur_ps.weapon == WP_SABER &&
ADDRLP4 388
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 392
CNSTI4 0
ASGNI4
ADDRLP4 388
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
ADDRLP4 392
INDIRI4
EQI4 $2863
ADDRLP4 388
INDIRP4
CNSTI4 164
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2863
ADDRLP4 388
INDIRP4
CNSTI4 2696
ADDP4
INDIRI4
ADDRLP4 392
INDIRI4
EQI4 $2863
ADDRLP4 396
ADDRLP4 388
INDIRP4
CNSTI4 1804
ADDP4
INDIRP4
ASGNP4
ADDRLP4 400
CNSTU4 0
ASGNU4
ADDRLP4 396
INDIRP4
CVPU4 4
ADDRLP4 400
INDIRU4
EQU4 $2863
ADDRLP4 404
ADDRLP4 396
INDIRP4
CNSTI4 408
ADDP4
INDIRP4
ASGNP4
ADDRLP4 404
INDIRP4
CVPU4 4
ADDRLP4 400
INDIRU4
EQU4 $2863
ADDRLP4 404
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ARGI4
ADDRLP4 408
ADDRGP4 BotWeaponBlockable
CALLI4
ASGNI4
ADDRLP4 408
INDIRI4
CNSTI4 0
EQI4 $2863
line 6870
;6868:		bs->saberDefending && bs->currentEnemy && bs->currentEnemy->client &&
;6869:		BotWeaponBlockable(bs->currentEnemy->client->ps.weapon) )
;6870:	{
line 6871
;6871:		bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6872
;6872:	}
LABELV $2863
line 6874
;6873:
;6874:	if (bs->cur_ps.saberLockTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2865
line 6875
;6875:	{
line 6876
;6876:		if (rand()%10 < 5)
ADDRLP4 412
ADDRGP4 rand
CALLI4
ASGNI4
ADDRLP4 412
INDIRI4
CNSTI4 10
MODI4
CNSTI4 5
GEI4 $2868
line 6877
;6877:		{
line 6878
;6878:			bs->doAttack = 1;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 1
ASGNI4
line 6879
;6879:		}
ADDRGP4 $2869
JUMPV
LABELV $2868
line 6881
;6880:		else
;6881:		{
line 6882
;6882:			bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6883
;6883:		}
LABELV $2869
line 6884
;6884:	}
LABELV $2865
line 6886
;6885:
;6886:	if (bs->botChallengingTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 2728
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2870
line 6887
;6887:	{
line 6888
;6888:		bs->doAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
CNSTI4 0
ASGNI4
line 6889
;6889:		bs->doAltAttack = 0;
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
CNSTI4 0
ASGNI4
line 6890
;6890:	}
LABELV $2870
line 6892
;6891:
;6892:	if (bs->doAttack)
ADDRFP4 0
INDIRP4
CNSTI4 2264
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2873
line 6893
;6893:	{
line 6894
;6894:		trap_EA_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Attack
CALLV
pop
line 6895
;6895:	}
ADDRGP4 $2874
JUMPV
LABELV $2873
line 6896
;6896:	else if (bs->doAltAttack)
ADDRFP4 0
INDIRP4
CNSTI4 2268
ADDP4
INDIRI4
CNSTI4 0
EQI4 $2875
line 6897
;6897:	{
line 6898
;6898:		trap_EA_Alt_Attack(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_Alt_Attack
CALLV
pop
line 6899
;6899:	}
LABELV $2875
LABELV $2874
line 6901
;6900:
;6901:	if (useTheForce && forceHostile && bs->botChallengingTime > level.time)
ADDRLP4 412
CNSTI4 0
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 412
INDIRI4
EQI4 $2877
ADDRLP4 16
INDIRI4
ADDRLP4 412
INDIRI4
EQI4 $2877
ADDRFP4 0
INDIRP4
CNSTI4 2728
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2877
line 6902
;6902:	{
line 6903
;6903:		useTheForce = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 6904
;6904:	}
LABELV $2877
line 6906
;6905:
;6906:	if (useTheForce)
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $2880
line 6907
;6907:	{
line 6909
;6908:#ifndef FORCEJUMP_INSTANTMETHOD
;6909:		if (bs->forceJumpChargeTime > level.time)
ADDRFP4 0
INDIRP4
CNSTI4 4780
ADDP4
INDIRI4
ADDRGP4 level+32
INDIRI4
LEI4 $2882
line 6910
;6910:		{
line 6911
;6911:			level.clients[bs->client].ps.fd.forcePowerSelected = FP_LEVITATION;
CNSTI4 1756
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
MULI4
ADDRGP4 level
INDIRP4
ADDP4
CNSTI4 840
ADDP4
CNSTI4 1
ASGNI4
line 6912
;6912:			trap_EA_ForcePower(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_ForcePower
CALLV
pop
line 6913
;6913:		}
ADDRGP4 $2883
JUMPV
LABELV $2882
line 6915
;6914:		else
;6915:		{
line 6917
;6916:#endif
;6917:			if (bot_forcepowers.integer && !g_forcePowerDisable.integer)
ADDRLP4 416
CNSTI4 0
ASGNI4
ADDRGP4 bot_forcepowers+12
INDIRI4
ADDRLP4 416
INDIRI4
EQI4 $2885
ADDRGP4 g_forcePowerDisable+12
INDIRI4
ADDRLP4 416
INDIRI4
NEI4 $2885
line 6918
;6918:			{
line 6919
;6919:				trap_EA_ForcePower(bs->client);
ADDRFP4 0
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRGP4 trap_EA_ForcePower
CALLV
pop
line 6920
;6920:			}
LABELV $2885
line 6922
;6921:#ifndef FORCEJUMP_INSTANTMETHOD
;6922:		}
LABELV $2883
line 6924
;6923:#endif
;6924:	}
LABELV $2880
line 6926
;6925:
;6926:	MoveTowardIdealAngles(bs);
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 MoveTowardIdealAngles
CALLV
pop
line 6927
;6927:}
LABELV $2317
endproc StandardBotAI 420 24
bss
align 4
LABELV $2890
skip 4
align 4
LABELV $2891
skip 4
align 4
LABELV $2892
skip 4
export BotAIStartFrame
code
proc BotAIStartFrame 24 12
line 6935
;6928://end rww
;6929:
;6930:/*
;6931:==================
;6932:BotAIStartFrame
;6933:==================
;6934:*/
;6935:int BotAIStartFrame(int time) {
line 6942
;6936:	int i;
;6937:	int elapsed_time, thinktime;
;6938:	static int local_time;
;6939:	static int botlib_residual;
;6940:	static int lastbotthink_time;
;6941:
;6942:	G_CheckBotSpawn();
ADDRGP4 G_CheckBotSpawn
CALLV
pop
line 6945
;6943:
;6944:	//rww - addl bot frame functions
;6945:	if (gBotEdit)
ADDRGP4 gBotEdit
INDIRF4
CNSTF4 0
EQF4 $2893
line 6946
;6946:	{
line 6947
;6947:		trap_Cvar_Update(&bot_wp_info);
ADDRGP4 bot_wp_info
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 6948
;6948:		BotWaypointRender();
ADDRGP4 BotWaypointRender
CALLV
pop
line 6949
;6949:	}
LABELV $2893
line 6951
;6950:
;6951:	UpdateEventTracker();
ADDRGP4 UpdateEventTracker
CALLV
pop
line 6956
;6952:	//end rww
;6953:
;6954:	//cap the bot think time
;6955:	//if the bot think time changed we should reschedule the bots
;6956:	if (BOT_THINK_TIME != lastbotthink_time) {
ADDRGP4 $2892
INDIRI4
CNSTI4 0
EQI4 $2895
line 6957
;6957:		lastbotthink_time = BOT_THINK_TIME;
ADDRGP4 $2892
CNSTI4 0
ASGNI4
line 6958
;6958:		BotScheduleBotThink();
ADDRGP4 BotScheduleBotThink
CALLV
pop
line 6959
;6959:	}
LABELV $2895
line 6961
;6960:
;6961:	elapsed_time = time - local_time;
ADDRLP4 4
ADDRFP4 0
INDIRI4
ADDRGP4 $2890
INDIRI4
SUBI4
ASGNI4
line 6962
;6962:	local_time = time;
ADDRGP4 $2890
ADDRFP4 0
INDIRI4
ASGNI4
line 6964
;6963:
;6964:	if (elapsed_time > BOT_THINK_TIME) thinktime = elapsed_time;
ADDRLP4 4
INDIRI4
CNSTI4 0
LEI4 $2897
ADDRLP4 8
ADDRLP4 4
INDIRI4
ASGNI4
ADDRGP4 $2898
JUMPV
LABELV $2897
line 6965
;6965:	else thinktime = BOT_THINK_TIME;
ADDRLP4 8
CNSTI4 0
ASGNI4
LABELV $2898
line 6968
;6966:
;6967:	// execute scheduled bot AI
;6968:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2899
line 6969
;6969:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2905
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2903
LABELV $2905
line 6970
;6970:			continue;
ADDRGP4 $2900
JUMPV
LABELV $2903
line 6973
;6971:		}
;6972:		//
;6973:		botstates[i]->botthink_residual += elapsed_time;
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ASGNI4
line 6975
;6974:		//
;6975:		if ( botstates[i]->botthink_residual >= thinktime ) {
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDRLP4 8
INDIRI4
LTI4 $2906
line 6976
;6976:			botstates[i]->botthink_residual -= thinktime;
ADDRLP4 20
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 4
ADDP4
ASGNP4
ADDRLP4 20
INDIRP4
ADDRLP4 20
INDIRP4
INDIRI4
ADDRLP4 8
INDIRI4
SUBI4
ASGNI4
line 6978
;6977:
;6978:			if (g_entities[i].client->pers.connected == CON_CONNECTED) {
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
CNSTI4 2
NEI4 $2908
line 6979
;6979:				BotAI(i, (float) thinktime / 1000);
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
CVIF4 4
CNSTF4 1148846080
DIVF4
ARGF4
ADDRGP4 BotAI
CALLI4
pop
line 6980
;6980:			}
LABELV $2908
line 6981
;6981:		}
LABELV $2906
line 6982
;6982:	}
LABELV $2900
line 6968
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2899
line 6985
;6983:
;6984:	// execute bot user commands every frame
;6985:	for( i = 0; i < MAX_CLIENTS; i++ ) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2911
line 6986
;6986:		if( !botstates[i] || !botstates[i]->inuse ) {
ADDRLP4 12
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 12
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2917
ADDRLP4 12
INDIRP4
INDIRI4
CNSTI4 0
NEI4 $2915
LABELV $2917
line 6987
;6987:			continue;
ADDRGP4 $2912
JUMPV
LABELV $2915
line 6989
;6988:		}
;6989:		if( g_entities[i].client->pers.connected != CON_CONNECTED ) {
CNSTI4 828
ADDRLP4 0
INDIRI4
MULI4
ADDRGP4 g_entities+408
ADDP4
INDIRP4
CNSTI4 1368
ADDP4
INDIRI4
CNSTI4 2
EQI4 $2918
line 6990
;6990:			continue;
ADDRGP4 $2912
JUMPV
LABELV $2918
line 6993
;6991:		}
;6992:
;6993:		BotUpdateInput(botstates[i], time, elapsed_time);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ARGP4
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRI4
ARGI4
ADDRGP4 BotUpdateInput
CALLV
pop
line 6994
;6994:		trap_BotUserCommand(botstates[i]->client, &botstates[i]->lastucmd);
ADDRLP4 16
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 16
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRLP4 16
INDIRP4
CNSTI4 1384
ADDP4
ARGP4
ADDRGP4 trap_BotUserCommand
CALLV
pop
line 6995
;6995:	}
LABELV $2912
line 6985
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2911
line 6997
;6996:
;6997:	return qtrue;
CNSTI4 1
RETI4
LABELV $2889
endproc BotAIStartFrame 24 12
export BotAISetup
proc BotAISetup 4 16
line 7005
;6998:}
;6999:
;7000:/*
;7001:==============
;7002:BotAISetup
;7003:==============
;7004:*/
;7005:int BotAISetup( int restart ) {
line 7007
;7006:	//rww - new bot cvars..
;7007:	trap_Cvar_Register(&bot_forcepowers, "bot_forcepowers", "1", CVAR_CHEAT);
ADDRGP4 bot_forcepowers
ARGP4
ADDRGP4 $2922
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7008
;7008:	trap_Cvar_Register(&bot_forgimmick, "bot_forgimmick", "0", CVAR_CHEAT);
ADDRGP4 bot_forgimmick
ARGP4
ADDRGP4 $2924
ARGP4
ADDRGP4 $2925
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7014
;7009:#ifdef _DEBUG
;7010:	trap_Cvar_Register(&bot_nogoals, "bot_nogoals", "0", CVAR_CHEAT);
;7011:	trap_Cvar_Register(&bot_debugmessages, "bot_debugmessages", "0", CVAR_CHEAT);
;7012:#endif
;7013:
;7014:	trap_Cvar_Register(&bot_attachments, "bot_attachments", "1", 0);
ADDRGP4 bot_attachments
ARGP4
ADDRGP4 $2926
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7015
;7015:	trap_Cvar_Register(&bot_camp, "bot_camp", "1", 0);
ADDRGP4 bot_camp
ARGP4
ADDRGP4 $2927
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7017
;7016:
;7017:	trap_Cvar_Register(&bot_wp_info, "bot_wp_info", "1", 0);
ADDRGP4 bot_wp_info
ARGP4
ADDRGP4 $2928
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7018
;7018:	trap_Cvar_Register(&bot_wp_edit, "bot_wp_edit", "0", CVAR_CHEAT);
ADDRGP4 bot_wp_edit
ARGP4
ADDRGP4 $2929
ARGP4
ADDRGP4 $2925
ARGP4
CNSTI4 512
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7019
;7019:	trap_Cvar_Register(&bot_wp_clearweight, "bot_wp_clearweight", "1", 0);
ADDRGP4 bot_wp_clearweight
ARGP4
ADDRGP4 $2930
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7020
;7020:	trap_Cvar_Register(&bot_wp_distconnect, "bot_wp_distconnect", "1", 0);
ADDRGP4 bot_wp_distconnect
ARGP4
ADDRGP4 $2931
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7021
;7021:	trap_Cvar_Register(&bot_wp_visconnect, "bot_wp_visconnect", "1", 0);
ADDRGP4 bot_wp_visconnect
ARGP4
ADDRGP4 $2932
ARGP4
ADDRGP4 $2923
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 trap_Cvar_Register
CALLV
pop
line 7023
;7022:
;7023:	trap_Cvar_Update(&bot_forcepowers);
ADDRGP4 bot_forcepowers
ARGP4
ADDRGP4 trap_Cvar_Update
CALLV
pop
line 7027
;7024:	//end rww
;7025:
;7026:	//if the game is restarted for a tournament
;7027:	if (restart) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2933
line 7028
;7028:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $2921
JUMPV
LABELV $2933
line 7032
;7029:	}
;7030:
;7031:	//initialize the bot states
;7032:	memset( botstates, 0, sizeof(botstates) );
ADDRGP4 botstates
ARGP4
CNSTI4 0
ARGI4
CNSTI4 128
ARGI4
ADDRGP4 memset
CALLP4
pop
line 7034
;7033:
;7034:	if (!trap_BotLibSetup())
ADDRLP4 0
ADDRGP4 trap_BotLibSetup
CALLI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $2935
line 7035
;7035:	{
line 7036
;7036:		return qfalse; //wts?!
CNSTI4 0
RETI4
ADDRGP4 $2921
JUMPV
LABELV $2935
line 7039
;7037:	}
;7038:
;7039:	return qtrue;
CNSTI4 1
RETI4
LABELV $2921
endproc BotAISetup 4 16
export BotAIShutdown
proc BotAIShutdown 8 8
line 7047
;7040:}
;7041:
;7042:/*
;7043:==============
;7044:BotAIShutdown
;7045:==============
;7046:*/
;7047:int BotAIShutdown( int restart ) {
line 7052
;7048:
;7049:	int i;
;7050:
;7051:	//if the game is restarted for a tournament
;7052:	if ( restart ) {
ADDRFP4 0
INDIRI4
CNSTI4 0
EQI4 $2938
line 7054
;7053:		//shutdown all the bots in the botlib
;7054:		for (i = 0; i < MAX_CLIENTS; i++) {
ADDRLP4 0
CNSTI4 0
ASGNI4
LABELV $2940
line 7055
;7055:			if (botstates[i] && botstates[i]->inuse) {
ADDRLP4 4
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
ASGNP4
ADDRLP4 4
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $2944
ADDRLP4 4
INDIRP4
INDIRI4
CNSTI4 0
EQI4 $2944
line 7056
;7056:				BotAIShutdownClient(botstates[i]->client, restart);
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 botstates
ADDP4
INDIRP4
CNSTI4 8
ADDP4
INDIRI4
ARGI4
ADDRFP4 0
INDIRI4
ARGI4
ADDRGP4 BotAIShutdownClient
CALLI4
pop
line 7057
;7057:			}
LABELV $2944
line 7058
;7058:		}
LABELV $2941
line 7054
ADDRLP4 0
ADDRLP4 0
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $2940
line 7060
;7059:		//don't shutdown the bot library
;7060:	}
ADDRGP4 $2939
JUMPV
LABELV $2938
line 7061
;7061:	else {
line 7062
;7062:		trap_BotLibShutdown();
ADDRGP4 trap_BotLibShutdown
CALLI4
pop
line 7063
;7063:	}
LABELV $2939
line 7064
;7064:	return qtrue;
CNSTI4 1
RETI4
LABELV $2937
endproc BotAIShutdown 8 8
import G_ThereIsAMaster
import WP_ForcePowerUsable
import ExitLevel
bss
export droppedBlueFlag
align 4
LABELV droppedBlueFlag
skip 4
export droppedRedFlag
align 4
LABELV droppedRedFlag
skip 4
export gBotEventTracker
align 4
LABELV gBotEventTracker
skip 512
import imperial_attackers
import rebel_attackers
export regularupdate_time
align 4
LABELV regularupdate_time
skip 4
export numbots
align 4
LABELV numbots
skip 4
export botstates
align 4
LABELV botstates
skip 128
import forceJumpStrength
import forceJumpHeight
import forcePowerNeeded
import g_MaxHolocronCarry
export floattime
align 4
LABELV floattime
skip 4
import gLevelFlags
import nodenum
import nodetable
import gLastPrintedIndex
import gWPNum
import gWPArray
import gWPRenderedFrame
import gBotEdit
import gDeactivated
import gWPRenderTime
import gBotChatBuffer
export eFlagBlue
align 4
LABELV eFlagBlue
skip 4
export eFlagRed
align 4
LABELV eFlagRed
skip 4
export oFlagBlue
align 4
LABELV oFlagBlue
skip 4
export flagBlue
align 4
LABELV flagBlue
skip 4
export oFlagRed
align 4
LABELV oFlagRed
skip 4
export flagRed
align 4
LABELV flagRed
skip 4
export bot_wp_visconnect
align 4
LABELV bot_wp_visconnect
skip 272
export bot_wp_distconnect
align 4
LABELV bot_wp_distconnect
skip 272
export bot_wp_clearweight
align 4
LABELV bot_wp_clearweight
skip 272
export bot_wp_edit
align 4
LABELV bot_wp_edit
skip 272
export bot_wp_info
align 4
LABELV bot_wp_info
skip 272
export bot_camp
align 4
LABELV bot_camp
skip 272
export bot_attachments
align 4
LABELV bot_attachments
skip 272
export bot_forgimmick
align 4
LABELV bot_forgimmick
skip 272
export bot_forcepowers
align 4
LABELV bot_forcepowers
skip 272
import ConcatArgs
import BotWaypointRender
import BotDoChat
import BotUtilizePersonality
import B_Free
import B_Alloc
import B_TempFree
import B_TempAlloc
import BotResetWeaponState
import BotFreeWeaponState
import BotAllocWeaponState
import BotLoadWeaponWeights
import BotGetWeaponInfo
import BotChooseBestFightWeapon
import BotShutdownWeaponAI
import BotSetupWeaponAI
import BotShutdownMoveAI
import BotSetupMoveAI
import BotSetBrushModelTypes
import BotAddAvoidSpot
import BotInitMoveState
import BotFreeMoveState
import BotAllocMoveState
import BotPredictVisiblePosition
import BotMovementViewTarget
import BotReachabilityArea
import BotResetLastAvoidReach
import BotResetAvoidReach
import BotMoveInDirection
import BotMoveToGoal
import BotResetMoveState
import BotShutdownGoalAI
import BotSetupGoalAI
import BotFreeGoalState
import BotAllocGoalState
import BotFreeItemWeights
import BotLoadItemWeights
import BotMutateGoalFuzzyLogic
import BotSaveGoalFuzzyLogic
import BotInterbreedGoalFuzzyLogic
import BotUpdateEntityItems
import BotInitLevelItems
import BotSetAvoidGoalTime
import BotAvoidGoalTime
import BotGetMapLocationGoal
import BotGetNextCampSpotGoal
import BotGetLevelItemGoal
import BotItemGoalInVisButNotVisible
import BotTouchingGoal
import BotChooseNBGItem
import BotChooseLTGItem
import BotGetSecondGoal
import BotGetTopGoal
import BotGoalName
import BotDumpGoalStack
import BotDumpAvoidGoals
import BotEmptyGoalStack
import BotPopGoal
import BotPushGoal
import BotRemoveFromAvoidGoals
import BotResetAvoidGoals
import BotResetGoalState
import GeneticParentsAndChildSelection
import BotSetChatName
import BotSetChatGender
import BotLoadChatFile
import BotReplaceSynonyms
import UnifyWhiteSpaces
import BotMatchVariable
import BotFindMatch
import StringContains
import BotGetChatMessage
import BotEnterChat
import BotChatLength
import BotReplyChat
import BotNumInitialChats
import BotInitialChat
import BotNumConsoleMessages
import BotNextConsoleMessage
import BotRemoveConsoleMessage
import BotQueueConsoleMessage
import BotFreeChatState
import BotAllocChatState
import BotShutdownChatAI
import BotSetupChatAI
import BotShutdownCharacters
import Characteristic_String
import Characteristic_BInteger
import Characteristic_Integer
import Characteristic_BFloat
import Characteristic_Float
import BotFreeCharacter
import BotLoadCharacter
import EA_Shutdown
import EA_Setup
import EA_ResetInput
import EA_GetInput
import EA_EndRegular
import EA_View
import EA_Move
import EA_DelayedJump
import EA_Jump
import EA_SelectWeapon
import EA_Use
import EA_Gesture
import EA_Talk
import EA_Respawn
import EA_ForcePower
import EA_Alt_Attack
import EA_Attack
import EA_MoveRight
import EA_MoveLeft
import EA_MoveBack
import EA_MoveForward
import EA_MoveDown
import EA_MoveUp
import EA_Walk
import EA_Crouch
import EA_Action
import EA_Command
import EA_SayTeam
import EA_Say
import GetBotLibAPI
import trap_ROFF_Purge_Ent
import trap_ROFF_Play
import trap_ROFF_Cache
import trap_ROFF_UpdateEntities
import trap_ROFF_Clean
import trap_SP_GetStringTextString
import trap_SP_Register
import trap_SP_RegisterServer
import trap_SnapVector
import trap_GeneticParentsAndChildSelection
import trap_BotResetWeaponState
import trap_BotFreeWeaponState
import trap_BotAllocWeaponState
import trap_BotLoadWeaponWeights
import trap_BotGetWeaponInfo
import trap_BotChooseBestFightWeapon
import trap_BotAddAvoidSpot
import trap_BotInitMoveState
import trap_BotFreeMoveState
import trap_BotAllocMoveState
import trap_BotPredictVisiblePosition
import trap_BotMovementViewTarget
import trap_BotReachabilityArea
import trap_BotResetLastAvoidReach
import trap_BotResetAvoidReach
import trap_BotMoveInDirection
import trap_BotMoveToGoal
import trap_BotResetMoveState
import trap_BotFreeGoalState
import trap_BotAllocGoalState
import trap_BotMutateGoalFuzzyLogic
import trap_BotSaveGoalFuzzyLogic
import trap_BotInterbreedGoalFuzzyLogic
import trap_BotFreeItemWeights
import trap_BotLoadItemWeights
import trap_BotUpdateEntityItems
import trap_BotInitLevelItems
import trap_BotSetAvoidGoalTime
import trap_BotAvoidGoalTime
import trap_BotGetLevelItemGoal
import trap_BotGetMapLocationGoal
import trap_BotGetNextCampSpotGoal
import trap_BotItemGoalInVisButNotVisible
import trap_BotTouchingGoal
import trap_BotChooseNBGItem
import trap_BotChooseLTGItem
import trap_BotGetSecondGoal
import trap_BotGetTopGoal
import trap_BotGoalName
import trap_BotDumpGoalStack
import trap_BotDumpAvoidGoals
import trap_BotEmptyGoalStack
import trap_BotPopGoal
import trap_BotPushGoal
import trap_BotResetAvoidGoals
import trap_BotRemoveFromAvoidGoals
import trap_BotResetGoalState
import trap_BotSetChatName
import trap_BotSetChatGender
import trap_BotLoadChatFile
import trap_BotReplaceSynonyms
import trap_UnifyWhiteSpaces
import trap_BotMatchVariable
import trap_BotFindMatch
import trap_StringContains
import trap_BotGetChatMessage
import trap_BotEnterChat
import trap_BotChatLength
import trap_BotReplyChat
import trap_BotNumInitialChats
import trap_BotInitialChat
import trap_BotNumConsoleMessages
import trap_BotNextConsoleMessage
import trap_BotRemoveConsoleMessage
import trap_BotQueueConsoleMessage
import trap_BotFreeChatState
import trap_BotAllocChatState
import trap_Characteristic_String
import trap_Characteristic_BInteger
import trap_Characteristic_Integer
import trap_Characteristic_BFloat
import trap_Characteristic_Float
import trap_BotFreeCharacter
import trap_BotLoadCharacter
import trap_EA_ResetInput
import trap_EA_GetInput
import trap_EA_EndRegular
import trap_EA_ForcePower
import trap_EA_Alt_Attack
import trap_EA_View
import trap_EA_Move
import trap_EA_DelayedJump
import trap_EA_Jump
import trap_EA_SelectWeapon
import trap_EA_MoveRight
import trap_EA_MoveLeft
import trap_EA_MoveBack
import trap_EA_MoveForward
import trap_EA_MoveDown
import trap_EA_MoveUp
import trap_EA_Crouch
import trap_EA_Respawn
import trap_EA_Use
import trap_EA_Attack
import trap_EA_Talk
import trap_EA_Gesture
import trap_EA_Action
import trap_EA_Command
import trap_EA_SayTeam
import trap_EA_Say
import trap_AAS_PredictClientMovement
import trap_AAS_Swimming
import trap_AAS_AlternativeRouteGoals
import trap_AAS_PredictRoute
import trap_AAS_EnableRoutingArea
import trap_AAS_AreaTravelTimeToGoalArea
import trap_AAS_AreaReachability
import trap_AAS_IntForBSPEpairKey
import trap_AAS_FloatForBSPEpairKey
import trap_AAS_VectorForBSPEpairKey
import trap_AAS_ValueForBSPEpairKey
import trap_AAS_NextBSPEntity
import trap_AAS_PointContents
import trap_AAS_TraceAreas
import trap_AAS_PointReachabilityAreaIndex
import trap_AAS_PointAreaNum
import trap_AAS_Time
import trap_AAS_PresenceTypeBoundingBox
import trap_AAS_Initialized
import trap_AAS_EntityInfo
import trap_AAS_AreaInfo
import trap_AAS_BBoxAreas
import trap_BotUserCommand
import trap_BotGetServerCommand
import trap_BotGetSnapshotEntity
import trap_BotLibTest
import trap_BotLibUpdateEntity
import trap_BotLibLoadMap
import trap_BotLibStartFrame
import trap_BotLibDefine
import trap_BotLibVarGet
import trap_BotLibVarSet
import trap_BotLibShutdown
import trap_BotLibSetup
import trap_DebugPolygonDelete
import trap_DebugPolygonCreate
import trap_GetEntityToken
import trap_GetUsercmd
import trap_BotFreeClient
import trap_BotAllocateClient
import trap_EntityContact
import trap_EntitiesInBox
import trap_UnlinkEntity
import trap_LinkEntity
import trap_AreasConnected
import trap_AdjustAreaPortalState
import trap_InPVSIgnorePortals
import trap_InPVS
import trap_PointContents
import trap_Trace
import trap_SetBrushModel
import trap_GetServerinfo
import trap_SetUserinfo
import trap_GetUserinfo
import trap_GetConfigstring
import trap_SetConfigstring
import trap_SendServerCommand
import trap_DropClient
import trap_LocateGameData
import trap_Cvar_VariableStringBuffer
import trap_Cvar_VariableValue
import trap_Cvar_VariableIntegerValue
import trap_Cvar_Set
import trap_Cvar_Update
import trap_Cvar_Register
import trap_SendConsoleCommand
import trap_FS_GetFileList
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import trap_Args
import trap_Argv
import trap_Argc
import trap_Milliseconds
import trap_Error
import trap_Printf
import g_timeouttospec
import g_forceDodge
import g_dismember
import g_singlePlayer
import g_enableBreath
import g_enableDust
import g_rankings
import pmove_msec
import pmove_fixed
import g_smoothClients
import g_blueteam
import g_redteam
import g_debugUp
import g_debugRight
import g_debugForward
import g_filterBan
import g_banIPs
import g_teamForceBalance
import g_teamAutoJoin
import g_allowVote
import g_blood
import g_doWarmup
import g_warmup
import g_motd
import g_synchronousClients
import g_adaptRespawn
import g_weaponTeamRespawn
import g_weaponRespawn
import g_debugDamage
import g_debugAlloc
import g_debugMove
import g_inactivity
import g_forcerespawn
import g_quadfactor
import g_knockback
import g_speed
import g_gravity
import g_needpass
import g_password
import g_friendlySaber
import g_friendlyFire
import g_saberInterpolate
import g_capturelimit
import g_timelimit
import g_duel_fraglimit
import g_fraglimit
import g_duelWeaponDisable
import g_weaponDisable
import g_forcePowerDisable
import g_spawnInvulnerability
import g_forceRegenTime
import g_saberLocking
import g_privateDuel
import g_forceBasedTeams
import g_maxForceRank
import g_dmflags
import g_autoMapCycle
import g_restarted
import g_maxGameClients
import g_maxclients
import g_cheats
import g_dedicated
import g_gametype
import g_entities
import level
import Pickup_Team
import CheckTeamStatus
import TeamplayInfoMessage
import Team_GetLocationMsg
import Team_GetLocation
import SelectSagaSpawnPoint
import SelectCTFSpawnPoint
import Team_FreeEntity
import Team_ReturnFlag
import Team_InitGame
import Team_CheckHurtCarrier
import Team_FragBonuses
import Team_DroppedFlagThink
import AddTeamScore
import TeamColorString
import OtherTeamName
import TeamName
import OtherTeam
import B_CleanupAlloc
import B_InitAlloc
import InitSagaMode
import G_ClearClientLog
import G_LogExit
import G_LogWeaponOutput
import G_LogWeaponInit
import G_LogWeaponItem
import G_LogWeaponPowerup
import G_LogWeaponFrag
import G_LogWeaponDeath
import G_LogWeaponKill
import G_LogWeaponDamage
import G_LogWeaponFire
import G_LogWeaponPickup
import Jedi_DodgeEvasion
import ForceTelepathy
import ForceThrow
import ForceSeeing
import ForceTeamForceReplenish
import ForceTeamHeal
import ForceAbsorb
import ForceProtect
import ForceGrip
import ForceRage
import ForceSpeed
import ForceHeal
import ForcePowerUsableOn
import WP_ForcePowersUpdate
import WP_SpawnInitForcePowers
import WP_InitForcePowers
import WP_SaberInitBladeData
import WP_SaberCanBlock
import WP_SaberPositionUpdate
import WP_ForcePowerStop
import HasSetSaberOnly
import G_PreDefSound
import G_RefreshNextMap
import G_DoesMapSupportGametype
import BotInterbreedEndMatch
import Svcmd_BotList_f
import Svcmd_AddBot_f
import G_BotConnect
import G_RemoveQueuedBotBegin
import G_CheckBotSpawn
import G_GetBotInfoByName
import G_GetBotInfoByNumber
import G_InitBots
import UpdateTournamentInfo
import G_WriteSessionData
import G_InitWorldSession
import G_InitSessionData
import G_ReadSessionData
import Svcmd_GameMem_f
import G_InitMemory
import G_Alloc
import Team_CheckDroppedItem
import OnSameTeam
import G_RunClient
import ClientEndFrame
import ClientThink
import G_CheckClientTimeouts
import ClientCommand
import ClientBegin
import ClientDisconnect
import ClientUserinfoChanged
import ClientConnect
import G_GetStripEdString
import G_Error
import G_Printf
import SendScoreboardMessageToAllClients
import G_LogPrintf
import G_RunThink
import CheckTeamLeader
import SetLeader
import FindIntermissionPoint
import g_ff_objectives
import DeathmatchScoreboardMessage
import G_SetStats
import MoveClientToIntermission
import BlowDetpacks
import FireWeapon
import G_FilterPacket
import G_ProcessIPBans
import ConsoleCommand
import gJMSaberEnt
import SpotWouldTelefrag
import CalculateRanks
import AddScore
import player_die
import ClientSpawn
import InitBodyQue
import BeginIntermission
import respawn
import CopyToBodyQue
import SelectSpawnPoint
import SetClientViewAngle
import PickTeam
import TeamLeader
import TeamCount
import CheckGauntletAttack
import SnapVectorTowards
import CalcMuzzlePoint
import LogAccuracyHit
import WP_FireGenericBlasterMissile
import WP_FireTurretMissile
import G_PlayerBecomeATST
import ATST_ManageDamageBoxes
import TeleportPlayer
import trigger_teleporter_touch
import Touch_DoorTrigger
import G_RunMover
import WP_FireBlasterMissile
import G_ExplodeMissile
import G_BounceProjectile
import CreateMissile
import G_RunMissile
import G_ReflectMissile
import ExplodeDeath
import TossClientCubes
import TossClientItems
import TossClientWeapon
import body_die
import G_RadiusDamage
import G_Damage
import CanDamage
import trap_G2API_SetBoneAnim
import trap_G2API_GetGLAName
import trap_G2API_SetBoneAngles
import trap_G2API_CleanGhoul2Models
import trap_G2API_RemoveGhoul2Model
import trap_G2API_HasGhoul2ModelOnIndex
import trap_G2API_DuplicateGhoul2Instance
import trap_G2API_CopySpecificGhoul2Model
import trap_G2API_CopyGhoul2Instance
import trap_G2API_SetBoltInfo
import trap_G2API_AddBolt
import trap_G2API_InitGhoul2Model
import trap_G2API_GetBoltMatrix_NoReconstruct
import trap_G2API_GetBoltMatrix
import trap_G2_HaveWeGhoul2Models
import trap_G2_SetGhoul2ModelIndexes
import trap_G2_ListModelBones
import trap_G2_ListModelSurfaces
import G_SkinIndex
import BuildShaderStateConfig
import AddRemap
import G_SetOrigin
import G_AddEvent
import G_AddPredictableEvent
import vtos
import tv
import G_RunObject
import G_TouchSolids
import G_TouchTriggers
import G_EntitiesFree
import G_FreeEntity
import G_KillG2Queue
import G_SendG2KillQueue
import TryUse
import G_EntitySound
import G_SoundAtLoc
import G_Sound
import G_MuteSound
import G_ScreenShake
import G_PlayEffect
import G_TempEntity
import G_Spawn
import G_InitGentity
import G_SetAngles
import G_SetMovedir
import G_UseTargets
import G_PickTarget
import G_RadiusList
import G_Find
import G_KillBox
import G_TeamCommand
import G_EffectIndex
import G_SoundIndex
import G_ModelIndex
import SaveRegisteredItems
import RegisterItem
import ClearRegisteredItems
import Touch_Item
import Add_Ammo
import ArmorIndex
import Think_Weapon
import FinishSpawningItem
import G_SpawnItem
import SetRespawn
import LaunchItem
import Drop_Item
import PrecacheItem
import UseHoldableItem
import RespawnItem
import G_RunItem
import G_CheckTeamItems
import ItemUse_MedPack
import ItemUse_Seeker
import ItemUse_Sentry
import ItemUse_Shield
import ItemUse_Binoculars
import G_GetDuelWinner
import Cmd_EngageDuel_f
import Cmd_ToggleSaber_f
import G_ItemUsable
import Cmd_SaberAttackCycle_f
import Cmd_FollowCycle_f
import SetTeam
import BroadcastTeamChange
import StopFollowing
import Cmd_Score_f
import G_NewString
import G_SpawnEntitiesFromString
import G_SpawnVector
import G_SpawnInt
import G_SpawnFloat
import G_SpawnString
import g2SaberInstance
import precachedKyle
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
LABELV $2932
char 1 98
char 1 111
char 1 116
char 1 95
char 1 119
char 1 112
char 1 95
char 1 118
char 1 105
char 1 115
char 1 99
char 1 111
char 1 110
char 1 110
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $2931
char 1 98
char 1 111
char 1 116
char 1 95
char 1 119
char 1 112
char 1 95
char 1 100
char 1 105
char 1 115
char 1 116
char 1 99
char 1 111
char 1 110
char 1 110
char 1 101
char 1 99
char 1 116
char 1 0
align 1
LABELV $2930
char 1 98
char 1 111
char 1 116
char 1 95
char 1 119
char 1 112
char 1 95
char 1 99
char 1 108
char 1 101
char 1 97
char 1 114
char 1 119
char 1 101
char 1 105
char 1 103
char 1 104
char 1 116
char 1 0
align 1
LABELV $2929
char 1 98
char 1 111
char 1 116
char 1 95
char 1 119
char 1 112
char 1 95
char 1 101
char 1 100
char 1 105
char 1 116
char 1 0
align 1
LABELV $2928
char 1 98
char 1 111
char 1 116
char 1 95
char 1 119
char 1 112
char 1 95
char 1 105
char 1 110
char 1 102
char 1 111
char 1 0
align 1
LABELV $2927
char 1 98
char 1 111
char 1 116
char 1 95
char 1 99
char 1 97
char 1 109
char 1 112
char 1 0
align 1
LABELV $2926
char 1 98
char 1 111
char 1 116
char 1 95
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 104
char 1 109
char 1 101
char 1 110
char 1 116
char 1 115
char 1 0
align 1
LABELV $2925
char 1 48
char 1 0
align 1
LABELV $2924
char 1 98
char 1 111
char 1 116
char 1 95
char 1 102
char 1 111
char 1 114
char 1 103
char 1 105
char 1 109
char 1 109
char 1 105
char 1 99
char 1 107
char 1 0
align 1
LABELV $2923
char 1 49
char 1 0
align 1
LABELV $2922
char 1 98
char 1 111
char 1 116
char 1 95
char 1 102
char 1 111
char 1 114
char 1 99
char 1 101
char 1 112
char 1 111
char 1 119
char 1 101
char 1 114
char 1 115
char 1 0
align 1
LABELV $2481
char 1 75
char 1 105
char 1 108
char 1 108
char 1 101
char 1 100
char 1 0
align 1
LABELV $2478
char 1 75
char 1 105
char 1 108
char 1 108
char 1 101
char 1 100
char 1 72
char 1 97
char 1 116
char 1 101
char 1 100
char 1 79
char 1 110
char 1 101
char 1 0
align 1
LABELV $2342
char 1 75
char 1 105
char 1 108
char 1 108
char 1 101
char 1 100
char 1 79
char 1 110
char 1 80
char 1 117
char 1 114
char 1 112
char 1 111
char 1 115
char 1 101
char 1 66
char 1 121
char 1 76
char 1 111
char 1 118
char 1 101
char 1 0
align 1
LABELV $2339
char 1 68
char 1 105
char 1 101
char 1 100
char 1 0
align 1
LABELV $2256
char 1 100
char 1 101
char 1 116
char 1 112
char 1 97
char 1 99
char 1 107
char 1 0
align 1
LABELV $2238
char 1 102
char 1 114
char 1 101
char 1 101
char 1 100
char 1 0
align 1
LABELV $2213
char 1 82
char 1 101
char 1 115
char 1 112
char 1 111
char 1 110
char 1 115
char 1 101
char 1 71
char 1 114
char 1 101
char 1 101
char 1 116
char 1 105
char 1 110
char 1 103
char 1 115
char 1 0
align 1
LABELV $2115
char 1 66
char 1 101
char 1 108
char 1 111
char 1 118
char 1 101
char 1 100
char 1 75
char 1 105
char 1 108
char 1 108
char 1 101
char 1 100
char 1 0
align 1
LABELV $2112
char 1 72
char 1 97
char 1 116
char 1 114
char 1 101
char 1 100
char 1 0
align 1
LABELV $2105
char 1 76
char 1 111
char 1 118
char 1 101
char 1 100
char 1 79
char 1 110
char 1 101
char 1 75
char 1 105
char 1 108
char 1 108
char 1 101
char 1 100
char 1 76
char 1 111
char 1 118
char 1 101
char 1 100
char 1 79
char 1 110
char 1 101
char 1 0
align 1
LABELV $450
char 1 102
char 1 117
char 1 110
char 1 99
char 1 95
char 1 0
align 1
LABELV $387
char 1 71
char 1 101
char 1 110
char 1 101
char 1 114
char 1 97
char 1 108
char 1 71
char 1 114
char 1 101
char 1 101
char 1 116
char 1 105
char 1 110
char 1 103
char 1 115
char 1 0
align 1
LABELV $381
char 1 66
char 1 111
char 1 116
char 1 65
char 1 73
char 1 83
char 1 101
char 1 116
char 1 117
char 1 112
char 1 67
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 58
char 1 32
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 32
char 1 37
char 1 100
char 1 32
char 1 97
char 1 108
char 1 114
char 1 101
char 1 97
char 1 100
char 1 121
char 1 32
char 1 115
char 1 101
char 1 116
char 1 117
char 1 112
char 1 10
char 1 0
align 1
LABELV $353
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 76
char 1 101
char 1 118
char 1 101
char 1 108
char 1 83
char 1 104
char 1 111
char 1 116
char 1 0
align 1
LABELV $350
char 1 115
char 1 99
char 1 111
char 1 114
char 1 101
char 1 115
char 1 0
align 1
LABELV $347
char 1 99
char 1 115
char 1 0
align 1
LABELV $344
char 1 99
char 1 112
char 1 32
char 1 0
align 1
LABELV $336
char 1 66
char 1 111
char 1 116
char 1 65
char 1 73
char 1 58
char 1 32
char 1 99
char 1 108
char 1 105
char 1 101
char 1 110
char 1 116
char 1 32
char 1 37
char 1 100
char 1 32
char 1 105
char 1 115
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 115
char 1 101
char 1 116
char 1 117
char 1 112
char 1 10
char 1 0
align 1
LABELV $160
char 1 79
char 1 114
char 1 100
char 1 101
char 1 114
char 1 65
char 1 99
char 1 99
char 1 101
char 1 112
char 1 116
char 1 101
char 1 100
char 1 0
align 1
LABELV $100
char 1 73
char 1 39
char 1 109
char 1 32
char 1 97
char 1 116
char 1 116
char 1 101
char 1 109
char 1 112
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 116
char 1 111
char 1 32
char 1 114
char 1 101
char 1 103
char 1 114
char 1 111
char 1 117
char 1 112
char 1 32
char 1 97
char 1 110
char 1 100
char 1 32
char 1 102
char 1 111
char 1 114
char 1 109
char 1 32
char 1 97
char 1 32
char 1 110
char 1 101
char 1 119
char 1 32
char 1 115
char 1 113
char 1 117
char 1 97
char 1 100
char 1 0
align 1
LABELV $99
char 1 73
char 1 39
char 1 109
char 1 32
char 1 97
char 1 115
char 1 115
char 1 105
char 1 115
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 109
char 1 121
char 1 32
char 1 99
char 1 111
char 1 109
char 1 109
char 1 97
char 1 110
char 1 100
char 1 105
char 1 110
char 1 103
char 1 0
align 1
LABELV $98
char 1 73
char 1 39
char 1 109
char 1 32
char 1 102
char 1 111
char 1 108
char 1 108
char 1 111
char 1 119
char 1 105
char 1 110
char 1 103
char 1 32
char 1 109
char 1 121
char 1 32
char 1 115
char 1 113
char 1 117
char 1 97
char 1 100
char 1 32
char 1 99
char 1 111
char 1 109
char 1 109
char 1 97
char 1 110
char 1 100
char 1 101
char 1 114
char 1 0
align 1
LABELV $97
char 1 73
char 1 39
char 1 109
char 1 32
char 1 112
char 1 114
char 1 101
char 1 118
char 1 101
char 1 110
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 101
char 1 110
char 1 101
char 1 109
char 1 121
char 1 32
char 1 102
char 1 114
char 1 111
char 1 109
char 1 32
char 1 99
char 1 111
char 1 109
char 1 112
char 1 108
char 1 101
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 116
char 1 104
char 1 101
char 1 105
char 1 114
char 1 32
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 118
char 1 101
char 1 0
align 1
LABELV $96
char 1 73
char 1 39
char 1 109
char 1 32
char 1 97
char 1 116
char 1 116
char 1 101
char 1 109
char 1 116
char 1 112
char 1 105
char 1 110
char 1 103
char 1 32
char 1 116
char 1 111
char 1 32
char 1 99
char 1 111
char 1 109
char 1 112
char 1 108
char 1 101
char 1 116
char 1 101
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 99
char 1 117
char 1 114
char 1 114
char 1 101
char 1 110
char 1 116
char 1 32
char 1 111
char 1 98
char 1 106
char 1 101
char 1 99
char 1 116
char 1 105
char 1 118
char 1 101
char 1 0
align 1
LABELV $95
char 1 73
char 1 39
char 1 118
char 1 101
char 1 32
char 1 103
char 1 111
char 1 116
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 101
char 1 110
char 1 101
char 1 109
char 1 121
char 1 39
char 1 115
char 1 32
char 1 102
char 1 108
char 1 97
char 1 103
char 1 0
align 1
LABELV $94
char 1 73
char 1 39
char 1 109
char 1 32
char 1 101
char 1 115
char 1 99
char 1 111
char 1 114
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 111
char 1 117
char 1 114
char 1 32
char 1 102
char 1 108
char 1 97
char 1 103
char 1 32
char 1 99
char 1 97
char 1 114
char 1 114
char 1 105
char 1 101
char 1 114
char 1 0
align 1
LABELV $93
char 1 73
char 1 39
char 1 109
char 1 32
char 1 103
char 1 101
char 1 116
char 1 116
char 1 105
char 1 110
char 1 103
char 1 32
char 1 111
char 1 117
char 1 114
char 1 32
char 1 102
char 1 108
char 1 97
char 1 103
char 1 32
char 1 98
char 1 97
char 1 99
char 1 107
char 1 0
align 1
LABELV $92
char 1 73
char 1 39
char 1 109
char 1 32
char 1 100
char 1 101
char 1 102
char 1 101
char 1 110
char 1 100
char 1 105
char 1 110
char 1 103
char 1 32
char 1 111
char 1 117
char 1 114
char 1 32
char 1 98
char 1 97
char 1 115
char 1 101
char 1 0
align 1
LABELV $91
char 1 73
char 1 39
char 1 109
char 1 32
char 1 97
char 1 116
char 1 116
char 1 97
char 1 99
char 1 107
char 1 105
char 1 110
char 1 103
char 1 32
char 1 116
char 1 104
char 1 101
char 1 32
char 1 101
char 1 110
char 1 101
char 1 109
char 1 121
char 1 39
char 1 115
char 1 32
char 1 98
char 1 97
char 1 115
char 1 101
char 1 0
align 1
LABELV $90
char 1 73
char 1 39
char 1 109
char 1 32
char 1 110
char 1 111
char 1 116
char 1 32
char 1 111
char 1 99
char 1 99
char 1 117
char 1 112
char 1 105
char 1 101
char 1 100
char 1 0
align 1
LABELV $89
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 77
char 1 65
char 1 88
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 83
char 1 0
align 1
LABELV $88
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 71
char 1 69
char 1 84
char 1 70
char 1 76
char 1 65
char 1 71
char 1 72
char 1 79
char 1 77
char 1 69
char 1 0
align 1
LABELV $87
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 71
char 1 85
char 1 65
char 1 82
char 1 68
char 1 67
char 1 65
char 1 82
char 1 82
char 1 73
char 1 69
char 1 82
char 1 0
align 1
LABELV $86
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 82
char 1 69
char 1 84
char 1 82
char 1 73
char 1 69
char 1 86
char 1 65
char 1 76
char 1 0
align 1
LABELV $85
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 68
char 1 69
char 1 70
char 1 69
char 1 78
char 1 68
char 1 69
char 1 82
char 1 0
align 1
LABELV $84
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 65
char 1 84
char 1 84
char 1 65
char 1 67
char 1 75
char 1 69
char 1 82
char 1 0
align 1
LABELV $83
char 1 67
char 1 84
char 1 70
char 1 83
char 1 84
char 1 65
char 1 84
char 1 69
char 1 95
char 1 78
char 1 79
char 1 78
char 1 69
char 1 0

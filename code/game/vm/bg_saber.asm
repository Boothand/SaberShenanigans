export PM_irand_timesync
code
proc PM_irand_timesync 8 4
file "../bg_saber.c"
line 6
;1:#include "q_shared.h"
;2:#include "bg_public.h"
;3:#include "bg_local.h"
;4:
;5:int PM_irand_timesync(int val1, int val2)
;6:{
line 9
;7:	int i;
;8:
;9:	i = (val1-1) + (Q_random( &pm->cmd.serverTime )*(val2 - val1)) + 1;
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
ARGP4
ADDRLP4 4
ADDRGP4 Q_random
CALLF4
ASGNF4
ADDRLP4 0
ADDRFP4 0
INDIRI4
CNSTI4 1
SUBI4
CVIF4 4
ADDRLP4 4
INDIRF4
ADDRFP4 4
INDIRI4
ADDRFP4 0
INDIRI4
SUBI4
CVIF4 4
MULF4
ADDF4
CNSTF4 1065353216
ADDF4
CVFI4 4
ASGNI4
line 10
;10:	if (i < val1)
ADDRLP4 0
INDIRI4
ADDRFP4 0
INDIRI4
GEI4 $66
line 11
;11:	{
line 12
;12:		i = val1;
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
line 13
;13:	}
LABELV $66
line 14
;14:	if (i > val2)
ADDRLP4 0
INDIRI4
ADDRFP4 4
INDIRI4
LEI4 $68
line 15
;15:	{
line 16
;16:		i = val2;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 17
;17:	}
LABELV $68
line 19
;18:
;19:	return i;
ADDRLP4 0
INDIRI4
RETI4
LABELV $65
endproc PM_irand_timesync 8 4
export BG_ForcePowerDrain
proc BG_ForcePowerDrain 12 0
line 23
;20:}
;21:
;22:void BG_ForcePowerDrain( playerState_t *ps, forcePowers_t forcePower, int overrideAmt )
;23:{
line 25
;24:	//take away the power
;25:	int	drain = overrideAmt;
ADDRLP4 0
ADDRFP4 8
INDIRI4
ASGNI4
line 34
;26:
;27:	/*
;28:	if (ps->powerups[PW_FORCE_BOON])
;29:	{
;30:		return;
;31:	}
;32:	*/
;33:
;34:	if ( !drain )
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $71
line 35
;35:	{
line 36
;36:		drain = forcePowerNeeded[ps->fd.forcePowerLevel[forcePower]][forcePower];
ADDRLP4 4
ADDRFP4 4
INDIRI4
CNSTI4 2
LSHI4
ASGNI4
ADDRLP4 0
ADDRLP4 4
INDIRI4
CNSTI4 72
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 932
ADDP4
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded
ADDP4
ADDP4
INDIRI4
ASGNI4
line 37
;37:	}
LABELV $71
line 38
;38:	if ( !drain )
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $73
line 39
;39:	{
line 40
;40:		return;
ADDRGP4 $70
JUMPV
LABELV $73
line 43
;41:	}
;42:
;43:	if (forcePower == FP_LEVITATION)
ADDRFP4 4
INDIRI4
CNSTI4 1
NEI4 $75
line 44
;44:	{ //special case
line 45
;45:		int jumpDrain = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 47
;46:
;47:		if (ps->velocity[2] > 250)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1132068864
LEF4 $77
line 48
;48:		{
line 49
;49:			jumpDrain = 20;
ADDRLP4 4
CNSTI4 20
ASGNI4
line 50
;50:		}
ADDRGP4 $78
JUMPV
LABELV $77
line 51
;51:		else if (ps->velocity[2] > 200)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1128792064
LEF4 $79
line 52
;52:		{
line 53
;53:			jumpDrain = 16;
ADDRLP4 4
CNSTI4 16
ASGNI4
line 54
;54:		}
ADDRGP4 $80
JUMPV
LABELV $79
line 55
;55:		else if (ps->velocity[2] > 150)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1125515264
LEF4 $81
line 56
;56:		{
line 57
;57:			jumpDrain = 12;
ADDRLP4 4
CNSTI4 12
ASGNI4
line 58
;58:		}
ADDRGP4 $82
JUMPV
LABELV $81
line 59
;59:		else if (ps->velocity[2] > 100)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1120403456
LEF4 $83
line 60
;60:		{
line 61
;61:			jumpDrain = 8;
ADDRLP4 4
CNSTI4 8
ASGNI4
line 62
;62:		}
ADDRGP4 $84
JUMPV
LABELV $83
line 63
;63:		else if (ps->velocity[2] > 50)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1112014848
LEF4 $85
line 64
;64:		{
line 65
;65:			jumpDrain = 6;
ADDRLP4 4
CNSTI4 6
ASGNI4
line 66
;66:		}
ADDRGP4 $86
JUMPV
LABELV $85
line 67
;67:		else if (ps->velocity[2] > 0)
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 0
LEF4 $87
line 68
;68:		{
line 69
;69:			jumpDrain = 4;
ADDRLP4 4
CNSTI4 4
ASGNI4
line 70
;70:		}
LABELV $87
LABELV $86
LABELV $84
LABELV $82
LABELV $80
LABELV $78
line 72
;71:
;72:		if (jumpDrain)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $89
line 73
;73:		{
line 74
;74:			jumpDrain /= ps->fd.forcePowerLevel[FP_LEVITATION];
ADDRLP4 4
ADDRLP4 4
INDIRI4
ADDRFP4 0
INDIRP4
CNSTI4 936
ADDP4
INDIRI4
DIVI4
ASGNI4
line 75
;75:		}
LABELV $89
line 77
;76:
;77:		ps->fd.forcePower -= jumpDrain;
ADDRLP4 8
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
ASGNP4
ADDRLP4 8
INDIRP4
ADDRLP4 8
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
SUBI4
ASGNI4
line 78
;78:		if ( ps->fd.forcePower < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 0
GEI4 $70
line 79
;79:		{
line 80
;80:			ps->fd.forcePower = 0;
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
CNSTI4 0
ASGNI4
line 81
;81:		}
line 83
;82:
;83:		return;
ADDRGP4 $70
JUMPV
LABELV $75
line 86
;84:	}
;85:
;86:	ps->fd.forcePower -= drain;
ADDRLP4 4
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
ASGNP4
ADDRLP4 4
INDIRP4
ADDRLP4 4
INDIRP4
INDIRI4
ADDRLP4 0
INDIRI4
SUBI4
ASGNI4
line 87
;87:	if ( ps->fd.forcePower < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 0
GEI4 $93
line 88
;88:	{
line 89
;89:		ps->fd.forcePower = 0;
ADDRFP4 0
INDIRP4
CNSTI4 920
ADDP4
CNSTI4 0
ASGNI4
line 90
;90:	}
LABELV $93
line 91
;91:}
LABELV $70
endproc BG_ForcePowerDrain 12 0
data
export saberMoveData
align 4
LABELV saberMoveData
address $95
byte 4 550
byte 4 1
byte 4 1
byte 4 0
byte 4 350
byte 4 0
byte 4 0
byte 4 0
byte 4 0
address $96
byte 4 553
byte 4 1
byte 4 1
byte 4 0
byte 4 350
byte 4 2
byte 4 1
byte 4 22
byte 4 0
address $97
byte 4 566
byte 4 1
byte 4 1
byte 4 2
byte 4 350
byte 4 0
byte 4 1
byte 4 22
byte 4 0
address $98
byte 4 567
byte 4 1
byte 4 1
byte 4 2
byte 4 350
byte 4 0
byte 4 1
byte 4 22
byte 4 0
address $99
byte 4 129
byte 4 4
byte 4 0
byte 4 10
byte 4 100
byte 4 1
byte 4 25
byte 4 25
byte 4 200
address $100
byte 4 127
byte 4 5
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 26
byte 4 26
byte 4 200
address $101
byte 4 131
byte 4 6
byte 4 2
byte 4 10
byte 4 50
byte 4 1
byte 4 27
byte 4 27
byte 4 200
address $102
byte 4 130
byte 4 0
byte 4 4
byte 4 10
byte 4 100
byte 4 1
byte 4 28
byte 4 28
byte 4 200
address $103
byte 4 128
byte 4 1
byte 4 5
byte 4 10
byte 4 100
byte 4 1
byte 4 29
byte 4 29
byte 4 200
address $104
byte 4 132
byte 4 2
byte 4 6
byte 4 10
byte 4 100
byte 4 1
byte 4 30
byte 4 30
byte 4 200
address $105
byte 4 126
byte 4 3
byte 4 7
byte 4 10
byte 4 100
byte 4 1
byte 4 31
byte 4 31
byte 4 200
address $106
byte 4 803
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $107
byte 4 804
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $108
byte 4 809
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $109
byte 4 808
byte 4 7
byte 4 3
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $110
byte 4 807
byte 4 3
byte 4 7
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $111
byte 4 806
byte 4 1
byte 4 3
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 51
byte 4 200
address $112
byte 4 805
byte 4 5
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 1
byte 4 40
byte 4 200
address $113
byte 4 178
byte 4 1
byte 4 4
byte 4 10
byte 4 100
byte 4 1
byte 4 4
byte 4 4
byte 4 200
address $114
byte 4 176
byte 4 1
byte 4 5
byte 4 10
byte 4 100
byte 4 1
byte 4 5
byte 4 5
byte 4 200
address $115
byte 4 180
byte 4 1
byte 4 6
byte 4 10
byte 4 100
byte 4 1
byte 4 6
byte 4 6
byte 4 200
address $116
byte 4 179
byte 4 1
byte 4 0
byte 4 10
byte 4 100
byte 4 1
byte 4 7
byte 4 7
byte 4 200
address $117
byte 4 177
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 1
byte 4 8
byte 4 8
byte 4 200
address $118
byte 4 181
byte 4 1
byte 4 2
byte 4 10
byte 4 100
byte 4 1
byte 4 9
byte 4 9
byte 4 200
address $119
byte 4 175
byte 4 1
byte 4 3
byte 4 10
byte 4 100
byte 4 1
byte 4 10
byte 4 10
byte 4 200
address $120
byte 4 186
byte 4 0
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $121
byte 4 184
byte 4 1
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $122
byte 4 188
byte 4 2
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $123
byte 4 185
byte 4 4
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $124
byte 4 183
byte 4 5
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $125
byte 4 187
byte 4 6
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $126
byte 4 182
byte 4 7
byte 4 1
byte 4 2
byte 4 100
byte 4 1
byte 4 1
byte 4 1
byte 4 200
address $127
byte 4 133
byte 4 0
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $128
byte 4 160
byte 4 0
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $129
byte 4 161
byte 4 0
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $130
byte 4 134
byte 4 0
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $131
byte 4 135
byte 4 0
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $132
byte 4 136
byte 4 0
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $133
byte 4 162
byte 4 1
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $134
byte 4 137
byte 4 1
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $135
byte 4 163
byte 4 1
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $136
byte 4 138
byte 4 1
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $137
byte 4 139
byte 4 1
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $138
byte 4 140
byte 4 1
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $139
byte 4 141
byte 4 2
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $140
byte 4 164
byte 4 2
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $141
byte 4 165
byte 4 2
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $142
byte 4 142
byte 4 2
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $143
byte 4 143
byte 4 2
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $144
byte 4 144
byte 4 2
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $145
byte 4 145
byte 4 3
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $146
byte 4 146
byte 4 3
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $147
byte 4 147
byte 4 3
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $148
byte 4 148
byte 4 3
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $149
byte 4 149
byte 4 3
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $150
byte 4 150
byte 4 3
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $151
byte 4 151
byte 4 4
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $152
byte 4 166
byte 4 4
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $153
byte 4 167
byte 4 4
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $154
byte 4 168
byte 4 4
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $155
byte 4 169
byte 4 4
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $156
byte 4 152
byte 4 4
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $157
byte 4 153
byte 4 5
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $158
byte 4 154
byte 4 5
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $159
byte 4 170
byte 4 5
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $160
byte 4 171
byte 4 5
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $161
byte 4 155
byte 4 5
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $162
byte 4 172
byte 4 5
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 6
byte 4 150
address $163
byte 4 156
byte 4 6
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 7
byte 4 150
address $164
byte 4 157
byte 4 6
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 8
byte 4 150
address $165
byte 4 158
byte 4 6
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 9
byte 4 150
address $166
byte 4 173
byte 4 6
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 10
byte 4 150
address $167
byte 4 174
byte 4 6
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 4
byte 4 150
address $168
byte 4 159
byte 4 6
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 5
byte 4 150
address $169
byte 4 189
byte 4 0
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 33
byte 4 150
address $170
byte 4 190
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 42
byte 4 150
address $171
byte 4 191
byte 4 2
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 47
byte 4 150
address $172
byte 4 192
byte 4 3
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 55
byte 4 150
address $173
byte 4 193
byte 4 4
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 58
byte 4 150
address $174
byte 4 194
byte 4 5
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 63
byte 4 150
address $175
byte 4 195
byte 4 6
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 70
byte 4 150
address $176
byte 4 196
byte 4 0
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 25
byte 4 33
byte 4 150
address $177
byte 4 197
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 26
byte 4 42
byte 4 150
address $178
byte 4 198
byte 4 2
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 47
byte 4 150
address $179
byte 4 192
byte 4 3
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 55
byte 4 150
address $180
byte 4 199
byte 4 4
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 28
byte 4 58
byte 4 150
address $181
byte 4 200
byte 4 5
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 29
byte 4 63
byte 4 150
address $182
byte 4 201
byte 4 6
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 30
byte 4 70
byte 4 150
address $183
byte 4 202
byte 4 7
byte 4 7
byte 4 10
byte 4 100
byte 4 0
byte 4 27
byte 4 55
byte 4 150
address $184
byte 4 522
byte 4 0
byte 4 0
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $185
byte 4 523
byte 4 1
byte 4 1
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $186
byte 4 524
byte 4 2
byte 4 2
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $187
byte 4 525
byte 4 3
byte 4 3
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $188
byte 4 526
byte 4 4
byte 4 4
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $189
byte 4 527
byte 4 5
byte 4 5
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $190
byte 4 528
byte 4 6
byte 4 6
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $191
byte 4 529
byte 4 7
byte 4 7
byte 4 10
byte 4 100
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $192
byte 4 530
byte 4 3
byte 4 7
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $193
byte 4 531
byte 4 2
byte 4 6
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $194
byte 4 532
byte 4 4
byte 4 0
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $195
byte 4 533
byte 4 6
byte 4 2
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $196
byte 4 534
byte 4 7
byte 4 3
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $197
byte 4 535
byte 4 0
byte 4 4
byte 4 10
byte 4 50
byte 4 0
byte 4 1
byte 4 1
byte 4 150
address $198
byte 4 516
byte 4 1
byte 4 3
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 50
byte 4 150
address $199
byte 4 517
byte 4 1
byte 4 2
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 45
byte 4 150
address $200
byte 4 518
byte 4 1
byte 4 4
byte 4 10
byte 4 50
byte 4 2
byte 4 28
byte 4 60
byte 4 150
address $201
byte 4 519
byte 4 1
byte 4 6
byte 4 10
byte 4 50
byte 4 2
byte 4 25
byte 4 72
byte 4 150
address $202
byte 4 521
byte 4 1
byte 4 0
byte 4 10
byte 4 50
byte 4 2
byte 4 30
byte 4 33
byte 4 150
address $203
byte 4 511
byte 4 1
byte 4 3
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 10
byte 4 150
address $204
byte 4 512
byte 4 1
byte 4 4
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 9
byte 4 150
address $205
byte 4 513
byte 4 1
byte 4 2
byte 4 10
byte 4 50
byte 4 2
byte 4 28
byte 4 4
byte 4 150
address $206
byte 4 514
byte 4 1
byte 4 0
byte 4 10
byte 4 50
byte 4 2
byte 4 25
byte 4 7
byte 4 150
address $207
byte 4 515
byte 4 1
byte 4 6
byte 4 10
byte 4 50
byte 4 2
byte 4 30
byte 4 6
byte 4 150
address $208
byte 4 511
byte 4 1
byte 4 3
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 10
byte 4 300
address $209
byte 4 513
byte 4 1
byte 4 2
byte 4 10
byte 4 50
byte 4 2
byte 4 28
byte 4 4
byte 4 300
address $210
byte 4 512
byte 4 1
byte 4 4
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 9
byte 4 300
address $211
byte 4 515
byte 4 1
byte 4 6
byte 4 10
byte 4 50
byte 4 2
byte 4 30
byte 4 6
byte 4 300
address $212
byte 4 514
byte 4 1
byte 4 0
byte 4 10
byte 4 50
byte 4 2
byte 4 25
byte 4 7
byte 4 300
address $213
byte 4 1089
byte 4 1
byte 4 2
byte 4 10
byte 4 50
byte 4 2
byte 4 28
byte 4 4
byte 4 150
address $214
byte 4 1090
byte 4 1
byte 4 4
byte 4 10
byte 4 50
byte 4 2
byte 4 27
byte 4 9
byte 4 150
skip 560
export transitionMove
align 4
LABELV transitionMove
byte 4 0
byte 4 32
byte 4 33
byte 4 34
byte 4 35
byte 4 36
byte 4 37
byte 4 0
byte 4 38
byte 4 0
byte 4 39
byte 4 40
byte 4 41
byte 4 42
byte 4 43
byte 4 0
byte 4 44
byte 4 45
byte 4 0
byte 4 46
byte 4 47
byte 4 48
byte 4 49
byte 4 0
byte 4 50
byte 4 51
byte 4 52
byte 4 0
byte 4 53
byte 4 54
byte 4 55
byte 4 0
byte 4 56
byte 4 57
byte 4 58
byte 4 59
byte 4 0
byte 4 60
byte 4 61
byte 4 0
byte 4 62
byte 4 63
byte 4 64
byte 4 65
byte 4 66
byte 4 0
byte 4 67
byte 4 0
byte 4 68
byte 4 69
byte 4 70
byte 4 71
byte 4 72
byte 4 73
byte 4 0
byte 4 0
byte 4 68
byte 4 32
byte 4 33
byte 4 34
byte 4 35
byte 4 36
byte 4 37
byte 4 0
export PM_AttackMoveForQuad
code
proc PM_AttackMoveForQuad 4 0
line 326
;92:
;93:// Silly, but I'm replacing these macros so they are shorter!
;94:#define AFLAG_IDLE	(SETANIM_FLAG_NORMAL)
;95:#define AFLAG_ACTIVE (/*SETANIM_FLAG_OVERRIDE | */SETANIM_FLAG_HOLD | SETANIM_FLAG_HOLDLESS)
;96:#define AFLAG_WAIT (SETANIM_FLAG_HOLD | SETANIM_FLAG_HOLDLESS)
;97:#define AFLAG_FINISH (SETANIM_FLAG_HOLD)
;98:
;99:saberMoveData_t	saberMoveData[LS_MOVE_MAX] = {//							NB:randomized
;100:	// name			anim				startQ	endQ	setanimflag		blend,	blocking	chain_idle		chain_attack	trailLen
;101:	{"None",		BOTH_STAND1,		Q_R,	Q_R,	AFLAG_IDLE,		350,	BLK_NO,		LS_NONE,		LS_NONE,		0	},	// LS_NONE		= 0,
;102:
;103:	// General movements with saber
;104:	{"Ready",		BOTH_STAND2,		Q_R,	Q_R,	AFLAG_IDLE,		350,	BLK_WIDE,	LS_READY,		LS_S_R2L,		0	},	// LS_READY,
;105:	{"Draw",		BOTH_STAND1TO2,		Q_R,	Q_R,	AFLAG_FINISH,	350,	BLK_NO,		LS_READY,		LS_S_R2L,		0	},	// LS_DRAW,
;106:	{"Putaway",		BOTH_STAND2TO1,		Q_R,	Q_R,	AFLAG_FINISH,	350,	BLK_NO,		LS_READY,		LS_S_R2L,		0	},	// LS_PUTAWAY,
;107:
;108:	// Attacks
;109:	//UL2LR
;110:	{"TL2BR Att",	BOTH_A1_TL_BR,		Q_TL,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_TL2BR,		LS_R_TL2BR,		200	},	// LS_A_TL2BR
;111:	//SLASH LEFT
;112:	{"L2R Att",		BOTH_A1__L__R,		Q_L,	Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_L2R,		LS_R_L2R,		200 },	// LS_A_L2R
;113:	//LL2UR
;114:	{"BL2TR Att",	BOTH_A1_BL_TR,		Q_BL,	Q_TR,	AFLAG_ACTIVE,	50,		BLK_TIGHT,	LS_R_BL2TR,		LS_R_BL2TR,		200	},	// LS_A_BL2TR
;115:	//LR2UL
;116:	{"BR2TL Att",	BOTH_A1_BR_TL,		Q_BR,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_BR2TL,		LS_R_BR2TL,		200	},	// LS_A_BR2TL
;117:	//SLASH RIGHT
;118:	{"R2L Att",		BOTH_A1__R__L,		Q_R,	Q_L,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_R2L,		LS_R_R2L,		200 },// LS_A_R2L
;119:	//UR2LL
;120:	{"TR2BL Att",	BOTH_A1_TR_BL,		Q_TR,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_TR2BL,		LS_R_TR2BL,		200	},	// LS_A_TR2BL
;121:	//SLASH DOWN
;122:	{"T2B Att",		BOTH_A1_T__B_,		Q_T,	Q_B,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_R_T2B,		LS_R_T2B,		200	},	// LS_A_T2B
;123:	//special attacks
;124:	{"Back Stab",	BOTH_A2_STABBACK1,	Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_A_BACKSTAB
;125:	{"Back Att",	BOTH_ATTACK_BACK,	Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_A_BACK
;126:	{"CR Back Att",	BOTH_CROUCHATTACKBACK1,Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_A_BACK_CR
;127:	{"Lunge Att",	BOTH_LUNGE2_B__T_,	Q_B,	Q_T,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_A_LUNGE
;128:	{"Jump Att",	BOTH_FORCELEAP2_T__B_,Q_T,	Q_B,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_A_JUMP_T__B_
;129:	{"Flip Stab",	BOTH_JUMPFLIPSTABDOWN,Q_R,	Q_T,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_T1_T___R,	200	},	// LS_A_FLIP_STAB
;130:	{"Flip Slash",	BOTH_JUMPFLIPSLASHDOWN1,Q_L,Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_READY,		LS_T1__R_T_,	200	},	// LS_A_FLIP_SLASH
;131:
;132:	//starts
;133:	{"TL2BR St",	BOTH_S1_S1_TL,		Q_R,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_TL2BR,		LS_A_TL2BR,		200	},	// LS_S_TL2BR
;134:	{"L2R St",		BOTH_S1_S1__L,		Q_R,	Q_L,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_L2R,		LS_A_L2R,		200	},	// LS_S_L2R
;135:	{"BL2TR St",	BOTH_S1_S1_BL,		Q_R,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_BL2TR,		LS_A_BL2TR,		200	},	// LS_S_BL2TR
;136:	{"BR2TL St",	BOTH_S1_S1_BR,		Q_R,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_BR2TL,		LS_A_BR2TL,		200	},	// LS_S_BR2TL
;137:	{"R2L St",		BOTH_S1_S1__R,		Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_R2L,		LS_A_R2L,		200	},	// LS_S_R2L
;138:	{"TR2BL St",	BOTH_S1_S1_TR,		Q_R,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_TR2BL,		LS_A_TR2BL,		200	},	// LS_S_TR2BL
;139:	{"T2B St",		BOTH_S1_S1_T_,		Q_R,	Q_T,	AFLAG_ACTIVE,	100,	BLK_TIGHT,	LS_A_T2B,		LS_A_T2B,		200	},	// LS_S_T2B
;140:	
;141:	//returns
;142:	{"TL2BR Ret",	BOTH_R1_BR_S1,		Q_BR,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_TL2BR
;143:	{"L2R Ret",		BOTH_R1__R_S1,		Q_R,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_L2R
;144:	{"BL2TR Ret",	BOTH_R1_TR_S1,		Q_TR,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_BL2TR
;145:	{"BR2TL Ret",	BOTH_R1_TL_S1,		Q_TL,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_BR2TL
;146:	{"R2L Ret",		BOTH_R1__L_S1,		Q_L,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_R2L
;147:	{"TR2BL Ret",	BOTH_R1_BL_S1,		Q_BL,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_TR2BL
;148:	{"T2B Ret",		BOTH_R1_B__S1,		Q_B,	Q_R,	AFLAG_FINISH,	100,	BLK_TIGHT,	LS_READY,		LS_READY,		200	},	// LS_R_T2B
;149:
;150:	//Transitions
;151:	{"BR2R Trans",	BOTH_T1_BR__R,		Q_BR,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast arc bottom right to right
;152:	{"BR2TR Trans",	BOTH_T1_BR_TR,		Q_BR,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast arc bottom right to top right		(use: BOTH_T1_TR_BR)
;153:	{"BR2T Trans",	BOTH_T1_BR_T_,		Q_BR,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast arc bottom right to top			(use: BOTH_T1_T__BR)
;154:	{"BR2TL Trans",	BOTH_T1_BR_TL,		Q_BR,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast weak spin bottom right to top left
;155:	{"BR2L Trans",	BOTH_T1_BR__L,		Q_BR,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast weak spin bottom right to left
;156:	{"BR2BL Trans",	BOTH_T1_BR_BL,		Q_BR,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast weak spin bottom right to bottom left
;157:	{"R2BR Trans",	BOTH_T1__R_BR,		Q_R,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast arc right to bottom right			(use: BOTH_T1_BR__R)
;158:	{"R2TR Trans",	BOTH_T1__R_TR,		Q_R,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast arc right to top right
;159:	{"R2T Trans",	BOTH_T1__R_T_,		Q_R,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast ar right to top				(use: BOTH_T1_T___R)
;160:	{"R2TL Trans",	BOTH_T1__R_TL,		Q_R,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast arc right to top left
;161:	{"R2L Trans",	BOTH_T1__R__L,		Q_R,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast weak spin right to left
;162:	{"R2BL Trans",	BOTH_T1__R_BL,		Q_R,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast weak spin right to bottom left
;163:	{"TR2BR Trans",	BOTH_T1_TR_BR,		Q_TR,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast arc top right to bottom right
;164:	{"TR2R Trans",	BOTH_T1_TR__R,		Q_TR,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast arc top right to right			(use: BOTH_T1__R_TR)
;165:	{"TR2T Trans",	BOTH_T1_TR_T_,		Q_TR,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast arc top right to top				(use: BOTH_T1_T__TR)
;166:	{"TR2TL Trans",	BOTH_T1_TR_TL,		Q_TR,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast arc top right to top left
;167:	{"TR2L Trans",	BOTH_T1_TR__L,		Q_TR,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast arc top right to left
;168:	{"TR2BL Trans",	BOTH_T1_TR_BL,		Q_TR,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast weak spin top right to bottom left
;169:	{"T2BR Trans",	BOTH_T1_T__BR,		Q_T,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast arc top to bottom right
;170:	{"T2R Trans",	BOTH_T1_T___R,		Q_T,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast arc top to right
;171:	{"T2TR Trans",	BOTH_T1_T__TR,		Q_T,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast arc top to top right
;172:	{"T2TL Trans",	BOTH_T1_T__TL,		Q_T,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast arc top to top left
;173:	{"T2L Trans",	BOTH_T1_T___L,		Q_T,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast arc top to left
;174:	{"T2BL Trans",	BOTH_T1_T__BL,		Q_T,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast arc top to bottom left
;175:	{"TL2BR Trans",	BOTH_T1_TL_BR,		Q_TL,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast weak spin top left to bottom right
;176:	{"TL2R Trans",	BOTH_T1_TL__R,		Q_TL,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast arc top left to right			(use: BOTH_T1__R_TL)
;177:	{"TL2TR Trans",	BOTH_T1_TL_TR,		Q_TL,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast arc top left to top right			(use: BOTH_T1_TR_TL)
;178:	{"TL2T Trans",	BOTH_T1_TL_T_,		Q_TL,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast arc top left to top				(use: BOTH_T1_T__TL)
;179:	{"TL2L Trans",	BOTH_T1_TL__L,		Q_TL,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast arc top left to left				(use: BOTH_T1__L_TL)
;180:	{"TL2BL Trans",	BOTH_T1_TL_BL,		Q_TL,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast arc top left to bottom left
;181:	{"L2BR Trans",	BOTH_T1__L_BR,		Q_L,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast weak spin left to bottom right
;182:	{"L2R Trans",	BOTH_T1__L__R,		Q_L,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast weak spin left to right
;183:	{"L2TR Trans",	BOTH_T1__L_TR,		Q_L,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast arc left to top right			(use: BOTH_T1_TR__L)
;184:	{"L2T Trans",	BOTH_T1__L_T_,		Q_L,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast arc left to top				(use: BOTH_T1_T___L)
;185:	{"L2TL Trans",	BOTH_T1__L_TL,		Q_L,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast arc left to top left
;186:	{"L2BL Trans",	BOTH_T1__L_BL,		Q_L,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	//# Fast arc left to bottom left			(use: BOTH_T1_BL__L)
;187:	{"BL2BR Trans",	BOTH_T1_BL_BR,		Q_BL,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	//# Fast weak spin bottom left to bottom right
;188:	{"BL2R Trans",	BOTH_T1_BL__R,		Q_BL,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_A_R2L,		150	},	//# Fast weak spin bottom left to right
;189:	{"BL2TR Trans",	BOTH_T1_BL_TR,		Q_BL,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	//# Fast weak spin bottom left to top right
;190:	{"BL2T Trans",	BOTH_T1_BL_T_,		Q_BL,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_A_T2B,		150	},	//# Fast arc bottom left to top			(use: BOTH_T1_T__BL)
;191:	{"BL2TL Trans",	BOTH_T1_BL_TL,		Q_BL,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	//# Fast arc bottom left to top left		(use: BOTH_T1_TL_BL)
;192:	{"BL2L Trans",	BOTH_T1_BL__L,		Q_BL,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_A_L2R,		150	},	//# Fast arc bottom left to left
;193:
;194:	//Bounces
;195:	{"Bounce BR",	BOTH_B1_BR___,		Q_BR,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_T1_BR_TR,	150	},	
;196:	{"Bounce R",	BOTH_B1__R___,		Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_T1__R__L,	150	},	
;197:	{"Bounce TR",	BOTH_B1_TR___,		Q_TR,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_T1_TR_TL,	150	},	
;198:	{"Bounce T",	BOTH_B1_T____,		Q_T,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_T1_T__BL,	150	},	
;199:	{"Bounce TL",	BOTH_B1_TL___,		Q_TL,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_T1_TL_TR,	150	},	
;200:	{"Bounce L",	BOTH_B1__L___,		Q_L,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_T1__L__R,	150	},	
;201:	{"Bounce BL",	BOTH_B1_BL___,		Q_BL,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_T1_BL_TR,	150	},	
;202:
;203:	//Deflected attacks (like bounces, but slide off enemy saber, not straight back)
;204:	{"Deflect BR",	BOTH_D1_BR___,		Q_BR,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TL2BR,		LS_T1_BR_TR,	150	},	
;205:	{"Deflect R",	BOTH_D1__R___,		Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_L2R,		LS_T1__R__L,	150	},	
;206:	{"Deflect TR",	BOTH_D1_TR___,		Q_TR,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_T1_TR_TL,	150	},	
;207:	{"Deflect T",	BOTH_B1_T____,		Q_T,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_T1_T__BL,	150	},	
;208:	{"Deflect TL",	BOTH_D1_TL___,		Q_TL,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BR2TL,		LS_T1_TL_TR,	150	},	
;209:	{"Deflect L",	BOTH_D1__L___,		Q_L,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_R2L,		LS_T1__L__R,	150	},	
;210:	{"Deflect BL",	BOTH_D1_BL___,		Q_BL,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_TR2BL,		LS_T1_BL_TR,	150	},	
;211:	{"Deflect B",	BOTH_D1_B____,		Q_B,	Q_B,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_R_BL2TR,		LS_T1_T__BL,	150	},	
;212:
;213:	//Reflected attacks
;214:	{"Reflected BR",BOTH_V1_BR_S1,		Q_BR,	Q_BR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_BR
;215:	{"Reflected R",	BOTH_V1__R_S1,		Q_R,	Q_R,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1__R
;216:	{"Reflected TR",BOTH_V1_TR_S1,		Q_TR,	Q_TR,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_TR
;217:	{"Reflected T",	BOTH_V1_T__S1,		Q_T,	Q_T,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_T_
;218:	{"Reflected TL",BOTH_V1_TL_S1,		Q_TL,	Q_TL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_TL
;219:	{"Reflected L",	BOTH_V1__L_S1,		Q_L,	Q_L,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1__L
;220:	{"Reflected BL",BOTH_V1_BL_S1,		Q_BL,	Q_BL,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_BL
;221:	{"Reflected B",	BOTH_V1_B__S1,		Q_B,	Q_B,	AFLAG_ACTIVE,	100,	BLK_NO,	LS_READY,		LS_READY,	150	},//	LS_V1_B_
;222:
;223:	// Broken parries
;224:	{"BParry Top",	BOTH_H1_S1_T_,		Q_T,	Q_B,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_UP,
;225:	{"BParry UR",	BOTH_H1_S1_TR,		Q_TR,	Q_BL,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_UR,
;226:	{"BParry UL",	BOTH_H1_S1_TL,		Q_TL,	Q_BR,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_UL,
;227:	{"BParry LR",	BOTH_H1_S1_BL,		Q_BL,	Q_TR,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_LR,
;228:	{"BParry Bot",	BOTH_H1_S1_B_,		Q_B,	Q_T,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_LL
;229:	{"BParry LL",	BOTH_H1_S1_BR,		Q_BR,	Q_TL,	AFLAG_ACTIVE,	50,		BLK_NO,	LS_READY,		LS_READY,		150	},	// LS_PARRY_LL
;230:
;231:	// Knockaways
;232:	{"Knock Top",	BOTH_K1_S1_T_,		Q_R,	Q_T,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_T1_T__BR,		150	},	// LS_PARRY_UP,
;233:	{"Knock UR",	BOTH_K1_S1_TR,		Q_R,	Q_TR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_T1_TR__R,		150	},	// LS_PARRY_UR,
;234:	{"Knock UL",	BOTH_K1_S1_TL,		Q_R,	Q_TL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BR2TL,		LS_T1_TL__L,		150	},	// LS_PARRY_UL,
;235:	{"Knock LR",	BOTH_K1_S1_BL,		Q_R,	Q_BL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TL2BR,		LS_T1_BL_TL,		150	},	// LS_PARRY_LR,
;236:	{"Knock LL",	BOTH_K1_S1_BR,		Q_R,	Q_BR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TR2BL,		LS_T1_BR_TR,		150	},	// LS_PARRY_LL
;237:
;238:	// Parry
;239:	{"Parry Top",	BOTH_P1_S1_T_,		Q_R,	Q_T,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_A_T2B,		150	},	// LS_PARRY_UP,
;240:	{"Parry UR",	BOTH_P1_S1_TR,		Q_R,	Q_TL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_A_TR2BL,		150	},	// LS_PARRY_UR,
;241:	{"Parry UL",	BOTH_P1_S1_TL,		Q_R,	Q_TR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BR2TL,		LS_A_TL2BR,		150	},	// LS_PARRY_UL,
;242:	{"Parry LR",	BOTH_P1_S1_BL,		Q_R,	Q_BR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TL2BR,		LS_A_BR2TL,		150	},	// LS_PARRY_LR,
;243:	{"Parry LL",	BOTH_P1_S1_BR,		Q_R,	Q_BL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TR2BL,		LS_A_BL2TR,		150	},	// LS_PARRY_LL
;244:
;245:	// Reflecting a missile
;246:	{"Reflect Top",	BOTH_P1_S1_T_,		Q_R,	Q_T,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_A_T2B,		300	},	// LS_PARRY_UP,
;247:	{"Reflect UR",	BOTH_P1_S1_TL,		Q_R,	Q_TR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BR2TL,		LS_A_TL2BR,		300	},	// LS_PARRY_UR,
;248:	{"Reflect UL",	BOTH_P1_S1_TR,		Q_R,	Q_TL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_BL2TR,		LS_A_TR2BL,		300	},	// LS_PARRY_UL,
;249:	{"Reflect LR",	BOTH_P1_S1_BR,		Q_R,	Q_BL,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TR2BL,		LS_A_BL2TR,		300	},	// LS_PARRY_LR
;250:	{"Reflect LL",	BOTH_P1_S1_BL,		Q_R,	Q_BR,	AFLAG_ACTIVE,	50,		BLK_WIDE,	LS_R_TL2BR,		LS_A_BR2TL,		300	},	// LS_PARRY_LL,
;251:
;252:	//Boot
;253:	{ "BOOT_Parry DL", BOOT_BLOCK_DIAG_LEFT, Q_R, Q_TR, AFLAG_ACTIVE, 50, BLK_WIDE, LS_R_BR2TL, LS_A_TL2BR, 150 },	// BOOT diag left
;254:	{ "BOOT_Parry DR", BOOT_BLOCK_DIAG_RIGHT, Q_R, Q_TL, AFLAG_ACTIVE, 50, BLK_WIDE, LS_R_BL2TR, LS_A_TR2BL, 150 },	// BOOT diag right
;255:};
;256:
;257:int transitionMove[Q_NUM_QUADS][Q_NUM_QUADS] = 
;258:{
;259:	LS_NONE,	//Can't transition to same pos!
;260:	LS_T1_BR__R,//40
;261:	LS_T1_BR_TR,
;262:	LS_T1_BR_T_,
;263:	LS_T1_BR_TL,
;264:	LS_T1_BR__L,
;265:	LS_T1_BR_BL,
;266:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;267:	LS_T1__R_BR,//46
;268:	LS_NONE,	//Can't transition to same pos!
;269:	LS_T1__R_TR,
;270:	LS_T1__R_T_,
;271:	LS_T1__R_TL,
;272:	LS_T1__R__L,
;273:	LS_T1__R_BL,
;274:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;275:	LS_T1_TR_BR,//52
;276:	LS_T1_TR__R,
;277:	LS_NONE,	//Can't transition to same pos!
;278:	LS_T1_TR_T_,
;279:	LS_T1_TR_TL,
;280:	LS_T1_TR__L,
;281:	LS_T1_TR_BL,
;282:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;283:	LS_T1_T__BR,//58
;284:	LS_T1_T___R,
;285:	LS_T1_T__TR,
;286:	LS_NONE,	//Can't transition to same pos!
;287:	LS_T1_T__TL,
;288:	LS_T1_T___L,
;289:	LS_T1_T__BL,
;290:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;291:	LS_T1_TL_BR,//64
;292:	LS_T1_TL__R,
;293:	LS_T1_TL_TR,
;294:	LS_T1_TL_T_,
;295:	LS_NONE,	//Can't transition to same pos!
;296:	LS_T1_TL__L,
;297:	LS_T1_TL_BL,
;298:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;299:	LS_T1__L_BR,//70
;300:	LS_T1__L__R,
;301:	LS_T1__L_TR,
;302:	LS_T1__L_T_,
;303:	LS_T1__L_TL,
;304:	LS_NONE,	//Can't transition to same pos!
;305:	LS_T1__L_BL,
;306:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;307:	LS_T1_BL_BR,//76
;308:	LS_T1_BL__R,
;309:	LS_T1_BL_TR,
;310:	LS_T1_BL_T_,
;311:	LS_T1_BL_TL,
;312:	LS_T1_BL__L,
;313:	LS_NONE,	//Can't transition to same pos!
;314:	LS_NONE,	//No transitions to bottom, and no anims start there, so shouldn't need any
;315:	LS_T1_BL_BR,//NOTE: there are no transitions from bottom, so re-use the bottom right transitions
;316:	LS_T1_BR__R,
;317:	LS_T1_BR_TR,
;318:	LS_T1_BR_T_,
;319:	LS_T1_BR_TL,
;320:	LS_T1_BR__L,
;321:	LS_T1_BR_BL,
;322:	LS_NONE		//No transitions to bottom, and no anims start there, so shouldn't need any
;323:};
;324:
;325:saberMoveName_t PM_AttackMoveForQuad( int quad )
;326:{
line 327
;327:	switch ( quad )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 0
LTI4 $216
ADDRLP4 0
INDIRI4
CNSTI4 7
GTI4 $216
ADDRLP4 0
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $225
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $225
address $218
address $219
address $220
address $221
address $222
address $223
address $224
address $218
code
line 328
;328:	{
LABELV $218
line 331
;329:	case Q_B:
;330:	case Q_BR:
;331:		return LS_A_BR2TL;
CNSTI4 7
RETI4
ADDRGP4 $215
JUMPV
line 332
;332:		break;
LABELV $219
line 334
;333:	case Q_R:
;334:		return LS_A_R2L;
CNSTI4 8
RETI4
ADDRGP4 $215
JUMPV
line 335
;335:		break;
LABELV $220
line 337
;336:	case Q_TR:
;337:		return LS_A_TR2BL;
CNSTI4 9
RETI4
ADDRGP4 $215
JUMPV
line 338
;338:		break;
LABELV $221
line 340
;339:	case Q_T:
;340:		return LS_A_T2B;
CNSTI4 10
RETI4
ADDRGP4 $215
JUMPV
line 341
;341:		break;
LABELV $222
line 343
;342:	case Q_TL:
;343:		return LS_A_TL2BR;
CNSTI4 4
RETI4
ADDRGP4 $215
JUMPV
line 344
;344:		break;
LABELV $223
line 346
;345:	case Q_L:
;346:		return LS_A_L2R;
CNSTI4 5
RETI4
ADDRGP4 $215
JUMPV
line 347
;347:		break;
LABELV $224
line 349
;348:	case Q_BL:
;349:		return LS_A_BL2TR;
CNSTI4 6
RETI4
ADDRGP4 $215
JUMPV
line 350
;350:		break;
LABELV $216
line 352
;351:	}
;352:	return LS_NONE;
CNSTI4 0
RETI4
LABELV $215
endproc PM_AttackMoveForQuad 4 0
export PM_SaberAnimTransitionAnim
proc PM_SaberAnimTransitionAnim 28 0
line 356
;353:}
;354:
;355:int PM_SaberAnimTransitionAnim( int curmove, int newmove )
;356:{
line 358
;357:	//FIXME: take FP_SABERATTACK into account here somehow?
;358:	int retmove = newmove;
ADDRLP4 0
ADDRFP4 4
INDIRI4
ASGNI4
line 359
;359:	if ( curmove == LS_READY )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $227
line 360
;360:	{//just standing there
line 361
;361:		switch ( newmove )
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 4
LTI4 $228
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $228
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $232-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $232
address $231
address $231
address $231
address $231
address $231
address $231
address $231
code
line 362
;362:		{
LABELV $231
line 371
;363:		case LS_A_TL2BR:
;364:		case LS_A_L2R:
;365:		case LS_A_BL2TR:
;366:		case LS_A_BR2TL:
;367:		case LS_A_R2L:
;368:		case LS_A_TR2BL:
;369:		case LS_A_T2B:
;370:			//transition is the start
;371:			retmove = LS_S_TL2BR + (newmove-LS_A_TL2BR);
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 4
SUBI4
CNSTI4 18
ADDI4
ASGNI4
line 372
;372:			break;
line 374
;373:		}
;374:	}
ADDRGP4 $228
JUMPV
LABELV $227
line 376
;375:	else
;376:	{
line 377
;377:		switch ( newmove )
ADDRLP4 4
ADDRFP4 4
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 1
LTI4 $234
ADDRLP4 4
INDIRI4
CNSTI4 10
GTI4 $234
ADDRLP4 4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $279-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $279
address $236
address $234
address $234
address $242
address $242
address $242
address $242
address $242
address $242
address $242
code
line 378
;378:		{
LABELV $236
line 381
;379:		//transitioning to ready pose
;380:		case LS_READY:
;381:			switch ( curmove )
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 4
LTI4 $235
ADDRLP4 8
INDIRI4
CNSTI4 10
GTI4 $235
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $240-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $240
address $239
address $239
address $239
address $239
address $239
address $239
address $239
code
line 382
;382:			{
LABELV $239
line 392
;383:			//transitioning from an attack
;384:			case LS_A_TL2BR:
;385:			case LS_A_L2R:
;386:			case LS_A_BL2TR:
;387:			case LS_A_BR2TL:
;388:			case LS_A_R2L:
;389:			case LS_A_TR2BL:
;390:			case LS_A_T2B:
;391:				//transition is the return
;392:				retmove = LS_R_TL2BR + (newmove-LS_A_TL2BR);
ADDRLP4 0
ADDRFP4 4
INDIRI4
CNSTI4 4
SUBI4
CNSTI4 25
ADDI4
ASGNI4
line 393
;393:				break;
line 395
;394:			}
;395:			break;
ADDRGP4 $235
JUMPV
LABELV $242
line 415
;396:		//transitioning to an attack
;397:		case LS_A_TL2BR:
;398:		case LS_A_L2R:
;399:		case LS_A_BL2TR:
;400:		case LS_A_BR2TL:
;401:		case LS_A_R2L:
;402:		case LS_A_TR2BL:
;403:		case LS_A_T2B:
;404:			/*if ( newmove == curmove )
;405:			{//FIXME: need a spin or something or go to next level, but for now, just play the return
;406:				retmove = LS_R_TL2BR + (newmove-LS_A_TL2BR);
;407:			}
;408:			else */
;409:			//if ( saberMoveData[curmove].endQuad == saberMoveData[newmove].startQuad )
;410:			//{//new move starts from same quadrant
;411:			//	retmove = newmove;
;412:			//}
;413:			//else
;414:			//{
;415:				switch ( curmove )
ADDRLP4 12
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 4
LTI4 $235
ADDRLP4 12
INDIRI4
CNSTI4 31
GTI4 $274
ADDRLP4 12
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $275-16
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $275
address $251
address $248
address $254
address $257
address $245
address $260
address $263
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $235
address $266
address $266
address $266
address $266
address $266
address $266
address $266
code
LABELV $274
ADDRLP4 16
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 108
LTI4 $235
ADDRLP4 16
INDIRI4
CNSTI4 117
GTI4 $235
ADDRLP4 16
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $277-432
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $277
address $271
address $271
address $271
address $271
address $271
address $271
address $271
address $271
address $271
address $271
code
line 416
;416:				{
LABELV $245
line 419
;417:				//transitioning from an attack
;418:				case LS_A_R2L:
;419:					if (newmove == LS_A_L2R)			//Boot added these, to prevent same quad attacks to skip the transition
ADDRFP4 4
INDIRI4
CNSTI4 5
NEI4 $246
line 420
;420:					{
line 421
;421:						retmove = LS_T1_BL__L;	
ADDRLP4 0
CNSTI4 73
ASGNI4
line 422
;422:						break;
ADDRGP4 $235
JUMPV
LABELV $246
LABELV $248
line 425
;423:					}
;424:				case LS_A_L2R:
;425:					if (newmove == LS_A_R2L)
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $249
line 426
;426:					{
line 427
;427:						retmove = LS_T1_BL__R;
ADDRLP4 0
CNSTI4 69
ASGNI4
line 428
;428:						break;
ADDRGP4 $235
JUMPV
LABELV $249
LABELV $251
line 431
;429:					}
;430:				case LS_A_TL2BR:
;431:					if (newmove == LS_A_BR2TL)
ADDRFP4 4
INDIRI4
CNSTI4 7
NEI4 $252
line 432
;432:					{
line 433
;433:						retmove = LS_T1_TL_BR;
ADDRLP4 0
CNSTI4 56
ASGNI4
line 434
;434:						break;
ADDRGP4 $235
JUMPV
LABELV $252
LABELV $254
line 437
;435:					}
;436:				case LS_A_BL2TR:
;437:					if (newmove == LS_A_TR2BL)
ADDRFP4 4
INDIRI4
CNSTI4 9
NEI4 $255
line 438
;438:					{
line 439
;439:						retmove = LS_T1_BL_TR;
ADDRLP4 0
CNSTI4 70
ASGNI4
line 440
;440:						break;
ADDRGP4 $235
JUMPV
LABELV $255
LABELV $257
line 443
;441:					}
;442:				case LS_A_BR2TL:
;443:					if (newmove == LS_A_TL2BR)
ADDRFP4 4
INDIRI4
CNSTI4 4
NEI4 $258
line 444
;444:					{
line 445
;445:						retmove = LS_T1_BR_TL;
ADDRLP4 0
CNSTI4 35
ASGNI4
line 446
;446:						break;
ADDRGP4 $235
JUMPV
LABELV $258
LABELV $260
line 449
;447:					}
;448:				case LS_A_TR2BL:
;449:					if (newmove == LS_A_BL2TR)
ADDRFP4 4
INDIRI4
CNSTI4 6
NEI4 $261
line 450
;450:					{
line 451
;451:						retmove = LS_T1_TR_BL;
ADDRLP4 0
CNSTI4 49
ASGNI4
line 452
;452:						break;
ADDRGP4 $235
JUMPV
LABELV $261
LABELV $263
line 455
;453:					}
;454:				case LS_A_T2B:
;455:					retmove = transitionMove[saberMoveData[curmove].endQuad][saberMoveData[newmove].startQuad];
ADDRLP4 20
CNSTI4 40
ASGNI4
ADDRLP4 0
ADDRLP4 20
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 20
INDIRI4
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 saberMoveData+12
ADDP4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 transitionMove
ADDP4
ADDP4
INDIRI4
ASGNI4
line 456
;456:					break;
ADDRGP4 $235
JUMPV
LABELV $266
line 465
;457:				//transitioning from a return
;458:				case LS_R_L2R:
;459:				case LS_R_TL2BR:
;460:				case LS_R_BL2TR:
;461:				case LS_R_BR2TL:
;462:				case LS_R_TR2BL:
;463:				case LS_R_T2B:
;464:				case LS_R_R2L:
;465:					if (newmove == LS_A_R2L)
ADDRFP4 4
INDIRI4
CNSTI4 8
NEI4 $267
line 466
;466:					{
line 467
;467:						retmove = LS_T1_BL__R;
ADDRLP4 0
CNSTI4 69
ASGNI4
line 468
;468:						break;
ADDRGP4 $235
JUMPV
LABELV $267
line 470
;469:					}
;470:					else if (newmove == LS_A_BR2TL)
ADDRFP4 4
INDIRI4
CNSTI4 7
NEI4 $269
line 471
;471:					{
line 472
;472:						retmove = LS_T1_TL_BR;
ADDRLP4 0
CNSTI4 56
ASGNI4
line 473
;473:						break;
ADDRGP4 $235
JUMPV
LABELV $269
LABELV $271
line 508
;474:					}
;475:				//transitioning from a bounce
;476:				/*
;477:				case LS_BOUNCE_UL2LL:
;478:				case LS_BOUNCE_LL2UL:
;479:				case LS_BOUNCE_L2LL:
;480:				case LS_BOUNCE_L2UL:
;481:				case LS_BOUNCE_UR2LR:
;482:				case LS_BOUNCE_LR2UR:
;483:				case LS_BOUNCE_R2LR:
;484:				case LS_BOUNCE_R2UR:
;485:				case LS_BOUNCE_TOP:
;486:				case LS_OVER_UR2UL:
;487:				case LS_OVER_UL2UR:
;488:				case LS_BOUNCE_UR:
;489:				case LS_BOUNCE_UL:
;490:				case LS_BOUNCE_LR:
;491:				case LS_BOUNCE_LL:
;492:				*/
;493:				//transitioning from a parry/deflection
;494:				case LS_PARRY_UP:
;495:				case LS_REFLECT_UP:
;496:				case LS_PARRY_UR:
;497:					//Boot
;498:				/*case BOOT_LS_PARRY_DIAG_LEFT:
;499:				case BOOT_LS_PARRY_DIAG_RIGHT:*/
;500:					//
;501:				case LS_REFLECT_UR:
;502:				case LS_PARRY_UL:
;503:				case LS_REFLECT_UL:
;504:				case LS_PARRY_LR:
;505:				case LS_REFLECT_LR:
;506:				case LS_PARRY_LL:
;507:				case LS_REFLECT_LL:
;508:					retmove = transitionMove[saberMoveData[curmove].endQuad][saberMoveData[newmove].startQuad];
ADDRLP4 24
CNSTI4 40
ASGNI4
ADDRLP4 0
ADDRLP4 24
INDIRI4
ADDRFP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 24
INDIRI4
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 saberMoveData+12
ADDP4
INDIRI4
CNSTI4 5
LSHI4
ADDRGP4 transitionMove
ADDP4
ADDP4
INDIRI4
ASGNI4
line 509
;509:					break;
line 513
;510:				//NB: transitioning from transitions is fine
;511:				}
;512:			//}
;513:			break;
LABELV $234
LABELV $235
line 516
;514:		//transitioning to any other anim is not supported
;515:		}
;516:	}
LABELV $228
line 518
;517:
;518:	if ( retmove == LS_NONE )
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $281
line 519
;519:	{
line 520
;520:		return newmove;
ADDRFP4 4
INDIRI4
RETI4
ADDRGP4 $226
JUMPV
LABELV $281
line 523
;521:	}
;522:
;523:	return retmove;
ADDRLP4 0
INDIRI4
RETI4
LABELV $226
endproc PM_SaberAnimTransitionAnim 28 0
export PM_SaberMoveQuadrantForMovement
proc PM_SaberMoveQuadrantForMovement 0 0
line 528
;524:}
;525:
;526:
;527:int PM_SaberMoveQuadrantForMovement( usercmd_t *ucmd )
;528:{
line 529
;529:	if ( ucmd->rightmove > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $284
line 530
;530:	{//moving right
line 531
;531:		if ( ucmd->forwardmove > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $286
line 532
;532:		{//forward right = TL2BR slash
line 533
;533:			return Q_TL;
CNSTI4 4
RETI4
ADDRGP4 $283
JUMPV
LABELV $286
line 535
;534:		}
;535:		else if ( ucmd->forwardmove < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $288
line 536
;536:		{//backward right = BL2TR uppercut
line 537
;537:			return Q_BL;
CNSTI4 6
RETI4
ADDRGP4 $283
JUMPV
LABELV $288
line 540
;538:		}
;539:		else
;540:		{//just right is a left slice
line 541
;541:			return Q_L;
CNSTI4 5
RETI4
ADDRGP4 $283
JUMPV
LABELV $284
line 544
;542:		}
;543:	}
;544:	else if ( ucmd->rightmove < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 25
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $290
line 545
;545:	{//moving left
line 546
;546:		if ( ucmd->forwardmove > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $292
line 547
;547:		{//forward left = TR2BL slash
line 548
;548:			return Q_TR;
CNSTI4 2
RETI4
ADDRGP4 $283
JUMPV
LABELV $292
line 550
;549:		}
;550:		else if ( ucmd->forwardmove < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $294
line 551
;551:		{//backward left = BR2TL uppercut
line 552
;552:			return Q_BR;
CNSTI4 0
RETI4
ADDRGP4 $283
JUMPV
LABELV $294
line 555
;553:		}
;554:		else
;555:		{//just left is a right slice
line 556
;556:			return Q_R;
CNSTI4 1
RETI4
ADDRGP4 $283
JUMPV
LABELV $290
line 560
;557:		}
;558:	}
;559:	else
;560:	{//not moving left or right
line 561
;561:		if ( ucmd->forwardmove > 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $296
line 562
;562:		{//forward= T2B slash
line 563
;563:			return Q_T;
CNSTI4 3
RETI4
ADDRGP4 $283
JUMPV
LABELV $296
line 565
;564:		}
;565:		else if ( ucmd->forwardmove < 0 )
ADDRFP4 0
INDIRP4
CNSTI4 24
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $298
line 566
;566:		{//backward= T2B slash	//or B2T uppercut?
line 567
;567:			return Q_T;
CNSTI4 3
RETI4
ADDRGP4 $283
JUMPV
LABELV $298
line 570
;568:		}
;569:		else //if ( curmove == LS_READY )//???
;570:		{//Not moving at all
line 571
;571:			return Q_R;
CNSTI4 1
RETI4
LABELV $283
endproc PM_SaberMoveQuadrantForMovement 0 0
export PM_SaberInBounce
proc PM_SaberInBounce 8 0
line 579
;572:		}
;573:	}
;574:	//return Q_R;//????
;575:}
;576:
;577://===================================================================
;578:qboolean PM_SaberInBounce( int move )
;579:{
line 580
;580:	if ( move >= LS_B1_BR && move <= LS_B1_BL )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 74
LTI4 $301
ADDRLP4 0
INDIRI4
CNSTI4 80
GTI4 $301
line 581
;581:	{
line 582
;582:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $300
JUMPV
LABELV $301
line 584
;583:	}
;584:	if ( move >= LS_D1_BR && move <= LS_D1_BL )
ADDRLP4 4
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 81
LTI4 $303
ADDRLP4 4
INDIRI4
CNSTI4 87
GTI4 $303
line 585
;585:	{
line 586
;586:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $300
JUMPV
LABELV $303
line 588
;587:	}
;588:	return qfalse;
CNSTI4 0
RETI4
LABELV $300
endproc PM_SaberInBounce 8 0
export PM_SaberInTransition
proc PM_SaberInTransition 4 0
line 592
;589:}
;590:
;591:qboolean PM_SaberInTransition( int move )
;592:{
line 593
;593:	if ( move >= LS_T1_BR__R && move <= LS_T1_BL__L )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 32
LTI4 $306
ADDRLP4 0
INDIRI4
CNSTI4 73
GTI4 $306
line 594
;594:	{
line 595
;595:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $305
JUMPV
LABELV $306
line 597
;596:	}
;597:	return qfalse;
CNSTI4 0
RETI4
LABELV $305
endproc PM_SaberInTransition 4 0
export PM_SaberKataDone
proc PM_SaberKataDone 12 8
line 601
;598:}
;599:
;600:qboolean PM_SaberKataDone( void )
;601:{
line 602
;602:	if ( (pm->ps->fd.saberAnimLevel >= FORCE_LEVEL_3 && pm->ps->saberAttackChainCount > PM_irand_timesync( 0, 1 )) ||
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 0
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 3
LTI4 $312
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 4
ADDRGP4 PM_irand_timesync
CALLI4
ASGNI4
ADDRLP4 0
INDIRP4
CNSTI4 1296
ADDP4
INDIRI4
ADDRLP4 4
INDIRI4
GTI4 $311
LABELV $312
ADDRLP4 8
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 8
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 2
NEI4 $309
ADDRLP4 8
INDIRP4
CNSTI4 1296
ADDP4
INDIRI4
CNSTI4 3
LEI4 $309
LABELV $311
line 604
;603:		( pm->ps->fd.saberAnimLevel == FORCE_LEVEL_2 && pm->ps->saberAttackChainCount > 3) )//PM_irand_timesync( 2, 5 ) ) )	//Boot - how many chains you can do with yellow
;604:	{
line 605
;605:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $308
JUMPV
LABELV $309
line 607
;606:	}
;607:	return qfalse;
CNSTI4 0
RETI4
LABELV $308
endproc PM_SaberKataDone 12 8
export PM_SetAnimFrame
proc PM_SetAnimFrame 0 0
line 611
;608:}
;609:
;610:void PM_SetAnimFrame( playerState_t *gent, int frame, qboolean torso, qboolean legs )
;611:{
line 612
;612:	gent->saberLockFrame = frame;
ADDRFP4 0
INDIRP4
CNSTI4 532
ADDP4
ADDRFP4 4
INDIRI4
ASGNI4
line 613
;613:}
LABELV $313
endproc PM_SetAnimFrame 0 0
export PM_SaberLockBreak
proc PM_SaberLockBreak 88 16
line 616
;614:
;615:void PM_SaberLockBreak( playerState_t *genemy, qboolean victory )
;616:{
line 617
;617:	int	winAnim = BOTH_STAND1, loseAnim = BOTH_STAND1;
ADDRLP4 0
CNSTI4 550
ASGNI4
ADDRLP4 8
CNSTI4 550
ASGNI4
line 618
;618:	qboolean punishLoser = qfalse;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 620
;619:
;620:	switch ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) )
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 20
CNSTI4 538
ASGNI4
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
EQI4 $318
ADDRLP4 12
INDIRI4
CNSTI4 541
EQI4 $321
ADDRLP4 12
INDIRI4
ADDRLP4 20
INDIRI4
LTI4 $315
LABELV $330
ADDRLP4 12
INDIRI4
CNSTI4 548
EQI4 $324
ADDRLP4 12
INDIRI4
CNSTI4 549
EQI4 $327
ADDRGP4 $315
JUMPV
line 621
;621:	{
LABELV $318
line 623
;622:	case BOTH_BF2LOCK:
;623:		pm->ps->saberMove = LS_A_T2B;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 10
ASGNI4
line 624
;624:		winAnim = BOTH_A3_T__B_;
ADDRLP4 0
CNSTI4 280
ASGNI4
line 625
;625:		if ( !victory )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $319
line 626
;626:		{//no-one won
line 627
;627:			genemy->saberMove = LS_A_T2B;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 10
ASGNI4
line 628
;628:			loseAnim = winAnim;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 629
;629:		}
ADDRGP4 $316
JUMPV
LABELV $319
line 631
;630:		else
;631:		{
line 633
;632:			//loseAnim = BOTH_KNOCKDOWN4;
;633:			punishLoser = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 634
;634:		}
line 635
;635:		break;
ADDRGP4 $316
JUMPV
LABELV $321
line 637
;636:	case BOTH_BF1LOCK:
;637:		pm->ps->saberMove = LS_K1_T_;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 103
ASGNI4
line 638
;638:		winAnim = BOTH_K1_S1_T_;
ADDRLP4 0
CNSTI4 516
ASGNI4
line 639
;639:		if ( !victory )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $322
line 640
;640:		{//no-one won
line 641
;641:			genemy->saberMove = LS_K1_T_;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 103
ASGNI4
line 642
;642:			loseAnim = winAnim;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 643
;643:		}
ADDRGP4 $316
JUMPV
LABELV $322
line 645
;644:		else
;645:		{
line 647
;646:			//loseAnim = BOTH_BF1BREAK;
;647:			punishLoser = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 648
;648:		}
line 649
;649:		break;
ADDRGP4 $316
JUMPV
LABELV $324
line 651
;650:	case BOTH_CWCIRCLELOCK:
;651:		winAnim = BOTH_CWCIRCLEBREAK;
ADDRLP4 0
CNSTI4 546
ASGNI4
line 652
;652:		if ( !victory )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $325
line 653
;653:		{//no-one won
line 654
;654:			loseAnim = winAnim;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 655
;655:		}
ADDRGP4 $316
JUMPV
LABELV $325
line 657
;656:		else
;657:		{
line 658
;658:			genemy->saberMove = /*genemy->saberBounceMove =*/ LS_H1_BL;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 102
ASGNI4
line 659
;659:			genemy->saberBlocked = BLOCKED_PARRY_BROKEN;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 661
;660:			//loseAnim = BOTH_H1_S1_BR;
;661:			punishLoser = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 662
;662:		}
line 663
;663:		break;
ADDRGP4 $316
JUMPV
LABELV $327
line 665
;664:	case BOTH_CCWCIRCLELOCK:
;665:		winAnim = BOTH_CCWCIRCLEBREAK;
ADDRLP4 0
CNSTI4 547
ASGNI4
line 666
;666:		if ( !victory )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $328
line 667
;667:		{//no-one won
line 668
;668:			loseAnim = winAnim;
ADDRLP4 8
ADDRLP4 0
INDIRI4
ASGNI4
line 669
;669:		}
ADDRGP4 $316
JUMPV
LABELV $328
line 671
;670:		else
;671:		{
line 672
;672:			genemy->saberMove = /*genemy->saberBounceMove =*/ LS_H1_BR;
ADDRFP4 0
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 100
ASGNI4
line 673
;673:			genemy->saberBlocked = BLOCKED_PARRY_BROKEN;
ADDRFP4 0
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 1
ASGNI4
line 675
;674:			//loseAnim = BOTH_H1_S1_BL;
;675:			punishLoser = qtrue;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 676
;676:		}
line 677
;677:		break;
LABELV $315
LABELV $316
line 679
;678:	}
;679:	PM_SetAnim( SETANIM_BOTH, winAnim, SETANIM_FLAG_OVERRIDE|SETANIM_FLAG_HOLD, -1 );
ADDRLP4 28
CNSTI4 3
ASGNI4
ADDRLP4 28
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 28
INDIRI4
ARGI4
CNSTI4 -1
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 681
;680:
;681:	if (punishLoser)
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $331
line 682
;682:	{
line 685
;683:		vec3_t oppDir;
;684:
;685:		int strength = 8;
ADDRLP4 44
CNSTI4 8
ASGNI4
line 687
;686:
;687:		VectorSubtract(genemy->origin, pm->ps->origin, oppDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 20
ASGNI4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60
CNSTI4 24
ASGNI4
ADDRLP4 32+4
ADDRLP4 48
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 28
ASGNI4
ADDRLP4 32+8
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 688
;688:		VectorNormalize(oppDir);
ADDRLP4 32
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 690
;689:
;690:		genemy->forceHandExtend = HANDEXTEND_KNOCKDOWN;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 8
ASGNI4
line 691
;691:		genemy->forceHandExtendTime = pm->cmd.serverTime + 1100;
ADDRFP4 0
INDIRP4
CNSTI4 1240
ADDP4
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 1100
ADDI4
ASGNI4
line 692
;692:		genemy->forceDodgeAnim = 0; //this toggles between 1 and 0, when it's 1 we should play the get up anim
ADDRFP4 0
INDIRP4
CNSTI4 1248
ADDP4
CNSTI4 0
ASGNI4
line 694
;693:
;694:		genemy->otherKiller = pm->ps->clientNum;
ADDRFP4 0
INDIRP4
CNSTI4 748
ADDP4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ASGNI4
line 695
;695:		genemy->otherKillerTime = pm->cmd.serverTime + 5000;
ADDRFP4 0
INDIRP4
CNSTI4 752
ADDP4
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 5000
ADDI4
ASGNI4
line 696
;696:		genemy->otherKillerDebounceTime = pm->cmd.serverTime + 100;
ADDRFP4 0
INDIRP4
CNSTI4 756
ADDP4
ADDRGP4 pm
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
CNSTI4 100
ADDI4
ASGNI4
line 698
;697:
;698:		genemy->velocity[0] = oppDir[0]*(strength*40);
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 32
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 699
;699:		genemy->velocity[1] = oppDir[1]*(strength*40);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 32+4
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 700
;700:		genemy->velocity[2] = 100;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1120403456
ASGNF4
line 701
;701:	}
ADDRGP4 $332
JUMPV
LABELV $331
line 703
;702:	else
;703:	{
line 706
;704:		vec3_t oppDir;
;705:
;706:		int strength = 4;
ADDRLP4 44
CNSTI4 4
ASGNI4
line 708
;707:
;708:		VectorSubtract(genemy->origin, pm->ps->origin, oppDir);
ADDRLP4 48
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 20
ASGNI4
ADDRLP4 56
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 48
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
INDIRP4
ADDRLP4 52
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 60
CNSTI4 24
ASGNI4
ADDRLP4 32+4
ADDRLP4 48
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
ADDRLP4 56
INDIRP4
INDIRP4
ADDRLP4 60
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 64
CNSTI4 28
ASGNI4
ADDRLP4 32+8
ADDRFP4 0
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 64
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 709
;709:		VectorNormalize(oppDir);
ADDRLP4 32
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 710
;710:		genemy->velocity[0] = oppDir[0]*(strength*40);
ADDRFP4 0
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 32
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 711
;711:		genemy->velocity[1] = oppDir[1]*(strength*40);
ADDRFP4 0
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 32+4
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 712
;712:		genemy->velocity[2] = 150;
ADDRFP4 0
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1125515264
ASGNF4
line 714
;713:
;714:		VectorSubtract(pm->ps->origin, genemy->origin, oppDir);
ADDRLP4 68
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
CNSTI4 20
ASGNI4
ADDRLP4 76
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 32
ADDRLP4 68
INDIRP4
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
ADDRLP4 72
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 80
CNSTI4 24
ASGNI4
ADDRLP4 32+4
ADDRLP4 68
INDIRP4
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
ADDRLP4 76
INDIRP4
ADDRLP4 80
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 84
CNSTI4 28
ASGNI4
ADDRLP4 32+8
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
ADDRFP4 0
INDIRP4
ADDRLP4 84
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 715
;715:		VectorNormalize(oppDir);
ADDRLP4 32
ARGP4
ADDRGP4 VectorNormalize
CALLF4
pop
line 716
;716:		pm->ps->velocity[0] = oppDir[0]*(strength*40);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
ADDRLP4 32
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 717
;717:		pm->ps->velocity[1] = oppDir[1]*(strength*40);
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
ADDRLP4 32+4
INDIRF4
CNSTI4 40
ADDRLP4 44
INDIRI4
MULI4
CVIF4 4
MULF4
ASGNF4
line 718
;718:		pm->ps->velocity[2] = 150;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1125515264
ASGNF4
line 720
;719:
;720:		genemy->forceHandExtend = HANDEXTEND_WEAPONREADY;
ADDRFP4 0
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 6
ASGNI4
line 721
;721:	}
LABELV $332
line 723
;722:
;723:	pm->ps->weaponTime = 0;//pm->ps->torsoTimer;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 725
;724:	//The enemy unfortunately has no valid torso animation time at this point, so just use ours
;725:	genemy->weaponTime = 0;
ADDRFP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 727
;726:
;727:	pm->ps->saberLockTime = genemy->saberLockTime = 0;
ADDRLP4 32
CNSTI4 524
ASGNI4
ADDRLP4 36
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 32
INDIRI4
ADDP4
ADDRLP4 36
INDIRI4
ASGNI4
line 728
;728:	pm->ps->saberLockFrame = genemy->saberLockFrame = 0;
ADDRLP4 40
CNSTI4 532
ASGNI4
ADDRLP4 44
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 40
INDIRI4
ADDP4
ADDRLP4 44
INDIRI4
ASGNI4
line 729
;729:	pm->ps->saberLockEnemy = genemy->saberLockEnemy = 0;
ADDRLP4 48
CNSTI4 528
ASGNI4
ADDRLP4 52
CNSTI4 0
ASGNI4
ADDRFP4 0
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 48
INDIRI4
ADDP4
ADDRLP4 52
INDIRI4
ASGNI4
line 731
;730:
;731:	pm->ps->forceHandExtend = HANDEXTEND_WEAPONREADY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1236
ADDP4
CNSTI4 6
ASGNI4
line 733
;732:
;733:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 734
;734:	if ( !victory )
ADDRFP4 4
INDIRI4
CNSTI4 0
NEI4 $342
line 735
;735:	{//no-one won
line 736
;736:		BG_AddPredictableEventToPlayerstate(EV_JUMP, 0, genemy);
CNSTI4 14
ARGI4
CNSTI4 0
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 737
;737:	}
ADDRGP4 $343
JUMPV
LABELV $342
line 739
;738:	else
;739:	{
line 740
;740:		if ( Q_irand( 0, 1 ) )
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 56
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $344
line 741
;741:		{
line 742
;742:			BG_AddPredictableEventToPlayerstate(EV_JUMP, PM_irand_timesync( 0, 75 ), genemy);
CNSTI4 0
ARGI4
CNSTI4 75
ARGI4
ADDRLP4 60
ADDRGP4 PM_irand_timesync
CALLI4
ASGNI4
CNSTI4 14
ARGI4
ADDRLP4 60
INDIRI4
ARGI4
ADDRFP4 0
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 743
;743:		}
LABELV $344
line 744
;744:	}
LABELV $343
line 745
;745:}
LABELV $314
endproc PM_SaberLockBreak 88 16
export PM_SaberLocked
proc PM_SaberLocked 84 16
line 749
;746:
;747:extern qboolean ValidAnimFileIndex ( int index );
;748:void PM_SaberLocked( void )
;749:{
line 750
;750:	int	remaining = 0;
ADDRLP4 4
CNSTI4 0
ASGNI4
line 757
;751:	/*
;752:	if ( pm->ps->weaponTime )
;753:	{//can't attack yet
;754:		return;
;755:	}
;756:	*/
;757:	playerState_t *genemy = pm->bgClients[pm->ps->saberLockEnemy];
ADDRLP4 8
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 8
INDIRP4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 8
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRP4
ASGNP4
line 758
;758:	if ( !genemy )
ADDRLP4 0
INDIRP4
CVPU4 4
CNSTU4 0
NEU4 $347
line 759
;759:	{
line 760
;760:		return;
ADDRGP4 $346
JUMPV
LABELV $347
line 762
;761:	}
;762:	if ( ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF2LOCK ||
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 538
EQI4 $353
ADDRLP4 12
INDIRI4
CNSTI4 541
EQI4 $353
ADDRLP4 12
INDIRI4
CNSTI4 548
EQI4 $353
ADDRLP4 12
INDIRI4
CNSTI4 549
NEI4 $349
LABELV $353
ADDRLP4 16
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 538
EQI4 $356
ADDRLP4 16
INDIRI4
CNSTI4 541
EQI4 $356
ADDRLP4 16
INDIRI4
CNSTI4 548
EQI4 $356
ADDRLP4 16
INDIRI4
CNSTI4 549
NEI4 $349
LABELV $356
line 771
;763:			(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF1LOCK ||
;764:			(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CWCIRCLELOCK ||
;765:			(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CCWCIRCLELOCK )
;766:		&& ( (genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF2LOCK ||
;767:			(genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF1LOCK ||
;768:			(genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CWCIRCLELOCK ||
;769:			(genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CCWCIRCLELOCK )
;770:		)
;771:	{
line 772
;772:		float dist = 0;
ADDRLP4 20
CNSTF4 0
ASGNF4
line 774
;773:
;774:		pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 775
;775:		pm->ps->weaponTime = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 776
;776:		genemy->torsoTimer = 0;
ADDRLP4 0
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 777
;777:		genemy->weaponTime = 0;
ADDRLP4 0
INDIRP4
CNSTI4 44
ADDP4
CNSTI4 0
ASGNI4
line 779
;778:
;779:		dist = DistanceSquared(pm->ps->origin,genemy->origin);
ADDRLP4 24
CNSTI4 20
ASGNI4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 0
INDIRP4
ADDRLP4 24
INDIRI4
ADDP4
ARGP4
ADDRLP4 28
ADDRGP4 DistanceSquared
CALLF4
ASGNF4
ADDRLP4 20
ADDRLP4 28
INDIRF4
ASGNF4
line 780
;780:		if ( dist < 64 || dist > 6400 )//( dist < 128 || dist > 2304 )
ADDRLP4 32
ADDRLP4 20
INDIRF4
ASGNF4
ADDRLP4 32
INDIRF4
CNSTF4 1115684864
LTF4 $359
ADDRLP4 32
INDIRF4
CNSTF4 1170735104
LEF4 $357
LABELV $359
line 781
;781:		{//between 8 and 80 from each other//was 16 and 48
line 782
;782:			PM_SaberLockBreak( genemy, qfalse );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 PM_SaberLockBreak
CALLV
pop
line 783
;783:			return;
ADDRGP4 $346
JUMPV
LABELV $357
line 785
;784:		}
;785:		if ( (pm->cmd.buttons & BUTTON_ATTACK) || pm->ps->saberLockAdvance )
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
ADDRLP4 40
INDIRI4
NEI4 $362
ADDRLP4 36
INDIRP4
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $350
LABELV $362
line 786
;786:		{//holding attack
line 787
;787:			if (pm->ps->saberLockAdvance)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 540
ADDP4
INDIRI4
CNSTI4 0
EQI4 $346
line 788
;788:			{//tapping
line 792
;789:				animation_t *anim;
;790:				float		currentFrame;
;791:				int			curFrame;
;792:				int			strength = 1;
ADDRLP4 44
CNSTI4 1
ASGNI4
line 794
;793:
;794:				pm->ps->saberLockAdvance = qfalse;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 540
ADDP4
CNSTI4 0
ASGNI4
line 796
;795:
;796:				anim = &pm->animations[pm->ps->torsoAnim&~ANIM_TOGGLEBIT];
ADDRLP4 60
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
CNSTI4 28
ADDRLP4 60
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRLP4 60
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ADDP4
ASGNP4
line 798
;797:	
;798:				currentFrame = pm->ps->saberLockFrame;
ADDRLP4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CVIF4 4
ASGNF4
line 800
;799:
;800:				strength = pm->ps->fd.forcePowerLevel[FP_SABERATTACK]+1;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 992
ADDP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 802
;801:
;802:				if ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CCWCIRCLELOCK ||
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 549
EQI4 $367
ADDRLP4 64
INDIRI4
CNSTI4 538
NEI4 $365
LABELV $367
line 804
;803:					(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF2LOCK )
;804:				{
line 805
;805:					curFrame = floor( currentFrame )-strength;
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 floor
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 68
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
SUBF4
CVFI4 4
ASGNI4
line 807
;806:					//drop my frame one
;807:					if ( curFrame <= anim->firstFrame )
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRP4
INDIRI4
GTI4 $368
line 808
;808:					{//I won!  Break out
line 809
;809:						PM_SaberLockBreak( genemy, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 PM_SaberLockBreak
CALLV
pop
line 810
;810:						return;
ADDRGP4 $346
JUMPV
LABELV $368
line 813
;811:					}
;812:					else
;813:					{
line 814
;814:						PM_SetAnimFrame( pm->ps, curFrame, qtrue, qtrue );
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 72
CNSTI4 1
ASGNI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
ADDRGP4 PM_SetAnimFrame
CALLV
pop
line 815
;815:						remaining = curFrame-anim->firstFrame;
ADDRLP4 4
ADDRLP4 52
INDIRI4
ADDRLP4 48
INDIRP4
INDIRI4
SUBI4
ASGNI4
line 816
;816:					}
line 817
;817:				}
ADDRGP4 $366
JUMPV
LABELV $365
line 819
;818:				else
;819:				{
line 820
;820:					curFrame = ceil( currentFrame )+strength;
ADDRLP4 56
INDIRF4
ARGF4
ADDRLP4 68
ADDRGP4 ceil
CALLF4
ASGNF4
ADDRLP4 52
ADDRLP4 68
INDIRF4
ADDRLP4 44
INDIRI4
CVIF4 4
ADDF4
CVFI4 4
ASGNI4
line 822
;821:					//advance my frame one
;822:					if ( curFrame >= anim->firstFrame+anim->numFrames )
ADDRLP4 72
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 52
INDIRI4
ADDRLP4 72
INDIRP4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
LTI4 $370
line 823
;823:					{//I won!  Break out
line 824
;824:						PM_SaberLockBreak( genemy, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 1
ARGI4
ADDRGP4 PM_SaberLockBreak
CALLV
pop
line 825
;825:						return;
ADDRGP4 $346
JUMPV
LABELV $370
line 828
;826:					}
;827:					else
;828:					{
line 829
;829:						PM_SetAnimFrame( pm->ps, curFrame, qtrue, qtrue );
ADDRGP4 pm
INDIRP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRI4
ARGI4
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 PM_SetAnimFrame
CALLV
pop
line 830
;830:						remaining = anim->firstFrame+anim->numFrames-curFrame;
ADDRLP4 80
ADDRLP4 48
INDIRP4
ASGNP4
ADDRLP4 4
ADDRLP4 80
INDIRP4
INDIRI4
ADDRLP4 80
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ADDRLP4 52
INDIRI4
SUBI4
ASGNI4
line 831
;831:					}
line 832
;832:				}
LABELV $366
line 833
;833:				if ( !Q_irand( 0, 2 ) )
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 68
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 68
INDIRI4
CNSTI4 0
NEI4 $364
line 834
;834:				{
line 835
;835:					PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 836
;836:				}
line 837
;837:			}
line 839
;838:			else
;839:			{
line 840
;840:				return;
LABELV $364
line 842
;841:			}
;842:			if( 1/*ValidAnimFileIndex( genemy->client->clientInfo.animFileIndex )*/ )
line 843
;843:			{
line 845
;844:				animation_t *anim;
;845:				anim = &pm->animations[(genemy->torsoAnim&~ANIM_TOGGLEBIT)];
ADDRLP4 44
CNSTI4 28
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
MULI4
ADDRGP4 pm
INDIRP4
CNSTI4 224
ADDP4
INDIRP4
ADDP4
ASGNP4
line 847
;846:
;847:				if ( (genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CWCIRCLELOCK ||
ADDRLP4 48
ADDRLP4 0
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 548
EQI4 $378
ADDRLP4 48
INDIRI4
CNSTI4 541
NEI4 $376
LABELV $378
line 849
;848:					(genemy->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF1LOCK )
;849:				{
line 850
;850:					if ( !Q_irand( 0, 2 ) )
CNSTI4 0
ARGI4
CNSTI4 2
ARGI4
ADDRLP4 52
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
NEI4 $379
line 851
;851:					{
line 852
;852:						BG_AddPredictableEventToPlayerstate(EV_PAIN, floor((float)80/100*100.0f), genemy);
CNSTF4 1117782016
ARGF4
ADDRLP4 56
ADDRGP4 floor
CALLF4
ASGNF4
CNSTI4 77
ARGI4
ADDRLP4 56
INDIRF4
CVFI4 4
ARGI4
ADDRLP4 0
INDIRP4
ARGP4
ADDRGP4 BG_AddPredictableEventToPlayerstate
CALLV
pop
line 853
;853:					}
LABELV $379
line 854
;854:					PM_SetAnimFrame( genemy, anim->firstFrame+remaining, qtrue, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 44
INDIRP4
INDIRI4
ADDRLP4 4
INDIRI4
ADDI4
ARGI4
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 PM_SetAnimFrame
CALLV
pop
line 855
;855:				}
ADDRGP4 $350
JUMPV
LABELV $376
line 857
;856:				else
;857:				{
line 858
;858:					PM_SetAnimFrame( genemy, anim->firstFrame+anim->numFrames-remaining, qtrue, qtrue );
ADDRLP4 0
INDIRP4
ARGP4
ADDRLP4 52
ADDRLP4 44
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
INDIRI4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ADDI4
ADDRLP4 4
INDIRI4
SUBI4
ARGI4
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
ADDRGP4 PM_SetAnimFrame
CALLV
pop
line 859
;859:				}
line 860
;860:			}
line 861
;861:		}
line 862
;862:	}
ADDRGP4 $350
JUMPV
LABELV $349
line 864
;863:	else
;864:	{//something broke us out of it
line 865
;865:		PM_SaberLockBreak( genemy, qfalse );
ADDRLP4 0
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 PM_SaberLockBreak
CALLV
pop
line 866
;866:	}
LABELV $350
line 867
;867:}
LABELV $346
endproc PM_SaberLocked 84 16
export PM_SaberInBrokenParry
proc PM_SaberInBrokenParry 4 0
line 870
;868:
;869:qboolean PM_SaberInBrokenParry( int move )
;870:{
line 871
;871:	if ( move >= LS_H1_T_ && move <= LS_H1_BL )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 0
INDIRI4
CNSTI4 97
LTI4 $382
ADDRLP4 0
INDIRI4
CNSTI4 102
GTI4 $382
line 872
;872:	{
line 873
;873:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $381
JUMPV
LABELV $382
line 875
;874:	}
;875:	return qfalse;
CNSTI4 0
RETI4
LABELV $381
endproc PM_SaberInBrokenParry 4 0
export PM_BrokenParryForParry
proc PM_BrokenParryForParry 12 0
line 880
;876:}
;877:
;878:
;879:int PM_BrokenParryForParry( int move )
;880:{
line 883
;881:	//FIXME: need actual anims for this
;882:	//FIXME: need to know which side of the saber was hit!  For now, we presume the saber gets knocked away from the center
;883:	switch ( move )
ADDRLP4 0
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 4
CNSTI4 1
ASGNI4
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
EQI4 $392
ADDRLP4 0
INDIRI4
ADDRLP4 4
INDIRI4
LTI4 $385
LABELV $393
ADDRLP4 8
ADDRFP4 0
INDIRI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 108
LTI4 $385
ADDRLP4 8
INDIRI4
CNSTI4 112
GTI4 $385
ADDRLP4 8
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $394-432
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $394
address $387
address $388
address $389
address $390
address $391
code
line 884
;884:	{
LABELV $387
line 886
;885:	case LS_PARRY_UP:
;886:		return LS_H1_T_;
CNSTI4 97
RETI4
ADDRGP4 $384
JUMPV
line 887
;887:		break;
LABELV $388
line 889
;888:	case LS_PARRY_UR:
;889:		return LS_H1_TR;
CNSTI4 98
RETI4
ADDRGP4 $384
JUMPV
line 890
;890:		break;
LABELV $389
line 892
;891:	case LS_PARRY_UL:
;892:		return LS_H1_TL;
CNSTI4 99
RETI4
ADDRGP4 $384
JUMPV
line 893
;893:		break;
LABELV $390
line 903
;894:		//Boot
;895:	/*case BOOT_LS_PARRY_DIAG_LEFT:
;896:		return LS_H1_TL;
;897:		break;
;898:	case BOOT_LS_PARRY_DIAG_RIGHT:
;899:		return LS_H1_TR;
;900:		break;*/
;901:		//
;902:	case LS_PARRY_LR:
;903:		return LS_H1_BL;
CNSTI4 102
RETI4
ADDRGP4 $384
JUMPV
line 904
;904:		break;
LABELV $391
line 906
;905:	case LS_PARRY_LL:
;906:		return LS_H1_BR;
CNSTI4 100
RETI4
ADDRGP4 $384
JUMPV
line 907
;907:		break;
LABELV $392
line 909
;908:	case LS_READY:
;909:		return LS_H1_B_;//???
CNSTI4 101
RETI4
ADDRGP4 $384
JUMPV
line 910
;910:		break;
LABELV $385
line 912
;911:	}
;912:	return LS_NONE;
CNSTI4 0
RETI4
LABELV $384
endproc PM_BrokenParryForParry 12 0
lit
align 4
LABELV $397
byte 4 3245342720
byte 4 3245342720
byte 4 3238002688
align 4
LABELV $398
byte 4 1097859072
byte 4 1097859072
byte 4 1090519040
export PM_CanBackstab
code
proc PM_CanBackstab 1152 28
line 918
;913:}
;914:
;915:#define BACK_STAB_DISTANCE 128//64
;916:
;917:qboolean PM_CanBackstab(void)
;918:{
line 922
;919:	trace_t tr;
;920:	vec3_t flatAng;
;921:	vec3_t fwd, back;
;922:	vec3_t trmins = {-15, -15, -8};
ADDRLP4 1116
ADDRGP4 $397
INDIRB
ASGNB 12
line 923
;923:	vec3_t trmaxs = {15, 15, 8};
ADDRLP4 1128
ADDRGP4 $398
INDIRB
ASGNB 12
line 925
;924:
;925:	VectorCopy(pm->ps->viewangles, flatAng);
ADDRLP4 1104
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 926
;926:	flatAng[PITCH] = 0;
ADDRLP4 1104
CNSTF4 0
ASGNF4
line 928
;927:
;928:	AngleVectors(flatAng, fwd, 0, 0);
ADDRLP4 1104
ARGP4
ADDRLP4 1080
ARGP4
ADDRLP4 1140
CNSTP4 0
ASGNP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRLP4 1140
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 930
;929:
;930:	back[0] = pm->ps->origin[0] - fwd[0]*BACK_STAB_DISTANCE;
ADDRLP4 1092
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1124073472
ADDRLP4 1080
INDIRF4
MULF4
SUBF4
ASGNF4
line 931
;931:	back[1] = pm->ps->origin[1] - fwd[1]*BACK_STAB_DISTANCE;
ADDRLP4 1092+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1124073472
ADDRLP4 1080+4
INDIRF4
MULF4
SUBF4
ASGNF4
line 932
;932:	back[2] = pm->ps->origin[2] - fwd[2]*BACK_STAB_DISTANCE;
ADDRLP4 1092+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1124073472
ADDRLP4 1080+8
INDIRF4
MULF4
SUBF4
ASGNF4
line 934
;933:
;934:	pm->trace(&tr, pm->ps->origin, trmins, trmaxs, back, pm->ps->clientNum, MASK_PLAYERSOLID);
ADDRLP4 0
ARGP4
ADDRLP4 1144
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 1148
ADDRLP4 1144
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 1148
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 1116
ARGP4
ADDRLP4 1128
ARGP4
ADDRLP4 1092
ARGP4
ADDRLP4 1148
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRLP4 1144
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLV
pop
line 936
;935:
;936:	if (tr.fraction != 1.0 && tr.entityNum >= 0 && tr.entityNum < MAX_CLIENTS)
ADDRLP4 0+8
INDIRF4
CNSTF4 1065353216
EQF4 $403
ADDRLP4 0+52
INDIRI4
CNSTI4 0
LTI4 $403
ADDRLP4 0+52
INDIRI4
CNSTI4 32
GEI4 $403
line 937
;937:	{ //We don't have real entity access here so we can't do an indepth check. But if it's a client and it's behind us, I guess that's reason enough to stab backward
line 938
;938:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $396
JUMPV
LABELV $403
line 941
;939:	}
;940:
;941:	return qfalse;
CNSTI4 0
RETI4
LABELV $396
endproc PM_CanBackstab 1152 28
export PM_SaberFlipOverAttackMove
proc PM_SaberFlipOverAttackMove 56 16
line 945
;942:}
;943:
;944:saberMoveName_t PM_SaberFlipOverAttackMove(trace_t *tr)
;945:{
line 948
;946:	//FIXME: check above for room enough to jump!
;947:	vec3_t fwdAngles, jumpFwd;
;948:	float zDiff = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 951
;949:	playerState_t *psData;
;950:
;951:	VectorCopy( pm->ps->viewangles, fwdAngles );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 952
;952:	fwdAngles[PITCH] = fwdAngles[ROLL] = 0;
ADDRLP4 32
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 32
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 32
INDIRF4
ASGNF4
line 953
;953:	AngleVectors( fwdAngles, jumpFwd, NULL, NULL );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 36
CNSTP4 0
ASGNP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRLP4 36
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 954
;954:	VectorScale( jumpFwd, /*100*/50, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1112014848
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1112014848
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1112014848
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 955
;955:	pm->ps->velocity[2] = 400;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1137180672
ASGNF4
line 957
;956:
;957:	psData = pm->bgClients[tr->entityNum];
ADDRLP4 28
ADDRFP4 0
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 pm
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRP4
ASGNP4
line 959
;958:
;959:	pm->ps->velocity[2] *= 1;//(pm->gent->enemy->maxs[2]-pm->gent->enemy->mins[2])/64.0f;
ADDRLP4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 40
INDIRP4
CNSTF4 1065353216
ADDRLP4 40
INDIRP4
INDIRF4
MULF4
ASGNF4
line 962
;960:
;961:	//go higher for enemies higher than you, lower for those lower than you
;962:	if (psData)
ADDRLP4 28
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $412
line 963
;963:	{
line 964
;964:		zDiff = psData->origin[2] - pm->ps->origin[2];
ADDRLP4 44
CNSTI4 28
ASGNI4
ADDRLP4 24
ADDRLP4 28
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
ADDRGP4 pm
INDIRP4
INDIRP4
ADDRLP4 44
INDIRI4
ADDP4
INDIRF4
SUBF4
ASGNF4
line 965
;965:	}
ADDRGP4 $413
JUMPV
LABELV $412
line 967
;966:	else
;967:	{
line 968
;968:		zDiff = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 969
;969:	}
LABELV $413
line 970
;970:	pm->ps->velocity[2] += (zDiff)*1.5f;
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
ASGNP4
ADDRLP4 44
INDIRP4
ADDRLP4 44
INDIRP4
INDIRF4
CNSTF4 1069547520
ADDRLP4 24
INDIRF4
MULF4
ADDF4
ASGNF4
line 973
;971:
;972:	//clamp to decent-looking values
;973:	if ( zDiff <= 0 && pm->ps->velocity[2] < 200 )
ADDRLP4 24
INDIRF4
CNSTF4 0
GTF4 $414
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1128792064
GEF4 $414
line 974
;974:	{//if we're on same level, don't let me jump so low, I clip into the ground
line 975
;975:		pm->ps->velocity[2] = 200;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1128792064
ASGNF4
line 976
;976:	}
ADDRGP4 $415
JUMPV
LABELV $414
line 977
;977:	else if ( pm->ps->velocity[2] < 100 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1120403456
GEF4 $416
line 978
;978:	{
line 979
;979:		pm->ps->velocity[2] = 100;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1120403456
ASGNF4
line 980
;980:	}
ADDRGP4 $417
JUMPV
LABELV $416
line 981
;981:	else if ( pm->ps->velocity[2] > 400 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
INDIRF4
CNSTF4 1137180672
LEF4 $418
line 982
;982:	{
line 983
;983:		pm->ps->velocity[2] = 400;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1137180672
ASGNF4
line 984
;984:	}
LABELV $418
LABELV $417
LABELV $415
line 986
;985:
;986:	pm->ps->fd.forceJumpZStart = pm->ps->origin[2];//so we don't take damage if we land at same height
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 48
INDIRP4
CNSTI4 1080
ADDP4
ADDRLP4 48
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 988
;987:
;988:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 989
;989:	pm->ps->fd.forceJumpSound = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 1
ASGNI4
line 990
;990:	pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 30
ADDP4
CNSTI1 0
ASGNI1
line 992
;991:
;992:	if ( Q_irand( 0, 1 ) )
CNSTI4 0
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 52
ADDRGP4 Q_irand
CALLI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 0
EQI4 $420
line 993
;993:	{
line 994
;994:		return LS_A_FLIP_STAB;
CNSTI4 16
RETI4
ADDRGP4 $408
JUMPV
LABELV $420
line 997
;995:	}
;996:	else
;997:	{
line 998
;998:		return LS_A_FLIP_SLASH;
CNSTI4 17
RETI4
LABELV $408
endproc PM_SaberFlipOverAttackMove 56 16
lit
align 4
LABELV $423
byte 4 3245342720
byte 4 3245342720
byte 4 3238002688
align 4
LABELV $424
byte 4 1097859072
byte 4 1097859072
byte 4 1090519040
export PM_SomeoneInFront
code
proc PM_SomeoneInFront 80 28
line 1005
;999:	}
;1000:}
;1001:
;1002:#define FLIPHACK_DISTANCE 200
;1003:
;1004:qboolean PM_SomeoneInFront(trace_t *tr)
;1005:{ //Also a very simplified version of the sp counterpart
line 1008
;1006:	vec3_t flatAng;
;1007:	vec3_t fwd, back;
;1008:	vec3_t trmins = {-15, -15, -8};
ADDRLP4 36
ADDRGP4 $423
INDIRB
ASGNB 12
line 1009
;1009:	vec3_t trmaxs = {15, 15, 8};
ADDRLP4 48
ADDRGP4 $424
INDIRB
ASGNB 12
line 1011
;1010:
;1011:	VectorCopy(pm->ps->viewangles, flatAng);
ADDRLP4 24
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 1012
;1012:	flatAng[PITCH] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
line 1014
;1013:
;1014:	AngleVectors(flatAng, fwd, 0, 0);
ADDRLP4 24
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 60
CNSTP4 0
ASGNP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRLP4 60
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1016
;1015:
;1016:	back[0] = pm->ps->origin[0] + fwd[0]*FLIPHACK_DISTANCE;
ADDRLP4 12
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
CNSTF4 1128792064
ADDRLP4 0
INDIRF4
MULF4
ADDF4
ASGNF4
line 1017
;1017:	back[1] = pm->ps->origin[1] + fwd[1]*FLIPHACK_DISTANCE;
ADDRLP4 12+4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
CNSTF4 1128792064
ADDRLP4 0+4
INDIRF4
MULF4
ADDF4
ASGNF4
line 1018
;1018:	back[2] = pm->ps->origin[2] + fwd[2]*FLIPHACK_DISTANCE;
ADDRLP4 12+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
CNSTF4 1128792064
ADDRLP4 0+8
INDIRF4
MULF4
ADDF4
ASGNF4
line 1020
;1019:
;1020:	pm->trace(tr, pm->ps->origin, trmins, trmaxs, back, pm->ps->clientNum, MASK_PLAYERSOLID);
ADDRFP4 0
INDIRP4
ARGP4
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 68
ADDRLP4 64
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 36
ARGP4
ADDRLP4 48
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 68
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
CNSTI4 273
ARGI4
ADDRLP4 64
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLV
pop
line 1022
;1021:
;1022:	if (tr->fraction != 1.0 && tr->entityNum >= 0 && tr->entityNum < MAX_CLIENTS)
ADDRLP4 72
ADDRFP4 0
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 8
ADDP4
INDIRF4
CNSTF4 1065353216
EQF4 $429
ADDRLP4 76
ADDRLP4 72
INDIRP4
CNSTI4 52
ADDP4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 0
LTI4 $429
ADDRLP4 76
INDIRI4
CNSTI4 32
GEI4 $429
line 1023
;1023:	{
line 1024
;1024:		return qtrue;
CNSTI4 1
RETI4
ADDRGP4 $422
JUMPV
LABELV $429
line 1027
;1025:	}
;1026:
;1027:	return qfalse;
CNSTI4 0
RETI4
LABELV $422
endproc PM_SomeoneInFront 80 28
export PM_SaberLungeAttackMove
proc PM_SaberLungeAttackMove 32 16
line 1031
;1028:}
;1029:
;1030:saberMoveName_t PM_SaberLungeAttackMove( void )
;1031:{
line 1034
;1032:	vec3_t fwdAngles, jumpFwd;
;1033:
;1034:	VectorCopy( pm->ps->viewangles, fwdAngles );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 1035
;1035:	fwdAngles[PITCH] = fwdAngles[ROLL] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1037
;1036:	//do the lunge
;1037:	AngleVectors( fwdAngles, jumpFwd, NULL, NULL );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1038
;1038:	VectorScale( jumpFwd, 150, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1125515264
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1125515264
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1125515264
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 1040
;1039:	//pm->ps->velocity[2] = 50;
;1040:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1042
;1041:
;1042:	return LS_A_LUNGE;
CNSTI4 14
RETI4
LABELV $431
endproc PM_SaberLungeAttackMove 32 16
export PM_SaberJumpAttackMove
proc PM_SaberJumpAttackMove 36 16
line 1046
;1043:}
;1044:
;1045:saberMoveName_t PM_SaberJumpAttackMove( void )
;1046:{
line 1049
;1047:	vec3_t fwdAngles, jumpFwd;
;1048:
;1049:	VectorCopy( pm->ps->viewangles, fwdAngles );
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 156
ADDP4
INDIRB
ASGNB 12
line 1050
;1050:	fwdAngles[PITCH] = fwdAngles[ROLL] = 0;
ADDRLP4 24
CNSTF4 0
ASGNF4
ADDRLP4 0+8
ADDRLP4 24
INDIRF4
ASGNF4
ADDRLP4 0
ADDRLP4 24
INDIRF4
ASGNF4
line 1051
;1051:	AngleVectors( fwdAngles, jumpFwd, NULL, NULL );
ADDRLP4 0
ARGP4
ADDRLP4 12
ARGP4
ADDRLP4 28
CNSTP4 0
ASGNP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRLP4 28
INDIRP4
ARGP4
ADDRGP4 AngleVectors
CALLV
pop
line 1052
;1052:	VectorScale( jumpFwd, /*200*/300, pm->ps->velocity );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 32
ADDP4
CNSTF4 1133903872
ADDRLP4 12
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 36
ADDP4
CNSTF4 1133903872
ADDRLP4 12+4
INDIRF4
MULF4
ASGNF4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1133903872
ADDRLP4 12+8
INDIRF4
MULF4
ASGNF4
line 1053
;1053:	pm->ps->velocity[2] = 280;//180;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 40
ADDP4
CNSTF4 1133248512
ASGNF4
line 1054
;1054:	pm->ps->fd.forceJumpZStart = pm->ps->origin[2];//so we don't take damage if we land at same height
ADDRLP4 32
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
CNSTI4 1080
ADDP4
ADDRLP4 32
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ASGNF4
line 1056
;1055:
;1056:	PM_AddEvent( EV_JUMP );
CNSTI4 14
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1057
;1057:	pm->ps->fd.forceJumpSound = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1088
ADDP4
CNSTI4 1
ASGNI4
line 1058
;1058:	pm->cmd.upmove = 0;
ADDRGP4 pm
INDIRP4
CNSTI4 30
ADDP4
CNSTI1 0
ASGNI1
line 1060
;1059:
;1060:	return LS_A_JUMP_T__B_;
CNSTI4 15
RETI4
LABELV $435
endproc PM_SaberJumpAttackMove 36 16
export PM_GroundDistance
proc PM_GroundDistance 1108 28
line 1064
;1061:}
;1062:
;1063:float PM_GroundDistance(void)
;1064:{
line 1068
;1065:	trace_t tr;
;1066:	vec3_t down;
;1067:
;1068:	VectorCopy(pm->ps->origin, down);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRB
ASGNB 12
line 1070
;1069:
;1070:	down[2] -= 4096;
ADDRLP4 0+8
ADDRLP4 0+8
INDIRF4
CNSTF4 1166016512
SUBF4
ASGNF4
line 1072
;1071:
;1072:	pm->trace(&tr, pm->ps->origin, pm->mins, pm->maxs, down, pm->ps->clientNum, MASK_SOLID);
ADDRLP4 12
ARGP4
ADDRLP4 1092
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 1096
ADDRLP4 1092
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 1096
INDIRP4
CNSTI4 20
ADDP4
ARGP4
ADDRLP4 1092
INDIRP4
CNSTI4 188
ADDP4
ARGP4
ADDRLP4 1092
INDIRP4
CNSTI4 200
ADDP4
ARGP4
ADDRLP4 0
ARGP4
ADDRLP4 1096
INDIRP4
CNSTI4 144
ADDP4
INDIRI4
ARGI4
CNSTI4 1
ARGI4
ADDRLP4 1092
INDIRP4
CNSTI4 240
ADDP4
INDIRP4
CALLV
pop
line 1074
;1073:
;1074:	VectorSubtract(pm->ps->origin, tr.endpos, down);
ADDRLP4 1100
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 0
ADDRLP4 1100
INDIRP4
INDIRP4
CNSTI4 20
ADDP4
INDIRF4
ADDRLP4 12+12
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+4
ADDRLP4 1100
INDIRP4
INDIRP4
CNSTI4 24
ADDP4
INDIRF4
ADDRLP4 12+12+4
INDIRF4
SUBF4
ASGNF4
ADDRLP4 0+8
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 28
ADDP4
INDIRF4
ADDRLP4 12+12+8
INDIRF4
SUBF4
ASGNF4
line 1076
;1075:
;1076:	return VectorLength(down);
ADDRLP4 0
ARGP4
ADDRLP4 1104
ADDRGP4 VectorLength
CALLF4
ASGNF4
ADDRLP4 1104
INDIRF4
RETF4
LABELV $439
endproc PM_GroundDistance 1108 28
export PM_SaberAttackForMovement
proc PM_SaberAttackForMovement 12 8
line 1080
;1077:}
;1078:
;1079:saberMoveName_t PM_SaberAttackForMovement(saberMoveName_t curmove)
;1080:{
line 1081
;1081:	saberMoveName_t newmove = -1;
ADDRLP4 0
CNSTI4 -1
ASGNI4
line 1083
;1082:
;1083:	if ( pm->cmd.rightmove > 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 29
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $449
line 1084
;1084:	{//moving right
line 1085
;1085:		if ( pm->cmd.forwardmove > 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $451
line 1086
;1086:		{//forward right = TL2BR slash
line 1087
;1087:			newmove = LS_A_TL2BR;
ADDRLP4 0
CNSTI4 4
ASGNI4
line 1088
;1088:		}
ADDRGP4 $450
JUMPV
LABELV $451
line 1089
;1089:		else if ( pm->cmd.forwardmove < 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $453
line 1090
;1090:		{//backward right = BL2TR uppercut
line 1091
;1091:			newmove = LS_A_BL2TR;
ADDRLP4 0
CNSTI4 6
ASGNI4
line 1092
;1092:		}
ADDRGP4 $450
JUMPV
LABELV $453
line 1094
;1093:		else
;1094:		{//just right is a left slice
line 1095
;1095:			newmove = LS_A_L2R;
ADDRLP4 0
CNSTI4 5
ASGNI4
line 1096
;1096:		}
line 1097
;1097:	}
ADDRGP4 $450
JUMPV
LABELV $449
line 1098
;1098:	else if ( pm->cmd.rightmove < 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 29
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $455
line 1099
;1099:	{//moving left
line 1100
;1100:		if ( pm->cmd.forwardmove > 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $457
line 1101
;1101:		{//forward left = TR2BL slash
line 1102
;1102:			newmove = LS_A_TR2BL;
ADDRLP4 0
CNSTI4 9
ASGNI4
line 1103
;1103:		}
ADDRGP4 $456
JUMPV
LABELV $457
line 1104
;1104:		else if ( pm->cmd.forwardmove < 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $459
line 1105
;1105:		{//backward left = BR2TL uppercut
line 1106
;1106:			newmove = LS_A_BR2TL;
ADDRLP4 0
CNSTI4 7
ASGNI4
line 1107
;1107:		}
ADDRGP4 $456
JUMPV
LABELV $459
line 1109
;1108:		else
;1109:		{//just left is a right slice
line 1110
;1110:			newmove = LS_A_R2L;
ADDRLP4 0
CNSTI4 8
ASGNI4
line 1111
;1111:		}
line 1112
;1112:	}
ADDRGP4 $456
JUMPV
LABELV $455
line 1114
;1113:	else
;1114:	{//not moving left or right
line 1115
;1115:		if ( pm->cmd.forwardmove > 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
LEI4 $461
line 1116
;1116:		{//forward= T2B slash												//Boot comment - disable yellow jump attack and blue lunge (though irrelevant)
line 1138
;1117:			//if (pm->ps->fd.saberAnimLevel == FORCE_LEVEL_2 &&
;1118:			//	/*pm->ps->groundEntityNum != ENTITYNUM_NONE &&*/
;1119:			//	pm->ps->velocity[2] > 100 &&
;1120:			//	PM_GroundDistance() < 32 &&
;1121:			//	!BG_InSpecialJump(pm->ps->legsAnim))
;1122:			//{ //FLIP AND DOWNWARD ATTACK
;1123:			//	trace_t tr;
;1124:
;1125:			//	if (PM_SomeoneInFront(&tr))
;1126:			//	{
;1127:			//		newmove = PM_SaberFlipOverAttackMove(&tr);
;1128:			//	}
;1129:			//}
;1130:			//else if (pm->ps->fd.saberAnimLevel == FORCE_LEVEL_1 &&
;1131:			//	(pm->ps->pm_flags & PMF_DUCKED) &&
;1132:			//	pm->ps->weaponTime <= 0)
;1133:			//{ //LUNGE (weak)
;1134:			//	newmove = PM_SaberLungeAttackMove();
;1135:			//}
;1136:			//else
;1137:			//{
;1138:				newmove = LS_A_T2B;
ADDRLP4 0
CNSTI4 10
ASGNI4
line 1140
;1139:			//}
;1140:		}
ADDRGP4 $462
JUMPV
LABELV $461
line 1141
;1141:		else if ( pm->cmd.forwardmove < 0 )
ADDRGP4 pm
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
CNSTI4 0
GEI4 $463
line 1142
;1142:		{//backward= T2B slash//B2T uppercut?
line 1163
;1143:			//if (PM_CanBackstab())											//Boot comment - disable bs and dbs
;1144:			//{ //BACKSTAB (attack varies by level)
;1145:			//	if (pm->ps->fd.saberAnimLevel >= FORCE_LEVEL_2)
;1146:			//	{//medium and higher attacks
;1147:			//		if ( (pm->ps->pm_flags&PMF_DUCKED) || pm->cmd.upmove < 0 )
;1148:			//		{
;1149:			//			newmove = LS_A_BACK_CR;
;1150:			//		}
;1151:			//		else
;1152:			//		{
;1153:			//			newmove = LS_A_BACK;
;1154:			//		}
;1155:			//	}
;1156:			//	else
;1157:			//	{ //weak attack
;1158:			//		newmove = LS_A_BACKSTAB;
;1159:			//	}
;1160:			//}
;1161:			//else
;1162:			//{
;1163:				newmove = LS_A_T2B;
ADDRLP4 0
CNSTI4 10
ASGNI4
line 1165
;1164:			//}
;1165:		}
ADDRGP4 $464
JUMPV
LABELV $463
line 1166
;1166:		else if ( PM_SaberInBounce( curmove ) )
ADDRFP4 0
INDIRI4
ARGI4
ADDRLP4 4
ADDRGP4 PM_SaberInBounce
CALLI4
ASGNI4
ADDRLP4 4
INDIRI4
CNSTI4 0
EQI4 $465
line 1167
;1167:		{//bounces should go to their default attack if you don't specify a direction but are attacking
line 1168
;1168:			if ( PM_SaberKataDone() )
ADDRLP4 8
ADDRGP4 PM_SaberKataDone
CALLI4
ASGNI4
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $467
line 1169
;1169:			{
line 1170
;1170:				newmove = saberMoveData[curmove].chain_idle;
ADDRLP4 0
CNSTI4 40
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 saberMoveData+28
ADDP4
INDIRI4
ASGNI4
line 1171
;1171:			}
ADDRGP4 $466
JUMPV
LABELV $467
line 1173
;1172:			else
;1173:			{
line 1174
;1174:				newmove = saberMoveData[curmove].chain_attack;
ADDRLP4 0
CNSTI4 40
ADDRFP4 0
INDIRI4
MULI4
ADDRGP4 saberMoveData+32
ADDP4
INDIRI4
ASGNI4
line 1175
;1175:			}
line 1176
;1176:		}
ADDRGP4 $466
JUMPV
LABELV $465
line 1177
;1177:		else if ( curmove == LS_READY )
ADDRFP4 0
INDIRI4
CNSTI4 1
NEI4 $471
line 1178
;1178:		{//Not moving at all, shouldn't have gotten here...?
line 1184
;1179:			//for now, just pick a random attack
;1180:			//newmove = Q_irand( LS_A_TL2BR, LS_A_T2B );
;1181:			//rww - If we don't seed with a "common" value, the client and server will get mismatched
;1182:			//prediction values. Under laggy conditions this will cause the appearance of rapid swing
;1183:			//sequence changes.
;1184:			newmove = PM_irand_timesync(LS_A_TL2BR, LS_A_T2B);
CNSTI4 4
ARGI4
CNSTI4 10
ARGI4
ADDRLP4 8
ADDRGP4 PM_irand_timesync
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 8
INDIRI4
ASGNI4
line 1185
;1185:		}
LABELV $471
LABELV $466
LABELV $464
LABELV $462
line 1186
;1186:	}
LABELV $456
LABELV $450
line 1188
;1187:
;1188:	return newmove;
ADDRLP4 0
INDIRI4
RETI4
LABELV $448
endproc PM_SaberAttackForMovement 12 8
export PM_WeaponLightsaber
proc PM_WeaponLightsaber 104 16
line 1201
;1189:}
;1190:/*
;1191:=================
;1192:PM_WeaponLightsaber
;1193:
;1194:Consults a chart to choose what to do with the lightsaber.
;1195:While this is a little different than the Quake 3 code, there is no clean way of using the Q3 code for this kind of thing.
;1196:=================
;1197:*/
;1198:// Ultimate goal is to set the sabermove to the proper next location
;1199:// Note that if the resultant animation is NONE, then the animation is essentially "idle", and is set in WP_TorsoAnim
;1200:void PM_WeaponLightsaber(void)
;1201:{
line 1203
;1202:	int			addTime,amount;
;1203:	qboolean	delayed_fire = qfalse;
ADDRLP4 20
CNSTI4 0
ASGNI4
line 1204
;1204:	int			anim=-1, curmove, newmove=LS_NONE;
ADDRLP4 16
CNSTI4 -1
ASGNI4
ADDRLP4 8
CNSTI4 0
ASGNI4
line 1206
;1205:
;1206:	qboolean saberInAir = qtrue;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 1207
;1207:	qboolean checkOnlyWeap = qfalse;
ADDRLP4 12
CNSTI4 0
ASGNI4
line 1209
;1208:
;1209: 	if ( pm->ps->saberLockTime > pm->cmd.serverTime )
ADDRLP4 32
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 32
INDIRP4
INDIRP4
CNSTI4 524
ADDP4
INDIRI4
ADDRLP4 32
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
LEI4 $474
line 1210
;1210:	{
line 1211
;1211:		pm->ps->saberMove = LS_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
CNSTI4 0
ASGNI4
line 1212
;1212:		PM_SaberLocked();
ADDRGP4 PM_SaberLocked
CALLV
pop
line 1213
;1213:		return;
ADDRGP4 $473
JUMPV
LABELV $474
line 1216
;1214:	}
;1215:	else
;1216:	{
line 1217
;1217:		if ( ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF2LOCK ||
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 40
ADDRLP4 36
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 538
EQI4 $481
ADDRLP4 40
INDIRI4
CNSTI4 541
EQI4 $481
ADDRLP4 40
INDIRI4
CNSTI4 548
EQI4 $481
ADDRLP4 40
INDIRI4
CNSTI4 549
EQI4 $481
ADDRLP4 36
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $476
LABELV $481
line 1223
;1218:				(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF1LOCK ||
;1219:				(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CWCIRCLELOCK ||
;1220:				(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CCWCIRCLELOCK ||
;1221:				pm->ps->saberLockFrame )
;1222:			)
;1223:		{
line 1224
;1224:			if (pm->ps->saberLockEnemy < ENTITYNUM_NONE &&
ADDRLP4 44
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 1023
GEI4 $482
ADDRLP4 44
INDIRI4
CNSTI4 0
LTI4 $482
line 1226
;1225:				pm->ps->saberLockEnemy >= 0)
;1226:			{
line 1229
;1227:				playerState_t *en;
;1228:
;1229:				en = pm->bgClients[pm->ps->saberLockEnemy];
ADDRLP4 52
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 48
ADDRLP4 52
INDIRP4
INDIRP4
CNSTI4 528
ADDP4
INDIRI4
CNSTI4 2
LSHI4
ADDRLP4 52
INDIRP4
CNSTI4 248
ADDP4
ADDP4
INDIRP4
ASGNP4
line 1231
;1230:
;1231:				if (en)
ADDRLP4 48
INDIRP4
CVPU4 4
CNSTU4 0
EQU4 $484
line 1232
;1232:				{
line 1233
;1233:					PM_SaberLockBreak(en, qfalse);
ADDRLP4 48
INDIRP4
ARGP4
CNSTI4 0
ARGI4
ADDRGP4 PM_SaberLockBreak
CALLV
pop
line 1234
;1234:					return;
ADDRGP4 $473
JUMPV
LABELV $484
line 1236
;1235:				}
;1236:			}
LABELV $482
line 1238
;1237:
;1238:			if ( ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF2LOCK ||
ADDRLP4 48
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 52
ADDRLP4 48
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 52
INDIRI4
CNSTI4 538
EQI4 $491
ADDRLP4 52
INDIRI4
CNSTI4 541
EQI4 $491
ADDRLP4 52
INDIRI4
CNSTI4 548
EQI4 $491
ADDRLP4 52
INDIRI4
CNSTI4 549
EQI4 $491
ADDRLP4 48
INDIRP4
CNSTI4 532
ADDP4
INDIRI4
CNSTI4 0
EQI4 $486
LABELV $491
line 1244
;1239:					(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_BF1LOCK ||
;1240:					(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CWCIRCLELOCK ||
;1241:					(pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == BOTH_CCWCIRCLELOCK ||
;1242:					pm->ps->saberLockFrame )
;1243:				)
;1244:			{
line 1245
;1245:				pm->ps->torsoTimer = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 0
ASGNI4
line 1246
;1246:				PM_SetAnim(SETANIM_TORSO,BOTH_STAND1,SETANIM_FLAG_OVERRIDE, 100);
ADDRLP4 56
CNSTI4 1
ASGNI4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 550
ARGI4
ADDRLP4 56
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1247
;1247:				pm->ps->saberLockFrame = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 532
ADDP4
CNSTI4 0
ASGNI4
line 1248
;1248:			}
LABELV $486
line 1249
;1249:		}
LABELV $476
line 1250
;1250:	}
line 1252
;1251:
;1252:	if (pm->ps->saberHolstered)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1300
ADDP4
INDIRI4
CNSTI4 0
EQI4 $492
line 1253
;1253:	{
line 1254
;1254:		if (pm->ps->saberMove != LS_READY)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 1
EQI4 $494
line 1255
;1255:		{
line 1256
;1256:			PM_SetSaberMove( LS_READY );
CNSTI4 1
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1257
;1257:		}
LABELV $494
line 1259
;1258:
;1259:		if ((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) != (pm->ps->torsoAnim & ~ANIM_TOGGLEBIT))
ADDRLP4 36
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 -2049
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
BANDI4
ADDRLP4 36
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
BANDI4
EQI4 $496
line 1260
;1260:		{
line 1261
;1261:			PM_SetAnim(SETANIM_TORSO,(pm->ps->legsAnim & ~ANIM_TOGGLEBIT),SETANIM_FLAG_OVERRIDE, 100);
ADDRLP4 44
CNSTI4 1
ASGNI4
ADDRLP4 44
INDIRI4
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ARGI4
ADDRLP4 44
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1262
;1262:		}
LABELV $496
line 1264
;1263:
;1264:		if (BG_InSaberStandAnim(pm->ps->torsoAnim))
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
ADDRGP4 BG_InSaberStandAnim
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
EQI4 $498
line 1265
;1265:		{
line 1266
;1266:			PM_SetAnim(SETANIM_TORSO,BOTH_STAND1,SETANIM_FLAG_OVERRIDE, 100);
ADDRLP4 48
CNSTI4 1
ASGNI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 550
ARGI4
ADDRLP4 48
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1267
;1267:		}
LABELV $498
line 1269
;1268:
;1269:		if (pm->ps->weaponTime < 1 && ((pm->cmd.buttons & BUTTON_ALT_ATTACK) || (pm->cmd.buttons & BUTTON_ATTACK)))
ADDRLP4 48
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
CNSTI4 1
ASGNI4
ADDRLP4 48
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 52
INDIRI4
GEI4 $500
ADDRLP4 56
ADDRLP4 48
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
CNSTI4 0
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 60
INDIRI4
NEI4 $502
ADDRLP4 56
INDIRI4
ADDRLP4 52
INDIRI4
BANDI4
ADDRLP4 60
INDIRI4
EQI4 $500
LABELV $502
line 1270
;1270:		{
line 1271
;1271:			if (pm->ps->duelTime < pm->cmd.serverTime)
ADDRLP4 64
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
INDIRP4
CNSTI4 1288
ADDP4
INDIRI4
ADDRLP4 64
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
GEI4 $503
line 1272
;1272:			{
line 1273
;1273:				pm->ps->saberHolstered = qfalse;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1300
ADDP4
CNSTI4 0
ASGNI4
line 1274
;1274:				PM_AddEvent(EV_SABER_UNHOLSTER);
CNSTI4 29
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1275
;1275:			}
LABELV $503
line 1276
;1276:		}
LABELV $500
line 1278
;1277:
;1278:		if ( pm->ps->weaponTime > 0 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $505
line 1279
;1279:		{
line 1280
;1280:			pm->ps->weaponTime -= pml.msec;
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1281
;1281:		}
LABELV $505
line 1283
;1282:
;1283:		checkOnlyWeap = qtrue;
ADDRLP4 12
CNSTI4 1
ASGNI4
line 1284
;1284:		goto weapChecks;
ADDRGP4 $508
JUMPV
LABELV $492
line 1287
;1285:	}
;1286:
;1287:	if ((pm->cmd.buttons & BUTTON_ALT_ATTACK) &&
ADDRLP4 36
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 40
CNSTI4 0
ASGNI4
ADDRLP4 36
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 128
BANDI4
ADDRLP4 40
INDIRI4
EQI4 $509
ADDRLP4 44
ADDRLP4 36
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 44
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 1
GEI4 $509
ADDRLP4 44
INDIRP4
CNSTI4 560
ADDP4
INDIRI4
ADDRLP4 40
INDIRI4
EQI4 $509
ADDRLP4 44
INDIRP4
CNSTI4 920
ADDP4
INDIRI4
CNSTI4 72
ADDRLP4 44
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+68
ADDP4
INDIRI4
LTI4 $509
ADDRLP4 36
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 44
INDIRP4
ARGP4
ADDRLP4 48
ADDRGP4 BG_HasYsalamiri
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
NEI4 $509
ADDRLP4 52
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 52
INDIRP4
CNSTI4 220
ADDP4
INDIRI4
ARGI4
ADDRLP4 52
INDIRP4
INDIRP4
ARGP4
ADDRLP4 52
INDIRP4
CNSTI4 4
ADDP4
INDIRI4
ARGI4
CNSTI4 17
ARGI4
ADDRLP4 56
ADDRGP4 BG_CanUseFPNow
CALLI4
ASGNI4
ADDRLP4 56
INDIRI4
CNSTI4 0
EQI4 $509
line 1294
;1288:		pm->ps->weaponTime < 1 &&
;1289:		pm->ps->saberCanThrow &&
;1290:		pm->ps->fd.forcePower >= forcePowerNeeded[pm->ps->fd.forcePowerLevel[FP_SABERTHROW]][FP_SABERTHROW] &&
;1291:		!BG_HasYsalamiri(pm->gametype, pm->ps) &&
;1292:		BG_CanUseFPNow(pm->gametype, pm->ps, pm->cmd.serverTime, FP_SABERTHROW)
;1293:		)
;1294:	{ //might as well just check for a saber throw right here
line 1296
;1295:		//This will get set to false again once the saber makes it back to its owner game-side
;1296:		if (!pm->ps->saberInFlight)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
NEI4 $512
line 1297
;1297:		{
line 1298
;1298:			pm->ps->fd.forcePower -= forcePowerNeeded[pm->ps->fd.forcePowerLevel[FP_SABERTHROW]][FP_SABERTHROW];
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
ADDRLP4 60
INDIRP4
CNSTI4 920
ADDP4
ASGNP4
ADDRLP4 64
INDIRP4
ADDRLP4 64
INDIRP4
INDIRI4
CNSTI4 72
ADDRLP4 60
INDIRP4
CNSTI4 1000
ADDP4
INDIRI4
MULI4
ADDRGP4 forcePowerNeeded+68
ADDP4
INDIRI4
SUBI4
ASGNI4
line 1299
;1299:		}
LABELV $512
line 1301
;1300:
;1301:		pm->ps->saberInFlight = qtrue;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 504
ADDP4
CNSTI4 1
ASGNI4
line 1302
;1302:	}
LABELV $509
line 1304
;1303:	
;1304:	if ( pm->ps->saberInFlight )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 504
ADDP4
INDIRI4
CNSTI4 0
EQI4 $515
line 1305
;1305:	{//guiding saber
line 1306
;1306:		PM_SetAnim(SETANIM_TORSO, BOTH_SABERPULL, SETANIM_FLAG_OVERRIDE|SETANIM_FLAG_HOLD, 100);
CNSTI4 1
ARGI4
CNSTI4 946
ARGI4
CNSTI4 3
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1307
;1307:		pm->ps->torsoTimer = 1;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 1
ASGNI4
line 1308
;1308:		return;
ADDRGP4 $473
JUMPV
LABELV $515
line 1312
;1309:	}
;1310:
;1311:   // don't allow attack until all buttons are up
;1312:	if ( pm->ps->pm_flags & PMF_RESPAWNED ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 512
BANDI4
CNSTI4 0
EQI4 $517
line 1313
;1313:		return;
ADDRGP4 $473
JUMPV
LABELV $517
line 1317
;1314:	}
;1315:
;1316:	// check for dead player
;1317:	if ( pm->ps->stats[STAT_HEALTH] <= 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 216
ADDP4
INDIRI4
CNSTI4 0
GTI4 $519
line 1318
;1318:		return;
ADDRGP4 $473
JUMPV
LABELV $519
line 1321
;1319:	}
;1320:
;1321:	if (pm->ps->weaponstate == WEAPON_READY ||
ADDRLP4 60
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
ASGNI4
ADDRLP4 60
INDIRI4
CNSTI4 0
EQI4 $523
ADDRLP4 60
INDIRI4
CNSTI4 6
NEI4 $521
LABELV $523
line 1323
;1322:		pm->ps->weaponstate == WEAPON_IDLE)
;1323:	{
line 1324
;1324:		if (pm->ps->saberMove != LS_READY && pm->ps->weaponTime <= 0 && !pm->ps->saberBlocked)
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 64
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 1
EQI4 $524
ADDRLP4 68
CNSTI4 0
ASGNI4
ADDRLP4 64
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
GTI4 $524
ADDRLP4 64
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ADDRLP4 68
INDIRI4
NEI4 $524
line 1325
;1325:		{
line 1326
;1326:			PM_SetSaberMove( LS_READY );
CNSTI4 1
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1327
;1327:		}
LABELV $524
line 1328
;1328:	}
LABELV $521
line 1330
;1329:
;1330:	if( (pm->ps->torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN2 ||
ADDRLP4 64
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
ADDRLP4 64
INDIRI4
CNSTI4 734
EQI4 $528
ADDRLP4 64
INDIRI4
CNSTI4 731
NEI4 $526
LABELV $528
line 1332
;1331:		(pm->ps->torsoAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN1 )
;1332:	{
line 1333
;1333:		if ((pm->ps->torsoAnim & ~ANIM_TOGGLEBIT) != (pm->ps->legsAnim & ~ANIM_TOGGLEBIT))
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
CNSTI4 -2049
ASGNI4
ADDRLP4 68
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
BANDI4
ADDRLP4 68
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
ADDRLP4 72
INDIRI4
BANDI4
EQI4 $529
line 1334
;1334:		{
line 1335
;1335:			PM_SetAnim(SETANIM_TORSO,(pm->ps->legsAnim & ~ANIM_TOGGLEBIT),SETANIM_FLAG_OVERRIDE, 100);
ADDRLP4 76
CNSTI4 1
ASGNI4
ADDRLP4 76
INDIRI4
ARGI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ARGI4
ADDRLP4 76
INDIRI4
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1336
;1336:		}
LABELV $529
line 1337
;1337:	}
LABELV $526
line 1340
;1338:
;1339:	// make weapon function
;1340:	if ( pm->ps->weaponTime > 0 ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $531
line 1341
;1341:		pm->ps->weaponTime -= pml.msec;
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ASGNP4
ADDRLP4 68
INDIRP4
ADDRLP4 68
INDIRP4
INDIRI4
ADDRGP4 pml+40
INDIRI4
SUBI4
ASGNI4
line 1343
;1342:
;1343:		if (pm->ps->saberBlocked && pm->ps->torsoAnim != saberMoveData[pm->ps->saberMove].animToUse)
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $532
ADDRLP4 72
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 40
ADDRLP4 72
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
EQI4 $532
line 1344
;1344:		{ //rww - keep him in the blocking pose until he can attack again
line 1345
;1345:			PM_SetAnim(SETANIM_TORSO,saberMoveData[pm->ps->saberMove].animToUse,saberMoveData[pm->ps->saberMove].animSetFlags|SETANIM_FLAG_HOLD, saberMoveData[pm->ps->saberMove].blendTime);
CNSTI4 1
ARGI4
ADDRLP4 76
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ASGNI4
ADDRLP4 76
INDIRI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ARGI4
ADDRLP4 76
INDIRI4
ADDRGP4 saberMoveData+16
ADDP4
INDIRU4
CNSTU4 2
BORU4
CVUI4 4
ARGI4
ADDRLP4 76
INDIRI4
ADDRGP4 saberMoveData+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1346
;1346:			return;
ADDRGP4 $473
JUMPV
line 1348
;1347:		}
;1348:	}
LABELV $531
line 1350
;1349:	else
;1350:	{
line 1351
;1351:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 1352
;1352:	}
LABELV $532
line 1355
;1353:
;1354:	// Now we react to a block action by the player's lightsaber.
;1355:	if ( pm->ps->saberBlocked )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
CNSTI4 0
EQI4 $540
line 1356
;1356:	{
line 1357
;1357:		int firstSet = 0;
ADDRLP4 68
CNSTI4 0
ASGNI4
line 1359
;1358:
;1359:		if (!pm->ps->weaponTime)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
NEI4 $542
line 1360
;1360:		{
line 1361
;1361:			firstSet = 1;
ADDRLP4 68
CNSTI4 1
ASGNI4
line 1362
;1362:		}
LABELV $542
line 1364
;1363:
;1364:		switch ( pm->ps->saberBlocked )
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 1
LTI4 $544
ADDRLP4 72
INDIRI4
CNSTI4 14
GTI4 $544
ADDRLP4 72
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $575-4
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $575
address $547
address $552
address $563
address $565
address $567
address $569
address $571
address $564
address $566
address $568
address $570
address $572
address $573
address $574
code
line 1365
;1365:		{
LABELV $547
line 1368
;1366:			case BLOCKED_PARRY_BROKEN:
;1367:				//whatever parry we were is in now broken, play the appropriate knocked-away anim
;1368:				{
line 1371
;1369:					int nextMove;
;1370:
;1371:					if ( PM_SaberInBrokenParry( pm->ps->saberMove ) )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 PM_SaberInBrokenParry
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $548
line 1372
;1372:					{//already have one...?
line 1373
;1373:						nextMove = pm->ps->saberMove;
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 1374
;1374:					}
ADDRGP4 $549
JUMPV
LABELV $548
line 1376
;1375:					else
;1376:					{
line 1377
;1377:						nextMove = PM_BrokenParryForParry( pm->ps->saberMove );
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 PM_BrokenParryForParry
CALLI4
ASGNI4
ADDRLP4 80
ADDRLP4 88
INDIRI4
ASGNI4
line 1378
;1378:					}
LABELV $549
line 1379
;1379:					if ( nextMove != LS_NONE )
ADDRLP4 80
INDIRI4
CNSTI4 0
EQI4 $545
line 1380
;1380:					{
line 1381
;1381:						PM_SetSaberMove( nextMove );
ADDRLP4 80
INDIRI4
CVII2 4
CVII4 2
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1382
;1382:						pm->ps->weaponTime = pm->ps->torsoTimer;
ADDRLP4 88
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 88
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 88
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ASGNI4
line 1383
;1383:					}
line 1385
;1384:					else
;1385:					{//Maybe in a knockaway?
line 1386
;1386:					}
line 1387
;1387:				}
line 1388
;1388:				break;
ADDRGP4 $545
JUMPV
LABELV $552
line 1392
;1389:			case BLOCKED_ATK_BOUNCE:
;1390:				// If there is absolutely no blocked move in the chart, don't even mess with the animation.
;1391:				// OR if we are already in a block or parry.
;1392:				if (pm->ps->saberMove >= LS_T1_BR__R/*LS_BOUNCE_TOP*/ )//|| saberMoveData[pm->ps->saberMove].bounceMove == LS_NONE )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
CNSTI4 32
LTI4 $553
line 1393
;1393:				{//an actual bounce?  Other bounces before this are actually transitions?
line 1394
;1394:					pm->ps->saberBlocked = BLOCKED_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 1395
;1395:				}
ADDRGP4 $545
JUMPV
LABELV $553
line 1397
;1396:				else
;1397:				{
line 1415
;1398:					int bounceMove;
;1399:
;1400:					//if ( pm->cmd.buttons & BUTTON_ATTACK )	Boot comment - no follow-up attacks when blocked, for now
;1401:					//{//transition to a new attack
;1402:					//	int newQuad = PM_SaberMoveQuadrantForMovement( &pm->cmd );
;1403:
;1404:					//	while ( newQuad == saberMoveData[pm->ps->saberMove].startQuad )
;1405:					//	{//player is still in same attack quad, don't repeat that attack because it looks bad, 
;1406:					//		//FIXME: try to pick one that might look cool?
;1407:					//		//newQuad = Q_irand( Q_BR, Q_BL );
;1408:					//		newQuad = PM_irand_timesync( Q_BR, Q_BL );
;1409:					//		//FIXME: sanity check, just in case?
;1410:					//	}//else player is switching up anyway, take the new attack dir
;1411:					//	bounceMove = transitionMove[saberMoveData[pm->ps->saberMove].startQuad][newQuad];
;1412:					//}
;1413:					//else
;1414:					//{//return to ready
;1415:						if ( saberMoveData[pm->ps->saberMove].startQuad == Q_T )
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 3
NEI4 $555
line 1416
;1416:						{
line 1417
;1417:							bounceMove = LS_R_BL2TR;
ADDRLP4 80
CNSTI4 27
ASGNI4
line 1418
;1418:						}
ADDRGP4 $556
JUMPV
LABELV $555
line 1419
;1419:						else if ( saberMoveData[pm->ps->saberMove].startQuad < Q_T )
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 3
GEI4 $558
line 1420
;1420:						{
line 1421
;1421:							bounceMove = LS_R_TL2BR+saberMoveData[pm->ps->saberMove].startQuad-Q_BR;
ADDRLP4 80
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 25
ADDI4
ASGNI4
line 1422
;1422:						}
ADDRGP4 $559
JUMPV
LABELV $558
line 1424
;1423:						else// if ( saberMoveData[pm->ps->saberMove].startQuad > Q_T )
;1424:						{
line 1425
;1425:							bounceMove = LS_R_BR2TL+saberMoveData[pm->ps->saberMove].startQuad-Q_TL;
ADDRLP4 80
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+8
ADDP4
INDIRI4
CNSTI4 28
ADDI4
CNSTI4 4
SUBI4
ASGNI4
line 1426
;1426:						}
LABELV $559
LABELV $556
line 1428
;1427:					//}
;1428:					PM_SetSaberMove( bounceMove );
ADDRLP4 80
INDIRI4
CVII2 4
CVII4 2
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1430
;1429:
;1430:					pm->ps->weaponTime = pm->ps->torsoTimer;//+saberMoveData[bounceMove].blendTime+SABER_BLOCK_DUR;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ASGNI4
line 1432
;1431:
;1432:				}
line 1433
;1433:				break;
ADDRGP4 $545
JUMPV
LABELV $563
line 1435
;1434:			case BLOCKED_UPPER_RIGHT:
;1435:				PM_SetSaberMove( LS_PARRY_UR );
CNSTI4 109
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1436
;1436:				break;
ADDRGP4 $545
JUMPV
LABELV $564
line 1438
;1437:			case BLOCKED_UPPER_RIGHT_PROJ:
;1438:				PM_SetSaberMove( LS_REFLECT_UR );
CNSTI4 114
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1439
;1439:				break;
ADDRGP4 $545
JUMPV
LABELV $565
line 1441
;1440:			case BLOCKED_UPPER_LEFT:
;1441:				PM_SetSaberMove( LS_PARRY_UL );
CNSTI4 110
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1442
;1442:				break;
ADDRGP4 $545
JUMPV
LABELV $566
line 1444
;1443:			case BLOCKED_UPPER_LEFT_PROJ:
;1444:				PM_SetSaberMove( LS_REFLECT_UL );
CNSTI4 115
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1445
;1445:				break;
ADDRGP4 $545
JUMPV
LABELV $567
line 1447
;1446:			case BLOCKED_LOWER_RIGHT:
;1447:				PM_SetSaberMove( LS_PARRY_LR );
CNSTI4 111
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1448
;1448:				break;
ADDRGP4 $545
JUMPV
LABELV $568
line 1450
;1449:			case BLOCKED_LOWER_RIGHT_PROJ:
;1450:				PM_SetSaberMove( LS_REFLECT_LR );
CNSTI4 116
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1451
;1451:				break;
ADDRGP4 $545
JUMPV
LABELV $569
line 1453
;1452:			case BLOCKED_LOWER_LEFT:
;1453:				PM_SetSaberMove( LS_PARRY_LL );
CNSTI4 112
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1454
;1454:				break;
ADDRGP4 $545
JUMPV
LABELV $570
line 1456
;1455:			case BLOCKED_LOWER_LEFT_PROJ:
;1456:				PM_SetSaberMove( LS_REFLECT_LL);
CNSTI4 117
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1457
;1457:				break;
ADDRGP4 $545
JUMPV
LABELV $571
line 1459
;1458:			case BLOCKED_TOP:
;1459:				PM_SetSaberMove( LS_PARRY_UP );
CNSTI4 108
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1460
;1460:				break;
ADDRGP4 $545
JUMPV
LABELV $572
line 1462
;1461:			case BLOCKED_TOP_PROJ:
;1462:				PM_SetSaberMove( LS_REFLECT_UP );
CNSTI4 113
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1463
;1463:				break;
ADDRGP4 $545
JUMPV
LABELV $573
line 1466
;1464:				//Boot
;1465:			case BOOT_BLOCKED_DIAG_LEFT:
;1466:				PM_SetSaberMove(BOOT_LS_PARRY_DIAG_LEFT);
CNSTI4 118
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1467
;1467:				break;
ADDRGP4 $545
JUMPV
LABELV $574
line 1469
;1468:			case BOOT_BLOCKED_DIAG_RIGHT:
;1469:				PM_SetSaberMove(BOOT_LS_PARRY_DIAG_RIGHT);
CNSTI4 119
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1470
;1470:				break;
ADDRGP4 $545
JUMPV
LABELV $544
line 1473
;1471:				//
;1472:			default:
;1473:				pm->ps->saberBlocked = BLOCKED_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 1474
;1474:				break;
LABELV $545
line 1477
;1475:		}
;1476:
;1477:		if (pm->ps->saberBlocked != BLOCKED_ATK_BOUNCE && pm->ps->saberBlocked != BLOCKED_PARRY_BROKEN && pm->ps->weaponTime < 1)
ADDRLP4 80
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
ADDRLP4 80
INDIRP4
CNSTI4 520
ADDP4
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 2
EQI4 $577
ADDRLP4 88
CNSTI4 1
ASGNI4
ADDRLP4 84
INDIRI4
ADDRLP4 88
INDIRI4
EQI4 $577
ADDRLP4 80
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ADDRLP4 88
INDIRI4
GEI4 $577
line 1478
;1478:		{
line 1479
;1479:			pm->ps->torsoTimer = SABER_BLOCK_DUR;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 96
ADDP4
CNSTI4 150
ASGNI4
line 1480
;1480:			pm->ps->weaponTime = pm->ps->torsoTimer;
ADDRLP4 92
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 92
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 92
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ASGNI4
line 1481
;1481:		}
LABELV $577
line 1483
;1482:
;1483:		if (firstSet)
ADDRLP4 68
INDIRI4
CNSTI4 0
EQI4 $579
line 1484
;1484:		{
line 1485
;1485:			return;
ADDRGP4 $473
JUMPV
LABELV $579
line 1489
;1486:		}
;1487:
;1488:		// Charging is like a lead-up before attacking again.  This is an appropriate use, or we can create a new weaponstate for blocking
;1489:		pm->ps->weaponstate = WEAPON_READY;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 0
ASGNI4
line 1492
;1490:
;1491:		// Done with block, so stop these active weapon branches.
;1492:		return;
ADDRGP4 $473
JUMPV
LABELV $540
LABELV $508
line 1498
;1493:	}
;1494:
;1495:weapChecks:
;1496:	// check for weapon change
;1497:	// can't change if weapon is firing, but can change again if lowering or raising
;1498:	if ( pm->ps->weaponTime <= 0 || pm->ps->weaponstate != WEAPON_FIRING ) {
ADDRLP4 68
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 68
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $583
ADDRLP4 68
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 3
EQI4 $581
LABELV $583
line 1499
;1499:		if ( pm->ps->weapon != pm->cmd.weapon ) {
ADDRLP4 72
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
ADDRLP4 72
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
EQI4 $584
line 1500
;1500:			PM_BeginWeaponChange( pm->cmd.weapon );
ADDRGP4 pm
INDIRP4
CNSTI4 24
ADDP4
INDIRU1
CVUI4 1
ARGI4
ADDRGP4 PM_BeginWeaponChange
CALLV
pop
line 1501
;1501:		}
LABELV $584
line 1502
;1502:	}
LABELV $581
line 1504
;1503:
;1504:	if ( pm->ps->weaponTime > 0 ) 
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $586
line 1505
;1505:	{
line 1506
;1506:		return;
ADDRGP4 $473
JUMPV
LABELV $586
line 1514
;1507:	}
;1508:
;1509:	// *********************************************************
;1510:	// WEAPON_DROPPING
;1511:	// *********************************************************
;1512:
;1513:	// change weapon if time
;1514:	if ( pm->ps->weaponstate == WEAPON_DROPPING ) {
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 2
NEI4 $588
line 1515
;1515:		PM_FinishWeaponChange();
ADDRGP4 PM_FinishWeaponChange
CALLV
pop
line 1516
;1516:		return;
ADDRGP4 $473
JUMPV
LABELV $588
line 1523
;1517:	}
;1518:
;1519:	// *********************************************************
;1520:	// WEAPON_RAISING
;1521:	// *********************************************************
;1522:
;1523:	if ( pm->ps->weaponstate == WEAPON_RAISING ) 
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 1
NEI4 $590
line 1524
;1524:	{//Just selected the weapon
line 1525
;1525:		pm->ps->weaponstate = WEAPON_IDLE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 6
ASGNI4
line 1526
;1526:		if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_WALK1 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 723
NEI4 $592
line 1527
;1527:		{
line 1528
;1528:			PM_SetAnim(SETANIM_TORSO,BOTH_WALK1,SETANIM_FLAG_NORMAL, 100);
CNSTI4 1
ARGI4
CNSTI4 723
ARGI4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1529
;1529:		}
ADDRGP4 $593
JUMPV
LABELV $592
line 1530
;1530:		else if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN2 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 734
NEI4 $594
line 1531
;1531:		{
line 1532
;1532:			PM_SetAnim(SETANIM_TORSO,BOTH_RUN2,SETANIM_FLAG_NORMAL, 100);
CNSTI4 1
ARGI4
CNSTI4 734
ARGI4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1533
;1533:		}
ADDRGP4 $595
JUMPV
LABELV $594
line 1534
;1534:		else if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_WALK2 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 724
NEI4 $596
line 1535
;1535:		{
line 1536
;1536:			PM_SetAnim(SETANIM_TORSO,BOTH_WALK2,SETANIM_FLAG_NORMAL, 100);
CNSTI4 1
ARGI4
CNSTI4 724
ARGI4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1537
;1537:		}
ADDRGP4 $597
JUMPV
LABELV $596
line 1539
;1538:		else
;1539:		{
line 1540
;1540:			PM_SetAnim(SETANIM_TORSO,PM_GetSaberStance(),SETANIM_FLAG_NORMAL, 100);
ADDRLP4 72
ADDRGP4 PM_GetSaberStance
CALLI4
ASGNI4
CNSTI4 1
ARGI4
ADDRLP4 72
INDIRI4
ARGI4
CNSTI4 0
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1541
;1541:		}
LABELV $597
LABELV $595
LABELV $593
line 1543
;1542:
;1543:		if (pm->ps->weaponstate == WEAPON_RAISING)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 1
NEI4 $598
line 1544
;1544:		{
line 1545
;1545:			return;
ADDRGP4 $473
JUMPV
LABELV $598
line 1548
;1546:		}
;1547:
;1548:	}
LABELV $590
line 1550
;1549:
;1550:	if (checkOnlyWeap)
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $600
line 1551
;1551:	{
line 1552
;1552:		return;
ADDRGP4 $473
JUMPV
LABELV $600
line 1561
;1553:	}
;1554:
;1555:	// *********************************************************
;1556:	// Check for WEAPON ATTACK
;1557:	// *********************************************************
;1558:
;1559:	// NOTENOTE This is simply a client-side struct.  Anything that is needed client and server should be moved to bg_weapon.
;1560:
;1561:	if(!delayed_fire)
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $602
line 1562
;1562:	{
line 1564
;1563:		// Start with the current move, and cross index it with the current control states.
;1564:		if ( pm->ps->saberMove > LS_NONE && pm->ps->saberMove < LS_MOVE_MAX )
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
ADDRLP4 72
INDIRI4
CNSTI4 0
LEI4 $604
ADDRLP4 72
INDIRI4
CNSTI4 134
GEI4 $604
line 1565
;1565:		{
line 1566
;1566:			curmove = pm->ps->saberMove;
ADDRLP4 4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ASGNI4
line 1567
;1567:		}
ADDRGP4 $605
JUMPV
LABELV $604
line 1569
;1568:		else
;1569:		{
line 1570
;1570:			curmove = LS_READY;
ADDRLP4 4
CNSTI4 1
ASGNI4
line 1571
;1571:		}
LABELV $605
line 1573
;1572:		// check for fire
;1573:		if ( !(pm->cmd.buttons & (BUTTON_ATTACK/*|BUTTON_ALT_ATTACK*/)) )
ADDRGP4 pm
INDIRP4
CNSTI4 20
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
NEI4 $606
line 1574
;1574:		{
line 1575
;1575:			if (pm->ps->weaponTime != 0)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
EQI4 $608
line 1576
;1576:			{//Still firing
line 1577
;1577:				pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 3
ASGNI4
line 1578
;1578:			}
ADDRGP4 $609
JUMPV
LABELV $608
line 1579
;1579:			else if ( pm->ps->weaponstate != WEAPON_READY )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
INDIRI4
CNSTI4 0
EQI4 $610
line 1580
;1580:			{
line 1581
;1581:				pm->ps->weaponstate = WEAPON_IDLE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 6
ASGNI4
line 1582
;1582:			}
LABELV $610
LABELV $609
line 1584
;1583:			//Check for finishing an anim if necc.
;1584:			if ( curmove >= LS_S_TL2BR && curmove <= LS_S_T2B )
ADDRLP4 76
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 76
INDIRI4
CNSTI4 18
LTI4 $612
ADDRLP4 76
INDIRI4
CNSTI4 24
GTI4 $612
line 1585
;1585:			{//started a swing, must continue from here
line 1586
;1586:				newmove = LS_A_TL2BR + (curmove-LS_S_TL2BR);
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 18
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 1587
;1587:			}
ADDRGP4 $613
JUMPV
LABELV $612
line 1588
;1588:			else if ( curmove >= LS_A_TL2BR && curmove <= LS_A_T2B )
ADDRLP4 80
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 4
LTI4 $614
ADDRLP4 80
INDIRI4
CNSTI4 10
GTI4 $614
line 1589
;1589:			{//finished an attack, must continue from here
line 1590
;1590:				newmove = LS_R_TL2BR + (curmove-LS_A_TL2BR);
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 4
SUBI4
CNSTI4 25
ADDI4
ASGNI4
line 1591
;1591:			}
ADDRGP4 $615
JUMPV
LABELV $614
line 1592
;1592:			else if ( PM_SaberInTransition( curmove ) )
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 84
ADDRGP4 PM_SaberInTransition
CALLI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
EQI4 $616
line 1593
;1593:			{//in a transition, must play sequential attack
line 1594
;1594:				newmove = saberMoveData[curmove].chain_attack;
ADDRLP4 8
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+32
ADDP4
INDIRI4
ASGNI4
line 1595
;1595:			}
ADDRGP4 $617
JUMPV
LABELV $616
line 1596
;1596:			else if ( PM_SaberInBounce( curmove ) )
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 88
ADDRGP4 PM_SaberInBounce
CALLI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 0
EQI4 $619
line 1597
;1597:			{//in a bounce
line 1598
;1598:				newmove = saberMoveData[curmove].chain_idle;//oops, not attacking, so don't chain
ADDRLP4 8
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+28
ADDP4
INDIRI4
ASGNI4
line 1599
;1599:			}
ADDRGP4 $620
JUMPV
LABELV $619
line 1601
;1600:			else
;1601:			{//FIXME: what about returning from a parry?
line 1602
;1602:				PM_SetSaberMove( LS_READY );
CNSTI4 1
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1603
;1603:				return;
ADDRGP4 $473
JUMPV
LABELV $620
LABELV $617
LABELV $615
LABELV $613
line 1605
;1604:			}
;1605:		}
LABELV $606
line 1610
;1606:
;1607:		// ***************************************************
;1608:		// Pressing attack, so we must look up the proper attack move.
;1609:
;1610:		saberInAir = qtrue;
ADDRLP4 24
CNSTI4 1
ASGNI4
line 1612
;1611:
;1612:		if ( pm->ps->weaponTime > 0 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
LEI4 $622
line 1613
;1613:		{	// Last attack is not yet complete.
line 1614
;1614:			pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 3
ASGNI4
line 1615
;1615:			return;
ADDRGP4 $473
JUMPV
LABELV $622
line 1618
;1616:		}
;1617:		else
;1618:		{
line 1619
;1619:			int	both = qfalse;
ADDRLP4 76
CNSTI4 0
ASGNI4
line 1621
;1620:
;1621:			if ( curmove >= LS_PARRY_UP && curmove <= LS_REFLECT_LL )
ADDRLP4 80
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 80
INDIRI4
CNSTI4 108
LTI4 $624
ADDRLP4 80
INDIRI4
CNSTI4 117
GTI4 $624
line 1622
;1622:			{//from a parry or deflection, can go directly into an attack (?)
line 1623
;1623:				switch ( saberMoveData[curmove].endQuad )
ADDRLP4 84
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+12
ADDP4
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 0
LTI4 $626
ADDRLP4 84
INDIRI4
CNSTI4 6
GTI4 $626
ADDRLP4 84
INDIRI4
CNSTI4 2
LSHI4
ADDRGP4 $635
ADDP4
INDIRP4
JUMPV
lit
align 4
LABELV $635
address $633
address $626
address $631
address $630
address $632
address $626
address $634
code
line 1624
;1624:				{
LABELV $630
line 1626
;1625:				case Q_T:
;1626:					newmove = LS_A_T2B;
ADDRLP4 8
CNSTI4 10
ASGNI4
line 1627
;1627:					break;
ADDRGP4 $627
JUMPV
LABELV $631
line 1629
;1628:				case Q_TR:
;1629:					newmove = LS_A_TL2BR;
ADDRLP4 8
CNSTI4 4
ASGNI4
line 1630
;1630:					break;
ADDRGP4 $627
JUMPV
LABELV $632
line 1632
;1631:				case Q_TL:
;1632:					newmove = LS_A_TR2BL;
ADDRLP4 8
CNSTI4 9
ASGNI4
line 1633
;1633:					break;
ADDRGP4 $627
JUMPV
LABELV $633
line 1635
;1634:				case Q_BR:
;1635:					newmove = LS_A_BR2TL;
ADDRLP4 8
CNSTI4 7
ASGNI4
line 1636
;1636:					break;
ADDRGP4 $627
JUMPV
LABELV $634
line 1638
;1637:				case Q_BL:
;1638:					newmove = LS_A_BL2TR;
ADDRLP4 8
CNSTI4 6
ASGNI4
line 1639
;1639:					break;
LABELV $626
LABELV $627
line 1642
;1640:				//shouldn't be a parry that ends at L, R or B
;1641:				}
;1642:			}
LABELV $624
line 1644
;1643:
;1644:			if ( newmove != LS_NONE )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $636
line 1645
;1645:			{//have a valid, final LS_ move picked, so skip findingt he transition move and just get the anim
line 1646
;1646:				anim = saberMoveData[newmove].animToUse;
ADDRLP4 16
CNSTI4 40
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ASGNI4
line 1647
;1647:			}
LABELV $636
line 1650
;1648:
;1649:			//FIXME: diagonal dirs use the figure-eight attacks from ready pose?
;1650:			if ( anim == -1 )
ADDRLP4 16
INDIRI4
CNSTI4 -1
NEI4 $639
line 1651
;1651:			{
line 1653
;1652:				//FIXME: take FP_SABER_OFFENSE into account here somehow?
;1653:				if ( curmove >= LS_T1_BR__R && curmove <= LS_T1_BL__L )
ADDRLP4 84
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 84
INDIRI4
CNSTI4 32
LTI4 $641
ADDRLP4 84
INDIRI4
CNSTI4 73
GTI4 $641
line 1654
;1654:				{//in a transition, must play sequential attack
line 1655
;1655:					newmove = saberMoveData[curmove].chain_attack;
ADDRLP4 8
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+32
ADDP4
INDIRI4
ASGNI4
line 1656
;1656:				}
ADDRGP4 $642
JUMPV
LABELV $641
line 1657
;1657:				else if ( curmove >= LS_S_TL2BR && curmove <= LS_S_T2B )
ADDRLP4 88
ADDRLP4 4
INDIRI4
ASGNI4
ADDRLP4 88
INDIRI4
CNSTI4 18
LTI4 $644
ADDRLP4 88
INDIRI4
CNSTI4 24
GTI4 $644
line 1658
;1658:				{//started a swing, must continue from here
line 1659
;1659:					newmove = LS_A_TL2BR + (curmove-LS_S_TL2BR);
ADDRLP4 8
ADDRLP4 4
INDIRI4
CNSTI4 18
SUBI4
CNSTI4 4
ADDI4
ASGNI4
line 1660
;1660:				}
ADDRGP4 $645
JUMPV
LABELV $644
line 1662
;1661:				else
;1662:				{
line 1663
;1663:					if ( PM_SaberKataDone() )
ADDRLP4 92
ADDRGP4 PM_SaberKataDone
CALLI4
ASGNI4
ADDRLP4 92
INDIRI4
CNSTI4 0
EQI4 $646
line 1664
;1664:					{//we came from a bounce and cannot chain to another attack because our kata is done
line 1665
;1665:						newmove = saberMoveData[curmove].chain_idle;
ADDRLP4 8
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+28
ADDP4
INDIRI4
ASGNI4
line 1666
;1666:					}
ADDRGP4 $647
JUMPV
LABELV $646
line 1668
;1667:					else
;1668:					{
line 1669
;1669:						saberMoveName_t checkMove = PM_SaberAttackForMovement(curmove);
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 100
ADDRGP4 PM_SaberAttackForMovement
CALLI4
ASGNI4
ADDRLP4 96
ADDRLP4 100
INDIRI4
ASGNI4
line 1670
;1670:						if (checkMove != -1)
ADDRLP4 96
INDIRI4
CNSTI4 -1
EQI4 $649
line 1671
;1671:						{
line 1672
;1672:							newmove = checkMove;
ADDRLP4 8
ADDRLP4 96
INDIRI4
ASGNI4
line 1673
;1673:						}
LABELV $649
line 1674
;1674:					}
LABELV $647
line 1675
;1675:				}
LABELV $645
LABELV $642
line 1683
;1676:				/*
;1677:				if ( newmove == LS_NONE )
;1678:				{//FIXME: should we allow this?  Are there some anims that you should never be able to chain into an attack?
;1679:					//only curmove that might get in here is LS_NONE, LS_DRAW, LS_PUTAWAY and the LS_R_ returns... all of which are in Q_R
;1680:					newmove = PM_AttackMoveForQuad( saberMoveData[curmove].endQuad );
;1681:				}
;1682:				*/
;1683:				if ( newmove != LS_NONE )
ADDRLP4 8
INDIRI4
CNSTI4 0
EQI4 $651
line 1684
;1684:				{
line 1686
;1685:					//Now get the proper transition move
;1686:					newmove = PM_SaberAnimTransitionAnim( curmove, newmove );
ADDRLP4 4
INDIRI4
ARGI4
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 92
ADDRGP4 PM_SaberAnimTransitionAnim
CALLI4
ASGNI4
ADDRLP4 8
ADDRLP4 92
INDIRI4
ASGNI4
line 1692
;1687:					// NOTENOTE Had to remove this concept since there is no gent in pmove.
;1688:					/*
;1689:					if ( PM_HasAnimation( pm->gent, saberMoveData[newmove].animToUse ) )
;1690:					*/
;1691:
;1692:					assert(	bgGlobalAnimations[saberMoveData[newmove].animToUse].firstFrame != 0 || 
line 1695
;1693:							bgGlobalAnimations[saberMoveData[newmove].animToUse].numFrames != 0);
;1694:
;1695:					if (1)
line 1696
;1696:					{
line 1697
;1697:						anim = saberMoveData[newmove].animToUse;
ADDRLP4 16
CNSTI4 40
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ASGNI4
line 1698
;1698:					}
LABELV $653
line 1699
;1699:				}
LABELV $651
line 1700
;1700:			}
LABELV $639
line 1702
;1701:
;1702:			if (anim == -1)
ADDRLP4 16
INDIRI4
CNSTI4 -1
NEI4 $656
line 1703
;1703:			{//not side-stepping, pick neutral anim
line 1705
;1704:				// Add randomness for prototype?
;1705:				newmove = saberMoveData[curmove].chain_attack;
ADDRLP4 8
CNSTI4 40
ADDRLP4 4
INDIRI4
MULI4
ADDRGP4 saberMoveData+32
ADDP4
INDIRI4
ASGNI4
line 1707
;1706:
;1707:				anim= saberMoveData[newmove].animToUse;
ADDRLP4 16
CNSTI4 40
ADDRLP4 8
INDIRI4
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ASGNI4
line 1709
;1708:
;1709:				if ( !pm->cmd.forwardmove && !pm->cmd.rightmove && pm->cmd.upmove >= 0 && pm->ps->groundEntityNum != ENTITYNUM_NONE )
ADDRLP4 84
ADDRGP4 pm
INDIRP4
ASGNP4
ADDRLP4 88
CNSTI4 0
ASGNI4
ADDRLP4 84
INDIRP4
CNSTI4 28
ADDP4
INDIRI1
CVII4 1
ADDRLP4 88
INDIRI4
NEI4 $660
ADDRLP4 84
INDIRP4
CNSTI4 29
ADDP4
INDIRI1
CVII4 1
ADDRLP4 88
INDIRI4
NEI4 $660
ADDRLP4 84
INDIRP4
CNSTI4 30
ADDP4
INDIRI1
CVII4 1
ADDRLP4 88
INDIRI4
LTI4 $660
ADDRLP4 84
INDIRP4
INDIRP4
CNSTI4 84
ADDP4
INDIRI4
CNSTI4 1023
EQI4 $660
line 1710
;1710:				{//not moving at all, so set the anim on entire body
line 1711
;1711:					both = qtrue;
ADDRLP4 76
CNSTI4 1
ASGNI4
line 1712
;1712:				}
LABELV $660
line 1714
;1713:			
;1714:			}
LABELV $656
line 1716
;1715:
;1716:			if ( anim == -1)
ADDRLP4 16
INDIRI4
CNSTI4 -1
NEI4 $662
line 1717
;1717:			{
line 1718
;1718:				if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_WALK1 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 723
NEI4 $664
line 1719
;1719:				{
line 1720
;1720:					anim = BOTH_WALK1;
ADDRLP4 16
CNSTI4 723
ASGNI4
line 1721
;1721:				}
ADDRGP4 $665
JUMPV
LABELV $664
line 1722
;1722:				else if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_RUN2 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 734
NEI4 $666
line 1723
;1723:				{
line 1724
;1724:					anim = BOTH_RUN2;
ADDRLP4 16
CNSTI4 734
ASGNI4
line 1725
;1725:				}
ADDRGP4 $667
JUMPV
LABELV $666
line 1726
;1726:				else if((pm->ps->legsAnim & ~ANIM_TOGGLEBIT) == BOTH_WALK2 )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
CNSTI4 724
NEI4 $668
line 1727
;1727:				{
line 1728
;1728:					anim = BOTH_WALK2;
ADDRLP4 16
CNSTI4 724
ASGNI4
line 1729
;1729:				}
ADDRGP4 $669
JUMPV
LABELV $668
line 1731
;1730:				else
;1731:				{
line 1732
;1732:					anim = PM_GetSaberStance();
ADDRLP4 84
ADDRGP4 PM_GetSaberStance
CALLI4
ASGNI4
ADDRLP4 16
ADDRLP4 84
INDIRI4
ASGNI4
line 1733
;1733:				}
LABELV $669
LABELV $667
LABELV $665
line 1734
;1734:				newmove = LS_READY;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1735
;1735:			}
LABELV $662
line 1737
;1736:
;1737:			if ( !pm->ps->saberActive )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 508
ADDP4
INDIRI4
CNSTI4 0
NEI4 $670
line 1738
;1738:			{//turn on the saber if it's not on
line 1739
;1739:				pm->ps->saberActive = qtrue;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 508
ADDP4
CNSTI4 1
ASGNI4
line 1740
;1740:			}
LABELV $670
line 1742
;1741:
;1742:			PM_SetSaberMove( newmove );
ADDRLP4 8
INDIRI4
CVII2 4
CVII4 2
ARGI4
ADDRGP4 PM_SetSaberMove
CALLV
pop
line 1744
;1743:
;1744:			if ( both )
ADDRLP4 76
INDIRI4
CNSTI4 0
EQI4 $672
line 1745
;1745:			{
line 1746
;1746:				PM_SetAnim(SETANIM_LEGS,anim,SETANIM_FLAG_OVERRIDE|SETANIM_FLAG_HOLD, 100);
CNSTI4 2
ARGI4
ADDRLP4 16
INDIRI4
ARGI4
CNSTI4 3
ARGI4
CNSTI4 100
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1747
;1747:			}
LABELV $672
line 1750
;1748:
;1749:			//don't fire again until anim is done
;1750:			pm->ps->weaponTime = pm->ps->torsoTimer;
ADDRLP4 84
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 84
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 84
INDIRP4
CNSTI4 96
ADDP4
INDIRI4
ASGNI4
line 1751
;1751:		}
line 1752
;1752:	}
LABELV $602
line 1758
;1753:
;1754:	// *********************************************************
;1755:	// WEAPON_FIRING
;1756:	// *********************************************************
;1757:
;1758:	pm->ps->weaponstate = WEAPON_FIRING;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 152
ADDP4
CNSTI4 3
ASGNI4
line 1760
;1759:
;1760:	amount = weaponData[pm->ps->weapon].energyPerShot;
ADDRLP4 28
CNSTI4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
MULI4
ADDRGP4 weaponData+8
ADDP4
INDIRI4
ASGNI4
line 1762
;1761:
;1762:	addTime = pm->ps->weaponTime;
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
ASGNI4
line 1764
;1763:
;1764:	pm->ps->saberAttackSequence = pm->ps->torsoAnim;
ADDRLP4 72
ADDRGP4 pm
INDIRP4
INDIRP4
ASGNP4
ADDRLP4 72
INDIRP4
CNSTI4 732
ADDP4
ADDRLP4 72
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
ASGNI4
line 1765
;1765:	if ( !addTime )
ADDRLP4 0
INDIRI4
CNSTI4 0
NEI4 $675
line 1766
;1766:	{
line 1767
;1767:		addTime = weaponData[pm->ps->weapon].fireTime;
ADDRLP4 0
CNSTI4 56
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 148
ADDP4
INDIRI4
MULI4
ADDRGP4 weaponData+12
ADDP4
INDIRI4
ASGNI4
line 1768
;1768:	}
LABELV $675
line 1769
;1769:	pm->ps->weaponTime = addTime;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1770
;1770:}
LABELV $473
endproc PM_WeaponLightsaber 104 16
export PM_SetSaberMove
proc PM_SetSaberMove 52 16
ADDRFP4 0
ADDRFP4 0
INDIRI4
CVII2 4
ASGNI2
line 1773
;1771:
;1772:void PM_SetSaberMove(short newMove)
;1773:{
line 1774
;1774:	unsigned int setflags = saberMoveData[newMove].animSetFlags;
ADDRLP4 4
CNSTI4 40
ADDRFP4 0
INDIRI2
CVII4 2
MULI4
ADDRGP4 saberMoveData+16
ADDP4
INDIRU4
ASGNU4
line 1775
;1775:	int	anim = saberMoveData[newMove].animToUse;
ADDRLP4 0
CNSTI4 40
ADDRFP4 0
INDIRI2
CVII4 2
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ASGNI4
line 1776
;1776:	int parts = SETANIM_TORSO;	//Boot - here you can change what parts saber anims are played on.
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1778
;1777:	
;1778:	if ( newMove == LS_READY )
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 1
NEI4 $681
line 1779
;1779:	{//finished with a kata, reset attack counter
line 1780
;1780:		pm->ps->saberAttackChainCount = 0;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1296
ADDP4
CNSTI4 0
ASGNI4
line 1781
;1781:	}
ADDRGP4 $682
JUMPV
LABELV $681
line 1782
;1782:	else if ( BG_SaberInAttack( newMove ) )
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 12
ADDRGP4 BG_SaberInAttack
CALLI4
ASGNI4
ADDRLP4 12
INDIRI4
CNSTI4 0
EQI4 $683
line 1783
;1783:	{//continuing with a kata, increment attack counter
line 1784
;1784:		pm->ps->saberAttackChainCount++;
ADDRLP4 16
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1296
ADDP4
ASGNP4
ADDRLP4 16
INDIRP4
ADDRLP4 16
INDIRP4
INDIRI4
CNSTI4 1
ADDI4
ASGNI4
line 1785
;1785:	}
LABELV $683
LABELV $682
line 1787
;1786:
;1787:	if (pm->ps->saberAttackChainCount > 16)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1296
ADDP4
INDIRI4
CNSTI4 16
LEI4 $685
line 1788
;1788:	{ //for the sake of being able to send the value over the net within a reasonable bit count
line 1789
;1789:		pm->ps->saberAttackChainCount = 16;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1296
ADDP4
CNSTI4 16
ASGNI4
line 1790
;1790:	}
LABELV $685
line 1792
;1791:
;1792:	if ( pm->ps->fd.saberAnimLevel > FORCE_LEVEL_1 &&
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
CNSTI4 1
LEI4 $687
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 16
ADDRGP4 BG_SaberInIdle
CALLI4
ASGNI4
ADDRLP4 16
INDIRI4
CNSTI4 0
NEI4 $687
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 20
ADDRGP4 PM_SaberInParry
CALLI4
ASGNI4
ADDRLP4 20
INDIRI4
CNSTI4 0
NEI4 $687
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 24
ADDRGP4 PM_SaberInReflect
CALLI4
ASGNI4
ADDRLP4 24
INDIRI4
CNSTI4 0
NEI4 $687
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 28
ADDRGP4 BG_SaberInSpecial
CALLI4
ASGNI4
ADDRLP4 28
INDIRI4
CNSTI4 0
NEI4 $687
line 1794
;1793:		 !BG_SaberInIdle( newMove ) && !PM_SaberInParry( newMove ) && !PM_SaberInReflect( newMove ) && !BG_SaberInSpecial(newMove))
;1794:	{//readies, parries and reflections have only 1 level 
line 1796
;1795:		//increment the anim to the next level of saber anims
;1796:		if ( !PM_SaberInTransition( newMove ) )
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 32
ADDRGP4 PM_SaberInTransition
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $689
line 1797
;1797:		{//FIXME: only have level 1 transitions for now
line 1798
;1798:			anim += (pm->ps->fd.saberAnimLevel-FORCE_LEVEL_1) * SABER_ANIM_GROUP_SIZE;
ADDRLP4 36
CNSTI4 77
ASGNI4
ADDRLP4 0
ADDRLP4 0
INDIRI4
ADDRLP4 36
INDIRI4
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 1216
ADDP4
INDIRI4
MULI4
ADDRLP4 36
INDIRI4
SUBI4
ADDI4
ASGNI4
line 1799
;1799:		}
LABELV $689
line 1800
;1800:	}
LABELV $687
line 1803
;1801:
;1802:	// If the move does the same animation as the last one, we need to force a restart...
;1803:	if ( saberMoveData[pm->ps->saberMove].animToUse == anim && newMove > LS_PUTAWAY)
CNSTI4 40
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
MULI4
ADDRGP4 saberMoveData+4
ADDP4
INDIRI4
ADDRLP4 0
INDIRI4
NEI4 $691
ADDRFP4 0
INDIRI2
CVII4 2
CNSTI4 3
LEI4 $691
line 1804
;1804:	{
line 1805
;1805:		setflags |= SETANIM_FLAG_RESTART;
ADDRLP4 4
ADDRLP4 4
INDIRU4
CNSTU4 4
BORU4
ASGNU4
line 1806
;1806:	}
LABELV $691
line 1809
;1807:
;1808:	//saber torso anims should always be highest priority
;1809:	setflags |= SETANIM_FLAG_OVERRIDE;
ADDRLP4 4
ADDRLP4 4
INDIRU4
CNSTU4 1
BORU4
ASGNU4
line 1811
;1810:
;1811:	if ( BG_InSaberStandAnim(anim) || anim == BOTH_STAND1 )
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 32
ADDRGP4 BG_InSaberStandAnim
CALLI4
ASGNI4
ADDRLP4 32
INDIRI4
CNSTI4 0
NEI4 $696
ADDRLP4 0
INDIRI4
CNSTI4 550
NEI4 $694
LABELV $696
line 1812
;1812:	{
line 1813
;1813:		anim = (pm->ps->legsAnim & ~ANIM_TOGGLEBIT);
ADDRLP4 0
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 92
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ASGNI4
line 1815
;1814:
;1815:		if ((anim >= BOTH_STAND1 && anim <= BOTH_STAND4TOATTACK2) ||
ADDRLP4 0
INDIRI4
CNSTI4 550
LTI4 $700
ADDRLP4 0
INDIRI4
CNSTI4 571
LEI4 $699
LABELV $700
ADDRLP4 0
INDIRI4
CNSTI4 954
LTI4 $697
ADDRLP4 0
INDIRI4
CNSTI4 985
GTI4 $697
LABELV $699
line 1817
;1816:			(anim >= TORSO_DROPWEAP1 && anim <= TORSO_WEAPONIDLE12))
;1817:		{ //If standing then use the special saber stand anim
line 1818
;1818:			anim = PM_GetSaberStance();
ADDRLP4 44
ADDRGP4 PM_GetSaberStance
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 44
INDIRI4
ASGNI4
line 1819
;1819:		}
LABELV $697
line 1821
;1820:
;1821:		if (pm->ps->pm_flags & PMF_DUCKED)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 12
ADDP4
INDIRI4
CNSTI4 1
BANDI4
CNSTI4 0
EQI4 $701
line 1822
;1822:		{ //Playing torso walk anims while crouched makes you look like a monkey
line 1823
;1823:			anim = PM_GetSaberStance();
ADDRLP4 44
ADDRGP4 PM_GetSaberStance
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 44
INDIRI4
ASGNI4
line 1824
;1824:		}
LABELV $701
line 1826
;1825:
;1826:		if (anim == BOTH_WALKBACK1 || anim == BOTH_WALKBACK2)		//BOOT walk anims. IMPORTANT!
ADDRLP4 0
INDIRI4
CNSTI4 748
EQI4 $705
ADDRLP4 0
INDIRI4
CNSTI4 749
NEI4 $703
LABELV $705
line 1827
;1827:		{ //normal stance when walking backward so saber doesn't look like it's cutting through leg
line 1828
;1828:			anim = PM_GetSaberStance();
ADDRLP4 48
ADDRGP4 PM_GetSaberStance
CALLI4
ASGNI4
ADDRLP4 0
ADDRLP4 48
INDIRI4
ASGNI4
line 1829
;1829:		}
LABELV $703
line 1831
;1830:
;1831:		if (anim == BOTH_WALK1 || anim == BOTH_WALK2)	//Boot - make walking look cooler
ADDRLP4 0
INDIRI4
CNSTI4 723
EQI4 $708
ADDRLP4 0
INDIRI4
CNSTI4 724
NEI4 $706
LABELV $708
line 1832
;1832:		{
line 1833
;1833:			anim = BOTH_SABERFAST_STANCE;
ADDRLP4 0
CNSTI4 800
ASGNI4
line 1834
;1834:		}
LABELV $706
line 1836
;1835:
;1836:		parts = SETANIM_TORSO;
ADDRLP4 8
CNSTI4 1
ASGNI4
line 1837
;1837:	}
LABELV $694
line 1839
;1838:
;1839:	if ( newMove == LS_A_LUNGE 
ADDRLP4 36
ADDRFP4 0
INDIRI2
CVII4 2
ASGNI4
ADDRLP4 36
INDIRI4
CNSTI4 14
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 15
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 11
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 12
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 13
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 16
EQI4 $716
ADDRLP4 36
INDIRI4
CNSTI4 17
NEI4 $709
LABELV $716
line 1846
;1840:		|| newMove == LS_A_JUMP_T__B_ 
;1841:		|| newMove == LS_A_BACKSTAB
;1842:		|| newMove == LS_A_BACK
;1843:		|| newMove == LS_A_BACK_CR
;1844:		|| newMove == LS_A_FLIP_STAB
;1845:		|| newMove == LS_A_FLIP_SLASH )
;1846:	{
line 1847
;1847:		parts = SETANIM_BOTH;
ADDRLP4 8
CNSTI4 3
ASGNI4
line 1848
;1848:	}
ADDRGP4 $710
JUMPV
LABELV $709
line 1849
;1849:	else if ( BG_SpinningSaberAnim( anim ) )
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 40
ADDRGP4 BG_SpinningSaberAnim
CALLI4
ASGNI4
ADDRLP4 40
INDIRI4
CNSTI4 0
EQI4 $717
line 1850
;1850:	{//spins must be played on entire body
line 1851
;1851:		parts = SETANIM_BOTH;
ADDRLP4 8
CNSTI4 3
ASGNI4
line 1852
;1852:	}
LABELV $717
LABELV $710
line 1854
;1853:
;1854:	PM_SetAnim(parts, anim, setflags|SETANIM_FLAG_HOLD, saberMoveData[newMove].blendTime);
ADDRLP4 8
INDIRI4
ARGI4
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 4
INDIRU4
CNSTU4 2
BORU4
CVUI4 4
ARGI4
CNSTI4 40
ADDRFP4 0
INDIRI2
CVII4 2
MULI4
ADDRGP4 saberMoveData+20
ADDP4
INDIRI4
ARGI4
ADDRGP4 PM_SetAnim
CALLV
pop
line 1856
;1855:
;1856:	if ( (pm->ps->torsoAnim&~ANIM_TOGGLEBIT) == anim )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
INDIRI4
CNSTI4 -2049
BANDI4
ADDRLP4 0
INDIRI4
NEI4 $720
line 1857
;1857:	{//successfully changed anims
line 1860
;1858:	//special check for *starting* a saber swing
;1859:		//playing at attack
;1860:		if ( BG_SaberInAttack( newMove ) || BG_SaberInSpecialAttack( anim ) )
ADDRFP4 0
INDIRI2
CVII4 2
ARGI4
ADDRLP4 44
ADDRGP4 BG_SaberInAttack
CALLI4
ASGNI4
ADDRLP4 44
INDIRI4
CNSTI4 0
NEI4 $724
ADDRLP4 0
INDIRI4
ARGI4
ADDRLP4 48
ADDRGP4 BG_SaberInSpecialAttack
CALLI4
ASGNI4
ADDRLP4 48
INDIRI4
CNSTI4 0
EQI4 $722
LABELV $724
line 1861
;1861:		{
line 1862
;1862:			if ( pm->ps->saberMove != newMove )
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
INDIRI4
ADDRFP4 0
INDIRI2
CVII4 2
EQI4 $725
line 1863
;1863:			{//wasn't playing that attack before
line 1864
;1864:				PM_AddEvent(EV_SABER_ATTACK);
CNSTI4 26
ARGI4
ADDRGP4 PM_AddEvent
CALLV
pop
line 1865
;1865:			}
LABELV $725
line 1866
;1866:		}
LABELV $722
line 1868
;1867:
;1868:		pm->ps->saberMove = newMove;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 512
ADDP4
ADDRFP4 0
INDIRI2
CVII4 2
ASGNI4
line 1869
;1869:		pm->ps->saberBlocking = saberMoveData[newMove].blocking;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 516
ADDP4
CNSTI4 40
ADDRFP4 0
INDIRI2
CVII4 2
MULI4
ADDRGP4 saberMoveData+24
ADDP4
INDIRI4
ASGNI4
line 1871
;1870:
;1871:		pm->ps->torsoAnim = anim;//saberMoveData[newMove].animToUse;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 100
ADDP4
ADDRLP4 0
INDIRI4
ASGNI4
line 1873
;1872:
;1873:		if (pm->ps->weaponTime <= 0)
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 44
ADDP4
INDIRI4
CNSTI4 0
GTI4 $728
line 1874
;1874:		{
line 1875
;1875:			pm->ps->saberBlocked = BLOCKED_NONE;
ADDRGP4 pm
INDIRP4
INDIRP4
CNSTI4 520
ADDP4
CNSTI4 0
ASGNI4
line 1876
;1876:		}
LABELV $728
line 1877
;1877:	}
LABELV $720
line 1878
;1878:}
LABELV $678
endproc PM_SetSaberMove 52 16
import ValidAnimFileIndex
import PM_SetAnim
import PM_FinishWeaponChange
import PM_BeginWeaponChange
import PM_ForceLegsAnim
import PM_ContinueLegsAnim
import PM_StartTorsoAnim
import BG_CycleInven
import PM_StepSlideMove
import PM_SlideMove
import PM_AddEvent
import PM_AddTouchEnt
import PM_ClipVelocity
import PM_GetSaberStance
import PM_AnimLength
import PM_InRollComplete
import PM_InOnGroundAnim
import PM_SpinningAnim
import PM_LandingAnim
import PM_JumpingAnim
import PM_PainAnim
import PM_InKnockDown
import PM_InSaberAnim
import PM_SaberInStart
import PM_SaberInReflect
import PM_SaberInParry
import trap_FS_FCloseFile
import trap_FS_Write
import trap_FS_Read
import trap_FS_FOpenFile
import forcePowerNeeded
import c_pmove
import pm_flightfriction
import pm_waterfriction
import pm_friction
import pm_flyaccelerate
import pm_wateraccelerate
import pm_airaccelerate
import pm_accelerate
import pm_wadeScale
import pm_swimScale
import pm_duckScale
import pm_stopspeed
import pml
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
LABELV $214
char 1 66
char 1 79
char 1 79
char 1 84
char 1 95
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 68
char 1 82
char 1 0
align 1
LABELV $213
char 1 66
char 1 79
char 1 79
char 1 84
char 1 95
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 68
char 1 76
char 1 0
align 1
LABELV $212
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 76
char 1 76
char 1 0
align 1
LABELV $211
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 76
char 1 82
char 1 0
align 1
LABELV $210
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 85
char 1 76
char 1 0
align 1
LABELV $209
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 85
char 1 82
char 1 0
align 1
LABELV $208
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 84
char 1 111
char 1 112
char 1 0
align 1
LABELV $207
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 76
char 1 76
char 1 0
align 1
LABELV $206
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 76
char 1 82
char 1 0
align 1
LABELV $205
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 85
char 1 76
char 1 0
align 1
LABELV $204
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 85
char 1 82
char 1 0
align 1
LABELV $203
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 84
char 1 111
char 1 112
char 1 0
align 1
LABELV $202
char 1 75
char 1 110
char 1 111
char 1 99
char 1 107
char 1 32
char 1 76
char 1 76
char 1 0
align 1
LABELV $201
char 1 75
char 1 110
char 1 111
char 1 99
char 1 107
char 1 32
char 1 76
char 1 82
char 1 0
align 1
LABELV $200
char 1 75
char 1 110
char 1 111
char 1 99
char 1 107
char 1 32
char 1 85
char 1 76
char 1 0
align 1
LABELV $199
char 1 75
char 1 110
char 1 111
char 1 99
char 1 107
char 1 32
char 1 85
char 1 82
char 1 0
align 1
LABELV $198
char 1 75
char 1 110
char 1 111
char 1 99
char 1 107
char 1 32
char 1 84
char 1 111
char 1 112
char 1 0
align 1
LABELV $197
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 76
char 1 76
char 1 0
align 1
LABELV $196
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 66
char 1 111
char 1 116
char 1 0
align 1
LABELV $195
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 76
char 1 82
char 1 0
align 1
LABELV $194
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 85
char 1 76
char 1 0
align 1
LABELV $193
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 85
char 1 82
char 1 0
align 1
LABELV $192
char 1 66
char 1 80
char 1 97
char 1 114
char 1 114
char 1 121
char 1 32
char 1 84
char 1 111
char 1 112
char 1 0
align 1
LABELV $191
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 66
char 1 0
align 1
LABELV $190
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 66
char 1 76
char 1 0
align 1
LABELV $189
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 76
char 1 0
align 1
LABELV $188
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 84
char 1 76
char 1 0
align 1
LABELV $187
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 84
char 1 0
align 1
LABELV $186
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 84
char 1 82
char 1 0
align 1
LABELV $185
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 82
char 1 0
align 1
LABELV $184
char 1 82
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 101
char 1 100
char 1 32
char 1 66
char 1 82
char 1 0
align 1
LABELV $183
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 66
char 1 0
align 1
LABELV $182
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 66
char 1 76
char 1 0
align 1
LABELV $181
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 76
char 1 0
align 1
LABELV $180
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 84
char 1 76
char 1 0
align 1
LABELV $179
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 84
char 1 0
align 1
LABELV $178
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 84
char 1 82
char 1 0
align 1
LABELV $177
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 82
char 1 0
align 1
LABELV $176
char 1 68
char 1 101
char 1 102
char 1 108
char 1 101
char 1 99
char 1 116
char 1 32
char 1 66
char 1 82
char 1 0
align 1
LABELV $175
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 66
char 1 76
char 1 0
align 1
LABELV $174
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 76
char 1 0
align 1
LABELV $173
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 84
char 1 76
char 1 0
align 1
LABELV $172
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 84
char 1 0
align 1
LABELV $171
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 84
char 1 82
char 1 0
align 1
LABELV $170
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 82
char 1 0
align 1
LABELV $169
char 1 66
char 1 111
char 1 117
char 1 110
char 1 99
char 1 101
char 1 32
char 1 66
char 1 82
char 1 0
align 1
LABELV $168
char 1 66
char 1 76
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $167
char 1 66
char 1 76
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $166
char 1 66
char 1 76
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $165
char 1 66
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $164
char 1 66
char 1 76
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $163
char 1 66
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $162
char 1 76
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $161
char 1 76
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $160
char 1 76
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $159
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $158
char 1 76
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $157
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $156
char 1 84
char 1 76
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $155
char 1 84
char 1 76
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $154
char 1 84
char 1 76
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $153
char 1 84
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $152
char 1 84
char 1 76
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $151
char 1 84
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $150
char 1 84
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $149
char 1 84
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $148
char 1 84
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $147
char 1 84
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $146
char 1 84
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $145
char 1 84
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $144
char 1 84
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $143
char 1 84
char 1 82
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $142
char 1 84
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $141
char 1 84
char 1 82
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $140
char 1 84
char 1 82
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $139
char 1 84
char 1 82
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $138
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $137
char 1 82
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $136
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $135
char 1 82
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $134
char 1 82
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $133
char 1 82
char 1 50
char 1 66
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $132
char 1 66
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $131
char 1 66
char 1 82
char 1 50
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $130
char 1 66
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $129
char 1 66
char 1 82
char 1 50
char 1 84
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $128
char 1 66
char 1 82
char 1 50
char 1 84
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $127
char 1 66
char 1 82
char 1 50
char 1 82
char 1 32
char 1 84
char 1 114
char 1 97
char 1 110
char 1 115
char 1 0
align 1
LABELV $126
char 1 84
char 1 50
char 1 66
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $125
char 1 84
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $124
char 1 82
char 1 50
char 1 76
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $123
char 1 66
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $122
char 1 66
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $121
char 1 76
char 1 50
char 1 82
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $120
char 1 84
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 82
char 1 101
char 1 116
char 1 0
align 1
LABELV $119
char 1 84
char 1 50
char 1 66
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $118
char 1 84
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $117
char 1 82
char 1 50
char 1 76
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $116
char 1 66
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $115
char 1 66
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $114
char 1 76
char 1 50
char 1 82
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $113
char 1 84
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 83
char 1 116
char 1 0
align 1
LABELV $112
char 1 70
char 1 108
char 1 105
char 1 112
char 1 32
char 1 83
char 1 108
char 1 97
char 1 115
char 1 104
char 1 0
align 1
LABELV $111
char 1 70
char 1 108
char 1 105
char 1 112
char 1 32
char 1 83
char 1 116
char 1 97
char 1 98
char 1 0
align 1
LABELV $110
char 1 74
char 1 117
char 1 109
char 1 112
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $109
char 1 76
char 1 117
char 1 110
char 1 103
char 1 101
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $108
char 1 67
char 1 82
char 1 32
char 1 66
char 1 97
char 1 99
char 1 107
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $107
char 1 66
char 1 97
char 1 99
char 1 107
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $106
char 1 66
char 1 97
char 1 99
char 1 107
char 1 32
char 1 83
char 1 116
char 1 97
char 1 98
char 1 0
align 1
LABELV $105
char 1 84
char 1 50
char 1 66
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $104
char 1 84
char 1 82
char 1 50
char 1 66
char 1 76
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $103
char 1 82
char 1 50
char 1 76
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $102
char 1 66
char 1 82
char 1 50
char 1 84
char 1 76
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $101
char 1 66
char 1 76
char 1 50
char 1 84
char 1 82
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $100
char 1 76
char 1 50
char 1 82
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $99
char 1 84
char 1 76
char 1 50
char 1 66
char 1 82
char 1 32
char 1 65
char 1 116
char 1 116
char 1 0
align 1
LABELV $98
char 1 80
char 1 117
char 1 116
char 1 97
char 1 119
char 1 97
char 1 121
char 1 0
align 1
LABELV $97
char 1 68
char 1 114
char 1 97
char 1 119
char 1 0
align 1
LABELV $96
char 1 82
char 1 101
char 1 97
char 1 100
char 1 121
char 1 0
align 1
LABELV $95
char 1 78
char 1 111
char 1 110
char 1 101
char 1 0

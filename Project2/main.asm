include Irvine32.inc

;�s�Winc�Mlib�ɡA�ΨӼ��񭵼�
include winmm.inc
includelib winmm.lib	
includelib Kernel32.lib

EXTERN game1@0:PROC
EXTERN stage@0:PROC
EXTERN gamerule@0:PROC

.data 
state BYTE 0							;��ܿ�椤�U�ӿﶵ
boolvalue BYTE 0						;�T�{�O�_����ӿﶵ
InfoCursor CONSOLE_CURSOR_INFO <1,0>
consoleHandle DWORD ?
cellsWritten DWORD ?
bytesWritten DWORD 0
state0 BYTE "START GAME"
state1 BYTE "GAME RULES"
state2 BYTE "SETTINGS"
state3 BYTE "EXIT"
volume1 BYTE "Volume: <            >"
volume2 BYTE "�p�p�p�p�p�p�p�p�p�p"	
volLen DWORD 20
tomenu BYTE "(Press enter to return the menu)"

settingstitle1 BYTE "  �p�p�p�p�p   �p�p�p�p�p�p�p  �p�p�p�p�p�p   �p�p�p�p�p�p    �p�p�p�p    �p�p   �p�p    �p�p�p�p    �p�p�p�p�p "
settingstitle2 BYTE " �p�p   �p�p   �p�p   �p  �p �p�p �p   �p �p�p �p     �p�p     �p�p�p  �p�p   �p�p  �p�p  �p�p   �p�p           "
settingstitle3 BYTE " �p         �p�p �p      �p�p       �p�p       �p�p     �p�p�p�p �p�p  �p�p       �p                            "
settingstitle4 BYTE "  �p�p�p�p�p    �p�p�p�p      �p�p       �p�p       �p�p     �p�p �p�p�p�p  �p�p        �p�p�p�p�p              "
settingstitle5 BYTE "      �p�p   �p�p �p      �p�p       �p�p       �p�p     �p�p  �p�p�p  �p�p  �p�p�p       �p�p                  "
settingstitle6 BYTE " �p�p   �p�p   �p�p   �p    �p�p       �p�p       �p�p     �p�p   �p�p   �p�p  �p�p  �p�p   �p�p                "
settingstitle7 BYTE "  �p�p�p�p�p   �p�p�p�p�p�p�p   �p�p�p�p     �p�p�p�p     �p�p�p�p    �p�p   �p�p    �p�p�p�p�p   �p�p�p�p�p    "

settingsPos1 COORD <24,3>
settingsPos2 COORD <24,4>
settingsPos3 COORD <24,5>
settingsPos4 COORD <24,6>
settingsPos5 COORD <24,7>
settingsPos6 COORD <24,8>
settingsPos7 COORD <24,9>


startgamePos COORD <54,16>
gamerulePos COORD <54,19>
settingsPos COORD <55,22>
exitPos COORD <57,25>
volume1Pos COORD <50,16>
volume2Pos COORD <60,16>
tomenuPos COORD <45,25>

color_pink WORD 10 DUP(0Ch)
color_yellow WORD 10 DUP(06h)
color_lyellow WORD 10 DUP(0EEh)	;�L����
color_red WORD 10 DUP(44h)
color_volume WORD 10 DUP(06h)	;���q�վ�Ϯ��C��

P1pos1 COORD <23,3>
P1pos2 COORD <24,3>
P1pos3 COORD <24,6>
P1pos4 COORD <29,4>
O1pos1 COORD <32,4>
O1pos2 COORD <33,3>
O1pos3 COORD <33,9>
O1pos4 COORD <38,4>
P2pos1 COORD <41,3>
P2pos2 COORD <42,3>
P2pos3 COORD <42,6>
P2pos4 COORD <47,4>
Cpos1 COORD <50,4>
Cpos2 COORD <51,3>
Cpos3 COORD <51,9>
O2pos1 COORD <62,3>
O2pos2 COORD <60,4>
O2pos3 COORD <59,5>
O2pos4 COORD <59,6>
O2pos5 COORD <60,7>
O2pos6 COORD <64,7>
O2pos7 COORD <61,9>
Npos1 COORD <68,3>
Npos2 COORD <69,4>
Npos3 COORD <74,3>
Epos1 COORD <77,4>
Epos2 COORD <78,3>
Epos3 COORD	<78,6>
Epos4 COORD <78,9>
Spos1 COORD <86,4>
Spos2 COORD <87,3>
Spos3 COORD <87,6>
Spos4 COORD <86,9>
Spos5 COORD <92,7>

;�Ω�ø�s���D
O BYTE "O"
l BYTE "l"

;�Ω�playsoundA���ѼơA�W�d���֪�����Ҧ�
SND_ASYNC DWORD 0001h			;�P�B����A�禡�|�����񧹫ạ�^
SND_LOOP DWORD 0008h			;�`������
SND_NOSTOP DWORD 20011h			;�ثe�����ּ���ɡA���|���_�ثe������
SND_LOOP_ASYNC DWORD 0009h		;�P�B + �`������

;����(�ϥά۹���|�A�ɮש�m��Pexe�ɦP�Ӧ�m)
button_swtich BYTE "button_switch.wav",0	
button_choose BYTE "button_choose.wav",0	

;���q�j�p
music_volume DWORD 0FFFFh		;�w�]��l���̤j����

;�Ω�mcisendstring���ѼơA�W�d���֪�����Ҧ�
;�I������(�ϥε����m�A�ɮש�m��C��)

menu_cd BYTE "open C:\asm_music_project\menu.wav type waveaudio alias menu_music", 0		;���}���ɪ����O�A�N���ɦW�ٳ]�m��menu_music
playmenu_cd BYTE "play menu_music", 0														;�����ɪ����O
stopmenu_cd BYTE "stop menu_music", 0														;�Ȱ����ɪ����O
closemenu_cd BYTE "close menu_music", 0														;�������ɪ����O
statusmenu_cd BYTE "status menu_music mode", 0												;�ˬd���ɪ��A�����O

buffer BYTE 128 dup(0)				;�w�İϥΩ󱵦���ƪ���^��T(���O���浲�G)
statusBuffer BYTE 128 dup(0)		;���A�w�İϥΩ󱵦���ƪ���^��T(���񪬺A)

.code 

;������e����s�W�v
delayer3E PROC
	push ecx
	mov ecx, 300000000
L1:
	loop L1
	pop ecx
	ret
delayer3E ENDP

;����]�w�e����s�W�v
delayer5kw PROC
	push ecx
	mov ecx, 50000000
L1:
	loop L1
	pop ecx
	ret
delayer5kw ENDP

;�]�m���֤j�p
setVolume PROC	;�̤j���q 0FFFFh	�̤p���q00000h
	INVOKE waveOutSetVolume, NULL, music_volume

	ret
setVolume ENDP

;�]�m���I������
playmusic_m PROC USES eax ecx edx	
	invoke mciSendString, addr menu_cd, addr buffer, sizeof buffer, 0			;�}�ҭ���
	invoke mciSendString, addr playmenu_cd, addr buffer, sizeof buffer, 0		;������

	ret
playmusic_m ENDP

;����I�����ּ��񧹲���A���s�A���@��
checkmusic_m PROC USES eax ecx edx	
	invoke mciSendString, addr statusmenu_cd, addr statusBuffer, sizeof statusBuffer, 0		;�o�쭵�֥ثe���A

	push ebx
	mov bl,[statusBuffer]		;�N���A���Ĥ@�Ӧr���bl�����
	cmp bl, 'p'					;�Y��p�A�h�N�����٦b����A����still_play (p = playing)
	je still_play
	
	invoke mciSendString, addr closemenu_cd, addr buffer, sizeof buffer, 0		;�n���N��e����������A�I�s���񭵼�
	CALL playmusic_m															;�I�s����I������

	still_play:

	pop ebx

	ret
checkmusic_m ENDP

;���s���ʭ���
playmusic_s PROC USES eax ecx edx			
	INVOKE PlaySoundA, OFFSET button_swtich, NULL, SND_ASYNC

	ret
playmusic_s ENDP

;���s��ܭ���
playmusic_c PROC USES eax ecx edx
	INVOKE PlaySoundA, OFFSET button_choose, NULL, SND_ASYNC

	ret
playmusic_c ENDP

;�ھ���L��J�A���ܿ�ܿﶵ
keyinput PROC

	.IF ax == 4800h
		.IF state >= 1			;��V��U
			CALL playmusic_s	;���񲾰ʭ���
			sub state,1
		.ENDIF
	.ENDIF
	.IF ax == 5000h				;��V��W
		.IF state <= 2
			CALL playmusic_s	;���񲾰ʭ���
			add state, 1
		.ENDIF
	.ENDIF
	.IF ax == 1C0Dh				;���UEnter��
		CALL playmusic_c		;�����ܭ���
		mov boolvalue, 1
	.ENDIF
keyinput ENDP


main PROC 
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR InfoCursor

	;�]�m���֪�l�j�p�ü���I������
	CALL setVolume	
    CALL playmusic_m
    
MENU:
	call ClrScr
	CALL checkmusic_m		;�ˬd�I�����֪��A�ô`�����񭵼�

	;�̨C�@���eø�s���DPOPCONES
	mov ecx, 7
	drawP11:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P1pos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P1pos1, ADDR cellsWritten
		add P1pos1.y, 1
		pop ecx
		loop drawP11
		sub P1pos1.y, 7
	mov ecx, 5
	drawP12:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P1pos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P1pos2, ADDR cellsWritten
		add P1pos2.x, 1
		pop ecx
		loop drawP12
		sub P1pos2.x, 5
	mov ecx, 5
	drawP13:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P1pos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P1pos3, ADDR cellsWritten
		add P1pos3.x, 1
		pop ecx
		loop drawP13
		sub P1pos3.x, 5
	mov ecx, 2
	drawP14:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P1pos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P1pos4, ADDR cellsWritten
		add P1pos4.y, 1
		pop ecx
		loop drawP14
		sub P1pos4.y, 2
	mov ecx, 5
	drawO11:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, O1pos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O1pos1, ADDR cellsWritten
		add O1pos1.y, 1
		pop ecx
		loop drawO11
		sub O1pos1.y, 5
	mov ecx, 5
	drawO12:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, O1pos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O1pos2, ADDR cellsWritten
		add O1pos2.x, 1
		pop ecx
		loop drawO12
		sub O1pos2.x, 5
	mov ecx, 5
	drawO13:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, O1pos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O1pos3, ADDR cellsWritten
		add O1pos3.x, 1
		pop ecx
		loop drawO13
		sub O1pos3.x, 5
	mov ecx, 5
	drawO14:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, O1pos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O1pos4, ADDR cellsWritten
		add O1pos4.y, 1
		pop ecx
		loop drawO14
		sub O1pos4.y, 5
	mov ecx, 7
	drawP21:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P2pos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P2pos1, ADDR cellsWritten
		add P2pos1.y, 1
		pop ecx
		loop drawP21
		sub P2pos1.y, 7
	mov ecx, 5
	drawP22:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P2pos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P2pos2, ADDR cellsWritten
		add P2pos2.x, 1
		pop ecx
		loop drawP22
		sub P2pos2.x, 5
	mov ecx, 5
	drawP23:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P2pos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P2pos3, ADDR cellsWritten
		add P2pos3.x, 1
		pop ecx
		loop drawP23
		sub P2pos3.x, 5
	mov ecx, 2
	drawP24:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_lyellow, 1, P2pos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, P2pos4, ADDR cellsWritten
		add P2pos4.y, 1
		pop ecx
		loop drawP24
		sub P2pos4.y, 2
	mov ecx, 5
	drawC1:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Cpos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Cpos1, ADDR cellsWritten
		add Cpos1.y, 1
		pop ecx
		loop drawC1
		sub Cpos1.y, 5
	mov ecx, 6
	drawC2:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Cpos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Cpos2, ADDR cellsWritten
		add Cpos2.x, 1
		pop ecx
		loop drawC2
		sub Cpos2.x, 6
	mov ecx, 6
	drawC3:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Cpos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Cpos3, ADDR cellsWritten
		add Cpos3.x, 1
		pop ecx
		loop drawC3
		sub Cpos3.x, 6
	mov ecx, 1
	drawO21:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR l, 1, O2pos1, ADDR cellsWritten
		add O2pos1.y, 1
		pop ecx
		loop drawO21
		sub O2pos1.y, 1
	mov ecx, 5
	drawO22:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos2, ADDR cellsWritten
		add O2pos2.x, 1
		pop ecx
		loop drawO22
		sub O2pos2.x, 5
	mov ecx, 7
	drawO23:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos3, ADDR cellsWritten
		add O2pos3.x, 1
		pop ecx
		loop drawO23
		sub O2pos3.x, 7
	mov ecx, 7
	drawO24:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos4, ADDR cellsWritten
		add O2pos4.x, 1
		pop ecx
		loop drawO24
		sub O2pos4.x, 7
	mov ecx, 2
	drawO25:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos5, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos5, ADDR cellsWritten
		add O2pos5.y, 1
		pop ecx
		loop drawO25
		sub O2pos5.y, 2
	mov ecx, 2
	drawO26:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos6, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos6, ADDR cellsWritten
		add O2pos6.y, 1
		pop ecx
		loop drawO26
		sub O2pos6.y, 2
	mov ecx, 3
	drawO27:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_yellow, 1, O2pos7, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, O2pos7, ADDR cellsWritten
		add O2pos7.x, 1
		pop ecx
		loop drawO27
		sub O2pos7.x, 3
	mov ecx, 7
	drawN1:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Npos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Npos1, ADDR cellsWritten
		add Npos1.y, 1
		pop ecx
		loop drawN1
		sub Npos1.y, 7
	mov ecx, 5
	drawN2:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Npos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Npos2, ADDR cellsWritten
		add Npos2.y, 1
		add Npos2.x, 1
		pop ecx
		loop drawN2
		sub Npos2.y, 5
		sub Npos2.x, 5
	mov ecx, 7
	drawN3:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Npos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Npos3, ADDR cellsWritten
		add Npos3.y, 1
		pop ecx
		loop drawN3
		sub Npos3.y, 7
	mov ecx, 5
	drawE1:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Epos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Epos1, ADDR cellsWritten
		add Epos1.y, 1
		pop ecx
		loop drawE1
		sub Epos1.y, 5
	mov ecx, 6
	drawE2:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Epos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Epos2, ADDR cellsWritten
		add Epos2.x, 1
		pop ecx
		loop drawE2
		sub Epos2.x, 6
	mov ecx, 6
	drawE3:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Epos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Epos3, ADDR cellsWritten
		add Epos3.x, 1
		pop ecx
		loop drawE3
		sub Epos3.x, 6
	mov ecx, 6
	drawE4:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Epos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Epos4, ADDR cellsWritten
		add Epos4.x, 1
		pop ecx
		loop drawE4
		sub Epos4.x, 6
	mov ecx, 2
	drawS1:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Spos1, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Spos1, ADDR cellsWritten
		add Spos1.y, 1
		pop ecx
		loop drawS1
		sub Spos1.y, 2
	mov ecx, 6
	drawS2:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Spos2, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Spos2, ADDR cellsWritten
		add Spos2.x, 1
		pop ecx
		loop drawS2
		sub Spos2.x, 6
	mov ecx, 5
	drawS3:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Spos3, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Spos3, ADDR cellsWritten
		add Spos3.x, 1
		pop ecx
		loop drawS3
		sub Spos3.x, 5
	mov ecx, 6
	drawS4:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Spos4, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Spos4, ADDR cellsWritten
		add Spos4.x, 1
		pop ecx
		loop drawS4
		sub Spos4.x, 6
	mov ecx, 2
	drawS5:
		push ecx
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_red, 1, Spos5, ADDR bytesWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR O, 1, Spos5, ADDR cellsWritten
		add Spos5.y, 1
		pop ecx
		loop drawS5
		sub Spos5.y, 2

	;�N��e����ﶵ��r�אּ����
	.IF state == 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_pink, 10, startgamePos, ADDR bytesWritten
	.ENDIF
	.IF state == 1
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_pink, 10, gamerulePos, ADDR bytesWritten
	.ENDIF
	.IF state == 2
        INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_pink, 8, settingsPos, ADDR bytesWritten
    .ENDIF
	.IF state == 3
        INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_pink, 4, exitPos, ADDR bytesWritten
    .ENDIF

	;ø�s�ﶵ��r
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state0, 10, startgamePos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state1, 10, gamerulePos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state2, 8, settingsPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR state3, 4, exitPos, ADDR cellsWritten

	call delayer3E

	;�ھڿ�����ﶵ���ܤ��PLabel
	.IF boolvalue == 1
		.IF state == 0
			jmp stage
		.ENDIF
		.IF state == 1
			jmp gamerule
		.ENDIF
		.IF state == 2
			jmp setting
		.ENDIF
		.IF state == 3
			INVOKE ExitProcess, 0
		.ENDIF
	.ENDIF

    call Readkey
	jnz L_m
	jmp MENU

;�p�GReadkeyŪ������L��J�hcall keyinput
L_m:
	call keyinput
	jmp MENU

;�Ω�call game1.asm
game1:
	mov boolvalue, 0
    call game1@0
	jmp menu

;�Ω�call levelstage.asm
stage:
	mov boolvalue, 0
	INVOKE mciSendString, addr closemenu_cd, addr buffer, sizeof buffer, 0		;���}�ɭ��������I������
    call stage@0
	jmp menu

;�Ψ�call gamerule.asm
gamerule:
	mov boolvalue, 0
    call gamerule@0
	jmp menu

setting:
	CALL checkmusic_m		;�ˬd���֬O�_���񧹲�
	call ClrScr

	;ø�s���D��r�ϼ�
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle1, 112, settingsPos1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle2, 112, settingsPos2, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle3, 112, settingsPos3, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle4, 112, settingsPos4, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle5, 112, settingsPos5, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle6, 112, settingsPos6, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR settingstitle7, 112, settingsPos7, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR volume1, 22, volume1Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR volume2, volLen, volume2Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR tomenu, 32, tomenuPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR color_volume, 10, volume2Pos, ADDR bytesWritten

	call delayer5kw
	call Readkey
	jnz L_s
	jmp setting

	;�Y��������L��J
	L_s:
		.IF ax == 4D00h					;��V��k
			.IF volLen < 20
				add volLen, 2
				;�W�j���q
				add music_volume,1999h

				CALL setVolume	
				
			.ENDIF
		.ENDIF
		.IF ax == 4B00h					;��V�䥪
			.IF volLen >= 1
				sub volLen, 2
				;��p���q
				sub music_volume,1999h

				CALL setVolume	
			.ENDIF
		.ENDIF
		.IF ax == 1C0Dh					;���UEnter��
			mov boolvalue, 0
			jmp MENU
		.ENDIF
		jmp setting
    exit

main ENDP 
END main

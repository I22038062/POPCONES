include Irvine32.inc

;�s�Winc�Mlib�ɡA�ΨӼ��񭵼�
include winmm.inc
includelib winmm.lib	
includelib Kernel32.lib

EXTERN main@0:PROC
EXTERN game1@0:PROC
EXTERN levelNum:BYTE
.data
consoleHandle DWORD ?
cellsWritten DWORD ?
bytesWritten DWORD 0
CursorInfo CONSOLE_CURSOR_INFO <1,0>

boolEnd BYTE 0		;0:keep,1:end

;���d1�w����
stage1row1 BYTE "      ------------------------------------------------------------------------------------------------------------      "
stage1row2 BYTE "      |                                                                                                          |      "
stage1row3 BYTE "      |                                                                                                          |      "
stage1row4 BYTE "      |                                                                                                          |      "
stage1row5 BYTE "      |                                                                                                          |      "
stage1row6 BYTE "      |                                                          OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |      "
stage1row7 BYTE "      |                                                          OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |      "
stage1row8 BYTE "      |                                                          OOOOOOOOO   OOO    OOO    OO    OO   OOOOOOOO   |      "
stage1row9 BYTE "      |                                                          OOOOOOOO OOOOOO OOO OO OOOOO OOOOO OO OOOOOOO   |      "
stage1row10 BYTE "      |                                                          OOOOOOOOO   OOO    OOO   OOO   OOO OO OOOOOOO   |      "
stage1row11 BYTE "      |                                                          OOOOOOOOOOOO OO OOOOOO OOOOO OOOOO OO OOOOOOO   |      "
stage1row12 BYTE "      |           |\=.                                           OOOOOOOO    OOO OOOOOO    OO    OO   OOOOOOO0   |      "
stage1row13 BYTE "      |           /  6',                                         OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |      "
stage1row14 BYTE "      |   .--.    \  .-'                                         OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |   >  "
stage1row15 BYTE "      |  /_   \   /  (                                           OOOOO                                   OOOOO   |      "
stage1row16 BYTE "      |    )   | / `;\\                                          OOOOO         OOOOOOO  OOOOOOOO         OOOOO   |      "
stage1row17 BYTE "      |   /   / /   ( ``                                         OOOOO        OO     OO OO               OOOOO   |      "
stage1row18 BYTE "      |  (    `'    _)_                                          OOOOO               OO OO               OOOOO   |      "
stage1row19 BYTE "      |   `-==-'`""""""`                                            OOOOO         OOOOOOO  OOOOOOO          OOOOO   |   "
stage1row20 BYTE "      |                                                          OOOOO        OO              OO         OOOOO   |      "
stage1row21 BYTE "      |                                                          OOOOO        OO        OO    OO         OOOOO   |      "
stage1row22 BYTE "      |                                                          OOOOO        OOOOOOOOO  OOOOOO          OOOOO   |      "
stage1row23 BYTE "      |                                                          OOOOO                                   OOOOO   |      "
stage1row24 BYTE "      |                                                          OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |      "
stage1row25 BYTE "      |                                                          OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO   |      "
stage1row26 BYTE "      |                                                                                                          |      "
stage1row27 BYTE "      ------------------------------------------------------------------------------------------------------------      "
stage1row28 BYTE "                                                                                                                        "
stage1row29 BYTE "                                                        STAGE 1                                                         "
stage1row30 BYTE "                                                                                                                        "

stage1row1Pos COORD <0,0>
stage1row2Pos COORD <0,1>
stage1row3Pos COORD <0,2>
stage1row4Pos COORD <0,3>
stage1row5Pos COORD <0,4>
stage1row6Pos COORD <0,5>
stage1row7Pos COORD <0,6>
stage1row8Pos COORD <0,7>
stage1row9Pos COORD <0,8>
stage1row10Pos COORD <0,9>
stage1row11Pos COORD <0,10>
stage1row12Pos COORD <0,11>
stage1row13Pos COORD <0,12>
stage1row14Pos COORD <0,13>
stage1row15Pos COORD <0,14>
stage1row16Pos COORD <0,15>
stage1row17Pos COORD <0,16>
stage1row18Pos COORD <0,17>
stage1row19Pos COORD <0,18>
stage1row20Pos COORD <0,19>
stage1row21Pos COORD <0,20>
stage1row22Pos COORD <0,21>
stage1row23Pos COORD <0,22>
stage1row24Pos COORD <0,23>
stage1row25Pos COORD <0,24>
stage1row26Pos COORD <0,25>
stage1row27Pos COORD <0,26>
stage1row28Pos COORD <0,27>
stage1row29Pos COORD <0,28>
stage1row30Pos COORD <0,29>

;���d2�w����
stage2row1 BYTE "      ------------------------------------------------------------------------------------------------------------      "
stage2row2 BYTE "      |                                                          .OOOOOOOOOOOOO.                                 |      "
stage2row3 BYTE "      |                                                       .OOOOOOOOOOOOOOOOOOO.                              |      "
stage2row4 BYTE "      |                                                    .OOOOOOOOOOOOOOOOOOOOOOOOO.                           |      "
stage2row5 BYTE "      |                                                   .OOOOOOOOOOOOOOOOOOOOOOOOOOO.                          |      "
stage2row6 BYTE "      |                                                  .OOOOOOOOOOOOOOOOOOOOOOOOOOOOO.                         |      "
stage2row7 BYTE "      |                                                  .OOOOOOOOOOOOOO!OOOOOOOOOOOOOO.                         |      "
stage2row8 BYTE "      |                                                   OOOOOOOOOOOOOOOOOOOOOOOOOOOOO                          |      "
stage2row9 BYTE "      |                                                   OOOOOOOOOOOOOOOOOOOOOOOOOOOOO                          |      "
stage2row10 BYTE "      |                                                   `OOOOOOOOOOOOOOOOOOOOOOOOOOO                           |      "
stage2row11 BYTE "      |                                                     `OOOOOOOOOOOOOOOOOOOOOOO'                            |      "
stage2row12 BYTE "      |           |\=.                                        `OOOOOOOOOOOOOOOOOO'  OOOOOOOOOOOO,                |      "
stage2row13 BYTE "      |           /  6',                                         `OOOOOOOOOOOOO'.OOOOOOOOOOOOOOOOOO,             |      "
stage2row14 BYTE "  <   |   .--.    \  .-'                                           `OOOOOOOOO'OOOOOOOOOOOOOOOOOOOOOOOO,          |      "
stage2row15 BYTE "      |  /_   \   /  (                                               `OOOOO'.OOOOOOOOOOOOOOOOOOOOOOOOOO,         |      "
stage2row16 BYTE "      |    )   | / `;\\                                                `OO' OOOOOOOOOOOOOOOOOOOOOOOOOOOO         |      "
stage2row17 BYTE "      |   /   / /   ( ``                                               OOO  OOOOOOOOOOOOOO!OOOOOOOOOOOOO         |      "
stage2row18 BYTE "      |  (    `'    _)_                                                 '   OOOOOOOOOOOOOOOOOOOOOOOOOOOO         |      "
stage2row19 BYTE "      |   `-==-'`""""""`                                                  '    `OOOOOOOOOOOOOOOOOOOOOOOOOO'         |   "
stage2row20 BYTE "      |                                                               '       `OOOOOOOOOOOOOOOOOOOOOO'           |      "
stage2row21 BYTE "      |                                                               `         `OOOOOOOOOOOOOOOOOO'             |      "
stage2row22 BYTE "      |                                                                `          `OOOOOOOOOOOOOO'               |      "
stage2row23 BYTE "      |                                                                  `           `OOOOOOOOOO'                |      "
stage2row24 BYTE "      |                                                                   '            `OOOOOO'                  |      "
stage2row25 BYTE "      |                                                                  '              `OOO'                    |      "
stage2row26 BYTE "      |                                                                                 .OO                      |      "
stage2row27 BYTE "      ------------------------------------------------------------------------------------------------------------      "
stage2row28 BYTE "                                                                                                                        "
stage2row29 BYTE "                                                        STAGE 2                                                         "
stage2row30 BYTE "                                                                                                                        "

stage2row1Pos COORD <120,0>
stage2row2Pos COORD <120,1>
stage2row3Pos COORD <120,2>
stage2row4Pos COORD <120,3>
stage2row5Pos COORD <120,4>
stage2row6Pos COORD <120,5>
stage2row7Pos COORD <120,6>
stage2row8Pos COORD <120,7>
stage2row9Pos COORD <120,8>
stage2row10Pos COORD <120,9>
stage2row11Pos COORD <120,10>
stage2row12Pos COORD <120,11>
stage2row13Pos COORD <120,12>
stage2row14Pos COORD <120,13>
stage2row15Pos COORD <120,14>
stage2row16Pos COORD <120,15>
stage2row17Pos COORD <120,16>
stage2row18Pos COORD <120,17>
stage2row19Pos COORD <120,18>
stage2row20Pos COORD <120,19>
stage2row21Pos COORD <120,20>
stage2row22Pos COORD <120,21>
stage2row23Pos COORD <120,22>
stage2row24Pos COORD <120,23>
stage2row25Pos COORD <120,24>
stage2row26Pos COORD <120,25>
stage2row27Pos COORD <120,26>
stage2row28Pos COORD <120,27>
stage2row29Pos COORD <120,28>
stage2row30Pos COORD <120,29>


;�Ω�ø�s�����ʵe
stage1rowLength BYTE 0
stage2rowLength BYTE 0
stage1rowOffset DWORD 120	;�O�����}�����q

selectbool BYTE 0	;�Ω�P�_�O�_ø�s�����ʵe
selectstage BYTE 1	;��ܪ����d

;�Ω�playsoundA���ѼơA�W�d���֪�����Ҧ�
SND_ASYNC DWORD 0001h			;�P�B����A�禡�|�����񧹫ạ�^
SND_LOOP DWORD 0008h			;�`������
SND_NOSTOP DWORD 20011h			;�ثe�����ּ���ɡA���|���_�ثe������
SND_LOOP_ASYNC DWORD 0009h		;�P�B + �`������

;����(�ϥά۹���|�A�ɮש�m��Pexe�ɦP�Ӧ�m)
level_switch BYTE "level_switch.wav",0
level_choose BYTE "level_choose.wav",0

;�Ω�mcisendstring���ѼơA�W�d���֪�����Ҧ�
;�I������(�ϥε����m�A�ɮש�m��C��)
stage_cd BYTE "open C:\asm_music_project\menu.wav type waveaudio alias stage_music", 0		;���}���ɪ����O�A�N���ɦW�ٳ]�m��stage_music
playstage_cd BYTE "play stage_music", 0														;�����ɪ����O
stopstage_cd BYTE "stop stage_music", 0														;�Ȱ����ɪ����O
closestage_cd BYTE "close stage_music", 0													;�������ɪ����O
statusstage_cd BYTE "status stage_music mode", 0											;�ˬd���ɪ��A�����O

buffer BYTE 128 dup(0)					;�w�İϥΩ󱵦���ƪ���^��T(���O���浲�G)
statusBuffer BYTE 128 dup(0)			;���A�w�İϥΩ󱵦���ƪ���^��T(���񪬺A)

.code

;��������ʵe��s�W�v
delayer1 PROC
	push ecx
	mov ecx, 5000000
L1:
	loop L1
	pop ecx
	ret
delayer1 ENDP

;�]�m�I������
playmusic_stage PROC USES eax ecx edx	
	invoke mciSendString, addr stage_cd, addr buffer, sizeof buffer, 0
	invoke mciSendString, addr playstage_cd, addr buffer, sizeof buffer, 0

	ret
playmusic_stage ENDP

;��I�����ּ��񧹲���A���s�A���@��
checkmusic_stage PROC USES eax ecx edx	
	invoke mciSendString, addr statusstage_cd, addr statusBuffer, sizeof statusBuffer, 0		;�o�쭵�֥ثe���A

	push ebx

	mov bl ,[statusBuffer]			;�N���A���Ĥ@�Ӧr���bl�����
    cmp bl, 'p'						;�Y��p�A�h�N�����٦b����A����still_play (p = playing)
	je still_play
	
	invoke mciSendString, addr closestage_cd, addr buffer, sizeof buffer, 0			;�n���N��e����������A�I�s���񭵼�
	CALL playmusic_stage															;�I�s����I������

	still_play:

	pop ebx

	ret
checkmusic_stage ENDP

;�]�m�������d����
playmusic_switchlevel PROC USES eax ecx edx	
	INVOKE PlaySoundA, OFFSET level_switch, NULL, SND_ASYNC
	
	ret
playmusic_switchlevel ENDP

;�]�m������d����
playmusic_chooselevel PROC PROC USES eax ecx edx
	INVOKE PlaySoundA, OFFSET level_choose, NULL, SND_ASYNC

	ret
playmusic_chooselevel ENDP

select PROC
	.IF ax == 4D00h							;���k��V��
		.IF selectstage == 1				;�Y�{�b�����d1
			call playmusic_switchlevel		;����������d����
			add selectstage, 1				;���������d2
			mov selectbool, 1
		.ENDIF
	.ENDIF
	.IF ax == 4B00h							;������V��
		.IF selectstage == 2				;�Y�{�b�����d2
			call playmusic_switchlevel		;����������d����
			sub selectstage, 1				;���������d1
			mov selectbool, 1
		.ENDIF
	.ENDIF
	.IF ax == 011Bh							;��ESC��
		mov selectstage, 1
		mov boolEnd, 1						
	.ENDIF
	.IF ax == 1C0Dh							;��Enter��
		INVOKE mciSendString, addr closestage_cd, addr buffer, sizeof buffer, 0
		call playmusic_chooselevel			;���������d����
		.IF selectstage == 1				;�Y������d1
			mov levelNum, 1
			call game1@0
			mov boolEnd, 1
		.ENDIF
		.IF selectstage == 2				;�Y������d2
			mov levelNum, 2
			call game1@0
			mov boolEnd, 1
		.ENDIF
	.ENDIF
	ret
select ENDP

stage PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR CursorInfo

	mov boolEnd, 0	;not the end
	mov levelNum, 1 ;��l�Ĥ@��
	mov selectstage, 1
	mov selectbool, 0

	call Clrscr
	call playmusic_stage	;����I������

	;ø�s���d1�w����
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row1, 120, stage1row1Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row2, 120, stage1row2Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row3, 120, stage1row3Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row4, 120, stage1row4Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row5, 120, stage1row5Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row6, 120, stage1row6Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row7, 120, stage1row7Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row8, 120, stage1row8Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row9, 120, stage1row9Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row10, 120, stage1row10Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row11, 120, stage1row11Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row12, 120, stage1row12Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row13, 120, stage1row13Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row14, 120, stage1row14Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row15, 120, stage1row15Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row16, 120, stage1row16Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row17, 120, stage1row17Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row18, 120, stage1row18Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row19, 120, stage1row19Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row20, 120, stage1row20Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row21, 120, stage1row21Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row22, 120, stage1row22Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row23, 120, stage1row23Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row24, 120, stage1row24Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row25, 120, stage1row25Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row26, 120, stage1row26Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row27, 120, stage1row27Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row28, 120, stage1row28Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row29, 120, stage1row29Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage1row30, 120, stage1row30Pos, ADDR cellsWritten


START:
	CALL checkmusic_stage			;�ˬd�I�����֪��A�ô`�����񭵼�
	.IF boolEnd == 1
		jmp endStage
	.ENDIF
	
	.IF selectbool == 1
		.IF selectstage == 1	;�Y������d1
			mov selectbool, 0
			jmp drawStage1
		.ENDIF
		.IF selectstage == 2	;�Y������d2
			mov selectbool, 0
			jmp drawStage2
		.ENDIF
	.ENDIF

	call Readkey
	call select
	
	jmp START

;ø�s�q���d2�����d1
drawStage1:
	.IF stage1rowLength <= 120

		;��row�q�̫�@��}�l���e�e�A�åB�v���k���A�F��Ϯױq�����k�������ĪG
		sub stage1rowOffset, 1		;�����q��1
		add stage1rowLength, 1		;���ץ[1
		lea ebx, stage1row1			;ebx�s��row���O�����}
		add ebx, stage1rowOffset	;�[�W�����q
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row1Pos, ADDR cellsWritten
		lea ebx, stage1row2
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row2Pos, ADDR cellsWritten
		lea ebx, stage1row3
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row3Pos, ADDR cellsWritten
		lea ebx, stage1row4
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row4Pos, ADDR cellsWritten
		lea ebx, stage1row5
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row5Pos, ADDR cellsWritten
		lea ebx, stage1row6
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row6Pos, ADDR cellsWritten
		lea ebx, stage1row7
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row7Pos, ADDR cellsWritten
		lea ebx, stage1row8
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row8Pos, ADDR cellsWritten
		lea ebx, stage1row9
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row9Pos, ADDR cellsWritten
		lea ebx, stage1row10
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row10Pos, ADDR cellsWritten
		lea ebx, stage1row11
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row11Pos, ADDR cellsWritten
		lea ebx, stage1row12
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row12Pos, ADDR cellsWritten
		lea ebx, stage1row13
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row13Pos, ADDR cellsWritten
		lea ebx, stage1row14
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row14Pos, ADDR cellsWritten
		lea ebx, stage1row15
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row15Pos, ADDR cellsWritten
		lea ebx, stage1row16
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row16Pos, ADDR cellsWritten
		lea ebx, stage1row17
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row17Pos, ADDR cellsWritten
		lea ebx, stage1row18
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row18Pos, ADDR cellsWritten
		lea ebx, stage1row19
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row19Pos, ADDR cellsWritten
		lea ebx, stage1row20
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row20Pos, ADDR cellsWritten
		lea ebx, stage1row21
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row21Pos, ADDR cellsWritten
		lea ebx, stage1row22
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row22Pos, ADDR cellsWritten
		lea ebx, stage1row23
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row23Pos, ADDR cellsWritten
		lea ebx, stage1row24
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row24Pos, ADDR cellsWritten
		lea ebx, stage1row25
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row25Pos, ADDR cellsWritten
		lea ebx, stage1row26
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row26Pos, ADDR cellsWritten
		lea ebx, stage1row27
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row27Pos, ADDR cellsWritten
		lea ebx, stage1row28
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row28Pos, ADDR cellsWritten
		lea ebx, stage1row29
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row29Pos, ADDR cellsWritten
		lea ebx, stage1row30
		add ebx, stage1rowOffset
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ebx, stage1rowLength, stage1row30Pos, ADDR cellsWritten
	.ENDIF

	.IF stage1rowLength == 120		;����ץ[��120
		mov stage1rowOffset, 120	;�����q���m��120
		mov stage1rowLength, 0		;���׭��m��0
		jmp START
	.ENDIF
	call delayer1
	jmp drawStage1

;ø�s�q���d1�����d2
drawStage2:
	
	;�Nrow����1
	sub stage2row1Pos.x, 1
	sub stage2row2Pos.x, 1
	sub stage2row3Pos.x, 1
	sub stage2row4Pos.x, 1
	sub stage2row5Pos.x, 1
	sub stage2row6Pos.x, 1
	sub stage2row7Pos.x, 1
	sub stage2row8Pos.x, 1
	sub stage2row9Pos.x, 1
	sub stage2row10Pos.x, 1
	sub stage2row11Pos.x, 1
	sub stage2row12Pos.x, 1
	sub stage2row13Pos.x, 1
	sub stage2row14Pos.x, 1
	sub stage2row15Pos.x, 1
	sub stage2row16Pos.x, 1
	sub stage2row17Pos.x, 1
	sub stage2row18Pos.x, 1
	sub stage2row19Pos.x, 1
	sub stage2row20Pos.x, 1
	sub stage2row21Pos.x, 1
	sub stage2row22Pos.x, 1
	sub stage2row23Pos.x, 1
	sub stage2row24Pos.x, 1
	sub stage2row25Pos.x, 1
	sub stage2row26Pos.x, 1
	sub stage2row27Pos.x, 1
	sub stage2row28Pos.x, 1
	sub stage2row29Pos.x, 1
	sub stage2row30Pos.x, 1

	.IF stage2rowLength <= 120	;�Y���פ���120
		add stage2rowLength, 1	;�N���ץ[1
	.ENDIF

	;�N���ױq0���W�A�óv�������A�ӹF���Ϯױq�k�쥪�������ĪG
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row1, stage2rowLength, stage2row1Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row2, stage2rowLength, stage2row2Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row3, stage2rowLength, stage2row3Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row4, stage2rowLength, stage2row4Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row5, stage2rowLength, stage2row5Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row6, stage2rowLength, stage2row6Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row7, stage2rowLength, stage2row7Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row8, stage2rowLength, stage2row8Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row9, stage2rowLength, stage2row9Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row10, stage2rowLength, stage2row10Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row11, stage2rowLength, stage2row11Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row12, stage2rowLength, stage2row12Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row13, stage2rowLength, stage2row13Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row14, stage2rowLength, stage2row14Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row15, stage2rowLength, stage2row15Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row16, stage2rowLength, stage2row16Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row17, stage2rowLength, stage2row17Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row18, stage2rowLength, stage2row18Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row19, stage2rowLength, stage2row19Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row20, stage2rowLength, stage2row20Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row21, stage2rowLength, stage2row21Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row22, stage2rowLength, stage2row22Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row23, stage2rowLength, stage2row23Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row24, stage2rowLength, stage2row24Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row25, stage2rowLength, stage2row25Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row26, stage2rowLength, stage2row26Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row27, stage2rowLength, stage2row27Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row28, stage2rowLength, stage2row28Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row29, stage2rowLength, stage2row29Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR stage2row30, stage2rowLength, stage2row30Pos, ADDR cellsWritten

	.IF stage2row1Pos.x == 0		;��row������̥���
		mov stage2row1Pos.x, 120	;���mrow����m��̥k
		mov stage2row2Pos.x, 120
		mov stage2row3Pos.x, 120
		mov stage2row4Pos.x, 120
		mov stage2row5Pos.x, 120
		mov stage2row6Pos.x, 120
		mov stage2row7Pos.x, 120
		mov stage2row8Pos.x, 120
		mov stage2row9Pos.x, 120
		mov stage2row10Pos.x, 120
		mov stage2row11Pos.x, 120
		mov stage2row12Pos.x, 120
		mov stage2row13Pos.x, 120
		mov stage2row14Pos.x, 120
		mov stage2row15Pos.x, 120
		mov stage2row16Pos.x, 120
		mov stage2row17Pos.x, 120
		mov stage2row18Pos.x, 120
		mov stage2row19Pos.x, 120
		mov stage2row20Pos.x, 120
		mov stage2row21Pos.x, 120
		mov stage2row22Pos.x, 120
		mov stage2row23Pos.x, 120
		mov stage2row24Pos.x, 120
		mov stage2row25Pos.x, 120
		mov stage2row26Pos.x, 120
		mov stage2row27Pos.x, 120
		mov stage2row28Pos.x, 120
		mov stage2row29Pos.x, 120
		mov stage2row30Pos.x, 120
		mov stage2rowLength, 0
		jmp START
	.ENDIF
	call delayer1
	jmp drawStage2

endStage:
	INVOKE mciSendString, addr closestage_cd, addr buffer, sizeof buffer, 0	;���}�ɭ��������I������
	ret

stage ENDP
END stage
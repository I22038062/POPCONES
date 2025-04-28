include Irvine32.inc

;�s�Winc�Mlib�ɡA�ΨӼ��񭵼�
include winmm.inc
includelib winmm.lib	
includelib Kernel32.lib

;�ޥ�
EXTERN main@0:PROC
EXTERN bloons1:BYTE,bloons2:BYTE
EXTERN lose1:BYTE,win1:BYTE
EXTERN drawSqur@0:PROC

.data
bytesWritten DWORD 0
CursorInfo CONSOLE_CURSOR_INFO <1,0>
resultState BYTE 0		;0:lose,1:win
resultChoose BYTE 0		;0:again,1:menu

bumpNum DWORD 0			;�����g�}����y��
resultRate DWORD 0		;�̫᪺�R���v
shotNum DWORD 3			;�o�g������
numDigit DWORD 0		;�Ʀr�����
rateDigit DWORD 0		;�R���v�����
targetRate DWORD 0		;�ؼЩR���v

;��r�˦�/���e
wordTargetW BYTE "TARGET :"
wordScoreW BYTE "POPPED :"
wordRateW BYTE "RATE   :"
wordNum DWORD 0		;drawNum�������n�L�X����
wordRate DWORD 0	;drawRate�������n�L�X����
wordVirgule BYTE "/"
wordPercent BYTE "%"
wordDot BYTE "."
wordPound BYTE "#"
wordLineV BYTE "|"
wordLineH BYTE "_"
wordSpace BYTE " "
;��r����
wordTargetWLen BYTE 8
wordScoreWLen BYTE 8
wordRateWLen BYTE 8
wordResultRateLen BYTE 3
;��r��m
wordTargetWPos COORD <5,21>
wordtargetRatePos COORD <21,21>	;�a�k���(�_�lX�b�̥k��)
wordRateWPos COORD <5,22>
wordRatePos COORD <21,22>		;�a�k���(�_�lX�b�̥k��)
wordScoreWPos COORD <5,23>
wordBumpNumPos COORD <18,23>	;�a�k���(�_�lX�b�̥k��)
wordVirgulePos COORD <19,23>
wordAllBloonPos COORD <20,23>
wordShotNumPos COORD <5,24>

;�O���O
squareScoreAreaL DWORD 21
squareScoreAreaW DWORD 5
squareScoreAreaPos COORD <3,20>

;��y
PUBLIC levelNum			;�]�������ܼ�
levelNum BYTE 0			;�����ĴX��
allBloon DWORD 460		;�Ҧ���y�`��
blonCol = 47			;��y��Column�ƶq
blonRow = 27			;��y��Row�ƶq
blonPos0 COORD <70,0>	;��y�����W����m
;��y�}�C
bloons0 BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO"

bumpPos COORD <0,0>		;�}����y��m	
bombPos COORD <0,0>		;���u���z��m
;�Q���ʵe
PUBLIC boolThrew
boolThrew BYTE 0	;�O�_��X=> 0:not,1:threw

;����e�����
squareResAreaL DWORD 35			;��檺��
squareResAreaW DWORD 6			;��檺�e
squareResAreaPos COORD <44,13>	;��檺���W����m

;����e����T 
;(wordResX:�r�� / wordResXLen:���� / wordResXPos:��ܦ�m)
wordRes1 BYTE "BALLOONS POPPED :" ,0
wordRes1Len DWORD 17
wordRes1Pos COORD <51,15>
wordRes2 BYTE "TOTAL  :" ,0
wordRes2Len DWORD 8
wordRes2Pos COORD <54,17>
wordRes3 BYTE "POPPED :" ,0
wordRes3Len DWORD 8
wordRes3Pos COORD <54,18>
wordRes4 BYTE "A G A I N" ,0
wordRes4Len DWORD 9
wordRes4Pos COORD <57,23>
wordRes5 BYTE "M E N U" ,0
wordRes5Len DWORD 7
wordRes5Pos COORD <58,25>

wordResRatePos COORD <72,15>	;�R���v��ܪ���m
wordResABPos COORD <64,17>		;��y�`����ܪ���m
wordResPopPos COORD <64,18>		;���}��y����ܪ���m

;����e���j�r
lose1Pos COORD <41,3>	;�j�r��ܦ�m
lose1Row DWORD 7		;�j�r��Row�ƶq
lose1Col DWORD 39		;�j�r��Column�ƶq
win1Pos COORD <42,3>	;�j�r��ܦ�m
win1Row DWORD 7			;�j�r��Row�ƶq
win1Col DWORD 37		;�j�r��Column�ƶq

attriShotNumI WORD 0Eh		;�Ѿl��g���ƹϮ��C��(��)
attriRes4 WORD 9 DUP(0Ch)	;����e��AGAIN�ﶵ����C��(��)
attriRes5 WORD 7 DUP(0Ch)	;����e��MENU�ﶵ����C��(��)

;--------------------------------------------------------------					
consoleHandle DWORD ?			; OUTPUTHANDLE
cellsWritten DWORD ?			
speedX WORD 1					; �Q�GX��V�t��
speed COORD <0, 0>				; �Q�GY��V�t�׾�Ƹ�p���I
xyBound COORD <116,27>			; �C�����XY
phase BYTE 0					; �C�����q
dart BYTE 15					; �Q�G�Ÿ�
playerPos COORD <17, 18>		; �Q����m(�Q�G��l��m)
dartPos COORD <17, 18>			; �Q�G��m
predartPos COORD <4, 18>		; �Q�G�W�@�B����m
darty2 SWORD 0					; �Q�GY�y�Ъ��p���I
gravity COORD <0, 0>			; ���O���ֿn�q
angle SBYTE 15					; �o�g����
ocount BYTE 0					; �����e�F�X�ӪQ�G�F
timecount BYTE 0				; �����g�L�F�X�ӹC���j��
colorred WORD 00Eh				; �e������

framePos COORD <0, 27>			; �O�q���ئ�m
straight BYTE 3 DUP ("|")		; ������زŸ�
horizon BYTE 118 DUP ("=")		; ������زŸ�
blockPos COORD <1, 28>			; �O�q����m
spblock WORD 0020h				; �Ů�Ÿ�
colorpink WORD 4 DUP(0CCh)		; �e���I��������
colornull WORD 4 DUP(00h)		; �S���C��
power WORD 1					; �Q�G�o�g�O��
dpower BYTE 1					; �O�q�W�[�٬O���
pressed BYTE 0					; �Ů���O�_���L

LEFTKEY BYTE 0					; ������U
RIGHTKEY BYTE 0					; �k����U
SPACE BYTE 0					; �Ů�����U

dartround SBYTE 0				; �Q�GY�y�ЬO�_���|�ˤ��J
y_step BYTE 0					; �e�u��Y�O�W�[�٬O���
ay WORD 0						; �e�u��Y�y�Ъ��ֿn
mid_y WORD 0					; �e�u��X�����jY�y��
pathPos COORD <0, 0>			; �e�u�ɸ��|�W���I�y��
dy WORD 0						; �e�u����IY�y�Юt
	
	


;tangent �d��A�q-45�ר�87�סA�C�T�װO�@���A�y�Ъ�x�O��Ʀ�A�y�Ъ�y�O�p���I����
tantable COORD <-1, 00>, <0, -90>, <0, -80>, <0, -72>, <0, -64>, <0, -57>, <0, -50>, <0, -44>, <0, -38>, <0, -32>, 
			   <0, -26>, <0, -21>, <0, -15>, <0, -10>, <0, -05>, <00, 00>, <00, 05>, <00, 10>, <00, 15>, <00, 21>, 
			   <00, 26>, <00, 32>, <00, 38>, <00, 44>, <00, 50>, <00, 57>, <00, 64>, <00, 72>, <00, 80>, <00, 90>, 
			   <01, 00>, <01, 11>, <01, 23>, <01, 37>, <01, 53>, <01, 73>, <01, 96>, <02, 24>, <02, 60>, <03, 07>, 
			   <03, 73>, <04, 70>, <06, 31>, <09, 51>, <19, 08>
			    


;---------------------------------------------------------------------------

;�Ω�playsoundA���ѼơA�W�d���֪�����Ҧ�
SND_ASYNC DWORD 0001h			;�P�B����A�禡�|�����񧹫ạ�^
SND_LOOP DWORD 0008h			;�`������
SND_NOSTOP DWORD 20011h			;�ثe�����ּ���ɡA���|���_�ثe������
SND_LOOP_ASYNC DWORD 0009h		;�P�B + �`������

;����(�ϥά۹���|�A�ɮש�m��Pexe�ɦP�Ӧ�m)
ball_throw BYTE "ball_throw.wav", 0
balloon_pop BYTE "balloon_pop.wav", 0
game_lose BYTE "game_lose.wav", 0
game_win BYTE "game_win", 0

;�W�d������Ĺ������
isplaylose BYTE 0
isplaywin BYTE 0

;�Ω�mcisendstring���ѼơA�W�d���֪�����Ҧ�
;�I������(�ϥε����m�A�ɮש�m��C��)
game_cd BYTE "open C:\asm_music_project\game.wav type waveaudio alias game_music", 0		;���}���ɪ����O�A�N���ɦW�ٳ]�m��game_music
playgame_cd BYTE "play game_music", 0														;�����ɪ����O
stopgame_cd BYTE "stop game_music", 0														;�Ȱ����ɪ����O
closegame_cd BYTE "close game_music", 0														;�������ɪ����O
statusgame_cd BYTE "status game_music mode", 0												;�ˬd���ɪ��A�����O

buffer BYTE 128 dup(0)					;�w�İϥΩ󱵦���ƪ���^��T(���O���浲�G)
statusBuffer BYTE 128 dup(0)			;���A�w�İϥΩ󱵦���ƪ���^��T(���񪬺A)


.code

;�]�m�C���I������
playmusic_g PROC USES eax ecx edx	
	invoke mciSendString, addr game_cd, addr buffer, sizeof buffer, 0
	invoke mciSendString, addr playgame_cd, addr buffer, sizeof buffer, 0

	ret
playmusic_g ENDP

;��C���I�����ּ��񧹲���A���s�A���@��
checkmusic_g PROC USES eax ecx edx	
	
	invoke mciSendString, addr statusgame_cd, addr statusBuffer, sizeof statusBuffer, 0		;�o�쭵�֥ثe���A

	push ebx
	mov bl,[statusBuffer]		;�N���A���Ĥ@�Ӧr���bl�����
	cmp bl, 'p'					;�Y��p�A�h�N�����٦b����A����still_play (p = playing)
	je still_play
	
	invoke mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0		;�n���N��e����������A�I�s���񭵼�
	CALL playmusic_g															;�I�s����I������

	still_play:

	pop ebx

	ret
checkmusic_g ENDP

;�]�m���y����
playmusic_throw PROC USES eax ecx edx		
	INVOKE PlaySoundA, OFFSET ball_throw, NULL, SND_ASYNC

	ret
playmusic_throw ENDP

;�]�m�骺����
playmusic_lose PROC	USES eax ecx edx	
	.IF isplaylose == 0
		INVOKE PlaySoundA, OFFSET game_lose, NULL, SND_ASYNC
		add isplaylose,1
	.ENDIF

	ret
playmusic_lose ENDP

;�]�mĹ������
playmusic_win PROC USES eax ecx edx	
	.IF isplaywin == 0
		INVOKE PlaySoundA, OFFSET game_win, NULL, SND_ASYNC
		add isplaywin,1
	.ENDIF
	
	ret
playmusic_win ENDP

;----------------------------------------------------------------------------

;����C���e����s�W�v
delayer2 PROC USES eax, cnt : DWORD
	push ecx
	mov eax, 10000000
	mul cnt
	mov ecx, eax
L1:
	loop L1
	pop ecx
	ret
delayer2 ENDP

;�ʧ@���O��ť
listener PROC
	mov RIGHTKEY, 0
	mov LEFTKEY, 0
	mov SPACE, 0
	
	.IF ax == 4B00h		; leftarrow
		mov LEFTKEY, 1
	.ELSEIF ax == 4D00h ; rightarrow
		mov RIGHTKEY, 1		
	.ELSEIF ax == 3920h ; SPACE
		mov SPACE, 1
	.ENDIF
	mov ax, 0
	ret
listener ENDP

;�p��R���v(���p���I��T��)
calRate PROC USES eax ecx edx
cal:
	mov ecx, 1000
	mov eax, bumpNum
	mul ecx
	xor edx, edx
	div allBloon
	mov resultRate, eax
	ret
calRate ENDP

;�P�_��y�O�_�I��
bump PROC USES eax ebx ecx edx esi, 
	Posx : WORD, Posy : WORD

	;�Y�w�g���h���P�_�I��
	.IF shotNum == 0
		jmp endbump
	.ENDIF
    mov esi, OFFSET bloons0
	xor ebx, ebx
	xor edx, edx
    mov bx, Posx
	mov ax, Posy
	mov dx, blonPos0.y
	add dx, blonRow
	;�Y���b��y��m�Ϫ��d�򤺫h���P�_�I��
	.IF ax < blonPos0.y || ax >= dx
		jmp endbump
	.ENDIF
	mov cx, blonPos0.x
	mov dx, cx
	add dx, blonCol
	;�Y�b��y��m�Ϫ��d��
	.IF Posx >= cx  && Posx < dx
		sub bx, blonPos0.x
		add esi, ebx
		mov eax, blonCol
		xor ecx,ecx
		mov cx, Posy
		sub cx, blonPos0.y
		.IF ecx > 0
			mul ecx
			add esi, eax
		.ENDIF
		;�P�_�I������y
		mov dl, [esi]
		.IF dl == 4Fh
			mov dl, 20h
			mov [esi], dl
			mov dx, WORD PTR Posx
			mov bumpPos.x, dx
			mov dx, WORD PTR Posy
			mov bumpPos.y, dx
			INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, 1, bumpPos, ADDR cellsWritten
			inc bumpNum
		.ELSEIF dl == 21h
			mov dl, 20h
			mov [esi], dl
			mov dx, WORD PTR Posx
			mov bumpPos.x, dx
			mov dx, WORD PTR Posy
			mov bumpPos.y, dx
			INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, 1, bumpPos, ADDR cellsWritten
			Call bomb
			inc bumpNum
		.ENDIF
	.ENDIF
    
endbump:	;�����I���P�_
    ret
bump ENDP

;���u�\�� : �����T���Ʈ�y
bomb PROC USES esi eax ebx ecx edx
	
	mov esi, OFFSET bloons0
	xor ebx, ebx
	xor edx, edx
    mov bx, bumpPos.x
	sub bx, blonPos0.x
	dec bx
	add esi, ebx
	mov ecx, blonRow
	mov dx, WORD PTR blonPos0.y
	mov bombPos.y, dx
L1:
	mov bx, 3
	mov dx, WORD PTR bumpPos.x
	dec dx
	mov bombPos.x, dx
L2:
	mov dl, [esi]
	.IF dl == 4Fh
		mov dl, 20h
		mov [esi], dl
		push ecx
		INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, 1, bombPos, ADDR cellsWritten
		pop ecx
		inc bumpNum
	.ENDIF

	inc bombPos.x
	inc esi

	dec bx
	.IF bx > 0
		jmp L2
	.ENDIF

	dec ecx
	inc bombPos.y
	.IF ecx > 0
		sub esi, 3
		add esi, blonCol
		jmp L1
	.ENDIF

	ret	
bomb ENDP

;�e��g���Ѿl����
drawShotNumIcon PROC USES eax ecx 
	xor ecx, ecx
	mov ecx, shotNum
	.IF ecx == 0
		jmp enddsni
	.ENDIF
	push ecx
dsni:
	push ecx
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attriShotNumI, 1, wordShotNumPos, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR dart, 1, wordShotNumPos, ADDR cellsWritten
	pop ecx
	inc wordShotNumPos.x
	loop dsni
	pop ecx
	sub wordShotNumPos.x, cx

enddsni:	
	ret

drawShotNumIcon ENDP

;�e�X���d��y
drawBalloon PROC USES eax ecx esi
	mov ecx, blonRow
	mov esi, OFFSET bloons0
	push ecx
drawBloon:
	push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, blonCol, blonPos0, ADDR cellsWritten	
	add blonPos0.y,1
	add esi, blonCol
	pop ecx
	loop drawBloon

	pop ecx
	sub blonPos0.y, cx
	ret
drawBalloon ENDP


;�e�X�Q�i��Ʀr�A�����Υk���(�a��:0�A�a�k:1)
drawNum PROC USES eax ecx edx,
	num:DWORD,pos:COORD,LorR:BYTE

	push num
	;�P�_��ƨç�s�C�L�_�l��m
	.IF num<10
		mov numDigit, 0
	.ELSEIF num<100
		mov numDigit, 1
		.IF LorR == 1
			sub pos.x, 1
		.ENDIF
	.ELSEIF num<1000
		mov numDigit, 2
		.IF LorR == 1
			sub pos.x, 2
		.ENDIF
	.ELSEIF num<10000
		mov numDigit, 3
		.IF LorR == 1
			sub pos.x, 3
		.ENDIF
	.ENDIF
	push numDigit
draw:	
	;�̷Ӧ�ƱN�̰��쪺�Ʀr�L�X
	.IF numDigit == 0
		mov eax,num
		add eax,48
		mov wordNum,eax
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordNum, 1, pos, ADDR cellsWritten
		jmp endDraw
	.ELSEIF numDigit == 1
		mov ecx, 10
	.ELSEIF numDigit == 2
		mov ecx, 100
	.ELSEIF numDigit == 3
		mov ecx, 1000
	.ENDIF

	mov eax, num
	xor edx,edx
	push ecx
	div ecx
	push eax
	add eax,48
	mov wordNum,eax
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordNum, 1, pos, ADDR cellsWritten
	pop eax
	pop ecx
	mul ecx
	sub num,eax
	inc pos.x
	dec numDigit
	jmp draw

endDraw:
	pop numDigit
	mov ax, WORD PTR numDigit
	.IF LorR == 0
		sub pos.x, ax
	.ENDIF
	
	pop num
	ret
drawNum ENDP


;�e�X�R���v
drawRate PROC USES eax ecx edx,
	num:DWORD,pos:COORD
	push num
	push pos
	.IF num<10
		mov rateDigit, 0
		push rateDigit
		jmp drawLess
	.ELSEIF num<100
		mov rateDigit, 1
	.ELSEIF num<1000
		mov rateDigit, 2
	.ELSEIF num >= 1000
		mov rateDigit, 3
	.ENDIF
	push rateDigit
;�̦�Ƶe�X�Ʀr
draw:
	push pos
	.IF rateDigit == 0
		dec pos.x
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordDot, 1, pos, ADDR cellsWritten
		pop pos
		mov eax, num
		INVOKE drawNum,eax,pos,0
		jmp endDraw
	.ELSEIF rateDigit == 1
		mov ecx, 10
		sub pos.x, 2
	.ELSEIF rateDigit == 2
		mov ecx, 100
		sub pos.x, 3
	.ELSEIF rateDigit == 3
		pop pos
		jmp drawH
	.ENDIF

	mov eax, num
	xor edx,edx
	push ecx
	div ecx
	mov wordRate, eax
	INVOKE drawNum,wordRate,pos,0
	pop ecx
	mov eax, wordRate
	mul ecx
	sub num,eax
	dec rateDigit
	pop pos
	jmp draw
;�Y�R���v�p��1%
drawLess:
	mov eax, num
	.IF num == 0
		INVOKE drawNum,eax,pos,0
	.ELSE
		INVOKE drawNum,eax,pos,0
		sub pos.x, 1
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordDot, 1, pos, ADDR cellsWritten
		mov eax,0
		sub pos.x, 1
		INVOKE drawNum,eax,pos,0
		add pos, 2
	.ENDIF
	jmp endDraw
;�Y�R���v����100%
drawH:
	sub pos, 3
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordSpace, 4, pos, ADDR cellsWritten
	add pos, 3
	mov wordRate, 100
	sub pos.x, 2
	INVOKE drawNum,wordRate,pos,0
	add pos.x, 2
	
endDraw:
	inc pos.x
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordPercent, 1, pos, ADDR cellsWritten
	pop rateDigit
	pop pos
	pop num
	ret
drawRate ENDP

;�e���
drawSquareArea PROC USES eax ebx ecx esi,
	areaL:DWORD, areaW:DWORD, pos:COORD

	mov ecx, areaL
	dec ecx
	inc pos.x
	push ecx
;�e�W�誽�u
dsa1:
    push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle,ADDR wordLineH, 1, pos, ADDR cellsWritten	
	pop ecx
	inc pos.x
	loop dsa1
	pop ecx
	sub pos.x, cx

	push ecx
	mov ebx, areaW
	add pos.y, bx
	push ebx
;�e�U�誽�u
dsa2:
    push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle,ADDR wordLineH, 1, pos, ADDR cellsWritten	
	pop ecx
	inc pos.x
	loop dsa2
	pop ebx
	sub pos.y, bx
	pop ecx
	sub pos.x, cx
	dec pos.x

	inc pos.y
	mov ecx, areaW
	push ecx
;�e���誽�u
dsa3:
    push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle,ADDR wordLineV, 1, pos, ADDR cellsWritten	
	pop ecx
	inc pos.y
	loop dsa3
	pop ecx
	sub pos.y, cx

	mov ecx, areaW
	push ecx
	mov ebx, areaL
	add pos.x, bx
	push ebx
;�e�k�誽�u
dsa4:
    push ecx
	INVOKE WriteConsoleOutputCharacter, consoleHandle,ADDR wordLineV, 1, pos, ADDR cellsWritten	
	pop ecx
	inc pos.y
	loop dsa4
	pop ebx
	sub pos.x, bx
	pop ecx
	sub pos.y, cx
	dec pos.y
	ret

drawSquareArea ENDP


;��ܰO���O
drawScoreArea PROC 
draw:
	;��ܤ��
	INVOKE drawSquareArea,squareScoreAreaL,squareScoreAreaW,squareScoreAreaPos
	;��ܥؼ����}��
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordTargetW, wordTargetWLen, wordTargetWPos, ADDR cellsWritten
	INVOKE drawRate,TargetRate,wordtargetRatePos
	;��ܩR���v
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRateW, wordRateWLen, wordRateWPos, ADDR cellsWritten
	INVOKE drawRate,resultRate,wordRatePos
	;������}�ƩM��y�`��
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordScoreW, wordScoreWLen, wordScoreWPos, ADDR cellsWritten
	INVOKE drawNum, bumpNum,wordBumpNumPos,1
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordVirgule, 1, wordVirgulePOS, ADDR cellsWritten
	INVOKE drawNum, allBloon,wordAllBloonPos,0
	;��ܳѾl��g����
	call drawShotNumIcon
	ret
drawScoreArea ENDP

;�����ɡA���sø�s��y�A�í��s�p���y�`��
replaceBloon PROC USES eax ecx esi edi edx,
	new:PTR BYTE, old:PTR BYTE
	
	mov eax, blonRow
	mov ecx, blonCol
	mul ecx
	mov ecx,eax
	mov esi, new
	mov edi, old
r1:
	mov dl, [edi]
	mov [esi], dl
	.IF dl == 4Fh
		inc allBloon
	.ENDIF
	inc esi
	inc edi
	loop r1

	ret
replaceBloon ENDP


;�e����e�����j�r
drawBigWord PROC USES eax ebx ecx esi,
	array:PTR BYTE,row:DWORD,col:DWORD,pos:COORD

	mov esi, array
	mov ecx, row
dbw:
	push ecx
	push esi
	INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, col, pos, ADDR cellsWritten	
	pop esi
	add esi, col
	add esi, 1
	inc pos.y
	pop ecx
	loop dbw
	mov ecx, row
	sub pos, ecx
	
	ret
drawBigWord ENDP

;---------------------------------------------------------------------------

; �Q�G����y���ܤ�
dartrun PROC USES eax ebx esi
	mov bx, dartPos.x
	mov predartPos.x, bx
	mov pathPos.x, bx
	mov bx, dartPos.y
	mov predartPos.y, bx
	mov pathPos.y, bx
	.IF dartround == 1
		inc predartPos.y
		inc pathPos.y
	.ELSEIF dartround == -1
		dec predartPos.y
		dec pathPos.y
	.ENDIF
	
; �ھڳt�ײ���
speedmov:
	add dartPos.x, 1
	mov bx, speed.x
	sub dartPos.y, bx
	mov bx, speed.y
	add darty2, bx

L:
	.IF darty2 >= 100
		dec dartPos.y
		sub darty2, 100
	.ELSEIF darty2 <= -100
		inc dartPos.y
		add darty2, 100
	.ENDIF

	.IF darty2 > -100 && darty2 < 100
		jmp gravitymov
	.ELSE
		jmp L
	.ENDIF

; �ھڤO�ק��ܨ��쪺���O
gravitymov:
    .IF timecount == 4
        mov ax, power
        mov bx, 30
        sub bx, ax
        mov ax, speed.x
        mov dx, 4
        MUL dx
        inc ax
        MUL bx
        add gravity.y, ax
        mov timecount, 0
    .ELSE
        inc timecount
    .ENDIF



    .IF gravity.y >= 100
        add gravity.x, 1
        sub gravity.y, 100
    .ENDIF

    mov bx, gravity.y
    sub darty2, bx
    mov bx, gravity.x
    add dartPos.y, bx

; �|�ˤ��JY�y��
Posround:
	mov dartround, 0
	.IF darty2 >= 50
		mov dartround, -1
	.ELSEIF darty2 <= -50
		mov dartround, 1
	.ENDIF

; �ˬd�O�_�쩳�F
boundtest:
	mov bx, dartPos.y
	.IF bx >= xyBound.y && bx <= 1000h
		mov phase, 0
		dec shotNum
	.ENDIF
	mov bx, dartPos.x
	.IF bx >= xyBound.x
		mov phase, 0
		dec shotNum
	.ENDIF

	ret
dartrun ENDP

; ���p�˺~�i�t��k
drawline PROC USES ebx eax ecx edx
; �u���_�I�OpredartPos
; �u�����I�OdartPos
; �]���ݭn�e���u���Osteep
; �ҥHxy�B��|���
	push dartPos.y
	.IF dartround == 1
		inc dartPos.y
	.ELSEIF dartround == -1
		dec dartPos.y
	.ENDIF
; �ײv����
steepTEST:
	mov ax, dartPos.y
	mov bx, predartPos.y
	sub ax, bx
	.IF ax < 2 && ax >=0 || ax > -2
		pop dartPos.y
		ret
	.ENDIF
; ��l��
Initial:
	mov ay, 0
	.IF ax < 1000h
		mov dy, ax
	.ELSEIF ax >= 1000h
		mov dy, ax
		neg dy
	.ENDIF
	
	mov dx, ax
	shr dx, 1
	mov mid_y, dx
; �ײv���t����
y_stepTEST:
	mov ax, dartPos.y
	.IF bx > dartPos.y
		mov y_step, 1
	.ELSEIF bx <= 28 && ax >= 1000h
		mov y_step, 1
	.ELSE
		mov y_step, 0
	.ENDIF
; ���楪�k��V����
torightTEST:
	mov bx, predartPos.x
	.IF bx > dartPos.x
		mov bx, predartPos.x
		mov ax, dartPos.x
		mov dartPos.x, bx
		mov predartPos.x, ax

		mov bx, predartPos.y
		mov ax, dartPos.y
		mov dartPos.y, bx
		mov PredartPos.y, ax

	.ENDIF
	
; �j��e�u�٦��P�_�I��
L:
	inc ay
	.IF y_step == 1
		dec pathPos.y
	.ELSEIF y_step == 0
		inc pathPos.y
	.ENDIF

	mov bx, pathPos.y
	.IF bx == dartPos.y
		pop dartPos.y
		ret
	.ENDIF

	mov bx, ay
	.IF bx > mid_y
		inc pathPos.x
		mov bx, dy
		
		add mid_y, bx
	.ENDIF
	.IF pathPos.y < 27
		inc ocount
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colorred, 1, pathPos, ADDR cellsWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR dart, 1, pathPos, ADDR cellsWritten
		.IF phase == 3
			INVOKE bump, pathPos.x,pathPos.y
			inc pathPos.y
			INVOKE bump, pathPos.x,pathPos.y
			sub pathPos.y, 2
			INVOKE bump, pathPos.x,pathPos.y
			inc pathPos.y
			inc pathPos.x
			INVOKE bump, pathPos.x,pathPos.y
			sub pathPos.x, 2
			INVOKE bump, pathPos.x,pathPos.y
			inc pathPos.x
		.ENDIF
		.IF ocount >= 15 && phase == 1
			pop dartPos.y
			ret
		.ENDIF
	.ENDIF

	
	jmp L

drawline ENDP

; �e�O�ױ��ؽu
drawframe PROC 
	push framePos.x
	push framePos.y
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR horizon, 118, framePos, ADDR cellsWritten
	mov ecx, 3
	inc framePos.y
L1:
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR straight, 1, framePos, ADDR cellsWritten
	add framePos.x, 117
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR straight, 1, framePos, ADDR cellsWritten
	sub framePos.x, 117
	inc framePos.y
	.IF framePos.y != 30
		jmp L1
	.ENDIF
	dec framePos.y
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR horizon, 118, framePos, ADDR cellsWritten
	pop framePos.y
	pop framePos.x
	ret
drawframe ENDP

; �e�O�ױ�
drawstrength PROC USES ebx
	.IF pressed == 0 && SPACE == 1
		mov pressed, 1
		jmp powerrun
	.ELSEIF pressed == 1 && SPACE == 1
		jmp powerrun
	.ELSEIF pressed == 1 && SPACE == 0
		CALL playmusic_throw		;���񥵲y����
		mov phase, 3
		mov pressed, 0
		ret
	.ENDIF
	
; �O�ױ��e��]
powerrun:
	
	.IF dpower == 1
		inc power
		add blockPos.x, 4
		.IF power >= 29
			mov dpower, 0
			mov power, 29
			mov blockPos.x, 113
		.ENDIF
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colorpink, 4, blockPos, ADDR cellsWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR spblock, 4, blockPos, ADDR cellsWritten
	.ELSE
		dec power
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colornull, 4, blockPos, ADDR cellsWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR spblock, 4, blockPos, ADDR cellsWritten
		sub blockPos.x, 4
		.IF power <= 1
			mov dpower, 1
			mov power, 1
			mov blockPos.x, 1
		.ENDIF
	.ENDIF
	
	
	ret
drawstrength ENDP

; �e�o�g���׹w���u
drawangle PROC USES eax ebx edx esi ecx
dealwithkey:
	.IF angle <= 44 && LEFTKEY == 1
		inc angle
	.ENDIF

	.IF angle >= 0 && RIGHTKEY == 1
		dec angle
	.ENDIF

	.IF SPACE == 1
		mov phase, 2
	.ENDIF

	mov LEFTKEY, 0
	mov RIGHTKEY, 0

; �ھڨ��ק��ܪQ�G�t��
AngleToSpeed:
	movzx ebx, angle
	shl ebx, 2
	mov esi, offset tantable
	add esi, ebx
	mov dx, WORD ptr [esi]
	mov speed.x, dx
	mov dx, WORD ptr [esi + 2]
	mov speed.y, dx
	

	mov power, 30
	
; �e�w���u
preview:
	Call dartrun
	Call drawline
	.IF ocount >= 15
		ret
	.ENDIF

	Call drawdart
	inc ocount
	
	.IF ocount >= 15
		ret
	.ELSE
		jmp preview
	.ENDIF

	
drawangle ENDP

; �e�Q�G�y��
drawdart PROC
	push dartPos.y
	push dartPos.x
	.IF dartround == -1
		dec dartPos.y
	.ELSEIF dartround == 1
		inc dartPos.y
	.ENDIF
	.IF dartPos.y < 27 && dartPos.y >= 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colorred, 1, dartPos, ADDR cellsWritten
		INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR dart, 1, dartPos, ADDR cellsWritten
		.IF phase == 3
			INVOKE bump, dartPos.x,dartPos.y
			inc dartPos.y
			INVOKE bump, dartPos.x,dartPos.y
			sub dartPos.y, 2
			INVOKE bump, dartPos.x,dartPos.y
			inc dartPos.y
			inc dartPos.x
			INVOKE bump, dartPos.x,dartPos.y
			sub dartPos.x, 2
			INVOKE bump, dartPos.x,dartPos.y
			inc dartPos.x
		.ENDIF

	.ENDIF
	pop dartPos.x
	pop dartPos.y
	ret
drawdart ENDP

;----------------------------------------------------------------------

;�C���D�{��
game1 PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE		;���o Output Console Handle
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR CursorInfo		;����Cursor

	CALL playmusic_g		;����I������

;�C�����d��l��
INIT:
	mov phase, 0			;��g���q
	mov allBloon, 0			;��y�`��
	mov resultState, 0		;��Ĺ���G�P�_
	mov resultChoose, 0		;����ﶵ���
	mov shotNum, 3			;�i�H��g������
	mov bumpNum, 0			;�����g�}����y��
	mov resultRate, 0		;�̫᪺�R���v
	mov targetRate, 0		;�ؼЩR���v
	mov numDigit, 0			;�Ʀr�����
	mov rateDigit, 0		;�R���v���
	mov angle, 15			;��g����

	;�٭��y���d�t�m�A�íp���y�`��
	.IF levelNum == 1
		INVOKE replaceBloon,OFFSET bloons0,OFFSET bloons1
		mov targetRate, 400
	.ELSEIF	levelNum == 2
		INVOKE replaceBloon,OFFSET bloons0,OFFSET bloons2
		mov targetRate, 500
	.ENDIF

; �᧹�Q�G��l��
Initial0:
	mov phase, 1
	.IF resultRate >= 1000
		mov resultState, 1
		jmp resultScr
	.ENDIF
	.IF shotNum == 0
		mov eax, targetRate
		.IF resultRate > eax
				mov resultState, 1
		.ELSE
				mov resultState, 0
		.ENDIF
		jmp resultScr
	.ENDIF

; ��g�e�A�վ��g���׮ɪ���l��
Initial1:
	mov dartPos.x, 15		
	mov dartPos.y, 17		
	mov predartPos.x, 15	
	mov predartPos.y, 17
	mov darty2, 0
	mov gravity.y, 0
	mov gravity.x, 0
	mov dartround, 0
	mov power, 1
	mov dpower, 1
	mov blockPos.x, 1
	mov ocount, 0
	mov timecount, 0	
	mov boolThrew, 0	;�S��g

	Call Clrscr
	;�O�ױ����
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colorpink, 4, blockPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR spblock, 4, blockPos, ADDR cellsWritten

; �C���i��
START:
	CALL checkmusic_g		;�ˬd�I�����֪��A�ô`�����񭵼�

	;��g���q�����e��y
	.IF phase != 3
		call drawBalloon	
	.ENDIF
	
	call drawSqur@0			;��ܪQ��
	call drawdart			;��ܪQ�G
	call drawframe			;��ܤO�ױ�
	call drawScoreArea		;��ܰO���O

	;�P�_�ثe���q
	.IF phase == 0
		jmp Initial0
	.ELSEIF phase == 1
		jmp phase1
	.ELSEIF phase == 2
		jmp phase2
	.ELSEIF phase == 3
		jmp phase3
	.ENDIF

; �վ㨤�׶��q
phase1:					
	Call drawangle
	INVOKE delayer2, 30
	Call ReadKey
	jz L2
	Call listener
L2:
	
	INVOKE delayer2, 30
	jmp Initial1

; �O�ׯB�ʶ��q
phase2:					
	INVOKE delayer2, 4
	Call ReadKey
	Call listener
	Call drawstrength		;��s�O�ױ�
	jmp Start

; �o�g���q
phase3:					
	INVOKE delayer2, 3
	mov boolThrew, 1		;�w��g
	Call dartrun			;�Q�G����
	Call drawline			;��ܭ�����|
	call calRate			;�p��R���v
	jmp Start

;����e��
resultScr:
	call ClrScr

	;�̷ӿ�ܡA�N�ثe�ﶵ�ܴ��C��(��)
	.IF resultChoose == 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attriRes4, wordRes4Len, wordRes4Pos, ADDR bytesWritten
	.ELSEIF resultChoose == 1
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attriRes5, wordRes5Len, wordRes5Pos, ADDR bytesWritten
	.ENDIF

	;�̷ӵ��G�A��ܿ�Ĺ�r��
	.IF resultState == 1
		INVOKE drawBigWord,OFFSET win1,win1Row,win1Col,win1Pos
		CALL playmusic_win		;����Ĺ�y����
	.ELSEIF
		INVOKE drawBigWord,OFFSET lose1,lose1Row,lose1Col,lose1Pos
		CALL playmusic_lose		;�����y����
	.ENDIF

	;��ܵ���e����T
	;��ܤ��
	INVOKE drawSquareArea,squareResAreaL,squareResAreaW,squareResAreaPos
	;��ܧ�g���G��T
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes1, wordRes1Len, wordRes1Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes2, wordRes2Len, wordRes2Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes3, wordRes3Len, wordRes3Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes4, wordRes4Len, wordRes4Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes5, wordRes5Len, wordRes5Pos, ADDR cellsWritten
	INVOKE drawRate,resultRate,wordResRatePos
	INVOKE drawNum,allBloon,wordResABPos,0
	INVOKE drawNum,bumpNum,wordResPopPos,0
	
	call Readkey
	jz resScrNoInput					;�Y�S�ʧ@
	;�Y���ʧ@�N�P�_
	.IF ax == 4B00h	|| ax == 4800h		; leftarrow / uparrow
		mov resultChoose, 0
	.ELSEIF ax == 4D00h || ax == 5000h	; rightarrow / downarrow
		mov resultChoose, 1
	.ELSEIF ax == 1C0Dh					; ENTER
		jmp resScrEnter
	.ENDIF

;�Y�S�ʧ@
resScrNoInput:
	INVOKE delayer2, 30
	jmp resultScr

;�Y���U���
resScrEnter:
	mov isplaylose, 0		;�k�s�H�K���񭵮�
	mov isplaywin, 0		;�k�s�H�K���񭵮�
	.IF resultChoose == 0
		;�}�l�s�C��
		INVOKE mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0	;���}�ɭ��������I������
		call game1
	.ELSEIF resultChoose == 1
		;�^��MENU
		INVOKE mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0	;���}�ɭ��������I������
	.ENDIF
		
	ret
game1 ENDP
END game1


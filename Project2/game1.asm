include Irvine32.inc

;新增inc和lib檔，用來撥放音樂
include winmm.inc
includelib winmm.lib	
includelib Kernel32.lib

;引用
EXTERN main@0:PROC
EXTERN bloons1:BYTE,bloons2:BYTE
EXTERN lose1:BYTE,win1:BYTE
EXTERN drawSqur@0:PROC

.data
bytesWritten DWORD 0
CursorInfo CONSOLE_CURSOR_INFO <1,0>
resultState BYTE 0		;0:lose,1:win
resultChoose BYTE 0		;0:again,1:menu

bumpNum DWORD 0			;紀錄射破的氣球數
resultRate DWORD 0		;最後的命中率
shotNum DWORD 3			;發射的次數
numDigit DWORD 0		;數字的位數
rateDigit DWORD 0		;命中率的位數
targetRate DWORD 0		;目標命中率

;文字樣式/內容
wordTargetW BYTE "TARGET :"
wordScoreW BYTE "POPPED :"
wordRateW BYTE "RATE   :"
wordNum DWORD 0		;drawNum中紀錄要印出的數
wordRate DWORD 0	;drawRate中紀錄要印出的數
wordVirgule BYTE "/"
wordPercent BYTE "%"
wordDot BYTE "."
wordPound BYTE "#"
wordLineV BYTE "|"
wordLineH BYTE "_"
wordSpace BYTE " "
;文字長度
wordTargetWLen BYTE 8
wordScoreWLen BYTE 8
wordRateWLen BYTE 8
wordResultRateLen BYTE 3
;文字位置
wordTargetWPos COORD <5,21>
wordtargetRatePos COORD <21,21>	;靠右對齊(起始X在最右邊)
wordRateWPos COORD <5,22>
wordRatePos COORD <21,22>		;靠右對齊(起始X在最右邊)
wordScoreWPos COORD <5,23>
wordBumpNumPos COORD <18,23>	;靠右對齊(起始X在最右邊)
wordVirgulePos COORD <19,23>
wordAllBloonPos COORD <20,23>
wordShotNumPos COORD <5,24>

;記分板
squareScoreAreaL DWORD 21
squareScoreAreaW DWORD 5
squareScoreAreaPos COORD <3,20>

;氣球
PUBLIC levelNum			;設為全域變數
levelNum BYTE 0			;紀錄第幾關
allBloon DWORD 460		;所有氣球總數
blonCol = 47			;氣球的Column數量
blonRow = 27			;氣球的Row數量
blonPos0 COORD <70,0>	;氣球的左上角位置
;氣球陣列
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

bumpPos COORD <0,0>		;破掉氣球位置	
bombPos COORD <0,0>		;炸彈引爆位置
;松鼠動畫
PUBLIC boolThrew
boolThrew BYTE 0	;是否丟出=> 0:not,1:threw

;結算畫面方格
squareResAreaL DWORD 35			;方格的長
squareResAreaW DWORD 6			;方格的寬
squareResAreaPos COORD <44,13>	;方格的左上角位置

;結算畫面資訊 
;(wordResX:字樣 / wordResXLen:長度 / wordResXPos:顯示位置)
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

wordResRatePos COORD <72,15>	;命中率顯示的位置
wordResABPos COORD <64,17>		;氣球總數顯示的位置
wordResPopPos COORD <64,18>		;打破氣球數顯示的位置

;結算畫面大字
lose1Pos COORD <41,3>	;大字顯示位置
lose1Row DWORD 7		;大字的Row數量
lose1Col DWORD 39		;大字的Column數量
win1Pos COORD <42,3>	;大字顯示位置
win1Row DWORD 7			;大字的Row數量
win1Col DWORD 37		;大字的Column數量

attriShotNumI WORD 0Eh		;剩餘投射次數圖案顏色(黃)
attriRes4 WORD 9 DUP(0Ch)	;結算畫面AGAIN選項顯示顏色(紅)
attriRes5 WORD 7 DUP(0Ch)	;結算畫面MENU選項顯示顏色(紅)

;--------------------------------------------------------------					
consoleHandle DWORD ?			; OUTPUTHANDLE
cellsWritten DWORD ?			
speedX WORD 1					; 松果X方向速度
speed COORD <0, 0>				; 松果Y方向速度整數跟小數點
xyBound COORD <116,27>			; 遊戲邊界XY
phase BYTE 0					; 遊戲階段
dart BYTE 15					; 松果符號
playerPos COORD <17, 18>		; 松鼠位置(松果初始位置)
dartPos COORD <17, 18>			; 松果位置
predartPos COORD <4, 18>		; 松果上一步的位置
darty2 SWORD 0					; 松果Y座標的小數點
gravity COORD <0, 0>			; 重力的累積量
angle SBYTE 15					; 發射角度
ocount BYTE 0					; 紀錄畫了幾個松果了
timecount BYTE 0				; 紀錄經過了幾個遊戲迴圈
colorred WORD 00Eh				; 前景紅色

framePos COORD <0, 27>			; 力量條框位置
straight BYTE 3 DUP ("|")		; 垂直邊框符號
horizon BYTE 118 DUP ("=")		; 水平邊框符號
blockPos COORD <1, 28>			; 力量條位置
spblock WORD 0020h				; 空格符號
colorpink WORD 4 DUP(0CCh)		; 前景背景粉紅色
colornull WORD 4 DUP(00h)		; 沒有顏色
power WORD 1					; 松果發射力度
dpower BYTE 1					; 力量增加還是減少
pressed BYTE 0					; 空格鍵是否按過

LEFTKEY BYTE 0					; 左鍵按下
RIGHTKEY BYTE 0					; 右鍵按下
SPACE BYTE 0					; 空格鍵按下

dartround SBYTE 0				; 松果Y座標是否有四捨五入
y_step BYTE 0					; 畫線時Y是增加還是減少
ay WORD 0						; 畫線時Y座標的累積
mid_y WORD 0					; 畫線時X的分隔Y座標
pathPos COORD <0, 0>			; 畫線時路徑上的點座標
dy WORD 0						; 畫線兩端點Y座標差
	
	


;tangent 查表，從-45度到87度，每三度記一次，座標的x是整數位，座標的y是小數點後兩位
tantable COORD <-1, 00>, <0, -90>, <0, -80>, <0, -72>, <0, -64>, <0, -57>, <0, -50>, <0, -44>, <0, -38>, <0, -32>, 
			   <0, -26>, <0, -21>, <0, -15>, <0, -10>, <0, -05>, <00, 00>, <00, 05>, <00, 10>, <00, 15>, <00, 21>, 
			   <00, 26>, <00, 32>, <00, 38>, <00, 44>, <00, 50>, <00, 57>, <00, 64>, <00, 72>, <00, 80>, <00, 90>, 
			   <01, 00>, <01, 11>, <01, 23>, <01, 37>, <01, 53>, <01, 73>, <01, 96>, <02, 24>, <02, 60>, <03, 07>, 
			   <03, 73>, <04, 70>, <06, 31>, <09, 51>, <19, 08>
			    


;---------------------------------------------------------------------------

;用於playsoundA的參數，規範音樂的撥放模式
SND_ASYNC DWORD 0001h			;同步撥放，函式會等撥放完後滿回
SND_LOOP DWORD 0008h			;循環撥放
SND_NOSTOP DWORD 20011h			;目前有音樂撥放時，不會打斷目前的音樂
SND_LOOP_ASYNC DWORD 0009h		;同步 + 循環撥放

;音效(使用相對路徑，檔案放置於與exe檔同個位置)
ball_throw BYTE "ball_throw.wav", 0
balloon_pop BYTE "balloon_pop.wav", 0
game_lose BYTE "game_lose.wav", 0
game_win BYTE "game_win", 0

;規範撥放輸或贏的音效
isplaylose BYTE 0
isplaywin BYTE 0

;用於mcisendstring的參數，規範音樂的撥放模式
;背景音效(使用絕對位置，檔案放置於C槽)
game_cd BYTE "open C:\asm_music_project\game.wav type waveaudio alias game_music", 0		;打開音檔的指令，將音檔名稱設置為game_music
playgame_cd BYTE "play game_music", 0														;撥放音檔的指令
stopgame_cd BYTE "stop game_music", 0														;暫停音檔的指令
closegame_cd BYTE "close game_music", 0														;關閉音檔的指令
statusgame_cd BYTE "status game_music mode", 0												;檢查音檔狀態的指令

buffer BYTE 128 dup(0)					;緩衝區用於接收函數的返回資訊(指令執行結果)
statusBuffer BYTE 128 dup(0)			;狀態緩衝區用於接收函數的返回資訊(撥放狀態)


.code

;設置遊戲背景音樂
playmusic_g PROC USES eax ecx edx	
	invoke mciSendString, addr game_cd, addr buffer, sizeof buffer, 0
	invoke mciSendString, addr playgame_cd, addr buffer, sizeof buffer, 0

	ret
playmusic_g ENDP

;當遊戲背景音樂撥放完畢後，重新再撥一次
checkmusic_g PROC USES eax ecx edx	
	
	invoke mciSendString, addr statusgame_cd, addr statusBuffer, sizeof statusBuffer, 0		;得到音樂目前狀態

	push ebx
	mov bl,[statusBuffer]		;將狀態的第一個字放到bl中比較
	cmp bl, 'p'					;若為p，則代表音樂還在撥放，跳到still_play (p = playing)
	je still_play
	
	invoke mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0		;要先將當前音檔關掉後再呼叫撥放音樂
	CALL playmusic_g															;呼叫撥放背景音樂

	still_play:

	pop ebx

	ret
checkmusic_g ENDP

;設置扔球音效
playmusic_throw PROC USES eax ecx edx		
	INVOKE PlaySoundA, OFFSET ball_throw, NULL, SND_ASYNC

	ret
playmusic_throw ENDP

;設置輸的音效
playmusic_lose PROC	USES eax ecx edx	
	.IF isplaylose == 0
		INVOKE PlaySoundA, OFFSET game_lose, NULL, SND_ASYNC
		add isplaylose,1
	.ENDIF

	ret
playmusic_lose ENDP

;設置贏的音效
playmusic_win PROC USES eax ecx edx	
	.IF isplaywin == 0
		INVOKE PlaySoundA, OFFSET game_win, NULL, SND_ASYNC
		add isplaywin,1
	.ENDIF
	
	ret
playmusic_win ENDP

;----------------------------------------------------------------------------

;延遲遊戲畫面更新頻率
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

;動作指令監聽
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

;計算命中率(取小數點後三位)
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

;判斷氣球是否碰撞
bump PROC USES eax ebx ecx edx esi, 
	Posx : WORD, Posy : WORD

	;若已射完則不判斷碰撞
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
	;若不在氣球放置區的範圍內則不判斷碰撞
	.IF ax < blonPos0.y || ax >= dx
		jmp endbump
	.ENDIF
	mov cx, blonPos0.x
	mov dx, cx
	add dx, blonCol
	;若在氣球放置區的範圍內
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
		;判斷碰撞的氣球
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
    
endbump:	;結束碰撞判斷
    ret
bump ENDP

;炸彈功能 : 消除三直排氣球
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

;畫投射的剩餘次數
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

;畫出關卡氣球
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


;畫出十進位數字，往左或右對齊(靠左:0，靠右:1)
drawNum PROC USES eax ecx edx,
	num:DWORD,pos:COORD,LorR:BYTE

	push num
	;判斷位數並更新列印起始位置
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
	;依照位數將最高位的數字印出
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


;畫出命中率
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
;依位數畫出數字
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
;若命中率小於1%
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
;若命中率等於100%
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

;畫方格
drawSquareArea PROC USES eax ebx ecx esi,
	areaL:DWORD, areaW:DWORD, pos:COORD

	mov ecx, areaL
	dec ecx
	inc pos.x
	push ecx
;畫上方直線
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
;畫下方直線
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
;畫左方直線
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
;畫右方直線
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


;顯示記分板
drawScoreArea PROC 
draw:
	;顯示方格
	INVOKE drawSquareArea,squareScoreAreaL,squareScoreAreaW,squareScoreAreaPos
	;顯示目標擊破數
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordTargetW, wordTargetWLen, wordTargetWPos, ADDR cellsWritten
	INVOKE drawRate,TargetRate,wordtargetRatePos
	;顯示命中率
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRateW, wordRateWLen, wordRateWPos, ADDR cellsWritten
	INVOKE drawRate,resultRate,wordRatePos
	;顯示擊破數和氣球總數
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordScoreW, wordScoreWLen, wordScoreWPos, ADDR cellsWritten
	INVOKE drawNum, bumpNum,wordBumpNumPos,1
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordVirgule, 1, wordVirgulePOS, ADDR cellsWritten
	INVOKE drawNum, allBloon,wordAllBloonPos,0
	;顯示剩餘投射次數
	call drawShotNumIcon
	ret
drawScoreArea ENDP

;重玩時，重新繪製氣球，並重新計算氣球總數
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


;畫結算畫面的大字
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

; 松果飛行座標變化
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
	
; 根據速度移動
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

; 根據力度改變受到的重力
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

; 四捨五入Y座標
Posround:
	mov dartround, 0
	.IF darty2 >= 50
		mov dartround, -1
	.ELSEIF darty2 <= -50
		mov dartround, 1
	.ENDIF

; 檢查是否到底了
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

; 布雷森漢姆演算法
drawline PROC USES ebx eax ecx edx
; 線的起點是predartPos
; 線的終點是dartPos
; 因為需要畫的線都是steep
; 所以xy運算會對調
	push dartPos.y
	.IF dartround == 1
		inc dartPos.y
	.ELSEIF dartround == -1
		dec dartPos.y
	.ENDIF
; 斜率測試
steepTEST:
	mov ax, dartPos.y
	mov bx, predartPos.y
	sub ax, bx
	.IF ax < 2 && ax >=0 || ax > -2
		pop dartPos.y
		ret
	.ENDIF
; 初始化
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
; 斜率正負測試
y_stepTEST:
	mov ax, dartPos.y
	.IF bx > dartPos.y
		mov y_step, 1
	.ELSEIF bx <= 28 && ax >= 1000h
		mov y_step, 1
	.ELSE
		mov y_step, 0
	.ENDIF
; 飛行左右方向測試
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
	
; 迴圈畫線還有判斷碰撞
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

; 畫力度條框線
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

; 畫力度條
drawstrength PROC USES ebx
	.IF pressed == 0 && SPACE == 1
		mov pressed, 1
		jmp powerrun
	.ELSEIF pressed == 1 && SPACE == 1
		jmp powerrun
	.ELSEIF pressed == 1 && SPACE == 0
		CALL playmusic_throw		;撥放扔球音效
		mov phase, 3
		mov pressed, 0
		ret
	.ENDIF
	
; 力度條前後跑
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

; 畫發射角度預覽線
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

; 根據角度改變松果速度
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
	
; 畫預覽線
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

; 畫松果軌跡
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

;遊戲主程式
game1 PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE		;取得 Output Console Handle
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR CursorInfo		;隱藏Cursor

	CALL playmusic_g		;撥放背景音樂

;遊戲關卡初始化
INIT:
	mov phase, 0			;投射階段
	mov allBloon, 0			;氣球總數
	mov resultState, 0		;輸贏結果判斷
	mov resultChoose, 0		;結算選項選擇
	mov shotNum, 3			;可以投射的次數
	mov bumpNum, 0			;紀錄射破的氣球數
	mov resultRate, 0		;最後的命中率
	mov targetRate, 0		;目標命中率
	mov numDigit, 0			;數字的位數
	mov rateDigit, 0		;命中率位數
	mov angle, 15			;投射角度

	;還原氣球關卡配置，並計算氣球總數
	.IF levelNum == 1
		INVOKE replaceBloon,OFFSET bloons0,OFFSET bloons1
		mov targetRate, 400
	.ELSEIF	levelNum == 2
		INVOKE replaceBloon,OFFSET bloons0,OFFSET bloons2
		mov targetRate, 500
	.ENDIF

; 丟完松果初始化
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

; 投射前，調整投射角度時的初始化
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
	mov boolThrew, 0	;沒投射

	Call Clrscr
	;力度條顯示
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR colorpink, 4, blockPos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR spblock, 4, blockPos, ADDR cellsWritten

; 遊戲進行
START:
	CALL checkmusic_g		;檢查背景音樂狀態並循環撥放音樂

	;投射階段不重畫氣球
	.IF phase != 3
		call drawBalloon	
	.ENDIF
	
	call drawSqur@0			;顯示松鼠
	call drawdart			;顯示松果
	call drawframe			;顯示力度條
	call drawScoreArea		;顯示記分板

	;判斷目前階段
	.IF phase == 0
		jmp Initial0
	.ELSEIF phase == 1
		jmp phase1
	.ELSEIF phase == 2
		jmp phase2
	.ELSEIF phase == 3
		jmp phase3
	.ENDIF

; 調整角度階段
phase1:					
	Call drawangle
	INVOKE delayer2, 30
	Call ReadKey
	jz L2
	Call listener
L2:
	
	INVOKE delayer2, 30
	jmp Initial1

; 力度浮動階段
phase2:					
	INVOKE delayer2, 4
	Call ReadKey
	Call listener
	Call drawstrength		;更新力度條
	jmp Start

; 發射階段
phase3:					
	INVOKE delayer2, 3
	mov boolThrew, 1		;已投射
	Call dartrun			;松果飛行
	Call drawline			;顯示飛行路徑
	call calRate			;計算命中率
	jmp Start

;結算畫面
resultScr:
	call ClrScr

	;依照選擇，將目前選項變換顏色(紅)
	.IF resultChoose == 0
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attriRes4, wordRes4Len, wordRes4Pos, ADDR bytesWritten
	.ELSEIF resultChoose == 1
		INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attriRes5, wordRes5Len, wordRes5Pos, ADDR bytesWritten
	.ENDIF

	;依照結果，顯示輸贏字樣
	.IF resultState == 1
		INVOKE drawBigWord,OFFSET win1,win1Row,win1Col,win1Pos
		CALL playmusic_win		;撥放贏球音效
	.ELSEIF
		INVOKE drawBigWord,OFFSET lose1,lose1Row,lose1Col,lose1Pos
		CALL playmusic_lose		;撥放輸球音效
	.ENDIF

	;顯示結算畫面資訊
	;顯示方格
	INVOKE drawSquareArea,squareResAreaL,squareResAreaW,squareResAreaPos
	;顯示投射結果資訊
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes1, wordRes1Len, wordRes1Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes2, wordRes2Len, wordRes2Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes3, wordRes3Len, wordRes3Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes4, wordRes4Len, wordRes4Pos, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR wordRes5, wordRes5Len, wordRes5Pos, ADDR cellsWritten
	INVOKE drawRate,resultRate,wordResRatePos
	INVOKE drawNum,allBloon,wordResABPos,0
	INVOKE drawNum,bumpNum,wordResPopPos,0
	
	call Readkey
	jz resScrNoInput					;若沒動作
	;若有動作就判斷
	.IF ax == 4B00h	|| ax == 4800h		; leftarrow / uparrow
		mov resultChoose, 0
	.ELSEIF ax == 4D00h || ax == 5000h	; rightarrow / downarrow
		mov resultChoose, 1
	.ELSEIF ax == 1C0Dh					; ENTER
		jmp resScrEnter
	.ENDIF

;若沒動作
resScrNoInput:
	INVOKE delayer2, 30
	jmp resultScr

;若按下選擇
resScrEnter:
	mov isplaylose, 0		;歸零以便撥放音效
	mov isplaywin, 0		;歸零以便撥放音效
	.IF resultChoose == 0
		;開始新遊戲
		INVOKE mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0	;離開界面時關閉背景音樂
		call game1
	.ELSEIF resultChoose == 1
		;回到MENU
		INVOKE mciSendString, addr closegame_cd, addr buffer, sizeof buffer, 0	;離開界面時關閉背景音樂
	.ENDIF
		
	ret
game1 ENDP
END game1


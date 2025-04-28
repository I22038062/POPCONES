include Irvine32.inc

EXTERN main@0:PROC

.data
InfoCursor CONSOLE_CURSOR_INFO <1,0>
consoleHandle DWORD ?
cellsWritten DWORD ?
bytesWritten DWORD 0

title0 BYTE "GAMERULE"

;規則介面的標題，右邊顯示每行所占的半形字源數量，印到cmd時要再多加這些數字
gameRuleText1 BYTE " ███▌   ████▌  █     █  █████  ████    █   █  █      █████",0	;28
gameRuleText2 BYTE "█       █  █▌  ██   ██  █      █   █   █   █  █      █    ",0	;14
gameRuleText3 BYTE "█  ██   ████▌  █ █ █ █  ████   ████    █   █  █      █████",0	;26
gameRuleText4 BYTE "█   ▌   █  █▌  █  █  █  █      █   █   █   █  █      █    ",0	;13
gameRuleText5 BYTE " ███    █  █▌  █     █  █████  █   █   █████  ████▌  █████",0	;32

;遊戲規則
grule1 BYTE	"Rule1:Press the Enter key to access SETTINGS and select a gamemode.",0
grule2 BYTE	"Rule2:Press the Enter key to access START GAME and begin the game.",0
grule3 BYTE	"Rule3:Use the left and right arrow keys to adjust the shooting angle.",0
grule4 BYTE	"Rule4:Press the spacebar once to activate the power bar, and press it again to select the desired power level.",0
grule5 BYTE	"Rule5:Hit a certain number of balloons to clear the level.",0

;回到菜單
tomenu BYTE "(Press enter to return the menu)",0

;每行標題的初始位置
xy_t11 COORD <0,0>	
xy_t12 COORD <10,0>	
xy_t13 COORD <20,0>
xy_t14 COORD <30,0>
xy_t15 COORD <40,0>
xy_t16 COORD <50,0>
xy_t21 COORD <0,1>	
xy_t22 COORD <10,1>	
xy_t23 COORD <20,1>
xy_t24 COORD <30,1>
xy_t25 COORD <40,1>
xy_t26 COORD <50,1>
xy_t2 COORD <0,1>	
xy_t3 COORD <0,2>
xy_t4 COORD <0,3>
xy_t5 COORD <0,4>
xy_t6 COORD <0,5>
xy_t7 COORD <0,6>

;規則的初始位置
xy_r1 COORD <0,8>	
xy_r2 COORD <0,11>
xy_r3 COORD <0,14>
xy_r4 COORD <0,17>
xy_r5 COORD <0,20>

;回到菜單說明的初始位置
xy_menu COORD <45,25>

;黃色屬性
attri WORD 10 DUP(06h)

.code

;延遲規則介面更新頻率
delayer_rule PROC
	push ecx
	mov ecx, 300000000
L1:
	loop L1
	pop ecx
	ret
delayer_rule ENDP

gamerule PROC
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	INVOKE SetConsoleCursorInfo, consoleHandle, ADDR InfoCursor

    call ClrScr

	;印製標題顏色
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t11, ADDR bytesWritten	
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t12, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t13, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t14, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t15, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t16, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t21, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t22, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t23, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t24, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t25, ADDR bytesWritten
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri, 10, xy_t26, ADDR bytesWritten

	;印製標題文字
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gameRuleText1, 86, xy_t11, ADDR bytesWritten	
    INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gameRuleText2, 70, xy_t21, ADDR bytesWritten
    INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gameRuleText3, 84, xy_t3, ADDR bytesWritten
    INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gameRuleText4, 69, xy_t4, ADDR bytesWritten
    INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR gameRuleText5, 88, xy_t5, ADDR bytesWritten
    
	;印製規則文字
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR grule1, 67, xy_r1, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR grule2, 66, xy_r2, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR grule3, 69, xy_r3, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR grule4, 110, xy_r4, ADDR cellsWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR grule5, 58, xy_r5, ADDR cellsWritten

	;印製回到菜單說明的文字
	INVOKE WriteConsoleOutputCharacter, consoleHandle, ADDR tomenu, 32, xy_menu, ADDR cellsWritten

	call delayer_rule
	call Readkey
	jnz L_r
	jmp gamerule
L_r:
	.IF ax == 1C0Dh		;按下enter後回到菜單
		jmp endGM
	.ENDIF
	
	jmp gamerule

endGM:
    ret
gamerule ENDP

END gamerule
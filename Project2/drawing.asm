include Irvine32.inc
EXTERN boolThrew:BYTE

.data
bytesWritten DWORD 0	
consoleHandle DWORD ?
cellsWritten DWORD ?
;設為全域變數
PUBLIC bloons1			
PUBLIC bloons2
PUBLIC lose1
PUBLIC win1

;關卡1
bloons1 BYTE "                                               "
		BYTE "                                               "
		BYTE "                                               "
		BYTE "                                               "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE " OOOOOOOOO   OOO    OOO    OO    OO   OOOOOOOO "
		BYTE " OOOOOOOO OOOOOO OOO OO OOOOO OOOOO OO OOOOOOO "
		BYTE " OOOOOOOOO   OOO    OOO   OOO   OOO OO OOOOOOO "
		BYTE " OOOOOOOOOOOO OO OOOOOO OOOOO OOOOO OO OOOOOOO "
		BYTE " OOOOOOOO    OOO OOOOOO    OO    OO   OOOOOOOO "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE " OOOOO                                   OOOOO "
		BYTE " OOOOO         OOOOOOO  OOOOOOOO         OOOOO "
		BYTE " OOOOO        OO     OO OO               OOOOO "
		BYTE " OOOOO               OO OO               OOOOO "
		BYTE " OOOOO         OOOOOOO  OOOOOOO          OOOOO "
		BYTE " OOOOO        OO              OO         OOOOO "
		BYTE " OOOOO        OO        OO    OO         OOOOO "
		BYTE " OOOOO        OOOOOOOOO  OOOOOO          OOOOO "
		BYTE " OOOOO                                   OOOOO "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE " OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO "
        BYTE "                                               "
		BYTE "                                               "
		BYTE "                                               "
;關卡2
bloons2 BYTE "       .OOOOOOOOOOOOO.                         "
		BYTE "    .OOOOOOOOOOOOOOOOOOO.                      "
		BYTE " .OOOOOOOOOOOOOOOOOOOOOOOOO.                   "
		BYTE ".OOOOOOOOOOOOOOOOOOOOOOOOOOO                   "
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOO                  "
		BYTE "OOOOOOOOOOOOOO!OOOOOOOOOOOOOO                  "
		BYTE "OOOOOOOOOOOOOOOOOOOOOOOOOOOOO                  "
		BYTE "`OOOOOOOOOOOOOOOOOOOOOOOOOOO                   "
		BYTE "  `OOOOOOOOOOOOOOOOOOOOOOO                     "
		BYTE "     `OOOOOOOOOOOOOOOOO'  OOOOOOOOOOOO         "
		BYTE "       `OOOOOOOOOOOOO'.OOOOOOOOOOOOOOOOOO      "
		BYTE "         `OOOOOOOOO'OOOOOOOOOOOOOOOOOOOOOOOO,  "
		BYTE "           `OOOOO'.OOOOOOOOOOOOOOOOOOOOOOOOOO, "
		BYTE "             `OO' OOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE "             OOO  OOOOOOOOOOOOOO!OOOOOOOOOOOOO "
		BYTE "              '   OOOOOOOOOOOOOOOOOOOOOOOOOOOO "
		BYTE "             '    `OOOOOOOOOOOOOOOOOOOOOOOOOO' "
		BYTE "            '       `OOOOOOOOOOOOOOOOOOOOOO'   "
		BYTE "            `         `OOOOOOOOOOOOOOOOOO'     "
		BYTE "             `          `OOOOOOOOOOOOOO'       "
		BYTE "              `           `OOOOOOOOOO'         "
		BYTE "               '            `OOOOOO'           "
		BYTE "              '              `OOO'             "
		BYTE "                             .OO               "
		BYTE "                             OOO               "
		BYTE "                              '                "
		BYTE "                             '                 "
		 
;輸的顯示字樣
lose1	BYTE " __       ______   ______   ______     ",0
		BYTE "/_/\     /_____/\ /_____/\ /_____/\    ",0
		BYTE "\:\ \    \:::_ \ \\::::_\/_\::::_\/_   ",0
		BYTE " \:\ \    \:\ \ \ \\:\/___/\\:\/___/\  ",0
		BYTE "  \:\ \____\:\ \ \ \\_::._\:\\::___\/_ ",0
		BYTE "   \:\/___/\\:\_\ \ \ /____\:\\:\____/\",0
		BYTE "    \_____\/ \_____\/ \_____\/ \_____\/",0

;贏的顯示字樣
win1	BYTE " __ __ __    ________  ___   __      ",0
		BYTE "/_//_//_/\  /_______/\/__/\ /__/\    ",0
		BYTE "\:\\:\\:\ \ \__.::._\/\::\_\\  \ \   ",0
		BYTE " \:\\:\\:\ \   \::\ \  \:. `-\  \ \  ",0
		BYTE "  \:\\:\\:\ \  _\::\ \__\:. _    \ \ ",0
		BYTE "   \:\\:\\:\ \/__\::\__/\\. \`-\  \ \",0
		BYTE "    \_______\/\________\/ \__\/ \__\/",0

;松鼠圖案的資訊
squrRow DWORD 8			;松鼠圖案的Row數量
squrCol DWORD 19		;松鼠圖案的Column數量
squrPos COORD <0,12>	;松鼠圖案的左上角位置
attri_brwon WORD 19 DUP(06h)	;松鼠圖案的顏色(棕)
;松鼠準備動作圖案
squrrelDraw BYTE "         |\=.      "
			BYTE "         /  6',    "
			BYTE " .--.    \  .-'    "
			BYTE "/_   \   /  (      "
			BYTE "  )   | / `;\\     "
			BYTE " /   / /   ( ``    "
			BYTE "(    `'    _)_     "
			BYTE " `-==-'`""""""`    "
;松鼠投射動作圖案
squrrelThrew	BYTE "         |\=.      "
				BYTE "         /  6',    "
				BYTE " .--.    \  .-'    "
				BYTE "/_   \   /  (_     "
				BYTE "  )   | / `;--'    "
				BYTE " /   / /   (       "
				BYTE "(    `'    _)_     "
				BYTE " `-==-'`""""""`    "


.code

;顯示松鼠圖案
drawSqur PROC USES eax ebx ecx esi
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	.IF boolThrew == 0			;未投射
		mov esi, OFFSET squrrelDraw
	.ELSEIF boolThrew == 1		;已投射
		mov esi, OFFSET squrrelthrew
	.ENDIF
	
	mov ebx, squrCol
	xor ecx, ecx
	mov ecx, squrRow
	push ecx
drawS:
	push ecx
	INVOKE WriteConsoleOutputAttribute, consoleHandle, ADDR attri_brwon, 19, squrPos, ADDR bytesWritten
	INVOKE WriteConsoleOutputCharacter, consoleHandle, esi, squrCol, squrPos, ADDR bytesWritten
	pop ecx
	add esi, ebx
	inc squrPos.y 
	loop drawS

	pop ecx
	sub squrPos.y, cx
	ret
drawSqur ENDP

drawing PROC
	
	ret
drawing ENDP


END drawing 


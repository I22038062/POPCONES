include Irvine32.inc
EXTERN boolThrew:BYTE

.data
bytesWritten DWORD 0	
consoleHandle DWORD ?
cellsWritten DWORD ?
;�]�������ܼ�
PUBLIC bloons1			
PUBLIC bloons2
PUBLIC lose1
PUBLIC win1

;���d1
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
;���d2
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
		 
;�骺��ܦr��
lose1	BYTE " __       ______   ______   ______     ",0
		BYTE "/_/\     /_____/\ /_____/\ /_____/\    ",0
		BYTE "\:\ \    \:::_ \ \\::::_\/_\::::_\/_   ",0
		BYTE " \:\ \    \:\ \ \ \\:\/___/\\:\/___/\  ",0
		BYTE "  \:\ \____\:\ \ \ \\_::._\:\\::___\/_ ",0
		BYTE "   \:\/___/\\:\_\ \ \ /____\:\\:\____/\",0
		BYTE "    \_____\/ \_____\/ \_____\/ \_____\/",0

;Ĺ����ܦr��
win1	BYTE " __ __ __    ________  ___   __      ",0
		BYTE "/_//_//_/\  /_______/\/__/\ /__/\    ",0
		BYTE "\:\\:\\:\ \ \__.::._\/\::\_\\  \ \   ",0
		BYTE " \:\\:\\:\ \   \::\ \  \:. `-\  \ \  ",0
		BYTE "  \:\\:\\:\ \  _\::\ \__\:. _    \ \ ",0
		BYTE "   \:\\:\\:\ \/__\::\__/\\. \`-\  \ \",0
		BYTE "    \_______\/\________\/ \__\/ \__\/",0

;�Q���Ϯת���T
squrRow DWORD 8			;�Q���Ϯת�Row�ƶq
squrCol DWORD 19		;�Q���Ϯת�Column�ƶq
squrPos COORD <0,12>	;�Q���Ϯת����W����m
attri_brwon WORD 19 DUP(06h)	;�Q���Ϯת��C��(��)
;�Q���ǳưʧ@�Ϯ�
squrrelDraw BYTE "         |\=.      "
			BYTE "         /  6',    "
			BYTE " .--.    \  .-'    "
			BYTE "/_   \   /  (      "
			BYTE "  )   | / `;\\     "
			BYTE " /   / /   ( ``    "
			BYTE "(    `'    _)_     "
			BYTE " `-==-'`""""""`    "
;�Q����g�ʧ@�Ϯ�
squrrelThrew	BYTE "         |\=.      "
				BYTE "         /  6',    "
				BYTE " .--.    \  .-'    "
				BYTE "/_   \   /  (_     "
				BYTE "  )   | / `;--'    "
				BYTE " /   / /   (       "
				BYTE "(    `'    _)_     "
				BYTE " `-==-'`""""""`    "


.code

;��ܪQ���Ϯ�
drawSqur PROC USES eax ebx ecx esi
	INVOKE GetStdHandle, STD_OUTPUT_HANDLE
	mov consoleHandle, eax
	.IF boolThrew == 0			;����g
		mov esi, OFFSET squrrelDraw
	.ELSEIF boolThrew == 1		;�w��g
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


POPCONES - 一款用組合語言 (Assembly) 製作的輕鬆小遊戲，控制松果擊破氣球，挑戰關卡！

? 遊戲簡介

POPCONES 是一款玩家操控松果投擲，射破氣球的小遊戲，?單易上手，展示組合語言和運算模型能力。

? 遊戲玩法

使用 左、右方向鍵 調整投擲角度

使用 空白鍵 調整投擲力量

每場 3次投擲機會，盡可能破壞更多氣球

達到關卡門檻數量則通關，否則失敗

? 頁面結構

【 MENU 】主選單

【 GAME RULES 】遊戲觀念與操作說明

【 START 】開始遊戲

【 SETTING 】調整音量

【 EXIT 】退出遊戲

【 WIN/LOSE 】結算畫面

??? 程式結構

檔案名稱

功能描述

main.asm

主程式，處理主選單、設定和音樂操作

game1.asm

核心遊戲機制，投擲角度，力量調整，氣球碰擊判定

gamerule.asm

遊戲觀念與介面展示

levelstage.asm

關卡切換、預設關卡動畫效果

drawing.asm

畫面繪製（氣球、松果、投擲軌道等）

需使用 Irvine32.inc、winmm.lib、Kernel32.lib

? 遊戲畫面預覽

→ 主選單畫面

→ 遊戲機制說明

→ 關卡選擇

→ 遊戲運行中

→ 結算畫面 - 失敗/勝利

? 開發成員

資工二A  張峪銓 (112502514)

資工二A  譚智軒 (112502519)

資工二A  楊大正 (112502010)

資工二B  邵川祐 (112502026)

? 如何執行

確認安裝 MASM32 或相對的組合語言開發環境

將所有項目檔案和音效檔案放在指定路徑

? 注意事項

請確保音效檔案路徑正確，否則會無法正常播放音效

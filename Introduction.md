## 簡介 ##

* pacman-ps/
	* 調用samcv的[pacman-ps](https://gitlab.com/samcv/ps-lsof)的外圍工具
	* pacman-ps-graph
		* 使用graphviz繪製依賴/調用圖
	* pacman-ps-restart
		* 自動重啓一些適合重啓的軟件，以調用新版本的庫
* python/
	* hformat
		* 轉換數字單位使之更適合人類閱讀（類似free -h中的-h）
	* exif-reform
		* 整理exif時間信息，使得所有*數字化晚於創建*的時間全部統一爲創建時間
		* 接收一個參數，爲目標目錄；我的用途中僅處理了`*.jpg`文件
	* python-open-flags-reverse.py
		* 解釋open()函數的flags——現實flags數值對應的flag名稱
* shell/
	* backup/
		* 備份腳本（源自lilydjwg博客），通過syncall調用
		* syncall
			* 參數表：src dst [-w]
	* ckrepo
		* 檢查本地安裝的軟件，判斷是否和AUR中版本一致
		* 軟件名寫在腳本目錄下packages文件中，以空格分隔
		* 當有某倉庫收錄目標軟件時尤其有用
	* cmdscrot
		* 對命令行輸出進行長“截圖”（[說明](http://renyuneyun.is-programmer.com/2017/4/5/mimicing_long_screenshot_of_shell_output.209191.html)）
		* 依賴util-linux、ansi2html以及CutyCapt
	* cut-media
		* 刪除媒體（如音頻）的前或後幾秒，不進行重新編碼。
	* downyou
		* 調用you-get下載當前目錄下'urls'文件內列出的所有內容
		* 忽略所有以#開頭的行
	* gpg-remote
		* 對遠程文件（使用gpg）進行分離式簽名（結果放在遠程機器上）
	* loop-do
		* 循環執行啓動參數中的動作
		* 讀取標準輸入作爲參數補充；每行一次
	* maglink
		* 補全哈希成爲磁力鏈接（哈希正確性取決於用戶）
	* mirrow-window
		* 鏡像某一本地窗口
		* 僅支持X11；使用VNC
	* rx11vnc
		* Remote X11VNC
		* 通過遠程服務器中轉（ssh代理）x11vnc，以越過內網
	* uvcs
		* 自動升級VCS的版本庫
		* 將進入指定目錄，然後遞歸搜索子目錄，找到版本庫則不再繼續深入
	* wine32run
		* 爲後續（參數）命令設置32位wine環境

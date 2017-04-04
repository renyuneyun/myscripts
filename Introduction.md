## 簡介 ##
* shell/
	* ckrepo
		* 檢查本地安裝的軟件，判斷是否和AUR中版本一致
		* 軟件名寫在腳本目錄下packages文件中，以空格分隔
		* 當有某倉庫收錄目標軟件時尤其有用
	* wine32run
		* 爲後續（參數）命令設置32位wine環境
	* uvcs
		* 自動升級VCS的版本庫
		* 將進入指定目錄，然後遞歸搜索子目錄，找到版本庫則不再繼續深入
	* downyou
		* 調用you-get下載當前目錄下'urls'文件內列出的所有內容
		* 忽略所有以#開頭的行
	* backup/
		* 備份腳本（源自lilydjwg博客），通過syncall調用
		* syncall
			* 參數表：src dst [-w]
	* cmdscrot
		* 對命令行輸出進行長“截圖”（[說明](http://renyuneyun.is-programmer.com/2017/4/5/mimicing_long_screenshot_of_shell_output.209191.html)）
		* 依賴util-linux、ansi2html以及CutyCapt
* python/
	* hformat
		* 轉換數字單位使之更適合人類閱讀（類似free -h中的-h）
* pacman-ps/
	* 調用samcv的[pacman-ps](https://gitlab.com/samcv/ps-lsof)的外圍工具
	* pacman-ps-graph
		* 使用graphviz繪製依賴/調用圖
	* pacman-ps-restart
		* 自動重啓一些適合重啓的軟件，以調用新版本的庫

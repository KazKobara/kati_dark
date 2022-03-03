#!/usr/bin/env bash
# Script to make html version of Help/Markdown for FSWiki
#
# How to use:
# 1. Chrome で「名前を付けて保存」を選択し、「ウエブページ、完全」で Help_Markdown_for_FreeStyleWiki.htm へ保存。
# 2. 本スクリプトを実行
# 3. "Done"が表示されなければ途中でエラーになり終了

set -e
trap 'echo "Error: line $LINENO returned $?!"' ERR

HT_NAME=Help_Markdown_for_FreeStyleWiki
HT_FILE=${HT_NAME}.htm
HT_DIR=${HT_NAME}_files

# Remove redundant files.
(cd ${HT_DIR} && rm -f 'fswiki.png:Zone.Identifier' kati_dark.css)

# To UTF-8
nkf -w --in-place ${HT_FILE}

# Check if escape chars are not used.
hexdump -e '/1 "%02X "' ./${HT_FILE} | grep -qv 06
hexdump -e '/1 "%02X "' ./${HT_FILE} | grep -qv 15

# Line-by-line process first.
sed -E -i.bk "
s/EUC-JP/UTF-8/;
/<head>/a <meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self'\">;
/title=\"RSS\"/d;
s/\.\/${HT_DIR}\/kati_dark\.css/\.\.\/\.\.\/kati_dark\.css/;
s/http:\/\/localhost:8366\/wiki\.cgi\?page=Help%2FMarkdown#/#/g;
s/http:\/\/localhost:8366/\.\/${HT_DIR}/g;
s/<!--ここは表示されません。-->/\x15/;
" ${HT_FILE}

# Then buffer process.
sed -z -i.bk1 -E '
s/<\/div>[\n ]*/\x06/g; 
s/(<div class="adminmenu">)([^\x06]*)(\x06)//;
s/(<div class="plugin-calendar">)([^\x06]*)(\x06)//;
s/([\n ]*<h4><a href)(.*)(<h4> outline<\/h4>)/\n\3/;
s/(<div class="footer">)([^\x06]*)(\x06)//;
s/\x06/<\/div>\n/g;
s/-->[\n ]*/\x06/g; 
s/(<!--)([^\x06]*)(\x06)//g;
s/\x15/<!--ここは表示されません。-->/;
'  ${HT_FILE}

rm -f ${HT_FILE}.bk*
echo "Done"

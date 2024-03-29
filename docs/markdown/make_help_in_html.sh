#!/usr/bin/env bash
# Script to make html version of Help/Markdown for FSWiki
#   with LaTeX/MathJax3.
#
# How to use:
# 1. 本スクリプト中の以下の変数を確認または編集
#    - LATEST_HELP_MARKDOWN_WIKI
# 2. httpd-security-fswiki-local.conf の style-src を以下のように変更:
#    - https://cdn.jsdelivr.net/npm/mathjax@3/es5/ と 'unsafe-inline' を一時的に追加
#    - ハッシュ値 'sha*' を一時的に削除
#    (cf. https://kazkobara.github.io/kati_dark/docs/markdown/markdown_plugin_for_fswiki.html の追加設定)
# 3. Chrome で「名前を付けて保存」を選択し、「ウエブページ、完全」で Help_Markdown_for_FreeStyleWiki.htm へ保存。
# 4. 本スクリプトを実行
# 5. "Done"が表示されれば完了
# 6. 1.で保存したファイルをブラウザで開き確認
# 7. httpd-security-fswiki-local.conf の style-src を元に戻す。

LATEST_HELP_MARKDOWN_WIKI=~/git/dockerfile_fswiki_local_test/tmp/wikilatest/data/Help%2FMarkdown.wiki

set -e
trap 'echo "Error: line $LINENO returned $?!"' ERR

HT_NAME=Help_Markdown_for_FreeStyleWiki
HT_FILE=${HT_NAME}.htm
HT_DIR=${HT_NAME}_files

# Remove redundant files.
(cd ${HT_DIR} && rm -f 'fswiki.png:Zone.Identifier' 'favicon.ico:Zone.Identifier' kati_dark.css* ./*.js*)

# To UTF-8
nkf -w --in-place ${HT_FILE}

# Check if escape chars are not used.
hexdump -e '/1 "%02X "' ./${HT_FILE} | grep -qv 06
hexdump -e '/1 "%02X "' ./${HT_FILE} | grep -qv 15

# Line-by-line process first.
# The HTML file requires "style-src 'unsafe-inline'" since the MathJax style
# is saved in the 'style=' form of mjx-containers while online web pages
# do not require it (as long as CSS provides necessary styles on
# Chrome or Edge).

sed -E -i.bk "
s/EUC-JP/UTF-8/;
/<head>/a <meta http-equiv=\"Content-Security-Policy\" content=\"default-src 'self';\
 script-src 'self' https:\/\/cdn.jsdelivr.net\/npm\/mathjax@3\/es5\/tex-mml-chtml.js; \
 style-src 'self' 'unsafe-inline'; \
 font-src 'self' https:\/\/cdn.jsdelivr.net\/npm\/mathjax@3\/es5\/output\/chtml\/fonts\/;\">
/title=\"RSS\"/d;
s/${HT_DIR}\/kati_dark\.css/\.\.\/..\/kati_dark.css/;
s/http:\/\/localhost:8366\/wiki\.cgi\?page=Help%2FMarkdown#/#/g;
s/http:\/\/localhost:8366/.\/${HT_DIR}/g;
s/\.\/Help_Markdown_for_FreeStyleWiki_files\/tex-mml-chtml\.js\.ダウンロード/https:\/\/cdn.jsdelivr.net\/npm\/mathjax@3\/es5\/tex-mml-chtml.js/;
s/<!--ここは表示されません。-->/\x15/;
" ${HT_FILE}

# Then buffer process.
sed -z -i.bk1 -E '
s/<\/style>/\x06/g;
s/([\n \t\x0d\x0a\x20]*)(<style)([^\x06]*)(\x06)([\n \t\x0d\x0a\x20]*)//g;
s/<\/div>/\x06/g;
s/([\n \t]*)(<div class="adminmenu">)([^\x06]*)(\x06)([\n \t]*)/\n/;
s/([\n \t]*)(<div class="plugin-calendar">)([^\x06]*)(\x06)([\n \t]*)/\n/;
s/([\n \t]*)(<h4><a href)(.*)(<h4> outline<\/h4>)/\n\4/;
s/([\n \t]*)(<div class="footer">)([^\x06]*)(\x06)([\n \t]*)/\n/;
s/\x06([\n \t]*)/<\/div>\n/g;
s/-->/\x06/g;
s/([\n \t\x0d\x0a\x20]*)(<!--)([^\x06]*)(\x06)([\n \t\x0d\x0a\x20]*)/\n/g;
s/([\n \t\x0d\x0a\x20]*)(<meta)/\n  \2/g;
s/([\n \t\x0d\x0a\x20]*)(<link)/\n  \2/g;
s/([\n \t\x0d\x0a\x20]*)(<title)/\n  \2/;
s/([\n \t\x0d\x0a\x20]*)(<\/head)/\n\2/;
s/([\n \t\x0d\x0a\x20]*)(<body>)([\n \t\x0d\x0a\x20]*)/\n\2\n/;
s/([\n \t\x0d\x0a\x20]*)(<div class="main">)([\n \t\x0d\x0a\x20]*)/\n\2\n  /;
' ${HT_FILE}

# Line-by-line process again.
sed -E -i.bk "
/<head>/a \  <!-- This HTML file requires \"style-src 'unsafe-inline'\" since \
the MathJax style is saved in the 'style=' form of mjx-containers \
while online web pages do not require it (as long as CSS provides necessary \
styles on Chrome or Edge). -->
s/\x15/<!--ここは表示されません。-->/;
" ${HT_FILE}

rm -f ${HT_FILE}.bk*

# Copy latest Help/Markdown.wiki
cp ${LATEST_HELP_MARKDOWN_WIKI} .

echo "Done"

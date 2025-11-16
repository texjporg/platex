
if "%~1"=="install" goto :install
if "%~1"=="uninstall" goto :uninstall

rem strip platex.ltx

del /q platex.ltx plcore.ltx kinsoku.tex pldefs.ltx
del /q jy1mc.fd jy1gt.fd jt1mc.fd jt1gt.fd plext.sty
del /q ptrace.sty pfltrace.sty plexpl3.sty plexpl3.ltx

platex -kanji=jis plfmt.ins

del /q plfmt.log

rem strip jarticle.cls

del /q jarticle.cls jreport.cls jbook.cls jsize10.clo
del /q jsize11.clo jsize12.clo jbk10.clo jbk11.clo jbk12.clo
del /q tarticle.cls treport.cls tbook.cls tsize10.clo
del /q tsize11.clo tsize12.clo tbk10.clo tbk11.clo tbk12.clo

platex -kanji=jis plcls.ins

del /q plcls.log

rem strip pl209.def

del /q pl209.def oldpfont.sty jarticle.sty tarticle.sty
del /q jbook.sty tbook.sty jreport.sty treport.sty

platex -kanji=jis pl209.ins

del /q pl209.log

rem strip platexrelease.sty

del /q platexrelease.sty

platex -kanji=jis platexrelease.ins

del /q platexrelease.log

rem strip jltxdoc.cls

del /q jltxdoc.cls pldoc.tex Xins.ins

platex -kanji=jis pldocs.ins

del /q pldocs.log pldoc.tex Xins.ins

rem end strip

if "%~1"=="strip" exit /b 0

rem make format

platex-dev -ini -etex -jobname=platex-dev *platex.ini

rem platex.dvi

del /q platex.cfg

platex-dev -kanji=jis platex.dtx

mendex -J -f -s gglo.ist -o platex.gls platex.glo

platex-dev -kanji=jis platex.dtx

del /q platex.aux platex.log
del /q platex.glo platex.gls platex.ilg

rem platexrelease.dvi

del /q platex.cfg

platex-dev -kanji=jis platexrelease.dtx
platex-dev -kanji=jis platexrelease.dtx

del /q platexrelease.aux platexrelease.log

rem pldoc.dvi

del /q platex.cfg
del /q jltxdoc.cls pldoc.tex Xins.ins

platex -kanji=jis pldocs.ins

del /q pldoc.toc pldoc.idx pldoc.glo

echo. > ltxdoc.cfg

platex-dev -kanji=jis pldoc.tex

mendex -J -s gind.ist -d pldoc.dic -o pldoc.ind pldoc.idx
mendex -J -f -s gglo.ist -o pldoc.gls pldoc.glo

echo \includeonly{} > ltxdoc.cfg

platex-dev -kanji=jis pldoc.tex

echo. > ltxdoc.cfg

platex-dev -kanji=jis pldoc.tex

del /q *.aux *.log pldoc.toc pldoc.idx pldoc.ind pldoc.ilg
del /q pldoc.glo pldoc.gls pldoc.tex Xins.ins
del /q ltxdoc.cfg pldoc.dic

rem platexrelease.dvi

del /q platex.cfg

platex-dev -kanji=jis exppl2e.sty
platex-dev -kanji=jis exppl2e.sty

del /q exppl2e.aux exppl2e.log

rem platex-en.dvi

echo \newif\ifJAPANESE > platex.cfg

platex-dev -kanji=jis -jobname=platex-en platex.dtx

mendex -J -f -s gglo.ist -o platex-en.gls platex-en.glo

platex-dev -kanji=jis -jobname=platex-en platex.dtx

del /q platex-en.aux platex-en.log
del /q platex-en.glo platex-en.gls platex-en.ilg
del /q platex.cfg

rem pldoc-en.dvi

echo \newif\ifJAPANESE > platex.cfg

del /q jltxdoc.cls pldoc.tex Xins.ins

platex -kanji=jis pldocs.ins

del /q pldoc-en.toc pldoc-en.idx pldoc-en.glo

echo. > ltxdoc.cfg

platex-dev -kanji=jis -jobname=pldoc-en pldoc.tex

mendex -J -s gind.ist -d pldoc.dic -o pldoc-en.ind pldoc-en.idx
mendex -J -f -s gglo.ist -o pldoc-en.gls pldoc-en.glo

echo \includeonly{} > ltxdoc.cfg

platex-dev -kanji=jis -jobname=pldoc-en pldoc.tex

echo. > ltxdoc.cfg

platex-dev -kanji=jis -jobname=pldoc-en pldoc.tex

del /q *.aux *.log pldoc-en.toc pldoc-en.idx pldoc-en.ind pldoc-en.ilg
del /q pldoc-en.glo pldoc-en.gls pldoc.tex Xins.ins
del /q ltxdoc.cfg pldoc.dic
del /q platex.cfg

rem end doc

if not "%~1"=="all" exit /b 0

rem platex.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map platex.dvi

rem platexrelease.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map platexrelease.dvi

rem pldoc.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map pldoc.dvi

rem exppl2e.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map exppl2e.dvi

rem platex-en.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map platex-en.dvi

rem pldoc-en.pdf

dvipdfmx -f haranoaji.map -f ptex-haranoaji.map pldoc-en.dvi

rem end
exit /b 0


rem install
:install

mkdir "%USERPROFILE%\texmf\doc\platex\base"
copy /Y LICENSE     "%USERPROFILE%\texmf\doc\platex\base"
copy /Y README.md   "%USERPROFILE%\texmf\doc\platex\base"
copy /Y *.pdf       "%USERPROFILE%\texmf\doc\platex\base"

mkdir "%USERPROFILE%\texmf\source\platex\base"
copy /Y Makefile    "%USERPROFILE%\texmf\source\platex\base"
copy /Y plnews*.tex "%USERPROFILE%\texmf\source\platex\base"
copy /Y *.dtx       "%USERPROFILE%\texmf\source\platex\base"
copy /Y *.ins       "%USERPROFILE%\texmf\source\platex\base"

mkdir "%USERPROFILE%\texmf\tex\platex\base"
copy /Y kinsoku.tex "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.clo       "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.cls       "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.def       "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.fd        "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.ltx       "%USERPROFILE%\texmf\tex\platex\base"
copy /Y *.sty       "%USERPROFILE%\texmf\tex\platex\base"

mkdir "%USERPROFILE%\texmf\tex\platex\config"
copy /Y platex.ini  "%USERPROFILE%\texmf\tex\platex\config"

rem end install
exit /b 0


rem uninstall
:uninstall

rmdir /q /s "%USERPROFILE%\texmf\doc\platex\base"
rmdir /q /s "%USERPROFILE%\texmf\source\platex\base"
rmdir /q /s "%USERPROFILE%\texmf\tex\platex\base"
rmdir /q /s "%USERPROFILE%\texmf\tex\platex\config"

rem end uninstall
exit /b 0

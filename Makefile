STRIPTARGET = platex.ltx jarticle.cls pl209.def platexrelease.sty \
	jltxdoc.cls
DOCTARGET = platex platexrelease pldoc exppl2e \
	platex-en #pldoc-en
PDFTARGET = $(addsuffix .pdf,$(DOCTARGET))
DVITARGET = $(addsuffix .dvi,$(DOCTARGET))
TEXMF = $(shell kpsewhich -var-value=TEXMFHOME)

KANJI = -kanji=jis
#FONTMAP = -f ipaex.map -f ptex-ipaex.map
FONTMAP = -f haranoaji.map -f ptex-haranoaji.map
LTX = platex $(KANJI)
DPX = dvipdfmx $(FONTMAP)
MDX = mendex -J

default: $(STRIPTARGET) $(DVITARGET)
strip: $(STRIPTARGET)
all: $(STRIPTARGET) $(PDFTARGET)

PLFMT = platex.ltx plcore.ltx kinsoku.tex pldefs.ltx \
	jy1mc.fd jy1gt.fd jt1mc.fd jt1gt.fd plext.sty \
	ptrace.sty pfltrace.sty plexpl3.sty plexpl3.ltx

PLFMT_SRC = platex.dtx plvers.dtx plfonts.dtx plcore.dtx \
	kinsoku.dtx plext.dtx plexpl3.dtx

PLCLS = jarticle.cls jreport.cls jbook.cls jsize10.clo \
	jsize11.clo jsize12.clo jbk10.clo jbk11.clo jbk12.clo \
	tarticle.cls treport.cls tbook.cls tsize10.clo \
	tsize11.clo tsize12.clo tbk10.clo tbk11.clo tbk12.clo

PLCLS_SRC = jclasses.dtx

PL209 = pl209.def oldpfont.sty jarticle.sty tarticle.sty \
	jbook.sty tbook.sty jreport.sty treport.sty

PL209_SRC = pl209.dtx

PLREL = platexrelease.sty

PLREL_SRC = platexrelease.dtx $(PLFMT_SRC)

INTRODOC_SRC = platex.dtx

PLRELDOC_SRC = platexrelease.dtx

PLDOC_SRC = $(PLFMT_SRC) $(PLCLS_SRC) $(PL209_SRC) jltxdoc.dtx

platex.ltx: $(PLFMT_SRC)
	rm -f $(PLFMT)
	$(LTX) plfmt.ins
	rm plfmt.log

jarticle.cls: $(PLCLS_SRC)
	rm -f $(PLCLS)
	$(LTX) plcls.ins
	rm plcls.log

pl209.def: $(PL209_SRC)
	rm -f $(PL209)
	$(LTX) pl209.ins
	rm pl209.log

platexrelease.sty: $(PLREL_SRC)
	rm -f $(PLREL)
	$(LTX) platexrelease.ins
	rm platexrelease.log

jltxdoc.cls: jltxdoc.dtx
	rm -f jltxdoc.cls pldoc.tex Xins.ins
	$(LTX) pldocs.ins
	rm pldocs.log pldoc.tex Xins.ins

platex.dvi: $(INTRODOC_SRC)
	rm -f platex.cfg
	$(LTX) platex.dtx
	$(MDX) -f -s gglo.ist -o platex.gls platex.glo
	$(LTX) platex.dtx
	rm platex.aux platex.log
	rm platex.glo platex.gls platex.ilg

platexrelease.dvi: $(PLRELDOC_SRC)
	rm -f platex.cfg
	$(LTX) platexrelease.dtx
	$(LTX) platexrelease.dtx
	rm platexrelease.aux platexrelease.log

pldoc.dvi: $(PLDOC_SRC)
	rm -f platex.cfg
	rm -f jltxdoc.cls pldoc.tex Xins.ins
	$(LTX) pldocs.ins
	#
	#rm -f mkpldoc*.sh dstcheck.pl
	#$(LTX) Xins.ins
	#sh mkpldoc.sh
	#rm mkpldoc*.sh dstcheck.pl
	#
	rm -f pldoc.toc pldoc.idx pldoc.glo
	echo "" > ltxdoc.cfg
	$(LTX) pldoc.tex
	$(MDX) -s gind.ist -d pldoc.dic -o pldoc.ind pldoc.idx
	$(MDX) -f -s gglo.ist -o pldoc.gls pldoc.glo
	echo "\includeonly{}" > ltxdoc.cfg
	$(LTX) pldoc.tex
	echo "" > ltxdoc.cfg
	$(LTX) pldoc.tex
	#
	rm *.aux *.log pldoc.toc pldoc.idx pldoc.ind pldoc.ilg
	rm pldoc.glo pldoc.gls pldoc.tex Xins.ins
	rm ltxdoc.cfg pldoc.dic

exppl2e.dvi: exppl2e.sty
	rm -f platex.cfg
	$(LTX) exppl2e.sty
	$(LTX) exppl2e.sty
	rm exppl2e.aux exppl2e.log

platex-en.dvi: $(INTRODOC_SRC)
	# built-in echo in shell is troublesome, so use perl instead
	perl -e "print \"\\\\newif\\\\ifJAPANESE\\n"\" >platex.cfg
	$(LTX) -jobname=platex-en platex.dtx
	$(MDX) -f -s gglo.ist -o platex-en.gls platex-en.glo
	$(LTX) -jobname=platex-en platex.dtx
	rm platex-en.aux platex-en.log
	rm platex-en.glo platex-en.gls platex-en.ilg
	rm platex.cfg

pldoc-en.dvi: $(PLDOC_SRC)
	# built-in echo in shell is troublesome, so use perl instead
	perl -e "print \"\\\\newif\\\\ifJAPANESE\\n"\" >platex.cfg
	rm -f jltxdoc.cls pldoc.tex Xins.ins
	$(LTX) pldocs.ins
	#
	#rm -f mkpldoc*.sh dstcheck.pl
	#$(LTX) Xins.ins
	#sh mkpldoc-en.sh
	#rm mkpldoc*.sh dstcheck.pl
	#
	rm -f pldoc-en.toc pldoc-en.idx pldoc-en.glo
	echo "" > ltxdoc.cfg
	$(LTX) -jobname=pldoc-en pldoc.tex
	$(MDX) -s gind.ist -d pldoc.dic -o pldoc-en.ind pldoc-en.idx
	$(MDX) -f -s gglo.ist -o pldoc-en.gls pldoc-en.glo
	echo "\includeonly{}" > ltxdoc.cfg
	$(LTX) -jobname=pldoc-en pldoc.tex
	echo "" > ltxdoc.cfg
	$(LTX) -jobname=pldoc-en pldoc.tex
	#
	rm *.aux *.log pldoc-en.toc pldoc-en.idx pldoc-en.ind pldoc-en.ilg
	rm pldoc-en.glo pldoc-en.gls pldoc.tex Xins.ins
	rm ltxdoc.cfg pldoc.dic
	rm platex.cfg

platex.pdf: platex.dvi
	$(DPX) $<
platexrelease.pdf: platexrelease.dvi
	$(DPX) $<
pldoc.pdf: pldoc.dvi
	$(DPX) $<
exppl2e.pdf: exppl2e.dvi
	$(DPX) $<
platex-en.pdf: platex-en.dvi
	$(DPX) $<
pldoc-en.pdf: pldoc-en.dvi
	$(DPX) $<

.PHONY: install clean cleanstrip cleanall cleandoc
install:
	mkdir -p ${TEXMF}/doc/platex/base
	cp ./LICENSE ${TEXMF}/doc/platex/base/
	cp ./README.md ${TEXMF}/doc/platex/base/
	cp ./*.pdf ${TEXMF}/doc/platex/base/
#	cp ./*.txt ${TEXMF}/doc/platex/base/
	mkdir -p ${TEXMF}/source/platex/base
	cp ./Makefile ${TEXMF}/source/platex/base/
	cp ./plnews*.tex ${TEXMF}/source/platex/base/
	cp ./*.dtx ${TEXMF}/source/platex/base/
	cp ./*.ins ${TEXMF}/source/platex/base/
	mkdir -p ${TEXMF}/tex/platex/base
	cp ./kinsoku.tex ${TEXMF}/tex/platex/base/
	cp ./*.clo ${TEXMF}/tex/platex/base/
	cp ./*.cls ${TEXMF}/tex/platex/base/
	cp ./*.def ${TEXMF}/tex/platex/base/
	cp ./*.fd  ${TEXMF}/tex/platex/base/
	cp ./*.ltx ${TEXMF}/tex/platex/base/
	cp ./*.sty ${TEXMF}/tex/platex/base/
	mkdir -p ${TEXMF}/tex/platex/config
	cp ./platex.ini ${TEXMF}/tex/platex/config/
clean:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(DVITARGET) \
	jltxdoc.cls pldoc.tex Xins.ins
cleanstrip:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	jltxdoc.cls pldoc.tex Xins.ins
cleanall:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(DVITARGET) $(PDFTARGET) \
	jltxdoc.cls pldoc.tex Xins.ins
cleandoc:
	rm -f $(DVITARGET) $(PDFTARGET)

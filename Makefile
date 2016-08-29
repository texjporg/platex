TARGET1 = platex.ltx jarticle.cls pl209.def platexrelease.sty \
	nidanfloat.sty tascmac.sty jltxdoc.cls
TARGET2 = platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf exppl2e.pdf
TARGET3 = platex.dvi platexrelease.dvi pldoc.dvi \
	nidanfloat.dvi ascmac.dvi exppl2e.dvi
KANJI = -kanji=jis
FONTMAP = -f ipaex.map -f ptex-ipaex.map

default: $(TARGET1) $(TARGET3)
strip: $(TARGET1)
all: $(TARGET1) $(TARGET2)

PLFMT = platex.ltx plcore.ltx kinsoku.tex pldefs.ltx \
	jy1mc.fd jy1gt.fd jt1mc.fd jt1gt.fd plext.sty \
	ptrace.sty pfltrace.sty

PLFMT_SRC = platex.dtx plvers.dtx plfonts.dtx plcore.dtx \
	kinsoku.dtx plext.dtx

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

NIDAN = nidanfloat.sty

NIDAN_SRC = nidanfloat.dtx

ASCMAC = tascmac.sty ascmac.sty

ASCMAC_SRC = ascmac.dtx

INTRODOC_SRC = platex.dtx

PLRELDOC_SRC = platexrelease.dtx

PLDOC_SRC = platex.dtx plvers.dtx plfonts.dtx plcore.dtx plext.dtx \
	pl209.dtx kinsoku.dtx jclasses.dtx jltxdoc.dtx

platex.ltx: $(PLFMT_SRC)
	rm -f $(PLFMT)
	platex $(KANJI) plfmt.ins
	rm plfmt.log

jarticle.cls: $(PLCLS_SRC)
	rm -f $(PLCLS)
	platex $(KANJI) plcls.ins
	rm plcls.log

pl209.def: $(PL209_SRC)
	rm -f $(PL209)
	platex $(KANJI) pl209.ins
	rm pl209.log

platexrelease.sty: $(PLREL_SRC)
	rm -f $(PLREL)
	platex $(KANJI) platexrelease.ins
	rm platexrelease.log

nidanfloat.sty: $(NIDAN_SRC)
	rm -f $(NIDAN)
	platex $(KANJI) nidanfloat.ins
	rm nidanfloat.log

tascmac.sty: $(ASCMAC_SRC)
	rm -f $(ASCMAC)
	platex $(KANJI) ascmac.ins
	rm ascmac.log

jltxdoc.cls: jltxdoc.dtx
	rm -f jltxdoc.cls pldoc.tex Xins.ins
	platex $(KANJI) pldocs.ins
	rm pldoc.tex Xins.ins

platex.dvi: $(INTRODOC_SRC)
	platex $(KANJI) platex.dtx
	mendex -f -s gglo.ist -o platex.gls platex.glo
	platex $(KANJI) platex.dtx
	rm platex.aux platex.log
	rm platex.glo platex.gls platex.ilg

platexrelease.dvi: $(PLRELDOC_SRC)
	platex $(KANJI) platexrelease.dtx
	platex $(KANJI) platexrelease.dtx
	rm platexrelease.aux platexrelease.log

pldoc.dvi: $(PLDOC_SRC)
	rm -f jltxdoc.cls pldoc.tex Xins.ins
	platex $(KANJI) pldocs.ins
	rm -f mkpldoc.sh dstcheck.pl
	platex $(KANJI) Xins.ins
	sh mkpldoc.sh
	rm *.aux *.log pldoc.toc pldoc.idx pldoc.ind pldoc.ilg
	rm pldoc.glo pldoc.gls pldoc.tex Xins.ins
	rm ltxdoc.cfg pldoc.dic mkpldoc.sh dstcheck.pl

nidanfloat.dvi: $(NIDAN_SRC)
	platex $(KANJI) nidanfloat.dtx
	platex $(KANJI) nidanfloat.dtx
	rm nidanfloat.aux nidanfloat.log

ascmac.dvi: $(ASCMAC_SRC)
	platex $(KANJI) ascmac.dtx
	platex $(KANJI) ascmac.dtx
	rm ascmac.aux ascmac.log ascmac.toc

exppl2e.dvi: exppl2e.sty
	platex $(KANJI) exppl2e.sty
	platex $(KANJI) exppl2e.sty
	rm exppl2e.aux exppl2e.log

platex.pdf: platex.dvi
	dvipdfmx $(FONTMAP) platex.dvi
platexrelease.pdf: platexrelease.dvi
	dvipdfmx $(FONTMAP) platexrelease.dvi
pldoc.pdf: pldoc.dvi
	dvipdfmx $(FONTMAP) pldoc.dvi
nidanfloat.pdf: nidanfloat.dvi
	dvipdfmx $(FONTMAP) nidanfloat.dvi
ascmac.pdf: ascmac.dvi
	dvipdfmx $(FONTMAP) ascmac.dvi
exppl2e.pdf: exppl2e.dvi
	dvipdfmx $(FONTMAP) exppl2e.dvi

.PHONY: clean cleanstrip cleanall cleandoc
clean:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(NIDAN) $(ASCMAC) \
	platex.dvi platexrelease.dvi pldoc.dvi \
	nidanfloat.dvi ascmac.dvi exppl2e.dvi \
	jltxdoc.cls pldoc.tex Xins.ins
cleanstrip:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(NIDAN) $(ASCMAC) \
	jltxdoc.cls pldoc.tex Xins.ins
cleanall:
	rm -f $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(NIDAN) $(ASCMAC) \
	platex.dvi platexrelease.dvi pldoc.dvi \
	nidanfloat.dvi ascmac.dvi exppl2e.dvi \
	platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf exppl2e.pdf \
	jltxdoc.cls pldoc.tex Xins.ins
cleandoc:
	rm -f \
	platex.dvi platexrelease.dvi pldoc.dvi \
	nidanfloat.dvi ascmac.dvi exppl2e.dvi \
	platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf exppl2e.pdf

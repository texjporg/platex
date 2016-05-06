TARGET1 = platex.ltx jarticle.cls pl209.def platexrelease.sty \
	nidanfloat.sty tascmac.sty
TARGET2 = platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf

all: $(TARGET1) $(TARGET2)

PLFMT = platex.ltx plcore.ltx kinsoku.tex pldefs.ltx \
	jy1mc.fd jy1gt.fd jt1mc.fd jt1gt.fd plext.sty ptrace.sty

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
	platex --kanji=jis plfmt.ins
	rm plfmt.log

jarticle.cls: $(PLCLS_SRC)
	platex --kanji=jis plcls.ins
	rm plcls.log

pl209.def: $(PL209_SRC)
	platex --kanji=jis pl209.ins
	rm pl209.log

platexrelease.sty: $(PLREL_SRC)
	platex --kanji=jis platexrelease.ins
	rm platexrelease.log

nidanfloat.sty: $(NIDAN_SRC)
	platex --kanji=jis nidanfloat.ins
	rm nidanfloat.log

tascmac.sty: $(ASCMAC_SRC)
	platex --kanji=jis ascmac.ins
	rm ascmac.log

platex.pdf: $(INTRODOC_SRC)
	platex --kanji=jis platex.dtx && \
	platex --kanji=jis platex.dtx && \
	dvipdfmx platex.dvi
	rm platex.aux platex.log platex.dvi

platexrelease.pdf: $(PLRELDOC_SRC)
	platex --kanji=jis platexrelease.dtx && \
	platex --kanji=jis platexrelease.dtx && \
	dvipdfmx platexrelease.dvi
	rm platexrelease.aux platexrelease.log platexrelease.dvi

pldoc.pdf: $(PLDOC_SRC)
	for x in jltxdoc.cls pldoc.tex Xins.ins; do \
	if [ -e $$x ]; then rm $$x; fi \
	done
	platex --kanji=jis pldocs.ins && \
	platex --kanji=jis Xins.ins && sh mkpldoc.sh && \
	dvipdfmx pldoc.dvi
	rm *.aux *.log pldoc.toc pldoc.idx pldoc.ind pldoc.ilg
	rm pldoc.glo pldoc.gls *.dvi pldoc.tex Xins.ins
	rm *.cfg pldoc.dic mkpldoc.sh dstcheck.pl

nidanfloat.pdf: $(NIDAN_SRC)
	platex --kanji=jis nidanfloat.dtx && \
	platex --kanji=jis nidanfloat.dtx && \
	dvipdfmx nidanfloat.dvi
	rm nidanfloat.aux nidanfloat.log nidanfloat.dvi

ascmac.pdf: $(ASCMAC_SRC)
	platex --kanji=jis ascmac.dtx && \
	platex --kanji=jis ascmac.dtx && \
	dvipdfmx ascmac.dvi
	rm ascmac.aux ascmac.log ascmac.toc ascmac.dvi

.PHONY: clean
clean:
	for x in $(PLFMT) $(PLCLS) $(PL209) $(PLREL) \
	$(NIDAN) $(ASCMAC) \
	platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf \
	jltxdoc.cls pldoc.tex Xins.ins; do \
	if [ -e $$x ]; then rm $$x; fi \
	done

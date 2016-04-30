all: platex.ltx jarticle.cls pl209.def platexrelease.sty \
	nidanfloat.sty tascmac.sty \
	platex.pdf platexrelease.pdf pldoc.pdf \
	nidanfloat.pdf ascmac.pdf

.PHONY: $(TARGET1) $(TARGET2)

platex.ltx:
	platex --kanji=jis plfmt.ins
	rm plfmt.log

jarticle.cls:
	platex --kanji=jis plcls.ins
	rm plcls.log

pl209.def:
	platex --kanji=jis pl209.ins
	rm pl209.log

platexrelease.sty:
	platex --kanji=jis platexrelease.ins
	rm platexrelease.log

nidanfloat.sty:
	platex --kanji=jis nidanfloat.ins
	rm nidanfloat.log

tascmac.sty:
	platex --kanji=jis ascmac.ins
	rm ascmac.log

platex.pdf:
	platex --kanji=jis platex.dtx && \
	platex --kanji=jis platex.dtx && \
	dvipdfmx platex.dvi
	rm platex.aux platex.log platex.dvi

platexrelease.pdf:
	platex --kanji=jis platexrelease.dtx && \
	platex --kanji=jis platexrelease.dtx && \
	dvipdfmx platexrelease.dvi
	rm platexrelease.aux platexrelease.log platexrelease.dvi

pldoc.pdf:
	for x in jltxdoc.cls pldoc.tex Xins.ins; do \
	if [ -e $$x ]; then rm $$x; fi \
	done
	platex --kanji=jis pldocs.ins && \
	platex --kanji=jis Xins.ins && sh mkpldoc.sh && \
	dvipdfmx pldoc.dvi
	rm *.aux *.log pldoc.toc pldoc.idx pldoc.ind pldoc.ilg
	rm pldoc.glo pldoc.gls *.dvi
	rm *.cfg pldoc.dic mkpldoc.sh dstcheck.pl

nidanfloat.pdf:
	platex --kanji=jis nidanfloat.dtx && \
	platex --kanji=jis nidanfloat.dtx && \
	dvipdfmx nidanfloat.dvi
	rm nidanfloat.aux nidanfloat.log nidanfloat.dvi

ascmac.pdf:
	platex --kanji=jis ascmac.dtx && \
	platex --kanji=jis ascmac.dtx && \
	dvipdfmx ascmac.dvi
	rm ascmac.aux ascmac.log ascmac.toc ascmac.dvi

#!/bin/bash
make platex.ltx
platex-dev -ini -etex platex.ini
yes | platex pldocs.ins
platex -fmt=./platex pldoc
dvipdfmx pldoc

cd tests
platex -fmt=../platex -jobname=float-footnote-2506 float-footnote.tex \
  && dvipdfmx float-footnote-2506
platex -jobname=float-footnote-2411 float-footnote \
  && dvipdfmx float-footnote-2411
pdflatex  float-footnote-compare
cd ..

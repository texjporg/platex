#!/bin/bash
make platex.ltx
platex-dev -ini -etex platex.ini
yes | platex pldocs.ins
platex -fmt=./platex pldoc
dvipdfmx pldoc

cd tests
platex --progname=platex-dev -fmt=../platex -jobname=float-footnote-2506 float-footnote.tex \
  && dvipdfmx float-footnote-2506
platex -jobname=float-footnote-2411 float-footnote \
  && dvipdfmx float-footnote-2411
platex  float-footnote-compare && dvipdfmx float-footnote-compare
cd ..

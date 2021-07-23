# platex

pLaTeX is a Japanese version of LaTeX, which runs on pTeX
(a TeX engine with extensions for Japanese typesetting).
This bundle provides the macros and settings needed to generate
the pLaTeX format (named "pLaTeX2e") and some classes.

Note: This is a community edition maintained by
[Japanese TeX Development Community](http://texjp.org),
which forked from the original ASCII edition; see below.

## Repository

This bundle is maintained on GitHub:
https://github.com/texjporg/platex

If you have issues, please let us know from the page above.

## Changes from the original ASCII edition

The macros were originally developed by ASCII Corporation
(a publishing company in Japan).
We, Japanese TeX Development Community, have created a fork
to work with the latest version of TeX Live.

The original ASCII edition, pLaTeX2e 2006/11/10,
was based on pTeX-3.1.10 and LaTeX2e 2005/12/01.
It can be obtained from the link below:
- https://asciidwango.github.io/ptex/base/sources.html#platex

The community edition (this bundle) has the following advantages:

- Fix several bugs in pLaTeX2e format and packages.
- Fix macros which are inconsistent with the latest pTeX
  (e.g. \footnote, tabular, \parbox, \underline).
- Support LaTeX2e 2015/01/01 and later versions.
- Add platexrelease.sty. As with the latexrelease package, this
  package enables us to use the old versions of pLaTeX2e (from
  2006/11/10 the ASCII edition).

See the documents (platex.pdf, pldoc.pdf, platexrelease.pdf)
for more information.

## Documentation

A brief exposition of pLaTeX2e is provided in platex.pdf.
The document can be obtained by executing the following commands:

    platex platex.dtx
    dvipdfmx platex.dvi

The comprehensive explanation of pLaTeX2e source is included in
pldoc.pdf. If you are interested in typesetting pldoc.tex yourself,
the following commands will be helpful:

    platex pldocs.ins
    platex Xins.ins
    sh mkpldoc.sh
    dvipdfmx pldoc.dvi

## Character encoding

All the text files containing Japanese characters in this repository
are encoded in ISO-2022-JP. This is because ISO-2022-JP encoded
texts are most suitable for the traditional pTeX engine.

## License

The bundle may be distributed and/or modified under the terms of
the 3-clause BSD license (see [LICENSE](./LICENSE)).

## Release Date

$RELEASEDATE

Japanese TeX Development Community

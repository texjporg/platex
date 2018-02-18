%%
%% This is file `jltxdoc.cls',
%% generated with the docstrip utility.
%%
%% The original source files were:
%%
%% jltxdoc.dtx  (with options: `class')
%% 
%% Copyright (c) 2010 ASCII MEDIA WORKS
%% Copyright (c) 2016-2018 Japanese TeX Development Community
%% 
%% This file is part of the pLaTeX2e system (community edition).
%% -------------------------------------------------------------
%% 
%% File: jltxdoc.dtx
\NeedsTeXFormat{pLaTeX2e}
\ProvidesClass{jltxdoc}[2017/09/24 v1.0d Standard pLaTeX file]
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ltxdoc}}
\ProcessOptions
\LoadClass{ltxdoc}
\renewcommand{\normalsize}{%
    \@setfontsize\normalsize\@xpt{15}%
  \abovedisplayskip 10\p@ \@plus2\p@ \@minus5\p@
  \abovedisplayshortskip \z@ \@plus3\p@
  \belowdisplayshortskip 6\p@ \@plus3\p@ \@minus3\p@
   \belowdisplayskip \abovedisplayskip
   \let\@listi\@listI}
\renewcommand{\small}{%
  \@setfontsize\small\@ixpt{11}%
  \abovedisplayskip 8.5\p@ \@plus3\p@ \@minus4\p@
  \abovedisplayshortskip \z@ \@plus2\p@
  \belowdisplayshortskip 4\p@ \@plus2\p@ \@minus2\p@
  \def\@listi{\leftmargin\leftmargini
              \topsep 4\p@ \@plus2\p@ \@minus2\p@
              \parsep 2\p@ \@plus\p@ \@minus\p@
              \itemsep \parsep}%
  \belowdisplayskip \abovedisplayskip}
\normalsize
\setlength\parindent{1zw}
\providecommand*{\file}[1]{\texttt{#1}}
\providecommand*{\pstyle}[1]{\textsl{#1}}
\providecommand*{\Lcount}[1]{\textsl{\small#1}}
\providecommand*{\Lopt}[1]{\textsf{#1}}
\providecommand\dst{{\normalfont\scshape docstrip}}
\providecommand\NFSS{\textsf{NFSS}}
\newcounter{@clineno}
\def\mlineplus#1{\setcounter{@clineno}{\arabic{CodelineNo}}%
   \addtocounter{@clineno}{#1}\arabic{@clineno}}
\def\tsample#1{%
  \hbox to\linewidth\bgroup\vrule width.1pt\hss
    \vbox\bgroup\hrule height.1pt
      \vskip.5\baselineskip
      \vbox to\linewidth\bgroup\tate\hsize=#1\relax\vss}
\def\endtsample{%
      \vss\egroup
      \vskip.5\baselineskip
    \hrule height.1pt\egroup
  \hss\vrule width.1pt\egroup}
\def\DisableCrossrefs{\@bsphack\scan@allowedfalse\@esphack}
\def\EnableCrossrefs{\@bsphack\scan@allowedtrue
   \def\DisableCrossrefs{\@bsphack\scan@allowedfalse\@esphack}\@esphack}
\def\verb{\relax\ifmmode\hbox\else\leavevmode\vadjust{}\fi
  \bgroup \let\do\do@noligs \verbatim@nolig@list
    \ttfamily \verb@eol@error \let\do\@makeother \dospecials
    \@ifstar{\@sverb}{\@vobeyspaces \frenchspacing \@sverb}}
\xspcode"5C=3 %% \
\xspcode"22=3 %% "
\endinput
%%
%% End of file `jltxdoc.cls'.

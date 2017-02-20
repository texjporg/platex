## 
##  This is file `dstcheck.pl',
##  generated with the docstrip utility.
## 
##  The original source files were:
## 
##  platex.dtx  (with options: `plprog')
##  
##  File: platex.dtx
##
## DOCSTRIP 文書内の環境や条件の入れ子を調べる perl スクリプト
##
push(@dst,"DUMMY"); push(@dst,"000");
push(@env,"DUMMY"); push(@env,"000");
while (<>) {
  if (/^%<\*([^>]+)>/) { # check conditions
    push(@dst,$1);
    push(@dst,$.);
  } elsif (/^%<\/([^>]+)>/) {
    $linenum = pop(@dst);
    $conditions = pop(@dst);
    if ($1 ne $conditions) {
      if ($conditions eq "DUMMY") {
        print "$ARGV: `</$1>' (l.$.) is not started.\n";
        push(@dst,"DUMMY");
        push(@dst,"000");
      } else {
        print "$ARGV: `<*$conditions>' (l.$linenum) is ended ";
        print "by `<*$1>' (l.$.)\n";
      }
    }
  }
  if (/^% *\\begin\{verbatim\}/) { # check environments
    while(<>) {
        last if (/^% *\\end\{verbatim\}/);
    }
  } elsif (/^% *\\begin\{([^{}]+)\}\{(.*)\}/) {
    push(@env,$1);
    push(@env,$.);
  } elsif (/^% *\\begin\{([^{}]+)\}/) {
    push(@env,$1);
    push(@env,$.);
  } elsif (/^% *\\end\{([^{}]+)\}/) {
    $linenum = pop(@env);
    $environment = pop(@env);
    if ($1 ne $environment) {
      if ($environment eq "DUMMY") {
        print "$ARGV: `\\end{$1}' (l.$.) is not started.\n";
        push(@env,"DUMMY");
        push(@env,"000");
      } else {
        print "$ARGV: \\begin{$environement} (l.$linenum) is ended ";
        print "by \\end{$1} (l.$.)\n";
      }
    }
  }
}
$linenum = pop(@dst);
$conditions = pop(@dst);
while ($conditions ne "DUMMY") {
    print "$ARGV: `<*$conditions>' (l.$linenum) is not ended.\n";
    $linenum = pop(@dst);
    $conditions = pop(@dst);
}
$linenum = pop(@env);
$environment = pop(@env);
while ($environment ne "DUMMY") {
    print "$ARGV: `\\begin{$environment}' (l.$linenum) is not ended.\n";
    $linenum = pop(@env);
    $environment = pop(@env);
}
exit;
##  
## 
##  End of file `dstcheck.pl'.

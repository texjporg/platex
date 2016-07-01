#!/bin/sh

PROJECT=platex
TMP=/tmp
PWDF=`pwd`
LATESTRELEASEDATE=`git tag | sort -r | head -n 1`
RELEASEDATE=`git tag --points-at HEAD | sort -r | head -n 1`

if [ -z "$RELEASEDATE" ]; then
    RELEASEDATE="**not tagged**; later than $LATESTRELEASEDATE?"
fi

echo " * Create $PROJECT.tds.zip"
git archive --format=tar --prefix=$PROJECT/ HEAD | (cd $TMP && tar xf -)
rm $TMP/$PROJECT/.gitignore
rm $TMP/$PROJECT/create_archive.sh
rm -rf $TMP/$PROJECT/tests
perl -pi.bak -e "s/\\\$RELEASEDATE/$RELEASEDATE/g" $TMP/$PROJECT/README.md
rm -f $TMP/$PROJECT/README.md.bak

mkdir -p $TMP/$PROJECT/doc/platex/base
mv $TMP/$PROJECT/LICENSE $TMP/$PROJECT/doc/platex/base/
mv $TMP/$PROJECT/README.md $TMP/$PROJECT/doc/platex/base/
mv $TMP/$PROJECT/*.pdf $TMP/$PROJECT/doc/platex/base/
mv $TMP/$PROJECT/*.txt $TMP/$PROJECT/doc/platex/base/

mkdir -p $TMP/$PROJECT/source/platex/base
mv $TMP/$PROJECT/Makefile $TMP/$PROJECT/source/platex/base/
mv $TMP/$PROJECT/plnews* $TMP/$PROJECT/source/platex/base/
mv $TMP/$PROJECT/*.dtx $TMP/$PROJECT/source/platex/base/
mv $TMP/$PROJECT/*.ins $TMP/$PROJECT/source/platex/base/

mkdir -p $TMP/$PROJECT/tex/platex/base
mv $TMP/$PROJECT/kinsoku.tex $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.clo $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.cls $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.def $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.fd  $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.ltx $TMP/$PROJECT/tex/platex/base/
mv $TMP/$PROJECT/*.sty $TMP/$PROJECT/tex/platex/base/

mkdir -p $TMP/$PROJECT/tex/platex/config
mv $TMP/$PROJECT/platex.ini $TMP/$PROJECT/tex/platex/config/

cd $TMP/$PROJECT && zip -r $TMP/$PROJECT.tds.zip *
cd $PWDF
rm -rf $TMP/$PROJECT

echo
echo " * Create $PROJECT.zip ($RELEASEDATE)"
git archive --format=tar --prefix=$PROJECT/ HEAD | (cd $TMP && tar xf -)
# Remove generated and auxiliary files
rm $TMP/$PROJECT/.gitignore
rm $TMP/$PROJECT/create_archive.sh
rm -rf $TMP/$PROJECT/tests
rm $TMP/$PROJECT/kinsoku.tex
rm $TMP/$PROJECT/pl209.def
ls $TMP/$PROJECT/*.cls | grep -v plnews.cls | xargs rm
rm $TMP/$PROJECT/*.clo
rm $TMP/$PROJECT/*.fd
rm $TMP/$PROJECT/*.ltx
ls $TMP/$PROJECT/*.sty | grep -v exppl2e.sty | xargs rm
perl -pi.bak -e "s/\\\$RELEASEDATE/$RELEASEDATE/g" $TMP/$PROJECT/README.md
rm -f $TMP/$PROJECT/README.md.bak

cd $TMP && zip -r $PWDF/$PROJECT.zip $PROJECT $PROJECT.tds.zip
rm -rf $TMP/$PROJECT $TMP/$PROJECT.tds.zip
echo
echo " * Done: $PROJECT.zip ($RELEASEDATE)"

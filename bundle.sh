#!/bin/bash
set -e -o pipefail

usage()
{
cat << EOUSAGE

bundle.sh

Bundles an exercise.


USAGE: ./bundle.sh [OPTIONS] NAME

OPTIONS:
	-s 	Sign tar file
	-p	Generate pdf
	-c 	Tar the directory
	-t 	Test

EOUSAGE
}

compress()
{
	PROJ="${1}"
	TMPDIR=`mktemp -d`
	#mkdir -p "${TMPDIR}/$1"
	rsync -avp --exclude='.git/' --include='prettyprint.pdf' --exclude='prettyprint.tex' --exclude='.bundleinclude' --filter=':+ .bundleinclude' --exclude='.gitignore' --filter=':- .gitignore' --filter=':- .gitignore'  "/home/ben/projects/exercise-fprog/$1" "${TMPDIR}"
	tar -czvf "${PROJ}.tar.gz" -C ${TMPDIR} .

	[[ -d "$TMPDIR" ]] && {
    	echo "Remove $TMPDIR"
    	rm -rf -- "$TMPDIR"
	}
}

sign()
{
	PROJ="${1}"
	gpg --detach-sign -a "${PROJ}.tar.gz"
}

pdf()
{
	PROJ="${1}"
	TMPDIR=`mktemp -d`
	rsync -avp --exclude='.git/' --exclude='prettyprint.pdf' --include='prettyprint.tex' --exclude='.bundleinclude' --filter=':+ .bundleinclude' --exclude='.gitignore' --filter=':- .gitignore'  "/home/ben/projects/exercise-fprog/$1" "${TMPDIR}"
	OLDPWD=$PWD
	cd "${TMPDIR}/${PROJ}"
	latexdockercmd.sh pdflatex ./prettyprint.tex && rm prettyprint.aux prettyprint.log prettyprint.out
	cp prettyprint.pdf "${OLDPWD}/${PROJ}"
	cd ${OLDPWD}
	[[ -d "$TMPDIR" ]] && {
        echo "Remove $TMPDIR"
        rm -rf -- "$TMPDIR"
	}
}

testing()
{
	PROJ="${1}"
	TAR="${PROJ}.tar.gz"
	SIG="${PROJ}.tar.gz.asc"
	if [ ! -e "$TAR" ];then
		echo "Tar does not exist"
		exit 1
	else
		echo "## Tar exists"
	fi
	if [ ! -e "$SIG" ];then
		echo "Sig does not exist"
		exit 1
	else
		echo "## Sig exists"
	fi

	gpg --verify-files "${SIG}"
	if [ "$?" -ne "0" ]; then
		echo "Wrong signature"
		exit 1
	else
		echo "## File verfied"
	fi

	CONTENTS=$(tar -tvf "${TAR}")
	for line in "${CONTENTS[@]}" ; do
	    echo "$line"
	done
}

COMPRESS=
SIGN=
PDF=
TEST=
while getopts ":cspth" flag
do
  case "$flag" in
    h)
      usage
      exit 0
      ;;
    c)
	  COMPRESS=true
      ;;
    s)
	  SIGN=true
	  ;;
	p)
      PDF=true
	  ;;
	t)
	  TEST=true
	  ;;
    ?)
      usage
      exit 1
      ;;
  esac
done
shift $((OPTIND-1))

PROJ="${@%/}"
if [ ! -d "$PROJ" ]; then
	echo "No valid project given: ${PROJ}"
	exit 1
fi

if [ ! -z "$PDF" ]; then
	echo "# Creating pdf"
	pdf "${PROJ}"
fi

if [ ! -z "$COMPRESS" ]; then
	echo "# Compressing"
	compress "${PROJ}"
fi

if [ ! -z "$SIGN" ]; then
	echo "# Signing"
	sign "${PROJ}"
fi

if [ ! -z "$TEST" ]; then
	echo "# Testing"
	testing "${PROJ}"
fi


echo "OK"

exit 0
#!/bin/bash
DIR=$PWD
IN=content
OUT=build

function parse {
	local LIN=$1
	local LOUT=$2
	for FILE in $LIN/*
		do
			[ ! -d $OUT/$LOUT ] && mkdir -v $OUT/$LOUT
			if [ -f $FILE ];
				then
					local NAME=$(basename $FILE .md)
					echo "Transforming $FILE"
					pandoc -d ./Defaults -s -f markdown -t html5 $FILE -o $OUT/$LOUT/$NAME.html
			fi
			if [ -d $FILE ];
				then
					parse $FILE $(basename $FILE)
			fi
		done
}

function build {
	# loop $1=input $2=output
	parse $1 $2

	# todo:
	# - watch scss -> $OUT/*.css
	# - watch scripts  -> $OUT/*.js

	# copy these files if they exist
	[ -f src/theme.css ] && cp src/theme.css $OUT/theme.css
	[ -f src/app.js ] && cp src/app.js $OUT/app.js
}

echo "Initializing static-site generation..."
build $DIR/$IN
echo "Static-site generation complete."
#!/bin/mksh

list="\
$(find src/ -type f -name '*.txt' -o -name '*.wshtml' \
	| awk -F'/[^/]*$' '{print $1}' | sort -u | cut -d '/' -f 2- \
	| while read dir; do
		edir="$(print $dir | sed -e 's/\//\\\//g')"
		tdir="$(print $edir | sed -e 's/-/\ /g')"
		if [ -f src/"$dir"/index.txt ] || [ -f src/"$dir"/index.wshtml ]; then
			printf '%s' "\<li\>\<a\ href\=\"\\/$edir\\/\"\>$tdir\<\\/a\>"
		else
			printf '%s' "\<li\>$tdir"
		fi
		CONTENTS="$(find src/"$dir"/ -maxdepth 1 -type f \( -name '*.txt' -o -name '*.wshtml' \) ! -name 'index.*')"
		if [ -n "$CONTENTS" ]; then
			printf '%s\n' "\<ul\>\\"
			print "$CONTENTS" | sort \
			| while read file; do
				t="$(printf '%s' "$file" | sed 's#.*/##')"
				printf '%s' "\<li\>\<a\ href\=\"\\/$edir\\/"
				printf '%s' "$t" | sed -e 's/\.txt$/\.html/' -e 's/\.wshtml$/\.html/' -e 's/\ /\%20/'
				printf '%s\n' "\"\>$t\<\\/a\>\<\\/li\>\\"
			done
			printf '%s' "\<\\/ul\>"
		fi
		printf '%s\n' "\<\\/li\>\\"
	done
)
"

# escape: $.*[\]^&/

menu="<div id=\"nav\">\\
<a id=\"backlink\" href=\"\\/\">↜<\\/a>\\
<nav>\\
<ul>\\
$list<\\/ul>\\
<\\/nav>\\
<\\/div>\\
<div id=\"paper\">\\
<article>"

sed -e "s/<div>FOO<\/div>/$menu/" scripts/layout > includes/layout

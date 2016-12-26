#!/bin/ksh
source ./wswsh.conf

find dest/ -type f ! -name '*index.html' -name '*.html' \
| while read file; do
	htmlfile="$(print "$file" | cut -d '/' -f 2- )"
	txtpath="${htmlfile%.*}"
	txtfile="$(find src/ -type f -wholename src/"$txtpath".* | cut -d '/' -f 2- )"
	txtlink="$(print "$txtfile" | sed 's/\ /\%20/')"
	gitlink_text="${gitlink}${txtlink}"

	awk '{
		if ( match($0, /<article>/, arr) ) {
			print $0arr[1]
			print "<header>"
			print "<div id=gitlink>"
			print "you can edit this file and contribute here:"
			print "<br>"
			print "<a href=\"'${gitlink_text}'\" target=\"_blank\">'${gitlink_text}'</a>"
			print "</div>"
			print "</header>"
		}
		else {
			print;
		}
	}' "$file" > "$file".tmp
	mv "$file".tmp "$file"
done

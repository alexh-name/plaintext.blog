#!/bin/mksh

find src/*/ -type f -name index.txt -o -name index.wshtml \
| while read index ; do
	title=$(print $index | cut -d '/' -f 2)
	dt=$(print $index | sed -e 's/src\//dest\//' -e 's/\.txt/\.html/' -e 's/\.wshtml/\.html/')
	link="${title// /_}"
	sed -i "s/href=\"\/[0-9]*[0-9]*_*$link\/\"/href=\"\/$link\/\" class=\"thisPage\"/Ig" "$dt"
done

find src/*/ -type f ! -name index.txt -name '*.txt' -o -name '*.wshtml' \
| awk -F'/[^/]*$' '{print $1}' \
| cut -d '/' -f 2- \
| awk '!seen[$0]++' \
| while read dir ; do
	edir="$(print $dir | sed -e 's/\//\\\//g')"
	find src/$dir/ -type f ! -name index.txt -name '*.txt' -o -name '*.wshtml' \
	| while read text; do
		title=$(print $text | sed 's#.*/##')
		link=$(print $title | sed -e 's/\.txt/\.html/' -e 's/\.wshtml/\.html/')
		dt=$(print $text | sed -e 's/src\//dest\//' -e 's/\.txt/\.html/' -e 's/\.wshtml/\.html/')
		sed -i "s/href=\"\/$edir\/$link\"/href=\"\/$edir\/$link\" class=\"thisPage\"/Ig" "$dt"
	done
done

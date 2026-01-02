#
# AWK common function lib
#
# Trim whitespace from strings on the left, right or both
function ltrim(s) { sub(/^[ \t\r\n]+/, "", s); return s }
function rtrim(s) { sub(/[ \t\r\n]+$/, "", s); return s }
function trim(s)  { return rtrim(ltrim(s)); }

function arr_size (arr) {
	size=0
	for (i in arr) { if ( i != "" ) { size++ } }
	return size
}	

### Deal with double quotes (")
# Unquoted str results in z=1, if quoted z=3
function dequote (str) {
	z=split(str,parts,"\"")
	if ( z == 1 ) { return parts[1]
	} else {	return parts[z-1] }
}

function enquote (str) {
	tmp=dequote(str)
	return sprintf("\"%s\"", tmp)
}

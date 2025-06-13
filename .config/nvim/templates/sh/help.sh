help() { echo "<++> -

USAGE:
	<++> [OPTION]...

OPTIONS:
	-h  show this help message"; }

[ "$#" -lt 1 ] && help >&2 && exit 1


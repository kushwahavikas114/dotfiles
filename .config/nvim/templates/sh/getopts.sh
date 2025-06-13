while getopts 'h' o; do case "$o" in
	h) help >&2; exit ;;
	*) err "invalid option -- '$OPTARG'" ;;
esac done
shift $((OPTIND - 1))



absolute-path-with-default() {
	local candidate=$1
	local default=$2

	if [[ "$candidate" == "" ]]; then
		local result="$default"
	elif [[ "${candidate:0:1}" != "/" && "${candidate:0:1}" != "~" ]]; then
		local result="$PWD/$candidate"
	else
		local result="$candidate"
	fi
	echo "$result"
}

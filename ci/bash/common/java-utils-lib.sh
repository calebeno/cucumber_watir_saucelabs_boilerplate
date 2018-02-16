
JAVA_ROOT=/Library/Java/JavaVirtualMachines

set-JAVA-HOME() {
	if [[ "$JAVA_HOME" != "" ]]; then
		return 0
	fi
	local last_version="$(ls -F $JAVA_ROOT | grep "/$" | tail -n 1)"
	if [[ "$last_version" == "" ]]; then
		export JAVA_HOME=
		return 1
	else
		local jh="$JAVA_ROOT/$last_version"
		jh+="Contents/Home"
		export JAVA_HOME="$jh"
		return 0
	fi
}

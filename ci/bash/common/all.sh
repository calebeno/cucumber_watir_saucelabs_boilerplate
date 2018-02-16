#! /bin/bash 

run_subsidiary() {
	local prefix=$1
	local subsidiary=$2
	if ! [ -f "$ci_dir/$subsidiary" ]; then
		echo "=== $subsidiary not found: skipping ==="
		return 0
	else
		echo "=== $subsidiary running ==="
		$prefix "$ci_dir/$subsidiary"
		return $?
	fi
}

source_exec() {
	local subsidiary=$1
	run_subsidiary "source" "$subsidiary"
	local result=$?
	if [ $result -ne 0 ]; then
		echo "=== BUILD FAILED: $subsidiary ==="
		exit $result
	fi
}

subprocess_exec() {
	local subsidiary=$1
	run_subsidiary "bash" "$subsidiary"
	local result=$?
	if [ $result -ne 0 ]; then
		echo "=== BUILD FAILED: $subsidiary ==="
		exit $result
	fi
}

subprocess_exec_with_cleanup() {
	local subsidiary=$1
	run_subsidiary "bash" "$subsidiary"
	local result=$?
	if [ $result -ne 0 ]; then
		echo "=== BUILD FAILED in $subsidiary with environment running: cleaning up ==="
		subprocess_exec environment-stop.sh
		echo "=== BUILD FAILED: $subsidiary ==="
		exit $result
	fi
}

ci_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/.." && pwd)"

source_exec setenv.sh
if [ "$JOB_NAME" != "" ]; then
	source_exec ci-setenv.sh
fi
subprocess_exec build.sh
subprocess_exec unit-test.sh
subprocess_exec_with_cleanup environment-start.sh
subprocess_exec_with_cleanup integration-test.sh
subprocess_exec_with_cleanup functional-test.sh
subprocess_exec environment-stop.sh
if [ "$JOB_NAME" != "" ]; then
	subprocess_exec publish.sh
fi
echo "=== BUILD SUCCEEDED ==="

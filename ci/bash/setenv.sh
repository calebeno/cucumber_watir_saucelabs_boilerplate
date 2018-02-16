#! /bin/bash
export PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)/../.."

export FT_PLATFORM="test"


find_open_port(){
	local starting_port=$1
	local port_found=0
	local port_in_use=`nc -z localhost $starting_port; echo $?`
	while [[ $port_found -lt 1 ]]; do
		if [[ $port_in_use == 1 ]]; then
			echo "Found Port "$starting_port
			port_found=1
			export OPEN_PORT=$starting_port
		else
			echo "checking to see if "$starting_port "is open"
			starting_port=$(expr $starting_port + 1)
			port_in_use=`nc -z localhost $starting_port; echo $?`
		fi
	done

}


setup_version_specific_vars() {
  export CUCUMBER_TAGS="-t ~@donotrun $CUCUMBER_TAGS"
}

export JENKINS_BASE_URL="http://jenkins"
setup_version_specific_vars

echo "PROJECT_DIR = $PROJECT_DIR"
echo "CUCUMBER_TAGS = $CUCUMBER_TAGS"

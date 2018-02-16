
# Requires common/path-utils-lib.sh
# Requires common/java-utils-lib.sh

GRADLE_HOME=.
DYNATRACE_HOME=/opt/dynatrace

dynatrace-instrument-android() {
	local apk=$(absolute-path-with-default "$1" "$PWD/app/build/outputs/apk/app-debug.apk")
	local properties=$(absolute-path-with-default "$2" "$PWD/app/APK-Instr.properties")

	if [[ "$JAVA_HOME" == "" ]]; then
		set-JAVA-HOME
	fi

	$GRADLE_HOME/gradlew clean zipalignDebug

	pushd $DYNATRACE_HOME/Android/auto-instrumentor
	./instrument.sh apk=$apk prop=$properties
	popd

	local apk_path=$(dirname $apk)
	local apk_name=$(basename $apk)
	local apk_name_without_extension=${apk_name%.apk}
	local final_apk_name=$apk_name_without_extension
	final_apk_name+="-final.apk"
	cp $apk_path/$apk_name_without_extension/dist/$final_apk_name $apk_path/$apk_name

	$GRADLE_HOME/gradlew -x zipalignDebug assembleDebug
}

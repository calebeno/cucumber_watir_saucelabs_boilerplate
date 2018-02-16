#@IgnoreInspection BashAddShebang

catchable_exit() {
    echo "$2"
    exit "$1"
}

find_open_android_port(){
    local starting_port=5554
    local port_found=0
    local port_in_use=`nc -z localhost $starting_port; echo $?`
    while [[ $port_found -lt 1 ]]; do
        if [[ $port_in_use == 1 ]]; then
            echo "Found Port "$starting_port
            port_found=1
            export ANDROID_EMULATOR_PORT=$starting_port
        else
            echo "checking to see if "$starting_port "is open"
            starting_port=$(expr $starting_port + 2)
            port_in_use=`nc -z localhost $starting_port; echo $?`
        fi
    done

}

async_execute() {
    $1 2>&1 &
}
# Deprecated
stop_emulator () {
    local emulator_name="$1"

    gmtool admin stop "$emulator_name"
    local result="$?"
    if [[ "$result" -eq 0 || "$result" -eq "3" ]]; then
        return 0
    else
        return "$result"
    fi
}
# Deprecated
start_emulator_if_necessary_new () {
    local emulator_name="$1"

    gmtool admin start "$emulator_name"
    local result="$?"
    if [[ "$result" -eq 0 || "$result" -eq 3 ]]; then
        export BUILD_ID="DontKillMe"
        return 0
    else
        return "$result"
    fi
}
# Deprecated
start_emulator_if_necessary () {
    local emulator_name="$1"
    local port="$2"

    local status="$(adb -s "emulator-$port" shell getprop init.svc.bootanim)"
    if [[ "${status:0:7}" == "stopped" ]]; then # happens if emulator is running and happy
        return 0
    elif [[ "$status" == "" ]]; then
        export BUILD_ID="DontKillMe"
        async_execute "nohup emulator @$emulator_name -gpu on -port $port"
    fi
    local retries_remaining="50"
    while [[ "$retries_remaining" -gt "0" ]]; do
        local status="$(adb -s "emulator-$port" shell getprop init.svc.bootanim)"
        if [[ "${status:0:7}" == "stopped" ]]; then
            break
        fi
        retries_remaining=$(echo "$retries_remaining - 1" | bc)
        if [[ "$retries_remaining" -le "0" ]]; then
            echo "Emulator has not yet finished booting; gave up."
            killall -9 emulator64-x86
            catchable_exit 1
        else
            echo "Emulator has not yet finished booting; will check $retries_remaining more times."
            sleep 3
        fi
    done
}


stop_android_emulator () {
    killall qemu-system-x86_64
    killall qemu-system-i386
    killall emulator64-x86 
}

start_android_emulator_if_necessary () {
    local emulator_name="$1"
    find_open_android_port
    echo "Found port " $ANDROID_EMULATOR_PORT
    async_execute "emulator @$emulator_name -wipe-data -gpu on -port $ANDROID_EMULATOR_PORT"
    export emulator_pid=$!
    local retries_remaining="50"
   while [[ "$retries_remaining" -gt "0" ]]; do
        status="$(adb -s "emulator-${ANDROID_EMULATOR_PORT}" shell getprop init.svc.bootanim)"
        if [[ "${status:0:7}" == "stopped" ]]; then
            break
        fi
        retries_remaining=$(echo "$retries_remaining - 1" | bc)
        if [[ "$retries_remaining" -le "0" ]]; then
            echo "emulator has not yet finished booting; gave up."
            kill $emulator_pid
            catchable_exit 1 "Failed: Emulator never came up"
        else
            echo "emulator has not yet finished booting; will check $retries_remaining more times."
            sleep 3
        fi
   done
}

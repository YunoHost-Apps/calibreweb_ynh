#!/bin/bash

pkg_dependencies="sqlite3 python-pip imagemagick"
create_dir=0


#=================================================
# EXPERIMENTAL HELPERS
# TO BE DELETED WHEN RELEASED
#=================================================

#=================================================
#YNH_SYSTEMD_ACTION
#=================================================

# Start (or other actions) a service,  print a log in case of failure and optionnaly wait until the service is completely started
#
# usage: ynh_system_reload service_name [action]
# | arg: -n, --service_name= - Name of the service to reload. Default : $app
# | arg: -a, --action=       - Action to perform with systemctl. Default: start
# | arg: -l, --line_match=   - Line to match - The line to find in the log to attest the service have finished to boot.
#                              If not defined it don't wait until the service is completely started.
# | arg: -p, --log_path=     - Log file - Path to the log file. Default : /var/log/$app/$app.log
# | arg: -t, --timeout=      - Timeout - The maximum time to wait before ending the watching. Default : 300 seconds.
# | arg: -e, --length=       - Length of the error log : Default : 20
ynh_systemd_action() {
    # Declare an array to define the options of this helper.
    declare -Ar args_array=( [n]=service_name= [a]=action= [l]=line_match= [p]=log_path= [t]=timeout= [e]=length= )
    local service_name
    local action
    local line_match
    local length
    local log_path
    local timeout

    # Manage arguments with getopts
    ynh_handle_getopts_args "$@"

    local service_name="${service_name:-$app}"
    local action=${action:-start}
    local log_path="${log_path:-/var/log/$service_name/$service_name.log}"
    local length=${length:-20}
    local timeout=${timeout:-300}
    local wait_starting=true

    if [[ -z "${line_match:-}" ]]
    then
        wait_starting=false
    fi

    ynh_clean_check_starting () {
        # Stop the execution of tail.
        kill -s 15 $pid_tail 2>&1
        ynh_secure_remove "$templog" 2>&1
    }

    echo "Starting of $service_name" >&2
    systemctl $action $service_name || ( journalctl --lines=$length -u $service_name >&2 && false)

    if $wait_starting
    then
        # Following the starting of the app in its log
        local templog="$(mktemp)"
        tail -F -n1 "$log_path" > "$templog" &
        # Get the PID of the tail command
        local pid_tail=$!

        local i=0
        for i in $(seq 1 $timeout)
        do
            # Read the log until the sentence is found, that means the app finished to start. Or run until the timeout
            if grep --quiet "$line_match" "$templog"
            then
                echo "The service $service_name has correctly started." >&2
                break
            fi
            echo -n "." >&2
            sleep 1
        done
        if [ $i -eq $timeout ]
        then
            echo "The service $service_name didn't fully started before the timeout." >&2
            journalctl --lines=$length -u $service_name >&2
        fi

        echo ""
        ynh_clean_check_starting
    fi
}

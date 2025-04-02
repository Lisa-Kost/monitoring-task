#!/bin/bash

PROCESS_NAME="test_process_name"
LOG_FILE="/var/log/monitoring.log"
SERVER_URL="https://test.com/monitoring/test/api"
PID_FILE=/Users/lisa/monitoring-task

CURRENT_PID=$(pgrep -f "PROCESS_NAME")

# if the process is running
if [ -n "$CURRENT_PID" ]; then
    LAST_PID=$(cat $PID_FILE 2>/dev/null)

    if [ "$CURRENT_PID" != "LAST_PID" ]; then
    echo "$(date) - Process restarted (PID: $CURRENT_PID)" >> "$LOG_FILE"
    echo "$CURRENT_PID" > $PID_FILE
    fi

    if ! curl -fsS "$SERVER_URL"; then
    echo "$(date) - Monitoring server unavailable >> "$LOG_FILE"
    fi

# if the process is not running
else
    exit 0
fi

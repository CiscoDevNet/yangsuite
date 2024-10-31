#!/bin/bash

LOG_DIR="/ys-data/logs"
INOTIFY_EVENTS="create,modify,delete,move"

# Function to tail all current log files
tail_logs() {
  tail -F "$LOG_DIR"/* &
  TAIL_PID=$!
}

# Function to clean up and exit
cleanup() {
  echo "Stopping log monitoring..."
  kill $TAIL_PID
  exit 0
}

# Trap termination signals
trap cleanup SIGINT SIGTERM

# Start tailing existing logs
tail_logs

# Monitor the directory for new files and restart tailing
inotifywait -m -e "$INOTIFY_EVENTS" --format '%w%f' "$LOG_DIR" | while read NEW_FILE
do
  kill $TAIL_PID
  tail_logs
done
#!/bin/bash
# Always execute this file with this directory as CWD

if [ $# -eq 0 ]
  then
    echo "Please provide your username as argument"
    exit 1
fi

docker run -u $(id -u $1):$(id -g $1) --rm -v $(pwd):/src metro python scripts/query_schedule.py
if [ $? -eq 0 ]; then
  echo "Successfully downloaded schedule data:" $(date) >> $(pwd)/logs/schedulelog
else
  echo "Failed schedule data download:" $(date) >> $(pwd)/logs/schedulelog
  exit 1
fi

docker run -u $(id -u $1):$(id -g $1) --rm -v $(pwd):/src metro python scripts/process_schedule.py
if [ $? -eq 0 ]; then
  echo "Successfully processed schedule data:" $(date) >> $(pwd)/logs/schedulelog
else
  echo "Failed schedule data processing:" $(date) >> $(pwd)/logs/schedulelog
  exit 1
fi
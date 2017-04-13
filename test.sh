#!bin/bash

wait_for_db() {
  nslookup redis
  if ! nc -z redis 6379; then
    echo "Waiting for db..."
    sleep 2
    wait_for_db
  fi
}

wait_for_db

if curl web | grep -q '<b>Visits:</b> '; then
  echo "Tests passed!"
  exit 0
else
  echo "Tests failed!"
  exit 1
fi
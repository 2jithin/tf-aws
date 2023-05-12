#!/bin/bash

instances=("$@")

for ((i=0; i<${#instances[@]}; i++)); do
  destination=$((i + 1))
  if [ $destination -eq ${#instances[@]} ]; then
    destination=0
  fi

  ping_result=$(ping -c 1 "${instances[$destination]}")
  if [ $? -eq 0 ]; then
    echo "Ping from ${instances[$i]} to ${instances[$destination]}: Success"
  else
    echo "Ping from ${instances[$i]} to ${instances[$destination]}: Failure"
  fi
done

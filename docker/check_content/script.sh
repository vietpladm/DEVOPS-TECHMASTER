#!/bin/bash
while true; do
  read -p "Enter a file path to display its contents (or type 'quit' to exit): " input

  if [[ $input == "quit" ]]; then
    exit
  fi

  if [[ -f $input ]]; then
    cat "$input"
  else
    echo "Invalid file path"
  fi
done

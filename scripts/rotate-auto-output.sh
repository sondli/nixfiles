#!/usr/bin/env zsh

sinks=($(pactl list short sinks | cut -f2))
current=$(pactl get-default-sink)
total=${#sinks[@]}

for ((i = 1; i <= $total; i++)); do
  if [[ "${sinks[$i]}" == "$current" ]]; then
    next=$(( (i % total) + 1 ))
    pactl set-default-sink "${sinks[$next]}"

    pactl list short sink-inputs | cut -f1 | while read input; do
      pactl move-sink-input "$input" "${sinks[$next]}"
    done

    break
  fi
done

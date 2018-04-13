#!/bin/bash

machine="$1"
find_text="$2"

console_width=$(tput cols)

zcat "supercop-data/$machine/data.gz" \
| grep "$find_text" \
| cut -c "-$console_width"


#!/bin/bash

SECTION="\u00A7"

codes=(
    "0" # Black
    "1" # Dark Blue
    "2" # Dark Green
    "3" # Dark Aqua
    "4" # Dark Red
    "5" # Dark Purple
    "6" # Gold
    "7" # Gray
    "8" # Dark Gray
    "9" # Blue
    "a" # Green
    "b" # Aqua
    "c" # Red
    "d" # Light Purple
    "e" # Yellow
    "f" # White
    "k" # Obfuscated
    "l" # Bold
    "m" # Strikethrough
    "n" # Underline
    "o" # Italic
    "r" # Reset
)

colour=$SECTION${codes[ (RANDOM % 15) ]}
format=$SECTION${codes[ (16 + RANDOM % 5) ]}
obfuscation=$( ((RANDOM % 10)) && echo "" || echo $SECTION'k')

decoration=$colour$format$obfuscation
adjective=$(shuf -n 1 /usr/share/wordnet/data.adj \
            | cut -d " " -f 5 \
            | sed 's/\b\(.\)/\u\1/g' \
            | sed 's/_/ /g' \
            | tr -cd '[:alnum:]._-' \
            | cut -d " " -f 1 )

indefinite_article=$(if [[ "${adjective:0:1 }" =~ (A|E|I|O|U) ]]; then
                        echo "An"
                    else
                        echo "A"
                    fi)
motd="$indefinite_article $decoration$adjective World Of Blocks"

echo $motd

# Escape backslashes for final sed replacement
motd=$(echo $motd | sed 's/\\/\\\\/g')

# Replace MOTD line
sed -i "s/motd=.*/motd=$motd/g" /srv/minecraft-server/server/server.properties

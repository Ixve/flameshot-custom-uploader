#!/bin/bash
auth="UPLOAD KEY HERE"
url="https://api.has-cool.pics/upload"

temp_file="/tmp/screenshot.png"
flameshot gui -r > $temp_file

if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
        rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

image_url=$(curl -X POST -F "file=@"$temp_file -H "Authorization: Bearer "$auth -v "$url" 2>/dev/null)
echo $image_url > /tmp/upload.json

cat /tmp/upload.json | jq -r ".data.fileLink" | xclip -sel c
rm $temp_file

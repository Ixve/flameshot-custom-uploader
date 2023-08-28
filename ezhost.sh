#!/bin/bash -e

if [ ! -f ~/.E-Z/settings.sh ]; then
    read -p "Input API URI: " url
    read -p "Input API Key: " auth
    rm -rf ~/.E-Z && mkdir ~/.E-Z
    echo 'url="'$url'"' > ~/.E-Z/settings.sh && echo 'auth="'$auth'"' >> ~/.E-Z/settings.sh
    echo 'temp_file="/tmp/screenshot.png"' >> ~/.E-Z/settings.sh && echo 'response_file="/tmp/upload.json"' >> ~/.E-Z/settings.sh
    notify-send "Settings updated" -a "Flameshot"
    exit 1
fi

source ~/.E-Z/settings.sh
flameshot gui -r > $temp_file

if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
    rm $temp_file
    exit 1
fi

image_url=$(curl -X POST -F "file=@"$temp_file -H "key: "$auth -v "$url" 2>/dev/null)
echo $image_url > $response_file

if ! jq -e . >/dev/null 2>&1 < $response_file; then
    notify-send "Error occurred while uploading. Please try again later." -a "Flameshot"
    rm $temp_file
    rm $response_file
    exit 1
fi

success=$(cat $response_file | jq -r ".success")
if [[ "$success" != "true" ]] || [[ "$success" == "null" ]]; then
    error=$(cat $response_file | jq -r ".error")
    if [[ "$error" == "null" ]]; then
        notify-send "Error occurred while uploading. Please try again later." -a "Flameshot"
        rm $temp_file
        rm $response_file
        exit 1
    else
        notify-send "Error: $error" -a "Flameshot"
        rm $temp_file
        rm $response_file
        exit 1
    fi
fi

cat $response_file | jq -r ".imageUrl" | xclip -sel c
notify-send "Image URL copied to clipboard" -a "Flameshot" -i $temp_file
rm $temp_file

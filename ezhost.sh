auth="PUT YOUR AUTHENTICATION KEY HERE (https://neverlose.me/ky8pn0p2.png)"
url="https://api.e-z.host/files"

temp_file="/tmp/screenshot.png"
flameshot gui -r > $temp_file

if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
        rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

image_url=$(curl -X POST -F "file=@"$temp_file -H "key: "$auth -v "$url" 2>/dev/null)
echo $image_url > /tmp/upload.json
cat /tmp/upload.json | jq -r ".imageUrl" | xclip -sel c
notify-send "Image URL copied to clipboard" -a "Flameshot" -i $temp_file
rm $temp_file

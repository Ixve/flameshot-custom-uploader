auth="AUTHENTICATION KEY HERE"
url="URL HERE"

temp_file="/tmp/screenshot.png"
flameshot gui -r > $temp_file

if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
	rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

#SOME HOSTS MAY USE "KEY: " INSTEAD OF "AUTHORIZATION: " IN THE HEADERS, MAKE SURE TO CHANGE IT IF REQUIRED
image_url=$(curl -X POST -F "file=@"$temp_file -H "authorization: "$auth -v "$url" 2>/dev/null)
echo $image_url > /tmp/upload.json
cat /tmp/upload.json | jq ".imageURL" | tr -d '"' | xclip -sel c
notify-send "Image URL copied to clipboard" "$image_url" -a "Flameshot" -i $temp_file
rm $temp_file

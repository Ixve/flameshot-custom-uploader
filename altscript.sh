auth="KEY GOES HERE"
url="URL GOES HERE"
temp_file="/tmp/screenshot.png"
flameshot gui -r > $temp_file

if [[ $(file --mime-type -b $temp_file) != "image/png" ]]; then
    rm $temp_file
  notify-send "Screenshot aborted" -a "Flameshot" && exit 1
fi

image_url=$(curl -X POST -F "file=@"$temp_file -H "key: "$auth -v "$url" 2>/dev/null)
echo $image_url > /tmp/upload.json
#DURING MY TESTING IVE FOUND SOME HOSTS MAY USE A DIFFERENT "IMAGEURL" RESPONSE FIELD IN THE JSON, MAKE SURE TO KEEP AN EYE OUT FOR THAT!
cat /tmp/upload.json | jq -r ".imageURL" | xclip -sel c
notify-send "Image URL copied to clipboard" "$image_url" -a "Flameshot" -i $temp_file
rm $temp_file

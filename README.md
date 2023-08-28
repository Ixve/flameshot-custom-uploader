# READ
This script will most probably rarely get commits - if you wish to use an updated script, SKRRRTT has made his own repo with his own script improvements [over here](https://github.com/ignSKRRRTT/e-z-flameshot-script)

# Flameshot Custom Uploader Script
A simple script that utilizes cURL and some bash for uploading your images taken via flameshot to an image hosting service.

# Usage
The following packages are required to be installed:
* xclip
* jq
* flameshot

Most distributions are based on Ubuntu or Debian, and will use apt: `sudo apt install xclip jq flameshot`<br>If you use anything not Ubuntu/Debian-based, then you should know your way around a package manager.

Download the script or clone the entire repo using:<br>`git clone https://github.com/c-um/flameshot-custom-uploader/`<br><br>
Give the script execution permissions using `chmod +x ./scriptname.sh` (or `chmod +x scriptname.sh`, both work.)<br><br>
Edit the script using any editor you wish (e.g `nano scriptname.sh`) and change the URL to your desired host, including putting in your API key.<br><br><br>
After editing the script try uploading any image and make sure to check the returned field name by simply doing `cat /tmp/upload.json`<br>The most common returned field will be along the lines of `imageUrl`, just edit the script and replace the:<br> `jq -r ".imageUrl"` with `jq -r ".FieldNameHere`

<br><br><br>
Credits:

[Everyone over at the Flameshot Organization for actually creating Flameshot](https://flameshot.org/)

[Tanner Reynolds / the entire ShareS Project for the flameshot example script](https://github.com/TannerReynolds/ShareX-Upload-Server)

[DryByte for helping me figure out jq](https://github.com/DryByte)

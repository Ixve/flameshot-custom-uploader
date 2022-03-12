# Flameshot Custom Uploader Script
A script for uploading your images to a custom hosting service

The installation is simple, go into the file and change the URL to your desired host and set your authentication key.

*Some hosts may use `key:` instead of `authorization:` in the headers, please make sure to check and change it if required.*

*During my testing of hosts I've found some hosts may use a different field name for "imageURL", make sure to keep an eye out for that and make the change if required.*

The following packages are required:
* xclip
* jq


Credits:
[Everyone over at the Flameshot Organization for actually creating Flameshot](https://flameshot.org/)

[Tanner Reynolds / ShareS Project for the flameshot example script](https://github.com/TannerReynolds/ShareX-Upload-Server)

[DryByte for helping me with jq](https://github.com/DryByte)

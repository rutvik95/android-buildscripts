#this script copies the patches from the patch folder to the rom folder 

# just replace the ~/patch to ur folder name where the patches exist and change ~/axxion to the path of the rom 



#these copy normal patches reqd to boot the device and core functions to work
cp -r ~/patch/audiovideo.diff ~/axxion/frameworks/av
cp -r ~/patch/bluetooth.diff ~/axxion/hardware/broadcom/libbt
cp -r ~/patch/hwc.diff ~/axxion/frameworks/native
cp -r ~/patch/webview.diff ~/axxion/external/chromium_org
cp -r ~/patch/ril.diff ~/axxion/system/core



echo -e " patches copied ... pleaser review to check for any errors "
read -p " PRESS ENTER TO START APPLYING THE PATCHES "


. patches.sh

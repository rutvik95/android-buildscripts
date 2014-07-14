#this script copies the patches from the patch folder to the rom folder 

# just replace the ~/patch to ur folder name where the patches exist and change ~/vaniraosp to the path of the rom 



#these copy normal patches reqd to boot the device and core functions to work
cp -r ~/patch/audiovideo.diff ~/vaniraosp/frameworks/av
cp -r ~/patch/bluetooth.diff ~/vaniraosp/hardware/broadcom/libbt
cp -r ~/patch/hwc.diff ~/vaniraosp/frameworks/native
cp -r ~/patch/webview.diff ~/vaniraosp/external/chromium_org
cp -r ~/patch/ril.diff ~/vaniraosp/system/core


#now copying msim patches 
cp -r ~/patch/msim/msim_frameworks_base.diff ~/vaniraosp/frameworks/base
cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/vaniraosp/frameworks/opt/telephony-msim
cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/vaniraosp/packages/apps/Settings
cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/vaniraosp/packages/services/Telephony


echo -e " patches copied ... pleaser review to check for any errors "
read -p " PRESS ENTER TO START APPLYING THE PATCHES "


. patches.sh

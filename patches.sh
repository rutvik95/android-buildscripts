echo -e ""
echo -e " Applying Patches for Galaxy Grand Duos "
echo -e ""

# Bluetooth Patch
echo -e ""
echo -e " APPLYING BLUETOOTH PATCH "
echo -e ""
cd hardware/broadcom/libbt
git checkout .
patch -p1 < bluetooth.diff
cd ../../../
echo -e " BLUETOOTH PATCH APPLIED SUCCESSFULLY "
echo -e ""

# HW Composer Patch 
echo -e ""
echo -e " APPLYING HWC PATCH "
cd frameworks/native
git checkout .
patch -p1 < hwc.diff
git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/62/53162/6 && git format-patch -1 --stdout FETCH_HEAD

echo -e ""
echo -e " HWC PATCHES APPLIED SUCCESSFULLY"
echo -e ""

# AUDIO/VIDEO PATCHES 
echo -e ""
echo -e " APPLYING A/V PATCHES"
echo -e ""
cd ../av
git checkout .
patch -p1 < audiovideo.diff 
echo -e ""
echo -e " AUDIO/VIDEO PATCHES APPLIED SUCCESSFULLY "

# WEBVIEW PATCHES 
echo -e ""
echo -e " APPLYING WEBVIEW PATCH "
echo -e ""
cd ../../
cd external/chromium_org
git checkout .
patch -p1 < webview.diff
echo -e ""
echo -e " WEBVIEW PATCHES APPLIED SUCCESSFULLY"

# ACTUAL BUILD 
echo -e ""
echo -e " ALL PATCHES APPLIED SUCCESSFULLY AND NOW BUILD STARTING "
echo -e ""
cd ../../

#checking if msim exists

if [ -d "frameworks/opt/telephony-msim" ]
then
    echo "msim supported ."
   
#now copying msim patches ... change the path axxion to any other rom you are compiling

cp -r ~/patch/msim/msim_frameworks_base.diff ~/axxion/frameworks/base
cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/axxion/frameworks/opt/telephony-msim
cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/axxion/packages/apps/Settings
cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/axxion/packages/services/Telephony
. msim-patches.sh
    
else
    echo "MSIM NOT SUPPORTED."
    read -p " PRESS ENTER TO START THE BUILD"
. build/envsetup.sh && brunch i9082 
fi



 

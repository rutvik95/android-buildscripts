#this script applies the msim patches 


#frameworks/base patch 
echo -e " PATCHING FRAMEWORKS/BASE "
echo -e ""

cd frameworks/base 
git checkout .
patch -p1 < msim_frameworks_base.diff

echo -e " frameworks/base patched successfully "
echo -e ""

# applying frameworks/opt/telephony-msim patch 
echo -e " applying  telephony-msim patch"
echo -e ""
cd ../opt/telephony-msim
git checkout .
patch -p1 < msim_frameworks_opt_telephony-msim.patch

echo -e " telephony-msim patched successfully"
echo -e ""

# applying settings patch 

echo -e " applying settings patch "
echo -e ""
cd ../../../
cd packages/apps/Settings
git checkout .
patch -p1 < msim_packages_apps_Setting.diff
echo -e ""
echo -e " settings patch applied successfully"
echo -e ""

# applying services/telephony patch 
echo -e ""
echo -e " applying telephony patch "
echo -e ""
cd ../../services/Telephony
git checkout .
patch -p1 < msim_packages_services_Telephony.diff
echo -e ""
echo -e " telephony patches successfully"
echo -e ""
cd ../../../

echo -e ""
echo -e " all msim patches applied ..pl review fr any errors "
read -p " PRESS ENTER TO START BUILDING "

. build/envsetup.sh && brunch i9082 -j4

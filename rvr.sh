#!/bin/bash
echo -e "\e[91m****************************************************************"
echo -e "* WELCOME TO RUTVIKRVR'S BUILD SCRIPT FOR GALAXY GRAND DUOS    *"
echo -e "****************************************************************"
#This build script has to be kept in the home folder along with the patch folder .. it will automatically navigate and apply patches and build

OPTIONS="Axxionkat 
VanirAOSP
Merkmod
AOGP
Quit"


PS3="Select a ROM to build  (1-5): "
select opt in $OPTIONS; 
do
    if [ "$opt" = "Quit" ]; then
     echo done
     exit
    elif [ "$opt" = "Axxionkat" ]; then
    	echo -e "**************************"
	echo -e "*AXXIONKAT BUILD STARTING*"
	echo -e "*			  *"
   	echo -e "**************************"
	cd axxion
	#these copy normal patches reqd to boot the device and core functions to work
	cp -r ~/patch/audiovideo.diff ~/axxion/frameworks/av
	cp -r ~/patch/bluetooth.diff ~/axxion/hardware/broadcom/libbt
	cp -r ~/patch/hwc.diff ~/axxion/frameworks/native
	cp -r ~/patch/webview.diff ~/axxion/external/chromium_org
	cp -r ~/patch/ril.diff ~/axxion/system/core



	echo -e " patches copied ... pleaser review to check for any errors "
	read -p " PRESS ENTER TO START APPLYING THE PATCHES "

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
	echo -e " ALL BASIC PATCHES APPLIED SUCCESSFULLY , NOW CHECKING FOR MSIM SUPPORT "
	echo -e ""
	cd ../../

	#checking if msim exists

	if [ -d "frameworks/opt/telephony-msim" ]
	then
        echo "MSIM SUPPORTED ."
   
	#now copying msim patches ... change the path axxion to any other rom you are compiling

	cp -r ~/patch/msim/msim_frameworks_base.diff ~/axxion/frameworks/base
	cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/axxion/frameworks/opt/telephony-msim
	cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/axxion/packages/apps/Settings
	cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/axxion/packages/services/Telephony
	
	echo -e ""
	echo -e "MSIM PATCHES COPIED ! PLEASE REVIEW FOR ANY ERRORS"
	read -p "PRESS ENTER TO APPLY PATCHES"


	#frameworks/base patch 
	echo -e " PATCHING FRAMEWORKS/BASE "
	echo -e ""

	cd frameworks/base 
	git checkout .
	patch -p1 < msim_frameworks_base.diff
	rm -rf packages/SystemUI/res/layout/status_bar_expanded.xml.orig

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
    	cd
	else
	    echo "MSIM NOT SUPPORTED."
	    read -p " PRESS ENTER TO START THE BUILD"
	. build/envsetup.sh && brunch i9082
 	cd
	fi
#Axxion Build ends 

    elif [ "$opt" = "VanirAOSP" ]; then
        echo -e "**************************"
	echo -e "*VanirAOSP BUILD STARTING*"
	echo -e "*			  *"
   	echo -e "**************************"

	cd vaniraosp
	repo sync -j100
	#these copy normal patches reqd to boot the device and core functions to work
	cp -r ~/patch/audiovideo.diff ~/vaniraosp/frameworks/av
	cp -r ~/patch/bluetooth.diff ~/vaniraosp/hardware/broadcom/libbt
	cp -r ~/patch/hwc.diff ~/vaniraosp/frameworks/native
	cp -r ~/patch/webview.diff ~/vaniraosp/external/chromium_org
	cp -r ~/patch/ril.diff ~/vaniraosp/system/core



	echo -e " patches copied ... pleaser review to check for any errors "
	read -p " PRESS ENTER TO START APPLYING THE PATCHES "

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
	git fetch http://review.cyanogenmod.org/CyanogenMod/android_frameworks_native refs/changes/62/53162/6 && git format-patch -1 --stdout 	FETCH_HEAD
	
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
	    echo "MSIM SUPPORTED ."
	   
	#now copying msim patches ... change the path vaniraosp to any other rom you are compiling
	
	cp -r ~/patch/msim/msim_frameworks_base.diff ~/vaniraosp/frameworks/base
	cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/vaniraosp/frameworks/opt/telephony-msim
	cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/vaniraosp/packages/apps/Settings
	cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/vaniraosp/packages/services/Telephony
	
	echo -e ""
	echo -e "MSIM PATCHES COPIED ! PLEASE REVIEW FOR ANY ERRORS"
	read -p "PRESS ENTER TO APPLY PATCHES"
	

	#frameworks/base patch 
	echo -e " PATCHING FRAMEWORKS/BASE "
	echo -e ""
	
	cd frameworks/base 
	git checkout .
	patch -p1 < msim_frameworks_base.diff
	rm -rf packages/SystemUI/res/layout/status_bar_expanded.xml.orig

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
	
	. build/envsetup.sh && lunch vanir_i9082-userdebug && make otapackage -j4
	   cd 
	else
	    echo "MSIM NOT SUPPORTED."
	    read -p " PRESS ENTER TO START THE BUILD"
	. build/envsetup.sh && lunch vanir_i9082-userdebug && make otapackage -j4
	 cd
	fi


	    elif [ "$opt" = "MERKMOD" ]; then	      
 	echo -e "**************************"
	echo -e "*MERKMOD BUILD STARTING  *"
	echo -e "*			  *"
   	echo -e "**************************"
	cd merkmod
	#these copy normal patches reqd to boot the device and core functions to work
	cp -r ~/patch/audiovideo.diff ~/merkmod/frameworks/av
	cp -r ~/patch/bluetooth.diff ~/merkmod/hardware/broadcom/libbt
	cp -r ~/patch/webview.diff ~/merkmod/external/chromium_org


	echo -e " patches copied ... pleaser review to check for any errors "
	read -p " PRESS ENTER TO START APPLYING THE PATCHES "

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
   	 echo "MSIM SUPPORTED ."
   	
	#now copying msim patches ... change the path merkmod to any other rom you are compiling

	cp -r ~/patch/msim/msim_frameworks_base.diff ~/merkmod/frameworks/base
	cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/merkmod/frameworks/opt/telephony-msim
	cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/merkmod/packages/apps/Settings
	cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/merkmod/packages/services/Telephony

	echo -e ""
	echo -e "MSIM PATCHES COPIED ! PLEASE REVIEW FOR ANY ERRORS"
	read -p "PRESS ENTER TO APPLY PATCHES"


	#frameworks/base patch 
	echo -e " PATCHING FRAMEWORKS/BASE "
	echo -e ""

	cd frameworks/base 
	git checkout .
	patch -p1 < msim_frameworks_base.diff
	rm -rf packages/SystemUI/res/layout/status_bar_expanded.xml.orig

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

	. build/envsetup.sh && brunch i9082 
    	cd
	else
 	   echo "MSIM NOT SUPPORTED."
 	   read -p " PRESS ENTER TO START THE BUILD"
	. build/envsetup.sh && brunch i9082
 	cd
fi


    elif [ "$opt" = "AOGP" ]; then
        echo -e "*******************************"
	echo -e "*AOGP BUILD STARTING*"
	echo -e "*			       *"
   	echo -e "*******************************"


cd aogp
	repo sync -j100
#these copy normal patches reqd to boot the device and core functions to work
	cp -r ~/patch/audiovideo.diff ~/aogp/frameworks/av
	cp -r ~/patch/bluetooth.diff ~/aogp/hardware/broadcom/libbt
	cp -r ~/patch/hwc.diff ~/aogp/frameworks/native
	cp -r ~/patch/webview.diff ~/aogp/external/chromium_org
	cp -r ~/patch/ril.diff ~/aogp/system/core



	echo -e " patches copied ... pleaser review to check for any errors "
	read -p " PRESS ENTER TO START APPLYING THE PATCHES "

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
	echo -e " ALL BASIC PATCHES APPLIED SUCCESSFULLY , NOW CHECKING FOR MSIM SUPPORT "
	echo -e ""
	cd ../../

	#checking if msim exists

	if [ -d "frameworks/opt/telephony-msim" ]
	then
        echo "MSIM SUPPORTED ."
   
	#now copying msim patches ... change the path axxion to any other rom you are compiling

	cp -r ~/patch/msim/msim_frameworks_base.diff ~/aogp/frameworks/base
	cp -r ~/patch/msim/msim_frameworks_opt_telephony-msim.patch ~/aogp/frameworks/opt/telephony-msim
	cp -r ~/patch/msim/msim_packages_apps_Setting.diff ~/aogp/packages/apps/Settings
	cp -r ~/patch/msim/msim_packages_services_Telephony.diff ~/aogp/packages/services/Telephony
	
	echo -e ""
	echo -e "MSIM PATCHES COPIED ! PLEASE REVIEW FOR ANY ERRORS"
	read -p "PRESS ENTER TO APPLY PATCHES"


	#frameworks/base patch 
	echo -e " PATCHING FRAMEWORKS/BASE "
	echo -e ""

	cd frameworks/base 
	git checkout .
	patch -p1 < msim_frameworks_base.diff
	rm -rf packages/SystemUI/res/layout/status_bar_expanded.xml.orig

	echo -e " frameworks/base patched successfully "
	echo -e ""
	
	# applying frameworks/opt/telephony-msim patch 
	#echo -e " applying  telephony-msim patch"
	#echo -e ""
	#cd ../opt/telephony-msim
	#git checkout .
	#patch -p1 < msim_frameworks_opt_telephony-msim.patch

	#echo -e " telephony-msim patched successfully"
	#echo -e ""

	# applying settings patch 
	
	echo -e " applying settings patch "
	echo -e ""
	cd ../../
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
    	cd
	else
	    echo "MSIM NOT SUPPORTED."
	    read -p " PRESS ENTER TO START THE BUILD"
	. build/envsetup.sh && brunch i9082
 	cd
	fi


    else
     clear
     echo bad option
    fi
done

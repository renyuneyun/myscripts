#!/usr/bin/bash
TMPDIR=/tmp/repo_checker
APPS="`cat ${0%/*}/packages`"
REPO="archlinuxcn"
num=0
UPLIST=""

pre()
{
	mkdir $TMPDIR
	cd $TMPDIR
}
download_aur_pkgbuild()
{
	PRELINK="https://aur.archlinux.org/packages"
	PACKAGENAME=$1
	FILENAME="PKGBUILD"
	LINK=${PRELINK}/${PACKAGENAME:0:2}/$PACKAGENAME/$FILENAME
	wget $LINK
}
get_local_version()
{
	APP=`pacman -Q ${app}`
	local ret=$?
	if [ $ret -ne '0' ]; then
		#pacman -Q would throw the error message
		return $ret
	fi
	APP_VERSION=`echo ${APP} | cut -d ' ' -f 2`
}
get_aur_version()
{
	download_aur_pkgbuild $APP 2> /dev/null
	local ret=$?
	if [ $ret -ne '0' ]; then
		echo Download failed for package $APP
		return $ret
	fi
	AUR_VERSION=`cat PKGBUILD | grep ^pkgver | cut -c 8-`'-'`cat PKGBUILD | grep ^pkgrel | cut -c 8-`
}
diff_version()
{
	if [ "${APP_VERSION}" != "${AUR_VERSION}" ]; then
		echo -e "\033[1;36mThere is an update here\033[0m"
		((num += 1))
		return 1
	else
		echo -e "\033[1;35mNo need to update\033[0m"
	fi
}
overview()
{
	echo -en "\033[37mOverview:\033[0m "
	if [ $num -gt 0 ]; then
		echo -e "\033[36mYou need to submit updates\033[0m"
		if [ -z $DISPLAY ]; then
			export DISPLAY=':0';
		fi
		notify-send -t 0 "ArchlinuxCN repo-check" "發現更新：\n${UPLIST}"
	else
		echo -e "\033[36mNo updates found\033[0m"
	fi
}
post()
{
	rm -d $TMPDIR
	if [ $? -ne '0' ]; then
		echo -e "Unable to remove the temp directory (${TMPDIR}).\nYou need to remove it manually."
	fi
}

pre
for app in $APPS; do
	get_local_version
	if [ $? -ne '0' ]; then
		continue;
	fi
	get_aur_version
	if [ $? -ne '0' ]; then
		continue;
	fi
	echo "${app} is now ${APP_VERSION} and ${AUR_VERSION} in AUR"
	diff_version
	if [ $? -ne '0' ]; then
		UPLIST="${UPLIST}\n${app} ${APP_VERSION} -> ${AUR_VERSION}"
	fi
	rm PKGBUILD
done;
overview
post
exit $num

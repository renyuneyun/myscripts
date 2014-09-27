#!/usr/bin/bash
TMPDIR=/tmp/cn_checker
mkdir $TMPDIR
cd $TMPDIR
APPS="`cat ${0%/*}/packages`"
num=0

function download_aur_pkgbuild()
{
	PRELINK="https://aur.archlinux.org/packages"
	PACKAGENAME=$1
	FILENAME="PKGBUILD"
	LINK=${PRELINK}/${PACKAGENAME:0:2}/$PACKAGENAME/$FILENAME
	wget $LINK
}

for APP in $APPS; do
	APP_VERSION=`pacman -Q ${APP} | cut -d ' ' -f 2`
	if [ $? -ne '0' ]; then
		echo Package $APP does not exist on this machine
		continue
	fi
	download_aur_pkgbuild $APP 2> /dev/null
	if [ $? -ne '0' ]; then
		echo Download failed for package $APP
		continue
	fi
	AUR_VERSION=`cat PKGBUILD | grep ^pkgver | cut -c 8-`'-'`cat PKGBUILD | grep ^pkgrel | cut -c 8-`
	echo "${APP} is now ${APP_VERSION} and ${AUR_VERSION} in AUR"
	if [ "${APP_VERSION}" != "${AUR_VERSION}" ]; then
		echo -e "\033[1;36mThere is an update here\033[0m"
		((num += 1))
	else
		echo -e "\033[1;35mNo need to update\033[0m"
	fi
	rm PKGBUILD
done;
echo -en "\033[37mOverview:\033[0m "
if [ $num -gt 0 ]; then
	echo -e "\033[36mYou need to submit updates\033[0m"
else
	echo -e "\033[36mNo updates found\033[0m"
fi
rm -d $TMPDIR
if [ $? -ne '0' ]; then
	echo -e "Unable to remove the temp directory (${TMPDIR}).\nYou need to remove it manually."
fi
exit $num

#! /usr/bin/env sh

echo ""
echo "RebornOS ISO Prerequisites Script"
echo "---------------------------------"
echo ""

SCRIPT_DIRECTORY="$(dirname -- "$(readlink -f -- "$0")")"
PROJECT_DIRECTORY="$(dirname -- "$SCRIPT_DIRECTORY")"

echo "Project Directory: $PROJECT_DIRECTORY"
echo "Script Directory: $SCRIPT_DIRECTORY"

echo ""
echo "Giving executable permissions to the required scripts..."
echo ""
set -o xtrace
sudo chmod -R +x "$PROJECT_DIRECTORY/scripts"
set +o xtrace

read -t 5 -p "Do you want to skip refreshing mirrors? (The default option will be selected in 5 seconds) [y/N] : " -n 1 -r
echo ""
if [ "$REPLY" != "Y" ] && [ "$REPLY" != "y" ]; then
    echo ""
    echo "Refreshing mirrors..."
    echo ""
    set -o xtrace
    sudo refresh-mirrors
    set +o xtrace
fi

echo ""
echo "Installing prerequisites if needed. Ignore any warnings..."
echo ""
set -o xtrace
sudo pacman -Sy --noconfirm archlinux-keyring rebornos-keyring
sudo pacman -Sy --noconfirm --needed archiso wget # rsync git git-lfs
# git lfs install
# git lfs pull
set +o xtrace

echo ""
echo "Copying mirrorlists..."
echo ""
set -o xtrace
cp -f /etc/pacman.d/reborn-mirrorlist "$PROJECT_DIRECTORY"/airootfs/etc/pacman.d/
cp -f /etc/pacman.d/mirrorlist "$PROJECT_DIRECTORY"/airootfs/etc/pacman.d/
set +o xtrace
#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "Need root to install required binaries."
  sudo -v || exit
fi

echo "Installing appimagetool to /usr/bin"
wget -O /tmp/appimagetool https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-i686.AppImage
chmod +x /tmp/appimagetool
if [[ "$EUID" -eq 0 ]]; then
  mv /tmp/appimagetool /usr/bin/
else
  sudo mv /tmp/appimagetool /usr/bin/
fi

echo "Installing linuxdeploy to /usr/bin"
wget -O /tmp/linuxdeploy https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-i386.AppImage
chmod +x /tmp/linuxdeploy
if [[ "$EUID" -eq 0 ]]; then
  mv /tmp/linuxdeploy /usr/bin
else
  sudo mv /tmp/linuxdeploy /usr/bin
fi

echo "Installing required libraries"
sudo apt install -y \
  libxcb1-dev libxcb1-dev:i386 \
  libxcb-render0-dev libxcb-render0-dev:i386 \
  libxcb-shape0-dev libxcb-shape0-dev:i386 \
  libxcb-xfixes0-dev libxcb-xfixes0-dev:i386

echo "Done. To uninstall simply remove the binaries located in /usr/bin."

#!/bin/bash

if [[ "$EUID" -ne 0 ]]; then
  echo "Need root to install required libraries."
  sudo -v || exit
fi

HOST_TYPE=$(uname -m)  # uname -i sometimes returns unknown

echo "Installing appimagetool to /usr/bin"
wget -O /tmp/appimagetool "https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-$HOST_TYPE.AppImage"
chmod +x /tmp/appimagetool
if [[ "$EUID" -eq 0 ]]; then
  mv /tmp/appimagetool /usr/bin/
else
  sudo mv /tmp/appimagetool /usr/bin/
fi

echo "Installing required libraries"
sudo apt install -y libxcb1-dev libxcb-render0-dev libxcb-shape0-dev libxcb-xfixes0-dev libxkbcommon-dev

echo "Installing required cargo package"
cargo install cargo-appimage

echo "Done."

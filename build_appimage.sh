#!/bin/bash
set -eu

# ./setup_appimage.sh # <- call this first!

# build binary
echo "Building Rust binary..."
RUSTFLAGS="--emit=asm" cargo build --target x86_64-unknown-linux-gnu --release

# remove existing binary if exists
if [ -e AppDir/usr/bin/ferrischat_client ]; then
  rm AppDir/usr/bin/ferrischat_client
fi

# invoke linuxdeploy to set up the AppDir
echo "Setting up the AppDir..."
linuxdeploy -e target/x86_64-unknown-linux-gnu/release/ferrischat_client --appdir AppDir

# invoke appimagetool to make the actual AppImage
echo "Making the AppImage..."
appimagetool AppDir/

echo "AppImage built!"

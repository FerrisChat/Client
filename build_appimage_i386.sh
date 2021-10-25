#!/bin/bash
set -eu

# ./setup_appimage.sh # <- call this first!

# build binary
echo "Building Rust binary..."
RUSTFLAGS="--emit=asm" cargo build --target i686-unknown-linux-gnu --release

# remove existing binary if exists
if [ -e AppDir_i386/usr/bin/ferrischat_client ]; then
  rm AppDir_i386/usr/bin/ferrischat_client
fi

# invoke linuxdeploy to set up the AppDir
echo "Setting up the AppDir..."
linuxdeploy -e target/i686-unknown-linux-gnu/release/ferrischat_client --appdir AppDir_i386

# invoke appimagetool to make the actual AppImage
echo "Making the AppImage..."
appimagetool AppDir_i386/

echo "AppImage built!"

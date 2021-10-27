#!/bin/bash
set -eu

# ./setup_appimage.sh # <- call this first!

# remove existing libs if they exist
if [ -e libs ]; then
  rm -r libs/
fi

if [[ $(uname -m) != "aarch64" ]]; then
  echo "64-bit ARM Linux builds can only be built natively!"
  exit 1
fi

echo "!! DO NOT MODIFY Cargo.toml WHILE RUNNING !!"
echo "Your changes MAY be dropped!"

printf "\n[package.metadata.appimage]\nauto_link = true" >> Cargo.toml
echo "Building AppImage (stage 1/2)"
RUSTFLAGS="--emit=asm" cargo appimage -- --target aarch64-unknown-linux-gnu

echo "Cleaning up libs"
sed -i '/\[package.metadata.appimage\]/d' Cargo.toml
sed -i '/auto_link = true/d' Cargo.toml

rm -f libs/libc.* libs/libpthread.* libs/libgcc_s.* libs/libdl.* libs/ld-linux* libs/libbsd.* libs/libm.* libs/librt.*

echo "Building AppImage (stage 2/2: much faster)"
RUSTFLAGS="--emit=asm" cargo appimage -- --target aarch64-unknown-linux-gnu

echo "AppImage built!"

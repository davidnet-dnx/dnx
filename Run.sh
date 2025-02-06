#!/bin/bash

# Clean up any previous build files
rm -rf build
mkdir build

# Assemble the Stage 1 and Stage 2 bootloaders
nasm -f bin src/stage1.asm -o build/stage1.bin
nasm -f bin src/stage2.asm -o build/stage2.bin

# Concatenate the Stage 1 and Stage 2 bootloaders into a single bootable image
cat build/stage1.bin build/stage2.bin > build/dnx.img

# Run the image with QEMU (use -drive to specify the bootable image)
qemu-system-x86_64 -drive file=build/dnx.img,format=raw

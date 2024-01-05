          git clone https://github.com/crdroidandroid/android_kernel_oneplus_sm8150.git -b 11.0 kernel
          git clone https://github.com/AOSP-12/prebuilts_clang_host_linux-x86_clang-r433403b clang
          sudo apt install axel
          export HOME=~/
          export CLANG_PATH=$HOME/clang/bin
          export PATH="$CLANG_PATH:$PATH"
          export CROSS_COMPILE=aarch64-linux-gnu-
          export CROSS_COMPILE_ARM32=arm-linux-gnueabi-
          export KBUILD_BUILD_USER=大哥
          export KBUILD_BUILD_HOST=王寒朔
          cd kernel
          curl -LSs "https://raw.githubusercontent.com/tiann/KernelSU/main/kernel/setup.sh" | bash -
          axel https://raw.githubusercontent.com/mingmingzhichua/build/main/su.patch
          patch -p1 < su.patch
          make ARCH=arm64 CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=../out vendor/sm8150-perf_defconfig
          make ARCH=arm64 CC=clang LD=ld.lld AR=llvm-ar NM=llvm-nm OBJCOPY=llvm-objcopy OBJDUMP=llvm-objdump STRIP=llvm-strip O=../out -j16
          cd ..
          git clone https://github.com/osm0sis/AnyKernel3
          sed -i 's/do.devicecheck=1/do.devicecheck=0/g' AnyKernel3/anykernel.sh
          sed -i 's!block=/dev/block/platform/omap/omap_hsmmc.0/by-name/boot;!block=auto;!g' AnyKernel3/anykernel.sh
          sed -i 's/is_slot_device=0;/is_slot_device=auto;/g' AnyKernel3/anykernel.sh
          cp ./out/arch/arm64/boot/Image AnyKernel3/
          rm -rf AnyKernel3/.git* AnyKernel3/README.md

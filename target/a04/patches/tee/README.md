# Multi-TEE support patch for a04

Check currently supported bootloader versions: [here](https://github.com/ohjhas/target_a04_patches_tee/blob/main/supported_bootloaders)

Check changelog and the bootloader versions supported in each Multi-TEE version: [here](https://github.com/ohjhas/target_a04_patches_tee/blob/main/CHANGELOG.md)

To check your bootloader version simply run the following command in Termux or ADB shell, then check if the Multi-TEE version your ROM has supports that bootloader version:
```
getprop ro.boot.bootloader
```

This patches are made for UN1CA build system and currently work only with API 34 vendor (used in One UI 6 and later) of Galaxy A04. 

Contents of this repository should be cloned in the `target/a04/patches/tee` folder. You can use the following command to set them up in your UN1CA-based environment as long as `a04` is your target. The a04 target already comes with these TEE files, but if in your case it doesn't then run the command
```
git clone https://github.com/ohjhas/target_a04_patches_tee target/a04/patches/tee
```

They make it possible to support booting on multiple bootloader versions (so multiple variants) by shipping different TEE blobs which are dynamically mounted at boot time. TEEGris on A34 requires the version signature of each TA to match with the version of the bootloader.

Only latest firmware for each model is supported.


### License
All files of this project are currently under GPLv3 license, this excludes all the prebuilt files located in vendor/tee_* directories.

You can use this project but you must make sure you give credits to me and the other prople who made this possible.

### Credits
- [@Fede2782](https://github.com/Fede2782) for his awesome (tbh) work on https://github.com/UN1CA/target_a34x_patches_tee, the original repo this was forked from.
- [@salvogiangri](https://github.com/salvogiangri)
- [@jesec](https://github.com/jesec) and [@corsicanu](https://github.com/corsicanu) for the original GitHub Actions script

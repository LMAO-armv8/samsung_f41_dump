#!/vendor/bin/sh
if ! applypatch --check EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:4af89a5b450385eedb7a1fd1e0fe085cc0352095; then
  applypatch \
          --patch /vendor/recovery-from-boot.p \
          --source EMMC:/dev/block/by-name/boot$(getprop ro.boot.slot_suffix):61865984:48eb1751f7873aa5642697cf74a5c5c10bc58c37 \
          --target EMMC:/dev/block/by-name/recovery$(getprop ro.boot.slot_suffix):71106560:4af89a5b450385eedb7a1fd1e0fe085cc0352095 && \
      (log -t install_recovery "Installing new recovery image: succeeded" && setprop vendor.ota.recovery.status 200) || \
      (log -t install_recovery "Installing new recovery image: failed" && setprop vendor.ota.recovery.status 454)
else
  log -t install_recovery "Recovery image already installed" && setprop vendor.ota.recovery.status 200
fi


FROM ghcr.io/charles8191/rocky-bootc:r9
RUN set -euxo pipefail && \
    mkdir -m 0700 -p /var/roothome && \
    ln -sf /run /var/run && \
    dnf install -x cockpit,kmod-kvdo,PackageKit,PackageKit-command-not-found,vdo -y \
      alsa-sof-firmware \
      @base \
      @base-x \
      firefox \
      @fonts \
      gdm \
      @gnome-desktop \
      @guest-desktop-agents \
      gnome-tweaks \
      @hardware-support \
      @networkmanager-submodules \
      @print-client && \
    dnf remove -y console-login-helper-messages{,profile} && \
    systemctl set-default graphical.target && \
    kver=$(cd /usr/lib/modules && echo * | awk '{print $1}') && \
    dracut -vf /usr/lib/modules/$kver/initramfs.img $kver && \
    dnf clean all && \
    ostree container commit && \
    bootc container lint
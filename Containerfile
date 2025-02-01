FROM ghcr.io/charles8191/rocky-bootc:r9
RUN set -euxo pipefail && \
    mkdir -m 0700 -p /var/roothome && \
    ln -sf /run /var/run && \
    sed -i 's,ExecStart=/usr/bin/bootc update --apply --quiet,ExecStart=/usr/bin/bootc update --quiet,g' \
      /usr/lib/systemd/system/bootc-fetch-apply-updates.service && \
    echo 'KERNEL=="loop0", ENV{UDISKS_IGNORE}="1"' > /etc/udev/rules.d/10-bootc.rules && \
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
      man-db
      @networkmanager-submodules \
      @print-client && \
    dnf remove -y console-login-helper-messages{,profile} && \
    mkdir -p /etc/flatpak/remotes.d && \
    curl -o /etc/flatpak/remotes.d/flathub.flatpakrepo https://dl.flathub.org/repo/flathub.flatpakrepo && \
    systemctl set-default graphical.target && \
    kver=$(cd /usr/lib/modules && echo * | awk '{print $1}') && \
    dracut -vf /usr/lib/modules/$kver/initramfs.img $kver && \
    dnf clean all && \
    ostree container commit && \
    bootc container lint

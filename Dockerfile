FROM quay.io/centos/centos:stream10

ARG USERNAME=user

RUN <<EOCONF
echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf
echo 'fastestmirror=True' >> /etc/dnf/dnf.conf
EOCONF

RUN <<EORUN
dnf config-manager --set-enabled crb
dnf install -y -q epel-release git jq sudo
dnf install -y -q chezmoi gum
EORUN

RUN <<EORUN
useradd -m -s /bin/bash ${USERNAME}
echo "${USERNAME} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${USERNAME}
chmod 0440 /etc/sudoers.d/${USERNAME}
EORUN

RUN <<EORUN
mkdir -p /home/${USERNAME}/.local/share/chezmoi
chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}/.local
EORUN

VOLUME /home/${USERNAME}/.local/share/chezmoi

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

USER ${USERNAME}
WORKDIR /home/${USERNAME}

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

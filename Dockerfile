FROM quay.io/centos/centos:stream10-development

ARG USERNAME=user

RUN <<EOCONF
echo 'max_parallel_downloads=10' >> /etc/dnf/dnf.conf
echo 'fastestmirror=True' >> /etc/dnf/dnf.conf
EOCONF

RUN --mount=type=cache,target=/var/cache/dnf,sharing=locked <<EORUN
dnf install -y -q sudo git epel-release
dnf install -y -q chezmoi
EORUN

RUN <<EORUN
useradd -m -u 1000 -s /bin/bash ${USERNAME}
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

#!/usr/bin/env bash

set -e

echo $TEMPLATE_SSH_PUBLIC_KEY > /tmp/ssh_public_key

qm set 9000 --ciuser $TEMPLATE_SSH_USER
qm set 9000 --sshkeys /tmp/ssh_public_key
qm set 9000 --name ubuntu-ci

rm /tmp/ssh_public_key
qm destroy 8999 --purge || echo "VM already missing."

MESSAGE=$(cat <<-END
Subject: build-template

Successfully built template ubuntu-ci
END
)

echo "$MESSAGE" | proxmox-mail-forward

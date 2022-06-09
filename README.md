# proxmox-build-template

A project which builds a cloud-init enabled Ubuntu VM template on Proxmox. Improvements can be made, but it works OOTB as is, just make sure, that VM IDs 8999 and 9000 are not taken yet.

Nightly job first fetches the latest cloud-init enabled Ubuntu VM image, then prepares a Proxmox VM to template, `packer` creates a template from that prepared VM and configures the template with cloud-init defaults (SSH user and public key association). It also sends a notification with `pvemailforward`.

## Installation

Installation is intended to be done on the Proxmox host itself.

### Install dependencies

```
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
apt-get update && apt-get install packer libguestfs-tools wget
```

### Clone the repository

Clone the repository to `/opt`.

```
git clone https://github.com/mfin/proxmox-build-template /opt/build-template
cd /opt/build-template
```

### Configuration

Copy the environment variable file and edit with your own parameters.

```
cp env .env
vim .env
```

### Setup systemd timers
By default, the build-template service runs each night at 00:15.

```
make install
systemctl daemon-reload
systemctl enable --now build-template.timer
```


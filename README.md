# proxmox-build-template

A project which builds a cloud-init enabled Ubuntu VM template on Proxmox. Improvements can be made, but it works OOTB as is.

## Installation

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


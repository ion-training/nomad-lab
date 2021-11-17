#!/usr/bin/env bash

export DEBIAN_FRONTEND=noninteractive

# pre-reqs
apt-get update
apt-get install -y zip unzip

# hashicorp apt repo
curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -
apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"

# install nomad
apt-get update
apt-get install -y nomad
hash -r
nomad --autocomplete-install

# create directories
mkdir -p /opt/nomad
mkdir -p /etc/nomad.d

chmod 700 /opt/nomad
chmod 700 /etc/nomad.d

cp -ap /vagrant/conf/client/nomad.hcl /etc/nomad.d/
chown -R nomad: /etc/nomad.d /opt/nomad/

cp -ap /vagrant/conf/nomad.service /etc/systemd/system/

# nomad set bash env
cp -ap /vagrant/conf/nomad-bash-env.sh /etc/profile.d/

systemctl enable nomad
systemctl start nomad


# install docker
apt-get install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update
apt-get install -y docker-ce docker-ce-cli containerd.io

# add auto completion for docker
curl -fsSL https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/bash/docker-compose -o /etc/bash_completion.d/docker-compose

# facilitate nomad access to docker
sudo usermod -G docker -a nomad

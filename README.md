# Nomad LAB

This repo contains a nomad server and a nomad client that runes workloads.

# Topology
```

  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
  x                x                  x                x                  x                x
  x     server     x                  x     client     x                  x     syslog     x
  x  nomad server  x                  x  nomad client  x                  x                x
  x                x                  x      Docker    x                  x                x
  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx                  xxxxxxxxxxxxxxxxxx
          | .71                               | .72                                    |.70
          |-----------------------------------|------------------------------------|
                                       192.168.56.0/24       
```
# How to use this repo
Download this repo and cd into it
```
git clone git@github.com:ion-training/nomad-lab.git
```
```
cd nomad-lab
```
Vagrant up
```
vagrant up --provision
```
Check status of VMs and their names 
```
vagrant status
```

# SSH into the machines
Client
```
vagrant ssh client
```
Server
```
vagrant ssh server
```
Syslog
```
vagrant ssh syslog
```

To stop the machines (you can stop individual machines only), from nomad-lab
```
vagrant halt
```

Destroy machines
```
vagrant destroy
```

# code organization

```
tree
.
├── LICENSE
├── README.md
├── Vagrantfile
├── conf
│   ├── client
│   │   ├── nomad-bash-env.sh
│   │   ├── nomad.hcl
│   │   └── nomad.service
│   └── server
│       ├── nomad-bash-env.sh
│       ├── nomad.hcl
│       └── nomad.service
└── scripts
    ├── client.sh
    ├── server.sh
    └── syslog.sh
```
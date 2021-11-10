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
          |-----------------------------------|----------------------------------------|
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

# Sample output server
```
vagrant@server:~$ nomad server members 
Name           Address        Port  Status  Leader  Protocol  Build  Datacenter  Region
server.global  192.168.56.71  4648  alive   true    2         1.1.6  dc1         global
vagrant@server:~$ 
```

# Sample output client
```
vagrant@client:~$ nomad node status c9b56a60
ID              = c9b56a60-6e2b-9ffe-8a19-b3ca08943b22
Name            = client
Class           = <none>
DC              = dc1
Drain           = false
Eligibility     = eligible
Status          = ready
CSI Controllers = <none>
CSI Drivers     = <none>
Uptime          = 25m12s
Host Volumes    = <none>
CSI Volumes     = <none>
Driver Status   = <none>

Node Events
Time                  Subsystem  Message
2021-11-10T13:54:22Z  Cluster    Node registered

Allocated Resources
CPU         Memory       Disk
0/4800 MHz  0 B/1.9 GiB  0 B/57 GiB

Allocation Resource Utilization
CPU         Memory
0/4800 MHz  0 B/1.9 GiB

Host Resource Utilization
CPU         Memory          Disk
0/4800 MHz  95 MiB/1.9 GiB  (/dev/mapper/vagrant--vg-root)

Allocations
No allocations placed
vagrant@client:~$ 
```

# Sample output syslog server
```
vagrant@syslog:~$ systemctl status systemd-journald
● systemd-journald.service - Journal Service
   Loaded: loaded (/lib/systemd/system/systemd-journald.service; static; vendor preset: enabled)
   Active: active (running) since Wed 2021-11-10 13:48:36 UTC; 34min ago
     Docs: man:systemd-journald.service(8)
           man:journald.conf(5)
 Main PID: 415 (systemd-journal)
   Status: "Processing requests..."
    Tasks: 1 (limit: 1135)
   CGroup: /system.slice/systemd-journald.service
           └─415 /lib/systemd/systemd-journald

Nov 10 13:48:36 vagrant systemd-journald[415]: Journal started
Nov 10 13:48:36 vagrant systemd-journald[415]: Runtime journal (/run/log/journal/1c1063f97b1b429c83c4a23b7b1a1c0d) is 1.2M, max 9.8M, 8.6M free.
Nov 10 13:48:37 vagrant systemd-journald[415]: Time spent on flushing to /var is 30.424ms for 450 entries.
Nov 10 13:48:37 vagrant systemd-journald[415]: System journal (/var/log/journal/1c1063f97b1b429c83c4a23b7b1a1c0d) is 16.0M, max 4.0G, 3.9G free.
Warning: Journal has been rotated since unit was started. Log output is incomplete or unavailable.
vagrant@syslog:~$ 
```

## What`s Inside

* Two VMs provisioned by Puppet

* Debian 8 Jessie [box](https://vagrantcloud.com/lazyfrosch/boxes/debian-8-jessie-amd64-puppet)

* MySQL 5.5

## Installation

```bash
$ vagrant up # install both master and slave machines
```

and start slave:

```bash
$ vagrant ssh slave1
$ mysql -u root -p123 -e 'change master to master_host = "192.168.12.101", master_user = "slave_user", master_password = "123", master_port = 3306;'
$ mysql -u root -p123 -e 'start slave;'
```

## SSH

```bash
$ vagrant ssh master # at 192.168.12.101
```

```bash
$ vagrant ssh slave1 # at 192.168.12.101
```

## Note

It's easy to create more slave machines. See `Vagrantfile` and `puppet/manifests` dir. Enjoy.

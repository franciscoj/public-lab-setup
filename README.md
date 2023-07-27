# Simple ansible playbook for Raspberry PI

Included:

- Pihole under docker-compose (rans along with traefik, duckdns and a whoami
  container to help debugging)
- PiVPN (with duckdns for dynamic public IP Addresses)
- Minecraft server (Papermc + backups)
- Transmission daemon + transmission web

## How to use it!

Install ansible on your OS, for example:

```sh
# Mac
brew install ansible

# Ubuntu
apt install ansible
```

Before running it you need to customize it to your network setup.

Look for `CHANGEME` and update:

- The IP address to the one your Raspberry PI has on your local network
- The timezone in which you are
- The duckdns subdomain you want to use

Edit the secrets (default password is `changeme`)

```sh
ansible-vault edit roles/torrent/files/secrets.yml
ansible-vault edit roles/lab/files/dot_env
```

Once your secrets are there, make sure you rekey them to update the password!

```sh
ansible-vault rekey roles/torrent/files/secrets.yml
ansible-vault rekey roles/lab/files/dot_env
```

Run it!

```sh
ansible-playbook --ask-vault-password -K -i inventory.yaml playbook.yaml --diff
```

In case you only want to run a subset of the playbooks (for example to upgrade
your minecraft server) you can, as a shortcut do:

```sh
make TAGS=minecraft
```

Have fun!

## How is everything setup?

Each one of the different playbooks sets up a user so that in case I break
stuff it is as isolated as possible.

I don't have an automated way to install the docker images yet, but what I
generally do is:

```sh
# ssh into the raspberry
sudo su - lab
cd /opt/lab
docker-compose pull
docker-compose restart
```

That will upgrade all the docker images to the latest version.

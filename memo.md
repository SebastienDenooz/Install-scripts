Add key to ssh server
---------------------
cat ~/.ssh/id_rsa.pub | ssh root@server.tld "cat - >> ~/.ssh/authorized_keys"

Virtualbox Config
-----------------
Type de connexion reseau: Connexion de pont
Configuration de l'host:
/etc/resolv.conf:
    domain home
    search home
    nameserver 192.168.1.1


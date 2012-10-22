Add key to ssh server
---------------------
<pre><code>cat ~/.ssh/id_rsa.pub | ssh root@server.tld "cat - >> ~/.ssh/authorized_keys"</code></pre>

Virtualbox Config
-----------------
- Type de connexion reseau: Connexion de pont

- Configuration de l'host:
	- /etc/resolv.conf:
<pre>
domain home
search home
nameserver 192.168.1.1
</pre>


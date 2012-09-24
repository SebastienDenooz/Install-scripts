#!/bin/sh

WWW_DIR=/var/www
WEBSITE=$1
WEBSITE_LEN=${#WEBSITE}
MIN_LEN=1
www=`expr match "$WEBSITE" '^[w]*\.'`

if [ "$WEBSITE_LEN" -le "$MIN_LEN" ]
then
	echo "You must give a domain name with minimum $MIN_LEN char."
	exit 1
fi

if [ $www = 4 ]
then
	echo "Don't give a domain name with 'www.' at the beginning, it will be automaticly added."
	exit 1
fi

mkdir $WWW_DIR/$WEBSITE
mkdir $WWW_DIR/$WEBSITE/public
mkdir $WWW_DIR/$WEBSITE/logs
mkdir $WWW_DIR/$WEBSITE/cgi-bin

echo "#
#  $WEBSITE (/etc/apache2/sites-available/$WEBSITE)
#
<VirtualHost *:80>
        ServerAdmin webmaster@$WEBSITE
        ServerName  www.$WEBSITE
        ServerAlias $WEBSITE

        # Indexes + Directory Root.
        DirectoryIndex index.html
        DocumentRoot $WWW_DIR/$WEBSITE/public/

        # CGI Directory
        ScriptAlias /cgi-bin/ $WWW_DIR/$WEBSITE/cgi-bin/
        <Location /cgi-bin>
                Options +ExecCGI
        </Location>


        # Logfiles
        ErrorLog  $WWW_DIR/$WEBSITE/logs/error.log
        CustomLog $WWW_DIR/$WEBSITE/logs/access.log combined
</VirtualHost>" > /etc/apache2/sites-available/$WEBSITE

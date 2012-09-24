#!/bin/sh
echo "Downloading Symfony..."
wget --output-document=symfony.tgz http://symfony.com/download?v=Symfony_Standard_2.0.6.tgz

echo "Extracting Symfony..."
tar xvzf symfony.tgz

echo "Entering Symfony..."
cd Symfony/

echo "Backuping deps..."
cp deps deps.orig

echo "Adding timestampable and other to deps..."
echo "
[gedmo-doctrine-extensions]
   git=http://github.com/l3pp4rd/DoctrineExtensions.git

[Stof-DoctrineExtensionsBundle]
   git=https://github.com/stof/StofDoctrineExtensionsBundle.git
   target=/bundles/Stof/DoctrineExtensionsBundle" >> deps
   
echo "Installing vendors..."
php bin/vendors install

echo "Chmoding cache, logs and aparms.ini..."
chmod 777 app/cache/ -R
chmod 777 app/logs/ -R
chmod 777 app/config/parameters.ini

echo "Backuping app/config/config.yml..."
cp app/config/config.yml app/config/config.yml.orig


echo "Configure timestampable..."
echo "

# Doctrine Extensions Configuration
stof_doctrine_extensions:
        default_locale: en_us
        orm:
            default:
              timestampable: true
              
              " >> app/config/config.yml

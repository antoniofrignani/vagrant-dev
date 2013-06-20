export DEBIAN_FRONTEND=noninteractive
echo "Updating Ubuntu....."
sudo apt-get -qq -y update
#sudo apt-get -qq -y upgrade
echo "Updated Ubuntu"

echo "Installing tools... vim, curl etc..."
sudo apt-get -qq -y install curl
sudo apt-get -qq -y install vim
sudo apt-get -qq -y install git
sudo apt-get -qq -y install htop
sudo apt-get -qq -y install tmux

# Install Apache
sudo apt-get -qq -y install apache2

# Copy over default apache file to point to the public directory in /vagrant for laravel
sudo cp /vagrant/provision/default /etc/apache2/sites-available/default
sudo service apache2 restart
echo "Apache Intalled"

# Mysql
# Set default user and pass for mysql
echo 'mysql-server mysql-server/root_password password vagrant' | debconf-set-selections
echo 'mysql-server mysql-server/root_password_again password vagrant' | debconf-set-selections
sudo apt-get -qq -y install mysql-server mysql-client
echo "Mysql installed..."

# PHP
sudo apt-get -qq -y install php5 php5-common libapache2-mod-php5
sudo apt-get -qq -y install php5-cli php5-curl php5-gd php5-cgi php5-mysql php5-mcrypt phpunit
echo "PHP Installed, restarting Apache again!"
sudo service apache2 restart

# Composer
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer
echo "Composer Installed"


# Set read/write permissions for Laravel...
chmod -R 777 /vagrant/app/storage/

# Run composer update
cd /vagrant/
composer update

echo "Done"

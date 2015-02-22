set -x
sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm

sudo yum install -y mysql mysql-server nginx php-fpm php-mysql
sudo /etc/init.d/mysqld restart


myIp=`ifconfig eth0 | sed -n '/inet addr.*Mask/s/.*inet addr:\(.*\) Bcast.*/\1/p'`

sed -i 's/^cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php.ini
cp default.conf /etc/php-fpm/conf.d/.

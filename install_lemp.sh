set -x
#sudo rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm
#sudo rpm -Uvh http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
sudo yum install epel-release

sudo yum install -y mysql mysql-server nginx php-fpm
sudo /etc/init.d/mysqld restart

[[ $1 == "nophp" ]] || sudo yum install -y php-mysql
BASEDIR=$(dirname $0)

myIp=`ifconfig eth0 | sed -n '/inet addr.*Mask/s/.*inet addr:\(.*\) Bcast.*/\1/p'`

sed -i 's/^;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php.ini
cp ${BASEDIR}/default.conf /etc/nginx/conf.d/.
sed -i 's/^user = apache$/user = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^group = apache$/group = nginx/' /etc/php-fpm.d/www.conf
sed -i 's/^worker_process[ ]*1/worker_processes  4;/' /etc/nginx/nginx.conf
worker_processes  1;

service nginx restart
service php-fpm restart

#!/bin/bash -eux

echo "==> Remove PackageKit"
yum remove -y PackageKit

echo "==> Add epel repo"
yum install -y epel-release

echo "==> Add mysql repo"
wget https://dev.mysql.com/get/mysql80-community-release-el7-1.noarch.rpm
rpm -Uvh mysql80-community-release-el7-1.noarch.rpm
yum-config-manager --disable mysql80-community
yum-config-manager --enable mysql57-community

echo "==> Add mongodb repo"
/bin/cat <<EOM >/etc/yum.repos.d/mongodb-org-3.4.repo
[mongodb-org-3.4]
name=MongoDB Repository
baseurl=https://repo.mongodb.org/yum/redhat/7/mongodb-org/3.4/x86_64/
gpgcheck=1
enabled=1
gpgkey=https://www.mongodb.org/static/pgp/server-3.4.asc
EOM

echo "==> Install packages"
yum update -y
yum install -y gitk perl-CPAN perl-core perl-devel firefox dos2unix htop libxml2-devel libxslt-devel openssl-devel expat-devel tree httpd mysql-server mongodb-org perl-DBD-MySQL vim-X11 vim-common vim-enhanced vim-minimal

echo "==> Enable httpd"
systemctl enable httpd.service
systemctl restart httpd.service

echo "==> Enable mysql"
systemctl enable mysqld.service
systemctl restart mysqld.service
var=$(awk '/temporary password/ { print $11 }' /var/log/mysqld.log)

mysql --connect-expired-password -uroot -p$var -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 'Super6ood!'"
mysql --connect-expired-password -uroot -pSuper6ood! -e "uninstall plugin validate_password"
mysql --connect-expired-password -uroot -pSuper6ood! -e "ALTER USER 'root'@'localhost' IDENTIFIED BY 's2iabos'"

echo "==> Turn off MySQL strict mode"
echo "sql-mode='NO_ENGINE_SUBSTITUTION'" >> /etc/my.cnf

echo "==> Increase MySQL max allowed package size"
echo "max_allowed_packet=64M" >> /etc/my.cnf

echo "==> Enable mongod"
systemctl enable mongod.service
systemctl restart mongod.service

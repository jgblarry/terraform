#!/bin/bash

#JENKINS INSTALL
sudo yum -y update
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key
yum install -y java-1.8.0
yum remove -y java-1.7.0
yum install -y jenkins
service jenkins start
sudo yum update -y
yum -y install nginx
chkconfig --add nginx 
chkconfig nginx on
sed -i 's/     listen       80 default_server;/      listen       80;/g' "/etc/nginx/nginx.conf"
sed -i 's/     listen       \[::\]:80 default_server;/     listen       \[::\]:80;/g' "/etc/nginx/nginx.conf"

cat >> /etc/nginx/conf.d/jenkins.conf << EOF
upstream jenkins {
    server 127.0.0.1:8080 fail_timeout=0;
}
server {
    listen 80 default_server;

    access_log  /var/log/nginx/jenkins.access.log;
    error_log   /var/log/nginx/jenkins.error.log;

    proxy_buffers 16 64k;
    proxy_buffer_size 128k;
    #ssl_certificate /etc/nginx/ssl/crt;
    #ssl_certificate_key /etc/nginx/ssl/key;

    location / {
        proxy_pass  http://jenkins;
        proxy_next_upstream error timeout invalid_header http_500 http_502 http_503 http_504;
        #proxy_redirect http://  https://;

        proxy_set_header    Host            \$host:\$server_port;
        proxy_set_header    X-Real-IP       \$remote_addr;
        proxy_set_header    X-Forwarded-For \$proxy_add_x_forwarded_for;
        proxy_set_header    X-Forwarded-Proto \$scheme;
    }
}
EOF
service nginx start

#MONITORING AGENT
sudo yum update -y
sudo yum install perl-Switch perl-DateTime perl-Sys-Syslog perl-LWP-Protocol-https -y
sudo mkdir /opt/aws/
cd /opt/aws/
curl http://aws-cloudwatch.s3.amazonaws.com/downloads/CloudWatchMonitoringScripts-1.2.1.zip -O
unzip CloudWatchMonitoringScripts-1.2.1.zip
rm -rf CloudWatchMonitoringScripts-1.2.1.zip    
cd /opt/aws/aws-scripts-mon
CRONTAB=/var/spool/cron/root
echo "* * * * * /opt/aws/aws-scripts-mon/mon-put-instance-data.pl --mem-util --disk-space-util --disk-path=/ --from-cron" > $CRONTAB

#IP=$(curl http://169.254.169.254/latest/meta-data/public-ipv4)

# GET ADMIN PASSWORD JENKINS
PASSWDJK=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
while [ -z $PASSWDJK ]; do
        sleep 3
        PASSWDJK=$(cat /var/lib/jenkins/secrets/initialAdminPassword)
done
if [ -n $PASSWDJK ]; then
        ADMINPASSWD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)
else 
        #Nothing to do
fi
echo "$ADMINPASSWD" >> /home/ec2-user/AdminPasswdJenkins

#INSTALAR OPENVPN

#CREAR UN CERTIFICADO OPENVPN Y SUBIRLO AL MISMO BUCKET S3 DEL TFSTATE
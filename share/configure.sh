# configure work directory's access grant
cp /share/000-default.conf /etc/apache2/sites-enabled/000-default.conf

# deploy wechat app
cp -rf /share/wx /var/www/html/wx
chmod -R 755 /var/www/html/wx

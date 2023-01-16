FROM debian:buster

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y nginx emacs wget libnss3-tools unzip mariadb-server mariadb-client curl
RUN apt-get install -y php7.3 php7.3-fpm php7.3-mysql php-common php7.3-cli php7.3-common php7.3-json php7.3-opcache php7.3-readline php-mbstring unzip

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.zip
RUN unzip phpMyAdmin-4.9.0.1-all-languages.zip
RUN mv phpMyAdmin-4.9.0.1-all-languages /var/www/html/phpmyadmin
COPY srcs/phpmyadmin/config.inc.php /var/www/html/phpmyadmin/config.inc.php
RUN rm -rf phpMyAdmin-4.9.0.1-all-languages.zip

RUN mkdir /var/www/html/phpmyadmin/tmp
RUN chmod 777 /var/www/html/phpmyadmin/tmp

RUN chown -R www-data:www-data /var/www/html/phpmyadmin


# SSL - Downloading a tool that makes locally trusted certificates.
RUN wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.1/mkcert-v1.4.1-linux-arm
# SSL - Makes the mkcert an executable.
RUN chmod 777 mkcert-v1.4.1-linux-arm
RUN mv mkcert-v1.4.1-linux-arm /usr/local/bin/mkcert
RUN /usr/local/bin/mkcert -install
# SSL - Generates a certificate/certificate key for the domain localhost.
RUN mkcert localhost

COPY srcs/nginx/default /etc/nginx/sites-available/default
RUN mkdir /etc/nginx/ssl
RUN mv localhost.pem /etc/nginx/ssl
RUN mv localhost-key.pem /etc/nginx/ssl
RUN service mysql start && \
	mysql -e "CREATE USER 'admin' IDENTIFIED BY 'padmin';" && \
	mysql -e "GRANT USAGE ON *.* TO 'admin'@localhost IDENTIFIED BY 'padmin';" && \
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost';" && \
	mysql -u root < var/www/html/phpmyadmin/sql/create_tables.sql &&\
	mysql -e "FLUSH PRIVILEGES;"

RUN mkdir temp
COPY srcs/wordpress/latest.tar.gz /temp
RUN cd /var/www/html/ && \
	tar -xzf /temp/latest.tar.gz --strip-components=1 &&\
	rm -rf /temp/latest.tar.gz

RUN service mysql start && \
	mysql -e "CREATE DATABASE wordpress_db;" && \
	mysql -e "GRANT ALL ON wordpress_db.* TO 'wordpress_user'@'localhost' IDENTIFIED BY 'password';" && \
	mysql -e "FLUSH PRIVILEGES;"

COPY srcs/wordpress/upload_max.zip /var/www/html/wp-content/plugins/
RUN cd /var/www/html/wp-content/plugins && unzip upload_max.zip && rm -rf /var/www/html/wp-content/plugins/upload_max.zip
COPY srcs/wordpress/wp-config.php /var/www/html/
COPY srcs/wordpress/wordpress /etc/nginx/sites-available/
COPY srcs/wordpress/php.ini /etc/php/7.3/fpm/

RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod 777 wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp
RUN cd /var/www/html/wp-content &&\
	mkdir uploads &&\
	chmod 777 uploads

RUN service nginx start &&\
	service php7.3-fpm start &&\
	service mysql start &&\
	wp core install --url=localhost --title="Codam 42" --admin_name=wordpress_user --admin_password=password --admin_email=rkieboom@student.codam.nl --allow-root --path=/var/www/html &&\
	wp plugin activate upload_max --allow-root --path=/var/www/html
	



EXPOSE 80 443
CMD service nginx start && service mysql start && service php7.3-fpm start && tail -f /dev/null
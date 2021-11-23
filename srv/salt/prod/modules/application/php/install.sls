/tmp/oniguruma-devel-6.8.2-2.el8.x86_64.rpm:
  file.managed:
    - source: salt://modules/application/php/files/oniguruma-devel-6.8.2-2.el8.x86_64.rpm
    - user: root
    - group: root
    - mode: '0644'
  cmd.run:
    - name: yum -y install /tmp/oniguruma-devel-6.8.2-2.el8.x86_64.rpm

php-dep-package:
  pkg.installed:
    - pkgs:
      - libxml2 
      - libxml2-devel 
      - libsqlite3x-devel
      - openssl 
      - openssl-devel 
      - bzip2 
      - bzip2-devel 
      - libcurl 
      - libcurl-devel 
      - libicu-devel 
      - libjpeg-turbo
      - libjpeg-turbo-devel 
      - libpng 
      - libpng-devel 
      - openldap-devel  
      - pcre-devel 
      - freetype 
      - freetype-devel 
      - gmp 
      - gmp-devel 
      - libmcrypt 
      - libmcrypt-devel 
      - readline 
      - readline-devel 
      - libxslt 
      - libxslt-devel 
      - libzip
      - libzip-devel
      - mhash 
      - mhash-devel 
      - php-mysqlnd
      - make
      - gcc
      - gcc-c++ 

/usr/src:
  archive.extracted:
    - source: salt://modules/application/php/files/php-7.4.24.tar.xz

salt://modules/application/php/files/install.sh:
  cmd.script

copy-file-php:
  file.managed:
    - names:
      - /usr/local/php7/etc/php-fpm.conf:
        - source: salt://modules/application/php/files/php-fpm.conf.default
      - /usr/local/php7/etc/php-fpm.d/www.conf:
        - source: salt://modules/application/php/files/www.conf.default
      - /etc/init.d/php-fpm:
        - source: salt://modules/application/php/files/init.d.php-fpm
        - user: root
        - group: root
        - mode: '0755'
      - /usr/lib/systemd/system/php-fpm.service:
        - source: salt://modules/application/php/files/php-fpm.service


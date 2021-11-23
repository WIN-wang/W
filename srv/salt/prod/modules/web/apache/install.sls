"Development Tools":
  pkg.group_installed
   
httpd-dep-packages:
  pkg.installed:
    - pkgs:
      - openssl-devel
      - pcre-devel
      - expat-devel
      - libtool
      - gcc
      - gcc-c++
      - make

create-httpd-user:
  user.present:
    - name: apache
    - shell: /sbin/nologin
    - createhome: false
    - system: true

copy-software:
  file.managed:
    - names:
      - /usr/src/apr-1.7.0.tar.gz:
        - source: salt://modules/web/apache/file/apr-1.7.0.tar.gz
      - /usr/src/apr-util-1.6.1.tar.gz:
        - source: salt://modules/web/apache/file/apr-util-1.6.1.tar.gz
      - /usr/src/httpd-2.4.48.tar.gz:
        - source: salt://modules/web/apache/file/httpd-2.4.48.tar.gz

salt://modules/web/apache/file/install.sh:
  cmd.script

/usr/local/apache/conf/httpd.conf:
  file.managed:
    - source: salt://modules/web/apache/file/httpd.conf
    - user: root
    - group: root
    - mode: '0644'

/usr/lib/systemd/system/httpd.service:
  file.managed:
    - source: salt://modules/web/apache/file/httpd.service 
    - user: root
    - group: root
    - mode: '0644'


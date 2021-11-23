/etc/my.cnf.d/master.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/master.cnf
    - user: root
    - group: root
    - mode: '0644'

master-service:
  service.running:
    - enable: true
    - name: mysqld.service
    - reload: true
    - watch:
      - file: /etc/my.cnf.d/master.cnf

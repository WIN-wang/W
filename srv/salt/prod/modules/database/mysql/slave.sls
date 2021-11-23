include:
  - modules.database.mysql.install

/etc/my.cnf.d/slave.cnf:
  file.managed:
    - source: salt://modules/database/mysql/files/slave.cnf
    - user: root
    - group: root
    - mode: '0644'

slave-service:
  service.running:
    - name: mysqld.service
    - enable: true
    - rolead: true
    - watch:
      - file: /etc/my.cnf.d/slave.cnf
      - file: /etc/my.cnf

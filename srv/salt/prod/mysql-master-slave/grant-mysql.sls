set-password-mysql:
  cmd.run:
    - name: {{ pillar['install_dir'] }}/bin/mysql -e "set password = password('{{ pillar['password'] }}');"
    - require:
      - service: mysqld.service
    - unless: {{ pillar['install_dir'] }}/bin/mysql -uroot -p'{{ pillar['password'] }}' -e 'exit'


master-grant:
  cmd.run:
    - name: {{ pillar['install_dir'] }}/bin/mysql -uroot -p'{{ pillar['password'] }}' -e  "GRANT REPLICATION SLAVE,super ON *.* TO 'wjm'@'%' IDENTIFIED BY '{{ pillar['password'] }}'; FLUSH PRIVILEGES;"
    - unless: {{ pillar['install_dir'] }}/bin/mysql -uroot -p'{{ pillar['password'] }}' -e "select user from mysql.user;" | grep wjm 


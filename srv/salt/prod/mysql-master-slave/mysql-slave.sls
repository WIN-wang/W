include:
  - modules.database.mysql.slave

set-password-mysql:
  cmd.run: 
    - name: {{ pillar['install_dir'] }}/bin/mysql -e "set password = password('{{ pillar['password'] }}');"
    - unless: {{ pillar['install_dir'] }}/bin/mysql -uroot -p'{{ pillar['password'] }}' -e 'exit'

start-slave:
  file.managed:
    - name: /tmp/mysql-install.sh
    - source: salt://mysql-master-slave/files/mysql-install.sh.j2
    - mode: '0755'
    - template: jinja
  cmd.run:
    - name: /bin/bash  /tmp/mysql-install.sh
    - unless: test $( {{ pillar['install_dir'] }}/bin/mysql -uroot -pwjm123 -e "show slave status\G;" | grep '_Running' | grep -c 'Yes')  -eq 2

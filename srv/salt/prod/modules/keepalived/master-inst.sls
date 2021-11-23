install-keeplived:
  pkg.installed:
    - name: keepalived

copu-keepalived.conf:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://modules/keepalived/files/master-keep.conf.j2
    - template: jinja
    - reuqire:
      - pkg: install-keeplived

create-shell:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - name: /scripts

copy-shell:
  file.managed:
    - source: salt://modules/keepalived/files/check_h.sh
    - name: {{ pillar['shell'] }}/check_h.sh
    - mode: '0755'
      



service-keepalived:
  service.running:
    - name: keepalived
    - reload: true
    - require: 
      - file: copy-shell
      - file: copu-keepalived.conf
    - watch:
      - file: copu-keepalived.conf

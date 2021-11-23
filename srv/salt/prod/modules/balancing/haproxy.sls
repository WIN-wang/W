http-isntall:
  pkg.installed:
    - pkgs:
      - make
      - gcc
      - pcre-devel
      - bzip2-devel
      - openssl-devel
      - systemd-devel

haproxy:
  user.present:
    - system: true
    - createhome: false
    - shell: /sbin/nologin

tar-haproxy:
  archive.extracted:
    - source: salt://modules/balancing/files/haproxy-2.4.0.tar.gz
    - name: {{ pillar['harproxy_ins'] }}


install-haproxy:
  cmd.script:
    - name: salt://modules/balancing/files/install.sh {{ pillar['harproxy_ins'] }}
    - require:
      - archive: tar-haproxy
    - unless:  test $(ls -d {{ pillar['harproxy_ins'] }}/haproxy-2.4.0)

/etc/profile.d/haproxy.sh:
  file.managed:
    - source: salt://modules/balancing/files/haproxy.sh
    - require:
      - cmd: install-haproxy

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1

net.ipv4.ip_forward:
  sysctl.present:
    - value: 1


mkdir-haproxy:
  file.directory:
    - user: root
    - group: root
    - mode: '0755'
    - makedirs: true
    - name: /etc/haproxy

copy-haproxy:
  file.managed:
    - source: salt://modules/balancing/files/haproxy.cfg.j2
    - name: /etc/haproxy/haproxy.cfg
    - template: jinja

copy-service:
  file.managed:
    - source: salt://modules/balancing/files/haproxy.service.j2
    - name: /usr/lib/systemd/system/haproxy.service
    - user: root
    - group: root
    - mode: '0644'
    - template: jinja

copu-rsyslog.conf:
  file.managed:
    - name: /etc/rsyslog.conf
    - source: salt://modules/balancing/files/rsyslog.conf
    


haproxy-service:
  service.running:
    - name: haproxy.service
    - enable: true
    - reuqire:
      - file: copy-service
      - file: copu-rsyslog.conf
    - watch:
      - file: copu-rsyslog.conf

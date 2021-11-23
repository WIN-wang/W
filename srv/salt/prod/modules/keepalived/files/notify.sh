#!/bin/bash
VIP=$2
case "$1" in
  master)
        httpd_status=$(ps -ef|grep -Ev "grep|$0"|grep '\bhttpd\b'|wc -l)
        if [ $httpd_status -lt 1 ];then
            systemctl start httpd
        fi
  ;;
  backup)
        httpd_status=$(ps -ef|grep -Ev "grep|$0"|grep '\bhttpd\b'|wc -l)
        if [ $httpd_status -gt 0 ];then
            systemctl stop httpd
        fi
  ;;
  *)
        echo "Usage:$0 master|backup VIP"
  ;;
esac

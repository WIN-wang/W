#!/bin/bash
httpd_status=$(ps -ef|grep -Ev "grep|$0"|grep '\bhttpd\b'|wc -l)
if [ $httpd_status -lt 1 ];then
    systemctl stop keepalived
fi

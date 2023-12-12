vim /etc/rsyslog.conf 
#save ldap logs
local4.* /var/log/ldap.log

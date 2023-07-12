9- Manage content
Create and use templates to create customized configuration files
Use Ansible Vault in playbooks to protect sensitive data

PARRALLELISM
forks = 50 (how many simultaneous processes should control node start)
how many nodes a task is being executed on at a time
  hosts: vmservers
  serial:
    - 1
    - 2
    - 50%
  tasks:
first run all tasks on server 1, then 2, then 50% of all left
"********************************************************************************"

VAULT
{TASK1}
[ansible@x230 automation]$ vim playbooks/ansible_vault.yml
---
- name: Ansible Vault Playbook
  hosts: web
  vars:
    pw: redhat
  tasks:
    - name: Creating user account and password
      user:
        name: trump
        password: "{{ pw }}"

ansible-vault encrypt playbook/ansible_vault.yml
[ansible@x230 automation]$ ansible-vault encrypt playbooks/ansible_vault.yml
New Vault password:
Confirm New Vault password:
Encryption successful
[ansible@x230 automation]$ cat playbooks/ansible_vault.yml
$ANSIBLE_VAULT;1.1;AES256
#Adv Encryption Standard - 256 bit key used to convert text into cipher


encrypt whole file
[ansible@x230 automation]$ ansible-playbook playbooks/ansible_vault.yml --ask-vault-password
[ansible@x230 automation]$ ansible-vault edit playbook/ansible_vault.yml

encrypt only a variable and call it from encrypted file
[ansible@x230 automation]$ ansible-vault view playbook/ansible_vault2.yml
[ansible@x230 automation]$ ansible-vault create ~/crypt.yml
[ansible@x230 automation]$ ansible-vault rekey ~/crypt.yml

save password in a file
[ansible@x230 automation]$ ansible-vault encrypt playbook/ansible_vault3.yml
passowrd: redhat
vim pass.txt 
redhat
[ansible@x230 automation]$ ansible-playbook playbooks/ansible_vault3.yml --vault-password-file pass.txt


encrypt a string
[ansible@x230 automation]$ ansible-vault encrypt_string 'bar' --name 'foo'
foo has been encrypted as bar
[ansible@x230 automation]$ ansible-vault encrypt_string 'bar' --name 'foo' > bar.txt



"*************************************************************"
"JINJA2 TEMPLATES"
Python based templating engine
helpful in creating static configuration files for each of the node
jinja2 templates store variables that can change from time to time 
All templating happens on the Ansible Controller before the task is sent, This approach minimizes the package requirements on the target machines
j2 template file is a text file that contains variables that get evaluated and replaced by actual values upon runtime or code execution.
{{}} used when you call a variable in the template
{% %} used for control statements such as loops & if-else statements
{# #} comments
JINJA2 IS SIMILAR TO copy module. copy module is static, jinja template is dynamic
in most cases, jinja2 Templates are used for creating files or Replacing Configurations on servers
Template files bear .j2 extension
No other MODULE can be used, only TEMPLATE MODULE is used
- name:
  template:
    path: ~/automation/templates/motd.j2
you can use ANSIBLE_FACTS as variable in templates

motd.j2
***** Welcome to {{ ansible_distribution }} Server. *****
IP Address of This Machine is {{ ansible_all_ipv4_addresses }}
Today is {{ ansible_date_time['date'] }}

motb.yml
---
- name: MOTD file creation playbook
  hosts: web
  tasks:
    - name: Copying MOTD file from Ansible server to managed nodes
      template:
        src: ~/automation/templates/motd.j2
        dest: /etc/motd


"*************************************************************"
index.j2
<html>
<center><h1>*** Apache Webserver Hosted on {{ ansible_hostname }} ***</h1></center>
</html>
~"*************************************************************"
---
- name: instal and configure apache for nodes
  hosts: web
  tasks:
    - name: check if installed.
      yum:
        name: httpd
        state: latest
    - service:
        name: httpd
        state: started
        enabled: true
    - name: configure index.html
      template:
        src: ~/automation/templates/index.j2
        dest: /var/www/html/index.html
    - name: restart Apache
      service:
        name: httpd
        state: restarted
    - name: firewalld
      firewalld:
        service: http
        permanent: true
        immediate: true
        state: enabled
    - name: restart firewalld
      service:
        name: firewalld
        state: restarted


"*************************************************************"
fruits.j2
The list of fruit names are as follows
{% for item in fruits %}

{{ item }}

{% endfor %}

"*************************************************************"
jinja_conditionals.yml
---
- name: Ansible jinja template with conditionals
  hosts: web
  vars:
    fruits:
      - mango
      - banana
      - orange
      - grapes
      - apple
      - papaya
  tasks:
    - name: Using loop with jinj2 template
      template:
        src: ~/automation/template/fruit_loop.j2
        dest: /home/rupert/fruits.txt
~
"*************************************************************"
[USING FILTERS WITH jinja2]
{{ variable | arguement }}
# e.g. we want upper case letters of the string
[ansible@x230 automation]$ vim templates/fruit_loop.j2
The list of fruit names are as follows
{% for item in fruits %}
{{ item | upper }}
{% endfor %}

{% for item in fruits %}
{{ item | upper }}
{% endfor %}


numbers.j2
The lowest number is: {{ [ 100, 37, 45, 65, 83, 23, 17 ] | min }}
The highest number is: {{ [ 100, 37, 45, 65, 83, 23, 17 ] | max }}

on node: The lowest number is : 17

The unique number is: {{ [ 3, 4, 2, 4, 4, 5, 2, 3, 3, 2 ] | unique }}

on node: The unique numbers are : 2,3,4,5

[ansible@x230 automation]$ vim templates/strings.j2
{{ "Hello World" | replace ("World", "Everyone") }}

Note: You can make ideal solution in Ansible by using templates for dynamic variables in config files



[rupert@server1 ~]$
logout
Connection to 192.168.100.101 closed.
[ansible@x230 automation]$ cat templates/info.j2
Hostname = {{ ansible_hostname }}
Operating System = {{ ansible_distribution }} {{ ansible_distribution_version }}
IPV4 Address = {{ ansible_default_ipv4.address }}
IPV6 Address = {{ ansible_default_ipv6.address }}
Interfaces = {{ ansible_interfaces|join(', ') }}
Block Devices = {{ ansible_devices|join(', ') }}

[rupert@server1 ~]$ cat /tmp/info.txt
Hostname = server1
Operating System = RedHat 9.1
IPV4 Address = 192.168.100.101
IPV6 Address = 2407:aa80:314:a7b1::6
Interfaces = ens160, lo
Block Devices = dm-1, dm-10, nvme0n1, dm-8, dm-6, nvme0n6, dm-4, dm-13, nvme0n4, sr0, dm-2, dm-11, nvme0n2, dm-0, dm-9, dm-7, nvme0n7, dm-5, dm-14, nvme0n5, sr1, dm-3, dm-12, nvme0n3


"*****************************************************************88"

[ansible@x230 automation]$ cat templates/httpd.conf.j2
# This is the main Apache HTTP server configuration file.
#
# {{ ansible_managed }}
ServerRoot "/etc/httpd"
#
#Listen 12.34.56.78:80
Listen {{ http_port }}
# LoadModule foo_module modules/mod_foo.so
Include conf.modules.d/*.conf

User apache
Group apache

# 'Main' server configuration
ServerAdmin {{ admin }}@{{ ansible_hostname }}

<Directory />
    AllowOverride none
    Require all denied
</Directory>

DocumentRoot "{{ content_dir }}"
#
<Directory "{{ content_dir }}">
    AllowOverride None
    # Allow open access:
    Require all granted
</Directory>
# Further relax access to the default document root:
<Directory "{{ content_dir }}">
    #
    Options Indexes FollowSymLinks
    AllowOverride None
    # Controls who can get stuff from this server.
    Require all granted
</Directory>
# DirectoryIndex: sets the file that Apache will serve if a directory
<IfModule dir_module>
    DirectoryIndex index.html
</IfModule>
# The following lines prevent .htaccess and .htpasswd files from being
<Files ".ht*">
    Require all denied
</Files>
# ErrorLog: The location of the error log file.
ErrorLog "logs/error_log"
# LogLevel: Control the number of messages logged to the error_log.
LogLevel warn

<IfModule log_config_module>
    # The following directives define some format nicknames for use with
    LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
    LogFormat "%h %l %u %t \"%r\" %>s %b" common

    <IfModule logio_module>
      # You need to enable mod_logio.c to use %I and %O
      LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
    </IfModule>

    CustomLog "logs/access_log" combined
</IfModule>

<IfModule alias_module>
    ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"

</IfModule>
# "/var/www/cgi-bin" should be changed to whatever your ScriptAliased
# CGI directory exists, if you have that configured.
<Directory "/var/www/cgi-bin">
    AllowOverride None
    Options None
    Require all granted
</Directory>

<IfModule mime_module>
    # TypesConfig points to the file containing the list of mappings from
    # filename extension to MIME-type.
    TypesConfig /etc/mime.types

    # AddType allows you to add to or override the MIME configuration
    # file specified in TypesConfig for specific file types.
    AddType application/x-compress .Z
    AddType application/x-gzip .gz .tgz
    AddType text/html .shtml
    AddOutputFilter INCLUDES .shtml
</IfModule>

AddDefaultCharset UTF-8

<IfModule mime_magic_module>
    # The mod_mime_magic module allows the server to use various hints from the
    # contents of the file itself to determine its type.  The MIMEMagicFile
    MIMEMagicFile conf/magic
</IfModule>
# Defaults if commented: EnableMMAP On, EnableSendfile Off
#EnableMMAP off
EnableSendfile on
# Load config files in the "/etc/httpd/conf.d" directory, if any.
IncludeOptional conf.d/*.conf

[ansible@x230 automation]$ cat templates/index.html.j2
Welcome to {{ ansible_hostname }} refered to as {{ inventory_hostname }}

- The ipv4 address is {{ ansible_default_ipv4.address }}
- The current memory usage is {{ ansible_memory_mb['real']['used'] }}mb out of {{ ansible_memory_mb['real']['total'] }}mb
- The {{ ansible_devices|first }} Root Block Device has the following Partitions:

---
- name: Setup a Webserver on Node 3
  hosts: node3
  become: yes
  vars:
    content_dir: /webcontent
    http_port: 8080
    admin: rupert
  tasks:
    - name: create a folder with correct selinux contexts
      file:
        path: /webcontent
        state: directory
        owner: apache
        group: apache
        mode: 0644
    - name: selinux
      sefcontext:
        target: '/webcontent(/.*)?'
        state: present
        setype: httpd_sys_content_t
    - name: restorecon
      command: restorecon -irv /webcontent

    - name: copy template as conf file
      template:
        src: /home/ansible/automation/templates/httpd.conf.j2
        dest: /etc/httpd/conf/httpd.conf
        backup: yes
      notify: "restart apache"

    - name: edit firewall
      firewalld:
        port: 8080/tcp
        permanent: yes
        immediate: yes
        state: enabled
      notify: "restart firewall"

    - name: copy index.html
      template:
        src: /home/ansible/automation/templates/index.html.j2
        dest: /webcontent/index.html
        owner: apache
        group: apache

  handlers:
    - name: restart apache
      service:
        name: httpd
        state: restarted
        enabled: yes
      listen: "restart apache"
    - name: restart firewall
      service:
        name: firewalld
        state: restarted
      listen: "restart firewall"

"***************************************************************"
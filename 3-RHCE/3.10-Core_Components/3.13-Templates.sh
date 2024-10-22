
--------------------------------------------------------------------------


Synopsis
A Jinja template is simply a text file. Jinja can generate any text-based format (HTML, XML, CSV, LaTeX, etc.). A Jinja template doesn’t need to have a specific extension: .html, .xml, or any other extension is just fine.

A template contains variables and/or expressions, which get replaced with values when a template is rendered; and tags, which control the logic of the template. The template syntax is heavily inspired by Django and Python.

Below is a minimal template that illustrates a few basics using the default Jinja configuration. We will cover the details later in this document:

<!DOCTYPE html>
<html lang="en">
<head>
    <title>My Webpage</title>
</head>
<body>
    <ul id="navigation">
    {% for item in navigation %}
        <li><a href="{{ item.href }}">{{ item.caption }}</a></li>
    {% endfor %}
    </ul>

    <h1>My Webpage</h1>
    {{ a_variable }}

    {# a comment #}
</body>
</html>
The following example shows the default configuration settings. An application developer can change the syntax configuration from {% foo %} to <% foo %>, or something similar.

There are a few kinds of delimiters. The default Jinja delimiters are configured as follows:

{% ... %} for Statements

{{ ... }} for Expressions to print to the template output

{# ... #} for Comments not included in the template output

#  ... ## for Line Statements

--------------------------------------------------------------------------
Variables
# Template variables are defined by the context dictionary passed to the template.

# You can mess around with the variables in templates provided they are passed in by the application. Variables may have attributes or elements on them you can access too. What attributes a variable has depends heavily on the application providing that variable.

# You can use a dot (.) to access attributes of a variable in addition to the standard Python __getitem__ “subscript” syntax ([]).

The following lines do the same thing:

{{ foo.bar }}
{{ foo['bar'] }}
# It’s important to know that the outer double-curly braces are not part of the variable, but the print statement. If you access variables inside tags don’t put the braces around them.

# If a variable or attribute does not exist, you will get back an undefined value. What you can do with that kind of value depends on the application configuration: the default behavior is to evaluate to an empty string if printed or iterated over, and to fail for every other operation.

Implementation
# For the sake of convenience, foo.bar in Jinja2 does the following things on the Python layer:

# check for an attribute called bar on foo (getattr(foo, 'bar'))

# if there is not, check for an item 'bar' in foo (foo.__getitem__('bar'))

# if there is not, return an undefined object.

# foo['bar'] works mostly the same with a small difference in sequence:

# check for an item 'bar' in foo. (foo.__getitem__('bar'))

# if there is not, check for an attribute called bar on foo. (getattr(foo, 'bar'))

# if there is not, return an undefined object.

# This is important if an object has an item and attribute with the same name. Additionally, the attr() filter only looks up attributes.

Filters
# Variables can be modified by filters. Filters are separated from the variable by a pipe symbol (|) and may have optional arguments in parentheses. Multiple filters can be chained. The output of one filter is applied to the next.

# For example, {{ name|striptags|title }} will remove all HTML Tags from variable name and title-case the output (title(striptags(name))).

# Filters that accept arguments have parentheses around the arguments, just like a function call. For example: {{ listx|join(', ') }} will join a list with commas (str.join(', ', listx)).

# The List of Builtin Filters below describes all the builtin filters.

Tests
# Beside filters, there are also so-called “tests” available. Tests can be used to test a variable against a common expression. To test a variable or expression, you add is plus the name of the test after the variable. For example, to find out if a variable is defined, you can do name is defined, which will then return true or false depending on whether name is defined in the current template context.

# Tests can accept arguments, too. If the test only takes one argument, you can leave out the parentheses. For example, the following two expressions do the same thing:

{% if loop.index is divisibleby 3 %}
{% if loop.index is divisibleby(3) %}
The List of Builtin Tests below describes all the builtin tests.

Comments
# To comment-out part of a line in a template, use the comment syntax which is by default set to {# ... #}. This is useful to comment out parts of the template for debugging or to add information for other template designers or yourself:

{# note: commented-out template because we no longer use this
    {% for user in users %}
        ...
    {% endfor %}
#}


---------------------------List of Builtin Filters------------------------
abs()
float()
lower()
round()
tojson()
attr()
forceescape()
map()
safe()
trim()
batch()
format()
max()
select()
truncate()
capitalize()
groupby()
min()
selectattr()
unique()
center()
indent()
pprint()
slice()
upper()
default() <------------------
int()
random()
sort()
urlencode()
dictsort()
join() <-------------
reject()
string()
urlize()
escape()
last()
rejectattr()
striptags()
wordcount()
filesizeformat()
length()
replace() <--------------
sum()
wordwrap()
first()
list()
reverse()
title()
xmlattr()




--------------------[List of Builtin Tests()]-------------------------
callable() - even() - le() - none() - string() 
- defined() <----------------
ge() - lower() - number() 
- undefined()
divisibleby()
gt() #greater than
lt() # less than
odd()
upper()
eq() # equal
in() 
mapping()
sameas() <------------------------
escaped()
iterable()
ne()
sequence()

-----------callable(obj, /)
Return whether the object is callable (i.e., some kind of function).

Note that classes are callable, as are instances of classes with a __call__() method.

------------defined(value)
Return true if the variable is defined:

{% if variable is defined %}
    value of variable: {{ variable }}
{% else %}
    variable is not defined
{% endif %}


---------sameas(value, other)
Check if an object points to the same memory address than another object:

{% if foo.attribute is sameas false %}
    the foo attribute really is the `False` singleton
{% endif %}

------------------------Expression Statement------------------------
If the expression-statement extension is loaded, a tag called do is available that works exactly like the regular variable expression ({{ ... }}); except it doesn’t print anything. This can be used to modify lists:

{% do navigation.append('a string') %}


----------------------Loop Controls---------------------------------
If the application enables the Loop Controls, it’s possible to use break and continue in loops. When break is reached, the loop is terminated; if continue is reached, the processing is stopped and continues with the next iteration.

Here’s a loop that skips every second item:

{% for user in users %}
    {%- if loop.index is even %}{% continue %}{% endif %}
    ...
{% endfor %}
Likewise, a loop that stops processing after the 10th iteration:

{% for user in users %}
    {%- if loop.index >= 10 %}{% break %}{% endif %}
{%- endfor %}
CLOUD_LAB
# Encrypt home/ansible/secret using the ansible-vault command.
# Create /home/ansible/vault as a vault password file that may be used to access the encrypted secret file without prompt.
# Run the playbook /home/ansible/secPage.yml using your vault password file to validate your work.
# Verify that the secure page deployed correctly by attempting to access http://node1/secure/classified.html as the user bond with the password james.
---
- hosts: webservers
  become: yes
  vars_files:
    - /home/ansible/secret
  tasks:
  - name: install apache
    yum: name=httpd state=latest
  - name: configure httpd as necessary
    template:
      src: /home/ansible/assets/httpd.conf.j2
      dest: /etc/httpd/conf/httpd.conf
  - name: create secure directory
    file: state=directory path=/var/www/html/secure mode=0755
  - name: deploy htaccess file
    template:
      src: /home/ansible/assets/htaccess.j2
      dest: /var/www/html/secure/.htaccess
  - name: make sure passlib is installed for htpasswd module
    yum: name=python-passlib state=latest
  - name: create users for basic auth
    htpasswd:
      path: /var/www/html/secure/.passwdfile
      name: "{{ secure_user }}"
      password: "{{ secure_password }}"
      crypt_scheme: md5_crypt
  - name: start and enable apache
    service: name=httpd state=started enabled=yes
  - name: install secure files
    copy:
      src: /home/ansible/assets/classified.html
      dest: /var/www/html/secure/classified.html
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
Today is {{ ansible_date_time['date']['time']['tz'] }}

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
#     Options Indexes FollowSymLinks
#     AllowOverride None
#     # Controls who can get stuff from this server.
#     Require all granted
# </Directory>
# # DirectoryIndex: sets the file that Apache will serve if a directory
# <IfModule dir_module>
#     DirectoryIndex index.html
# </IfModule>
# # The following lines prevent .htaccess and .htpasswd files from being
# <Files ".ht*">
#     Require all denied
# </Files>
# # ErrorLog: The location of the error log file.
# ErrorLog "logs/error_log"
# # LogLevel: Control the number of messages logged to the error_log.
# LogLevel warn

# <IfModule log_config_module>
#     # The following directives define some format nicknames for use with
#     LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\"" combined
#     LogFormat "%h %l %u %t \"%r\" %>s %b" common

#     <IfModule logio_module>
#       # You need to enable mod_logio.c to use %I and %O
#       LogFormat "%h %l %u %t \"%r\" %>s %b \"%{Referer}i\" \"%{User-Agent}i\" %I %O" combinedio
#     </IfModule>

#     CustomLog "logs/access_log" combined
# </IfModule>

# <IfModule alias_module>
#     ScriptAlias /cgi-bin/ "/var/www/cgi-bin/"

# </IfModule>
# # "/var/www/cgi-bin" should be changed to whatever your ScriptAliased
# # CGI directory exists, if you have that configured.
# <Directory "/var/www/cgi-bin">
#     AllowOverride None
#     Options None
#     Require all granted
# </Directory>

# <IfModule mime_module>
#     # TypesConfig points to the file containing the list of mappings from
#     # filename extension to MIME-type.
#     TypesConfig /etc/mime.types

#     # AddType allows you to add to or override the MIME configuration
#     # file specified in TypesConfig for specific file types.
#     AddType application/x-compress .Z
#     AddType application/x-gzip .gz .tgz
#     AddType text/html .shtml
#     AddOutputFilter INCLUDES .shtml
# </IfModule>

# AddDefaultCharset UTF-8

# <IfModule mime_magic_module>
#     # The mod_mime_magic module allows the server to use various hints from the
#     # contents of the file itself to determine its type.  The MIMEMagicFile
#     MIMEMagicFile conf/magic
# </IfModule>
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
###############################################################################
{{ ansible_hostname }} is....
     ___      .__   __.      _______. __  .______    __       _______
    /   \     |  \ |  |     /       ||  | |   _  \  |  |     |   ____|
   /  ^  \    |   \|  |    |   (----`|  | |  |_)  | |  |     |  |__
  /  /_\  \   |  . `  |     \   \    |  | |   _  <  |  |     |   __|
 /  _____  \  |  |\   | .----)   |   |  | |  |_)  | |  `----.|  |____
/__/     \__\ |__| \__| |_______/    |__| |______/  |_______||_______|

.___  ___.      ___      .__   __.      ___       _______  _______  _______
|   \/   |     /   \     |  \ |  |     /   \     /  _____||   ____||       \
|  \  /  |    /  ^  \    |   \|  |    /  ^  \   |  |  __  |  |__   |  .--.  |
|  |\/|  |   /  /_\  \   |  . `  |   /  /_\  \  |  | |_ | |   __|  |  |  |  |
|  |  |  |  /  _____  \  |  |\   |  /  _____  \ |  |__| | |  |____ |  '--'  |
|__|  |__| /__/     \__\ |__| \__| /__/     \__\ \______| |_______||_______/


################################################################################
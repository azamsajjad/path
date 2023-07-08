9- Manage content
Create and use templates to create customized configuration files
Use Ansible Vault in playbooks to protect sensitive data


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
{{}}
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
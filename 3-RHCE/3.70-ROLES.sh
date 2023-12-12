3- Use roles and Ansible Content Collections
Create and work with roles
Install roles and use them in playbooks
Install Content Collections and use them in playbooks
Obtain a set of related roles, supplementary modules, and other content from content collections, and use them in a playbook.

ansible-galaxy install -r re.yml -p role/

for firewalld
$ansible-galaxy collection install ansible.posix

vim playbooks/roles_apache.yml
vim templates/roles_apache.j2
ansible-galaxy init /home/ansible/automation/roles/apache --offline

upload roles on Ansible-Galaxy from Git 
 814  sudo yum install -y git
  815  ansible-galaxy list
  816  pwd -> go to apache directory ~/automation/roles/apache(role) and then execute command.

  817  git init
  818  ls -alh
  819  git clone https://github.com/syedsajjad-rh/playbooks.git
  819  git remote add origin https://github.com/syedsajjad-rh/ansible-httpd.git
  820  git status
  821  git add .
  822  git status
  823  git config user.name syedsajjad-rh
  824  git config user.email syedsajjad.rh@gmail.com
  825  git commit -m "apache"
  826  git push origin master
        ->username?
        ->password? (new access token from developers menu in github)

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

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 roles
# new

git rm --cached -r PDFs/
git add .
git commit -m ""
git push

 pip install --upgrade ansible (if ansible module fails - accidental deletion)


clone your repo from remote server , then make changes and push back
git clone https://github.com/syedsajjad-rh/playbooks.git/ original

   89  git clone https://github.com/syedsajjad-rh/playbooks.git/ playbooks
   92  ll playbooks/
   93  git clone playbooks/ playbooksr/
   94  # clone repo from folder to folder
   95  cd playbooksr
   96  git status
   97  git add newfile.txt
   98  echo newfile > newfile.txt
   99  git status
  100  git add .
  101  git commit -m "nf"
  102  git config user.email syedsajjad.rh@gmail.com
  103  git config user.name syedsajjad-rh
  104  git commit -m "nf"
  105  git remote -v
  106  git status
  107  git push https://github.com/syedsajjad-rh/playbooks.git/
    username and password

"**********************************************************************************"
vim /etc/ansible/ansible.ini
[defaults]
interpreter_python = auto
host_key_checking = false
remote_user = rupert
ask_pass = false
roles_path = /home/ansible/automation/roles:/etc/ansible/roles
"***********************************************************************************"
#roles can be installed from a file
ansible-galaxy install -r file.yml
ansible-galaxy collection install hypersql_devops.postgres
ansible-galaxy list
ansible-galaxy install geerlingguy.postgresql
ansible-galaxy info geerlingguy.postgresql
ansible-galaxy remove geerlingguy.postgresql



pre_tasks: (out of scope)
tasks:
YOU CAN INCLUDE OTHER PLAYBOOKS IN A PLAYBOOK
tasks:
  - include: folder/packages.yml
this file should have only the task, not everything




role.yml
---
- name: for apachej2 role
  hosts: node2
  become: yes
  tasks:
    - include_role:
        name: apachej2
      vars:
        http_port: 80

- name: for apachej2 role
  hosts: node2
  become: yes
  roles:
      - apachej2

---
# defaults file for apachej2
content_dir: /website
http_port: 8080
admin: rupert

---
# tasks file for apachej2
- name: create a directory to serve content
  file:
    path: "{{ content_dir }}"
    state: directory
    owner: root
    group: apache
    mode: 0755
- name: secontext
  sefcontext:
    target: "{{ content_dir }}(/.*)?"
    setype: httpd_sys_content_t
    state: present
- name: restorecon
  command: restorecon -irv {{ content_dir }}
- name: copy template file
  template:
    src: httpd.conf.j2
    dest: /etc/httpd/conf/httpd.conf
    backup: yes
- name: copy index.html
  template:
    src: index.html.j2
    dest: "{{ content_dir }}/index.html"
    owner: apache
    group: apache
    mode: 0600
  tags: index
- name: open firewall rule
  firewalld:
    port: "{{ http_port }}/tcp"
    state: enabled
    immediate: yes
    permanent: yes
  notify: "restart firewall"
~
                  #index.html.j2
                  Welcome to {{ ansible_hostname }} refered to as {{ inventory_hostname }}

                  - The ipv4 address is {{ ansible_default_ipv4.address }}
                  - The current memory usage is {{ ansible_memory_mb['real']['used'] }}mb out of {{ ansible_memory_mb['real']['total'] }}mb
                  - On 4th-Reich Network, This Website is hosted on {{ ansible_nodename }} Running {{ ansible_os_family }}
                  - System is {{ ansible_processor[2] }}

#httpd.conf.j2
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
"****************************************************************************************"

---
# tasks file for /home/ansible/automation/roles/apache
- import_tasks: install.yml
- import_tasks: service.yml
- import_tasks: config.yml
~
"****************************************************************************************"
You can enable dependencies for your role by listing them in meta/main.yml
ansible-galaxy will first download and run all dependent roles t, then the role targeted will be run
galaxy_info:
  author: your name
  description: your role description
  company: your company (optional)

  # If the issue tracker for your role is not on github, uncomment the
  # next line and provide a value
  # issue_tracker_url: http://example.com/issue/tracker

  # Choose a valid license ID from https://spdx.org - some suggested licenses:
  # - BSD-3-Clause (default)
  # - MIT
  # - GPL-2.0-or-later
  # - GPL-3.0-only
  # - Apache-2.0
  # - CC-BY-4.0
  license: license (GPL-2.0-or-later, MIT, etc)

  min_ansible_version: 2.1

  # If this a Container Enabled role, provide the minimum Ansible Container version.
  # min_ansible_container_version:

  #
  # Provide a list of supported platforms, and for each platform a list of versions.
  # If you don't wish to enumerate all versions for a particular platform, use 'all'.
  # To view available platforms and versions (or releases), visit:
  # https://galaxy.ansible.com/api/v1/platforms/
  #
  # platforms:
  # - name: Fedora
  #   versions:
  #   - all
  #   - 25
  # - name: SomePlatform
  #   versions:
  #   - all
  #   - 1.0
  #   - 7
  #   - 99.99

  galaxy_tags: []
    # List tags for your role here, one per line. A tag is a keyword that describes
    # and categorizes the role. Users find roles by searching for tags. Be sure to
    # remove the '[]' above, if you add tags to this list.
    #
    # NOTE: A tag is limited to a single word comprised of alphanumeric characters.
    #       Maximum 20 tags per role.
allow_duplicate: true
# you can mention it so a role wont apply to same server more than once, if it makes sense. prevent a role to be applied more than once on a specified host
dependencies: []
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list.

  or


  dependencies:
  - role1
  - role2
  - role3
  # List your role dependencies here, one per line. Be sure to remove the '[]' above,
  # if you add dependencies to this list.
~

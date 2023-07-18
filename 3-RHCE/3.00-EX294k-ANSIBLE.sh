
Study points for the exam
As an RHCE exam candidate, you should be able to handle all responsibilities expected of a Red Hat Certified System Administrator, including these tasks:

Be able to perform all tasks expected of a Red Hat Certified System Administrator

1- Understand and use essential tools
Operate running systems
Configure local storage
Create and configure file systems
Deploy, configure, and maintain systems
Manage users and groups
Manage security

2- Understand core components of Ansible:
Inventories - "session 3"
Modules - "session 4,5,6,7"
Variables - "session 8,9,10,12"
Facts - "session 11"
Loops - "session 14,15,16"
Conditional tasks - "session 17"
Plays
Handling task failure - "session 19"
Playbooks 
Configuration files
Roles "session 22"
Use provided documentation to look up specific information about Ansible modules and commands

3- Use roles and Ansible Content Collections "session 22"
Create and work with roles
Install roles and use them in playbooks
Install Content Collections and use them in playbooks
Obtain a set of related roles, supplementary modules, and other content from content collections, and use them in a playbook.

4- Install and configure an Ansible control node
Install required packages
Create a static host inventory file
Create a configuration file
Create and use static inventories to define groups of hosts

5- Configure Ansible managed nodes
Create and distribute SSH keys to managed nodes
Configure privilege escalation on managed nodes
Deploy files to managed nodes
Be able to analyze simple shell scripts and convert them to playbooks

6- Run playbooks with Automation content navigator
Know how to run playbooks with Automation content navigator
Use Automation content navigator to find new modules in available Ansible Content Collections and use them
Use Automation content navigator to create inventories and configure the Ansible environment

7- Create Ansible plays and playbooks:
Know how to work with commonly used Ansible modules
Use variables to retrieve the results of running a command
Use conditionals to control play execution
Configure error handling
Create playbooks to configure systems to a specified state

8- Automate standard RHCSA tasks using Ansible modules that work with:
Software packages and repositories
Services
Firewall rules
File systems
Storage devices
File content
Archiving
Task scheduling
Security
Users and groups

9- Manage content
Create and use templates to create customized configuration files
Use Ansible Vault in playbooks to protect sensitive data - "session 13"

vmware workstation pro license key
4A4RR-813DK-M81A9-4U35H-06KND
NZ4RR-FTK5H-H81C1-Q30QH-1V2LA
JU090-6039P-08409-8J0QH-2YR7F
4Y09U-AJK97-089Z0-A3054-83KLA
4C21U-2KK9Q-M8130-4V2QH-CF810

"************************************************************************"
These are the twelve tasks you'll need to complete in order to prepare for the exam:

Set up an Ansible inventory.
Set up SSH keys.
Set up sudoers.
Write a playbook to install httpd only on WebServer1. Make sure the service is started and enabled.
Use an ad-hoc command to install tcpdump on AdminServer1
Use the LVM module in a playbook to set up the disk attached to DBServer1 (/dev/xvdg), then make sure it's formatted with XFS and mounted persistently on /mnt/dbdata. The disk's size should be 10G.
Create the users adam, john, sara, and sam on all servers.
Write a Bash script that queries each server for its Ansible facts, and outputs that information to a file in /tmp; there should be one file for each server name.
Using the ssh.tmpl sample file in /root on the Ansible Host to write a template and playbook that will deploy the file on all hosts in the environment. It should turn off Password Authentication on all servers, and ensure X11 forwarding is on for administrative servers only.
Create two custom roles: web and database.
In the database role, create a password file that will be copied into the dba user's home directory. Encrypt the file. Ensure the database role is deployed correctly.
For the web role, ensure that /var/www/html/index.html contains the Ansible hostname of the server and all IP addresses connected to that server. Ensure that httpd is running and enabled, and that the role deploys correctly.


Write a Bash Script That Will Collect the Required Ansible Information
We want to get each host's Ansible facts and dump the information into respective text files. So you've got to write a script, facts.sh, that will query each one and put its relevant info into a text file. The script should look something like the following:

#!/bin/bash
for i in webserver1 dbserver1 adminserver1
do
        ansible -m setup $i > /tmp/$i\_facts
done

Using the ssh.tmpl sample file in /root on the Ansible Host to write a template and playbook that will deploy the file on all hosts in the environment. It should turn off Password Authentication on all servers, and ensure X11 forwarding is on for administrative servers only.

---
- name: review task 9
  hosts: all:!admin
  become: yes
  vars:
    - pa_ans: "no"
      x11_ans: "no"
  tasks:
    - name: copy template
      template:
        src: /root/ssh.j2
        dest: /etc/ssh/sshd_config
        owner: root
        group: root
        mode: 0600
        validate: usr/sbin/sshd -t -f %s

    - name: restart sshd
      service:
        name: sshd
        state: restarted

- hosts: admin
  become: true
  vars:
    - pa_ans: "no"
    - x11_ans: "yes"
  tasks:
    - name: copy template
      template:
        src: /root/ssh.j2
        dest: /etc/ssh/sshd_config
        owner: root
        group: root
        mode: 0600
        validate: usr/sbin/sshd -t -f %s    <-------------------------no /usr becaus root

    - name: restart sshd
      service:
        name: sshd
        state: restarted


"***************************************"
Version: 5.0
Question: 1
Install and configure ansible
User bob has been created on your control node. Give him the appropriate permissions on the control
node. Install the necessary packages to run ansible on the control node.
Create a configuration file /home/bob/ansible/ansible.cfg to meet the following requirements:
• The roles path should include /home/bob/ansible/roles, as well as any other path that may be
required for the course of the sample exam.
• The inventory file path is /home/bob/ansible/inventory.
• Ansible should be able to manage 10 hosts at a single time.
• Ansible should connect to all managed nodes using the bob user.
Create an inventory file for the following five nodes:
nodel.example.com
node2.example.com
node3.example.com
node4.example.com
node5.example.com
Configure these nodes to be in an inventory file where node1 is a member of group dev. nodc2 is a
member of group test, nodc3 is a member of group proxy, nodc4 and node 5 are members of group prod.
Also, prod is a member of group webservers.
Answer: See the
Explanation for
complete Solution
below.
Explanation:
In/home/sandy/ansible/ansible.cfg
[defaults]
inventory=/home/sandy/ansible/inventory
roles_path=/home/sandy/ansible/roles
remote_user= sandy
host_key_checking=false
[privilegeescalation]
become=true
become_user=root
Questions & Answers PDF Page 3
become_method=sudo
become_ask_pass=false
In /home/sandy/ansible/inventory
[dev]
node 1 .example.com
[test]
node2.example.com
[proxy]
node3 .example.com
[prod]
node4.example.com
node5 .example.com
[webservers:children]
prod
Question: 2
Create a file called adhoc.sh in /home/sandy/ansible which will use adhoc commands to set up a new
repository. The name of the repo will be 'EPEL' the description 'RHEL8' the baseurl is
'https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rmp' there is no gpgcheck, but you
should enable the repo.
* You should be able to use an bash script using adhoc commands to enable repos. Depending on your
lab setup, you may need to make this repo "state=absent" after you pass this task.
Answer: See the
Explanation for
complete Solution
below.
Explanation:
chmod 0777 adhoc.sh
vim adhoc.sh
#I/bin/bash
Questions & Answers PDF Page 4
ansible all -m yum_repository -a 'name=EPEL description=RHEL8
baseurl=https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rmp
gpgcheck=no enabled=yes'
Question: 3
Create a file called packages.yml in /home/sandy/ansible to install some packages for the following
hosts. On dev, prod and webservers install packages httpd, mod_ssl, and mariadb. On dev only install the
development tools package. Also, on dev host update all the packages to the latest.
Answer: See the
Explanation for
complete Solution
below.
Explanation:
Solution as:
** NOTE 1 a more acceptable answer is likely 'present' since it's not asking to install the latest
state: present
** NOTE 2 need to update the development node
- name: update all packages on development node
yum:
name: '*'
state: latest
Question: 4
Questions & Answers PDF Page 5
Create a role called sample-apache in /home/sandy/ansible/roles that enables and starts httpd, enables
and starts the firewall and allows the webserver service. Create a template called index.html.j2 which
creates and serves a message from /var/www/html/index.html Whenever the content of the file
changes, restart the webserver service.
Welcome to [FQDN] on [IP]
Replace the FQDN with the fully qualified domain name and IP with the ip address of the node using
ansible facts. Lastly, create a playbook in /home/sandy/ansible/ called apache.yml and use the role to
serve the index file on webserver hosts.
Answer: See the
Explanation for
complete Solution
below.
Explanation:
/home/sandy/ansible/apache.yml
/home/sandy/ansible/roles/sample-apache/tasks/main.yml
Questions & Answers PDF Page 6
/home/sandy/ansible/roles/sample-apache/templates/index.html.j2
In /home/sandy/ansible/roles/sample-apache/handlers/main.yml
Questions & Answers PDF Page 7
Question: 5
Create a file called requirements.yml in /home/sandy/ansible/roles to install two roles. The source for
the first role is geerlingguy.haproxy and geerlingguy.php. Name the first haproxy-role and the second
php-role. The roles should be installed in /home/sandy/ansible/roles.
Answer: See the
Explanation for
complete Solution
below.
Explanation:
in /home/sandy/ansible/roles
vim requirements.yml
Run the requirements file from the roles directory:
ansible-galaxy install -r requirements.yml -p /home/sandy/ansible/roles





"*************************************************************************"

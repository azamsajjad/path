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
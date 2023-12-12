4- Install and configure an Ansible control node
Install required packages
Create a static host inventory file
Create a configuration file
Create and use static inventories to define groups of hosts

"*************************************************************"
when installing ansible on a control node - (DO the following 3 steps if NEEDED)
yum search ansible 
subscription manager repos --list | grep ansible
subscription-manager repos --enable ansible-2.8....
yum install -y ansible 

ssh 102
INSTALL ANSIBLE FROM SOURCE - GITHUB
yum install git
mkdir git && cd git 
git clone --single-branch --branch stable-2.15 https://github.com/ansible/ansible.git
echp $PATH
--> /home/rupert/.local/bin:/home/rupert/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
[rupert@server2 ansible]$ source ./hacking/env-setup
[rupert@server2 ansible]$ echo $PATH
--> /home/rupert/git/ansible/bin:/home/rupert/.local/bin:/home/rupert/bin:/usr/local/bin:/usr/bin:/usr/local/sbin:/usr/sbin
to make it persistent, add it in .bash_profile
so it loads up ansible env variables when you log in

install dpeendencies
sudo yum install pip
pip install --user -r ~/git/ansible/requirements.txt

"*************************************************************"
"STATIC INVENTORY"
see 2.2a-Inventory.yml

"*************************************************************"
"CREATE ansible.cfg file"
cp ~/git/ansible/examples/ansible.cfg /etc/ansible/ansible.cfg 
cp ~/git/ansible/examples/hosts /etc/ansible/host
to create commented config file from scratch
$ ansible-config init --disable > ansible.cfg 
$ ansible-config list  

~/ansible/ansible.cfg
[defaults]

interpreter_python = auto
inventory = /home/rupert/ansible/inventory/inv.ini
roles = /etc/ansible/roles:/home/rupert/ansible/roles

#ORDER OF PREFERENCE FOR ansible.cfg
ANSIBLE_CONFIG
ansible.cfg (working dir)
ansible.cfg (user homedir)
ansible.cfg (/etc/ansible/ansible.cfg) 

"*************************************************************"
"DYNAMIC INVENTORY"
boto is AWS sdk for python
boto enables easy-to-use object-oriented APIs 
boto is low access to aws services
ansible aws modules are written on top of boto3

"AWS SETUP"
yum install ansible-core python-pip python-devel
pip install --upgrade ansible
pip install boto
pip install boto3
ansible-galaxy collection install amazon.aws
ec2.py ec2.ini (need these 2 files for aws initialization)
git clone https://github.com/ansible22/aws.git
                Cloning into 'aws'...
                remote: Enumerating objects: 4, done.
                remote: Counting objects: 100% (4/4), done.
                remote: Compressing objects: 100% (4/4), done.
                remote: Total 4 (delta 0), reused 0 (delta 0), pack-reused 0
                Receiving objects: 100% (4/4), 17.42 KiB | 163.00 KiB/s, done.
                [ansible@x230 ~]$ ll
                total 12
                drwxr-xr-x. 5 ansible ansible 4096 Jun 24 15:10 automation
                drwxr-xr-x. 3 ansible ansible   47 Jun 25 13:50 aws
                drwxr-xr-x. 4 ansible ansible   52 Jun 18 16:09 backup
                -rw-r--r--. 1 ansible ansible   21 Jun 18 13:56 copythisfileintmp.txt
                -rw-r--r--. 1 ansible ansible    0 Jun 18 23:05 Nehraclasses.txt
                -rw-r--r--. 1 ansible ansible   31 Jun 18 15:36 shell.sh

chmod +x ec2.*
vim ec2.py 
: set nu (to see line numbers)
line 37 -> #
line 64 -> elasticache should be false

vim ec2.ini
line 217 , 218 paste aws_access_keys

sudo vim /etc/ansible/ansible.cfg
[defaults]
inventory = /home/ansible/aws/ec2.py

./ec2.py 
ansible all --list-hosts 
[ansible@x230 aws]$ ansible all --list-hosts
[WARNING]: Invalid characters were found in group names but not replaced, use -vvvv to see details
  hosts (2):
    52.207.214.10
    44.208.34.168
[ansible@x230 aws]$


COPY ansible_key.pem to aws folder TO ACCESS INSTANCe

add more configuration to ansible.cfg file
[defaults]
inventory = /home/ansible/aws/ec2.py
remote_user = rupert
ask_pass = false
private_key_file = /home/ansible/aws/ansible-key-pair.pem

[privilege_escalation]
become = true
become_method = sudo
become_user = root
become_ask_pass = false

ansible all -m ping 

"*************************************************************"
"MANAGING GROUPS IN DYNAMIC INVENTORY"
ec2.py is a script file 
ec2.ini is the config file for ec2.py and can be used to limit the scope of Ansible's reach
You can specify regions, instance tags, roles that ec2.py script will find. 
use TAGS in instances menu to assign group
tag key value pair
group      web


ansible-inventory graph
./ec2.py

- name:
  hosts: tag_group_web
  hostS: tag_group2_dev
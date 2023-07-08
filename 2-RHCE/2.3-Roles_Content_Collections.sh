3- Use roles and Ansible Content Collections
Create and work with roles
Install roles and use them in playbooks
Install Content Collections and use them in playbooks
Obtain a set of related roles, supplementary modules, and other content from content collections, and use them in a playbook.

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
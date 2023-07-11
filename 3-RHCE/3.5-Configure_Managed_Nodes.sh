5- Configure Ansible managed nodes
Create and distribute SSH keys to managed nodes
Configure privilege escalation on managed nodes
Deploy files to managed nodes
Be able to analyze simple shell scripts and convert them to playbooks

[ANSIBLE SETUP]
1053  useradd ansible
 1054  echo "Altreason1" | passwd --stdin ansible
 1055  echo "ansible ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/ansible
 1056  su - ansible
  5  ssh-keygen
    6  ssh-copy-id rupert@192.168.100.101
    7  ssh rupert@192.168.100.101
    8  ssh-copy-id rupert@192.168.100.102
    9  ssh rupert@192.168.100.102
echo "rupert ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/rupert
echo "rupert ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/rupert

vim ~/automation/ansible.cfg (check configuration)
    [defaults]
    inventory = ./inventory
    host_key_checking = false
    remote_user = rupert
    ask_pass = false

    [privilege_escalation]
    become=true
    become_method=sudo
    become_user=root
    become_ask_pass=False
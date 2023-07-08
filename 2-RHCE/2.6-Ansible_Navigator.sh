6- Run playbooks with Automation content navigator
Know how to run playbooks with Automation content navigator
Use Automation content navigator to find new modules in available Ansible Content Collections and use them
Use Automation content navigator to create inventories and configure the Ansible environment

"Ansible Navigator supports execution environments, which are containerized environments that isolate Ansible execution.
This ensures consistent environment for running playbooks and reduces the risk of conflicts between dependencies.
Features:"
interactive look, Containerized Environment
enhances discoverability of Ansible content
simplifies usage of execution environments
all within Ansible Navigator TUI




Install ansible-navigator¶
Install the python package manager using the system package installer (e.g.):
[sudo dnf install python3-pip ansible-core podman]
Install ansible-navigator:
[python3 -m pip install ansible-navigator --user]
Add the installation path to the user shell initialization file (e.g.):
[ansible@x230 ~]$ echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.profile
[ansible@x230 ~]$ source ~/.profile
"*************************************************************"
[ansible@x230 navigator]$ cat /etc/ansible/ansible.cfg
[defaults]
host_key_checking = false
remote_user = rupert
ask_pass = false
"*************************************************************"
[ansible@x230 navigator]$ cat inventory
[RHEL]
node1
node2
(already defined in /etc/ansible/hosts. but navigator picks this file in ansible directory)
"**************************************************************"
[ansible@x230 navigator]$ cat ansible-navigator.yml
---
ansible-navigator:
  ansible:
    inventory:
      entries:
        - inventory
  execution-environment:
    container-engine: podman
    enabled: false
    image: ghcr.io/ansible/creator-ee:v0.18.0
  logging:
    level: debug
  playbook-artifact:
    enable: true
    save-as: playbook-artifacts/{playbook_name}-artifact-{time_stamp}.json
"***************************************************************"
[ansible@x230 navigator]$ ansible-navigator
[ansible@x230 navigator]$ ansible-navigator run ping.yml
[ansible@x230 navigator]$ ansible-navigator run ping.yml -i /etc/ansible/hosts --eei ansible-navigator-demo-ee
run a playbook with different inventry file and different execution environment

to replay a playbook or see how it ran, we use artifacts
[ansible@x230 navigator]$ ansible-navigator replay playbook-artifacts/ping-artifact-2023-06-26T11\:13\:06.806694+00\:00.json
[ansible@x230 navigator]$ ansible-navigator collections

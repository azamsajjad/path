 1010  ansible-galaxy collection init local.colors
 1011  ll
 1012  tree
 1013  ansible --version
 1019  ansible-playbook main.yml -i "localhost," -c local
 1020  ll
 1021  cd ..
 1022  ansible-galaxy collection install -r collections/requirements.yml

requirements.yml
---
collections:
  - name: kubernetes.core
    version: 2.4.0
    
 1047  ansible-galaxy collection list
 1048  ansible-galaxy role list

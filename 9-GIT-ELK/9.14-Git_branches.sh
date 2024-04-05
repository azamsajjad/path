git diff
shows difference between old committed file and modified file

Workflow - from Ansible branch
  795  git checkout -b 05042024
  797  vim README.md
  799  git add README.md
  800  git commit -m "05042024"
  801  git checkout ansible
  802  vim README.md 
  805  git merge 05042024
  806  git branch -d 05042024
  810  git push -u origin ansible
  811  eval "`ssh-agent -s`"
  812  ssh-add ~/.ssh/id_ed25519_git_azam_sajjad
  813  git push -u origin ansible



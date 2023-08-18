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
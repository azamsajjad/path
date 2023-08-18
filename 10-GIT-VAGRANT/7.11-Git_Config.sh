git config --global user.email syedsajjad.rh@gmail.com (for a user and all his repos)
git config --local user.email syedsajjad.rh@gmail.com (for a repo directory)

[ansible@x230 ~]$ cat ~/.gitconfig
[user]
        email = syedsajjad.rh@gmail.com
        name = syed sajjad


[ansible@x230 playbooks]$ git config --list
user.email=syedsajjad.rh@gmail.com
user.name=syed sajjad
core.repositoryformatversion=0
core.filemode=true
core.bare=false
core.logallrefupdates=true
remote.origin.url=https://github.com/syedsajjad-rh/playbooks.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
user.email=syedsajjad.rh@gmail.com
user.name=syed sajjad
(but doesnt tell which setting is global and which is userspace)


[ansible@x230 automation]$ sudo git config --system color.diff auto


[ansible@x230 automation]$ git config --list --show-origin
file:/etc/gitconfig     color.diff=auto
file:/home/ansible/.gitconfig   user.email=syedsajjad.rh@gmail.com
file:/home/ansible/.gitconfig   user.name=syed sajjad


[ansible@x230 playbooks]$ git config --list --show-origin
file:/etc/gitconfig     color.diff=auto
file:/home/ansible/.gitconfig   user.email=syedsajjad.rh@gmail.com
file:/home/ansible/.gitconfig   user.name=syed sajjad
file:.git/config        core.repositoryformatversion=0
file:.git/config        core.filemode=true
file:.git/config        core.bare=false
file:.git/config        core.logallrefupdates=true
file:.git/config        remote.origin.url=https://github.com/syedsajjad-rh/playbooks.git
file:.git/config        remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
file:.git/config        branch.master.remote=origin
file:.git/config        branch.master.merge=refs/heads/master
file:.git/config        user.email=syedsajjad.rh@gmail.com
file:.git/config        user.name=syed sajjad

System file is read first, then user, then local
for duplicate settings, whichever is listed last on the list, wins

git remote set-url origin https://github.com/syedsajjad-rh/ansible_playbooks.git

GIT SAVE PASSWORD
git config --global credential.helper store

[*************************************************************************]
ERROR 


PS D:\devops> git push
fatal: the remote end hung up unexpectedly
send-pack: unexpected disconnect while reading sideband packet
fatal: the remote end hung up unexpectedly
error: failed to push some refs to 'https://github.com/syedsajjad-rh/devops.git'

git config --global core.compression 0
git clone --depth 1 <repo_URI>
# cd to your newly created directory
git fetch --unshallow 
git pull --all


git remote -v
git reset --hard
git fetch --refetch


Solution:. cloned from remote. copied its .gti file into folder. then git add .
git commit
then push

[*************************************************************************]

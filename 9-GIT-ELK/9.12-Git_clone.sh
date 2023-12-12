<<<<<<< HEAD
DISTRIBUTED VERSION CONTROL 
git clone https...... (from remote to local machine)
git show-ref main
    b2a33a898e77e9d75f1675ffa75abc5720d21ec1 refs/heads/master
    e041b9d86ba2cfb3e8f8a6caff9f5fe1efaa24de refs/remotes/origin/master
git push


# TO AVOID CONFLICTS WORKING ON A PROJECT, 
WHEN YOU LOCALLY MAKE CHANGES AND ARE READY TO push
FIRST PULL, THEN MERGE, THEN PUSH


NEVER REBASE SHARED COMMITs

2 MOST IMP FEATURE OF MODERN SOFTWARE DEVELOPMENT ON github
FORK & = fork a copy of the ORIGINAL CONTENT TO YOUR OWN ACCOUNT IN GITHUB, THEN CLONE IT LOCALLY , COMMIT AND PUSH CHANGES TO ORIGINAL(your account)

PULL REQUEST - when you want the original software to commit your modification on your github account, you send PULL REQUEST, they will review it, and if they like, they will pull it from your fork
=======
DISTRIBUTED VERSION CONTROL 
git clone https...... (from remote to local machine)
git show-ref main
    b2a33a898e77e9d75f1675ffa75abc5720d21ec1 refs/heads/master
    e041b9d86ba2cfb3e8f8a6caff9f5fe1efaa24de refs/remotes/origin/master
git push


# TO AVOID CONFLICTS WORKING ON A PROJECT, 
WHEN YOU LOCALLY MAKE CHANGES AND ARE READY TO push
FIRST PULL, THEN MERGE, THEN PUSH


NEVER REBASE SHARED COMMITs

2 MOST IMP FEATURE OF MODERN SOFTWARE DEVELOPMENT ON github
FORK & = fork a copy of the ORIGINAL CONTENT TO YOUR OWN ACCOUNT IN GITHUB, THEN CLONE IT LOCALLY , COMMIT AND PUSH CHANGES TO ORIGINAL(your account)

PULL REQUEST - when you want the original software to commit your modification on your github account, you send PULL REQUEST, they will review it, and if they like, they will pull it from your fork

90  git clone https://github.com/azamsajjad/devops.git
   91  ssh-keygen -t ed25519 -C "azam@gmail.com"
   93  cat ../.ssh/id_ed25519.pub 
   94  cd k8/pods/
   95  ssh -T git@github.com
   96  eval "$(ssh-agent -s)"
   97  ssh-add ~/.ssh/id_ed25519
   98  cd ../..
   99  git clone git@github.com:azamsajjad/devops.git
   
   add ssh url to .git/config
>>>>>>> origin

REVERT to PREVIOUS COMMIT
git log
git reset --hard 96f9d26d51259955a7eed7743219ae182814360c && git clean -f 
git push -u origin main -f


 
277  echo "Apple Pie" | git hash-object --stdin -w
  278  cd .git
  279  ll
  280  cd objects/
  281  ll
  282  cd ..
  283  cd objects/23/
  284  ll
  285  cd ..
  286  git cat-file 23991897e13e47ed0adb91a0082c31c82fe0cbe5 -t
  287  git cat-file 23991897e13e47ed0adb91a0082c31c82fe0cbe5 -p
  288  git log
  289  cd ..
  290  git commit
  291  git add .
  292  git commit -m "lvm"
  293  git log
  294  git cat-fil -p 62ba7874b966e46d3a37fef0a3f3a8bd3157e4be
  295  git cat-file -p 62ba7874b966e46d3a37fef0a3f3a8bd3157e4be
  296  git count-objects
  297  git branch
  298  git branch ideas
  299  git branch
  300  cat .git/HEAD
  301  git switch ideas
  302  git switch master
  303  vim play.yml
  304  git commit -m "main"
  305  git add .
  306  git commit -m "main"
  307  ll
  308  git switch ideas
  309  ll
  310  vim play.yml
  311  git add .
  312  git commit -m "ideas"
  313  git branch
  314  git merge master
  315  cat play.yml
  316  git switch master
  317  git merge --quit
  318  git switch master
  319  git branch
  320  git add .
  321  git commit
  322  git commit -m "idead"
  323  git switch master
  324  git switch ideas
  325  git merge master
  326  vim play.yml
  327  git add .
  328  git commit
  329  git log
  330  git cat-file -p 53922e8a74a3557980ef959792aa1a214321e0f0
  331  git switch master
  332  cat play.yml
  333  switch branch ideas
  334  git switch branch ideas
  335  git switch ideas
  336  cat play.yml
  337  git switch master
  338  git merge ideas
  339  git log

git rm --cached testfile
git status -> "Untracked" = testfile
git remote -v

  DETACH HEAD
  340  cat .git/HEAD
  341  git checkout 53922e8a74a3557980ef959792aa1a214321e0f0
  342  cat .git/HEAD
  343  git log
  344  vim play.yml
  345  git add .
  346  git commit -m "detach"
  347  git log
  348  git switch master <-----return back to master. dont run forward
  349  git log
  350  vim play.yml

[ansible@x230 playbooksr]$ git commit -m "detach"
[detached HEAD a5e7bfc] detach
 1 file changed, 1 insertion(+)
[ansible@x230 playbooksr]$ git log
commit a5e7bfc6913185d9235602646c18cc6fea6ef5e7 (HEAD)
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 14:56:45 2023 +0500

    detach

commit 53922e8a74a3557980ef959792aa1a214321e0f0 (master, ideas)
Merge: 2a51757 eed1f36
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 13:15:46 2023 +0500

    Merge branch 'master' into ideas

commit 2a51757b1be1e970f78ca7b76198371e481e9974
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 13:13:03 2023 +0500

    idead

    playbooks
[ansible@x230 playbooksr]$ git switch master
Warning: you are leaving 1 commit behind, not connected to
any of your branches:

  a5e7bfc detach  <-----------------------------you can still go back to forward commits if you have this hash   git checkout #hash ---> the nmake it a branch so it gets saved . git branch nogood

If you want to keep it by creating a new branch, this may be a good time
to do so with:

 git branch <new-branch-name> a5e7bfc

Switched to branch 'master'
Your branch is ahead of 'origin/master' by 6 commits.
  (use "git push" to publish your local commits)
[ansible@x230 playbooksr]$ git log
commit 53922e8a74a3557980ef959792aa1a214321e0f0 (HEAD -> master, ideas)
Merge: 2a51757 eed1f36
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 13:15:46 2023 +0500

    Merge branch 'master' into ideas

commit 2a51757b1be1e970f78ca7b76198371e481e9974
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 13:13:03 2023 +0500

    idead

commit 66569b548a1a39197334ff2aca656a5ed445aa01
Author: syedsajjad-rh <syedsajjad.rh@gmail.com>
Date:   Fri Jul 14 12:41:53 2023 +0500

    ideas



4 object types
blobs
trees
commits 
tags



tags:\ a tag is like a branch that doesnt move
annotated tags -> git tag release_1 -a -m "first release, its unstable"
    git tag
    git checkout release_1
    cat .git/refs/tags/release_1
    git cat-file -t tag#hash
    git cat-file -p tag#hash
    #annotated tag is just like a branch, its a ref to database object with a message, and that database object point to current commit
    
lightweight tags - hash same as current commit - point of reference (simple label)
git tag dinner
same hash as that of last commit



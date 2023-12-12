git rm --cached testfile
git status -> "Untracked" = testfile


[ansible@x230 roles]$ ls -alh
total 0
drwxr-xr-x.  4 ansible ansible  38 Jul 16 00:48 .
drwxr-xr-x.  6 ansible ansible  65 Jul 15 01:56 ..
drwxr-xr-x. 10 ansible ansible 151 Jul 16 02:17 apache_httpd
drwxr-xr-x.  8 ansible ansible 166 Jul 16 02:27 .git
[ansible@x230 roles]$ cd .git/
branches/ hooks/    info/     logs/     objects/  refs/
[ansible@x230 roles]$ cd .git/info/
[ansible@x230 info]$ ll
total 4
-rw-r--r--. 1 ansible ansible 240 Jul 16 00:46 exclude
[ansible@x230 info]$ cat exclude
# git ls-files --others --exclude-from=.git/info/exclude
# Lines that start with '#' are comments.
# For a project mostly in C, the following would be a good set of
# exclude patterns (uncomment them if you want to use them):
# *.[oa]
# *~
testfile
.pdf
[ansible@x230 info]$


or create a .gitignore file on the working folder
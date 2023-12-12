2-Create simple shell scripts
Conditionally execute code (use of: if, test, [], etc.)
Use Looping constructs (for, etc.) to process file, command line input
Process script inputs ($1, $2, etc.)
Processing output of shell commands within a script



$script terminal.txt
starts terminal recording, ctrl+D to exit

while true ; do clear ; df -h ; sleep 5 ; done

    #!/bin/bash

    # script to add users
    # takes input file with usernames

    # user name file
USERFILE=$1

if [ "$USERFILE" = "" ]
then
        echo "Please specify an input file!"
        exit 10

elif test -e $USERFILE
then
        for user in `cat $USERFILE`
        do
        echo "Creating the "$user" user..."
                useradd -m $user
        done
        exit 20
else
        echo "Invlid input file specified!"
        exit 30
fi

echo "azam hassan faizan shahrukh > file.txt
./create_users.sh file.txt
grep -E 'azam|hassan|faizan|shahrukh' /etc/passwd
echo $? (tells exit code) we know script ran successfully

root@x230:~/yum.sh
2 types of looping constructs used in shell scripts
while and for
done command is used to close these loops

VIM STOP INDENTATION
:setl nocin nosi noai inde=


ANSIBLE stopping dowmloads
#!/bin/sh

# Remove transaction_list, otherwise playbook will not check url again.
rm -f /home/ansible/transaction_list > /dev/null;

# Is httpd running?
nc -z -w 50ms apps.l33t.com 80 > /dev/null


# Switch states depending on if it is up or down
if [ $? -ne 0 ];
then
  echo -n "Starting apps.l33t.com...";
  ansible node1 -b -m service -a "name=httpd state=started" > /dev/null;
  echo "done."
else
  echo -n "Stopping apps.l33t.com...";
  ansible node1 -b -m service -a "name=httpd state=stopped" > /dev/null;
  echo "done."
fi



"******************************************"
---
- name: ignore changed_when failed_when example
  hosts: localhost
  become: yes
  tasks:
    - name: install farzi software
      yum:
        name: broke
        state: latest
      ignore_errors: yes

    - name: Run utility
      command: /home/ansible/automation/scripts/do_stuff.sh farzi
      register: output
      changed_when: "'CHANGED' is in output.stdout"
      failed_when: "'FAILED' is in output.stdout"

# Run command without a text to get changed status, or run with a text to get failed status
#!/bin/bash

if [ -z $1 ]
then
   echo "I CHANGED SOMETHING"
   exit 100
else
   echo "I FAILED"
   exit 200
fi
~

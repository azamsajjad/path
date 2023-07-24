Playbook Keywords
These are the keywords available on common playbook objects. Keywords are one of several sources for configuring Ansible behavior. See Controlling how Ansible behaves: precedence rules for details on the relative precedence of each source.

Note

Please note:

Aliases for the directives are not reflected here, nor are mutable ones. For example, action in task can be substituted by the name of any Ansible module.

The keywords do not have version_added information at this time

Some keywords set defaults for the objects inside of them rather than for the objects themselves

Play

Role

Block

Task

Play
any_errors_fatal
Force any un-handled task errors on any host to propagate to all hosts and end the play.

become
Boolean that controls if privilege escalation is used or not on Task execution. Implemented by the become plugin. See Become plugins.

become_exe
Path to the executable used to elevate privileges. Implemented by the become plugin. See Become plugins.

become_flags
A string of flag(s) to pass to the privilege escalation program when become is True.

become_method
Which method of privilege escalation to use (such as sudo or su).

become_user
User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.

check_mode
A boolean that controls if a task is executed in ‘check’ mode. See Validating tasks: check mode and diff mode.

collections
List of collection namespaces to search for modules, plugins, and roles. See Using collections in a playbook

Note

Tasks within a role do not inherit the value of collections from the play. To have a role search a list of collections, use the collections keyword in meta/main.yml within a role.

connection
Allows you to change the connection plugin used for tasks to execute on the target. See Using connection plugins.

debugger
Enable debugging tasks based on state of the task result. See Debugging tasks.

diff
Toggle to make tasks return ‘diff’ information or not.

environment
A dictionary that gets converted into environment vars to be provided for the task upon execution. This can ONLY be used with modules. This isn’t supported for any other type of plugins nor Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task. This is not a recommended way to pass in confidential data.

fact_path
Set the fact path option for the fact gathering plugin controlled by gather_facts.

force_handlers
Will force notified handler execution for hosts even if they failed during the play. Will not trigger if the play itself fails.

gather_facts
A boolean that controls if the play will automatically run the ‘setup’ task to gather facts for the hosts.

gather_subset
Allows you to pass subset options to the fact gathering plugin controlled by gather_facts.

gather_timeout
Allows you to set the timeout for the fact gathering plugin controlled by gather_facts.

handlers
A section with tasks that are treated as handlers, these won’t get executed normally, only when notified after each section of tasks is complete. A handler’s listen field is not templatable.

hosts
A list of groups, hosts or host pattern that translates into a list of hosts that are the play’s target.

ignore_errors
Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.

ignore_unreachable
Boolean that allows you to ignore task failures due to an unreachable host and continue with the play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.

max_fail_percentage
can be used to abort the run after a given percentage of hosts in the current batch has failed. This only works on linear or linear derived strategies.

module_defaults
Specifies default parameter values for modules.

name
Identifier. Can be used for documentation, or in tasks/handlers.

no_log
Boolean that controls information disclosure.

order
Controls the sorting of hosts as they are used for executing the play. Possible values are inventory (default), sorted, reverse_sorted, reverse_inventory and shuffle.

port
Used to override the default port used in a connection.

post_tasks
A list of tasks to execute after the tasks section.

pre_tasks
A list of tasks to execute before roles.

remote_user
User used to log into the target via the connection plugin.

roles
List of roles to be imported into the play

run_once
Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.

serial
Explicitly define how Ansible batches the execution of the current play on the play’s target. See Setting the batch size with serial.

strategy
Allows you to choose the connection plugin to use for the play.

tags
Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.

tasks
Main list of tasks to execute in the play, they run after roles and before post_tasks.

throttle
Limit number of concurrent task runs on task, block and playbook level. This is independent of the forks and serial settings, but cannot be set higher than those limits. For example, if forks is set to 10 and the throttle is set to 15, at most 10 hosts will be operated on in parallel.

timeout
Time limit for task to execute in, if exceeded Ansible will interrupt and fail the task.

vars
Dictionary/map of variables

vars_files
List of files that contain vars to include in the play.

vars_prompt
list of variables to prompt for.

Role
any_errors_fatal
Force any un-handled task errors on any host to propagate to all hosts and end the play.

become
Boolean that controls if privilege escalation is used or not on Task execution. Implemented by the become plugin. See Become plugins.

become_exe
Path to the executable used to elevate privileges. Implemented by the become plugin. See Become plugins.

become_flags
A string of flag(s) to pass to the privilege escalation program when become is True.

become_method
Which method of privilege escalation to use (such as sudo or su).

become_user
User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.

check_mode
A boolean that controls if a task is executed in ‘check’ mode. See Validating tasks: check mode and diff mode.

collections
List of collection namespaces to search for modules, plugins, and roles. See Using collections in a playbook

Note

Tasks within a role do not inherit the value of collections from the play. To have a role search a list of collections, use the collections keyword in meta/main.yml within a role.

connection
Allows you to change the connection plugin used for tasks to execute on the target. See Using connection plugins.

debugger
Enable debugging tasks based on state of the task result. See Debugging tasks.

delegate_facts
Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.

delegate_to
Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.

diff
Toggle to make tasks return ‘diff’ information or not.

environment
A dictionary that gets converted into environment vars to be provided for the task upon execution. This can ONLY be used with modules. This isn’t supported for any other type of plugins nor Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task. This is not a recommended way to pass in confidential data.

ignore_errors
Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.

ignore_unreachable
Boolean that allows you to ignore task failures due to an unreachable host and continue with the play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.

module_defaults
Specifies default parameter values for modules.

name
Identifier. Can be used for documentation, or in tasks/handlers.

no_log
Boolean that controls information disclosure.

port
Used to override the default port used in a connection.

remote_user
User used to log into the target via the connection plugin.

run_once
Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.

tags
Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.

throttle
Limit number of concurrent task runs on task, block and playbook level. This is independent of the forks and serial settings, but cannot be set higher than those limits. For example, if forks is set to 10 and the throttle is set to 15, at most 10 hosts will be operated on in parallel.

timeout
Time limit for task to execute in, if exceeded Ansible will interrupt and fail the task.

vars
Dictionary/map of variables

when
Conditional expression, determines if an iteration of a task is run or not.

Block
always
List of tasks, in a block, that execute no matter if there is an error in the block or not.

any_errors_fatal
Force any un-handled task errors on any host to propagate to all hosts and end the play.

become
Boolean that controls if privilege escalation is used or not on Task execution. Implemented by the become plugin. See Become plugins.

become_exe
Path to the executable used to elevate privileges. Implemented by the become plugin. See Become plugins.

become_flags
A string of flag(s) to pass to the privilege escalation program when become is True.

become_method
Which method of privilege escalation to use (such as sudo or su).

become_user
User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.

block
List of tasks in a block.

check_mode
A boolean that controls if a task is executed in ‘check’ mode. See Validating tasks: check mode and diff mode.

collections
List of collection namespaces to search for modules, plugins, and roles. See Using collections in a playbook

Note

Tasks within a role do not inherit the value of collections from the play. To have a role search a list of collections, use the collections keyword in meta/main.yml within a role.

connection
Allows you to change the connection plugin used for tasks to execute on the target. See Using connection plugins.

debugger
Enable debugging tasks based on state of the task result. See Debugging tasks.

delegate_facts
Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.

delegate_to
Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.

diff
Toggle to make tasks return ‘diff’ information or not.

environment
A dictionary that gets converted into environment vars to be provided for the task upon execution. This can ONLY be used with modules. This isn’t supported for any other type of plugins nor Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task. This is not a recommended way to pass in confidential data.

ignore_errors
Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.

ignore_unreachable
Boolean that allows you to ignore task failures due to an unreachable host and continue with the play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.

module_defaults
Specifies default parameter values for modules.

name
Identifier. Can be used for documentation, or in tasks/handlers.

no_log
Boolean that controls information disclosure.

notify
List of handlers to notify when the task returns a ‘changed=True’ status.

port
Used to override the default port used in a connection.

remote_user
User used to log into the target via the connection plugin.

rescue
List of tasks in a block that run if there is a task error in the main block list.

run_once
Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.

tags
Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.

throttle
Limit number of concurrent task runs on task, block and playbook level. This is independent of the forks and serial settings, but cannot be set higher than those limits. For example, if forks is set to 10 and the throttle is set to 15, at most 10 hosts will be operated on in parallel.

timeout
Time limit for task to execute in, if exceeded Ansible will interrupt and fail the task.

vars
Dictionary/map of variables

when
Conditional expression, determines if an iteration of a task is run or not.

Task
action
The ‘action’ to execute for a task, it normally translates into a C(module) or action plugin.

any_errors_fatal
Force any un-handled task errors on any host to propagate to all hosts and end the play.

args
A secondary way to add arguments into a task. Takes a dictionary in which keys map to options and values.

async
Run a task asynchronously if the C(action) supports this; value is maximum runtime in seconds.

become
Boolean that controls if privilege escalation is used or not on Task execution. Implemented by the become plugin. See Become plugins.

become_exe
Path to the executable used to elevate privileges. Implemented by the become plugin. See Become plugins.

become_flags
A string of flag(s) to pass to the privilege escalation program when become is True.

become_method
Which method of privilege escalation to use (such as sudo or su).

become_user
User that you ‘become’ after using privilege escalation. The remote/login user must have permissions to become this user.

changed_when
Conditional expression that overrides the task’s normal ‘changed’ status.

check_mode
A boolean that controls if a task is executed in ‘check’ mode. See Validating tasks: check mode and diff mode.

collections
List of collection namespaces to search for modules, plugins, and roles. See Using collections in a playbook

Note

Tasks within a role do not inherit the value of collections from the play. To have a role search a list of collections, use the collections keyword in meta/main.yml within a role.

connection
Allows you to change the connection plugin used for tasks to execute on the target. See Using connection plugins.

debugger
Enable debugging tasks based on state of the task result. See Debugging tasks.

delay
Number of seconds to delay between retries. This setting is only used in combination with until.

delegate_facts
Boolean that allows you to apply facts to a delegated host instead of inventory_hostname.

delegate_to
Host to execute task instead of the target (inventory_hostname). Connection vars from the delegated host will also be used for the task.

diff
Toggle to make tasks return ‘diff’ information or not.

environment
A dictionary that gets converted into environment vars to be provided for the task upon execution. This can ONLY be used with modules. This isn’t supported for any other type of plugins nor Ansible itself nor its configuration, it just sets the variables for the code responsible for executing the task. This is not a recommended way to pass in confidential data.

failed_when
Conditional expression that overrides the task’s normal ‘failed’ status.

ignore_errors
Boolean that allows you to ignore task failures and continue with play. It does not affect connection errors.

ignore_unreachable
Boolean that allows you to ignore task failures due to an unreachable host and continue with the play. This does not affect other task errors (see ignore_errors) but is useful for groups of volatile/ephemeral hosts.

local_action
Same as action but also implies delegate_to: localhost

loop
Takes a list for the task to iterate over, saving each list element into the item variable (configurable via loop_control)

loop_control
Several keys here allow you to modify/set loop behaviour in a task. See Adding controls to loops.

module_defaults
Specifies default parameter values for modules.

name
Identifier. Can be used for documentation, or in tasks/handlers.

no_log
Boolean that controls information disclosure.

notify
List of handlers to notify when the task returns a ‘changed=True’ status.

poll
Sets the polling interval in seconds for async tasks (default 10s).

port
Used to override the default port used in a connection.

register
Name of variable that will contain task status and module return data.

remote_user
User used to log into the target via the connection plugin.

retries
Number of retries before giving up in a until loop. This setting is only used in combination with until.

run_once
Boolean that will bypass the host loop, forcing the task to attempt to execute on the first host available and afterwards apply any results and facts to all active hosts in the same batch.

tags
Tags applied to the task or included tasks, this allows selecting subsets of tasks from the command line.

throttle
Limit number of concurrent task runs on task, block and playbook level. This is independent of the forks and serial settings, but cannot be set higher than those limits. For example, if forks is set to 10 and the throttle is set to 15, at most 10 hosts will be operated on in parallel.

timeout
Time limit for task to execute in, if exceeded Ansible will interrupt and fail the task.

until
This keyword implies a ‘retries loop’ that will go on until the condition supplied here is met or we hit the retries limit.

vars
Dictionary/map of variables

when
Conditional expression, determines if an iteration of a task is run or not.

with_<lookup_plugin>
The same as loop but magically adds the output of any lookup plugin to generate the item list.
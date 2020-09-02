#!/bin/bash -xe
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

# what is exec ?   Replace the shell with the given command.
#    Execute COMMAND, replacing this shell with the specified program.
#    ARGUMENTS become the arguments to COMMAND.  If COMMAND is not specified,
#    any redirections take effect in the current shell.

# tee command is used to appened standar input to file
# The logger command provides an easy way to add messages to the /var/log/syslog file from the command line.
# -t for tag 'user-data' on every line, -s to output mesage both stdmsg stderror

sleep 30
sudo mkdir -p  /data
sleep 30
sudo mkfs.ext4 ${device_name}
sudo mount ${device_name} /data

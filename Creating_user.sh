#!/bin/bash

# Script should be execute with sudo/root access.
if [[ "${UID}" -ne 0 ]]
then
        echo 'Please run with Sudo or root'
        exit 1
fi

# User should provide atleast one argument as username else guide hi
if [[ "${#}" -lt 1 ]]
then
        echo "Usage :${0} USER_NAME [COMMENT].."
        echo 'Create user with name USER_NAME and comments fields of commnet'
        exit 1
fi


# Store 1st argument as user name
USER_NAME="${1}"
echo $USER_NAME

# In case of more than one argument, store it as account comments.
shift
COMMENT="${@}"
echo $COMMENT

# Create a password.
PASSWORD=$(date +%s%N)
echo $PASSWORD

# Create the user
useradd -c "${COMMENT}" -m $USER_NAME
# Check if user is successfully created or not
if [[ $? -ne 0 ]]
then
        echo 'The Account could not be created'
        exit 1
fi

# Set the password for the user.
echo $PASSWORD | passwd --stdin $USER_NAME

# Check if password is successfully set or not
if [[ $? -ne 0 ]]
then
        echo 'The Password could not be set'
        exit 1
fi


# Force password change on first login.
passwd -e $USER_NAME

# Display the username, password, and the host where the user was created
echo
echo "USername : $USER_NAME"
echo
echo "Password : $PASSWORD"
echo
echo "Hostname :$(hostname)"

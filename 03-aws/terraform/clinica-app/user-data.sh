#!/bin/bash
# Copying the SSH Keyto the server

echo "ssh-rsa xxxxxxxxxxxxxxx" >> /home/ubuntu/.ssh/authorized_keys

sudo apt update
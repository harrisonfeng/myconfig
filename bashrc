#!/bin/bash
# This is .bashrc file for Harrison Feng <feng.harrison@gmail.com>
# You can copy this to your ${HOME}/.bashrc and customize it for yourself.

# make git branch displayed in shell prompt
PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[33m\]\w\[\033[35m\]$(__git_ps1)\[\033[00m\]\n\$ '

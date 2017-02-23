#!/bin/bash

# This script is used to configure VIM automatically.
#
#                                    _
#  ___ _   _ _ __   ___ _ __  __   _(_)_ __ ___
# / __| | | | '_ \ / _ \ '__| \ \ / / | '_ ` _ \
# \__ \ |_| | |_) |  __/ |     \ V /| | | | | | |
# |___/\__,_| .__/ \___|_|      \_/ |_|_| |_| |_|
#           |_|
#
#
# I love VIM so so so so much!
#
#
# Copyright (C) 2017 Harrison Feng <feng.harrison@gmail.com>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see [http://www.gnu.org/licenses/]
#
#
# Python Installer is a BASH script used to install Python from source
# in Ubuntu box. Since this script will go to download official Python
# source package, please make sure your network is alive. It requires
# wget utility is installed in your Ubuntu box. Actually, wget should
# be default installed in Ubuntu box.
#
#
# @author Harrison Feng <feng.harrison@gmail.com>
# @file install.sh


VERSION=1.0.1


# Definitions

## Color Definition
TXTRESET='\e[0m'
TXTRED='\e[0;31m'
TXTGREEN='\e[0;32m'
TXTBLUE='\e[0;34m'
TXTPURPLE='\e[0;35m'

## Must have directories
VIM_HOME_DIR=${HOME}/.vim
BUNDLE_DIR=${VIM_HOME_DIR}/bundle
VUNDLE_VIM_DIR=${BUNDLE_DIR}/Vundle.vim

## Useful pre-defined definitions
OS_TYPE=$(uname -o)
VIMRC=vimrc.linux
OS_CYGWIN=Cygwin

## URLs
VUNDLE_VIM_GIT_URL=https://github.com/VundleVim/Vundle.vim


function command_exists() {
   command -v "$@" > /dev/null 2>&1;
}


function go_back_home() {
    cd ${HOME}
}


function install_dependencies() {
    # For CentOS
    if command_exists yum; then
        yum groupinstall -y "Development Tools"
        yum install -y kernel-devel cmake python-devel tmux ctags
    # For Ubuntu
    elif command_exists apt; then
        sudo apt-get install -y build-essential cmake python-dev tmux exuberant-ctags
    # For ${OS_CYGWIN}
    elif [ "${OS_TYPE}" == "${OS_CYGWIN}" ]; then
        echo -e "${TXTGREEN}
        Your system is ${OS_CYGWIN}, don't need to install dependencies.
        But please make sure ctags installed in your ${OS_CYGWIN}.\n
        ${TXTRESET}"
    else
        echo -e "${TXTRED}
        Sorry, I can support ${OS_CYGWIN}, Ubuntu and CentOS only.\n
        ${TXTRESET}"
        exit 111
    fi
}


function check_env() {
    # Backup old bundle stuffs
    if [ -d ${BUNDLE_DIR} ]; then
        mv ${BUNDLE_DIR} ${VIM_HOME_DIR}/bundle_backup_$(date +%Y%m%d)
    else
        mkdir -p ${BUNDLE_DIR}
    fi
    # Backup old .vimrc 
    if [ -f ${HOME}/.vimrc ]; then
        mv ${HOME}/.vimrc ${HOME}/.vimrc_backup_$(date +%Y%m%d)
    fi
}


function create_vimrc {
    if [ "${OS_TYPE}" == "${OS_CYGWIN}" ]; then
        VIMRC=vimrc.cygwin
    fi
    \cp -rf ${VIMRC} ${HOME}/.vimrc
}


function install_update_plugins {
    if [ -d ${VUNDLE_VIM_DIR} ]; then
        cd ${VUNDLE_VIM_DIR}
        git pull origin master
    else
        go_back_home
        git clone ${VUNDLE_VIM_GIT_URL} ${VUNDLE_VIM_DIR}
    fi
    vim +PluginInstall +qall
}


function install_ycm {
    if [ "${OS_TYPE}" == "${OS_CYGWIN}" ]; then
        echo -e "${TXTGREEN}
        No need to install YCM as your OS is ${OS_CYGWIN}.\n
        ${TXTRESET}"
    else
        cd ${BUNDLE_DIR}/YouCompleteMe
        git submodule update --init --recursive
        ./install.py --clang-completer
        ./install.py --gocode-completer
    fi
}


function main() {
    check_env
    create_vimrc
    install_dependencies
    install_update_plugins
    install_ycm
    go_back_home
}


main

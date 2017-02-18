#!/bin/bash
# This script is used to config super vim
# I love VIM so much
# @author Harrison Feng <feng.harrison@gmail.com>

VERSION=1.0.0

VUNDLE_VIM_DIR=${HOME}/.vim/bundle/Vundle.vim
BUNDLE_DIR=${HOME}/.vim/bundle

function command_exists() {
   command -v "$@" > /dev/null 2>&1;
}


function install_dependencies() {
    if command_exists yum; then
        yum groupinstall -y "Development Tools"
        yum install -y kernel-devel cmake python-devel tmux
    elif command_exists apt; then
        sudo apt-get install -y build-essential cmake python-dev tmux
    else
        echo "Sorry, I can support both Ubuntu and CentOS only."
        exit 111
    fi
}


function check_env() {
    if [ ! -d $BUNDLE_DIR ]; then
        mkdir -p ${HOME}/.vim/bundle
    fi
    if [ -f ${HOME}/.vimrc ]; then
        mv ${HOME}/.vimrc ${HOME}/.vimrc_backup_$(date +%Y%m%d)
    fi
}


function create_vimrc {
    \cp -rf vimrc.simple ${HOME}/.vimrc
}


function install_update_plugins {
    if [ -d ${VUNDLE_VIM_DIR} ]; then
        cd ${VUNDLE_VIM_DIR}
        git pull origin master
        cd ${HOME}
    else
        cd ${HOME}
        git clone  https://github.com/VundleVim/Vundle.vim ${VUNDLE_VIM_DIR}
    fi
    vim +PluginInstall +qall
}


function install_ycm {
    cd ${HOME}/.vim/bundle/YouCompleteMe
    git submodule update --init --recursive
    ./install.py --clang-completer
    ./install.py --gocode-completer
}


function main() {
    check_env
    create_vimrc
    install_dependencies
    install_update_plugins
    install_ycm
}


main

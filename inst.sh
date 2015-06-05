#!/bin/bash
# This script is used to config super vim 

VUNDLE_VIM_DIR=${HOME}/.vim/bundle/vundle.vim

mkdir -p ${HOME}/.vim/bundle
cp vimrc ${HOME}/.vimrc

if [ -d ${VUNDLE_VIM_DIR} ]; then
    cd ${VUNDLE_VIM_DIR}
    git pull
    cd ${HOME}
else
    cd ${HOME}
    git clone  https://github.com/gmarik/vundle.git  ${HOME}/.vim/bundle/vundle.vim
fi

vim +PluginInstall +qall

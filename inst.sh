#!/bin/bash
# This script is used to config super vim 


VUNDLE_VIM_DIR=${HOME}/.vim/bundle/Vundle.vim

mkdir -p ${HOME}/.vim/bundle

if [ -f ${HOME}/.vimrc ]; then
    mv ${HOME}/.vimrc ${HOME}/.vimrc_backup
fi

\cp -rf vimrc.simple ${HOME}/.vimrc

if [ -d ${VUNDLE_VIM_DIR} ]; then
    cd ${VUNDLE_VIM_DIR}
    git pull
    cd ${HOME}
else
    cd ${HOME}
    git clone  https://github.com/VundleVim/Vundle.vim ${VUNDLE_VIM_DIR}
fi

vim +PluginInstall +qall

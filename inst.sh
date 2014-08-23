#!/bin/bash


VUNDLE_VIM_DIR=${HOME}/.vim/bundle/Vundle.vim

mkdir -p ${HOME}/.vim/bundle

cp vimrc ${HOME}/.vimrc

if [ -d ${VUNDLE_VIM_DIR} ]; then
    cd ${VUNDLE_VIM_DIR}
    git pull
    cd ${HOME}
else
    cd ${HOME}
    git clone  https://github.com/gmarik/vundle.git  ${HOME}/.vim/bundle/Vundle.vim
fi

vim +PluginInstall +qall

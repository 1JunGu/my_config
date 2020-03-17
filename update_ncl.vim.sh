#!/bin/sh
# produce ncl3.dic from downloaded ncl3.vim

wget http://www.ncl.ucar.edu/Applications/Files/ncl.dic
mv -i ncl.dic $HOME/my_config/vim/dictionary/
wget http://www.ncl.ucar.edu/Applications/Files/ncl3.vim  # updated 2 days after release of 6.4.0
mv -i ncl3.vim $HOME/my_config/vim/syntax/

sed -n '/^syn keyword nclKeyword/p' $HOME/my_config/vim/syntax/ncl3.vim > dic3b.ncl
sed -n '/^syn keyword nclBoolean/p' $HOME/my_config/vim/syntax/ncl3.vim >> dic3b.ncl
sed -n '/nclKeyword/d;/nclBoolean/d;/^syn keyword/p' $HOME/my_config/vim/syntax/ncl3.vim >> dic3b.ncl
sed -i 's/syn keyword [^ ]* \+\b/\n/' dic3b.ncl

t_update=`sed -n '/^" Updated/s/" Updated //p' $HOME/my_config/vim/syntax/ncl3.vim`
head -n 5 $HOME/my_config/vim/dictionary/ncl.dic |sed "s/\(^.* Updated: \+\b\).*$/\1$t_update/;s/\(^.* Author: \+\b\).*$/\1Packard Chan\n\" Based on previous version by Prince K Xavier, and ncl3.vim by Carl Schreck/" > $HOME/my_config/vim/dictionary/ncl3.dic

sed '1d' dic3b.ncl |fold -w 500 -s >> $HOME/my_config/vim/dictionary/ncl3.dic
rm dic3b.ncl
rm $HOME/my_config/vim/dictionary/ncl.dic
mv $HOME/my_config/vim/dictionary/ncl3.dic $HOME/my_config/vim/dictionary/ncl.dic
mv $HOME/my_config/vim/syntax/ncl3.vim $HOME/my_config/vim/syntax/ncl.vim

#This script puts the dictionary file in $HOME/my_config/vim/dictionary/ncl3.dic. Make
#sure you update your vimrc with this new dictionary file location.

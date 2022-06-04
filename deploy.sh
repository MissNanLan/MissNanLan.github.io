#!/bin/bash

echo "===========  start deploy  ==========="

/bin/echo -n "输入改动信息: "
read change 

git checkout master
git add .
git commit --amend --reset-author -m $change 
git push 


# git checkout pages
hexo clean
hexo g
hexo d




echo "===========  end  deploy  ==========="

exit 0 
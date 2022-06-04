#!/bin/bash
echo "===================  start deploy ==============================="

/bin/echo -n "输入改动信息: "
read change

rm -rf .deploy_git
hexo deploy

git add -A
git commit -m $change 
git pull --rebase
git push 

echo "===================  end   deploy ==============================="
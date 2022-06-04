#!/bin/bash

echo "===========  start deploy  ==========="

/bin/echo -n "输入改动信息: "
read change 


git add -A
git commit  -m $change 
git push origin master


# git checkout pages
hexo clean
hexo g
hexo d




echo "===========  end  deploy  ==========="

exit 0 
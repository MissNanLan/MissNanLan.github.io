---
title: Read-Eval-Print-Loop读取-执行-输出循环
date: 2022-06-02 14:47:25
tags: REPL
categories: 技术
---



REPL 提供了一种交互地执行 JavaScript 并查看输出的方式。它可以被用作调试、测试或仅仅尝试某些东西。

在命令行输入 `node `就会进入 `REPL`

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/d9d8f045081c48efa620c12a24130619~tplv-k3u1fbpfcp-watermark.image?)

``` 
.break    Sometimes you get stuck, this gets you out
.clear    Alias for .break
.editor   Enter editor mode
.exit     Exit the repl
.help     Print this help message
.load     Load JS from a file into the REPL session
.save     Save all evaluated commands in this REPL session to a file

```



之前老是跑到浏览器的`console`，现在才发现这个，记录下
---
title: html小技巧
date: 2022-06-06 21:18:29
tags: html
---

// 1、捕获摄像头，user 表示前置摄像头，environment 表示后置摄像头
<input type="file" capture="user" accept="image/*" />

// 2、每 10s 刷新一次

<meta http-equiv="refresh" content="10" />

// 3、开启 input 输入框的拼写检测
<input type="text" spellcheck="true" lang="en" />

// 4、上传文件时指定允许的文件格式
<input type="file" accept=".jpeg,.png" />

// 5、阻止浏览器翻译，适用场景比如 Logo 和品牌名

<p translate="no">Brand name</p >

// 6、允许选择多个文件
<input type="file" multiple />

// 7、为 video 标签添加缩略图
<video poster="picture.png"></video>

// 8、声明资源文件的下载
<a href="image.png" download>

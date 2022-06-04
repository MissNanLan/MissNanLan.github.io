---
title: background-size 和background-cover的缩写
date: 2022-06-04 11:03:31
tags: CSS
---

## 简介
 
 `background`的缩写其实在工作中经常遇到，但是由于属性颇多，会弄混淆，遂记录下

``` css
background: center / contain no-repeat url("../../media/examples/firefox-logo.svg"), 
#eee 35% url("../../media/examples/lizard.png");
```

以上代码我是从[MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background)拷贝的，能判断以上属性是什么属性的缩写吗。我们从浏览器`Styles` 截图


![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f609962e432b4288a61c827f9357aece~tplv-k3u1fbpfcp-watermark.image?)

代码中是有两张背景图片（日常工作没有用两张图片叠加在一起）。其实`no-repeat` 、`url`、`#eee` 这些都特别好判断，关键是`center/ container`、`35%` 不好区分。 他们是`background-postion`和`background-size`这两个属性，如果两个都缩写的话，必定要用`/`分割起来。`/`前面代表 background-position ，`/`后面是`background-size`。 如果没有用上`/`,则代表着`background-postion`属性
  
  
 ## 附上css样式属性
 
 ###  background-position
  
 > 含义：定义x、y的坐标
 
 属性值（没想到，一搜发现有这么多写法），有一到四个值的写法，可以看到不管是是几个值的语法，都有`length`和`percentage`的写法，所以常常回合`background-size`弄混
 
![FireShot Capture 011 - background-position - CSS（层叠样式表） - MDN - developer.mozilla.org.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/4b77cd9fb67340d88367b6c6672a68e2~tplv-k3u1fbpfcp-watermark.image?)

 ### background-size
  
> 含义： 设置图片背景的大小
属性值： 

1、 length 
2、 percentage 
3、 auto
4、 cover
5、container

 
![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/f0209ec91b6943c39198433ccf793b43~tplv-k3u1fbpfcp-watermark.image?)
 
 
日常工作中最常用的缩写组合，应该就是`background: url(xxx) no-repeat center / cover #eee`类似的语法了
 
 

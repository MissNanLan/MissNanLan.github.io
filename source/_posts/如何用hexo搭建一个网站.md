---
title: 如何用hexo搭建一个网站
date: 2022-06-05 20:47:17
tags: hexo
---

## 几行命令就可以搞定

```
$ npm install -g hexo-cli
$ npm install hexo
$ hexo init <folder>
$ cd <folder>
$ npm install

```

## 网站目录结构

```
├── _config.yml  // 配置信息
├── package.json
├── scaffolds  // 模板文件
├── source
|   ├── _drafts
|   └── _posts
└── themes

其他就不用多介绍了

```

### config.yml 基本参数介绍

| `title`       | 网站标题                                                                                                                                                                                                                          |
| ------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `subtitle`    | 网站副标题                                                                                                                                                                                                                        |
| `description` | 网站描述                                                                                                                                                                                                                          |
| `keywords`    | 网站的关键词。支持多个关键词。                                                                                                                                                                                                    |
| `author`      | 您的名字                                                                                                                                                                                                                          |
| `language`    | 网站使用的语言。对于简体中文用户来说，使用不同的主题可能需要设置成不同的值，请参考你的主题的文档自行设置，常见的有  `zh-Hans`和  `zh-CN`。                                                                                        |
| `timezone`    | 网站时区。Hexo 默认使用您电脑的时区。请参考  [时区列表](https://en.wikipedia.org/wiki/List_of_tz_database_time_zones)  进行设置，如  `America/New_York`, `Japan`, 和  `UTC` 。一般的，对于中国大陆地区可以使用  `Asia/Shanghai`。 |

其他配置参数详见[配置](https://hexo.io/zh-cn/docs/configuration)

### 模板文件

常见的模板文件有三种

```
├── scaffolds
    ├── _drafts
    └── _posts
    └── _page
```

与此对应的创建命令 `hexo new draft/post/page 你的名字`

### 写作

写作就用`MD`或者`EJS`格式。原理是因为`hexo` 默认安装了
`hexo-renderer-marked`  和  `hexo-renderer-ejs`。如果你安装了  `hexo-renderer-pug`,也可以用`pug`的格式

### Front-matter

就是开始写一篇文章后，用于指定文章的变量
参数 | 描述 | 默认值 |
| ----------------- | ------------------------------------------------------------------------------------------------------------------ | -------------------------------------------------------------------------------------- |
| `layout` | 布局 | [`config.default_layout`](https://hexo.io/zh-cn/docs/configuration#%E6%96%87%E7%AB%A0) |
| `title` | 标题 | 文章的文件名 |
| `date` | 建立日期 | 文件建立日期 |
| `updated` | 更新日期 | 文件更新日期 |
| `comments` | 开启文章的评论功能 | true |
| `tags` | 标签（不适用于分页） | |
| `categories` | 分类（不适用于分页） | |
| `permalink` | 覆盖文章网址 | |
| `excerpt` | Page excerpt in plain text. Use [this plugin](https://hexo.io/docs/tag-plugins#Post-Excerpt) to format the text | |
| `disableNunjucks` | Disable rendering of Nunjucks tag `{{ }}`/`{% %}` and [tag plugins](https://hexo.io/docs/tag-plugins) when enabled | |
| `lang` | Set the language to override [auto-detection](https://hexo.io/docs/internationalization#Path) | Inherited from `_config.yml`

`tags` 和 `categories`这两个参数，一般自己手动添加

categories 小知识

并列分类：
categories:

- [前端]
- [后端]

并列+子分类
categories:

- [前端, JavaScript]
- [后端, JAva]

### 本地启动

`hexo server`

## 部署

部署有多种方式，我浅尝了[github pages](https://hexo.io/docs/one-command-deployment), 即不需要服务器和域名

1、 安装 git 部署插件

```
npm install hexo-deployer-git --save
```

2、 编辑\_config.yml

```
deploy:
  type: git
  repo:  在github创建的.io的repo
  branch: [branch] // 部署的分支
  message: [message]
```

部署命令

```
$ hexo clean 清除缓存
$ hexo generate 生成静态文件
$ hexo deploy
```

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/adfc61f5bcf9401baff3cfc7f583a872~tplv-k3u1fbpfcp-watermark.image?)

3、 遇到的问题

- 经常性 443

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/ec64bcfdb9754b38b590cb39ddea1e69~tplv-k3u1fbpfcp-watermark.image?)

- source 和 build 后如何隔开来

- 部署的原理是什么

4、 TODO

- 下次不用 git pages 部署

### 常见问题

[troubleshooting](https://hexo.io/zh-cn/docs/troubleshooting)

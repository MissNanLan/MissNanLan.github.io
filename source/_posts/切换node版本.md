---
title: 切换node版本
date: 2022-06-04 10:42:36
tags: node
---
## n

```
npm install -g n
```

```
n x.x.x 安装某个版本

n lts 安装最新版本

n stable 安装稳定版本lts

n rm x.x.x 删除某个版本

n use 16.14.2

n 可以查看所有已安装的node版本，可以根据上下和回车选择要使用的版本

n ls-remote --all 查看服务器上所有可用的版本

```


`n ls-remote --all`这个命令真香，可以查看目前所有的node版本


## nvm



Node 版本管理器是一个用于管理多个已发布的 Node.js 不同版本的 bash 脚本。它允许你执行诸如“安装”、“卸载”以及“版本切换”等诸多功能。 使用[安装脚本](https://github.com/nvm-sh/nvm#install--update-script)安装 nvm。

对于 Unix / OS X 系统，Node.js 从源代码构建，并通过 [nvm](https://github.com/creationix/nvm) 安装到你所期望的地方。

```
env VERSION=`python tools/getnodeversion.py` make install DESTDIR=`nvm_version_path v$VERSION` PREFIX=""
```

随后你可以通过 `nvm` 在“发布版本”和“从源代码构建版本”中选择。

举个例子，如果你的 Node.js 版本是 v8.0.0-pre：

```
nvm use 8
```

一旦官方发布了版本，并且你希望卸载从源代码编译的版本，可以这样做：

```
nvm uninstall 8
```

这个安装脚本比想象中复杂


## nvs
#### Windows[](https://nodejs.org/zh-cn/download/package-manager/#windows)

`nvs`版本管理器是一个跨平台，可用于 Windows、macOS 以及形如 Unix 的操作系统。

在 Windows 上安装 `nvs`，请到此 [发布页](https://github.com/jasongin/nvs/releases) 下载最新发布的 MSI 安装源。

你也可以使用 `chocolatey` 进行安装：

```
choco install nvs
```

#### macOS，UnixLike[](https://nodejs.org/zh-cn/download/package-manager/#macos-unixlike)

你可以在 [此处](https://github.com/jasongin/nvs/blob/master/doc/SETUP.md#mac-linux) 找到关于在 macOS / 形如 Unix 操作系统的安装步骤文档。

#### 使用方法

安装完成后，你可以使用 `nvs` 在不同版本的 node 中来回切换。

添加最新版本的 node：

```
nvs add latest
```

添加最新 LTS 版本的 node：

```
nvs add lts
```

然后运行 `nvs use` ，为当前脚本的 `PATH` 路径下添加一个 node 版本：

```
$ nvs use lts
PATH -= %LOCALAPPDATA%\nvs\default
PATH += %LOCALAPPDATA%\nvs\node\14.17.0\x64
```

如果需要永久在 `PATH` 里添加，使用 `nvs link`：

```
nvs link lts
```



我最常用还是`n`


## 链接

[package-manager](https://nodejs.org/zh-cn/download/package-manager)

[nvs](https://github.com/jasongin/nvs)

[nvm](https://github.com/nvm-sh/nvm)

[n](https://github.com/tj/n)
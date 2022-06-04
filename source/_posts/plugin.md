---
title: plugin
date: 2022-06-04 18:28:51
tags: babel
---

举一个例子，以写一个自动生成API文档为主

## plugin

### 调用插件

``` js
// index.js
const { transformFromAstSync } = require('@babel/core');
const  parser = require('@babel/parser');
const autoDocumentPlugin = require('./plugin/auto-document-plugin');
const fs = require('fs');
const path = require('path');

// 读取文件
const sourceCode = fs.readFileSync(path.join(__dirname, './sourceCode.ts'), {
    encoding: 'utf-8'
});

// 转成AST
const ast = parser.parse(sourceCode, {
    sourceType: 'unambiguous',
    plugins: ['typescript']
});

// 插件使用
const { code } = transformFromAstSync(ast, sourceCode, {
    plugins: [[autoDocumentPlugin, {
        outputDir: path.resolve(__dirname, './docs'),
        format: 'markdown'// html / json
    }]]
});

```

### plugin模板

plugin 有两种形式

####  一个函数返回一个对象的格式

``` js
// xx-plugin.js
const { declare } = require('@babel/helper-plugin-utils');
// api:  babel 的 api，
// options: 传给plugin的参数
// dirname： 目录名字
const xxPlugin = declare((api, options, dirname) => {
    api.assertVersion(7);
    const xxPlugin = declare((api, options, dirname) => {
        api.assertVersion(7);
        // name 插件的名字
        // inherits 指定继承某个插件，和当前插件的 options 合并，通过 Object.assign 的方式。
        // pre 遍历前调用
        // visitor 指定 traverse 时调用的函数。
        // post 遍历后调用
        // manipulateOptions 用于修改 options，是在插件里面修改配置的方式，比如 babel-plugin-syntax-xx, 一般都会修改 parser options
        return {
            name: "proposal-export-namespace-from",
            inherits: syntaxExportNamespaceFrom.default,
            pre(file) {
                // 代码逻辑
            },
            visitor: {
                FunctionDeclaration(path, state) {
                    // 代码逻辑
                },
            },
            manipulateOptions(opts, parserOpts) {   
                // 告诉 parser 要 parse xxx这个语法,如jsx 
                 parserOpts.plugins.push("xxx");
            },
            post(file) {
                // 代码逻辑
            }
        }
    })
})
```
 在babel官网找了几个插件的写法
 
 [babel-plugin-proposal-export-default-from](https://github.com/babel/babel/blob/main/packages/babel-plugin-proposal-export-default-from/src/index.ts)
 
 [babel-plugin-proposal-function-bind](https://github.com/babel/babel/blob/main/packages/babel-plugin-proposal-function-bind/src/index.ts)
 
 [babel-plugin-proposal-numeric-separator](https://github.com/babel/babel/blob/main/packages/babel-plugin-proposal-numeric-separator/src/index.ts)
 
 [babel-plugin-syntax-export-default-from](https://github.com/babel/babel/tree/main/packages/babel-plugin-syntax-export-default-from)
 
 #### 直接返回一个对象
 
 这种方式的插件形式用于不需要处理参数的情况,这种我在官网还没有找到
 
  ``` js
export default plugin = {
  pre(state) {
    this.cache = new Map();
  },
  visitor: {
    StringLiteral(path, state) {
      this.cache.set(path.node.value, 1);
    },
  },
  post(state) {
    console.log(this.cache);
  },
};
  ```
 

### visitor模式

>visitor模式（访问者模式），作为设计模式的其中一种。访问者模式解决的是**数据**与**数据的操作方法**之间的耦合，将数据的操作方法独立于数据，使其可以自由演变。因此访问这更适合于那些**数据稳定**，但是数据的操作方法一遍的环境下。因此当操作方环境改变时，可以自由修改操作方法以适应操作环境，而不用修改原数据，实现操作方法的扩展。

对应到 babel traverse 的实现，就是 AST(数据) 和 visitor（有很多操作方法） 分离，在 traverse（遍历）AST 的时候，调用注册的 visitor 来对其进行处理


#### 路径（path）和作用域（scope）

``` js
path:NodePath
```

> babel AST 中只包含源码的一些信息，但是操作 AST 时要拿到父节点的信息，并且也需要对 AST 增删改的方法，这些都在 path 对象里。

>scope 是作用域信息，javascript 中能生成作用域的就是模块、函数、块等，而且作用域之间会形成嵌套关系，也就是作用域链。babel 在遍历的过程中会生成作用域链保存在 path.scope 中。

 
 path api太强大， 要多用才熟悉
 

## @babel/types

[@babel/types](https://babeljs.io/docs/en/babel-types)


## 总结

大致了解怎么去写一个babel插件，在转成AST后，在transform阶段运用设计模式的访问者模式（数据和数据的操作方法解耦），然后通过path相关api去实现逻辑，path的类型是`NodePath`,这个里面包含了AST的path 和scope（作用域链），通过对api的各种操作，实现我们要的结果

``` js
visitor: { 
ExportNamedDeclaration(path) { 
  const { node, scope } = path;
}
```

## 参考

掘金小册[babel插件通关秘籍](https://juejin.cn/book/6946117847848321055/section/6946582521672892456)

[babel-handbook](https://github.com/jamiebuilds/babel-handbook)
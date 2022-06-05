--
title: 如何实现一个babel plugin
date: 2022-06-04 18:17:36
tags: babel
---

最近在学[zxg_神说要有光](https://juejin.cn/user/2788017216685118)的babel通关秘籍

首先推荐一个非常有用的网站

[astexplorer](https://astexplorer.net/)

这个网站能我们实现一个plugin 以及AST的分类图能给我们写插件提供帮助

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/b29b0bb6151840d9b75cf79703fa9cdc~tplv-k3u1fbpfcp-watermark.image?)

无非是对各个AST节点进行逻辑处理，实现我们想要的功能

举例，比如我们要实现自动生成文档

``` js
/**
 * say 你好
 * @param name 名字
 */
 function sayHi (name: string, age: number, a: boolean):string {
  console.log(`hi, ${name}`);
  return `hi, ${name}`;
}

```

期望得到

![image.png](https://p9-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/70c24bc542974e1e8abd1f7072ff57ef~tplv-k3u1fbpfcp-watermark.image?)


我们把这段逻辑复制到[astexplorer](https://astexplorer.net/#/gist/b0d57d7558f7751699100200a14e523c/860789f4d6f1b19523d86eccd4d40838e975d4f4)

 
![image.png](https://p3-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/daef6d0643e94ab49137e7f6a7e4af78~tplv-k3u1fbpfcp-watermark.image?)

可以得知我们处理`FunctionDeclaration`，它有两个重要的参数

``` js
// path 获取节点的信息
// state 节点的状态
  FunctionDeclaration(path, state)
```

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/6822abaca28a437690ced0f35a175914~tplv-k3u1fbpfcp-watermark.image?)

- 获取函数名字path.get("id").toString()
- 获取函数的入参path.get("params")
- 获取函数的返回类型path.get("returnType").getTypeAnnotation()


``` js
// 函数的形式
const { declare } = require("@babel/helper-plugin-utils");
const doctrine = require("doctrine");
const fse = require("fs-extra");
const path = require("path");
const renderer = require("./renderer");

const autoDocumentPlugin = declare((api, options, dirname) => {
  api.assertVersion(7);

  return {
    pre(file) {  // 初始化插件返回的信息
      file.set("docs", []);
    },
    visitor: {
      FunctionDeclaration(path, state) {
        const docs = state.file.get("docs");
        docs.push({
          type: "function",
          name: path.get("id").toString(), // 获取函数名
          // 获取函数的参数
          params: path.get("params").map((paramPath) => {
            return {
              name: paramPath.toString(),
              // paramPath.getTypeAnnotation() 参数的类型
              type: resolveType(paramPath.getTypeAnnotation()),
            };
          }),
          //  返回参数的类型
          return: resolveType(path.get("returnType").getTypeAnnotation()),
          doc:
            // 注释信息单独处理
            path.node.leadingComments &&
            parseComment(path.node.leadingComments[0].value),
        });
        state.file.set("docs", docs);
        },
   
    },
    post(file) {   //  最后返回结果的处理
      const docs = file.get("docs");
      const res = generate(docs, options.format);
      fse.ensureDirSync(options.outputDir);
      fse.writeFileSync(
        path.join(options.outputDir, "docs" + res.ext),
        res.content
      );
    },
  };
});

module.exports = autoDocumentPlugin;
```
    
 注释的处理
 使用doctrine
 ``` js
 
//  处理注释信息
function parseComment(commentStr) {
  if (!commentStr) {
    return;
  }
  return doctrine.parse(commentStr, {
    unwrap: true,
  });
}
 ```
 
思考：实际工作中需要写一个plugin插件不
    
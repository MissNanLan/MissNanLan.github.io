---
title: react 18
date: 2022-06-04 18:12:15
tags: react 18
---

## What is Concurrent React（并发渲染）

并发模式进行可中断渲染

查阅了一些资料

其目的为了提升帮助React应用保持响应，并优雅地适应用户的设备功能和网络速度


因为有了这个并发渲染，Suspense, transitions, and SSR都是充分`并发渲染`去构建的



### 可重用的状态

接下来的小版本可能会增加 `Offscreen`


## New Feature: Automatic Batching

```
ReactDOM.flushSync()
```

[https://github.com/reactwg/react-18/discussions/21](https://github.com/reactwg/react-18/discussions/21)



这看起来很像是一个使用者不需要太关心的feature，因为react 18自动处理了。在使用timeouts、promises、natives event handler或者其他events的更新将以与React事件中的更新相同的方式进行批处理，嗯嗯...就是为了减少渲染次数

懒得复制代码了，直接截图

### 函数式组件

![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3b54eae955e743e68642ee6cb9f2e3e0~tplv-k3u1fbpfcp-watermark.image?)


最终只会渲染一次


### Class组件


![image.png](https://p6-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/3a4d2731d84f4aa8a7a2ab0fdecb50d1~tplv-k3u1fbpfcp-watermark.image?)


### 不想自动批处理

``` js
import { flushSync } from 'react-dom'; // Note: react-dom, not react

function handleClick() {
  flushSync(() => {
    setCounter(c => c + 1);
  });
  // React has updated the DOM by now
  flushSync(() => {
    setFlag(f => !f);
  });
  // React has updated the DOM by now
}
```

官方不推荐介么做啦


## New Feature Transitions

## New  Features Suspense

https://github.com/reactwg/react-18/discussions/37


## New Client and Server Rendering APIs

 ### Client Rendering APIs
|  | Before` | React 18 | 
| --- | --- | ---|
|  Updates to Client Rendering APIs | ReactDOM.render | ReactDOM.createRoot | 
|  Unmount | unmountComponentAtNode | root.unmount | 
|   | | 移除了render的callback| 
| Server-side rendering  | hydrate| hydrateRoot| 

#### changed `ReactDOM.render` to `ReactDOM.createRoot`
``` js

// Before
import { render } from 'react-dom';
const container = document.getElementById('app');
render(<App tab="home" />, container);

// After
import { createRoot } from 'react-dom/client';
const container = document.getElementById('app');
const root = createRoot(container);
root.render(<App tab="home" />);

```

#### changed `unmountComponentAtNode` to `root.unmount`


``` js
// Before
unmountComponentAtNode(container);

// After
root.unmount();
```


#### 移除了render的callback

``` js
// Before
const container = document.getElementById('app');
ReactDOM.render(<App tab="home" />, container, () => {
  console.log('rendered');
});

// After
function AppWithCallbackAfterRender() {
  useEffect(() => {
    console.log('rendered');
  });

  return <App tab="home" />
}

const container = document.getElementById('app');
const root = ReactDOM.createRoot(container);
root.render(<AppWithCallbackAfterRender />);
```


移除的原因是因为

> 因为它在使用 Suspense 时通常没有预期的结果


尴尬这个`Suspense`只是听闻过，但是没有使用过


#### SSR hydrate 替换为 hydrateRoot
``` js
// Before
import { hydrate } from 'react-dom';
const container = document.getElementById('app');
hydrate(<App tab="home" />, container);

// After
import { hydrateRoot } from 'react-dom/client';
const container = document.getElementById('app');
const root = hydrateRoot(container, <App tab="home" />);
//  哈哈，这里可以用不createRoot
```

也没有用过

 ### Server Rendering APIs
 
The following APIs will continue working, but with limited support for Suspense

-   [`renderToString()`](https://reactjs.org/docs/react-dom-server.html#rendertostring)（Limited）
-   [`renderToStaticMarkup()`](https://reactjs.org/docs/react-dom-server.html#rendertostaticmarkup)（Limited）


These additional methods depend on a package (`stream`) that is **only available on the server**, and won’t work in the browser.

-   [`renderToPipeableStream()`](https://reactjs.org/docs/react-dom-server.html#rendertopipeablestream) (New)
-   [`renderToReadableStream()`](https://reactjs.org/docs/react-dom-server.html#rendertoreadablestream)(New)
-   [`renderToNodeStream()`](https://reactjs.org/docs/react-dom-server.html#rendertonodestream) (Deprecated)
-   [`renderToStaticNodeStream()`](https://reactjs.org/docs/react-dom-server.html#rendertostaticnodestream)(不变)

介绍新的API

#### renderToPipeableStream

renderToString>renderToPipeableStream

#### renderToReadableStream


## New Strict Mode Behaviors


## 新的hooks

- useTransition

- startTransition

https://github.com/reactwg/react-18/discussions/41

https://github.com/reactwg/react-18/discussions/65

- useDeferredValue

有点类似于防抖的功能

- useInsertionEffect

- useId

- useSyncExternalStore

## 从另一个维度看这次更新

![image.png](https://p1-juejin.byteimg.com/tos-cn-i-k3u1fbpfcp/19f6d1dde8d94da7b55b972cf035e006~tplv-k3u1fbpfcp-watermark.image?)

https://github.com/reactwg/react-18/discussions/4


[discussions](https://github.com/reactwg/react-18/discussions)真是个好东西，可以及时看到更新的知识点



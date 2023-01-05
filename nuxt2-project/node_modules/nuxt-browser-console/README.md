# nuxt-browser-console

[![npm version][npm-version-src]][npm-version-href]
[![npm downloads][npm-downloads-src]][npm-downloads-href]
[![Github Actions CI][github-actions-ci-src]][github-actions-ci-href]
[![Codecov][codecov-src]][codecov-href]
[![License][license-src]][license-href]

> receive server-side and client-side logs/errors/warnings inside the browser console <br>

With this module, you can use browser console methods. No matter you are using this module inside the server or client, the messages are always shown in the browser console. A good and cheap way to monitoring server events in the production environment (for example, Axios request and response information can be logged into the browser console).

[📖 **Release Notes**](./CHANGELOG.md)

## Setup

1. Add `nuxt-browser-console` dependency with `yarn` or `npm` to your project

```bash
yarn add nuxt-browser-console # or npm install nuxt-browser-console
```

2. Add `nuxt-browser-console` to the `modules` section of `nuxt.config.js`

```js
{
  modules: [
    // Simple usage
    'nuxt-browser-console',

    // With options
    ['nuxt-browser-console', { /* module options */ }]
  ],
  browserConsole: {
    /* module options */
  }
}
```

## Options
Module default options:


| Option | Default | Description |
| ------ | ------- | ----------- |
| namespace | `console` | the namespace of the module. `this.$console.log(...)` or `$console.log(...)` inserted fom nuxt [context](https://nuxtjs.org/docs/2.x/concepts/context-helpers) |


```js
{
  browserConsole: {
    namespace: 'console'
  }
}
```

## Usage
You can simply use this module through `this` or context `$console` almost every where in your Nuxt app.

```js
  this.$console.log(...args)
```

Available methods:
```js
$console.log(obj1 [, obj2, ..., objN])
$console.info(obj1 [, obj2, ..., objN])
$console.warn(obj1 [, obj2, ..., objN])
$console.error(obj1 [, obj2, ..., objN])
$console.clear()
$console.groupCollapsed([label])
$console.groupEnd()
```

An example to show how to use this module to log some data inside the browser (no matter server-side/client-side).
```js
export default function ({$axios, $console}) {

  const style = "background: #d32f2f;border-radius: 0.5em;color: white;font-weight: bold;padding: 2px 0.5em;";

  $axios.interceptors.response.use((x) => {
    $console.groupCollapsed('', `%cRequest to ${x.config.url.split("?")[0]}`, style);

    $console.info('URL:', `${x.config.baseURL}${x.config.url}`);

    $console.info('Method:', x.config.method.toUpperCase());

    $console.info('Status:', `${x.statusText || 'OK'} (${x.status})`);
    
    $console.groupEnd();

    return x;
  });
}
```

## Development

1. Clone this repository
2. Install dependencies using `yarn install` or `npm install`
3. Start development server using `yarn dev` or `npm run dev`

## Todo

* [ ] error stack trace correction
* [x] module separation

## License

[MIT License](./LICENSE)

Copyright (c) Mohammad Saleh Fadaei ([@ms-fadaei](https://github.com/ms-fadaei))

<!-- Badges -->
[npm-version-src]: https://img.shields.io/npm/v/nuxt-browser-console/latest.svg
[npm-version-href]: https://npmjs.com/package/nuxt-browser-console

[npm-downloads-src]: https://img.shields.io/npm/dt/nuxt-browser-console.svg
[npm-downloads-href]: https://npmjs.com/package/nuxt-browser-console

[github-actions-ci-src]: https://github.com/ms-fadaei/nuxt-browser-console/workflows/ci/badge.svg
[github-actions-ci-href]: https://github.com/ms-fadaei/nuxt-browser-console/actions?query=workflow%3Aci

[codecov-src]: https://img.shields.io/codecov/c/github/ms-fadaei/nuxt-browser-console.svg
[codecov-href]: https://codecov.io/gh/ms-fadaei/nuxt-browser-console

[license-src]: https://img.shields.io/npm/l/nuxt-browser-console.svg
[license-href]: https://npmjs.com/package/nuxt-browser-console

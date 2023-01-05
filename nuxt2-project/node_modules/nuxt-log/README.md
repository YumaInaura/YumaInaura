# nuxt-log

> A logger module for Nuxt.js using [vuejs-logger](https://github.com/justinkames/vuejs-logger)

## Setup
- Add `nuxt-log` dependency using yarn or npm to your project
- Add `nuxt-log` to `modules` section of `nuxt.config.js`

```js
const logOptions = {
  // optional : defaults to true if not specified
  isEnabled: true,
  // required ['debug', 'info', 'warn', 'error', 'fatal']
  logLevel : 'debug',
  // optional : defaults to false if not specified
  stringifyArguments : false,
  // optional : defaults to false if not specified
  showLogLevel : false,
  // optional : defaults to false if not specified
  showMethodName : false,
  // optional : defaults to '|' if not specified
  separator: '|',
  // optional : defaults to false if not specified
  showConsoleColors: false
}

{
  modules: [
   ['nuxt-log', logOptions],
  ]
}
```

## Usage
You can use **$log** in almost any context using `app.$log` or `this.$log`.

See [vuejs-logger official docs](https://github.com/justinkames/vuejs-logger) for more usage information.

```js
export default {
  data() {
    return {
      a: 'a',
      b: 'b',
    };
  },
  created() {
    this.$log.debug('test', this.a, 123);
    this.$log.info('test', this.b);
    this.$log.warn('test');
    this.$log.error('test');
    this.$log.fatal('test');
  },
};
```

## License

[MIT License](./LICENSE)

Copyright (c) webcore-it

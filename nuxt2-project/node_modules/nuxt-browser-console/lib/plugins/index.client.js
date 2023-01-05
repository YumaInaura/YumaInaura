// get the options out using lodash templates
const options = JSON.parse('<%= JSON.stringify(options) %>')
const { namespace = 'console' } = options

export default function (context, inject) {
  const browserConsole = console

  // retrieve logs from nuxt global object
  if (window.__NUXT__?.serverReports) {
    window.__NUXT__.serverReports.forEach((log) => {
      browserConsole[log.type](...log.args)
    })
    delete window.__NUXT__.serverReports
  }

  // attach logger to the context
  context[`$${namespace}`] = browserConsole
  inject(namespace, browserConsole)
}

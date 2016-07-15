# karma-webview-launcher

> OS WebView launcher for [Karma](https://github.com/karma-runner/karma)

This plugin allows you to use a webview based app as a browser launcher.
Currently it support OSX WebView (not WKWebView) only.

## Installation

Install using

```bash
$ npm install karma-webview-launcher --save-dev
```

## Configuration

```js
// karma.conf.js
module.exports = function(config) {
  config.set({
    browsers: ['WebView']
  })
}
```

You can pass list of browsers as a CLI argument too:

```bash
$ karma start --browsers WebView
```

With extra options:

```js
// karma.conf.js
module.exports = function(config) {
  config.set({
    browsers: ['WebView'],
    webviewOpts: {
      show: true/false, // or `hide: false/true`
      minimized: true/false // only work when show is true or hide is false
      skipTaskbar: true/false // or `showDockIcon: false/true`
    }
  })
}
```

Run in a 'headless' like mode by make it hidden without dock icon:

```js
// karma.conf.js
module.exports = function(config) {
  config.set({
    browsers: ['WebView'],
    webviewOpts: {
      show: false, // or `hide: true`
      skipTaskbar: true // or `showDockIcon: false`
    }
  })
}
```


----

For more information on Karma see the [homepage].

[homepage]: http://karma-runner.github.com

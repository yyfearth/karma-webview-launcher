var WebViewBrowser = function (baseBrowserDecorator) {
  baseBrowserDecorator(this)

  this._getOptions = function (url) {
    return [url]
  }
}

WebViewBrowser.prototype = {
  name: 'WebView',

  DEFAULT_CMD: {
    darwin: __dirname + '/osx/build/Release/WebViewApp.app/Contents/MacOS/WebViewApp'
  },
  ENV_CMD: 'WEBVIEW_BIN'
};

WebViewBrowser.$inject = ['baseBrowserDecorator']

// PUBLISH DI MODULE
module.exports = {
  'launcher:WebView': ['type', WebViewBrowser]
}

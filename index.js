var WebViewBrowser = function (baseBrowserDecorator, webviewOpts) {
  baseBrowserDecorator(this)
  webviewOpts = webviewOpts || {}

  this._getOptions = function (url) {
    var opts = []
    if (webviewOpts.hide || webviewOpts.show === false) {
      opts.push('-hide')
    }
    if (webviewOpts.minimized) {
      opts.push('-minimized')
    }
    if (webviewOpts.skipTaskbar || webviewOpts.showDockIcon === false) {
      opts.push('-no-dock-icon')
    }
    if (webviewOpts.userAgent) {
      opts.push('-customUA', webviewOpts.userAgent)
    }
    else if (webviewOpts.appendUserAgent) {
      opts.push('-appendUA', webviewOpts.appendUserAgent)
    }
    opts.push(url)
    return opts
  }
}

WebViewBrowser.prototype = {
  name: 'webview',

  DEFAULT_CMD: {
    darwin: __dirname + '/osx/build/Release/WebViewApp.app/Contents/MacOS/WebViewApp'
  },
  ENV_CMD: 'WEBVIEW_BIN'
};

WebViewBrowser.$inject = ['baseBrowserDecorator', 'config.webviewOpts']

// PUBLISH DI MODULE
module.exports = {
  'launcher:WebView': ['type', WebViewBrowser]
}

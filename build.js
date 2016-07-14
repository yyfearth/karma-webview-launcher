#!/usr/bin/env node
(function () {
  var path = require('path'),
    proc = require('child_process')

  if (process.platform === 'darwin') {
    console.info('build osx webview app');
    var child = proc.spawn('xcodebuild', ['clean', 'build'], {
      cwd: path.join(__dirname, 'osx')
    })
    child.stdout.pipe(process.stdout)
    child.stderr.pipe(process.stderr)
    child.stdin.pipe(process.stdin)
    child.on('close', function (code) {
      process.exit(code)
    })
  }

}())

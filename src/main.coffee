'use strict'

electron = require 'electron'
app = electron.app
BrowserWindow = electron.BrowserWindow

createWindow = ->
  # mainWindow = new BrowserWindow {fullscreen: true}
  mainWindow = new BrowserWindow {width: 800, height: 600}

  mainWindow.setMenuBarVisibility false

  mainWindow.loadURL 'file://' + __dirname + '/index.html'

  mainWindow.webContents.openDevTools()

  mainWindow.on 'closed', ->
    mainWindow = null

app.on 'ready', createWindow

app.on 'window-all-closed', ->
  if process.platform != 'darwin'
    app.quit();

app.on 'activate', ->
  if mainWindow == null
    createWindow();

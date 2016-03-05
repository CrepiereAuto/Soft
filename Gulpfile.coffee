gulp = require 'gulp'
del = require 'del'
copy = require 'gulp-copy'
electron = require 'gulp-run-electron'
replace = require 'gulp-replace'
install = require 'gulp-install'
sequence = require 'gulp-sequence'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
plumber =  require 'gulp-plumber'
electronPckg = require 'gulp-atom-electron'

gulp.task 'default', (cb) ->
  sequence 'build', 'start', 'watch', cb

gulp.task 'build', (cb) ->
  sequence 'clean:build', ['modules', 'assets', 'app', 'main'], cb

gulp.task 'dev', (cb) ->
  sequence ['assets', 'app', 'main'], 'start', 'watch', cb

gulp.task 'start', ->
  gulp.src 'build'
    .pipe electron()

gulp.task 'compile', (cb) ->
  sequence 'clean:dist', 'dist', cb

gulp.task 'watch', ->
  gulp.watch ['package.json'], ['build', electron.rerun]
  gulp.watch ['src/assets/**/*'], ['assets', electron.rerun]
  gulp.watch ['src/app/**/*.coffee'], ['app', electron.rerun]
  gulp.watch ['src/main.coffee'], ['main', electron.rerun]

gulp.task 'clean:build', ->
  del 'build'

gulp.task 'clean:dist', ->
  del 'dist'

gulp.task 'assets', ->
  gulp.src 'src/assets/**/*.*'
    .pipe copy 'build', {prefix: 2}

gulp.task 'app', ['app:view', 'app:lib'], ->
  gulp.src 'src/app/app.coffee'
    .pipe plumber()
    .pipe coffee {bare: true}
    .pipe gulp.dest 'build/js/'

gulp.task 'app:lib', ->
  gulp.src 'src/app/lib/*.coffee'
    .pipe plumber()
    .pipe coffee {bare: true}
    .pipe gulp.dest 'build/js/lib/'

gulp.task 'app:view', ->
  gulp.src 'src/app/view/*.coffee'
    .pipe plumber()
    .pipe coffee {bare: true}
    .pipe concat 'view.js'
    .pipe gulp.dest 'build/js'

gulp.task 'main', ->
  gulp.src 'src/main.coffee'
    .pipe coffee {bare: true}
    .pipe gulp.dest 'build'

gulp.task 'package', ->
  gulp.src 'package.json'
    .pipe replace 'build/js/main.js', 'js/main.js'
    .pipe gulp.dest 'build'

gulp.task 'modules', ['package'], ->
  gulp.src 'build/package.json'
    .pipe install {production: true}

gulp.task 'dist', ['build'], ->
  gulp.src 'build/**'
    .pipe electronPckg {version: '0.36.8', platform: 'linux', arch: 'arm'}
    .pipe gulp.dest 'dist'

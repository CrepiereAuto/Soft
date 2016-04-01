var gulp = require('gulp');
  del = require('del');
  copy = require('gulp-copy');
  electron = require('gulp-run-electron');
  replace = require('gulp-replace');
  install = require('gulp-install');
  sequence = require('gulp-sequence');
  concat = require('gulp-concat');
  coffee = require('gulp-coffee');
  plumber = require('gulp-plumber');
  electronPckg = require('gulp-atom-electron');
  zip = require('gulp-zip');
  stylus = require('gulp-stylus');
  flatten = require('gulp-flatten');

gulp.task('default', function(cb) {
  return sequence('build', 'start', 'watch', cb);
});

gulp.task('build', function(cb) {
  return sequence('clean:build', ['modules', 'assets', 'app', 'main'], cb);
});

gulp.task('dev', function(cb) {
  return sequence(['assets', 'app', 'main'], 'start', 'watch', cb);
});

gulp.task('start', function() {
  return gulp.src('build').pipe(electron());
});

gulp.task('compile', function(cb) {
  return sequence('clean:dist', 'dist', cb);
});

gulp.task('make', function(cb) {
  return sequence('build', 'compile', 'compress', cb);
});

gulp.task('update', function(cb) {
  return sequence('pull', 'make', cb);
});

gulp.task('watch', function() {
  gulp.watch(['package.json'], ['build', electron.rerun]);
  gulp.watch(['src/assets/**/*'], ['assets', electron.rerun]);
  gulp.watch(['src/app/**/*.coffee', 'src/app/**/*.styl', 'src/app/**/*.html'], ['app', electron.rerun]);
  gulp.watch(['src/main.coffee'], ['main', electron.rerun]);
});

gulp.task('clean:build', function() {
  return del('build');
});

gulp.task('clean:dist', function() {
  return del('dist');
});

gulp.task('assets', function() {
  return gulp.src('src/assets/**/*.*').pipe(copy('build', {
    prefix: 2
  }));
});

gulp.task('app', ['app:coffee', 'app:styl', 'app:html']);

gulp.task('app:coffee', function() {
  return gulp.src('src/app/**/*.coffee')
    .pipe(plumber())
    .pipe(coffee({bare: true}))
    .pipe(concat('app.js'))
    .pipe(gulp.dest('build/js/'));
});

gulp.task('app:styl', function() {
  return gulp.src('src/app/**/*.styl')
    .pipe(plumber())
    .pipe(stylus())
    .pipe(concat('app.css'))
    .pipe(gulp.dest('build/css/'));
});

gulp.task('app:html', function() {
  return gulp.src('src/app/**/*.html')
    .pipe(plumber())
    .pipe(flatten())
    .pipe(gulp.dest('build/views/'));
});

// gulp.task('app', ['app:view', 'app:lib'], function() {
//   return gulp.src('src/app/app.coffee').pipe(plumber()).pipe(coffee({
//     bare: true
//   })).pipe(gulp.dest('build/js/'));
// });
//
// gulp.task('app:lib', function() {
//   return gulp.src('src/app/lib/*.coffee').pipe(plumber()).pipe(coffee({
//     bare: true
//   })).pipe(gulp.dest('build/js/lib/'));
// });
//
// gulp.task('app:view', function() {
//   return gulp.src('src/app/view/*.coffee').pipe(plumber()).pipe(coffee({
//     bare: true
//   })).pipe(concat('view.js')).pipe(gulp.dest('build/js'));
// });

gulp.task('main', function() {
  return gulp.src('src/main.coffee').pipe(coffee({
    bare: true
  })).pipe(gulp.dest('build'));
});

gulp.task('package', function() {
  return gulp.src('package.json').pipe(replace('build/js/main.js', 'js/main.js')).pipe(gulp.dest('build'));
});

gulp.task('modules', ['package'], function() {
  return gulp.src('build/package.json').pipe(install({
    production: true
  }));
});

gulp.task('dist', ['build'], function() {
  return gulp.src('build/**').pipe(electronPckg({
    version: '0.36.10',
    platform: 'linux',
    arch: 'arm'
  })).pipe(gulp.dest('dist'));
});

gulp.task('compress', function() {
  return gulp.src('dist/**').pipe(zip('SoftPI.zip')).pipe(gulp.dest(''));
});

module.exports = gulp;

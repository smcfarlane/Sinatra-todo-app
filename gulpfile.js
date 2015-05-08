var gulp = require('gulp');
var sass = require('gulp-ruby-sass');
var concat = require('gulp-concat');
var bower = require('gulp-bower');

dirs = {
  "source_scss": "./assets/sass",
  "source_js": "./assets/js/*.js",
  "dest_css": "./app/public/css",
  "dest_js": "./app/public/js/"
}

gulp.task('sass', function () {
    return sass(dirs.source_scss + '/main.scss', {bundleExec: true})
        .on('error', function (err) {
            console.error('Error!', err.message);
        })
        .pipe(gulp.dest(dirs.dest_css));
});

gulp.task('scripts', function() {
  return gulp.src("./assets/js/*.js")
    .pipe(concat('app.js'))
    .pipe(gulp.dest("./app/public/js/"));
});

gulp.task('bower', function() {
  return bower('./my_bower_components')
    .pipe(gulp.dest('lib/'))
});

gulp.task('watch', function() {
  gulp.watch(dirs.source_scss, ['sass']);
  gulp.watch(dirs.source_js, ['scripts']);
});

gulp.task('default', ['watch', 'scripts', 'sass'])

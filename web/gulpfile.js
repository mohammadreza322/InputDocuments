const gulp = require("gulp")
const cssmin = require("gulp-cssmin")
const merge = require("merge-stream")
const javascriptObfuscator = require('gulp-javascript-obfuscator');
const obfuscate = require('gulp-obfuscate');
const fs = require("fs");

function uglifyJs() {
    return gulp.src("build/web/**/*.js").pipe(javascriptObfuscator({compact: true})).pipe(gulp.dest('build/web/dist'))
}

function compressCss() {
    return gulp.src('build/web/**/*.css').pipe(cssmin()).pipe(gulp.dest("dist/public/css"))
}
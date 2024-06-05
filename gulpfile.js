const gulp = require("gulp")
const ts = require("gulp-typescript")
const tsProject = ts.createProject("tsconfig.json")
const uglify = require("gulp-uglify")
const cssmin = require("gulp-cssmin")
const merge = require("merge-stream");
const flatmap = require('gulp-flatmap');
const path = require('path');
const closureCompiler = require('google-closure-compiler').gulp();
const javascriptObfuscator = require('gulp-javascript-obfuscator');
const obfuscate = require('gulp-obfuscate');
// const del = require("del");
const fs = require("fs");

function uglifyJs() {
    return gulp.src("dist/**/*.js")
        .pipe(javascriptObfuscator({compact: true}))
        .pipe(gulp.dest('dist'))

}

function compressJs() {
    return gulp.src("dist/**/*.js")
        // .pipe(flatmap(function (stream,file) {
        //     return stream.pipe(javascriptObfuscator({
        //         identifierNamesCache: {},
        //         numbersToExpressions:true,
        //         optionsPreset:'high-obfuscation',
        //         splitStrings:true
        //     }))
        // }))
        .pipe(obfuscate({ replaceMethod: obfuscate.ZALGO }))
        .pipe(gulp.dest('dist'))
}

function compressCss() {
    return gulp.src('dist/public/css/**/*.css').pipe(cssmin()).pipe(gulp.dest("dist/public/css"))
}

function copyStatics() {
    return merge([
        gulp.src("src/views/**/*.ejs").pipe(gulp.dest("dist/views")),
        gulp.src("src/public/css/**/*.css").pipe(gulp.dest("dist/public/css")),
        gulp.src("src/public/fonts/**/*.ttf").pipe(gulp.dest("dist/public/fonts")),
        gulp.src("src/public/fonts/**/*.woff").pipe(gulp.dest("dist/public/fonts")),
        gulp.src("src/public/fonts/**/*.woff2").pipe(gulp.dest("dist/public/fonts")),
        gulp.src("src/public/js/**/*.js").pipe(gulp.dest("dist/public/js")),
        gulp.src("src/public/photo/**/*.png").pipe(gulp.dest("dist/public/photo")),
        gulp.src("src/public/photo/**/*.svg").pipe(gulp.dest("dist/public/photo")),
    ])

}

function compileTypescript() {
    return tsProject.src().pipe(tsProject()).js.pipe(gulp.dest("dist"))
}

async function clean(cb) {
    return await fs.rm('dist',{ recursive: true }, () => {
        cb()
        return true;
    })

}

exports.default = gulp.series(clean,compileTypescript, copyStatics, gulp.parallel(compressCss, uglifyJs))
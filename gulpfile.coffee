gulp = require 'gulp'
coffee = require 'gulp-coffee'
watch = require 'gulp-watch'

gulp.task 'coffee', ->
	gulp.src 'source/**/*.coffee'
		.pipe watch 'source/**/*.coffee'
		.pipe coffee bare: true
		.pipe gulp.dest 'build/'

gulp.task 'default', ['coffee']
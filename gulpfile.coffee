gulp = require 'gulp'
coffee = require 'gulp-coffee'

gulp.task 'coffee', ->
	gulp.src 'source/**/*.coffee'
		.pipe coffee bare: true
		.pipe gulp.dest 'build/'

gulp.task 'watch', ->
	gulp.watch 'source/**/*.coffee', ['coffee']

gulp.task 'default', ['coffee']
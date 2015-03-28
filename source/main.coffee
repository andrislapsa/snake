requirejs.config
	baseUrl: 'build'
	paths:
		underscore: '../vendor/underscore'
		backbone: '../vendor/backbone'
		jquery: '../vendor/jquery'

define (require) ->
	underscore = require 'underscore'
	$ = require 'jquery'
	GameView = require 'views/game'

	gameInstance = new GameView el: $ 'body > canvas'
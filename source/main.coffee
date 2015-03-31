requirejs.config
	baseUrl: 'build'
	paths:
		underscore: '../vendor/underscore'
		backbone: '../vendor/backbone'
		jquery: '../vendor/jquery'

define (require) ->
	GameView = require 'views/game'

	window.gameInstance = new GameView
		el: window
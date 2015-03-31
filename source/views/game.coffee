define (require) ->
	Backbone = require 'backbone'
	AssetView = require 'views/asset'
	SnakeView = require 'views/snake'
	SnakeModel = require 'models/snake'
	$ = require 'jquery'

	class GameView extends Backbone.View

		events:
			'keydown': 'changeSnakeDirection'
			'blur': 'lostFocus'

		initialize: ->
			@canvas = @el.querySelector '#game'

			$(window).blur =>
				@pause true

			$(window).focus =>
				@pause false

			@assets = new AssetView
				el: @el.querySelector '#assets'
				gridSize: @calculateGridSize()

			snakeModel = new SnakeModel
				position:
					x: 20
					y: 20
				direction: 'down'

			@snake = new SnakeView
				model: snakeModel
				context: @canvas.getContext '2d'
				assets: @assets

			@speed = 100

			@pause false

		calculateGridSize: ->
			@size =
				width: @canvas.width / 50
				height: @canvas.height / 50

		changeSnakeDirection: (e) ->
			@snake.model.changeDirection e.keyCode

		loop: =>
			if !@loopTimer
				@loopTimer = setInterval @loop, @speed

			@snake.model.move()
			@snake.render()

		pause: (pause) =>
			if pause
				clearTimeout @loopTimer
				@loopTimer = null
			else
				@loop()
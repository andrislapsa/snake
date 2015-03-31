define (require) ->
	Backbone = require 'backbone'
	AssetView = require 'views/asset'
	SnakeView = require 'views/snake'
	SnakeModel = require 'models/snake'

	class GameView extends Backbone.View

		events:
			'keydown': 'changeSnakeDirection'

		initialize: ->
			@canvas = @el.querySelector '#game'

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

			@speed = 300

			@loopTimer = setInterval @loop, @speed

		calculateGridSize: ->
			@size =
				width: @canvas.width / 50
				height: @canvas.height / 50

		changeSnakeDirection: (e) ->
			@snake.model.changeDirection e.keyCode

		loop: =>
			@snake.model.move()
			@snake.render()
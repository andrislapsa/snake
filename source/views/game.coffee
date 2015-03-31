define (require) ->
	Backbone = require 'backbone'
	RendererView = require 'views/renderer'
	SnakeView = require 'views/snake'
	SnakeModel = require 'models/snake'

	class GameView extends Backbone.View

		events:
			'keydown': 'changeSnakeDirection'
			'blur': 'pause'
			'focus': 'unpause'

		initialize: ->
			rendererView = new RendererView
				assetsContext: @el.document.querySelector('#assets').getContext '2d'
				gameContext: @el.document.querySelector('#game').getContext '2d'

			snakeModel = new SnakeModel
				position:
					x: 20
					y: 20
				direction: 'down'

			@snake = new SnakeView
				model: snakeModel
				renderer: rendererView

			@speed = 100

			@unpause()

		changeSnakeDirection: (e) ->
			@snake.model.changeDirection e.keyCode

		loop: =>
			if !@loopTimer
				@loopTimer = setInterval @loop, @speed

			@snake.model.move()
			@snake.render()

		pause: =>
			clearTimeout @loopTimer
			@loopTimer = null

		unpause: =>
			@loop()
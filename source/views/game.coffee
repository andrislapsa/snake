define (require) ->
	Backbone = require 'backbone'
	RendererView = require 'views/renderer'
	SnakeView = require 'views/snake'
	SnakeModel = require 'models/snake'

	class GameView extends Backbone.View

		events:
			'keydown': 'storeDirectionKeyStrokes'
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

			@keystrokes = []

			@unpause()

		storeDirectionKeyStrokes: (e) ->
			KEY_BINDINGS =
				37: 'left'
				38: 'up'
				39: 'right'
				40: 'down'

			return if !KEY_BINDINGS[e.keyCode]

			@keystrokes.push KEY_BINDINGS[e.keyCode]
			@keystrokes = @keystrokes.splice 0, 2
			console.log 'keystrokes', @keystrokes

		loop: =>
			if !@loopTimer
				@loopTimer = setInterval @loop, @speed

			if @keystrokes.length
				@snake.model.changeDirection @keystrokes.shift()
			@snake.model.move()
			@snake.render()

		pause: =>
			clearTimeout @loopTimer
			@loopTimer = null

		unpause: =>
			@loop()
define (require) ->
	Backbone = require 'backbone'
	AssetView = require 'views/asset'
	SectionView = require 'views/section'

	class GameView extends Backbone.View

		events:
			'keydown': 'changeDirection'

		initialize: ->
			@canvas = @el.querySelector '#game'

			@assets = new AssetView
				el: @el.querySelector '#assets'
				gridSize: @calculateGridSize()

			@section = new SectionView
				context: @canvas.getContext '2d'
				assets: @assets
				position:
					x: 20
					y: 20
				gridSize: @calculateGridSize()
				direction: 'right'

			@speed = 100

			window.test = @section

			window.gameTimer = setInterval @loop, @speed

			window.loopCount = 0

		calculateGridSize: ->
			@size =
				width: @canvas.width / 50
				height: @canvas.height / 50

		changeDirection: (e) ->
			KEY_BINDINGS =
				37: 'left'
				38: 'up'
				39: 'right'
				40: 'down'

			@section.direction = KEY_BINDINGS[e.keyCode]

		loop: =>
			@section.move()
			@section.render()
			loopCount++

			if false && loopCount > 5
				clearTimeout window.gameTimer
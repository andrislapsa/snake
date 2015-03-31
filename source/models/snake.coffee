define (require) ->
	Backbone = require 'backbone'

	class SnakeModel extends Backbone.Model

		initialize: (params) ->
			@set 'position', params.position
			@set 'size', params.gridSize

		changeDirection: (keyCode) ->
			KEY_BINDINGS =
				37: 'left'
				38: 'up'
				39: 'right'
				40: 'down'

			@set 'direction', KEY_BINDINGS[keyCode]

		move: ->
			position = @get 'position'
			size = @get 'size'

			switch @get 'direction'
				when 'left' then position.x--
				when 'up' then position.y--
				when 'right' then position.x++
				when 'down' then position.y++

			@set 'position', position
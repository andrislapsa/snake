define (require) ->
	Backbone = require 'backbone'

	class FoodModel extends Backbone.Model

		initialize: (params) ->
			@gridBoundaries = params.gridBoundaries
			@snakeModel = params.snakeModel

		getRandomLocation: ->
			return {
				x: Math.floor(Math.random() * @gridBoundaries.width)
				y: Math.floor(Math.random() * @gridBoundaries.height)
			}

		spawn: ->
			loop
				randomLocation = @getRandomLocation()
				if !@snakeModel.positionIsInSnakeBody(randomLocation)
					break

			@set 'position', randomLocation

		getPosition: ->
			return @get 'position'
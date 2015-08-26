define (require) ->
	Backbone = require 'backbone'

	class FoodModel extends Backbone.Model

		initialize: (params) ->
			@gridBoundaries = params.gridBoundaries

		getRandomLocation: ->
			return {
				x: Math.floor(Math.random() * @gridBoundaries.width)
				y: Math.floor(Math.random() * @gridBoundaries.height)
			}

		# TODO: shouldn't be completely random position, we don't want to spawn food on snake
		spawn: ->
			@set 'position', @getRandomLocation()
			console.log "spawned at", @getPosition()

		getPosition: ->
			return @get 'position'
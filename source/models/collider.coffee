define (require) ->
	Backbone = require 'backbone'
	_ = require 'underscore'

	class ColliderModel extends Backbone.Model

		initialize: (params) ->
			@bounds = params.gridBoundaries

		positionsMatch: (position1, position2) ->
			return position1.x == position2.x && position1.y == position2.y

		positionOutOfBounds: (position) ->
			if position.x < 0 || position.y < 0
				return true

			if position.x > @bounds.width || position.y > @bounds.height
				return true

		positionInArray: (position, array) ->
			for item in array
				if @positionsMatch position, item
					return true

			return false
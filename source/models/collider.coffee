define (require) ->
	Backbone = require 'backbone'

	class ColliderModel extends Backbone.Model

		positionsMatch: (position1, position2) ->
			return position1.x == position2.x && position1.y == position2.y 
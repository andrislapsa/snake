define (require) ->
	Backbone = require 'backbone'

	class SnakeView extends Backbone.View

		initialize: (params) ->
			@assets = params.assets
			@context = params.context

		render: ->
			position = @model.get 'position'

			@assets.transferToCanvas(
				context: @context
				x: position.x
				y: position.y
				direction: @model.get 'direction'
			)
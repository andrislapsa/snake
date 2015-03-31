define (require) ->
	Backbone = require 'backbone'

	class SnakeView extends Backbone.View

		initialize: (params) ->
			@assets = params.assets
			@context = params.context
			@drawingFirstPiece = true

		render: ->
			head = @model.getHead()

			if @model.get('body').length > 20
				tail = @model.eraseTail()
				console.log 'tail', tail
				
				@assets.clearTail(
					context: @context
					x: tail.x
					y: tail.y
				)

			@model.logBody()

			@assets.drawHead(
				firstPiece: @drawingFirstPiece
				context: @context
				x: head.x
				y: head.y
				direction: @model.get 'direction'
			)

			@drawingFirstPiece = false
define (require) ->
	Backbone = require 'backbone'

	class SnakeView extends Backbone.View

		initialize: (params) ->
			@renderer = params.renderer

		render: ->
			head = @model.getHead()

			if @model.get('body').length > 20
				tail = @model.eraseTail()
				
				@renderer.clearTail
					x: tail.x
					y: tail.y

			# @model.logBody()

			@renderer.drawHead
				x: head.x
				y: head.y
				direction: @model.get 'direction'
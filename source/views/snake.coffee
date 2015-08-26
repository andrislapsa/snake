define (require) ->
	Backbone = require 'backbone'

	class SnakeView extends Backbone.View

		initialize: (params) ->
			@renderer = params.renderer

		render: ->
			head = @model.getHeadPosition()

			if @model.get('body').length > @model.get('bodySize')
				tail = @model.eraseTail()
				
				@renderer.clearPosition
					x: tail.x
					y: tail.y

			@model.logBody()

			@renderer.drawHead
				x: head.x
				y: head.y
				direction: @model.get 'direction'
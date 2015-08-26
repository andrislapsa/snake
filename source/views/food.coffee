define (require) ->
	Backbone = require 'backbone'

	class FoodView extends Backbone.View

		initialize: (params) ->
			@renderer = params.renderer
			@spawn()

		spawn: ->
			@model.spawn()
			@render()

		erase: ->
			@renderer.clearPosition @model.getPosition()

		render: ->
			@renderer.drawFood @model.getPosition()
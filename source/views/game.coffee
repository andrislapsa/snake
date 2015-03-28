define (require) ->
	Backbone = require 'backbone'

	class GameView extends Backbone.View

		initialize: ->
			console.log 'testsss2'

	return GameView
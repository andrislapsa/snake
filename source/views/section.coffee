define (require) ->
	Backbone = require 'backbone'

	class SectionView extends Backbone.View

		initialize: (params) ->
			@assets = params.assets
			@context = params.context
			@size = params.gridSize
			@position = params.position
			@direction = params.direction

		move: ->
			switch @direction
				when 'left' then @position.x -= @size.width
				when 'up' then @position.y -= @size.height
				when 'right' then @position.x += @size.width
				when 'down' then @position.y += @size.height

		render: ->
			longPieceMeta = @assets.data['longPiece']

			@context.drawImage(
				@assets.context.canvas
				longPieceMeta.position.x
				longPieceMeta.position.y
				longPieceMeta.size.width
				longPieceMeta.size.height
				@position.x
				@position.y
				@size.width
				@size.height
			)
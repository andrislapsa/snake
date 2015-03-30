define (require) ->
	Backbone = require 'backbone'

	class AssetView extends Backbone.View

		initialize: (params) ->
			@size = params.gridSize
			@context = @el.getContext '2d'

			@position =
				x: 0
				y: 0

			@data = []
			@data['longPiece'] = @drawLongPiece()
			@data['cornerPiece'] = @drawCornerPiece()
			console.log @data

		getCurrentPosition: ->
			return {
				x: @position.x
				y: @position.y
			}

		getImageData: (key) ->
			meta = @data[key]
			@context.getImageData(
				meta.position.x
				meta.position.y
				meta.size.width
				meta.size.height
			)

		drawLongPiece: ->
			position = @getCurrentPosition()
			size = @size
			console.log 'long piece position', position

			@context.fillRect(
				@position.x
				@position.y + 1
				@size.width
				@size.height - 2
			)

			# update position to mark this place as used
			@position.x += @size.width

			return {
				position: position
				size: size
			}

		drawCornerPiece: ->
			position = @getCurrentPosition()
			size = @size

			@context.fillStyle = 'rgb(200, 0, 0)'
			@context.fillRect(
				@position.x
				@position.y + 1
				@size.width - 1
				@size.height - 2
			)

			@context.fillStyle = 'rgb(0, 200, 0)'
			@context.fillRect(
				@position.x + 1
				@position.y + @size.height - 1
				@size.width - 2
				1
			)

			# update position to mark this place as used
			@position.x += @size.width
			return {
				position: position
				size: size
			}


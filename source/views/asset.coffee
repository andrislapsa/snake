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
			@data['horizontalPiece'] = @drawHorizontalPiece()
			@data['verticalPiece'] = @drawVerticalPiece()

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

		drawHorizontalPiece: ->
			position = @getCurrentPosition()
			size = @size

			@context.fillRect(
				@position.x
				@position.y
				@size.width
				@size.height - 1
			)

			# update position to mark this place as used
			@position.x += @size.width

			return {
				position: position
				size: size
			}

		drawVerticalPiece: ->
			position = @getCurrentPosition()
			size = @size

			@context.fillRect(
				@position.x
				@position.y
				@size.width - 1
				@size.height
			)

			# update position to mark this place as used
			@position.x += @size.width

			return {
				position: position
				size: size
			}

		calculateGridToPixels: (gridPosition) ->
			return {
				x: gridPosition.x * @size.width
				y: gridPosition.y * @size.height
			}

		drawHead: (params) ->
			orientation = if ['up', 'down'].indexOf(params.direction) > -1 then 'vertical' else 'horizontal'
			pieceData = @data[orientation + 'Piece']

			destinationPosition = @calculateGridToPixels
				x: params.x
				y: params.y

			if params.direction == 'right' && !params.firstPiece
				destinationPosition.x--

			if params.direction == 'down' && !params.firstPiece
				destinationPosition.y--

			params.context.drawImage(
				@context.canvas
				pieceData.position.x
				pieceData.position.y
				pieceData.size.width
				pieceData.size.height
				destinationPosition.x
				destinationPosition.y
				@size.width
				@size.height
			)

		clearTail: (params) ->
			destinationPosition = @calculateGridToPixels
				x: params.x
				y: params.y

			params.context.clearRect(
				destinationPosition.x
				destinationPosition.y
				@size.width
				@size.height
			)

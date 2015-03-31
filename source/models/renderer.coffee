define (require) ->
	Backbone = require 'backbone'

	class RendererModel extends Backbone.Model

		initialize: (params) ->
			@set 'position', { x: 0, y: 0 }
			@set 'assets', []

		calculateGridSize: (size) ->
			return @gridSize if @gridSize

			@gridSize = 
				width: size.width / 50
				height: size.height / 50

		calculateGridToPixels: (gridPosition) ->
			return {
				x: gridPosition.x * @gridSize.width
				y: gridPosition.y * @gridSize.height
			}

		allocateAsset: (name, size) ->
			position = @get 'position'
			positionForAsset = { x: position.x, y: position.y }
			
			position.x += size.width
			position.y += size.height

			@get('assets')[name] =
				size: size
				position: positionForAsset

			return positionForAsset

		getAsset: (name) ->
			return @get('assets')[name]

		calculateHeadDestinationPosition: (params) ->
			destinationPosition = @calculateGridToPixels
				x: params.x
				y: params.y

			if params.direction == 'right' && !params.drawingFirstPiece
				destinationPosition.x--

			if params.direction == 'down' && !params.drawingFirstPiece
				destinationPosition.y--

			destinationPosition
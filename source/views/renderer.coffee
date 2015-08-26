define (require) ->
	Backbone = require 'backbone'
	RendererModel = require 'models/renderer'

	class RendererView extends Backbone.View

		initialize: (params) ->
			@assetsContext = params.assetsContext
			@gameContext = params.gameContext

			@model = new RendererModel

			@gridSize = @model.calculateGridSize
				width: @gameContext.canvas.width
				height: @gameContext.canvas.height

			@gridBoundaries = @model.calculateGridBoundaries
				width: @gameContext.canvas.width
				height: @gameContext.canvas.height

			@drawHorizontalPieceAsset()
			@drawVerticalPieceAsset()
			@drawFoodAsset()

			@drawingFirstPiece = true

		drawHorizontalPieceAsset: ->
			position = @model.allocateAsset 'horizontalPiece', @gridSize

			@assetsContext.fillRect(
				position.x
				position.y
				@gridSize.width
				@gridSize.height - 1
			)

		drawVerticalPieceAsset: ->
			position = @model.allocateAsset 'verticalPiece', @gridSize

			@assetsContext.fillRect(
				position.x
				position.y
				@gridSize.width - 1
				@gridSize.height
			)

		drawFoodAsset: ->
			position = @model.allocateAsset 'food', @gridSize
			path = new Path2D()
			radius = @gridSize.width / 2
			startAngle = 0
			endAngle = Math.PI * 2

			path.arc(
				position.x + radius,
				position.y + radius,
				radius,
				startAngle,
				endAngle
			)

			@assetsContext.fillStyle = 'red'
			@assetsContext.fill path

		drawHead: (params) ->
			orientation = if ['up', 'down'].indexOf(params.direction) > -1 then 'vertical' else 'horizontal'
			pieceData = @model.getAsset "#{orientation}Piece"

			if @drawingFirstPiece
				params.drawingFirstPiece = true
				@drawingFirstPiece = false

			destinationPosition = @model.calculateHeadDestinationPosition params

			@gameContext.drawImage(
				@assetsContext.canvas
				pieceData.position.x
				pieceData.position.y
				pieceData.size.width
				pieceData.size.height
				destinationPosition.x
				destinationPosition.y
				@gridSize.width
				@gridSize.height
			)

		drawFood: (params) ->
			params = @model.calculateGridToPixels params
			asset = @model.getAsset "food"

			@gameContext.drawImage(
				@assetsContext.canvas
				asset.position.x
				asset.position.y
				asset.size.width
				asset.size.height
				params.x
				params.y
				@gridSize.width
				@gridSize.height
			)

		clearPosition: (params) ->
			destinationPosition = @model.calculateGridToPixels
				x: params.x
				y: params.y

			@gameContext.clearRect(
				destinationPosition.x
				destinationPosition.y
				@gridSize.width
				@gridSize.height
			)

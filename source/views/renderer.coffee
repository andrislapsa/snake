define (require) ->
	Backbone = require 'backbone'
	RendererModel = require 'models/renderer'

	class RendererView extends Backbone.View

		initialize: (params) ->
			@assetsContext = params.assetsContext
			@gameContext = params.gameContext

			@model = new RendererModel

			@size = @model.calculateGridSize
				width: @gameContext.canvas.width
				height: @gameContext.canvas.height

			@drawHorizontalPieceAsset()
			@drawVerticalPieceAsset()
			@drawFoodAsset()

			@drawingFirstPiece = true

		drawHorizontalPieceAsset: ->
			position = @model.allocateAsset 'horizontalPiece', @size

			@assetsContext.fillRect(
				position.x
				position.y
				@size.width
				@size.height - 1
			)

		drawVerticalPieceAsset: ->
			position = @model.allocateAsset 'verticalPiece', @size

			@assetsContext.fillRect(
				position.x
				position.y
				@size.width - 1
				@size.height
			)

		drawFoodAsset: ->
			position = @model.allocateAsset 'food', @size
			path = new Path2D()
			radius = @size.width / 2
			position.x += radius
			position.y += radius
			startAngle = 0
			endAngle = Math.PI * 2

			path.arc(
				position.x,
				position.y,
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
				@size.width
				@size.height
			)

		clearTail: (params) ->
			destinationPosition = @model.calculateGridToPixels
				x: params.x
				y: params.y

			@gameContext.clearRect(
				destinationPosition.x
				destinationPosition.y
				@size.width
				@size.height
			)

define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class SnakeModel extends Backbone.Model

		initialize: (params) ->
			@collider = params.collider
			@canTeleport = true
			@set 'bodySize', params.bodySize
			@set 'position', params.position
			@set 'body', []

		grow: ->
			oldBodySize = @get 'bodySize'
			@set 'bodySize', oldBodySize + 1 

		appendBody: (section) ->
			position = @get 'position'

			@get('body').push
				x: position.x
				y: position.y

		logBody: ->
			body = @get 'body'
			results = []
			for i in body
				results.push "#{i.x}x#{i.y}"

			console.log results

		getHeadPosition: ->
			@get 'position'

		getBodyWithoutHead: ->
			_.initial(@get 'body')

		eraseTail: ->
			@get('body').shift()

		isValidDirectionChange: (oldDirection, newDirection) ->
			invalidChanges =
				left: "right"
				up: "down"
				right: "left"
				down: "up"

			return invalidChanges[newDirection] != oldDirection

		changeDirection: (newDirection) ->
			oldDirection = @get 'direction'

			if @isValidDirectionChange oldDirection, newDirection
				@set 'direction', newDirection

		move: ->
			position = @get 'position'
			size = @get 'size'

			switch @get 'direction'
				when 'left' then position.x--
				when 'up' then position.y--
				when 'right' then position.x++
				when 'down' then position.y++

			if @canTeleport && @collider.positionOutOfBounds position
				position = @teleport position

			@set 'position', position

			@appendBody position

		teleport: (position) ->
			if position.x > @collider.bounds.width
				position.x = 0
			
			if position.y > @collider.bounds.height
				position.y = 0

			if position.x < 0
				position.x = @collider.bounds.width
			
			if position.y < 0
				position.y = @collider.bounds.height

			return position

		positionIsInSnakeBody: (position) ->
			return @collider.positionInArray position, @getBodyWithoutHead()

		isAtValidPosition: ->
			snakeHeadPosition = @getHeadPosition()

			if !@canTeleport && @collider.positionOutOfBounds snakeHeadPosition
				return false

			if @positionIsInSnakeBody snakeHeadPosition
				return false

			return true

		die: ->
			console.log "am ded"
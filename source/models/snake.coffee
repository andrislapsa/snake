define (require) ->
	_ = require 'underscore'
	Backbone = require 'backbone'

	class SnakeModel extends Backbone.Model

		initialize: (params) ->
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

			@set 'position', position

			@appendBody position

		die: ->
			console.log "am ded"
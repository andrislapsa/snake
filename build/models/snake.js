var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, SnakeModel, _;
  _ = require('underscore');
  Backbone = require('backbone');
  return SnakeModel = (function(superClass) {
    extend(SnakeModel, superClass);

    function SnakeModel() {
      return SnakeModel.__super__.constructor.apply(this, arguments);
    }

    SnakeModel.prototype.initialize = function(params) {
      this.collider = params.collider;
      this.canTeleport = true;
      this.set('bodySize', params.bodySize);
      this.set('position', params.position);
      return this.set('body', []);
    };

    SnakeModel.prototype.grow = function() {
      var oldBodySize;
      oldBodySize = this.get('bodySize');
      return this.set('bodySize', oldBodySize + 1);
    };

    SnakeModel.prototype.appendBody = function(section) {
      var position;
      position = this.get('position');
      return this.get('body').push({
        x: position.x,
        y: position.y
      });
    };

    SnakeModel.prototype.logBody = function() {
      var body, i, j, len, results;
      body = this.get('body');
      results = [];
      for (j = 0, len = body.length; j < len; j++) {
        i = body[j];
        results.push(i.x + "x" + i.y);
      }
      return console.log(results);
    };

    SnakeModel.prototype.getHeadPosition = function() {
      return this.get('position');
    };

    SnakeModel.prototype.getBodyWithoutHead = function() {
      return _.initial(this.get('body'));
    };

    SnakeModel.prototype.eraseTail = function() {
      return this.get('body').shift();
    };

    SnakeModel.prototype.isValidDirectionChange = function(oldDirection, newDirection) {
      var invalidChanges;
      invalidChanges = {
        left: "right",
        up: "down",
        right: "left",
        down: "up"
      };
      return invalidChanges[newDirection] !== oldDirection;
    };

    SnakeModel.prototype.changeDirection = function(newDirection) {
      var oldDirection;
      oldDirection = this.get('direction');
      if (this.isValidDirectionChange(oldDirection, newDirection)) {
        return this.set('direction', newDirection);
      }
    };

    SnakeModel.prototype.move = function() {
      var position, size;
      position = this.get('position');
      size = this.get('size');
      switch (this.get('direction')) {
        case 'left':
          position.x--;
          break;
        case 'up':
          position.y--;
          break;
        case 'right':
          position.x++;
          break;
        case 'down':
          position.y++;
      }
      if (this.canTeleport && this.collider.positionOutOfBounds(position)) {
        position = this.teleport(position);
      }
      this.set('position', position);
      return this.appendBody(position);
    };

    SnakeModel.prototype.teleport = function(position) {
      if (position.x > this.collider.bounds.width) {
        position.x = 0;
      }
      if (position.y > this.collider.bounds.height) {
        position.y = 0;
      }
      if (position.x < 0) {
        position.x = this.collider.bounds.width;
      }
      if (position.y < 0) {
        position.y = this.collider.bounds.height;
      }
      return position;
    };

    SnakeModel.prototype.positionIsInSnakeBody = function(position) {
      return this.collider.positionInArray(position, this.getBodyWithoutHead());
    };

    SnakeModel.prototype.isAtValidPosition = function() {
      var snakeHeadPosition;
      snakeHeadPosition = this.getHeadPosition();
      if (!this.canTeleport && this.collider.positionOutOfBounds(snakeHeadPosition)) {
        return false;
      }
      if (this.positionIsInSnakeBody(snakeHeadPosition)) {
        return false;
      }
      return true;
    };

    SnakeModel.prototype.die = function() {
      return console.log("am ded");
    };

    return SnakeModel;

  })(Backbone.Model);
});

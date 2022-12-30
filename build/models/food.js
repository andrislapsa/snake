var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, FoodModel;
  Backbone = require('backbone');
  return FoodModel = (function(superClass) {
    extend(FoodModel, superClass);

    function FoodModel() {
      return FoodModel.__super__.constructor.apply(this, arguments);
    }

    FoodModel.prototype.initialize = function(params) {
      this.gridBoundaries = params.gridBoundaries;
      return this.snakeModel = params.snakeModel;
    };

    FoodModel.prototype.getRandomLocation = function() {
      return {
        x: Math.floor(Math.random() * this.gridBoundaries.width),
        y: Math.floor(Math.random() * this.gridBoundaries.height)
      };
    };

    FoodModel.prototype.spawn = function() {
      var randomLocation;
      while (true) {
        randomLocation = this.getRandomLocation();
        if (!this.snakeModel.positionIsInSnakeBody(randomLocation)) {
          break;
        }
      }
      return this.set('position', randomLocation);
    };

    FoodModel.prototype.getPosition = function() {
      return this.get('position');
    };

    return FoodModel;

  })(Backbone.Model);
});

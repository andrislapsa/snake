var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, ColliderModel, _;
  Backbone = require('backbone');
  _ = require('underscore');
  return ColliderModel = (function(superClass) {
    extend(ColliderModel, superClass);

    function ColliderModel() {
      return ColliderModel.__super__.constructor.apply(this, arguments);
    }

    ColliderModel.prototype.initialize = function(params) {
      return this.bounds = params.gridBoundaries;
    };

    ColliderModel.prototype.positionsMatch = function(position1, position2) {
      return position1.x === position2.x && position1.y === position2.y;
    };

    ColliderModel.prototype.positionOutOfBounds = function(position) {
      if (position.x < 0 || position.y < 0) {
        return true;
      }
      if (position.x > this.bounds.width || position.y > this.bounds.height) {
        return true;
      }
    };

    ColliderModel.prototype.positionInArray = function(position, array) {
      var i, item, len;
      for (i = 0, len = array.length; i < len; i++) {
        item = array[i];
        if (this.positionsMatch(position, item)) {
          return true;
        }
      }
      return false;
    };

    return ColliderModel;

  })(Backbone.Model);
});

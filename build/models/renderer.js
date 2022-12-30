var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, RendererModel;
  Backbone = require('backbone');
  return RendererModel = (function(superClass) {
    extend(RendererModel, superClass);

    function RendererModel() {
      return RendererModel.__super__.constructor.apply(this, arguments);
    }

    RendererModel.prototype.initialize = function(params) {
      this.set('position', {
        x: 0,
        y: 0
      });
      return this.set('assets', []);
    };

    RendererModel.prototype.calculateGridSize = function(size) {
      if (this.gridSize) {
        return this.gridSize;
      }
      return this.gridSize = {
        width: size.width / 50,
        height: size.height / 50
      };
    };

    RendererModel.prototype.calculateGridBoundaries = function(size) {
      return {
        width: (size.width / this.gridSize.width) - 1,
        height: (size.height / this.gridSize.height) - 1
      };
    };

    RendererModel.prototype.calculateGridToPixels = function(gridPosition) {
      return {
        x: gridPosition.x * this.gridSize.width,
        y: gridPosition.y * this.gridSize.height
      };
    };

    RendererModel.prototype.allocateAsset = function(name, size) {
      var position, positionForAsset;
      position = this.get('position');
      positionForAsset = {
        x: position.x,
        y: position.y
      };
      position.x += size.width;
      position.y += size.height;
      this.get('assets')[name] = {
        size: size,
        position: positionForAsset
      };
      return positionForAsset;
    };

    RendererModel.prototype.getAsset = function(name) {
      return this.get('assets')[name];
    };

    RendererModel.prototype.calculateHeadDestinationPosition = function(params) {
      var destinationPosition;
      destinationPosition = this.calculateGridToPixels({
        x: params.x,
        y: params.y
      });
      if (params.direction === 'right' && !params.drawingFirstPiece) {
        destinationPosition.x--;
      }
      if (params.direction === 'down' && !params.drawingFirstPiece) {
        destinationPosition.y--;
      }
      return destinationPosition;
    };

    return RendererModel;

  })(Backbone.Model);
});

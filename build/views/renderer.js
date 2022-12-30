var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, RendererModel, RendererView;
  Backbone = require('backbone');
  RendererModel = require('models/renderer');
  return RendererView = (function(superClass) {
    extend(RendererView, superClass);

    function RendererView() {
      return RendererView.__super__.constructor.apply(this, arguments);
    }

    RendererView.prototype.initialize = function(params) {
      this.assetsContext = params.assetsContext;
      this.gameContext = params.gameContext;
      this.model = new RendererModel;
      this.gridSize = this.model.calculateGridSize({
        width: this.gameContext.canvas.width,
        height: this.gameContext.canvas.height
      });
      this.gridBoundaries = this.model.calculateGridBoundaries({
        width: this.gameContext.canvas.width,
        height: this.gameContext.canvas.height
      });
      this.drawHorizontalPieceAsset();
      this.drawVerticalPieceAsset();
      this.drawFoodAsset();
      return this.drawingFirstPiece = true;
    };

    RendererView.prototype.drawHorizontalPieceAsset = function() {
      var position;
      position = this.model.allocateAsset('horizontalPiece', this.gridSize);
      return this.assetsContext.fillRect(position.x, position.y, this.gridSize.width, this.gridSize.height - 1);
    };

    RendererView.prototype.drawVerticalPieceAsset = function() {
      var position;
      position = this.model.allocateAsset('verticalPiece', this.gridSize);
      return this.assetsContext.fillRect(position.x, position.y, this.gridSize.width - 1, this.gridSize.height);
    };

    RendererView.prototype.drawFoodAsset = function() {
      var endAngle, path, position, radius, startAngle;
      position = this.model.allocateAsset('food', this.gridSize);
      path = new Path2D();
      radius = this.gridSize.width / 2;
      startAngle = 0;
      endAngle = Math.PI * 2;
      path.arc(position.x + radius, position.y + radius, radius, startAngle, endAngle);
      this.assetsContext.fillStyle = 'red';
      return this.assetsContext.fill(path);
    };

    RendererView.prototype.drawHead = function(params) {
      var destinationPosition, orientation, pieceData;
      orientation = ['up', 'down'].indexOf(params.direction) > -1 ? 'vertical' : 'horizontal';
      pieceData = this.model.getAsset(orientation + "Piece");
      if (this.drawingFirstPiece) {
        params.drawingFirstPiece = true;
        this.drawingFirstPiece = false;
      }
      destinationPosition = this.model.calculateHeadDestinationPosition(params);
      return this.gameContext.drawImage(this.assetsContext.canvas, pieceData.position.x, pieceData.position.y, pieceData.size.width, pieceData.size.height, destinationPosition.x, destinationPosition.y, this.gridSize.width, this.gridSize.height);
    };

    RendererView.prototype.drawFood = function(params) {
      var asset;
      params = this.model.calculateGridToPixels(params);
      asset = this.model.getAsset("food");
      return this.gameContext.drawImage(this.assetsContext.canvas, asset.position.x, asset.position.y, asset.size.width, asset.size.height, params.x, params.y, this.gridSize.width, this.gridSize.height);
    };

    RendererView.prototype.clearPosition = function(params) {
      var destinationPosition;
      destinationPosition = this.model.calculateGridToPixels({
        x: params.x,
        y: params.y
      });
      return this.gameContext.clearRect(destinationPosition.x, destinationPosition.y, this.gridSize.width, this.gridSize.height);
    };

    return RendererView;

  })(Backbone.View);
});

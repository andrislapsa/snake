var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, FoodView;
  Backbone = require('backbone');
  return FoodView = (function(superClass) {
    extend(FoodView, superClass);

    function FoodView() {
      return FoodView.__super__.constructor.apply(this, arguments);
    }

    FoodView.prototype.initialize = function(params) {
      this.renderer = params.renderer;
      return this.spawn();
    };

    FoodView.prototype.spawn = function() {
      this.model.spawn();
      return this.render();
    };

    FoodView.prototype.erase = function() {
      return this.renderer.clearPosition(this.model.getPosition());
    };

    FoodView.prototype.render = function() {
      return this.renderer.drawFood(this.model.getPosition());
    };

    return FoodView;

  })(Backbone.View);
});

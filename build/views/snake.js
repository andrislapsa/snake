var extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, SnakeView;
  Backbone = require('backbone');
  return SnakeView = (function(superClass) {
    extend(SnakeView, superClass);

    function SnakeView() {
      return SnakeView.__super__.constructor.apply(this, arguments);
    }

    SnakeView.prototype.initialize = function(params) {
      return this.renderer = params.renderer;
    };

    SnakeView.prototype.render = function() {
      var head, tail;
      head = this.model.getHeadPosition();
      if (this.model.get('body').length > this.model.get('bodySize')) {
        tail = this.model.eraseTail();
        this.renderer.clearPosition({
          x: tail.x,
          y: tail.y
        });
      }
      this.model.logBody();
      return this.renderer.drawHead({
        x: head.x,
        y: head.y,
        direction: this.model.get('direction')
      });
    };

    return SnakeView;

  })(Backbone.View);
});

var bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  extend = function(child, parent) { for (var key in parent) { if (hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  hasProp = {}.hasOwnProperty;

define(function(require) {
  var Backbone, ColliderModel, FoodModel, FoodView, GameView, RendererView, SnakeModel, SnakeView;
  Backbone = require('backbone');
  RendererView = require('views/renderer');
  SnakeView = require('views/snake');
  SnakeModel = require('models/snake');
  ColliderModel = require('models/collider');
  FoodView = require('views/food');
  FoodModel = require('models/food');
  return GameView = (function(superClass) {
    extend(GameView, superClass);

    function GameView() {
      this.unpause = bind(this.unpause, this);
      this.pause = bind(this.pause, this);
      this.loop = bind(this.loop, this);
      return GameView.__super__.constructor.apply(this, arguments);
    }

    GameView.prototype.events = {
      'keydown': 'storeDirectionKeyStrokes',
      'blur': 'pause',
      'focus': 'unpause'
    };

    GameView.prototype.initialize = function() {
      var foodModel, rendererView, snakeModel;
      rendererView = new RendererView({
        assetsContext: this.el.document.querySelector('#assets').getContext('2d'),
        gameContext: this.el.document.querySelector('#game').getContext('2d')
      });
      window.rendererView = rendererView;
      this.collider = new ColliderModel({
        gridBoundaries: rendererView.gridBoundaries
      });
      snakeModel = new SnakeModel({
        position: {
          x: 20,
          y: 20
        },
        direction: 'down',
        bodySize: 5,
        collider: this.collider
      });
      this.snake = new SnakeView({
        model: snakeModel,
        renderer: rendererView
      });
      foodModel = new FoodModel({
        gridBoundaries: rendererView.gridBoundaries,
        snakeModel: snakeModel
      });
      this.food = new FoodView({
        model: foodModel,
        renderer: rendererView
      });
      this.speed = 100;
      this.keystrokes = [];
      return this.unpause();
    };

    GameView.prototype.storeDirectionKeyStrokes = function(e) {
      var KEY_BINDINGS;
      KEY_BINDINGS = {
        37: 'left',
        38: 'up',
        39: 'right',
        40: 'down'
      };
      if (!KEY_BINDINGS[e.keyCode]) {
        return;
      }
      this.keystrokes.push(KEY_BINDINGS[e.keyCode]);
      this.keystrokes = this.keystrokes.splice(0, 2);
      return console.log('keystrokes', this.keystrokes);
    };

    GameView.prototype.loop = function() {
      var died, snakeHeadPosition;
      if (!this.loopTimer) {
        this.loopTimer = setInterval(this.loop, this.speed);
      }
      if (this.keystrokes.length) {
        this.snake.model.changeDirection(this.keystrokes.shift());
      }
      this.snake.model.move();
      snakeHeadPosition = this.snake.model.getHeadPosition();
      if (this.collider.positionsMatch(snakeHeadPosition, this.food.model.getPosition())) {
        this.food.erase();
        this.snake.model.grow();
        this.food.spawn();
      }
      died = !this.snake.model.isAtValidPosition();
      if (died) {
        this.snake.model.die();
        return this.pause();
      } else {
        return this.snake.render();
      }
    };

    GameView.prototype.pause = function() {
      clearTimeout(this.loopTimer);
      return this.loopTimer = null;
    };

    GameView.prototype.unpause = function() {
      return this.loop();
    };

    return GameView;

  })(Backbone.View);
});

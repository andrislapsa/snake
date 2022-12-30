requirejs.config({
  baseUrl: 'build',
  paths: {
    underscore: '../vendor/underscore',
    backbone: '../vendor/backbone',
    jquery: '../vendor/jquery'
  }
});

define(function(require) {
  var GameView;
  GameView = require('views/game');
  return window.gameInstance = new GameView({
    el: window
  });
});

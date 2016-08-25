#= require lib/angular.min
#= require lib/jquery
#= require lib/Box2D

#= require space/spaceModule

#***** world elements
#= require space/world/env
#= require space/world/ticker
#= require space/world/box2d_vars
#= require space/world/b2world

#**** level elements

#= require space/levels/ground

app = angular.module('App',['Space'])

app.controller 'game', ($scope, env) ->
  canvas = $('canvas')
  env.init(canvas)
  return

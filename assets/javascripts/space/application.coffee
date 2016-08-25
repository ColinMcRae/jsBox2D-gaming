# require lib/angular.min
#= require space/spaceModule
#= require space/world/env
#= require space/world/ticker

app = angular.module('App',['Space'])

app.controller 'game', ($scope, world, ticker) ->
  console.log 'controller runs'
  world.init()
  return

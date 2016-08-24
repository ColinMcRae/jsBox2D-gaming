# require lib/angular.min
#= require space/spaceModule
#= require space/world/world

app = angular.module('App',['Space'])

app.controller 'game', ($scope, world) ->
  console.log 'controller runs'
  world.init()

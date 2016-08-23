#= require lib/angular.min
#= require space/spaceModule
#= require space/game
'use strict'

app = angular.module('App',['Space'])


app.controller 'game', (init) ->
  init()
  console.log 'controller runs'

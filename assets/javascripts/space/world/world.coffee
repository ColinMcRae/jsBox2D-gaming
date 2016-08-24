angular.module('Space')
  .service 'world', () ->
    console.log 'service loaded'
    this.init = () ->
      console.log 'world inited'
      return

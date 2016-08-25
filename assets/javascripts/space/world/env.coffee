angular.module('Space')
  .service 'world', (ticker) ->
    console.log 'service loaded'
    this.init = () ->
      console.log 'inited'
      ticker.startWorld()
#      window.setInterval(ticker.tick(), 1000 / 60)
#      initDraw();
#      canvas = $('canvas') - move to param

#      createGround(world, canvas.width(), canvas.height()) create level
#      buildLevel() the same
    return
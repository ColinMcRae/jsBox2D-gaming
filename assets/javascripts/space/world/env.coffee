angular.module('Space')
  .service 'env', (ticker, b2world, ground) ->

    this.init = (worldObject, world) ->
      console.log 'start init'
      b2world.setWorld()
      ground.build worldObject, b2world.getWorld()
      ticker.startWorld()
#      initDraw();
#      createGround(world, canvas.width(), canvas.height()) create level
#      buildLevel() the same
      console.log 'init finished'
    return

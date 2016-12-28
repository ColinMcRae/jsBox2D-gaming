angular.module('Space')
  .service 'env', (ticker, b2world, ground) ->

    this.init = (worldObject, world) ->
      console.log 'start init'
      b2world.setWorld()
      b2world.debugDraw('world')
      ground.build(worldObject, b2world.getWorld())
      ticker.startWorld b2world.getWorld()
#      initDraw();
#      createGround(world, canvas.width(), canvas.height()) create level
#      buildLevel() the same
      console.log 'init finished'
    return

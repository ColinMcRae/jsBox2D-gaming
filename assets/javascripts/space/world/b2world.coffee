angular.module('Space')
  .service 'b2world', (B2D) ->
    world = undefined

    this.setWorld = () ->
#TODO      make some config
      gravityX = 0
      gravityY = 10
      doSleep = true

      gravity = new B2D.Vec2(gravityX, gravityY)
      world = world or new B2D.World(gravity, doSleep)

    this.getWorld = () ->
      return world


    return
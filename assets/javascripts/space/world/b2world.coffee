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

    this.debugDraw = (canvas_id) ->
      debugDraw = new B2D.DebugDraw
      debugDraw.SetSprite document.getElementById(canvas_id).getContext('2d')
      debugDraw.SetDrawScale 30.0
      debugDraw.SetFillAlpha 0.5
      debugDraw.SetLineThickness 1.0
      debugDraw.SetFlags B2D.DebugDraw.e_shapeBit | B2D.DebugDraw.e_jointBit
      world.SetDebugDraw debugDraw
      return

    return
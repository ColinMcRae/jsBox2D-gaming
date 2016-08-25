angular.module('Space')
  .service 'ticker', () ->
    l = this
    w_loop = undefined

    this.tick = (world) ->
      console.log 'tick'
      world.Step(1/60, 10, 10)
      world.DrawDebugData()
      world.ClearForces()
#        while(destroyedBodies.length > 0) {
#          world.DestroyBody(destroyedBodies.shift())
#        }

    this.startWorld = (world) ->
      clearInterval w_loop
      w_loop = setInterval(l.tick(world), 1000 / 60)
    return

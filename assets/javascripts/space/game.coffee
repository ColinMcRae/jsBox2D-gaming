#= require lib/easeljs.min

#= require space/reality
#= require space/stage
#= require space/scene

# stats.js - fps graph


class Game

  reality = new Reality()
  stage = new Stage()
  scene = new Scene(stage, reality)
  constructor: ->
    @play      = true
    @showDebug = true
    @fps       = 60
    console.log('game inited')

#    @bindEvents()
#    populate()
    @run()
#	  return


  run: =>


#    init b2d world
#  populate level
#  start ticker

# Set our Frames Per Second to @fps
    createjs.Ticker.setFPS @fps
    # User RequestAnimationFrame
    createjs.Ticker.useRAF = true
    # Fire @update upon each tick event
    createjs.Ticker.on 'tick', @update

  update: (e) =>
    if @play
# Start counting for FPS stats
#      STATS lib. Disabled yet
#      @stats.begin() if config.SHOW_FPS

# Update our stage
      stage.update(e.delta)

      # Our Box2D world should "step" at the
      # same rate as our defined FPS.
      reality.world.Step 1/@fps, 10, 10

      # Show Debug drawings if enabled
      @drawDebug(e) if @showDebug

      # End counting for FPS stats
#      @stats.end() if config.SHOW_FPS
  
  drawDebug: (e) =>
  # Save the current state/objects
    reality.debug.ctx.save()
  
    # Offset the context of the canvas to match
    # the current stage's offset
    reality.debug.ctx.translate(stage.stage.x, stage.stage.y)
  
    # Clear the previously drawn objects off the
    # screen. Note, clears a rectangle of the canvas
    # with a given x, y, width and height
    reality.debug.ctx.clearRect(0, 0, config.WIDTH, config.HEIGHT)
  
    # Get the draw-er instance and set it to Box2D's
    # SetDebugDraw function
    reality.world.SetDebugDraw(reality.drawer)
  
    # Actually draw the items to the Debug convas
    reality.world.DrawDebugData()
  
    # Restore/show the Box2D drawings
    reality.debug.ctx.restore()

new Game
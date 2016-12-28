#= require space/floor
#= require space/entities/ball

class @Scene
  constructor: (stage, reality)->
    @platforms = []
    @reality = reality
    @stage = stage

    @createGround()
    @createObjects()

  createGround: =>
    options =
      id     : 'ground'
      x      : 0
      y      : config.HEIGHT - 10
      width  : config.WIDTH
      height : 10

    @ground = new Floor(@reality, options)
    @stage.add @ground

    options =
      id    : 'r_wall'
      x     : config.WIDTH - 10
      y     : 10
      width : 10
      height : config.HEIGHT

    @wall = new Floor(@reality, options)
    @stage.add @wall

    options =
      id    : 'l_wall'
      x     : 0
      y     : 10
      width : 10
      height : config.HEIGHT

    @wall = new Floor(@reality, options)
    @stage.add @wall

  createObjects: =>
    console.log('fill scene')
#    TODO - doesnt work
    new Ball(Math.random() + 20 + 5)
    i = 0
    while i < 20
      ++i
      new Ball(Math.random() + 20 + 5)

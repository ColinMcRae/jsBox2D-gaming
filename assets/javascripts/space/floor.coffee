#= require lib/Box2D
#some test level

class @Floor
  b2Vec2 = Box2D.Common.Math.b2Vec2
  b2FixtureDef = Box2D.Dynamics.b2FixtureDef
  b2BodyDef = Box2D.Dynamics.b2BodyDef
  b2Body = Box2D.Dynamics.b2Body
  b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape

  constructor: (reality, options) ->
    @options = options
    @reality = reality
    @vertex = []
    console.log(options.id)
    @createVectors()
    @createFixtureDefinition()
    @createBodyDefinition()
    @createBox2DBody()

  createVectors: =>
    # The x,y coordinates of a polygon. Ie:
    # [[0,0], [200, 0], [200, 10], [0, 10]]
    # which would build a rectangle with a
    # width of 200 and a height of 10.
    coords = [[0,0],[@options.width, 0],[@options.width, @options.height],[0, @options.height]]

    # Creates a vector point based on options
    # passed to the constructor and assigns them
    # to a collection of vectors (a vertex)
    for i in [0..coords.length-1]
      vector = new b2Vec2
      vector.Set( (coords[i][0] / config.SCALE), (coords[i][1] / config.SCALE) )
      @vertex.push vector

  createFixtureDefinition: =>
    @fixtureDef = new b2FixtureDef
    @fixtureDef.density = 0
    @fixtureDef.friction = 0.5
    @fixtureDef.restitution = 0
    @fixtureDef.shape = new b2PolygonShape
    @fixtureDef.shape.SetAsArray( @vertex, @vertex.length )

  createBodyDefinition: =>
    @bodyDef = new b2BodyDef
    @bodyDef.type = b2Body.b2_staticBody
    @bodyDef.position.Set(@options.x / config.SCALE, @options.y / config.SCALE)
    @bodyDef.userData = @options.id

  createBox2DBody: =>
    @body = @reality.world.CreateBody( @bodyDef )
    @body.CreateFixture( @fixtureDef )
    @view = new createjs.Shape
    @view.graphics.beginFill('#000').drawRect(@options.x, @options.y, @options.width, @options.height)
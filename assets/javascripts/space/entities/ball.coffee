#= require lib/Box2D
#= require space/config

class @Ball
  b2FixtureDef = Box2D.Dynamics.b2FixtureDef
  b2BodyDef = Box2D.Dynamics.b2BodyDef
  b2Body = Box2D.Dynamics.b2Body

  construct: (radius, stage) ->
    console.log('creating ball')
    circle = new createjs.Shape()
    circle.graphics.beginFill("red").drawCircle(0, 0, 50)
    circle.x = Math.random() * 10
    circle.y = Math.random() * 10
    stage.addChild(circle)

#    @createFixtureDefinition()
#    @createBodyDefinition()
#    @createBox2DBody()
#    @radius = radius

  createFixtureDefinition: =>
    @fixtureDef = new b2FixtureDef
    @fixtureDef.density = 1
    @fixtureDef.friction = 1
    @fixtureDef.restitution = 0.25
    @fixtureDef.shape = new box2d.b2CircleShape( @radius / config.SCALE )
#    @fixtureDef.shape.SetAsArray( @vertex, @vertex.length )

  createBodyDefinition: =>
    @bodyDef = new b2BodyDef
    @bodyDef.type = b2Body.b2_dynamicBody
    @bodyDef.position.Set(@options.x / config.SCALE, @options.y / config.SCALE)
    @bodyDef.isSensor = true
#    @bodyDef.userData = 'ball'

  createBox2DBody: =>
    @body = @reality.world.CreateBody( @bodyDef )
    @body.CreateFixture( @fixtureDef )
    @view = new createjs.Shape
#    @view.graphics.beginFill('#000')
    @view.regX = @radius
    @view.regY = @radius

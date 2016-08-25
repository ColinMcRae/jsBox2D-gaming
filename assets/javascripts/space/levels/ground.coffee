angular.module('Space')
  .service 'ground', (B2D) ->

    this.build = (canvas, world) ->
      console.log 'building wall'
      this.createWall world,
        { width: canvas.width(), height: 1 },
        { x: 0, y: canvas.height() }
      this.createWall world,
        { width: canvas.width(), height: 1 },
        { x: 0, y: 0 }
      this.createWall world,
        { width: 1, height: canvas.height() },
        { x: 0, y: 0}
      this.createWall world,
        { width: 1, height: canvas.height()},
        { x: canvas.width(), y: 0 }

#      Move to factory

    this.createWall = (world, size, coo) ->
      fixDef = new B2D.FixtureDef
      fixDef.density = 0.4
      fixDef.friction = 0.5
      fixDef.restitution = 0.2
      bodyDef = new B2D.BodyDef
      bodyDef.type = B2D.Body.b2_staticBody
      fixDef.shape = new B2D.PolygonShape
      fixDef.shape.SetAsBox size.width, size.height
      bodyDef.position.Set coo.x / 30, coo.y / 30
      world.CreateBody(bodyDef).CreateFixture fixDef
    return
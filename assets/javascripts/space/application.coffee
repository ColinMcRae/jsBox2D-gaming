#= require lib/jquery
#= require lib/Box2D
#= require lib/easeljs.min

world = undefined

init = ->
	# world_consts()
	b2Vec2 = Box2D.Common.Math.b2Vec2
	b2BodyDef = Box2D.Dynamics.b2BodyDef
	b2Body = Box2D.Dynamics.b2Body
	b2FixtureDef = Box2D.Dynamics.b2FixtureDef
	b2Fixture = Box2D.Dynamics.b2Fixture
	b2World = Box2D.Dynamics.b2World
	b2MassData = Box2D.Collision.Shapes.b2MassData
	b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
	b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
	b2DebugDraw = Box2D.Dynamics.b2DebugDraw
	

	world = new b2World(new b2Vec2(0, 10), true)
	stage = new createjs.Stage("canvas")

	# objects
	fixDef = new b2FixtureDef
	fixDef.density = 1.0
	fixDef.friction = 0.5
	fixDef.restitution = 0.2

	bodyDef = new b2BodyDef
	# draw_level()
	#create ground
	bodyDef.type = b2Body.b2_staticBody
	bodyDef.position.x = 9
	bodyDef.position.y = 13
	
	fixDef.shape = new b2PolygonShape
	fixDef.shape.SetAsBox 10, 0.5
	
	world.CreateBody(bodyDef).CreateFixture fixDef
	#create some objects
	bodyDef.type = b2Body.b2_dynamicBody
	
	# fill_level()
	i = 0
	while i < 20
		if Math.random() > 0.5
			fixDef.shape = new b2PolygonShape
			fixDef.shape.SetAsBox Math.random() + 0.1, Math.random() + 0.1
		else
			circle = new createjs.Shape()
			circle.graphics.beginFill("red").drawCircle(0, 0, 50)
			circle.x = Math.random() * 10
			circle.y = Math.random() * 10
			stage.addChild(circle)
		#	fixDef.shape = new b2CircleShape(Math.random() + 0.1)
		#	bodyDef.position.x = Math.random() * 10
		#	bodyDef.position.y = Math.random() * 10
		#	world.CreateBody(bodyDef).CreateFixture fixDef
		++i

	#setup debug draw
	# init_graphics
	debugDraw = new b2DebugDraw
	debugDraw.SetSprite document.getElementById('canvas').getContext('2d')
	debugDraw.SetDrawScale 30.0
	debugDraw.SetFillAlpha 0.3
	debugDraw.SetLineThickness 1.0		
	debugDraw.SetFlags b2DebugDraw.e_shapeBit | b2DebugDraw.e_jointBit
	
	world.SetDebugDraw debugDraw
	window.setInterval update, 1000 / 60
	return

update = ->
	world.Step 1 / 60, 10, 10
	world.DrawDebugData()
	world.ClearForces()
	return

$(document).ready ->
	console.log 'ready!'
	debugger
	init()
	return

	
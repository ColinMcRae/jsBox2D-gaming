angular.module('Space')
  .service 'B2D', ->
#    this.AABB  = Box2D.Collision.b2AABB
    this.World = Box2D.Dynamics.b2World
    this.Vec2 = Box2D.Common.Math.b2Vec2
#    this.DebugDraw = Box2D.Dynamics.b2DebugDraw
    this.Body = Box2D.Dynamics.b2Body
    this.BodyDef = Box2D.Dynamics.b2BodyDef
    this.FixtureDef = Box2D.Dynamics.b2FixtureDef
    this.PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
#    this.CircleShape = Box2D.Collision.Shapes.b2CircleShape
#    this.MouseJointDef = Box2D.Dynamics.Joints.b2MouseJointDef
#    this.ContactListener = Box2D.Dynamics.b2ContactListener
    return
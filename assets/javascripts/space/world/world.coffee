angular.module('Space')
  .service 'world', ->
    this =  new b2World( new b2Vec2(0, 10), true)

#WorldController = ->
#  world.Step 1 / 60, 10, 10
#  world.DrawDebugData()
#  world.ClearForces()
#  while destroyedBodies.length > 0
#    world.DestroyBody destroyedBodies.shift()

#    service?

#CollisionController::PostSolve = (contact, impulse) ->
#  if contact.GetFixtureB().GetBody().GetUserData()
#    BangedBody = contact.GetFixtureB().GetBody()
#    imp = 0
#    for a of impulse.normalImpulses
#      imp = imp + impulse.normalImpulses[a]
#    if imp > BangedBody.GetUserData().minImpulse and startTimer <= 0
#      BangedBody.GetUserData().hp -= imp
#      console.log BangedBody.GetUserData().GetType() + ' got ' + imp + ' hp left ' + BangedBody.GetUserData().hp
#      if BangedBody.GetUserData().hp < 0
#        destroyedBodies.push BangedBody
#        BangedBody.visible = false
#        BangedBody = null
#  contactListener = new GameContactListener
#  world.SetContactListener contactListener
#  return
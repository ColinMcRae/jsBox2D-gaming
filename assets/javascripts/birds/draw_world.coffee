drawWorld = (world, context) ->
  j = world.m_jointList
  while j
    drawJoint j, context
    j = j.m_next
  b = world.m_bodyList
  while b
    s = b.GetShapeList()
    while s != null
      drawShape s, context
      s = s.GetNext()
    b = b.m_next
  return

drawJoint = (joint, context) ->
  b1 = joint.m_body1
  b2 = joint.m_body2
  x1 = b1.m_position
  x2 = b2.m_position
  p1 = joint.GetAnchor1()
  p2 = joint.GetAnchor2()
  context.strokeStyle = '#00eeee'
  context.beginPath()
  switch joint.m_type
    when b2Joint.e_distanceJoint
      context.moveTo p1.x, p1.y
      context.lineTo p2.x, p2.y
    when b2Joint.e_pulleyJoint
# TODO
    else
      if b1 == world.m_groundBody
        context.moveTo p1.x, p1.y
        context.lineTo x2.x, x2.y
      else if b2 == world.m_groundBody
        context.moveTo p1.x, p1.y
        context.lineTo x1.x, x1.y
      else
        context.moveTo x1.x, x1.y
        context.lineTo p1.x, p1.y
        context.lineTo x2.x, x2.y
        context.lineTo p2.x, p2.y
      break
  context.stroke()
  return

drawShape = (shape, context) ->
  `var i`
  `var v`
  context.strokeStyle = '#ffffff'
  context.beginPath()
  switch shape.m_type
    when b2Shape.e_circleShape
      circle = shape
      pos = circle.m_position
      r = circle.m_radius
      segments = 64.0
      theta = 0.0
      dtheta = 2.0 * Math.PI / segments
      # draw circle
      context.moveTo pos.x + r, pos.y
      i = 0
      while i < segments
        d = new b2Vec2(r * Math.cos(theta), r * Math.sin(theta))
        v = b2Math.AddVV(pos, d)
        context.lineTo v.x, v.y
        theta += dtheta
        i++
      context.lineTo pos.x + r, pos.y
      # draw radius
      context.moveTo pos.x, pos.y
      ax = circle.m_R.col1
      pos2 = new b2Vec2(pos.x + r * ax.x, pos.y + r * ax.y)
      context.lineTo pos2.x, pos2.y
    when b2Shape.e_polyShape
      poly = shape
      tV = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[0]))
      context.moveTo tV.x, tV.y
      i = 0
      while i < poly.m_vertexCount
        v = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[i]))
        context.lineTo v.x, v.y
        i++
      context.lineTo tV.x, tV.y
  context.stroke()
  return

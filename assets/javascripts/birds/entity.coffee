Entity = (id, x, y, angle, center, color, strength) ->
  @id = id
  @x = x
  @y = y
  @angle = angle or 0
  @center = center
  @color = color or 'red'
  @isHit = false
  @strength = strength
  @dead = false
  return

CircleEntity = (id, x, y, angle, center, color, strength, radius) ->
  color = color or 'aqua'
  Entity.call this, id, x, y, angle, center, color, strength
  @radius = radius
  return

RectangleEntity = (id, x, y, angle, center, color, strength, halfWidth, halfHeight) ->
  Entity.call this, id, x, y, angle, center, color, strength
  @halfWidth = halfWidth
  @halfHeight = halfHeight
  return

PolygonEntity = (id, x, y, angle, center, color, strength, polys) ->
  Entity.call this, id, x, y, angle, center, color, strength
  @polys = polys
  return

Entity::hit = (impulse, source) ->
  @isHit = true
  if @strength
    @strength -= impulse
    if @strength <= 0
      @dead = true
  #console.log(this.id + ", " + impulse + ", " + source.id + ", " + this.strength);
  return

Entity::getColor = ->
  if @isHit
    'black'
  else
    @color

Entity::update = (state) ->
  @x = state.x
  @y = state.y
  @center = state.c
  @angle = state.a
  return

Entity::draw = (ctx) ->
  ctx.fillStyle = 'black'
  ctx.beginPath()
  ctx.arc @x * SCALE, @y * SCALE, 4, 0, Math.PI * 2, true
  ctx.closePath()
  ctx.fill()
  ctx.fillStyle = 'yellow'
  ctx.beginPath()
  ctx.arc @center.x * SCALE, @center.y * SCALE, 2, 0, Math.PI * 2, true
  ctx.closePath()
  ctx.fill()
  # clear
  @isHit = false
  return

Entity.build = (def) ->
  if def.radius
    new CircleEntity(def.id, def.x, def.y, def.angle, NULL_CENTER, def.color, def.strength, def.radius)
  else if def.polys
    new PolygonEntity(def.id, def.x, def.y, def.angle, NULL_CENTER, def.color, def.strength, def.polys)
  else
    new RectangleEntity(def.id, def.x, def.y, def.angle, NULL_CENTER, def.color, def.strength, def.halfWidth, def.halfHeight)

CircleEntity.prototype = new Entity
CircleEntity::constructor = CircleEntity

CircleEntity::draw = (ctx) ->
  ctx.save()
  ctx.translate @x * SCALE, @y * SCALE
  ctx.rotate @angle
  ctx.translate -@x * SCALE, -@y * SCALE
  ctx.fillStyle = @getColor()
  ctx.strokeStyle = 'black'
  ctx.beginPath()
  ctx.arc @x * SCALE, @y * SCALE, @radius * SCALE, 0, Math.PI * 2, true
  ctx.moveTo @x * SCALE, @y * SCALE
  ctx.lineTo @x * SCALE, (@y + @radius) * SCALE
  ctx.closePath()
  ctx.fill()
  ctx.stroke()
  ctx.restore()
  Entity::draw.call this, ctx
  return

RectangleEntity.prototype = new Entity
RectangleEntity::constructor = RectangleEntity

RectangleEntity::draw = (ctx) ->
  ctx.save()
  ctx.translate @x * SCALE, @y * SCALE
  ctx.rotate @angle
  ctx.translate -@x * SCALE, -@y * SCALE
  ctx.fillStyle = @getColor()
  ctx.fillRect (@x - (@halfWidth)) * SCALE, (@y - (@halfHeight)) * SCALE, @halfWidth * 2 * SCALE, @halfHeight * 2 * SCALE
  ctx.restore()
  Entity::draw.call this, ctx
  return

PolygonEntity.prototype = new Entity
PolygonEntity::constructor = PolygonEntity

PolygonEntity::draw = (ctx) ->
  ctx.save()
  ctx.translate @x * SCALE, @y * SCALE
  ctx.rotate @angle
  ctx.translate -@x * SCALE, -@y * SCALE
  ctx.fillStyle = @getColor()
  i = 0
  while i < @polys.length
    points = @polys[i]
    ctx.beginPath()
    ctx.moveTo (@x + points[0].x) * SCALE, (@y + points[0].y) * SCALE
    j = 1
    while j < points.length
      ctx.lineTo (points[j].x + @x) * SCALE, (points[j].y + @y) * SCALE
      j++
    ctx.lineTo (@x + points[0].x) * SCALE, (@y + points[0].y) * SCALE
    ctx.closePath()
    ctx.fill()
    ctx.stroke()
    i++
  ctx.restore()
  Entity::draw.call this, ctx
  return

#/ Entity.build(pos).ship(type)
# Entity.build({x, y}).pig(size);
# Entity.build({x, y}).plank({w,h});
# Entity.build({x, y}).stone({w,h});
# Entity.build({x, y}).block(side, material); // empty square of some materials
#new BitmapData("ball.png");

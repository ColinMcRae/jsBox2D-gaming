plankWidth = 0.25

@buildSimpleBox = (world, position, plankSize, boxWidth, height = 5) ->
  canvasWidth = canvas.width / 30
  canvasHeight = canvas.height / 30
  createPlank position - plankWidth, canvasHeight - plankSize - height, plankWidth, plankSize
  createPlank position + boxWidth + plankWidth, canvasHeight - plankSize - height, plankWidth, plankSize
  height += plankSize * 2 + 0.02
  transversePosition = position + boxWidth / 2
  createPlank transversePosition, canvasHeight - plankWidth - height, boxWidth, plankWidth
  createPig transversePosition, canvasHeight + plankSize + plankWidth - height, 0.2
  return

@buildSimpleStoneBox = (world, position, plankSize, boxWidth, height = 5) ->
  canvasWidth = canvas.width / 30
  canvasHeight = canvas.height / 30
  createPlank position - plankWidth, canvasHeight - plankSize - height, plankWidth, plankSize
  createPlank position + boxWidth + plankWidth, canvasHeight - plankSize - height, plankWidth, plankSize
  height += plankSize * 2 + 0.02
  transversePosition = position + boxWidth / 2
  createStone transversePosition, canvasHeight - plankWidth - height, boxWidth, plankWidth
  createPig transversePosition, canvasHeight + plankSize + plankWidth - height, 0.2
  return

@buildBoxCascade = (world, position, plankSize, boxWidth, height = 5, levels = 2) ->
  i = 0
  while i < levels
    levelWidth = boxWidth
    levelHeight = height + i * plankSize * 2 + i * plankWidth * 2 + 0.02
    buildSimpleBox world, position, plankSize, levelWidth, levelHeight
    i++
  return

@buildSimplePyramide = (world, position, plankSize, boxWidth, height = 5, levels = 2) ->
  i = 0
  while i < levels
    levelWidth = boxWidth - (boxWidth * i * 0.3)
    levelHeight = height + i * plankSize * 2 + i * plankWidth * 2
    buildSimpleStoneBox world, position + (boxWidth - levelWidth) / 2, plankSize, levelWidth, levelHeight
    i++
  return

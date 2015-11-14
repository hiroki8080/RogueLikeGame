# 必要なAPIを仮実装
getTipWithCoordinates(x, y) ->
  Tip.road

class Key
  @up = 38
  @down = 40
  @left = 38
  @rigth = 39
  @space = 32

class Tip
  @road = 1
  @wall = 2
  @player = 3
  @treasure_chest = 4

class Character
  constructor: (x, y) ->
    @x = x
    @y = y
    window.document.keydown(bindEvents)
  bindEvents: (e) ->
    switch e.keyCode
      when Key.up
        moveUp()
      when Key.down
        moveDown()
      when Key.left
        moveLeft()
      when Key.right
        moveRight()
      when Key.space
        openMenu()
  moveUp: (distance) ->
    toY = @y - distance
    if canToMove(@x, toY)
      @y = toY
  moveDown: (distance) ->
    toY = @y + distance
    if canToMove(@x, toY)
      @y = toY
  moveLeft: (distance) ->
    toX = @x - distance
    if canToMove(toX, @y)
      @x = toX
  moveRight: (distance) ->
    toX = @x + distance
    if canToMove(toX, @y)
      @x = toX
  canToMove: (x, y) ->
    tipNo = getTipWithCoordinates(x, y)
    switch tipNo
      when Tip.road
        return true
      else
        return false
  openMenu: ->
    console.log("openMenu")

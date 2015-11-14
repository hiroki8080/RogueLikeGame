# 必要なAPIを仮実装
getTipWithCoordinates(x, y) ->
  Tip.road
# 宝箱というアイテムを処理するAPI

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
  @treasureChest = 4
  @enemy1 = 5
  @enemy2 = 6
  @enemy3 = 7
  @trap = 8
  @enemies = [@enemy1, @enemy2, @enemy3]

class Character
  constructor: (options) ->
    @x = options.x
    @y = options.y
    @hp = options.hp
    @attack = options.attack
    @deffense = options.deffense
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
  isEvent: (x, y) ->
    tipNo = getTipWithCoordinates(x, y)
    switch tipNo
      when Tip.treasureChest
        searchObject(Tip.treasureChest)
    if (@enemies.indexOf(tipNo) == -1)
      attack()
  attack: () ->
    console.log("player attacks")
  searchObject: (tipNo) ->
    switch tipNo
      when Tip.treasureChest
        console.log("open chest")
  openMenu: ->
    console.log("openMenu")

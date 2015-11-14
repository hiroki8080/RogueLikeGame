# 必要なAPIを仮実装
getTipWithCoordinates = (x, y) ->
  Chip.road
# 宝箱というアイテムを処理するAPI

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
      when Chip.road
        return true
      else
        return false
  isEvent: (x, y) ->
    tipNo = getTipWithCoordinates(x, y)
    switch tipNo
      when Chip.treasureChest
        searchObject(Chip.treasureChest)
    if (@enemies.indexOf(tipNo) == -1)
      attack()
  attack: () ->
    console.log("player attacks")
  searchObject: (tipNo) ->
    switch tipNo
      when Chip.treasureChest
        console.log("open chest")
  openMenu: ->
    console.log("openMenu")

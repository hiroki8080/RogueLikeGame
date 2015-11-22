# 必要なAPIを仮実装
getTipWithCoordinates = (x, y) ->
  Chip.road
# 宝箱というアイテムを処理するAPI

class Character
  constructor: (options) ->
    @x = options.x || 0
    @y = options.y || 0
    @name = options.name || "no name"
    @hp = options.hp || 20
    @attack = options.attack || 3
    @deffense = options.deffense || 1
    window.addEventListener('keydown', @bindEvent, true)
  bindEvent: (e) =>
    switch e.keyCode
      when Key.up
        @moveUp(1)
      when Key.down
        @moveDown(1)
      when Key.left
        @moveLeft(1)
      when Key.right
        @moveRight(1)
      when Key.space
        @openMenu(1)
    @logStatus()
  moveUp: (distance) ->
    toY = @y - distance
    if @canToMove(@x, toY)
      @y = toY
  moveDown: (distance) ->
    toY = @y + distance
    if @canToMove(@x, toY)
      @y = toY
  moveLeft: (distance) ->
    toX = @x - distance
    if @canToMove(toX, @y)
      @x = toX
  moveRight: (distance) ->
    toX = @x + distance
    if @canToMove(toX, @y)
      @x = toX
  # 座標にあるチップが移動可能かを判定
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
  # 自分の周囲8マスの座標を取得
  # 戻り値は下記の配列
  # [
  #  [x, y],   [x, y],    [x, y]
  #  [x, y], 自位置はなし [x, y]
  #  [x, y],   [x, y],    [x, y]
  # ]
  getAroundPoints: ->
    leftX = @x - 1
    centerX = @x
    rightX = @x + 1
    xList = [leftX, centerX, rightX]

    upY = @y - 1
    centerY = @y
    downY = @y + 1
    yList = [upY, centerY, downY]

    columnPoints = []
    for y in yList
      rowPoints = []
      for x in xList
        rowPoints.push({x: x, y: y})
      columnPoints.push(rowPoints)
    columnPoints
  openMenu: ->
    console.log("openMenu")
  logStatus: ->
    console.log "name: #{@name}\nx: #{@x}, y: #{@y}\nhp: #{@hp}"

options = {name: "トルネコ", x: 1, y: 10}
plyer1 = new Character(options)

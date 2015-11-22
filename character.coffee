# 必要なAPIを仮実装
getTipWithCoordinates = (x, y) ->
  Chip.road
# 宝箱というアイテムを処理するAPI

class Character
  constructor: (options) ->
    @point = options.point || new Point(0, 0)
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
    toY = @point.y - distance
    if @canToMove(@point.x, toY)
      @point.y = toY
  moveDown: (distance) ->
    toY = @point.y + distance
    if @canToMove(@point.x, toY)
      @point.y = toY
  moveLeft: (distance) ->
    toX = @point.x - distance
    if @canToMove(toX, @point.x)
      @point.x = toX
  moveRight: (distance) ->
    toX = @point.x + distance
    if @canToMove(toX, @point.x)
      @point.x = toX
  # 座標にあるチップが移動可能かを判定
  canToMove: (point) ->
    tipNo = getTipWithCoordinates(point.x, point.y)
    switch tipNo
      when Chip.road
        return true
      else
        return false
  isEvent: (point) ->
    tipNo = getTipWithCoordinates(point.x, point.y)
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
    leftX = @point.x - 1
    centerX = @point.x
    rightX = @point.x + 1
    xList = [leftX, centerX, rightX]

    upY = @point.y - 1
    centerY = @point.y
    downY = @point.y + 1
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
    console.log "name: #{@name}\nx: #{@point.x}, y: #{@point.y}\nhp: #{@hp}"

options = {name: "トルネコ", point: new Point(1, 10)}
plyer1 = new Character(options)

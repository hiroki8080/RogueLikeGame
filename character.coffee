class Character
  constructor: (options) ->
    @point = options.point || new Point(0, 0)
    @name = options.name || "no name"
    @hp = options.hp || 20
    @attack = options.attack || 3
    @deffense = options.deffense || 1
    @type = options.type || Chip.enemy1
    @dungeon = options.dungeon
    @direction = Direction.DOWN
    window.addEventListener('keydown', @bindEvent, true)
  bindEvent: (e) =>
    @move(e.keyCode)
    switch e.keyCode
      when Key.space
        @openMenu(1)
    @logStatus()
  move: (keyCode) ->
    switch keyCode
      when Key.up
        @moveUp(1)
      when Key.down
        @moveDown(1)
      when Key.left
        @moveLeft(1)
      when Key.right
        @moveRight(1)
  moveUp: (distance) ->
    toPoint = @point.getRelativePoint(0, -distance)
    if @canToMove(toPoint)
      @point = toPoint
    @direction = Direction.UP
    @isEvent(toPoint)
  moveDown: (distance) ->
    toPoint = @point.getRelativePoint(0, +distance)
    if @canToMove(toPoint)
      @point = toPoint
    @direction = Direction.DOWN
    @isEvent(toPoint)
  moveLeft: (distance) ->
    toPoint = @point.getRelativePoint(-distance, 0)
    if @canToMove(toPoint)
      @point = toPoint
    @direction = Direction.LEFT
    @isEvent(toPoint)
  moveRight: (distance) ->
    toPoint = @point.getRelativePoint(+distance, 0)
    if @canToMove(toPoint)
      @point = toPoint
    @direction = Direction.RIGHT
    @isEvent(toPoint)
  moveRandom: =>
    # 0~10の乱数
    directions = [Key.up, Key.down, Key.left, Key.right]
    rand = Math.floor(Math.random() * directions.length)
    @move(directions[rand])
  # 座標にあるチップが移動可能かを判定
  canToMove: (point) ->
    tipNo = @dungeon.getChip(point.x, point.y)
    switch tipNo
      when Chip.road
        return true
      else
        return false
  isPlayer: ->
    if @type == Chip.player
      return true
    else
      return false
  isEnemy: ->
    if Chip.enemies.indexOf(@type) != -1
      return true
    else
      return false
  isEvent: (point) ->
    tipNo = @dungeon.getChip(point.x, point.y)
    console.log tipNo
    switch tipNo
      when Chip.treasureChest
        @searchObject(Chip.treasureChest)
    if (Chip.enemies.indexOf(tipNo) == -1)
      console.log("player attacks")
  searchObject: (tipNo) ->
    switch tipNo
      when Chip.treasureChest
        alert("ワンピースを手に入れた")
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
        rowPoints.push(new Point(x, y))
      columnPoints.push(rowPoints)
    columnPoints
  openMenu: ->
    console.log("openMenu")
  logStatus: ->
    console.log "name: #{@name}\nx: #{@point.x}, y: #{@point.y}\nhp: #{@hp}"

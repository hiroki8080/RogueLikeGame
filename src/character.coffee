class Character
  constructor: (options) ->
    @point = options.point || new Point(0, 0)
    @name = options.name || "no name"
    @hp = options.hp || 20
    @attack = options.attack || 3
    @deffense = options.deffense || 1
    @steps = 0
    @type = options.type || Chip.enemy1
    @dungeon = options.dungeon
    @direction = Direction.DOWN
    @sprite = options.sprite
    @isOpenMenu = false
    @items = ['つるはし', '薬草', '毒消し草']
    @equipment = ""
    @itemIndex = 1
    @itemMaxSize = 5
    window.addEventListener('keydown', @bindEvent, true)
  bindEvent: (e) =>
    if @isOpenMenu == false
      switch e.keyCode
        when Key.up, Key.down, Key.left, Key.right
          @move(e.keyCode)
          @steps++
        when Key.space
          if @isOpenMenu == false
            @isOpenMenu = true
          else
            @isOpenMenu = false
          console.log(@isOpenMenu)
    else
      @itemMove(e.keyCode)
    @logStatus()
  update: ->
    @sprite.sourceOffsetY = @direction
    @sprite.update()
  render: (point) ->
    @sprite.render(point)
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
  itemMove: (keyCode) ->
    switch keyCode
      when Key.up
        if @itemIndex != 1
          @itemIndex = @itemIndex - 1
      when Key.down
        if @itemIndex != 5
          @itemIndex = @itemIndex + 1
      when Key.left
        @isOpenMenu = false
      when Key.right
        @logStatus()
      when Key.space
        @isOpenMenu = false

  logStatus: ->
    console.log "name: #{@name}\nx: #{@point.x}, y: #{@point.y}\nhp: #{@hp} direction: #{@direction}"

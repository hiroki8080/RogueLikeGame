console.log "\('o')/"

class App
  _renderPlayerPoint = new Point(5, 5)

  constructor: ->
    @statusCanvas = document.getElementById 'status'
    @itemCanvas = document.getElementById 'item'
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @statusCtx = @statusCanvas.getContext '2d'
    @itemCtx = @itemCanvas.getContext '2d'
    @dungeon = new Dungeon(64)
    startPosition = @dungeon.searchRoad()
    playerImg = new Image()
    playerImg.src = 'images/hero_splite.png'
    playerSprite = new Sprite(
      ticksPerFrame: 10
      numberOfFrames: 3
      context: @ctx
      canvasWidth: 96
      frameHeight: 32
      image: playerImg
      chipSize: 60
    )
    options = {name: "トルネコ", point: startPosition, dungeon: @dungeon, sprite: playerSprite}
    @player = new Character(options)
    statusCanvasInit @statusCanvas, @statusCtx
    canvasInit @canvas, @ctx

  statusCanvasInit = (canvas, ctx)->
    canvas.width = 660
    canvas.height = 30
    ctx.fillStyle = 'rgb(192, 80, 77)'
    ctx.fillRect(0,0,660,30)
    ctx.fill()

  canvasInit = (canvas, ctx)->
    canvas.width = 660
    canvas.height = 660
    ctx.fillStyle = 'rgb(192, 80, 77)'
    ctx.fillRect(0,0,660,660)
    ctx.fill()

  loop: =>
    requestAnimationFrame @loop
    @printStatus()
    console.log "loop"
    mapData = @dungeon.getAroundPoints(@player.point, 5)
#    mapData = [
#      [2,2,2,2,2,2,2,2,2,2,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,3,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,1,1,1,1,1,1,1,1,1,2],
#      [2,2,2,2,2,2,2,2,2,2,2],
#    ]
    @player.update()
    @printMap mapData

  printMap: (mapData)->
    for row,x in mapData
      for data,y in row
        switch data
          when 1
            @printImg y, x, 'images/wall.png'
          when 2
            @printImg y, x, 'images/floor.png'
          when 3
            @printImg y, x, 'images/hero.png'
          when 4
            @printImg y, x, 'images/treasurebox.png'
          when 5
            @printImg y, x, 'images/enemy1.png'
          when 6
            @printImg y, x, 'images/enemy2.png'
          when 7
            @printImg y, x, 'images/enemy3.png'
          when 8
            @printImg y, x, 'images/trap.png'
          else
            @printImg y, x, 'images/wall.png'
    @player.render(_renderPlayerPoint)

  printImg: (x,y, image)->
    img = new Image()
    img.onload = =>
      @ctx.drawImage(img, x*60, y*60)
    img.src = image

  printStatus: ->
    if @player.isOpenMenu == true
      @statusCtx.clearRect(0, 0, 660, 60)
      @statusCtx.fillStyle = '#D0A869';
      @statusCtx.fillRect(1, 1, 600, 40)
      @statusCtx.strokeText("[" + @player.name + "]", 0, 10)
      @statusCtx.strokeText("HP:" + @player.hp, 0, 20)
      @statusCtx.strokeText("攻:" + @player.attack, 60, 20)
      @statusCtx.strokeText("防:" + @player.deffense, 100, 20)
      @statusCtx.strokeText("X:" + @player.point.x, 150, 20)
      @statusCtx.strokeText("Y:" + @player.point.y, 200, 20)

      @itemCtx.clearRect(0, 0, 100, 300)
      @itemCtx.fillStyle = '#D0A869';
      @itemCtx.fillRect(0, 0, 100, 300)
      @itemCtx.strokeText(">", 0, @player.itemIndex*10)
      for item, index in @player.items
        @itemCtx.strokeText(item, 10, (index+1)*10)

    else
      @statusCtx.clearRect(0, 0, 660, 60)
      @itemCtx.clearRect(0, 0, 100, 300)

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

console.log "\('o')/"

class App

  constructor: ->
    @statusCanvas = document.getElementById 'status'
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @statusCtx = @statusCanvas.getContext '2d'
    @dungeon = new Dungeon(64)
    startPosition = @dungeon.searchRoad()
    options = {name: "トルネコ", point: startPosition}
    @player = new Character(options)
    @playerImg = new Image()
    @playerImg.src = 'images/hero.png'
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
    @printMap mapData

  printMap: (mapData)->
    for row,x in mapData
      for data,y in row
        switch data
          when 1
            @printRoad y, x
          when 2
            @printWall y, x
          when 3
            @printPlayer y, x
          when 4
            @printTreasureBox y, x
          when 5
            @printWall y, x
          when 6
            @printWall y, x
          when 7
            @printWall y, x
          when 8
            @printWall y, x
          else
            @printWall y, x
    @printPlayer 5, 5

  printWall: (x,y)->
    @wallImg = new Image()
    @wallImg.onload = =>
      @ctx.drawImage(@wallImg, x*60, y*60)
    @wallImg.src = 'images/wall.png'

  printRoad: (x,y)->
    @roadImg = new Image()
    @roadImg.onload = =>
      @ctx.drawImage(@roadImg, x*60, y*60)
    @roadImg.src = 'images/floor.png'

  printPlayer: (x,y)->
    @playerImg = new Image()
    @playerImg.onload = =>
      @ctx.drawImage(@playerImg, x*60, y*60)
    @playerImg.src = 'images/hero.png'

  printTreasureBox: (x,y)->
    @treasureBoxImg = new Image()
    @treasureBoxImg.onload = =>
      @ctx.drawImage(@treasureBoxImg, x*60, y*60)
    @treasureBoxImg.src = 'images/treasurebox.png'


  printEnemy: (x,y)->

  printStatus: ->
    @statusCtx.clearRect(0, 0, 660, 60)
    @statusCtx.strokeText("HP:" + @player.hp, 0, 10)
    @statusCtx.strokeText("X:" + @player.point.x, 100, 10)
    @statusCtx.strokeText("Y:" + @player.point.y, 200, 10)

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

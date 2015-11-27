console.log "\('o')/"

class App

  constructor: ->
    @statusCanvas = document.getElementById 'status'
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @statusCtx = @statusCanvas.getContext '2d'
    @dungeon = new Dungeon(64)
    startPosition = @dungeon.searchRoad()
    options = {name: "トルネコ", point: startPosition, dungeon: @dungeon}
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
    @printImg 5, 5, 'images/hero.png'

  printImg: (x,y, image)->
    img = new Image()
    img.onload = =>
      @ctx.drawImage(img, x*60, y*60)
    img.src = image

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

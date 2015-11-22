console.log "\('o')/"

class App

  constructor: ->
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @dungeon = new Dungeon(64)
    @playerImg = new Image()
    @playerImg.src = 'images/hero.png'
    canvasInit @canvas, @ctx

  canvasInit = (canvas, ctx)->
    canvas.width = 660
    canvas.height = 660
    ctx.fillStyle = 'rgb(192, 80, 77)'
    ctx.fillRect(0,0,660,660)
    ctx.fill()

  loop: ->
#    mapData = @dungeon.getMapData()
    mapData = [
      [2,2,2,2,2,2,2,2,2,2,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,3,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,1,1,1,1,1,1,1,1,1,2],
      [2,2,2,2,2,2,2,2,2,2,2],
    ]
    @printMap mapData

  printMap: (mapData)->
    for row,x in mapData
      for data,y in row
        switch data
          when 1
            @printRoad x, y
          when 2
            @printWall x, y
          when 3
            @printPlayer x, y
          when 4
            @printWall x, y
          when 5
            @printWall x, y
          when 6
            @printWall x, y
          when 7
            @printWall x, y
          when 8
            @printWall x, y
          else
            @printWall x, y

  printWall: (x,y)->
    @wallImg = new Image()
    @wallImg.onload = =>
      @ctx.drawImage(@wallImg, x*60, y*60)
    @wallImg.src = 'images/wall.png'

  printRoad: (x,y)->
    @roadImg = new Image();
    @roadImg.onload = =>
      @ctx.drawImage(@roadImg, x*60, y*60)
    @roadImg.src = 'images/floor.png'

  printPlayer: (x,y)->
    @playerImg = new Image();
    @playerImg.onload = =>
      @ctx.drawImage(@playerImg, x*60, y*60)
    @playerImg.src = 'images/hero.png'

  printEnemy = (x,y)->

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

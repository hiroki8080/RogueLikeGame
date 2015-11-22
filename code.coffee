console.log "\('o')/"

class App

  constructor: ->
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @dungeon = new Dungeon(64)
    img = new Image()
    img.onload = ->
      @ctx.drawImage(img, 0, 0)
    @wallImg = new Image()
    @wallImg.onload = ->
      @ctx.drawImage(@wallImg, 60, 60)
    @wallImg.src = 'images/hero.png'
    @roadImg = new Image();
    @roadImg.src = 'images/hero.png'
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
    mapData = @dungeon.getMapData()
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
      @ctx.drawImage(@wallImg, x*60, y*60)

  printRoad: (x,y)->
      @ctx.drawImage(@roadImg, x*60, y*60)

  printPlayer: (x,y)->
      @ctx.drawImage(@playerImg, x*60, y*60)

  printEnemy = (x,y)->

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

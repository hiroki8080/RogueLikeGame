console.log "\('o')/"

class App

  constructor: ->
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @dungeon = new Dungeon(64)
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
    console.log @ctx
    for row,x in mapData
      for data,y in row
        switch data
          when 2
            @printWall x, y, @ctx
          else
            @printWall x, y, @ctx

  printWall: (x,y,ctx)->
    console.log 'print wall'
    ctx.strokeText('2', x*10, y*10)

  printRoad = (x,y,ctx)->


  printPlayer = (x,y,ctx)->


  printEnemy = (x,y,ctx)->

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

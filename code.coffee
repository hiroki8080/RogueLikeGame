console.log "\('o')/"

class App

  constructor: ->
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    @dungeon = new Dungeon()
    canvasInit @canvas, @ctx

  canvasInit = (canvas, ctx)->
    canvas.width = 640
    canvas.height = 640
    ctx.fillStyle = 'rgb(192, 80, 77)'
    ctx.fillRect(0,0,640,640)
    ctx.fill()

  loop: ->
    console.log "loop"
    mapData = @dungeon.getMapData
    console.log mapData
    printMap mapData

  printMap = (mapData)->
    for x in mapData
      for y in x
        console.log 'map' + mapData[x][y]

  printWall: ->

  printRoad: ->

  printPlayer: ->

  printEnemy: ->

init =->
  window.rogue = new App()
  console.log "init"
  window.rogue.loop()

window.addEventListener 'load', init

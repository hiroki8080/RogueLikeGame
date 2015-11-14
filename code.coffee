console.log "\('o')/"

class App

  constructor: ->
    @canvas = document.getElementById 'main'
    @ctx = @canvas.getContext '2d'
    canvasInit @canvas, @ctx

  canvasInit = (canvas, ctx)->
    canvas.width = 500
    canvas.height = 500
    ctx.fillStyle = 'rgb(192, 80, 77)'
    ctx.fillRect(0,0,500,500)
    ctx.fill()

init =->
  window.rogue = new App()
  console.log "init"

window.addEventListener 'load', init

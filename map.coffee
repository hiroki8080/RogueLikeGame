class Dungeon
  constructor: (@size)->
    @init()

  init: ()->
    widthArray = [1..@size].map (i) -> Chip.wall
    @mapData = [1..@size].map (i) -> widthArray

  getChip: (x, y)->
    @dungeonArray[x][y]

  getMapData: ()->
    @mapData
    
dungeon = new Dungeon(64)
console.log(dungeon.getMapData())

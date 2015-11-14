class Dungeon
  constructor: (@size)->
    @init()

  init: ()->
    widthArray = [1..@size].map (i) -> Chip.wall
    @dungeonArray = [1..@size].map (i) -> widthArray

  getChip: (x, y)->
    @dungeonArray[x][y]


console.log(new Dungeon(64).getChip(1, 1))

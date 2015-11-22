class Dungeon
  constructor: (@size)->
    @init()

  init: ()->
    widthArray = [1..@size].map (i) -> Chip.wall
    @mapData = [1..@size].map (i) -> widthArray

  getChip: (x, y)->
    @mapData[x][y]

  getMapData: ()->
    @mapData

  getAroundPoints: (point, scale=1)->
    half = scale
    xBase = point.x - half
    yBase = point.y - half
    doubleScale = 2 * scale

    points = for y in [0...doubleScale]
              for x in [0...doubleScale]
                xx = xBase + x
                yy = yBase + y
                if (yy >= 0 and xx >= 0) and (yy < 64 and xx < 64)
                  @getChip(xBase + x, yBase + y)
                else
                  - 1

dungeon = new Dungeon(64)
console.log(dungeon.getMapData())

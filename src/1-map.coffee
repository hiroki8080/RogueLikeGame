class Dungeon
  constructor: (@size)->
    @init()

  init: ()->
    mapGenerator = new MapGenerator(@size)
    mapGenerator.generateSquareRoad(4)
    mapGenerator.setChip(Chip.treasureChest)
    mapGenerator.setChip(Chip.treasureChest)
    mapGenerator.setChip(Chip.enemy1)
    @mapData = mapGenerator.getMapData()

  getChip: (x, y)->
    @mapData[x][y]

  getMapData: ()->
    @mapData

  getAroundPoints: (point, scale=1)->
    half = scale
    xBase = point.x - half
    yBase = point.y - half
    arraySize = 2 * scale + 1

    points = for y in [0...arraySize]
              for x in [0...arraySize]
                xx = xBase + x
                yy = yBase + y
                if (yy >= 0 and xx >= 0) and (yy < 64 and xx < 64)
                  @getChip(xBase + x, yBase + y)
                else
                  Chip.outside

  searchRoad: ()->
    for y in [0...@size]
      for x in [0...@size]
        if @mapData[x][y] == Chip.road
          return new Point(x, y)
    console.log "NOT FOUND"

class MapGenerator
  constructor: (@size)->
    @mapData = [1..@size].map (i) => [1..@size].map (i) -> Chip.wall
    @squareRoadList = []

  generateSquareRoad: (roadIndex)->
    OUTER_WALL_SIZE = 1
    MIN_ROAD_SIZE = 11
    MAX_ROAD_SIZE = 25
    for x in [1..roadIndex]
      roadSize = Math.floor(Math.random() * (MAX_ROAD_SIZE - MIN_ROAD_SIZE + 1)) + MIN_ROAD_SIZE
      @squareRoadList.push new SquareRoad(roadSize, new Point())
    for squareRoad in @squareRoadList
      randomPoint = new Point()
      randomPoint.x = Math.floor(Math.random() * (@size - squareRoad.maxWidth - 1 - OUTER_WALL_SIZE))
      randomPoint.y = Math.floor(Math.random() * (@size - squareRoad.maxHeight - 1 - OUTER_WALL_SIZE))
      for x in [0...squareRoad.maxWidth]
        for y in [0...squareRoad.maxHeight]
          if squareRoad.getSquareRoadData()[x][y] != Chip.wall
            squareRoad.point.x = x + OUTER_WALL_SIZE + randomPoint.x
            squareRoad.point.y = y + OUTER_WALL_SIZE + randomPoint.y
            for room in squareRoad.roomList
              room.point.x = squareRoad.point.x
              room.point.y = squareRoad.point.y
            @mapData[squareRoad.point.x][squareRoad.point.y] = squareRoad.getSquareRoadData()[x][y]
    
  setTreasureBox: ()->
    allRoomList = @squareRoadList.map (squareRoad) -> squareRoad.roomList
                                 .reduce (a, b) -> a.concat(b)
    console.log(allRoomList)
    RoomUtils.shuffle(allRoomList)
    firstRoom = allRoomList[0]
    console.log(firstRoom)
    roomX = Math.floor(Math.random() * firstRoom.size)
    roomY = Math.floor(Math.random() * firstRoom.size)
    console.log(firstRoom.point)
    firstRoom.setChip(Chip.treasureChest, new Point(roomX, roomY))
    @mapData[firstRoom.point.x - roomX][firstRoom.point.y - roomY] = Chip.treasureChest

  getMapData: ()->
    @mapData.map (array) -> [].concat array

class SquareRoad
  constructor: (@roadSize, @point)->
    # roomList indexs(position) 0:upper left 1:lower left 2:upper right 3:lower right
    @roomList = []
    @generateRoom()
    @maxWidth = @getMaxWidth()
    @maxHeight = @getMaxHeight()
    @squareRoadData = [1..@maxWidth].map (i) => [1..@maxHeight].map (i) -> Chip.wall
    @renderSquareRoad()

  getMaxHeight: ()->
    try
      maxUpperRoomMiddleSize = Math.floor(Math.max(@roomList[0].size, @roomList[2].size) / 2)
      maxLowerRoomMiddleSize = Math.floor(Math.max(@roomList[1].size, @roomList[3].size) / 2)
      maxUpperRoomMiddleSize + maxLowerRoomMiddleSize + @roadSize
    catch error
      print error
      print "does not exist, four rooms"

  getMaxWidth: ()->
    try
      maxLeftRoomMiddleSize = Math.floor(Math.max(@roomList[0].size, @roomList[1].size) / 2)
      maxRightRoomMiddleSize = Math.floor(Math.max(@roomList[2].size, @roomList[3].size) / 2)
      maxLeftRoomMiddleSize + maxRightRoomMiddleSize + @roadSize
    catch error
      print error
      print "does not exist, four rooms"

  generateRoom: ()->
    MAX_ROOM_MULTIPLE_SIZE = 4
    MIN_ROOM_MULTIPLE_SIZE = 1
    for position in [0..3]
      size = (Math.floor(Math.random() * (MAX_ROOM_MULTIPLE_SIZE - MIN_ROOM_MULTIPLE_SIZE + 1)) + MIN_ROOM_MULTIPLE_SIZE) * 2 + 1
      @roomList.push new Room(size, position, new Point())

    # move room to the four corners
    @roomList[1].point.y = @getMaxHeight() - @roomList[1].size
    @roomList[2].point.x = @getMaxWidth() - @roomList[2].size
    @roomList[3].point.x = @getMaxWidth() - @roomList[3].size
    @roomList[3].point.y = @getMaxHeight() - @roomList[3].size

  renderSquareRoad: ()->
    console.log("maxWidth:" + @maxWidth)
    console.log("maxHeight:" + @maxHeight)
    
    # render room
    for room in @roomList
      for x in [0...room.size]
        for y in [0...room.size]
          @squareRoadData[room.point.x + x][room.point.y + y] = room.getRoomData()[x][y]
    
    # render road
    upperRoadPosition = Math.floor(Math.min(@roomList[0].size, @roomList[2].size) / 2)
    minLowerRoom = RoomUtils.min(@roomList[1], @roomList[3])
    minLowerRoomMiddleSize = Math.floor(minLowerRoom.size / 2)
    lowerRoadPosition = minLowerRoomMiddleSize + minLowerRoom.point.y

    leftRoadPosition = Math.floor(Math.min(@roomList[0].size, @roomList[1].size) / 2)
    
    minRightRoom = RoomUtils.min(@roomList[2], @roomList[3])
    minRightRoomMiddleSize = Math.floor(minRightRoom.size / 2)
    rightRoadPosition = minRightRoomMiddleSize + minRightRoom.point.x
    
    @squareRoadData[leftRoadPosition] = @squareRoadData[leftRoadPosition].map (i) -> Chip.road
    @squareRoadData[rightRoadPosition] = @squareRoadData[rightRoadPosition].map (i) -> Chip.road
    
    for x in [0...@maxWidth]
      @squareRoadData[x][upperRoadPosition] = Chip.road
      @squareRoadData[x][lowerRoadPosition] = Chip.road

  getSquareRoadData: ()->
    @squareRoadData.map (array) -> [].concat array


class Room
  constructor: (@size, @position, @point)->
   @roomData = [1..@size].map (i) => [1..@size].map (i) -> Chip.road
    
  getRoomData: ()->
    @roomData.map (array) -> [].concat array

  setChip: (chip, point)->
    try
      @roomData[point.x][point.y] = chip
    catch error
      print "does not set chip to the room at the point"
     

class RoomUtils
  @max: (room1, room2)->
    if room1.size > room2.size
      return room1
    else
      return room2

  @min: (room1, room2)->
    if room1.size > room2.size
      return room2
    else
      return room1

  @shuffle: (roomList)->
    i = roomList.length
    if i is 0 then return false
    while --i
      j = Math.floor Math.random() * (i + 1)
      tmpi = roomList[i]
      tmpj = roomList[j]
      roomList[i] = tmpj
      roomList[j] = tmpi
    return


class Key
  @up = 38
  @down = 40
  @left = 37
  @right = 39
  @space = 32

class Chip
  @outside = -1 // マップの外
  @road = 1
  @wall = 2
  @player = 3
  @treasureChest = 4
  @enemy1 = 5
  @enemy2 = 6
  @enemy3 = 7
  @trap = 8
  @enemies = [@enemy1, @enemy2, @enemy3]

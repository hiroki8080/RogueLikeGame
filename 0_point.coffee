class Point
  constructor: (x, y) ->
    @x = x || 0
    @y = y || 0
  getRelativePoint: (x, y) ->
    new Point(@x + x, @y + y)

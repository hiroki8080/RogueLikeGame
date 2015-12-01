class Sprite
  _frameIndex = 0
  _tickCount = 0
  _ticksPerFrame = null
  _numberOfFrames = null
  constructor: (options) ->
    _ticksPerFrame = options.ticksPerFrame || 0
    _numberOfFrames = options.numberOfFrames || 1
    @context = options.context
    @canvasWidth = options.canvasWidth
    @frameWidth = @canvasWidth / _numberOfFrames
    @frameHeight = options.frameHeight
    @image = options.image
    @sourceOffsetY = options.sourceOffsetY || 0
    @chipSize = options.chipSize || @frameWidth
    @renderWidth = options.renderWidth || @chipSize
    @renderHeight = options.renderHeight || @chipSize
  update: ->
    _tickCount += 1
    if _tickCount > _ticksPerFrame
      _tickCount = 0
      if _frameIndex < _numberOfFrames - 1
        _frameIndex += 1
      else
        _frameIndex = 0
  render: (point) ->
    @context.drawImage(
      @image,
      _frameIndex * @frameWidth,
      @sourceOffsetY * @frameHeight,
      @frameWidth,
      @frameHeight,
      point.x * @chipSize,
      point.y * @chipSize,
      @renderWidth,
      @renderHeight)

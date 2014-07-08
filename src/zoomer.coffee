class Zoomer
  setup: (imageSize, previewSize, exportZoom, options) ->
    widthRatio = previewSize.w / imageSize.w
    heightRatio = previewSize.h / imageSize.h
    if options.fitWidth && !options.fitHeight
      @minZoom = widthRatio
    else if options.fitHeight && !options.fitWidth
      @minZoom = heightRatio
    else if options.fitWidth && options.fitHeight
      @minZoom = if widthRatio < heightRatio then widthRatio else heightRatio
    else
      @minZoom = if widthRatio < heightRatio then heightRatio else widthRatio

    @maxZoom = if @minZoom < 1 / exportZoom then 1 / exportZoom else @minZoom

  getZoom: (sliderPos) ->
    return null unless @minZoom and @maxZoom
    sliderPos * (@maxZoom - @minZoom) + @minZoom

  isZoomable: ->
    return null unless @minZoom and @maxZoom
    @minZoom isnt @maxZoom

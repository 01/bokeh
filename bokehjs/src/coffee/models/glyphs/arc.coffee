_ = require "underscore"

Glyph = require "./glyph"
p = require "../../core/properties"

class ArcView extends Glyph.View

  _index_data: () ->
    @_xy_index()

  _map_data: () ->
    if @model.properties.radius.units == "data"
      @sradius = @sdist(@renderer.xmapper, this.x, @radius)
    else
      @sradius = @radius

  _render: (ctx, indices, {sx, sy, sradius, start_angle, end_angle}) ->
    if @visuals.line.doit
      direction = @model.properties.direction.value()
      for i in indices
        if isNaN(sx[i]+sy[i]+sradius[i]+start_angle[i]+end_angle[i])
          continue

        ctx.beginPath()
        ctx.arc(sx[i], sy[i], sradius[i], start_angle[i], end_angle[i], direction)

        @visuals.line.set_vectorize(ctx, i)
        ctx.stroke()

  draw_legend: (ctx, x0, x1, y0, y1) ->
    @_generic_line_legend(ctx, x0, x1, y0, y1)

class Arc extends Glyph.Model
  default_view: ArcView

  type: 'Arc'

  mixins: ['line']

  props: ->
    return _.extend {}, super(), {
      direction:   [ p.Direction,   'anticlock' ]
      radius:      [ p.DistanceSpec             ]
      start_angle: [ p.AngleSpec                ]
      end_angle:   [ p.AngleSpec                ]
    }

module.exports =
  Model: Arc
  View: ArcView

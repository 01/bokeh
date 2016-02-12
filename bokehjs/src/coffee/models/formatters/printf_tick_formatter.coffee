_ = require "underscore"
SPrintf = require "sprintf"

TickFormatter = require "./tick_formatter"
p = require "../../core/properties"

class PrintfTickFormatter extends TickFormatter.Model
  type: 'PrintfTickFormatter'

  props: () ->
    return _.extend {}, super(), {
      format: [ p.String, '%s' ]
    }

  format: (ticks) ->
    format = @get("format")
    labels = ( SPrintf.sprintf(format, tick) for tick in ticks )
    return labels

module.exports =
  Model: PrintfTickFormatter
class Dashing.Liteprice extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'liteprice', ->
    if @get('value')
      price = parseFloat(@get('value'))

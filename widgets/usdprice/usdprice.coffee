class Dashing.Usdprice extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'usdprice', ->
    if @get('value')
      price = parseFloat(@get('value'))

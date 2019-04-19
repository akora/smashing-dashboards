class Dashing.Eurprice extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'eurprice', ->
    if @get('value')
      price = parseFloat(@get('value'))

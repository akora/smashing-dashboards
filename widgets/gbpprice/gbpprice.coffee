class Dashing.Gbpprice extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'gbpprice', ->
    if @get('value')
      price = parseFloat(@get('value'))

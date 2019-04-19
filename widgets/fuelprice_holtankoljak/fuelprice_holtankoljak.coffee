class Dashing.Fuelprice_holtankoljak extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'fuelprice-holtankoljak', ->
    if @get('value')
      price = parseFloat(@get('value'))

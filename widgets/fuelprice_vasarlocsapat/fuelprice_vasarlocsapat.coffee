class Dashing.Fuelprice_vasarlocsapat extends Dashing.Widget
  @accessor 'value', Dashing.AnimatedValue
  @accessor 'fuelprice-vasarlocsapat', ->
    if @get('value')
      price = parseFloat(@get('value'))

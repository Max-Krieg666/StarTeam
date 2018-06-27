$(document).ready ->
  if $('.js-averages').length > 0
    count = Number($('#js-squad_size')[0].innerHTML)
    full_price = 0.0

    full_tal = summator($('.js-talent'))
    full_age = summator($('.js-age'))
    full_skills = summator($('.js-skills'))

    $('.js-price').each ->
      price = this.innerHTML.substring(1).replace(',', '')
      full_price += parseFloat(price)

    $('#js-average-talent')[0].innerHTML = (full_tal / count).toFixed(2)

    $('#js-average-age')[0].innerHTML = (full_age / count).toFixed(2)

    $('#js-average-skills')[0].innerHTML = (full_skills / count).toFixed(2)

    $('#js-average-price')[0].innerHTML = number_to_currency((full_price / count).toFixed(3))

    $('#js-full-power')[0].innerHTML = full_skills
    $('#js-full-cost')[0].innerHTML = number_to_currency(full_price.toFixed(3))

summator = (object) ->
  count = 0
  object.each ->
    count += Number(this.innerHTML)
  return count

number_to_currency = (number) ->
  Intl.NumberFormat('en', {
    style: 'currency',
    currency: 'USD',
    minimumFractionDigits: 3
  }).format(number)
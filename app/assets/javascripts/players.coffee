buy = ->
# TODO доделать кнопку покупки игрока в команду
  $.ajax
    url: '/player_in_teams'
    type: 'GET'
    success: (data, textStatus, jqXHR) ->
      window.location = '/player_in_teams/'

  console.log $(this)

$(document).on 'click', '#buy_player', buy

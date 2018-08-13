$(document).ready ->
  if $('.line_up_block').length > 0
    team_setter()

team_setter = ->
  team_id = $('.line_up_block')[0].id
  url = '/teams/' + team_id + '/get_players'
  $.ajax url,
    type: 'GET',
    dataType: 'json'
    success: (data) ->
      players = data['players']
module PlayersHelper
  def select_position1(title, selected = nil)
    select_tag(
      title,
      options_for_select(Player::POSITIONS, [selected]),
      class: 'selectpicker', prompt: I18n.t('prompt.choose_position')
    )
  end
end

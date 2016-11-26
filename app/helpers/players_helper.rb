module PlayersHelper
  def select_position1(title, selected = nil)
    select_tag(title, options_for_select(
      [['Выберите позицию', nil]] + Player::POSITIONS, [selected]), class: 'form-control'
    )
  end
end

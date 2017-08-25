module UsersHelper
  def select_country(country, selected = nil)
    select_tag(
      country, options_for_select(
        Country.order('title').load.map { |x| [x.title, x.id] },
        [selected]
      ),
      class: 'selectpicker',
      data: { 'live-search' => true },
      prompt: I18n.t('prompt.choose_country')
    )
  end
end

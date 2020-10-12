module UsersHelper
  def select_country(country, selected = nil)
    select_tag(
      country,
      options_for_select(
        Country.all.map { |c| [c.i18n_title, c.id] }.sort,
        [selected]
      ),
      prompt: I18n.t('prompt.choose_country')
    )
  end
end

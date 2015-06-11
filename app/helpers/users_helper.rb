module UsersHelper
  def select_country(country, selected = nil)
    select_tag(country, options_for_select(
      Country.order('title').load.map{ |x| [x.title, x.id] },
        [selected]))
  end
end

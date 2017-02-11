module SponsorsHelper
  def select_specialization(title, selected = nil)
    select_tag(title, options_for_select(
      I18n.t('specialization').map { |k, v| [v, k] }, [selected]), class: 'form-control'
    )
  end
end

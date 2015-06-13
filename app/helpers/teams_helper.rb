module TeamsHelper
  def select_sponsor(sponsor, selected = nil)
    select_tag(sponsor, options_for_select(
      Sponsor.order('title').all.find_all{|x| x.title if !x.team_id}.map{|x| [x.title, x.id]},
        [selected]))
  end
end

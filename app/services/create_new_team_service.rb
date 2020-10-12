class CreateNewTeamService
  def self.perform(user, team_params)
    team = user.build_team(team_params[:team_attributes])

    team = Generator::RandomTeam.new(team).generate
    Sponsor.create_rand(team.id)
    team.operations.create(
      sum: 250_000.0,
      kind: true,
      title: I18n.t('messages.operation.init')
    )
    team.captain.update(captain: true)
    Faker::UniqueGenerator.clear

    team
  end
end

class CreateNewTeamService
  def self.perform(user, team_params)
    team = user.team.build(team_params)

    # todo add randomization with :formation
    Sponsor.create_rand(@team.id)
    Generator::RandomTeam.new(@team).generate
    @team.operations.create(
      sum: 250_000.0,
      kind: true,
      title: I18n.t('messages.operation.init')
    )
    @team.captain.update(captain: true)

    team
  end
end

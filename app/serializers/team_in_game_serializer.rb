class TeamInGameSerializer < ActiveModel::Serializer
  attributes :id, :title

  has_many :players, serializer: PlayerInGameSerializer
end

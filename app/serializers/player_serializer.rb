class PlayerSerializer < ActiveModel::Serializer
  attributes :id, :name, :position1, :position2, :real_position,
             :efficienty, :talent, :age, :skill_level, :state,
             :injured, :can_play
end

class Game < ActiveRecord::Base
  belongs_to :home, class_name: 'Team'
  belongs_to :guest, class_name: 'Team'
end

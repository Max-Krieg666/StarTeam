module PositionMethods
  extend ActiveSupport::Concern

  def position_defend?(pos)
    DEF_POSITIONS.include?(pos)
  end

  def position_midfield?(pos)
    MID_POSITIONS.include?(pos)
  end

  def position_attack?(pos)
    ATT_POSITIONS.include?(pos)
  end

  POSITION_EFFICIENCY_MODEL = {
    'ld' => {
      'ld' => 1.0,  'cd' => 0.85, 'rd' => 0.75,
      'lm' => 0.65, 'cm' => 0.55, 'rm' => 0.45,
      'lf' => 0.3,  'cf' => 0.2,  'rf' => 0.1
    },
    'cd' => {
      'ld' => 0.85, 'cd' => 1.0 , 'rd' => 0.85,
      'lm' => 0.5,  'cm' => 0.65, 'rm' => 0.5,
      'lf' =>  0.2, 'cf' => 0.3,  'rf' => 0.2
    },
    'rd' => {
      'ld' => 0.75, 'cd' => 0.85, 'rd' => 1.0,
      'lm' => 0.45, 'cm' => 0.55, 'rm' => 0.65,
      'lf' => 0.1,  'cf' => 0.2,  'rf' => 0.3
    },
    'lm' => {
      'ld' => 0.65, 'cd' => 0.55, 'rd' => 0.45,
      'lm' => 1.0,  'cm' => 0.85, 'rm' => 0.75,
      'lf' => 0.65, 'cf' => 0.55, 'rf' => 0.45
    },
    'cm' => {
      'ld' => 0.5,  'cd' => 0.65, 'rd' => 0.5,
      'lm' => 0.85, 'cm' => 1.0,  'rm' => 0.85,
      'lf' => 0.5,  'cf' => 0.65, 'rf' => 0.5
    },
    'rm' => {
      'ld' => 0.45,  'cd' => 0.55, 'rd' => 0.65,
      'lm' => 0.75,  'cm' => 0.85, 'rm' => 1.0,
      'lf' =>  0.45, 'cf' => 0.55, 'rf' => 0.65
    },
    'lf' => {
      'ld' => 0.3,  'cd' => 0.2,  'rd' => 0.1,
      'lm' => 0.65, 'cm' => 0.55, 'rm' => 0.45,
      'lf' => 1.0,  'cf' => 0.85, 'rf' => 0.75
    },
    'cf' => {
      'ld' => 0.2,  'cd' => 0.3,  'rd' => 0.2,
      'lm' => 0.5,  'cm' => 0.65, 'rm' => 0.5,
      'lf' =>  0.85, 'cf' => 1.0, 'rf' => 0.85
    },
    'rf' => {
      'ld' => 0.1,  'cd' => 0.2,  'rd' => 0.3,
      'lm' => 0.45, 'cm' => 0.55, 'rm' => 0.65,
      'lf' => 0.75, 'cf' => 0.85, 'rf' => 1.0
    }
  }.freeze

  AVAILABLE_POSITIONS_FOR_CHOOSING = {
    'ld' => %i[cd],
    'cd' => %i[ld rd],
    'rd' => %i[cd],
    'lm' => %i[cm],
    'cm' => %i[lm rm],
    'rm' => %i[cm],
    'lf' => %i[cf],
    'cf' => %i[lf rf],
    'rf' => %i[cf]
  }.freeze
end
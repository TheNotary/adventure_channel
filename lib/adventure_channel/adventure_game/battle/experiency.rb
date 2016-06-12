def experiency
  ##############
  # Experiency #
  ##############
  attribute :exp, lambda { |x| x.to_i }
  # attribute :attribues_for_level, lambda { |x| x.to_i }


  # exp isn't available in level_calculation...
  define_method(:level) { level_calculation }
  define_method(:attribues_for_level) { attribues_for_level_calculation }

  # sums stats like strength, agility, hp, to see how many attributes have been
  # applied to a unit's bases states.
  def sum_allocated_attributes
  end

  # TODO: finish this when you test leveling up
  def can_apply_earned_attribute?
    # sum_of_stats > attribues_for_level + bonus_attributes
  end
end

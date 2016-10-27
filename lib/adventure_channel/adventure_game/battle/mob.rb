require 'adventure_channel/adventure_game/battle/battleable'

module AdventureChannel
  module AdventureGame

    class Mob < Ohm::Model
      include Battleable

      attribute :code;         index :code
      attribute :loot

      # TODO: rename to :attribute_distribution to determine how to divide total
      # attributes among the mob (which is determined by level, which is
      # determined by exp)
      attribute :base_attributes

      def self.spawn(config)
        mob = self.find(code: config[:code]).first
        mob.set_attributes!(config)
        mob.set_missing_base_attributes!
        mob
      end

      # TODO: base_attributes are read from the beastiary.json file,
      # and so these values need to be set as the mob's actual values and
      # then depending on level set to be approximately what's right
      # DEPENDS ON attribute game mechanics table
      def convert_base_attributes_to_actual
      end

      # after attributes are set... the mob shouldn't be saved into the database, that would cause a mess
      # hmmm... should I be duping
      def set_attributes!(attributes)
        # make sure :hp also sets :max_hp
        attributes.reject! {|k| k == :code}
        attributes = set_max_mp_and_hp_based_on_mp_hp(attributes)

        @attributes.merge!(attributes)
        self
      end

      # TODO: do me next
      # if you spawn a mob and don't explicitly specify, say, strength, this
      # function should set a good default for strength
      def set_missing_base_attributes!

        # looks like I'll need to change Mob.find to Mob.spawn
        self.exp = 20 if self.exp == 0
        c = attribues_for_level
        # FIXME: subract sum of existing attributes from c before the loop...

        [BasicCombatStats, PercentageCombatStats, CompositCombatStats].flatten.each do |s|
          next if attribute_deliberately_set_during_spawn?(s)

          if BasicCombatStats.include?(s)
            self.send("#{s}=".to_sym, 1)
          else
            self.send("#{s}=".to_sym, 1) # convert to a percentage decimal down the road...
          end

          c -= 1
          break if c <= 0
        end


      end

      # make sure we don't override attributes that were determined at spawn
      def attribute_deliberately_set_during_spawn?(s)
        self.send(s.to_sym) && self.send(s.to_sym) > 0
      end


      def set_max_mp_and_hp_based_on_mp_hp(attributes)
        # if :hp is supplied as an attribute, the value of max_hp will be set
        # to this same value
        max_hp_mp_based_on_base = attributes.inject({}) do |aggregate, pair|
          aggregate.merge!({ "max_#{pair[0]}".to_sym => pair[1] })
        end

        attributes = max_hp_mp_based_on_base.merge(attributes)
      end

      def pick_next_action
        abs = JSON.parse(abilities)

        sum_of_odds = abs.inject(:+) { |s, h| h.last["odds"].to_i }

        random_num = rand(1..sum_of_odds)

        sorted_abilities_decending = abs.sort_by { |k,v| v["odds"].to_i }.reverse

        # iterate over the abilities, summing thier odds to c
        # when c >= the number picked, use that value
        c = 0
        sorted_abilities_decending.each do |name, ability_data|
          c += ability_data["odds"].to_i
          return name if c > random_num
        end
      end



    end

  end
end

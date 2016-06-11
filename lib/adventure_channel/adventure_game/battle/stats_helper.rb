module AdventureChannel
  module AdventureGame

    module StatsHelper

      # Defines resistences
      def self.resistence_stat_definitions
        AdventureChannel::AdventureGame::Resistances.each do |r|
          define_method("resist_#{r.to_s}".to_sym) { sum_property_of_items("resist_#{r.to_s}") }
        end
      end

      # This defines teh p_RESISTANCE methods used for exporting stats in a
      # 'pretty' textual manor like print_stats.  e.g. p_cld
      def self.resistances_printer
        Resistances.each do |r|
          define_method("p_#{r.to_s}".to_sym) { '%4s' % self.send("resist_#{r.to_s}".to_sym); }
        end
      end

      def self.effective_combat_stat_definitions
        BasicCombatStats.each do |s|
          define_method("effective_#{s.to_s}".to_sym) { sum_property_of_items("modify-#{s.to_s}") + self.send(s).to_i }
        end
      end

      def p_level
        '%3s' % level
      end

      ################
      # Combat Stats #
      ################

      # weapon damage
      def wpn_dmg
        1
      end

      def p_wpn_dmg
        '%3s' % wpn_dmg
      end


      # [:eva, :pre, :mgk_eva, :mgk_pre]

      # e.g. effective_pre
      def self.percentage_combat_stat_definitions
        AdventureChannel::AdventureGame::Resistances.each do |r|
          define_method("effective_#{r.to_s}".to_sym) { sum_property_of_items("modify-#{r.to_s}") + self.send(r) }
        end
      end

      def self.percentage_combat_stat_printer
        PercentageCombatStats.each do |r|
          define_method("p_#{r.to_s}".to_sym) { '%2s' % self.send("effective_#{r.to_s}".to_sym); }
        end
      end

      # mgk_defense_base  # Done

      # effective_mgk_defense

      # p_effective_mgk_defense


      def self.composit_stat_printer
        #  [:defense_base, :atk_base, :mgk_atk_base, :mgk_defense_base]
        # binding.pry
        CompositCombatStats.each do|r|
          r = r.to_s.sub("_base", "").to_sym
          define_method("p_#{r.to_s}".to_sym) { '%2s' % self.send("effective_#{r.to_s}".to_sym); }
        end

      end


      def p_mgk_atk
        '%2s' % mgk_atk
      end


      # [stat] magic_attack, dmg of spell based attack
      def mgk_atk
        0
      end





      # this should reallly get it's own view... maybe...
      def print_stats
        <<-EOF
Dmg   #{p_wpn_dmg} | Def       #{effective_defense} |  str  #{strength},   sta  #{stamina},   agi  #{agility},   int  #{intelligence},   spi  #{spirit}
MgkAtk #{p_mgk_atk} | MgkDef   #{p_mgk_defense} | Atk#{p_atk} | Precision  #{pre} | Eva  #{eva} | MgkEva  #{mgk_eva}
Lvl   #{p_level} | Nxtlvl  200 | Exp #{'%7s' % exp} | Resistances:#{p_white}wht,#{p_dark}drk,#{p_cold}cld,#{p_fire}fire,#{p_thunder}thnd,#{p_poison}psn
        EOF
      end

    end

  end
end

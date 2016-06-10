module AdventureChannel
  module AdventureGame

    module StatsPrinter

      # Defines resistences
      def self.resistence_definitions
        AdventureChannel::AdventureGame::Resistances.each do |r|
          define_method("resist_#{r.to_s}".to_sym) { sum_property_of_items("resist_#{r.to_s}") }
        end
      end

      # This defines teh p_RESISTANCE methods used for exporting stats in a
      # 'pretty' textual manor like print_stats
      def self.resistances_printer
        Resistances.each do |r|
          define_method("p_#{r.to_s}".to_sym) { '%4s' % self.send("resist_#{r.to_s}".to_sym); }
        end
      end

      def wpn_dmg_p
        '%3s' % wpn_dmg
      end

      # this should reallly get it's own view... maybe...
      def print_stats
        <<-EOF
Dmg   #{wpn_dmg_p} | Def       #{defense} |  str  #{strength},   sta  #{stamina},   agi  #{agility},   int  #{intelligence},   spi  #{spirit}
MgkAtk #{mgk_atk_p} | MgkDef   #{mgk_def} | Atk #{atk} | Precision #{pre} | Eva #{eva} | MgkEva #{mgk_eva}
Lvl   #{level_p} | Nxtlvl  200 | Exp #{'%7s' % exp} | Resistances:#{p_white}wht,#{p_dark}drk,#{p_cold}cld,#{p_fire}fire,#{p_thunder}thnd,#{p_poison}psn
        EOF
      end

    end

  end
end

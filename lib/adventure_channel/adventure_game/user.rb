require 'adventure_channel/adventure_game/battle/battleable'

module AdventureChannel
  module AdventureGame

    class User < Ohm::Model
      battleable

      def self.spawn_for_new_player(name: nil)
        s = self.create(name: name, max_hp: 10, hp: 10, max_mp: 10, mp: 10,
          stamina: 1, agility: 1, intelligence: 1, spirit: 1, defense_base: 1,
          atk_base: 1, mgk_defense_base: 1, strength: 1, exp: 1)

        s.equipment = Loadout.spawn_for_new_player
        s.save
        s
      end

      def self.find_or_create_user(name)
        u = self.all.find(name: name).first || self.spawn_for_new_player(name: name)
      end

      def furnish_with_default_equipment
        # @equipment = { right_hand: "Jaggedly sharp e-waste specimen" } # {left_hand: 'axe', right_hand: 'axe'}
      end

      # FIXME is it possible to do inventory.to_s instead?
      def export_inventory
        <<-EOF
Backpack Contents:
  > Laptop rolling something linux based
  > Laser
        EOF
      end

      def export_equipment
        <<-EOF
Equipped:
  Weapons:
    [Bear Arms]
    [Empty]
  Shirt:
    [Defcon T-Shirt]
  Pants:
    [No Pants Bro, they'z lost or some shit]
  Shoes:
    [Cool Dance Shoes]
  Hair Style:
    [Dragon Ball Z]

Dmg: 1
Def: 5
        EOF
      end

      def export_status
        <<-EOF
Dmg     1 | Def      5  |  Resistances:   0wh,  20drk, -10cld,   0fr,   0thnd
Lvl     1 | Nxtlvl  200 |  Exp   91231
Status Effects:  [Overly Worried About Entropy] [Lost]
        EOF
      end

    end

  end
end

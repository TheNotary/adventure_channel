module AdventureChannel

  module AdventureGame

    class Mob < Ohm::Model
      battleable

      attribute :loot
      attribute :moves

      # TODO: base_attributes are read from the beastiary.json file,
      # and so these values need to be set as the mob's actual values and
      # then depending on level set to be approximately what's right
      # DEPENDS ON attribute game mechanics table
      def convert_base_attributes_to_actual
      end

      

    end

  end

end

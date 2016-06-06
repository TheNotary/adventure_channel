module AdventureChannel

  module AdventureGame

    class Mob < Ohm::Model
      battleable

      attribute :code;         index :code
      attribute :loot

      # TODO: rename to :attribute_distribution to determine how to divide total
      # attributes among the mob (which is determined by level, which is
      # determined by exp)
      attribute :base_attributes

      def self.spawn(config)
        mob = self.find(code: config[:code]).first
        mob.set_attributes!(config)
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


      def set_max_mp_and_hp_based_on_mp_hp(attributes)
        # if :hp is supplied as an attribute, the value of max_hp will be set
        # to this same value
        max_hp_mp_based_on_base = attributes.inject({}) do |aggregate, pair|
          aggregate.merge!({ "max_#{pair[0]}".to_sym => pair[1] })
        end

        attributes = max_hp_mp_based_on_base.merge(attributes)
      end



    end

  end

end

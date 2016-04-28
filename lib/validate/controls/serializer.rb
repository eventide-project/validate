module Serialize
  module Controls
    class Example
      attr_accessor :some_attribute

      def ==(other)
        other.some_attribute == self.some_attribute
      end

      module Serializer
        def self.some_format
          SomeFormat
        end

        def self.instance(raw_data)
          instance = Example.new
          instance.some_attribute = raw_data
          instance
        end

        def self.raw_data(instance)
          instance.some_attribute
        end

        module SomeFormat
          def self.serialize(raw_data)
            Controls::Text.example
          end

          def self.deserialize(text)
            Controls::RawData.example
          end
        end
      end
    end
  end
end

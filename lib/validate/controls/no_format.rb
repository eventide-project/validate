module Serialize
  module Controls
    module NoFormat
      class Example
        module Serializer
          def self.some_format
          end

          def self.instance(raw_data)
          end

          def self.raw_data(instance)
          end
        end
      end

      def self.example
        Example.new
      end

      def self.example_class
        Example
      end
    end
  end
end

module Serialize
  module Controls
    module NoValidatorMethods
      class Example
        module Validator
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

module Validate
  module Controls
    module NoSpecializationAccessor
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

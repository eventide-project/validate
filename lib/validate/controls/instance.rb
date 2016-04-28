module Serialize
  module Controls
    module Instance
      def self.example
        instance = example_class.new
        instance.some_attribute = Controls::RawData.example
        instance
      end

      def self.example_class
        Controls::Example
      end
    end
  end
end

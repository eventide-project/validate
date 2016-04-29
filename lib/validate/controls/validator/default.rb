module Serialize
  module Controls
    class Example
      module Validator
        def self.(obj)
          :some_default_result
        end

        def self.instance
          Example.new
        end
      end
    end
  end
end

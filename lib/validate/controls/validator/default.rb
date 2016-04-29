module Validate
  module Controls
    module Validator
      module Default
        class Example
          module Validator
            def self.call(obj)
              :some_default_result
            end

            def self.instance
              Example.new
            end
          end
        end
      end
    end
  end
end

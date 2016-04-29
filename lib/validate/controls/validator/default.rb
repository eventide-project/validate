module Validate
  module Controls
    module Validator
      module Default
        def self.example
          Example.new
        end

        class Example
          module Validator
            def self.call(subject)
              :some_default_result
            end
          end
        end
      end
    end
  end
end

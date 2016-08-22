module Validate
  module Controls
    module Validator
      module NotBooleanResult
        def self.example
          Example.new
        end

        class Example
          module Validator
            def self.call(subject)
              :something
            end
          end
        end
      end
    end
  end
end

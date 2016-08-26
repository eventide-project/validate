module Validate
  module Controls
    module Validator
      module State
        def self.example
          Example.new
        end

        class Example
          module Validator
            def self.call(subject, state)
              state << :some_entry
              true
            end
          end
        end
      end
    end
  end
end

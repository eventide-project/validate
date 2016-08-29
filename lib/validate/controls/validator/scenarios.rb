module Validate
  module Controls
    module Validator
      module Scenarios
        def self.example
          Example.new
        end

        class Example
          module Validator
            def self.some_scenario
              SomeScenario
            end

            def self.some_other_scenario
              SomeOtherScenario
            end

            module SomeScenario
              def self.call(subject, state)
                state << :some_scenario
                true
              end
            end

            module SomeOtherScenario
              def self.call(subject, state)
                state << :some_other_scenario
                false
              end
            end
          end
        end
      end
    end
  end
end

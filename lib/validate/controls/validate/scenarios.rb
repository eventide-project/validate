 module Validate
  module Controls
    module Validate
      module Scenarios
        def self.example
          Example.new
        end

        class Example
          module Validate
            def self.some_scenario
              SomeScenario
            end

            def self.some_other_scenario
              SomeOtherScenario
            end

            module SomeScenario
              def self.call(subject, state)
                state << :some_scenario
                false
              end
            end

            module SomeOtherScenario
              def self.call(subject, state)
                state << :some_other_scenario
                true
              end
            end
          end
        end
      end
    end
  end
end

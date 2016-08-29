module Validate
  module Controls
    module Validator
      module Scenario
        def self.example
          Example.new
        end

        class Example
          module Validator
            def self.some_scenario
              SomeScenario
            end

            module SomeScenario
              def self.call(subject)
                true
              end
            end
          end
        end
      end
    end
  end
end

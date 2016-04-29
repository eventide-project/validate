module Validate
  module Controls
    module Validator
      module Specialized
        def self.example
          Example.new
        end

        class Example
          def self.some_specialization
            SomeSpecialization
          end

          def self.instance
            Example.new
          end

          module SomeSpecialization
            def self.call(obj)
              :some_specialized_result
            end
          end
        end
      end
    end
  end
end

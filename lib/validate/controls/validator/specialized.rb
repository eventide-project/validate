module Serialize
  module Controls
    class Example
      module Validator
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

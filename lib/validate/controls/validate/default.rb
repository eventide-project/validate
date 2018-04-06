module Validate
  module Controls
    module Validate
      module Default
        def self.example
          Example.new
        end

        class Example
          module Validate
            def self.call(subject)
              true
            end
          end
        end
      end
    end
  end
end

require_relative 'init'
require 'test_bench'; TestBench.activate

# Validators are in an inner module named "Validate"
# that implements a "call" method that accepts an
# instance of the object being validated

class Example
  attr_accessor :some_attr

  module Validate
    def self.call(example)
      !example.some_attr.nil?
    end
  end
end

e = Example.new # some_attr is nil

valid = Validate.(e)

test "Not valid" do
  refute(valid)
end

e.some_attr = 'something' # some_attr is no longer nil

valid = Validate.(e)

test "Is valid" do
  assert(valid)
end

# Validation rules aren't always the same
# Use specialized validators for particular scenarios
# Provide accessor methods that retrieve the
# scenario validators

class Example2
  attr_accessor :some_attr

  module Validate
    def self.some_particular_scenario
      SomeValidator
    end

    def self.some_other_scenario
      SomeOtherValidator
    end

    module SomeValidator
      def self.call(example)
        example.some_attr == 'something'
      end
    end

    module SomeOtherValidator
      def self.call(example)
        example.some_attr == 'something else'
      end
    end
  end
end

e = Example2.new

e.some_attr = 'some invalid value'

valid = Validate.(e, scenario: :some_particular_scenario)

test "Not valid" do
  refute(valid)
end

e.some_attr = 'something' # some_attr is no longer nil

valid = Validate.(e, scenario: :some_particular_scenario)

test "Is valid" do
  assert(valid)
end

e.some_attr = 'some invalid value'

valid = Validate.(e, scenario: :some_other_scenario)

test "Not valid" do
  refute(valid)
end

e.some_attr = 'something else'

valid = Validate.(e, scenario: :some_other_scenario)

test "Is valid" do
  assert(valid)
end

# Many validators can be called at once by passing
# a list of scenarios rather than a single scenario.
# If any of the validators return false, the list
# of validation is considered false.

class Example3
  attr_accessor :some_attr

  module Validate
    def self.some_particular_scenario
      SomeValidator
    end

    def self.some_other_scenario
      SomeOtherValidator
    end

    module SomeValidator
      def self.call(example)
        example.some_attr.include?('something')
      end
    end

    module SomeOtherValidator
      def self.call(example)
        example.some_attr.include?('else')
      end
    end
  end
end

e = Example3.new
e.some_attr = 'something else' # causes both scenarios to be valid

valid = Validate.(e, scenarios: [:some_particular_scenario, :some_other_scenario])

test "Is valid" do
  assert(valid)
end

e.some_attr = 'something and other thing' # causes only the first scenario to be valid

valid = Validate.(e, scenarios: [:some_particular_scenario, :some_other_scenario])

test "Not valid" do
  refute(valid)
end

e.some_attr = 'else other thing' # causes only the second scenario to be valid

valid = Validate.(e, scenarios: [:some_particular_scenario, :some_other_scenario])

test "Not valid" do
  refute(valid)
end

# Validators can provide contextual information
# such as error messages, warnings, or any other
# arbitrary information as part of the execution
# of a validator.
# Pass an state object that can be used to collect
# info, messages, etc, from the validators.

class Example4
  attr_accessor :some_attr

  module Validate
    def self.call(example, state=[])
      state << 'All is well'
      true
    end

    def self.some_scenario
      SomeScenario
    end

    def self.some_other_scenario
      SomeOtherScenario
    end

    module SomeScenario
      def self.call(example, state=[])
        state << 'Oh oh! SomeScenario went wrong'
        false
      end
    end

    module SomeOtherScenario
      def self.call(example, state=[])
        state << 'Oh oh! SomeOtherScenario went wrong'
        false
      end
    end
  end
end

e = Example4.new

state = []
valid_1 = Validate.(e, state)
valid_2 = Validate.(e, state, scenario: [:some_scenario, :some_other_scenario])

valid = valid_1 && valid_2

test "Not valid" do
  refute(valid)
end

test "Validator state is collected" do
  assert(state == [
    'All is well',
    'Oh oh! SomeScenario went wrong',
    'Oh oh! SomeOtherScenario went wrong'
  ])
end

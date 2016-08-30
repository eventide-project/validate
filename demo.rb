require_relative 'init'
require 'test_bench'; TestBench.activate

# By Default, validators are in an inner module named "Validator"
# that implements a "call" method that accepts an instance of the
# object being validated
class Example
  attr_accessor :some_attr

  module Validator
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

  module Validator
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

  module Validator
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
e.some_attr = 'something else'

valid = Validate.(e, scenarios: [:some_particular_scenario, :some_other_scenario])

test "Is valid" do
  assert(valid)
end

e.some_attr = 'something'

valid = Validate.(e, scenarios: [:some_particular_scenario, :some_other_scenario])

test "Not valid" do
  refute(valid)
end

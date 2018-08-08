# validate

Interface and protocol for validating and validation discovery

## Synopsis

```ruby
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
```

In the example above, the `Validate` module within the `Example` class is discovered, and used as a validation script.

The internal `Validate` module is a [Protocol](https://en.wikipedia.org/wiki/Protocol_(object-oriented_programming)). It requires a defined function of `self.call(instance, optional_state)`


### Validation State

```ruby
class Example
  attr_accessor :some_attr

  module Validate
    def self.call(example, state=[])
      state << 'All is well'
      true
    end
  end
end

e = Example.new

state = []
valid = Validate.(e, state)

test "Not valid" do
  refute(valid)
end

assert(state == ['All is well'])
```

Errors may be collected via the second optional `state` parameter on the `Validate` protocol. In the example above, state is an array, but it could just as easily be a hash, or whatever type of object you want.

## Advanced Usage

### Multiple Validation Scenarios

It can be useful to have specialized validation scenarios, in order to validate an object in different contexts. Scenarios should not be implemented unless there is a need for them, because they are not needed most of the time.

```ruby
class Example
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

e = Example.new

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
```

### Composing Validation Scenarios

Multiple scenarios may be invoked at once, if any in the sequence return false, the entire validation fails.


```ruby
e = Example.new
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
```

### Multiple Scenarios and State

State will also be used to collect contextual information across all invoked scenarios.

```ruby
class Example
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

e = Example.new

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
```

## Comparison with Validation in Rails

What sets this library apart from other similar libraries in Ruby is the lack of a DSL, or a framework for generated error messaging. This is because validation in plain ruby is quite simple and high level already, and generated error messaging tends to result in poor error messages being presented to the user.

Some common examples:

```ruby

# simple

validates :name, presence: true # rails
state << "a name is required" if example.name.nil? # validate

# more complex

validates :size, inclusion: { in: %w(small medium large) } # rails

unless %w(small medium large).include?(example.size) # validate
  state << "size must be either small, medium, or large"
end

# still more complex

validates :quantity, numericality: { is_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 } # rails

quantity = example.quantity # validate
state << "quantity is not a number" unless quantity.to_i.to_s == quantity
state << "quantity cannot be less than 0" unless quantity >= 0
state << "quantity cannot be more than 10" unless quantity <= 10
```

## License

The `validate` library is released under the [MIT License](https://github.com/eventide-project/validate/blob/master/MIT-License.txt).

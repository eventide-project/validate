module Validate
  extend self

  Error = Class.new(RuntimeError)

  def call(subject, state=nil, scenario: nil, scenarios: nil)
    if scenarios.nil?
      scenarios = scenario
    end
    scenario_names = Array(scenarios)

    validator_reflection = validator_reflection(subject)

    if scenario_names.empty?
      validator = validator_reflection.constant
      validate(validator_reflection.constant, subject, state)
    else
      validate_scenarios(validator_reflection, subject, state, scenario_names)
    end
  end

  def validator_reflection(subject)
    subject_constant = Reflect.constant(subject)

    validator_name = validator_name(subject_constant)

    if validator_name.nil?
      raise Error, "#{subject_constant.name} doesn't have a Validate or Validator namespace"
    end

    Reflect.(subject, validator_name, strict: true)
  end

  def validator_name(subject_constant)
    if validate_const?(subject_constant)
      return :Validate
    elsif validator_const?(subject_constant)
      return :Validator
    else
      return nil
    end
  end

  def validate_const?(subject_constant)
    Reflect.constant?(subject_constant, :Validate)
  end

  def validator_const?(subject_constant)
    Reflect.constant?(subject_constant, :Validator)
  end

  def validate_scenarios(validator_reflection, subject, state, scenario_names)
    result = true
    scenario_names.each do |scenario_name|
      scenario_reflection = validator_reflection.get(scenario_name, strict: false)

      if scenario_reflection.nil?
        raise Error, "#{validator_reflection.constant.name} doesn't have a `#{scenario_name}' scenario accessor"
      end

      validator = scenario_reflection.constant

      result = result & validate(validator, subject, state)
    end

    result
  end

  def validate(validator, subject, state)
    method = validator.method(:call)

    result = nil
    case method.parameters.length
    when 1
      if !state.nil?
        raise Error, "State argument was supplied but the validator does not provide a state parameter (Validator: #{validator})"
      end

      result = validator.public_send :call, subject
    when 2
      result = validator.public_send :call, subject, state
    end

    unless result.is_a?(TrueClass) || result.is_a?(FalseClass)
      raise Error, "Result must be boolean. The result is a #{result.class}. (Validator: #{validator})"
    end

    result
  end
end

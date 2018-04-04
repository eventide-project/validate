module Validate
  extend self

  Error = Class.new(RuntimeError)

  def __call(subject, state=nil, scenario: nil, scenarios: nil)
    validator = validator(subject)

    if scenarios.nil?
      scenarios = scenario
    end
    scenarios = Array(scenarios)

    if scenarios.empty?
      validate(validator, subject, state)
    else
      validate_scenarios(validator, subject, state, scenarios)
    end
  end

  def call(subject, state=nil, scenario: nil, scenarios: nil)
    if scenarios.nil?
      scenarios = scenario
    end
    scenarios = Array(scenarios)

    validator_reflection = validator_reflection(subject)

    validator = validator_reflection.constant

    # format_reflection = transformer_reflection.get(format_name)

    # raw_data = raw_data(input, transformer_reflection)

    # output = format_reflection.(:write, raw_data)

    # logger.info { "Wrote (Format Name: #{format_name.inspect})" }
    # logger.debug(tags: [:data, :output]) { output.pretty_inspect }

    # output

    if scenarios.empty?
      validate(validator, subject, state)
    else
      validate_scenarios(validator, subject, state, scenarios)
    end
  end

  def validator_reflection(subject)
    subject_constant = Reflect.subject_constant(subject)

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



  def validate_scenarios(validator, subject, state, scenarios)
    result = true
    scenarios.each do |scenario|
      scenario_validator = scenario(validator, scenario)
      result = result & validate(scenario_validator, subject, state)
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

  def validator(subject)
    subject_const = subject_const(subject)

    assure_validator(subject_const)
    get_validator(subject_const)
  end

  def subject_const(subject)
    [Module, Class].include?(subject.class) ? subject : subject.class
  end

  def assure_validator(subject_const)
    unless validator_const?(subject_const)
      raise Error, "#{subject_const.name} doesn't have a `Validator' namespace"
    end
  end

  def validator_const?(subject_const)
    subject_const.const_defined?(:Validator)
  end

  def get_validator(subject_const)
    subject_const.const_get(:Validator)
  end

  def scenario(validator, scenario)
    assure_scenario(validator, scenario)
    get_scenario(validator, scenario)
  end

  def assure_scenario(validator, scenario)
    unless scenario_method?(validator, scenario)
      raise Error, "#{validator.name} doesn't have a `#{scenario}' scenario method"
    end
  end

  def scenario_method?(validator, scenario)
    validator.respond_to?(scenario)
  end

  def get_scenario(validator, scenario)
    validator.public_send(scenario)
  end
end
